const jwt = require('jsonwebtoken');
const { unless } = require('express-unless');

function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization'];
    console.log("Auth Header: ", authHeader); // Tambahkan ini untuk logging
    const token = authHeader && authHeader.split(' ')[1];
    if (token == null) {
        console.log("No token provided"); // Tambahkan ini untuk logging
        return res.sendStatus(401); // Unauthorized jika tidak ada token
    }

    jwt.verify(token, 'kydo_secretKEY', (err, user) => {
        if (err) {
            console.log("Token verification failed: ", err); // Tambahkan ini untuk logging
            return res.sendStatus(403); // Forbidden jika token tidak valid
        }
        req.user = user;
        next(); // Lanjutkan ke middleware atau rute berikutnya
    });
}


// Adding unless to authenticateToken
authenticateToken.unless = unless;

function generateAccessToken(username) {
    return jwt.sign({ data: username }, 'kydo_secretKEY', {
        expiresIn: '1h',
    });
}

module.exports = {
    authenticateToken,
    generateAccessToken,
};
