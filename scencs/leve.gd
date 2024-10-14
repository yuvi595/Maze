extends Area3D
@export var quiz_ui: NodePath
@export var question_resource: QuestionData # Use the QuestionData resource type

var question_shown: bool = false
func _on_body_entered(body):
	if body.is_in_group("Player") and not question_shown:
		print("Player entered quiz area")
		show_question()
func show_question():
	if question_resource != null:  
		var quiz_ui_instance = get_node_or_null(quiz_ui)
		if quiz_ui_instance:
			quiz_ui_instance.set_question(
				question_resource.question,
				question_resource.answers,
				question_resource.correct_answer
			)
			quiz_ui_instance.show_ui()
			question_shown = true
		else:
			print("Error: QuizUI node not found.")
	else:
		print("No question resource assigned")

func _on_body_exited(body):
	if body.is_in_group("Player"):
		print("Player exited quiz area")
		var quiz_ui_instance = get_node_or_null(quiz_ui)
		if quiz_ui_instance:
			quiz_ui_instance.hide_ui()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func reset_quiz():
	question_shown = false
func _ready():
	if question_resource == null:
		print("No question resource assigned.")
	elif not (
		question_resource.question != "" and
		question_resource.answers.size() > 0 and
		question_resource.correct_answer != ""
	):
		push_error("Question data is incomplete.")
	add_to_group("QuizAreas")


# Replace with function body.
