extends Control


func _ready():
		
	for l in $ColorRect/levels.get_children():
		if str2var(l.name) in range(Global.unlockedlevels+1):
			l.disabled=false
		else:
			l.disabled=true


func _on_level_1_pressed():
	Global.current_level=1
	Global.lives=Global.max_lives
	get_tree().get_root().get_node("/root/Levels").queue_free()
	LoadingScript.goto_scene("res://Main_Scene.tscn",self)
	#get_tree().change_scene("res://Main_Scene.tscn")


func _on_level_2_pressed():
	Global.current_level=2
	Global.lives=Global.max_lives
	get_tree().get_root().get_node("/root/Levels").queue_free()
	LoadingScript.goto_scene("res://Level_2.tscn",self)
	#get_tree().change_scene("res://Level_2.tscn")


func _on_level_3_pressed():
	Global.current_level=3
	Global.lives=Global.max_lives
	get_tree().get_root().get_node("/root/Levels").queue_free()
	LoadingScript.goto_scene("res://Level_3.tscn",self)
	#get_tree().change_scene("res://Level_3.tscn")


func _on_level_4_pressed():
	Global.current_level=4
	Global.lives=Global.max_lives
	get_tree().get_root().get_node("/root/Levels").queue_free()
	LoadingScript.goto_scene("res://Level_4.tscn",self)
	#get_tree().change_scene("res://Level_4.tscn")


func _on_level_5_pressed():
	Global.current_level=5
	Global.lives=Global.max_lives
	get_tree().get_root().get_node("/root/Levels").queue_free()
	LoadingScript.goto_scene("res://Level_5.tscn",self)
	#get_tree().change_scene("res://Level_5.tscn")



