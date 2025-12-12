extends Node2D


var coins_collected: int = 0
var total_coins: int = 0


@onready var coin_counter: Label = $CoinCounter
@onready var win_overlay: CanvasLayer = $WinOverlay


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	total_coins = $Coins.get_child_count()
	for coin: Area2D in $Coins.get_children():
		var err: Error = coin.body_entered.connect(_on_coin_collected.bind(coin)) as Error
		if err != OK:
			push_error("Failed to connect coin signal")
	coin_counter.text = str(coins_collected) + "/" + str(total_coins)


func _on_coin_collected(body: Node, coin: Node) -> void:
	if body == $Vacuum:
		coins_collected += 1
		coin.queue_free()
		coin_counter.text = str(coins_collected) + "/" + str(total_coins)
		if coins_collected >= total_coins:
			_on_level_complete()


func _on_level_complete() -> void:
	win_overlay.visible = true
	await get_tree().create_timer(5).timeout
	_load_menu()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		_load_menu()


func _load_menu() -> void:
	var err: Error = get_tree().change_scene_to_file("res://menu/menu.tscn")
	if err != OK:
		push_error("Failed to load menu")
