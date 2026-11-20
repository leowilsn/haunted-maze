extends Control

@onready var time_label: Label = $TimeLabel

func _ready() -> void:
	time_label.text = "Your time: %d s" % GameState.final_time

func _on_play_again_button_pressed() -> void:
	$Click.play()
	GameState.final_time = 0   # a new game starts from 0 seconds
	Fade.change_scene("res://scenes/level_0.tscn")

func _on_menu_button_pressed() -> void:
	$Click.play()
	Fade.change_scene("res://scenes/main_menu.tscn")
