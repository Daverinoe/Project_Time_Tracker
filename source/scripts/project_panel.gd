extends Panel

var task_name : String

@onready var __start_button : TextureButton = $"margins/cancel_button/panels/start_button"
@onready var __stop_button : TextureButton = $"margins/cancel_button/panels/stop_button"


func _on_start_button_pressed() -> void:
	__toggle_buttons()


func _on_stop_button_pressed() -> void:
	__toggle_buttons()

func __toggle_buttons() -> void:
	__start_button.visible = !__start_button.visible
	__stop_button.visible = !__stop_button.visible


func _on_back_button_pressed() -> void:
	self.queue_free()
