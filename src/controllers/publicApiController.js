const axios = require('axios');

exports.getPosts = async (req, res) => {
  try {
    const response = await axios.get('https://jsonplaceholder.typicode.com/posts');
    res.json({
      message: 'Fetched posts from JSONPlaceholder',
      data: response.data
    });
  } catch (error) {
    console.error(error.message);
    res.status(500).json({ error: 'Failed to fetch posts' });
  }
};
