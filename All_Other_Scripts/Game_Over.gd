extends Control


func _on_restart_pressed():
	get_tree().get_root().get_node("/root/Game_Over").queue_free()
	if Global.levels == 1:
		#get_tree().change_scene("res://Main_Scene.tscn")
		Global.lives=Global.max_lives
		LoadingScript.goto_scene("res://Main_Scene.tscn",self)
		
	elif Global.levels== 2:
		#get_tree().change_scene("res://Level_2.tscn")
		Global.lives=Global.max_lives
		LoadingScript.goto_scene("res://Level_2.tscn",self)
		
	elif Global.levels== 3:
		#get_tree().change_scene("res://Level_3.tscn")
		Global.lives=Global.max_lives
		LoadingScript.goto_scene("res://Level_3.tscn",self)
		
	elif Global.levels== 4:
		#get_tree().change_scene("res://Level_4.tscn")
		Global.lives=Global.max_lives
		LoadingScript.goto_scene("res://Level_4.tscn",self)
		
	elif Global.levels== 5:
		#get_tree().change_scene("res://Level_5.tscn")
		Global.lives=Global.max_lives
		LoadingScript.goto_scene("res://Level_5.tscn",self)
		
	else :
		get_tree().change_scene("res://YouWin.tscn")



func _on_Levels_pressed():
	Global.lives=Global.max_lives
	get_tree().get_root().get_node("/root/Game_Over").queue_free()
	get_tree().change_scene("res://Levels.tscn")


func _on_MainMenu_pressed():
	get_tree().get_root().get_node("/root/Game_Over").queue_free()
	get_tree().change_scene("res://TitleMenu.tscn")
	
