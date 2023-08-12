extends KinematicBody2D

#States is an enumeration which has the players state.
enum States {AIR=1, FLOOR , DEAD, LADDER , WALL , SHOOT , SLIDE , SLICE }
"""Enumerations are zero indexed, and can be changed by the user;
here AIR has value=1, FLOOR has value=2 and so on.
So state here contains such values."""
var state= States.AIR
var score : int = 0 #Colon means that the data type is static.
var last_jump_direction = 0
#variable c to delay cpu time to throw the kunai
var c = 0
#To distribute slide time i.e firstly it should slide and play slide sound then change its state.
var s = 0
const SPEED : int = 300
const RUNSPEED = 500
const JUMPFORCE : int = 800
const GRAVITY : int = 35
var coins : int = 0
var hurt := 0
var direction = 1
#vel variable which tells velocity of the player in x and y axis.
var vel = Vector2(0,0)
#Kunai variable stores the kunai scene
const KUNAI = preload("res://bullet.tscn")
#on the game being loaded, variable sprite stores the player node. 
onready var sprite : AnimatedSprite = get_node("sprite")

#Function which is the driver of the player scene; runs 60 times per second.
func _physics_process(delta):
	match state:
		States.DEAD:#When the player is dead.
			$CollisionShape2D.shape.extents = Vector2(19,35.555599)
			vel.x = 0
			move_and_fall(false)
			$sprite.play("dead")
		
		States.SHOOT:#When a kunai is thrown. 
			# player running in kunai state to avoid game lag during switching between player states
			if Input.is_action_pressed("move_left") and not Input.is_action_pressed("shoot"): 
				if Input.is_action_pressed("run"):
					vel.x=lerp(vel.x,-RUNSPEED,0.1)
					$sprite.set_speed_scale(1.66)
				else :
					vel.x=lerp(vel.x,-SPEED,0.1)
				$sprite.set_speed_scale(1)
				direction=-1
				sprite.flip_h=true
			elif Input.is_action_pressed("move_right") and not Input.is_action_pressed("shoot"):
				if Input.is_action_pressed("run"):
					vel.x=lerp(vel.x,RUNSPEED,0.1)
					$sprite.set_speed_scale(1.666)
				else :
					vel.x=lerp(vel.x,SPEED,0.1)
				$sprite.set_speed_scale(1)
				direction=1
				sprite.flip_h=false
			$sprite.play("throw")
			#incrementing c to 22 to delay cpu, while throwing a kunai.
			c=c+1
			if c==9:
				#shoot()
				if is_on_floor():
					shoot()
					state=States.FLOOR
					c=0
					continue
				#else:
					#shoot()
					#state=States.AIR
					#c=0
					#continue
			if not is_on_floor():
				shoot()
				state=States.AIR
				c=0
				continue


		States.WALL:
			#To do side wall jumps.
			#To avoid side jump from the same wall,
			#changing last_jump_direction again and again.
			if is_on_floor():
				state= States.FLOOR
				last_jump_direction=0
				continue
			elif not is_near_wall():
				state= States.AIR
				continue
			elif not is_on_floor():
				$sprite.play("jump")
				
			#Jumping when players direction is not equal last_jump_direction,
			# and action pressed is move_left and jump and player's direction is equal to 1
			# or move_right and jump and player's direction is equal to 1.
			if direction!=last_jump_direction and  Input.is_action_pressed("jump") and ((Input.is_action_pressed("move_left") and direction==1) or Input.is_action_just_pressed("jump") and (Input.is_action_pressed("move_right") and direction == -1)):
				last_jump_direction = direction
				vel.y=-JUMPFORCE
				vel.x= 500 * -direction
				$sprite.flip_h=true
				$SoundJump.play()
				state= States.AIR
				
			move_and_fall(true)
			
#To distribute slide time i.e
# s should reach 40 till then firstly it should slide and play slide sound then change its state.	
		States.SLIDE:
			if Global.lives<=0:
				state = States.DEAD
				continue
			if Input.is_action_just_pressed("jump"):
				#changing velocity to -Jumpforce which means to upward direction.
				vel.y-=JUMPFORCE
				#playing jump sound.
				$SoundJump.play()
				#changing to air state.
				state= States.AIR
			s=s+1
			if s<40:
				vel.x= direction * 200
				sprite.play("slide")
#changing collision shape to a smaller value, so that it could slide of between the tiles.
				$CollisionShape2D.shape.extents = Vector2(9.5,21)
			if s>=40 and not $SlideHelper2.is_colliding():
#making that collision shape normal.
				$CollisionShape2D.shape.extents = Vector2(19,35.555599)
				state=States.FLOOR
			move_and_fall(false)
			
			
		States.AIR:
			$CollisionShape2D.shape.extents = Vector2(19,35.555599)
			#making player dead if 3 lives are over.
			if Global.lives<=0:
				state = States.DEAD
				continue
				
				
			#switching to floor state if player is on floor.
			elif is_on_floor() and vel.y ==0:
				state=States.FLOOR
				last_jump_direction=0
				continue
				
				
#switching to wall jumping state if it is near the wall.
			elif is_near_wall():
				state=States.WALL
				continue
				
			#playing in air animations
			sprite.play("jump")
#moving left in air
#changing speed gradually from its current velocity to speed using lerp.
#depending upon, if player is running fast->changing its speed rapidly,
#and if it was walking then changing its speed slowly,
			if Input.is_action_pressed("move_left"):
				vel.x=lerp(vel.x,-SPEED,0.1) if vel.x > -SPEED else lerp(vel.x,-SPEED,0.03)
				direction=-1
				sprite.flip_h=true
				
				
			elif Input.is_action_pressed("move_right"):
				vel.x=lerp(vel.x,SPEED,0.1) if vel.x<SPEED else lerp(vel.x,SPEED,0.03)
				direction=1
				sprite.flip_h=false
				
				
				
				
			else :#changing speed to 0 slowly.
				vel.x=lerp(vel.x,0,0.2)
			move_and_fall(false)
			
			
			#shoot()
#shooting if player is not near the wall.
			if Input.is_action_just_pressed("shoot") and not is_near_wall():
				state=States.SHOOT
				continue
			
			
		States.FLOOR:#When on the floor
			if Global.lives<=0:#if dead, switching state to dead
				state = States.DEAD
				continue
			if not is_on_floor():#if in air.
				state = States.AIR
				continue
				
			$SlideHelper2.position.x = direction * - 15 #To detect floor on player's top
			$SlideHelper.rotation_degrees= direction * -90  #To detect wall in the front
			$SlideHelper3.rotation_degrees= direction * -90 #To detect space below to slide
			
			
			#movement input
			if Input.is_action_pressed("move_left"):
				if Input.is_action_pressed("run"):
#If running velocity changed to Runspeed gradually,
#where -ive sign indicates left direction and +ive indicates the right one.
#direction = -1 shows that the player is facing to the left.
#direction = 1 shows that the player is facing to the right.
					vel.x=lerp(vel.x,-RUNSPEED,0.1)
					$sprite.set_speed_scale(1.66)#Speeding sprite's animation frame rate.
				else :
#else if player is walking, then velocity changed to speed 
#and sprite's animation frame rate changed to normal.  
					vel.x=lerp(vel.x,-SPEED,0.1)
				sprite.play("walk")
				$sprite.set_speed_scale(1)
				direction=-1
				sprite.flip_h=true#Player rotated
				
				
			elif Input.is_action_pressed("move_right"):
				if Input.is_action_pressed("run"):
					vel.x=lerp(vel.x,RUNSPEED,0.1)
					$sprite.set_speed_scale(1.666)
				else :
					vel.x=lerp(vel.x,SPEED,0.1)
					
					
				$sprite.play("walk")
				$sprite.set_speed_scale(1)
				direction=1
				sprite.flip_h=false
				
				
			elif ((Input.is_action_just_pressed("slide")  and not $SlideHelper3.is_colliding()) or $SlideHelper2.is_colliding()):
			#elif (Input.is_action_just_pressed("slide") and $SlideHelper.is_colliding() and not $SlideHelper3.is_colliding()) or $SlideHelper2.is_colliding():
#Switching to slide state if :
#(slide key is pressed and there is a wall in the front and some space below it to slide).
#there is a wall just above player's head and is touching it.
#Playing slide sound
				s=0
				$SoundSlide.play()
				state= States.SLIDE
			else :
				$sprite.play("idle")
				#To stop with a slide
				vel.x=lerp(vel.x,0,0.2)
						#jump input
			if Input.is_action_just_pressed("jump"):
				#changing velocity to -Jumpforce which means to upward direction.
				vel.y-=JUMPFORCE
				#playing jump sound.
				$SoundJump.play()
				#changing to air state.
				state= States.AIR
				
			
			move_and_fall(false)
			if Input.is_action_just_pressed("shoot") and not is_near_wall() and hurt == 0:
				state=States.SHOOT
				continue
			#shoot()
			
	

func is_near_wall():#A raycast which tells the player is near the wall or not.
	$Wallchecker.rotation_degrees= direction * -90
	return $Wallchecker.is_colliding()

func shoot():#To shoot the kunai
#variable f which stores a kunai instance
	var f = KUNAI.instance()
#giving it a direction same as the player and rotating it as it moves forward.
	f.direction = direction
	
#adding kunai's instance to the Main_Scene(level 1)
#and adjusting its position according to the player.
	get_parent().add_child(f)
	f.position.x = position.x + 30 * direction
	f.position.y = position.y+ 15


func move_and_fall(slow_fall: bool):
	"""A function which decides players movement 
	and the gravity for the game"""
	#GRAVITY
	#vel.y+=GRAVITY*delta
	vel.y= vel.y + GRAVITY
	
	if slow_fall:#to make player slide while falling form a wall.
		vel.y=vel.y + JUMPFORCE/400
		#vel.y= clamp(vel.y,JUMPFORCE,-150) 
	#applying the velocity
#move_and_slide function which helps the player to move and tells it a standing direction.
	vel = move_and_slide(vel,Vector2.UP)



# warning-ignore:unused_argument
func _on_fallzone_body_entered(body):
# warning-ignore:return_value_discarded
	Global.lives-=1
	if Global.lives>0:#playing game over screen if the player falls from the stage.
		get_tree().reload_current_scene()
	else:
		get_tree().change_scene("res://Game_Over.tscn")
	
	


func bounce():
#To bounce the player
	vel.y=-(JUMPFORCE*0.3)
	



func ouch(var enemy_pos_x):
	Global.lose_life()#When player touches the enemy
	if Global.lives >= 1:
#for first two lives, playing simple hurt sound.
		$SoundHurt.play()
	if Global.lives == 0:
#when all lives are over, removing player from all the collision layers and masks.
		#set_collision_layer_bit(1,false)
		#set_collision_mask_bit(2,false)
		#set_collision_mask_bit(3,false)
		#set_collision_mask_bit(4,false)
		#set_collision_mask_bit(5,false)
		$SoundDead.play()#playing dead sound
		$Timer.start()#starting timer for playing game over screen.
	
	#set_modulate(Color(1,0.3,0.3,0.5))
	vel.y=-(JUMPFORCE*0.3) # jumping backwards when player is hurt.
	
	
	""" Noticed that the position of the player is always coming greater than that of the enemy.
	For enemy being in the left , the code ......player_position greater or less with respect to the enemy.. was working fine, but for the player being in the left,it was not.
	And also that the difference between their positions was less than 4 for player on the left(as noticed), so coded this scene as follows."""
	#if (position.x-enemy_pos_x)<4: 
		#vel.x= - 900
	#elif position.x>enemy_pos_x:
		#vel.x= 900
	

#moving player backwards when it touches the enemy
	if (position.x-enemy_pos_x)<4: 
		vel.x= - 900
	elif position.x>enemy_pos_x:
		vel.x= 900
	elif position.x<enemy_pos_x:
		vel.x = -900
	else:
		vel.x = 900
		
#disabling the keys when the player is hurt
	Input.action_release("move_left")
	Input.action_release("move_right")
	Input.action_release("slide")
	
	hurt = 10
	set_modulate(Color(1,0.3,0.3,0.85))
	set_collision_layer_bit(0,false)
	$Timer2.start()
	

var gameover = load("res://Game_Over.tscn")

func _on_Timer_timeout():
#To load game over screen
	if Global.current_level==1:
		get_tree().get_root().get_node("/root/Main_Scene").queue_free()
	elif Global.current_level==2:
		get_tree().get_root().get_node("/root/Level_2").queue_free()
	elif Global.current_level==3:
		get_tree().get_root().get_node("/root/Level_3").queue_free()
	elif Global.current_level==4:
		get_tree().get_root().get_node("/root/Level_4").queue_free()
	elif Global.current_level==5:
		get_tree().get_root().get_node("/root/Level_5").queue_free()
	get_tree().get_root().add_child(gameover.instance())
	#get_tree().change_scene("res://Game_Over.tscn")



func _on_VictoryDoor_body_entered(body):
	Global.unlockedlevels+=1
#To start timer when player enters the victory door.
	$TimerWin.start()


func _on_TimerWin_timeout():
#To load you win screen
	#get_tree().change_scene("res://Level_2.tscn")
	Global.levels += 1
	if Global.levels == 1:
		get_tree().change_scene("res://Main_Scene.tscn")
		Global.lives=Global.max_lives
	elif Global.levels== 2:
		get_tree().change_scene("res://Level_2.tscn")
		Global.lives=Global.max_lives
	elif Global.levels== 3:
		get_tree().change_scene("res://Level_3.tscn")
		Global.lives=Global.max_lives
	elif Global.levels== 4:
		get_tree().change_scene("res://Level_4.tscn")
		Global.lives=Global.max_lives
	elif Global.levels== 5:
		get_tree().change_scene("res://Level_5.tscn")
		Global.lives=Global.max_lives
	else :
		get_tree().change_scene("res://YouWin.tscn")



func _on_Timer2_timeout():#Timer for blinking if player is hurt.
	hurt-=1
	if hurt == 0 :
		$Timer2.stop()
		set_modulate(Color(1,1,1,1))
		set_collision_layer_bit(0,true)
	elif hurt > 0 and Global.lives > 0:
		set_modulate(Color(3,3,3,0.8) if hurt % 2 == 0 else Color(1,0.3,0.3,0.85))
		

