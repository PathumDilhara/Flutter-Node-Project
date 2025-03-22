const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const cors = require("cors");
const userRoutes = require("./routes/userRoutes"); // Import user routes then we can use anything whatever it returns via module.exports in userRoutes.js.


dotenv.config(); // Load environment variables from .env file, It helps secure sensitive information.

// express() is a function provided by the Express.js framework.
// When called, it creates an Express application.
// This application can handle HTTP requests, define routes, use middleware, and serve responses.
const app = express();

// middlewares
// Middleware functions in Express.js are functions that execute during the request-response cycle. 
// They have access to the request (req), response (res), and the next() function.
app.use(cors()); // Enable CORS (Cross-Origin Resource Sharing) to allow API requests from different origins
app.use(express.json()); // Allow Express to parse JSON request bodies

const PORT = process.env.PORT || 50000; // Set server port from environment or default to 5000

// Configure Routes
// server.js ---> userRoutes.js ---> userController.js
// localhost:5000 ---> /api ---> /users ---> createUser method
// "/api" This is used to apply middleware or routes to the Express app.
// Any request that starts with /api will be handled by userRoutes.
app.use("/api", userRoutes); // localhost:5000/api/users, All user-related routes will be prefixed with `/api` (e.g., `/api/users`)

// Connect to DB
// mongoose.connect(...) → Initiates a connection to MongoDB.
// process.env.MONGODB_URI → Retrieves the MongoDB connection string (URI) from the .env file.
mongoose
  .connect(process.env.MONGODB_URI) // Connect using the URI from the .env file
  .then(() => console.log("MongoDB Connected Successfully"))
  .catch((error) => console.log("MongoDB Connection Erro :", error));

  // Start the server
  // This block of code is responsible for starting the Express server and making it listen for incoming HTTP 
  // requests on the specified port.
  // app.listen(PORT, callback) → Starts the Express server on the specified PORT.
  app.listen(PORT, ()=> { // Log the server startup message
    console.log(`Server is running on port ${PORT}`) //  " ` " allow to embed variables directly into the string using ${}
  });
