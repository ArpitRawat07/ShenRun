extends CanvasLayer

onready var target_node = get_node("../Mobile_Controls")

func _unhandled_input(event):
	if event.is_action_released("pause"):
		get_tree().paused = true
		target_node.hide()#button hiding
		$Pause/ColorRect.show()


func _on_Resume_pressed():
	get_tree().paused = false
	target_node.show()
	$Pause/ColorRect.hide()




func _on_Restart1_pressed():
	Global.lives=Global.max_lives
	#get_tree().reload_current_scene()
	#target_node.show()
	get_tree().paused = false
	$Pause/ColorRect.hide()
	if Global.current_level==1:
		get_tree().get_root().get_node("/root/Main_Scene").queue_free()
		LoadingScript.goto_scene("res://Main_Scene.tscn",self)
	elif Global.current_level==2:
		get_tree().get_root().get_node("/root/Level_2").queue_free()
		LoadingScript.goto_scene("res://Level_2.tscn",self)
	elif Global.current_level==3:
		get_tree().get_root().get_node("/root/Level_3").queue_free()
		LoadingScript.goto_scene("res://Level_3.tscn",self)
	elif Global.current_level==4:
		get_tree().get_root().get_node("/root/Level_4").queue_free()
		LoadingScript.goto_scene("res://Level_4.tscn",self)
	elif Global.current_level==5:
		get_tree().get_root().get_node("/root/Level_5").queue_free()
		LoadingScript.goto_scene("res://Level_5.tscn",self)


func _on_MainMenu_pressed():
	get_tree().paused = false
	target_node.show()
	if Global.current_level==1:
		get_tree().get_root().get_node("/root/Main_Scene").queue_free()
		get_tree().change_scene("res://TitleMenu.tscn")
	elif Global.current_level==2:
		get_tree().get_root().get_node("/root/Level_2").queue_free()
		get_tree().change_scene("res://TitleMenu.tscn")
	elif Global.current_level==3:
		get_tree().get_root().get_node("/root/Level_3").queue_free()
		get_tree().change_scene("res://TitleMenu.tscn")
	elif Global.current_level==4:
		get_tree().get_root().get_node("/root/Level_4").queue_free()
		get_tree().change_scene("res://TitleMenu.tscn")
	elif Global.current_level==5:
		get_tree().get_root().get_node("/root/Level_5").queue_free()
		get_tree().change_scene("res://TitleMenu.tscn")
