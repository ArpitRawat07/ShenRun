extends KinematicBody2D

var velocity = Vector2()
const SPEED = 800
var direction = 1

func _ready():
	velocity.x = direction * SPEED
	


func _physics_process(delta):
	if is_on_wall():
		queue_free()
	velocity = move_and_slide(velocity,Vector2.UP)
	$Sprite.rotation_degrees += 10 * direction


func _on_kunai_body_entered(body):
	if body.get_collision_layer() == 16:
		#body.queue_free()
		#queue_free()
		pass


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Timer_timeout():
	$Sound_kunai.play()
