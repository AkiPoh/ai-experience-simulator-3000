extends Node2D


var searched := []
var phone_location: Node
var responses := {
	"Plant1": "Just leaves. Definetely no phone here.",
	"Plant2": "Is it tree or is it plant. No phone here even so.",
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var searchables = $Seachables.get_children()
	phone_location = searchables.pick_random()
	for item in searchables:
		item.body_entered.connect(_on_searchable_touched.bind(item))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://menu/menu.tscn")

func _on_searchable_touched(body: Node, item: Node) -> void:
	if body == $Robot and item not in searched:
		searched.append(item)
		if item == phone_location:
			_on_level_complete()
		else:
			$ResponseLabel.text = responses.get(item.name, "Nothing here.")


func _on_level_complete() -> void:
	$WinOverlay.visible = true
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://menu/menu.tscn")
