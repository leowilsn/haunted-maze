extends Node2D

@onready var start_button: Button = $UI/StartButton

func _ready() -> void:
	# the START button fades in over half a second
	start_button.modulate.a = 0.0
	var tween: Tween = create_tween()
	tween.tween_property(start_button, "modulate:a", 1.0, 0.5)
	start_button.grab_focus()   # Enter or Space presses it
	# the title drops in from above the screen with a little bounce
	$UI/Title.position.y = -60
	var title_tween: Tween = create_tween()
	title_tween.tween_property($UI/Title, "position:y", 40.0, 0.6).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	# a browser can't quit a game, so hide Quit on the web
	$UI/QuitButton.visible = not OS.has_feature("web")

func _on_start_button_pressed() -> void:
	$Click.play()
	GameState.final_time = 0
	Fade.change_scene("res://scenes/level_0.tscn")

func _on_credits_button_pressed() -> void:
	$Click.play()
	Fade.change_scene("res://scenes/credits.tscn")

func _on_quit_button_pressed() -> void:
	$Click.play()
	await $Click.finished   # let the click finish before closing
	get_tree().quit()
