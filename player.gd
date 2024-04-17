extends CharacterBody2D

@export var New_Random_Worlds = true

@export var speed = 200 #speed duh
@export var jump_power = -300 #how much the player jumps

@export var acc = 1000 #the speed the player accelerates

@export var gravity = 1000 #gravity

@export var spawn_point = Vector2(1000,-3500) #the point the player should spawn at

var cur_jump = 0 #the current jump the player is on

func respawn(respawnpoint): #function for respawning
	position = respawnpoint #respawn
	

func _ready():
	if New_Random_Worlds == true:
		pass
		#$"../Node/HeightmapGenerator2D".generate()

func _physics_process(delta):
	if position.y > 1000: #if player is too low,
		respawn(spawn_point) #respawn
	
	var direction = Input.get_axis("left", "right") #direction = 1 if moving right, -1 if moving left
	
	velocity.x = move_toward(velocity.x, speed * direction, acc * delta) #move
	
	if Input.is_action_pressed("Jump"): #if z is pressed,
		if cur_jump ==0: #and if player hasn't jumped before,
			velocity.y = jump_power #jump
			cur_jump =+ 1 #sets cur_jump to 1 so no jumping mid-air
	if not is_on_floor(): #if in the air,
		$"coyote time".start(0.02) #have a delay before not being able to jump mid-air
		velocity.y += gravity * delta #gravity.
	if is_on_floor(): #if on floor,
		cur_jump = 0 #let the player jump again
	
	move_and_slide()


func _on_coyote_time_timeout():
	cur_jump = 1


#func _on_heightmap_generator_2d_generation_finished():
#	respawn(spawn_point)
