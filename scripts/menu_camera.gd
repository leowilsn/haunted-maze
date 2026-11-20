extends Camera2D

var speed: float = 15.0   # pixels per second

func _process(delta: float) -> void:
	position.x += speed * delta
	# turn around at the ends (change 400 to fit your maze)
	if position.x > 400 or position.x < 240:
		speed = -speed
