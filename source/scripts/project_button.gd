extends RichTextLabel

var task_name : String

func _ready() -> void:
	var data = ProjectManager.data
	var project_data = data.get(task_name)
	var due_date = project_data.get("due_date")
	var date_string = ("%s/%s/%s" 
					% [due_date.get("day"), due_date.get("month"), due_date.get("year")])
	self.text = ("%s\nHours left: %s\nDate due: %s" 
					% [task_name, project_data.get("assigned_hours"), date_string])


func _on_button_pressed():
	Event.emit_signal("project_button", task_name)
