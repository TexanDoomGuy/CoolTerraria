extends Node2D

@export var item_protoset: ItemProtoset
@export var wood: InventoryItem
var _ctrl_inventory_grid_basic: CtrlInventoryGridBasic = null
const CtrlInventoryGridBasic = preload("res://addons/gloot/ui/ctrl_inventory_grid_basic.gd")

@onready var tile_map = $Node/TileMap

@onready var tile_map2 = $TileMap

@onready var player = $Player

@onready var inventory = $Camera/InventoryGridStacked

@onready var ctrl_inventory = $Camera/CtrlInventoryGrid

@onready var item_select = $Camera/background

var grass = Vector2i(2,1)
var grass2 = Vector2i(1,0)
var dirt = Vector2i(2,2)
var wood_removed = 0
var item_selected = Vector2i(0,0)
var placed_item = "null"


# Called when the node enters the scene tree for the first time.
func placetree(location):
	
	var location1 = tile_map.map_to_local(location)
	location = tile_map2.local_to_map(location1)
	
	
	#print("making a tree")
	#player.position = location1
	#print#print(location)
	tile_map2.set_cell(1, location-Vector2i(0,0), 0, Vector2i(0,0))	
	

func destroytree(location):
	@warning_ignore("unused_variable")
	var treepart = tile_map2.get_cell_atlas_coords(0,location).y -7
	
func destroy_block(location):
	tile_map.erase_cell(0, location)
	
func create_block(location,block):
	tile_map.set_cell(0, location, 0, block)
	
func add_item(item):
	if item == wood:
		if wood_removed == 0:
			var wood_stack = inventory.get_item_stack_size(wood)
			#print(wood)
			#print(wood_stack)
			inventory.set_item_stack_size(wood, wood_stack+1)
		else:
			inventory.add_item(wood)
			wood_removed = 0
func remove_item(item):
	if item == wood:
		var wood_stack = inventory.get_item_stack_size(wood)
		if wood_stack == 1:
			inventory.remove_item(wood)
			wood_removed = 1
		else:
			#print(wood_stack)
			#item_protoset.set_prototype_property("Wood","stack_size", wood_stack+1)
			inventory.set_item_stack_size(wood, wood_stack-1)
	

@warning_ignore("unused_parameter")
func _process(delta):
	if inventory.get_item_stack_size(wood) == 0:
		wood.set_property("image", null)
	else:
		wood.set_property("image","res://wood.png")
func _ready():
	var coolgrass = tile_map.get_used_cells_by_id(0, 0, grass)
	#print(coolgrass)
	for i in range(randf_range(4,9)):
		placetree(Vector2i(coolgrass.pick_random()))
		#print(Vector2i(coolgrass.pick_random()))
	for i in range(coolgrass.size()):
		create_block(coolgrass[i]+Vector2i(0,1),dirt)		

@warning_ignore("unused_parameter")
func _input(event):
	if Input.is_action_pressed("ui_up"):
		add_item(wood)
	if Input.is_action_pressed("ui_down"):
		remove_item(wood)
	if Input.is_action_pressed("1"):
		#print(inventory.get_item_at(Vector2i(0,0)))
		if inventory.get_item_at(Vector2i(0,0)) != null:
			item_select.position.x = -585			
			#_ctrl_inventory_grid_basic.select_inventory_item(inventory.get_item_at(Vector2i(0,0)))
	if Input.is_action_pressed("2"):
		#print(inventory.get_item_at(Vector2i(1,0)))
		if inventory.get_item_at(Vector2i(1,0)) != null:
			item_select.position.x = -553
			if inventory.get_item_at(Vector2i(2,0)): 
				pass
			#_ctrl_inventory_grid_basic.select_inventory_item(inventory.get_item_at(Vector2i(1,0)))
	if Input.is_action_pressed("3"):
		#print(inventory.get_item_at(Vector2i(2,0)))
		if inventory.get_item_at(Vector2i(2,0)) != null:
			item_select.position.x = -521
			#_ctrl_inventory_grid_basic.select_inventory_item(inventory.get_item_at(Vector2i(2,0)))
		
		
	if Input.is_action_just_pressed("click"):
		var tile_pos = tile_map.local_to_map(get_global_mouse_position())
		var tile_pos2 = tile_map2.local_to_map(get_global_mouse_position())
		
		#print(tile_map.get_cell_atlas_coords(0,tile_pos))
		#print(tile_pos)
		for i in range(11):	
			if item_select.position.x == -585 + (32*(i-1)):
				item_selected = Vector2i(i,0)
				print("i = "+str(i))
				print("item_selected = "+str(item_selected))
		
			if inventory.get_item_position(wood) == item_selected:
				placed_item = "Wood"
			print("placed_item = "+str(placed_item))
			
		if placed_item == "Dirt":
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
		if placed_item == "Wood":
			pass
			#todo make create_block request the tilemap
			#todo make a tilemap for blocsk
		if tile_map2.get_cell_atlas_coords(1,tile_pos2) != Vector2i(-1,-1):
			destroytree(tile_pos2)


	if Input.is_action_just_pressed("right click"):
		var tile_pos = tile_map.local_to_map(get_global_mouse_position())
		@warning_ignore("unused_variable")
		var tile_pos2 = tile_map2.local_to_map(get_global_mouse_position())
		destroy_block(tile_pos)
