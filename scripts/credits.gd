extends Control

func _on_back_button_pressed() -> void:
	$Click.play()
	Fade.change_scene("res://scenes/main_menu.tscn")
