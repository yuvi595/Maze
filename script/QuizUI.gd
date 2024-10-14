extends Control

var question = ""
var answers = []
var correct_answer = ""

func set_question(new_question: String, new_answers: Array, new_correct_answer: String):
	question = new_question
	answers = new_answers
	correct_answer = new_correct_answer

	var question_label = $Panel.get_node_or_null("Label")
	if question_label:
		question_label.text = question

	# Disconnect any existing signals and connect the new ones
	for i in range(answers.size()):
		var button = $Panel.get_node("Button" + str(i + 1))
		button.text = answers[i]
		button.disabled = false  
		if button.is_connected("pressed", Callable(self, "_on_button_1_pressed")): 
			button.pressed.disconnect(_on_button_1_pressed)
		button.pressed.connect(_on_button_1_pressed.bind(i))

func show_ui():
	self.visible = true
	self.set_focus_mode(FOCUS_ALL)  # or FOCUS_CLICK depending on your needs
	self.grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func hide_ui():
	self.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	# Check if signals exist before disconnecting
	for i in range(answers.size()):
		var button = $Panel.get_node("Button" + str(i + 1))
		if button.is_connected("pressed", Callable(self, "_on_button_1_pressed")):
			button.pressed.disconnect(_on_button_1_pressed)

func _ready():
	hide_ui()

func _on_button_1_pressed(button_index: int):
	# Immediately disable all buttons after one is pressed
	for i in range(answers.size()):
		var button = $Panel.get_node("Button" + str(i + 1))
		button.disabled = true

	if answers[button_index] == correct_answer:
		display_feedback("Correct!")
		var player_node = get_tree().get_first_node_in_group("Player") # Find the player node
		if player_node:
			player_node.correct_answer_count += 1
	else:
		display_feedback("Wrong!")
		get_tree().call_group("Player", "die")

func display_feedback(message):
	var feedback_label = $Panel.get_node_or_null("FeedbackLabel")
	if feedback_label:
		feedback_label.text = message
		feedback_label.visible = true
		if message == "Correct!":
			feedback_label.modulate = Color.GREEN
		else:
			feedback_label.modulate = Color.RED

		await get_tree().create_timer(1.0).timeout  # 2-second delay
		feedback_label.visible = false
		hide_ui()  # Hide the UI after feedback is shown
