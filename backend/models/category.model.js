const mongoose = require("mongoose");

const category = mongoose.model(
    "categorys",
    mongoose.Schema({
        cateNumber: Number,
        cateName: String
    },
    
    {
        timestapms: true,
    }
    )

);

module.exports={
    category
}
