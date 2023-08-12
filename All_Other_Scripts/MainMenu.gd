extends Button





func _on_MainMenu_pressed():
	#var title = load("res://TitleMenu.tscn").instance()
	#get_tree().get_root().call_deferred("add_child",title)
	get_tree().change_scene("res://TitleMenu.tscn")
	
	#if Global.current_level==1:
		#get_tree().get_root().get_node("/root/Main_Scene").queue_free()
		#get_tree().change_scene("res://TitleMenu.tscn")
	#elif Global.current_level==2:
		#get_tree().get_root().get_node("/root/Level_2").queue_free()
		#get_tree().change_scene("res://TitleMenu.tscn")
	#elif Global.current_level==3:
		#get_tree().get_root().get_node("/root/Level_3").queue_free()
		#get_tree().change_scene("res://TitleMenu.tscn")
	#elif Global.current_level==4:
		#get_tree().get_root().get_node("/root/Level_4").queue_free()
		#get_tree().change_scene("res://TitleMenu.tscn")
	#elif Global.current_level==5:
		#get_tree().get_root().get_node("/root/Level_5").queue_free()
		#get_tree().change_scene("res://TitleMenu.tscn")


