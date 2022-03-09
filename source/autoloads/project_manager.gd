extends Node

var data : Dictionary = {}

@onready var filePath = "user://projectData.txt"
@onready var fileHandle = File.new()
@onready var jsonHandle = JSON.new()

func _ready():
	Event.connect("add_task", add_data)
	load_data()

func add_data(task_name : String, hours : float, due_date : Dictionary = {},
customer : String = "", manager : String = "", category : String = "Training") -> void:
	var new_data = {"assigned_hours": hours,
					"hours_worked": 0.0,
					"due_date": due_date,
					"dates_worked": {},
					"customer": customer,
					"managed_by" : manager,
					"completed": false,
					"category": category}
	data[task_name] = new_data
	save_data()
	Event.emit_signal("task_added", task_name)

func load_data() -> void:
	if !fileHandle.file_exists(filePath):
		save_data()
	
	fileHandle.open(filePath, File.READ)
	jsonHandle.parse(fileHandle.get_line())
	data = jsonHandle.get_data()
	fileHandle.close()

func save_data() -> void:
	fileHandle.open(filePath, File.WRITE)
	fileHandle.store_line(jsonHandle.stringify(data))
	fileHandle.close()

func update_task(task_name : String, hours_worked = null, completed = null, dates_worked = null,
due_date = null, assigned_hours = null, customer = null, manager = null, category = null) -> void:
	if assigned_hours != null:
		data[task_name]["assigned_hours"] = assigned_hours
	if hours_worked != null:
		data[task_name]["hours_worked"] = hours_worked
	if dates_worked != null:
		data[task_name]["dates_worked"] = dates_worked
	if completed != null:
		data[task_name]["completed"] = completed
	if due_date != null:
		data[task_name]["due_date"] = due_date
	if customer != null:
		data[task_name]["customer"] = customer
	if manager != null:
		data[task_name]["manager"] = manager
	if category != null:
		data[task_name]["category"] = category
	save_data()
	Event.emit_signal("update_values")

func delete_task(task_name : String) -> void:
	if data.has(task_name):
		data.erase(task_name)
		Event.emit_signal("update_values")
