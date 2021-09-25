const express = require("express")
const cors = require("cors")
const morgan = require("morgan")
const mongoose = require("mongoose")

const todoSchema = new mongoose.Schema({
	title: String,
	body: String,
	date: String,
})

const ToDo = mongoose.model("ToDo", todoSchema)

const app = express()

mongoose
	.connect("mongodb://localhost:27017")
	.then(() => console.log("Mongo Connected."))

app.use(express.json())
app.use(cors())
app.use(morgan("dev"))

app.post("/", async (req, res) => {
	const { title, body, date } = req.body
	const todo = await ToDo.create({ title, body, date })
	res.json(todo)
})

app.get("/", async (req, res) => {
	const todos = await ToDo.find()
	res.json(todos)
})

app.delete("/:id", async (req, res) => {
	const { id } = req.params

	await ToDo.findByIdAndDelete(id)
	res.status(200)
})

app.patch("/:id", async (req, res) => {
	const { id } = req.params
	const { title, body, date } = req.body

	await ToDo.findByIdAndUpdate(id, { title, body, date })
	res.status(200)
})

app.listen(5000, () => console.log("Listening on 5000"))
