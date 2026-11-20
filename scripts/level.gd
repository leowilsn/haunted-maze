extends Node2D

var collected: int = 0
var total: int = 0
var time_passed: float = 0.0
var finished: bool = false

@onready var collected_label: Label = $HUD/CollectedLabel
@onready var health_bar: TextureProgressBar = $HUD/HealthBar
@onready var time_label: Label = $HUD/TimeLabel

func _ready() -> void:
	GameState.current_level = scene_file_path
	var coins: Array = get_tree().get_nodes_in_group("coins")
	total = coins.size()
	for coin in coins:
		coin.collected.connect(_on_coin_collected)
	# listen to the hero's health_changed signal
	var player = get_tree().get_first_node_in_group("player")
	player.health_changed.connect(_on_player_health_changed)
	update_label()

func _process(delta: float) -> void:
	if finished:
		return   # stop counting when the level is complete
	time_passed += delta
	time_label.text = "Time: %d" % int(time_passed)

func _on_coin_collected() -> void:
	collected += 1
	update_label()
	if has_node("CoinSound"):
		$CoinSound.play()

func _on_player_health_changed(new_value: int) -> void:
	health_bar.value = new_value
	$HUD/HealthLabel.text = "%d/100" % new_value

func update_label() -> void:
	collected_label.text = "Collected %d/%d" % [collected, total]

func show_message(text: String) -> void:
	collected_label.text = "%s  (Collected %d/%d)" % [text, collected, total]
