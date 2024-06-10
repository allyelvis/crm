CREATE DATABASE IF NOT EXISTS FinancialManagement;

USE FinancialManagement;

-- Products Table
CREATE TABLE IF NOT EXISTS Products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL
);

-- POS Table
CREATE TABLE IF NOT EXISTS POS (
    id INT PRIMARY KEY AUTO_INCREMENT,
    sale_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES Products(id)
);

-- Accounting Table
CREATE TABLE IF NOT EXISTS Accounting (
    id INT PRIMARY KEY AUTO_INCREMENT,
    transaction_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    description VARCHAR(255),
    account_id INT,
    FOREIGN KEY (account_id) REFERENCES Accounts(id)
);

-- Accounts Table
CREATE TABLE IF NOT EXISTS Accounts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL
);
