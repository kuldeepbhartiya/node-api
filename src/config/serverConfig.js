const dotenv = require('dotenv');

// Load .env variables
dotenv.config();

module.exports = {
  PORT: process.env.PORT || 3000,
  DOMAIN: process.env.DOMAIN || 'localhost',
};
