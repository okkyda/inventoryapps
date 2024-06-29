const mongoose = require("mongoose");

const product = mongoose.model(
  "products",
  mongoose.Schema(
    {
      productName: String,
      productDescription: String,
      productQty: Number,
      productCateId: Number,
      productUrl: String
    },
    { timestamps: true }
  )
);

module.exports = {
  product,
};