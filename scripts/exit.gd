extends Area2D

@export_file("*.tscn") var next_scene: String = "res://scenes/win.tscn"

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return
	var level = get_tree().current_scene
	if level.finished:
		return   # already on the way out
	if level.collected < level.total:
		level.show_message("Find all coins first!")
		return
	level.finished = true
	level.show_message("Level complete!")
	GameState.final_time += int(level.time_passed)
	$DoorCreak.play()
	$Jingle.play()
	# wait 1 second so the sounds can play, then go on
	await get_tree().create_timer(1.0).timeout
	Fade.change_scene(next_scene)
