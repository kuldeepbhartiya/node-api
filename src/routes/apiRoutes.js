const express = require('express');
const router = express.Router();
const { getHealth } = require('../controllers/healthController');
const { sayHello } = require('../controllers/helloController');
const { getPosts } = require('../controllers/publicApiController'); // External api controller

router.get('/health', getHealth);
router.get('/sayHello', sayHello);

router.get('/posts', getPosts); // Route for external API data

module.exports = router;
