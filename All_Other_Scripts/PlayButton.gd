extends Button



func _on_PlayButton_pressed():
	Global.lives = Global.max_lives
	#get_tree().change_scene("res://Main_Scene.tscn")
	#Load.load_scene(self,"res://Main_Scene.tscn")


func _on_Levels_pressed():
	get_tree().change_scene("res://Levels.tscn")


func _on_HELP_pressed():
	get_tree().change_scene("res://HELP.tscn")


func _on_Character_pressed():
	get_tree().change_scene("res://Characters.tscn")


func _on_Exit_pressed():
	SavedData.saveData()
	get_tree().quit()
