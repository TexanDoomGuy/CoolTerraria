extends Node2D

@onready var player_y = $Player_y
@onready var player_x = $Player_x
@onready var wood_removed = $wood_removed
@onready var player = $"../../Player"
@onready var aaa = $aaa
@onready var world = $"../.."
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_x.text = str(player.position.x)
	player_y.text = str(player.position.y)
	wood_removed.text = str(world.wood_removed)
	aaa.text = str(world.inventory.get_item_position(world.dirt))

