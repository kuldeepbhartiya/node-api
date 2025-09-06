const { PORT, DOMAIN } = require('../config/serverConfig');

exports.getHealth = (req, res) => {
  res.json({
    status: 'UP',
    port: PORT,
    domain: DOMAIN
  });
};
