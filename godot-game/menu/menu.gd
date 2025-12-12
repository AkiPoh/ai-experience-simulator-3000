extends Control


@onready var first_button = $Level1Button # Used for selection on scene loading


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Level1Button.pressed.connect(_on_level1_pressed)
	first_button.grab_focus()


func _on_level1_pressed() -> void:
	get_tree().change_scene_to_file("res://level1/level_1.tscn")
