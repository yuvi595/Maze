extends Area3D
class_name portal_scene
@export_file("*.tscn") var to_scene : String

func _on_body_entered(body):
	if body is Player:
		
		get_tree().change_scene_to_file.bind(to_scene).call_deferred()
	# Replace with function body.
