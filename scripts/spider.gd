extends Node2D

var ready_to_drop: bool = true

@onready var body: Sprite2D = $Body

func _ready() -> void:
	body.position = Vector2(0, -48)   # hanging on the ceiling, 3 tiles up

func _on_trigger_body_entered(other: Node2D) -> void:
	if not ready_to_drop or not other.is_in_group("player"):
		return
	ready_to_drop = false
	# drop down in 0.3 seconds
	var tween: Tween = create_tween()
	tween.tween_property(body, "position", Vector2(0, 0), 0.3)
	await get_tree().create_timer(1.0).timeout
	body.visible = false              # gone after 1 second
	await get_tree().create_timer(5.0).timeout
	body.position = Vector2(0, -48)   # back on the ceiling
	body.visible = true
	ready_to_drop = true
