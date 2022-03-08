extends Control

@onready var view_button : MenuButton = $"app_container/menu_bar/menu_container/view_button"
@onready var view_popup : PopupMenu = view_button.get_popup()
@onready var new_task : Resource = preload("res://source/scenes/new_task.tscn")
@onready var project_panel : Resource = preload("res://source/scenes/project_panel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Event.emit_signal("set_view_state", "day")
	view_popup.connect("index_pressed", __change_view)
	Event.connect("project_button", __open_project_panel)

func __change_view(index : int) -> void:
	var view_choice = view_popup.get_item_text(index)
	match view_choice:
		"Day View":
			Event.emit_signal("set_view_state", "day")
		"Week view":
			Event.emit_signal("set_view_state", "week")


func _on_add_project_pressed():
	var add_task = new_task.instantiate()
	self.call_deferred("add_child", add_task)

func __open_project_panel(task_name : String) -> void:
	var project = project_panel.instantiate()
	project.task_name = task_name
	project.top_level = true
	self.call_deferred("add_child", project)
