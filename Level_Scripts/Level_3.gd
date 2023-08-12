extends Node2D



var a = load("res://Tom.tscn")
var b = load("res://Sheru.tscn")
var c = load("res://Snt Santa.tscn")
var d = load("res://Lily.tscn")
var e = load("res://AI.tscn")
var f = load("res://NinjaGirl.tscn")
var g = load("res://player1.tscn")


func _ready():
	Global.current_level=3
	if Global.player==1:
		var x = a.instance()
		self.add_child(x)
		x.position.x=80
		x.position.y=500
		
	if Global.player==2:
		var x = b.instance()
		self.add_child(x)
		x.position.x=80
		x.position.y=500
		
	if Global.player==3:
		var x = c.instance()
		self.add_child(x)
		x.position.x=80
		x.position.y=500
		
	if Global.player==4:
		var x = d.instance()
		self.add_child(x)
		x.position.x=80
		x.position.y=500
		
	if Global.player==5:
		var x = e.instance()
		self.add_child(x)
		x.position.x=80
		x.position.y=500
		
	if Global.player==6:
		var x = f.instance()
		self.add_child(x)
		x.position.x=80
		x.position.y=500
		
	
	if Global.player==7:
		var x = g.instance()
		self.add_child(x)
		x.position.x=80
		x.position.y=500


func _on_fallzone_body_entered(body):
	# warning-ignore:return_value_discarded
	Global.lives-=1
	if Global.lives>0:#playing game over screen if the player falls from the stage.
		#get_tree().reload_current_scene()
		if Global.player==1:
			if has_node("Tom"):
				get_node("Tom").queue_free()
			elif has_node("@Tom@2"):
				get_node("@Tom@2").queue_free()
			var x = a.instance()
			self.add_child(x)
			if Global.lives>0:
				var y=x.get_node("tom")
				Global.lives+=1
				y.ouch(0);
			x.position.x=80
			x.position.y=500
		
		if Global.player==2:
			if has_node("Sheru"):
				get_node("Sheru").queue_free()
			elif has_node("@Sheru@2"):
				get_node("@Sheru@2").queue_free()
			#get_node("Sheru").queue_free()
			var x = b.instance()
			self.add_child(x)
			if Global.lives>0:
				var y=x.get_node("sheru")
				Global.lives+=1
				y.ouch(0);
			x.position.x=80
			x.position.y=500
		
		if Global.player==3:
			if has_node("Snt Santa"):
				get_node("Snt Santa").queue_free()
			elif has_node("@Snt Santa@2"):
				get_node("@Snt Santa@2").queue_free()
			#get_node("Snt Santa").queue_free()
			var x = c.instance()
			self.add_child(x)
			if Global.lives>0:
				var y=x.get_node("sntSanta")
				Global.lives+=1
				y.ouch(0);
			x.position.x=80
			x.position.y=500
		
		if Global.player==4:
			if has_node("Lily"):
				get_node("Lily").queue_free()
			elif has_node("@Lily@2"):
				get_node("@Lily@2").queue_free()
			#get_node("Lily").queue_free()
			var x = d.instance()
			self.add_child(x)
			if Global.lives>0:
				var y=x.get_node("lily")
				Global.lives+=1
				y.ouch(0);
			x.position.x=80
			x.position.y=500
			
		
		if Global.player==5:
			if has_node("AI"):
				get_node("AI").queue_free()
			elif has_node("@AI@2"):
				get_node("@AI@2").queue_free()
			#get_node("AI").queue_free()
			var x = e.instance()
			self.add_child(x)
			if Global.lives>0:
				var y=x.get_node("ai")
				Global.lives+=1
				y.ouch(0);
			x.position.x=80
			x.position.y=500
		
		if Global.player==6:
			if has_node("NinjaGirl"):
				get_node("NinjaGirl").queue_free()
			elif has_node("@NinjaGirl@2"):
				get_node("@NinjaGirl@2").queue_free()
			#get_node("NinjaGirl").queue_free()
			var x = f.instance()
			self.add_child(x)
			if Global.lives>0:
				var y=x.get_node("ninjagirl")
				Global.lives+=1
				y.ouch(0);
			x.position.x=80
			x.position.y=500
	
		if Global.player==7:
			var x=get_node("player1")
			Global.lives+=1
			x.ouch(0);
			x.position.x=80
			x.position.y=500
		
		
		
	else:
		get_tree().get_root().get_node("/root/Level_3").queue_free()
		get_tree().change_scene("res://Game_Over.tscn")
	


func _on_VictoryDoor_body_entered(body):
	if Global.unlockedlevels==Global.current_level:
		Global.unlockedlevels=4
	if Global.level_star["level3"]<Global.lives:
		Global.level_star["level3"]=Global.lives
	get_tree().get_root().get_node("/root/Level_3").queue_free()
	get_tree().change_scene("res://YouWin.tscn")
