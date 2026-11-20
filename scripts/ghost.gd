extends Node2D

@onready var patrol: AnimationPlayer = $Patrol
@onready var body: AnimatedSprite2D = $PatrolPath/Follower/Body

# the player came into sight: hurry and turn red
func _on_sight_body_entered(other: Node2D) -> void:
	if other.is_in_group("player"):
		patrol.speed_scale = 2.0
		body.modulate = Color(1, 0.4, 0.4)

# the player escaped: calm down again
func _on_sight_body_exited(other: Node2D) -> void:
	if other.is_in_group("player"):
		patrol.speed_scale = 1.0
		body.modulate = Color(1, 1, 1)

func _on_hitbox_body_entered(other: Node2D) -> void:
	if other.is_in_group("player"):
		other.take_damage(10)
