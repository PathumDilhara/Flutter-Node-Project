const mongoose = require("mongoose");

// Define a schema for the User collection
const userSchema = new mongoose.Schema(
  {
    name: {
      type: String,
      required: true, // Name is required
      trim: true, // Remove extra spaces
    },

    email: {
      type: String,
      required: true,
      trim: true,
      unique: true, // Prevent duplicate emails
    },

    age: {
      type: Number,
      required: true,
    },
  },
  { timestamps: true } // automatically adds createdAt and updatedAt timestamps
);

// Create a model from the schema
// the first argument ("User") is the model name, which determines the MongoDB collection name.
const User = mongoose.model("User", userSchema);

// Default Export (module.exports = ...) → Only one per file.
module.exports = User; // Exports the User model so it can be used in other files
