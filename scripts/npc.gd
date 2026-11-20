extends Node2D

var speed: float = 50.0
var direction: float = 1.0   # 1 = right, -1 = left
var start_x: float

func _ready() -> void:
	start_x = position.x

func _process(delta: float) -> void:
	position.x += speed * direction * delta
	if position.x > start_x + 80:
		direction = -1.0
	elif position.x < start_x:
		direction = 1.0
	$AnimatedSprite2D.flip_h = direction < 0
