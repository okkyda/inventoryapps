const bcrypt = require('bcrypt');
const User = require('../models/user.model');
const auth = require('../middlewares/auth'); // Adjust the path based on your actual file structure

async function login({ username, password }, callback) {
    const user = await User.findOne({ username });

    if (user != null) {
        if (bcrypt.compareSync(password, user.password)) {
            const token = auth.generateAccessToken(username); // Assuming generateAccessToken is defined in auth module
            return callback(null, { ...user.toJSON(), token });
        } else {
            return callback({
                message: "Username atau Password salah!"
            });
        }
    } else {
        return callback({
            message: "Username atau Password Salah!"
        });
    }
}

async function register(params, callback) {
    if (params.username === undefined) {
        return callback({ message: "Username Belum Terisi" });
    }

    const user = new User(params);
    user.save()
        .then((response) => {
            return callback(null, response);
        })
        .catch((error) => {
            return callback(error);
        });
}

module.exports = {
    login,
    register,
};
