import express from "express";

const app = express();

app.get("/health", (_req, res) => {
  res.json({ status: "ok" });
});

app.listen(8000, () => {
  console.log("Server is running on port 8000");
});
