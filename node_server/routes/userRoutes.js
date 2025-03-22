const express = require("express");
const router = express.Router(); // Uses Express Router to define the POST /users endpoint
const userController = require("../controllers/userController");  // Import user controller

// Define a POST route to create a new user
// Uses Express Router to define the POST /users endpoint
// Links this endpoint to userController.createUser
router.post("/users", userController.createUser); // Endpoint: http://localhost:5000/api/users 
router.get("/users/:id", userController.getSingleUser);
router.get("/users", userController.getAllUsers);
router.put("/users/update/:id", userController.updateUser);
router.delete("/users/delete/:id", userController.deleteUser);

module.exports = router; // Export the router to use in the server
