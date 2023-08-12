extends KinematicBody2D


var speed:= 80
var dead := 0
export var direction := -1
var velocity := Vector2(0,0)

func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true#flipping the sprite.
		$WallChecker.rotation_degrees*= -1


func _physics_process(delta):
	velocity.x = direction * speed
	if dead == 1:
		$AnimatedSprite.play("bat dead")
	else:
		$AnimatedSprite.play("bat fly")
	if $WallChecker.is_colliding():
		direction = direction * -1
		$WallChecker.rotation_degrees*= -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
	move_and_slide(velocity, Vector2.UP)




func _on_SideChecker_body_entered(body):
	if body.get_collision_layer() == 1:
		body.ouch(position.x)
	elif body.get_collision_layer() == 32:
		velocity.y=150
		speed=0
		$AnimatedSprite.rotation_degrees =- 90
		set_collision_layer_bit(4,false)
		set_collision_mask_bit(0,false)
		set_collision_mask_bit(5,false)
		$SideChecker.set_collision_layer_bit(4,false)
		$SideChecker.set_collision_mask_bit(0,false)
		$SideChecker.set_collision_mask_bit(5,false)
		dead = 1
		body.queue_free()
		$Timer.start()


func _on_Timer_timeout():
	queue_free()
