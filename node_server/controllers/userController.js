const User = require("../models/userModel"); // Import the User model

// Create a new user
exports.createUser = async (req, res) => {
  try {
    const user = new User(req.body); // Create a new User instance with request body data

    // Store the user in the data base
    // below user is a module that exports in userModel with mongodb
    // Mongoose models provide built-in methods to interact with the MongoDB database.
    await user.save();

    res.status(201).json(user); // Returns a 201 response (success)
  } catch (error) {
    res.status(400).json({ error: error.message }); // Returns a 400 response (error)
  }
};

//  Get single user
exports.getSingleUser = async (req, res) => {
  try {
    const userId = req.params.id.trim();
    const user = await User.findById(userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" }); // Returns a 400 response (error)
    } else {
      res.json(user);
    }
  } catch (error) {
    res.status(400).json({ error: error.message }); // Returns a 400 response (error)
  }
};

// Get all users
exports.getAllUsers = async (req, res) => {
  try {
    const allUsers = await User.find();
    res.json(allUsers);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Update a particular user
exports.updateUser = async (req, res) => {
  try {
    const userId = req.params.id.trim();
    const user = await User.findByIdAndUpdate(userId, req.body, {
      new: true,
      runValidators: true,
    });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    } else {
      res.json(user);
    }
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};

// Delete a user
exports.deleteUser = async (req, res) => {
  try {
    const userId = req.params.id.trim();
    const user = await User.findOneAndDelete({ _id: userId });

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    } else {
      res.status(200).json({ message: "User deleted successfully" });
    }
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
};
