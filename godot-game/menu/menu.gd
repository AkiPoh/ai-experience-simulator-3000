extends Control


@onready var first_button: Button = $Level1Button

var cancel_hold_time: float = 0.0
const QUIT_HOLD_DURATION: float = 0.5


func _ready() -> void:
	if first_button.pressed.connect(_on_level1_pressed) != OK:
		push_error("Failed to connect Level1Button signal")
	first_button.grab_focus()


func _process(delta: float) -> void:
	if Input.is_action_pressed("escape"):
		cancel_hold_time += delta
		if cancel_hold_time >= QUIT_HOLD_DURATION:
			get_tree().quit()
	else:
		cancel_hold_time = 0.0


func _on_level1_pressed() -> void:
	if get_tree().change_scene_to_file("res://level1/level_1.tscn") != OK:
		push_error("Failed to load level 1")
