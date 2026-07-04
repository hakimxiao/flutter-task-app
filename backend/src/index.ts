import express from "express";
import fs from "fs";
import path from "path";
import type { Router } from "express";

const app = express();

app.use(express.json());

const registerRoutes = () => {
  const routesDir = path.join(__dirname, "routes");

  fs.readdirSync(routesDir)
    .filter((file) => /\.(ts|js)$/.test(file) && !file.endsWith(".d.ts"))
    .forEach((file) => {
      const routeName = path.parse(file).name;
      const routeModule = require(path.join(routesDir, file)) as {
        default?: Router;
      };
      const router = routeModule.default;

      if (!router) {
        console.warn(`Skipping /${routeName}: route file has no default export`);
        return;
      }

      app.use(`/${routeName}`, router);
      console.log(`Registered route /${routeName}`);
    });
};

registerRoutes();

app.get("/health", (_req, res) => {
  res.json({ status: "ok" });
});

app.listen(8000, () => {
  console.log("Server is running on port 8000");
});
