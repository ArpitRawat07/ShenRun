extends Node


#levels keeps the record of the current level and the upcoming levels.
var levels : = 1
#var max_levels:=1
var max_lives=3
var lives = max_lives#variable which stores the life of the player
var hud
var Coins := 0
var player := 1
var current_level:=1
var maxplayer := 1
var character_array = [1]
var level_array = [1]
var unlockedlevels = 1
var level_star := {"level1":0,"level2":0,"level3":0,
					"level4":0,"level5":0}


func _process(delta):
	SavedData.saveData()
	if player>=maxplayer:
		maxplayer=player
	#if get_tree().current_scene.name == "Main_Scene":
	if current_level == 1:
		levels=1
	#elif get_tree().current_scene.name == "Level_2":
	if current_level == 2:
		levels=2
	#elif get_tree().current_scene.name == "Level_3":
	if current_level == 3:
		levels=3
	#elif get_tree().current_scene.name == "Level_4":
	if current_level == 4:
		levels=4
	#elif get_tree().current_scene.name == "Level_5":
	if current_level == 5:
		levels=5
	
	
	



	
func hide_layer(layer_to_hide):
	layer_to_hide.hide()

func show_layer(layer_to_show):
	layer_to_show.show()


func lose_life():
	lives-=1
	hud.load_hearts()
