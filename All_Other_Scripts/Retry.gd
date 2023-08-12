extends Button




func _on_Retry_pressed():
	Global.lives=Global.max_lives
	get_tree().change_scene("res://Levels.tscn")
