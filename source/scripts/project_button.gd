extends RichTextLabel

var task_name : String

func _ready() -> void:
	__set_values()
	Event.connect("update_values", __set_values)


func _on_button_pressed():
	Event.emit_signal("project_button", task_name)


func __set_values() -> void:
	if !ProjectManager.data.has(task_name):
		self.queue_free()
	else:
		var project_data = ProjectManager.data.get(task_name)
		var due_date = project_data.get("due_date")
		var date_string = ("%s/%s/%s" 
						% [due_date.get("day"), due_date.get("month"), due_date.get("year")])
		var hours_left = project_data.get("assigned_hours") - project_data.get("hours_worked")
		self.text = ("%s\nHours left: %s\nDate due: %s" 
						% [task_name, hours_left, date_string])
		
		self.modulate = Color("646464")
		if !project_data.completed:
			self.modulate = Color("ffffff")
			$"project_button".modulate = Color("07ff00")
			if hours_left <= 0:
				self.modulate = Color("ff0700")
			$"project_button".modulate = Color("ffffff")
