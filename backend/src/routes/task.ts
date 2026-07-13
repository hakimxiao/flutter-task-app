import { Router } from "express";
import { auth, AuthRequest } from "../middleware/auth";
import { NewTask, tasks } from "../db/schema";
import { db } from "../db";
import { eq } from "drizzle-orm";

const taskRouter = Router();

taskRouter.post("/", auth, async (req: AuthRequest, res) => {
  try {
    req.body = { ...req.body, dueAt: new Date(req.body.dueAt), uid: req.user };
    const newTask: NewTask = req.body;

    const [task] = await db.insert(tasks).values(newTask).returning();

    res.status(201).json(task);
  } catch (error) {
    res.status(500).json({ error: error });
  }
});

taskRouter.post("/sync", auth, async (req: AuthRequest, res) => {
  try {
    const tasksList = req.body;

    const filteredTasks: NewTask[] = [];

    for (let t of tasksList) {
      t = {
        ...t,
        dueAt: new Date(t.dueAt),
        createdAt: new Date(t.createdAt),
        updatedAt: new Date(t.updatedAt),
        uid: req.user,
      };
      filteredTasks.push(t);
    }
    const pushedTasks = await db
      .insert(tasks)
      .values(filteredTasks)
      .returning();

    res.status(201).json(pushedTasks);
  } catch (error) {
    res.status(500).json({ error: error });
  }
});

taskRouter.get("/", auth, async (req: AuthRequest, res) => {
  try {
    const myTasks = await db
      .select()
      .from(tasks)
      .where(eq(tasks.uid, req.user!));

    res.json(myTasks);
  } catch (error) {
    res.status(500).json({ error: error });
  }
});

taskRouter.delete("/", auth, async (req: AuthRequest, res) => {
  try {
    const { taskId }: { taskId: string } = req.body;

    await db.delete(tasks).where(eq(tasks.id, taskId));

    res.json(true);
  } catch (error) {
    res.status(500).json({ error: error });
  }
});

export default taskRouter;
