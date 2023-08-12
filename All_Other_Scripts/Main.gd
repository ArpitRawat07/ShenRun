extends Node2D
#we will preloafd our obstacle
var obstacle= preload("res://Tile.tscn")
#total number of obstacles we want to spawn
var max_obstacle=1000
#we want to loop through the obstacles
func _ready() -> void :
	for i in range(max_obstacle):
		var obstacle_scene=obstacle.instance() #we want to instance the scene
		obstacle_scene.global_position=Vector2(9072*(i+1),600) #we want to actually instance the scene accordingly 
