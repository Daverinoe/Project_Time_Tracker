extends Node

# Signals emitted by user actions
signal add_task(task_name : String, hours : float, due_date : Dictionary,
customer : String, manager : String, category : String)
signal task_added(task_name : String)
signal set_view_state(state : String)
signal project_button(task_name : String)

# Signals emitted by app processes
signal update_values
