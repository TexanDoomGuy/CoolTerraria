extends Node2D

@onready var tile_map = $Node/TileMap

@onready var tile_map2 = $TileMap

@onready var player = $Player

@onready var inventory = $Camera/InventoryGridStacked

var grass = Vector2i(2,1)
var grass2 = Vector2i(1,0)
var dirt = Vector2i(2,2)


# Called when the node enters the scene tree for the first time.
func placetree(location):
	
	var location1 = tile_map.map_to_local(location)
	location = tile_map2.local_to_map(location1)
	
	
	print("making a tree")
	#player.position = location1
	print(location)
	tile_map2.set_cell(1, location-Vector2i(0,0), 0, Vector2i(0,0))	
	

func destroytree(location):
	var treepart = tile_map2.get_cell_atlas_coords(0,location).y -7
	
func destroy_block(location):
	tile_map.erase_cell(0, location)
	
func create_block(location,block):
	tile_map.set_cell(0, location, 0, block)

func _ready():
	var coolgrass = tile_map.get_used_cells_by_id(0, 0, grass)
	print(coolgrass)
	
	for i in range(randf_range(4,9)):
		placetree(Vector2i(coolgrass.pick_random()))
		#print(Vector2i(coolgrass.pick_random()))
	for i in range(coolgrass.size()):
		create_block(coolgrass[i]+Vector2i(0,1),dirt)		

func _input(event):
	if Input.is_action_pressed("ui_up"):
			inventory.create_and_add_item_at("Wood",Vector2i(0,0))
			#inventory.add_item_at("Wood",Vector2i(0,0))
	if Input.is_action_just_pressed("click"):
		var tile_pos = tile_map.local_to_map(get_global_mouse_position())
		var tile_pos2 = tile_map2.local_to_map(get_global_mouse_position())
		
		print(tile_map.get_cell_atlas_coords(0,tile_pos))
		print(tile_pos)
	
		if tile_map.get_cell_atlas_coords(0,tile_pos) == Vector2i(-1,-1):
			if tile_map.get_cell_atlas_coords(0,Vector2i(tile_pos.x,tile_pos.y+1)) != Vector2i(-1,-1):
				if tile_map.get_cell_atlas_coords(0,Vector2i(tile_pos.x,tile_pos.y-1)) != Vector2i(-1,-1):
					create_block(tile_pos, dirt)
				else:
					create_block(tile_pos+Vector2i(0,1),dirt)
					create_block(tile_pos+Vector2i(0,0),grass)
			elif tile_map.get_cell_atlas_coords(0,Vector2i(tile_pos.x,tile_pos.y-1)) != Vector2i(-1,-1):
				create_block(tile_pos, dirt)
			elif tile_map.get_cell_atlas_coords(0,Vector2i(tile_pos.x+1,tile_pos.y)) != Vector2i(-1,-1):
				create_block(tile_pos, grass)
			elif tile_map.get_cell_atlas_coords(0,Vector2i(tile_pos.x-1,tile_pos.y)) != Vector2i(-1,-1):
				create_block(tile_pos, grass)
			
		if tile_map2.get_cell_atlas_coords(1,tile_pos2) != Vector2i(-1,-1):
			destroytree(tile_pos2)


	if Input.is_action_just_pressed("right click"):
		var tile_pos = tile_map.local_to_map(get_global_mouse_position())
		var tile_pos2 = tile_map2.local_to_map(get_global_mouse_position())
		destroy_block(tile_pos)
		

