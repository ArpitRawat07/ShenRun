extends KinematicBody2D

var speed = 50
var k =0
export var direction = -1
var velocity = Vector2()
export var detects_cliffs = true

#_ready() function starts working as soon as the scene starts.
func _ready():
	if direction == 1:#checking initial direction of enemy.
		$AnimatedSprite.flip_h = true#flipping the sprite.
	$floor_checker.position.x=$CollisionShape2D.shape.get_extents().x * direction
	$floor_checker.enabled = detects_cliffs
	if detects_cliffs:
		set_modulate(Color(1.2,0.5,1))


func _physics_process(delta):
	if direction == -1:
		$TileDetector.position.x = -30
	else:
		$TileDetector.position.x = 90
	if (is_on_wall() or not $floor_checker.is_colliding() and detects_cliffs and is_on_floor()) or $TileDetector.is_colliding():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$floor_checker.position.x=$CollisionShape2D.shape.get_extents().x * direction
	velocity.x = direction * speed
	velocity.y += 20
	move_and_slide(velocity, Vector2.UP)




func _on_top_checker_body_entered(body):
	if body.get_collision_layer() == 1:
		$AnimatedSprite.play("spider_dead")
		speed = 0
		set_collision_layer_bit(4,false)
		set_collision_mask_bit(0,false)
		$top_checker.set_collision_layer_bit(4,false)
		$top_checker.set_collision_mask_bit(0,false)
		$sides_checker.set_collision_layer_bit(4,false)
		$sides_checker.set_collision_mask_bit(0,false)
		$Timer.start()
		body.bounce()
		$SoundSquash.play()
	elif body.get_collision_layer() == 32:
		body.queue_free()
		queue_free()


func _on_side_checker_body_entered(body):
	if body.get_collision_layer() == 1:
		body.ouch(position.x)
	elif body.get_collision_layer() == 32:#kunai
		body.queue_free()
		queue_free()


func _on_Timer_timeout():
	queue_free()



