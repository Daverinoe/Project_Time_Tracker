extends Panel

var task_name : String

# Labels
@onready var __name_text : RichTextLabel = $"margins/cancel_button/panels/details/name"
@onready var __hours_assigned_text : RichTextLabel = $"margins/cancel_button/panels/details/hours_assigned"
@onready var __hours_left_text : RichTextLabel = $"margins/cancel_button/panels/details/hours_left"

# Buttons
@onready var __start_button : TextureButton = $"margins/cancel_button/panels/start_button"
@onready var __stop_button : TextureButton = $"margins/cancel_button/panels/stop_button"
@onready var __active_button : Button = $"margins/cancel_button/buttons/active_button"
@onready var __inactive_button : Button = $"margins/cancel_button/buttons/inactive_button"
@onready var __delete_button : Button = $"margins/cancel_button/buttons/delete_button"

var __task : Dictionary

var __start_time : Dictionary
var __end_time : Dictionary

var __date : String = Time.get_date_string_from_system()

func _ready() -> void:
	__set_values()
	Event.connect("update_values", __set_values)


func _on_start_button_pressed() -> void:
	__start_time = Time.get_time_dict_from_system()
	if !ProjectManager.data[task_name]["dates_worked"].has(__date):
		ProjectManager.data[task_name]["dates_worked"][__date] = []
	__toggle_buttons(__start_button, __stop_button)


func _on_stop_button_pressed() -> void:
	__end_time = Time.get_time_dict_from_system()
	var time_worked : float = __get_time_worked()
	var time_dict = {"start":__start_time,
					"stop": __end_time,
					"amount": time_worked}
	ProjectManager.data[task_name]["dates_worked"][__date].push_back(time_dict)
	ProjectManager.update_task(task_name, __task.get("hours_worked") + time_worked)
	__toggle_buttons(__start_button, __stop_button)

func __toggle_buttons(button1, button2) -> void:
	button1.visible = !button1.visible
	button2.visible = !button2.visible


func _on_back_button_pressed() -> void:
	self.queue_free()


func _on_inactive_button_pressed() -> void:
	ProjectManager.update_task(task_name, null, true)


func _on_active_button_pressed() -> void:
	ProjectManager.update_task(task_name, null, false)

func __get_time_worked() -> float:
	var hours = __end_time["hour"] - __start_time["hour"]
	var minutes = __end_time["minute"] - __start_time["minute"]
	var seconds = __end_time["second"] - __start_time["second"]
	var hours_worked = hours + (minutes / 60.0) + (seconds / 60.0 / 60.0)
	print("Hours: %s/nMinutes: %s/nSeconds: %s/nTotal: %s" % [hours, minutes, seconds, hours_worked])
	return hours_worked

func __set_values() -> void:
	if !ProjectManager.data.has(task_name):
		self.queue_free()
	else:
		__task = ProjectManager.data.get(task_name)
		__name_text.text = "Task: %s" % task_name
		__hours_assigned_text.text = "Assigned hours: %s" % __task.get("assigned_hours")
		__hours_left_text.text = "Hours left: %s" % (__task.get("assigned_hours") - __task.get("hours_worked"))
		
		__active_button.disabled = true
		__inactive_button.disabled = false
		if __task.completed:
			__active_button.disabled = false
			__inactive_button.disabled = true
	


func _on_delete_button_pressed() -> void:
	ProjectManager.delete_task(task_name)
