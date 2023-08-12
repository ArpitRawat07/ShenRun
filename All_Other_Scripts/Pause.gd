extends CanvasLayer


func _on_Resume_pressed():
	get_tree().paused = false
	$Pause/ColorRect.hide()


func _on_Restart1_pressed():
	Global.lives=Global.max_lives
	get_tree().reload_current_scene()
	get_tree().paused = false


func _on_MainMenu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://TitleMenu.tscn")
