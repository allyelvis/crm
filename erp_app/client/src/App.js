import React from 'react';
import './App.css';

function App() {
  const [users, setUsers] = React.useState([]);
  const [products, setProducts] = React.useState([]);

  React.useEffect(() => {
    fetch('http://localhost:5000/users')
      .then(response => response.json())
      .then(data => setUsers(data));

    fetch('http://localhost:5000/products')
      .then(response => response.json())
      .then(data => setProducts(data));
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <h1>ERP System</h1>
        <h2>Users</h2>
        <ul>
          {users.map(user => (
            <li key={user.id}>{user.username} ({user.email})</li>
          ))}
        </ul>
        <h2>Products</h2>
        <ul>
          {products.map(product => (
            <li key={product.id}>{product.name} - ${product.price} - Stock: {product.stock}</li>
          ))}
        </ul>
      </header>
    </div>
  );
}

export default App;
