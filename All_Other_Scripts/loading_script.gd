extends Node


func _ready():
	pass
	
	



func goto_scene(path,current_scene):
	var loader = ResourceLoader.load_interactive(path)
	
	var loading_scene = load("res://loading.tscn").instance()
	
	get_tree().get_root().call_deferred("add_child",loading_scene)
	
	while true:
		var err = loader.poll()
		if err == ERR_FILE_EOF:
			var resource = loader.get_resource()
			get_tree().get_root().call_deferred("add_child",resource.instance())
			#get_tree().change_scene(path)
			loading_scene.queue_free()
			break
		
		if err == OK :
			var bar = loading_scene.get_node("ProgressBar")
			var progress = float(loader.get_stage())/loader.get_stage_count()
			bar.value = progress * 100
			print(progress)
		yield(get_tree(),"idle_frame")
