const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(helmet());
app.use(cors());
app.use(express.json());
app.use(morgan('combined'));

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'OK', service: process.env.SERVICE_NAME });
});

// Routes (to be implemented)
app.get('/', (req, res) => {
  res.json({ message: `${process.env.SERVICE_NAME} is running` });
});

// Start server
app.listen(port, () => {
  console.log(`${process.env.SERVICE_NAME} listening on port ${port}`);
});
