extends CanvasLayer


var coins = Global.Coins
func _physics_process(delta):
	load_hearts()



func _ready():
	load_hearts()
	Global.Coins = coins
	$Coins.text = String(coins)
	Global.hud = self


func _on_coin_collected():
	coins = coins + 1
	_ready()


func _on_Button_pressed():
	get_tree().change_scene("res://Pause.tscn")

func load_hearts():
	if Global.lives>=0:
		$HeartsFull.rect_size.x= Global.lives * 53
		$HeartsEmpty.rect_size.x= (Global.max_lives - Global.lives) * 53
		$HeartsEmpty.rect_position.x= $HeartsFull.rect_position.x + $HeartsFull.rect_size.x
	
	
