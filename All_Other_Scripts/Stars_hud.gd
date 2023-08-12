extends CanvasLayer

func _ready():
	load_stars()
	
	
	
func load_stars():
	if Global.lives>=0:
		$StarsFull.rect_size.x= Global.lives * 70
		
