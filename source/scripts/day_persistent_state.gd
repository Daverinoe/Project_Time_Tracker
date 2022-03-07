# Weird psuedo-state machine thing using nodes instead of classes.
extends HBoxContainer

var current_date : Dictionary = Time.get_date_dict_from_system()

var day_scene = preload("res://source/scenes/day.tscn")

var time_scene = preload("res://source/scenes/times.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	Event.connect("set_view_state", __set_view_state)


func __set_view_state(state) -> void:
	var year = current_date.year
	var month = current_date.month
	var day = current_date.day
	var day2 = current_date.weekday
	for child in self.get_children():
		child.queue_free()
	
	var times = time_scene.instantiate()
	self.call_deferred("add_child", times)
	
	match state:
		"day":
			self.call_deferred("add_child", __load_day(year, month, day, day2))
		"week":
			for x in range(7):
				self.call_deferred("add_child", __load_day(year, month, day + x, (day2 + x) % 7 ))

func __load_day(year : int, month : int, day : int, weekday : int) -> Node:
#	ProjectManager.load({"year": year, "month": month, "day": day, "weekday": weekday})
	var new_day = day_scene.instantiate()
	new_day.get_node("day").day = day
	new_day.get_node("day").weekday = weekday
	return new_day


