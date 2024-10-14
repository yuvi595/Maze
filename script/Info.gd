extends Area3D

# Assuming GuideInfo is a child node named GuideInfo
 



func _on_body_entered(body):
	if body.is_in_group("Player"):
		$"../../Guideinfo".visible= true
		
		pass # Replace with function body.


func _on_body_exited(body):
	if body.is_in_group("Player"):
		$"../../Guideinfo".visible= false
	pass # Replace with function body.
