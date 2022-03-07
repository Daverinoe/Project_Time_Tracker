extends VBoxContainer

@onready var project_scene = preload("res://source/scenes/project.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	__load_task_list()
	Event.connect("task_added", __load_task_list)

func __load_task_list(task_name : String = "") -> void:
	# Check and get rid of any tasks that are already there
	for child in self.get_children():
		child.queue_free()
	
	var data = ProjectManager.data
	for key in data:
		var project_data = data.get(key)
		var due_date = project_data.get("due_date")
		var date_string = ("%s/%s/%s" 
						% [due_date.get("day"), due_date.get("month"), due_date.get("year")])
		var project = project_scene.instantiate()
		project.text = ("%s\nHours left: %s\nDate due: %s" 
						% [key, project_data.get("assigned_hours"), date_string])
		self.call_deferred("add_child", project)
