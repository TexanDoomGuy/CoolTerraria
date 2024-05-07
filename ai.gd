#extends CharacterBody2D
#
#var x
#var fellaSide = 0
#
#@export var speed = 200 #speed duh
#@export var jump_power = -300 #how much the player jumps
#
#@export var acc = 1000 #the speed the player accelerates
#
#@export var gravity = 1000 #gravity
#
#@export var spawn_point = Vector2(1000,-3500) #the point the player should spawn at
#
#var cur_jump = 0 #the current jump the player is on
#
#func _physics_process(delta):
	#if not is_on_floor(): #if in the air,
		#velocity.y += gravity * delta
		#print(gravity * delta)
	#if fellaSide != 0:
		#move(5,fellaSide,delta)
	#if is_on_floor():
		#velocity.y = 0
	#position += velocity
	#
#
#func jump():
	#if cur_jump ==0: #and if player hasn't jumped before,
		#velocity.y = jump_power #jump
		#cur_jump =+ 1 #sets cur_jump to 1 so no jumping mid-air
#
#func move(time,direction,delta):
	#while x != time:
		#if fellaSide == 1:
			#velocity.x = move_toward(velocity.x, speed * 1, acc * delta)
		#if fellaSide == -1:
			#velocity.x = move_toward(velocity.x, speed * -1, acc * delta)
		#$Timer.start(time)
		#if fellaSide == 0:
			#print("nope")
#
#func _on_right_area_entered(area,delta):
	#fellaSide = -1
#
#func _on_left_area_entered(area):
	#fellaSide = -1
#
#
#func _on_right_area_exited(area):
	#fellaSide = 0	
