const express = require('express');
const mongoose = require('mongoose');
const dbConfig = require('./config/db.config');
const auth = require('./middlewares/auth');
const errorHandler = require('./middlewares/errors');
const productError = require('./middlewares/products.error');
const cateError = require('./middlewares/category.error')
const { unless } = require('express-unless');

const app = express();

mongoose.Promise = global.Promise;
mongoose.connect(dbConfig.db, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
}).then(
    () => {
        console.log('Database Has Been Connected');
    },
    (error) => {
        console.log('Database Has Not Connected: ' + error);
    }
);

// Ensure that auth.authenticateToken is a middleware function
if (typeof auth.authenticateToken === 'function') {
    // Use unless for the authentication middleware
    auth.authenticateToken.unless = unless;
    
    app.use(
        auth.authenticateToken.unless({
            path: [
                { url: '/users/login', methods: ['POST'] },
                { url: '/users/register', methods: ['POST'] },
            ],
        })
    );
} else {
    console.error('auth.authenticateToken is not a function');
}

app.use(express.json());
app.use('/users', require('./routes/user.routes'));
app.use('/uploads', express.static('uploads'));
app.use('/products', require('./routes/product.routes')); // Pastikan path ini benar
app.use('/categories', require('./routes/category.routes'));

if (typeof errorHandler === 'function') {
    app.use(errorHandler);
} else {
    console.error('errorHandler is not a function');
}

if (typeof productError === 'function') {
    app.use(productError);
} else {
    console.error('productError is not a function');
}

app.listen(process.env.PORT || 3000, function () {
    console.log('Here We Go');
});

module.exports = app;
