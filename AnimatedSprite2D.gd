extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("right"):
		play("run")
		flip_h = 0
	else: if Input.is_action_pressed("left"):
		play("run")
		flip_h = 1
	else:
		play("idle")
	
