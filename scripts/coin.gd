extends Area2D

# our own signal: the coin tells the level "I was picked up"
signal collected


func _on_body_entered(body: Node2D) -> void:
	# only the player can collect the coin
	if body.is_in_group("player"):
		collected.emit()   # tell the level
		queue_free()       # the coin removes itself
