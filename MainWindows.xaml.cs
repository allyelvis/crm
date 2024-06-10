using System;
using System.Data;
using System.Windows;
using MySql.Data.MySqlClient;

namespace FinancialManagementSystem
{
    public partial class MainWindow : Window
    {
        private string connectionString = "server=localhost;user=root;database=FinancialManagement;port=3306;password=your_password";

        public MainWindow()
        {
            InitializeComponent();
        }

        private void AddProduct_Click(object sender, RoutedEventArgs e)
        {
            string name = ProductName.Text;
            decimal price = decimal.Parse(ProductPrice.Text);
            int stock = int.Parse(ProductStock.Text);

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string sql = "INSERT INTO Products (name, price, stock) VALUES (@name, @price, @stock)";
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@name", name);
                cmd.Parameters.AddWithValue("@price", price);
                cmd.Parameters.AddWithValue("@stock", stock);
                cmd.ExecuteNonQuery();
            }

            MessageBox.Show("Product added successfully");
        }

        private void UpdateProduct_Click(object sender, RoutedEventArgs e)
        {
            int id = int.Parse(UpdateProductId.Text);
            decimal price = decimal.Parse(UpdateProductPrice.Text);
            int stock = int.Parse(UpdateProductStock.Text);

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string sql = "UPDATE Products SET price = @price, stock = @stock WHERE id = @id";
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@id", id);
                cmd.Parameters.AddWithValue("@price", price);
                cmd.Parameters.AddWithValue("@stock", stock);
                cmd.ExecuteNonQuery();
            }

            MessageBox.Show("Product updated successfully");
        }

        private void SubmitTransaction_Click(object sender, RoutedEventArgs e)
        {
            int productId = int.Parse(POSProductId.Text);
            int quantity = int.Parse(POSQuantity.Text);

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                using (MySqlTransaction transaction = conn.BeginTransaction())
                {
                    try
                    {
                        string sqlInsert = "INSERT INTO POS (sale_date, amount, product_id, quantity) " +
                                           "SELECT NOW(), price * @quantity, id, @quantity FROM Products WHERE id = @productId";
                        MySqlCommand cmdInsert = new MySqlCommand(sqlInsert, conn, transaction);
                        cmdInsert.Parameters.AddWithValue("@productId", productId);
                        cmdInsert.Parameters.AddWithValue("@quantity", quantity);
                        cmdInsert.ExecuteNonQuery();

                        string sqlUpdate = "UPDATE Products SET stock = stock - @quantity WHERE id = @productId";
                        MySqlCommand cmdUpdate = new MySqlCommand(sqlUpdate, conn, transaction);
                        cmdUpdate.Parameters.AddWithValue("@productId", productId);
                        cmdUpdate.Parameters.AddWithValue("@quantity", quantity);
                        cmdUpdate.ExecuteNonQuery();

                        transaction.Commit();
                        MessageBox.Show("Transaction completed successfully");
                    }
                    catch (Exception ex)
                    {
                        transaction.Rollback();
                        MessageBox.Show($"Transaction failed: {ex.Message}");
                    }
                }
            }
        }

        private void GenerateReport_Click(object sender, RoutedEventArgs e)
        {
            DateTime startDate = StartDate.SelectedDate.Value;
            DateTime endDate = EndDate.SelectedDate.Value;

            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                conn.Open();
                string sql = "SELECT p.name, SUM(pos.quantity) AS total_quantity, SUM(pos.amount) AS total_amount " +
                             "FROM POS pos JOIN Products p ON pos.product_id = p.id " +
                             "WHERE pos.sale_date BETWEEN @startDate AND @endDate " +
                             "GROUP BY p.name";
                MySqlCommand cmd = new MySqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@startDate", startDate);
                cmd.Parameters.AddWithValue("@endDate", endDate);

                MySqlDataAdapter adapter = new MySqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);
                SalesReportGrid.ItemsSource = dt.DefaultView;
            }
        }
    }
}