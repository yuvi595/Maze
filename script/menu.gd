extends VBoxContainer

const WORLD = preload("res://scencs/flotingisland.tscn")
func _physics_process(delta):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	
func _on_start_pressed():
	get_tree().change_scene_to_packed(WORLD)


func _on_quit_pressed():
	get_tree().quit()
