const express = require('express');
const sql = require('mssql');
const app = express();
const port = 3000;

const config = {
    user: 'your_username',
    password: 'your_password',
    server: 'localhost', 
    database: 'FinancialManagement',
    options: {
        encrypt: true
    }
};

sql.connect(config, err => {
    if (err) console.error(err);
});

app.get('/api/accounting', (req, res) => {
    new sql.Request().query('SELECT * FROM Accounting', (err, result) => {
        if (err) res.status(500).send(err);
        res.json(result.recordset);
    });
});

app.get('/api/pos', (req, res) => {
    new sql.Request().query('SELECT * FROM POS', (err, result) => {
        if (err) res.status(500).send(err);
        res.json(result.recordset);
    });
});

app.listen(port, () => {
    console.log(`Server running on port ${port}`);
});