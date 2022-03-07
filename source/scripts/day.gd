extends Control

var hour : Resource = preload("res://source/scenes/hour.tscn")

var day : int
var weekday : int
var day_name : String
var name_node : Node
var name_pos : Vector2
var name_size : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():	
	for x in range(24):
		var day_hour = hour.instantiate()
		day_hour.hour = x
		self.call_deferred("add_child", day_hour)


