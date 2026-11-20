extends CharacterBody2D

var speed: float = 110.0
var is_hurt: bool = false
signal health_changed(new_value: int)

var health: int = 100

func _physics_process(_delta: float) -> void:
	var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	var current_speed: float = speed
	if Input.is_action_pressed("sprint"):
		current_speed = speed * 2

	velocity = direction * current_speed
	move_and_slide()

	# footsteps: play while moving, a little different each time
	if velocity != Vector2.ZERO and not $Footsteps.playing:
		$Footsteps.pitch_scale = randf_range(0.9, 1.1)
		$Footsteps.play()

	# while hurt, the hurt animation keeps playing
	if not is_hurt:
		if velocity == Vector2.ZERO:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("walk")

	if direction.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif direction.x > 0:
		$AnimatedSprite2D.flip_h = false

func hurt() -> void:
	if is_hurt:
		return
	is_hurt = true
	$AnimatedSprite2D.play("hurt")
	$HurtSound.play()
	# blink: red → normal, 5 times × 0.1 s = 0.5 s
	var tween: Tween = create_tween()
	tween.set_loops(5)
	tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 0.3, 0.3), 0.05)
	tween.tween_property($AnimatedSprite2D, "modulate", Color(1, 1, 1), 0.05)
	await get_tree().create_timer(0.5).timeout
	is_hurt = false

func take_damage(amount: int) -> void:
	if is_hurt:
		return   # still blinking = can't be hit again yet
	health -= amount
	if health < 0:
		health = 0
	health_changed.emit(health)   # tell whoever listens (the HUD)
	if health == 0:
		Fade.change_scene("res://scenes/game_over.tscn")
		return
	hurt()

func heal(amount: int) -> void:
	health = min(health + amount, 100)
	health_changed.emit(health)
