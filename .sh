#!/bin/bash

# Configuration for CRM database
CRM_DB_HOST="crm_host"
CRM_DB_USER="crm_user"
CRM_DB_PASS="crm_pass"
CRM_DB_NAME="crm_db"

# Configuration for POS database
POS_DB_HOST="pos_host"
POS_DB_USER="pos_user"
POS_DB_PASS="pos_pass"
POS_DB_NAME="pos_db"

# Function to synchronize data from CRM to POS
sync_crm_to_pos() {
  echo "Syncing CRM to POS..."

  # Example query: Sync customer data
  CRM_DATA=$(mysql -h $CRM_DB_HOST -u $CRM_DB_USER -p$CRM_DB_PASS -D $CRM_DB_NAME -e "SELECT * FROM customers WHERE updated_at >= NOW() - INTERVAL 1 MINUTE;")
  if [ $? -eq 0 ]; then
    echo "$CRM_DATA" | while read line; do
      mysql -h $POS_DB_HOST -u $POS_DB_USER -p$POS_DB_PASS -D $POS_DB_NAME -e "INSERT INTO customers (id, name, email, updated_at) VALUES $line ON DUPLICATE KEY UPDATE name=VALUES(name), email=VALUES(email), updated_at=VALUES(updated_at);"
    done
  else
    echo "Error fetching CRM data."
  fi
}

# Function to synchronize data from POS to CRM
sync_pos_to_crm() {
  echo "Syncing POS to CRM..."

  # Example query: Sync sales data
  POS_DATA=$(mysql -h $POS_DB_HOST -u $POS_DB_USER -p$POS_DB_PASS -D $POS_DB_NAME -e "SELECT * FROM sales WHERE updated_at >= NOW() - INTERVAL 1 MINUTE;")
  if [ $? -eq 0 ]; then
    echo "$POS_DATA" | while read line; do
      mysql -h $CRM_DB_HOST -u $CRM_DB_USER -p$CRM_DB_PASS -D $CRM_DB_NAME -e "INSERT INTO sales (id, customer_id, amount, updated_at) VALUES $line ON DUPLICATE KEY UPDATE customer_id=VALUES(customer_id), amount=VALUES(amount), updated_at=VALUES(updated_at);"
    done
  else
    echo "Error fetching POS data."
  fi
}

# Main function to handle synchronization
main() {
  sync_crm_to_pos
  sync_pos_to_crm
}

# Run the main function
main