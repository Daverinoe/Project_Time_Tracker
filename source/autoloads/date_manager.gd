extends Node

var current_date = Time.get_date_dict_from_system()

func match_weekday(weekday_enum) -> String:
	match weekday_enum:
		0:
			return "Sunday"
		1:
			return "Monday"
		2:
			return "Tuesday"
		3:
			return "Wednesday"
		4:
			return "Thursday"
		5:
			return "Friday"
		6:
			return "Saturday"
	return "null"
