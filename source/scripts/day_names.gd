extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	Event.connect("set_view_state", __set_view_state)

func __set_view_state(view : String) -> void:
	for child in self.get_children():
		child.queue_free()
	
	var time_spot = RichTextLabel.new()
	time_spot.bbcode_enabled = true
	time_spot.fit_content_height = true
	time_spot.rect_min_size = Vector2(60, 0)
	time_spot.text = "[center]%s[/center]" % ""
	self.call_deferred("add_child", time_spot)
	
	match view:
		"day":
			var new_name = RichTextLabel.new()
			var today = DateManager.match_weekday(DateManager.current_date.weekday)
			new_name.bbcode_enabled = true
			new_name.fit_content_height = true
			new_name.text = ("[center]%s/%s %s[/center]" 
							% [DateManager.current_date.day, DateManager.current_date.month, today])
			new_name.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			new_name.size_flags_vertical = Control.SIZE_EXPAND_FILL 
#			new_name.set_anchors_preset(Control.PRESET_WIDE)
			self.call_deferred("add_child", new_name)
		"week":
			for x in range(7):
				var offset = DateManager.current_date.weekday - x
				var new_name = RichTextLabel.new()
				var day_name = DateManager.match_weekday(x)
				new_name.bbcode_enabled = true
				new_name.fit_content_height = true
				new_name.text = ("[center]%s/%s %s[/center]" 
								% [DateManager.current_date.day - offset, DateManager.current_date.month, day_name])
				new_name.size_flags_horizontal = Control.SIZE_EXPAND_FILL
				new_name.size_flags_vertical = Control.SIZE_EXPAND_FILL 
#				new_name.set_anchors_preset(Control.PRESET_WIDE)
				self.call_deferred("add_child", new_name)
