const express = require('express');
const mysql = require('promise-mysql');
const app = express();
const port = 8080;

const createUnixSocketPool = async () => {
  return mysql.createPool({
    user: "test-user",
    password: "password_1234",
    database: "database",
    host: "127.0.0.1",
  });
};

let pool;

(async () => {
  pool = await createUnixSocketPool();
})();

app.get('/', async (req, res) => {
  try {
    const connection = await pool.getConnection();
    const results = await connection.query('SHOW TABLES');
    connection.release();
    res.send(results);
  } catch (error) {
    res.status(200).send(error.message);
  }
});

app.listen(port, () => {
  console.log(`App running on http://localhost:${port}`);
});
