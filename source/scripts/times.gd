extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(48):
		var time
		if x % 2 == 0:
			time = "%s:00" % (x/2)
		else:
			time = "%s:30" % floor(x/2)
		var half_hour = RichTextLabel.new()
		half_hour.bbcode_enabled = true
		half_hour.fit_content_height = true
		half_hour.rect_min_size = Vector2(60, 0)
		half_hour.size_flags_vertical = Control.SIZE_EXPAND_FILL
		half_hour.scroll_active = false
		half_hour.text = "[center]%s[/center]" % time
		self.call_deferred("add_child", half_hour)

