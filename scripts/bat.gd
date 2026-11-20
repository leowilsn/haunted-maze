extends Node2D

@onready var flight: AnimationPlayer = $Flight
@onready var body: AnimatedSprite2D = $FlightPath/Follower/Body

func _on_sight_body_entered(other: Node2D) -> void:
	if other.is_in_group("player"):
		flight.speed_scale = 0.0
		body.modulate = Color(1, 0.4, 0.4)

func _on_sight_body_exited(other: Node2D) -> void:
	if other.is_in_group("player"):
		flight.speed_scale = 1.0
		body.modulate = Color(1, 1, 1)
