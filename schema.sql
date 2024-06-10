CREATE DATABASE FinancialManagement;

USE FinancialManagement;

-- Accounting Table
CREATE TABLE Accounting (
    id INT PRIMARY KEY IDENTITY(1,1),
    transaction_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    description VARCHAR(255),
    account_id INT,
    FOREIGN KEY (account_id) REFERENCES Accounts(id)
);

-- POS Table
CREATE TABLE POS (
    id INT PRIMARY KEY IDENTITY(1,1),
    sale_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES Products(id)
);

-- Products Table
CREATE TABLE Products (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

-- Accounts Table
CREATE TABLE Accounts (
    id INT PRIMARY KEY IDENTITY(1,1),
    name VARCHAR(255) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL
);