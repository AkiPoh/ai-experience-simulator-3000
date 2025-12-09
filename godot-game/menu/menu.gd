extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Level1Button.pressed.connect(_on_level1_pressed)
	$Level2Button.pressed.connect(_on_level2_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level1_pressed() -> void:
	get_tree().change_scene_to_file("res://level1/level_1.tscn")


func _on_level2_pressed() -> void:
	get_tree().change_scene_to_file("res://level2/level_2.tscn")
