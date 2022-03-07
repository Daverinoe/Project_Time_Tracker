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
					"hours_worked": 0,
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
