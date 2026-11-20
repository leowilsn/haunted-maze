extends Control

func _on_restart_button_pressed() -> void:
	$Click.play()
	Fade.change_scene(GameState.current_level)

func _on_menu_button_pressed() -> void:
	$Click.play()
	Fade.change_scene("res://scenes/main_menu.tscn")
