extends Panel

var task_name : String
var task_hours : float
var due_date : Dictionary
var customer : String
var manager : String
var category : String


func _on_cancel_button_pressed():
	self.queue_free()


func _on_add_button_pressed():
	var date : Array = $"task_margin/new_task_container/task_date_container/text".text.split("/")
	due_date = {"day": date[0], "month": date[1], "year": date[2]}
	task_name = $"task_margin/new_task_container/task_name_container/text".text
	task_hours = $"task_margin/new_task_container/task_hours_container/text".text.to_float()
	customer = $"task_margin/new_task_container/task_customer_container/text".text
	manager = $"task_margin/new_task_container/task_manager_container/text".text
	category = $"task_margin/new_task_container/task_category_container/text".text
	Event.emit_signal("add_task", task_name, task_hours, due_date, customer, manager, category)
	self.queue_free()
