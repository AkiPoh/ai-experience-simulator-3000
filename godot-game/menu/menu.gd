extends Control


@onready var first_button: Button = $Level1Button # Used for selection on scene loading


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if first_button.pressed.connect(_on_level1_pressed) != OK:
		push_error("Failed to connect Level1Button signal")
	first_button.grab_focus()


func _on_level1_pressed() -> void:
	if get_tree().change_scene_to_file("res://level1/level_1.tscn") != OK:
		push_error("Failed to load level 1")
