extends CanvasLayer

var steps = 10
var current_step = 0
var level_scene = load("res://Main_Scene.tscn")
var loader = null
var progress_bar = null

func _ready():
	# Load the main scene
	#var level_scene = preload("res://Main_Scene.tscn")
	var level_instance = level_scene.instance()
	progress_bar = get_node("ProgressBar")
	
	# Load the main scene asynchronously
	var loader = ResourceLoader.load_interactive("res://Main_Scene.tscn")
	if loader == null:
		print("Error occurred while loading the scene")
		return
		
	# Wait for 0.5 seconds so that the loading screen can appear
	#yield(get_tree().create_timer(0.5), "timeout")
	
	while true:
		# Poll returns loaded data in pieces, so keep in a loop
		var error = loader.poll()
		
		if error == OK:
			# Update the progress bar according to the amount of data being loaded
			progress_bar.value = float(loader.get_stage()) / loader.get_stage_count() * 100
			
		elif error == ERR_FILE_EOF:
			# Create scene instance from the loaded data
			#get_tree().change_scene("res://Main_Scene.tscn")
			get_tree().get_root().call_deferred("add_child",level_instance)
			queue_free()
			return
			
		else:
			# Handle other errors
			print("Error occurred while loading chunks of data")
			return
		
		yield()
