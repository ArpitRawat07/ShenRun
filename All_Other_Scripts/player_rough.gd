extends KinematicBody2D

var score : int = 0
var speed : int = 300
var jumpForce : int = 600
var gravity : int = 1000
var vel : Vector2 = Vector2()
onready var sprite : AnimatedSprite = get_node("sprite")
func _physics_process(delta):
	#movement input
	vel.x=0
	if Input.is_action_pressed("move_left"):
		vel.x-=speed
		sprite.play("walk")
	elif Input.is_action_pressed("move_right"):
		vel.x+=speed
		$sprite.play("walk")
	else :
		$sprite.play("idle")
	
	#applying the velocity
	vel = move_and_slide(vel,Vector2.UP)
	#sprite direction
	if vel.x < 0:
		sprite.flip_h=true
	elif vel.x > 0:
		sprite.flip_h=false
	#gravity
	vel.y+=gravity*delta
	#jump input
	if(Input.is_action_just_pressed("jump")and is_on_floor()):
		vel.y-=jumpForce


func _on_fallzone_body_entered(body):
	get_tree().change_scene("res://Main_Scene.tscn")
