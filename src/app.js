const express = require('express');
const apiRoutes = require('./routes/apiRoutes');
const { PORT } = require('./config/serverConfig');

const app = express();
app.use(express.json());

// Routes
app.use('/api', apiRoutes);

// Listen on all interfaces so container can be accessed from host
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running at http://0.0.0.0:${PORT}`);
});

// Graceful shutdown for Ctrl+C
process.on('SIGINT', () => {
  console.log('Received SIGINT. Shutting down...');
  process.exit();
});
process.on('SIGTERM', () => {
  console.log('Received SIGTERM. Shutting down...');
  process.exit();
});
