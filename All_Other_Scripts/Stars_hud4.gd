extends CanvasLayer

func _ready():
	load_stars()
	
	
	
func load_stars():
	$StarsFull.rect_size.x= Global.level_star["level4"] * 70
		
