extends Control

onready var price1 = get_node("characters/ColorRect/levels/2/price1")
onready var price2 = get_node("characters/ColorRect/levels/3/price2")
onready var price3 = get_node("characters/ColorRect/levels/4/price3")
onready var price4 = get_node("characters/ColorRect/levels/5/price4")
onready var price5 = get_node("characters/ColorRect/levels/6/price5")
onready var price6 = get_node("characters/ColorRect/levels/7/price6")

func _ready():#Removing price from unlocked characters
	for c in Global.character_array:
		if c==2:
			price1.queue_free()
		if c==3:
			price2.queue_free()
		if c==4:
			price3.queue_free()
		if c==5:
			price4.queue_free()
		if c==6:
			price5.queue_free()
		if c==7:
			price6.queue_free()
		
		
		
		

func _process(delta):
	$Character_Menu_HUD/Coins.text = String(Global.Coins)
	if Global.Coins<200 && is_instance_valid(price1):
		price1.set_modulate(Color(0.8,0.5,0.5,0.8))
		
	if Global.Coins<500 && is_instance_valid(price2):
		price2.set_modulate(Color(0.8,0.5,0.5,0.8))
		
	if Global.Coins<1000 && is_instance_valid(price3):
		price3.set_modulate(Color(0.8,0.5,0.5,0.8))
		
	if Global.Coins<1200 && is_instance_valid(price4):
		price4.set_modulate(Color(0.8,0.5,0.5,0.8))
		
	if Global.Coins<1500 && is_instance_valid(price5):
		price5.set_modulate(Color(0.8,0.5,0.5,0.8))
		
	if Global.Coins<2000 && is_instance_valid(price6):
		price6.set_modulate(Color(0.8,0.5,0.5,0.8))
	
	
	
	

#Unlocking characters
func _on_1_pressed():
	Global.player=1
	get_tree().change_scene("res://Levels.tscn")


func _on_2_pressed():
	Global.player=2
	get_tree().change_scene("res://Levels.tscn")


func _on_3_pressed():
	Global.player=3
	get_tree().change_scene("res://Levels.tscn")


func _on_4_pressed():
	Global.player=4
	get_tree().change_scene("res://Levels.tscn")


func _on_5_pressed():
	Global.player=5
	get_tree().change_scene("res://Levels.tscn")


func _on_6_pressed():
	Global.player=6
	get_tree().change_scene("res://Levels.tscn")


func _on_7_pressed():
	Global.player=7
	get_tree().change_scene("res://Levels.tscn")





func _on_price1_pressed():
	if Global.Coins>=200:
		price1.queue_free()
		Global.character_array.append(2)
		Global.Coins-=200
	


func _on_price2_pressed():
	if Global.Coins>=500:
		price2.queue_free()
		Global.character_array.append(3)
		Global.Coins-=500


func _on_price3_pressed():
	if Global.Coins>=1000:
		price3.queue_free()
		Global.character_array.append(4)
		Global.Coins-=1000


func _on_price4_pressed():
	if Global.Coins>=1200:
		price4.queue_free()
		Global.character_array.append(5)
		Global.Coins-=1200


func _on_price5_pressed():
	if Global.Coins>=1500:
		price5.queue_free()
		Global.character_array.append(6)
		Global.Coins-=1500


func _on_price6_pressed():
	if Global.Coins>=2000:
		price6.queue_free()
		Global.character_array.append(7)
		Global.Coins-=2000


func _on_STATS_pressed():
	get_tree().change_scene("res://Character_Menu.tscn")

