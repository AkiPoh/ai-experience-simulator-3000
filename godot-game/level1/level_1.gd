extends Node2D


var coins_collected := 0
var total_coins := 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	total_coins = $Coins.get_child_count()
	for coin in $Coins.get_children():
		coin.body_entered.connect(_on_coin_collected.bind(coin))
	$CoinCounter.text = str(coins_collected) + "/" + str(total_coins)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene_to_file("res://menu/menu.tscn")


func _on_coin_collected(body: Node, coin: Node) -> void:
	if body == $Vacuum:
		coins_collected += 1
		coin.queue_free()
		$CoinCounter.text = str(coins_collected) + "/" + str(total_coins)
		if coins_collected >= total_coins:
			_on_level_complete()


func _on_level_complete() -> void:
	$WinOverlay.visible = true
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_file("res://menu/menu.tscn")
