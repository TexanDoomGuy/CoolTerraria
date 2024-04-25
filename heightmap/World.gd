extends Node2D

@export var item_protoset: ItemProtoset
@export var wood: InventoryItem
@export var dirt: InventoryItem

var _ctrl_inventory_grid_basic: CtrlInventoryGridBasic = null
const CtrlInventoryGridBasic = preload("res://addons/gloot/ui/ctrl_inventory_grid_basic.gd")

@onready var tile_map = $Node/TileMap

@onready var tile_map2 = $TileMap

@onready var player = $Player

@onready var inventory = $Camera/InventoryGridStacked

@onready var ctrl_inventory = $Camera/Node2D/CtrlInventoryGrid

@onready var item_select = $Camera/Node2D/background

@onready var blocks = $Blocks

var can_place = 1

var grass = Vector2i(2,1)
var grass2 = Vector2i(1,0)
var dirt_block = Vector2i(2,2)
var wood_removed = 0
var dirt_removed = 0
var item_selected = Vector2i(0,0)
var wood_plank = Vector2i(0,0)
var wood_plank_ph = Vector2i(1,0)
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
	
func destroy_block(location,tilemap):
	tilemap.erase_cell(0, location)
	
func create_block(location,block,tilemap):
	tilemap.set_cell(0, location, 0, block)
	
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
	if item == dirt:
		if dirt_removed == 0:
			var dirt_stack = inventory.get_item_stack_size(dirt)
			#print(wood)
			#print(wood_stack)
			inventory.set_item_stack_size(dirt, dirt_stack+1)
		else:
			inventory.add_item(dirt)
			dirt_removed = 0
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
	elif item == dirt:
		var dirt_stack = inventory.get_item_stack_size(dirt)
		if dirt_stack == 1:
			inventory.remove_item(dirt)
			dirt_removed = 1
		else:
			#print(wood_stack)
			#item_protoset.set_prototype_property("Wood","stack_size", wood_stack+1)
			inventory.set_item_stack_size(dirt, dirt_stack-1)
	

func hide0_wood():
	if inventory.get_item_stack_size(wood) == 0:
		wood.set_property("image", null)
	else:
		wood.set_property("image","res://wood.png")

func hide0_dirt():
	if inventory.get_item_stack_size(dirt) == 0:
		dirt.set_property("image", null)
	else:
		dirt.set_property("image","res://dirt.png")

func select_item():
	for i in range(11):
		print(i)
		if item_select.position.x == -585 + (32*(i-1)):
			item_selected = Vector2i(i-1,0)

		if inventory.get_item_position(wood) == item_selected:
			placed_item = "Wood"
			if wood_removed == 1:
				placed_item = "null"					
		elif inventory.get_item_position(dirt) == item_selected:
			placed_item = "Dirt"
			placed_item = "null"
	return(placed_item)

func select_item_ns():
	for i in range(11):
		print(i)
		if item_select.position.x == -585 + (32*(i-1)):
			item_selected = Vector2i(i-1,0)

		if inventory.get_item_position(wood) == item_selected:
			placed_item = wood
		elif inventory.get_item_position(dirt) == item_selected:
			placed_item = dirt
	return(placed_item)


func _process(delta):
	hide0_wood()
	hide0_dirt()
func _ready():
	var coolgrass = tile_map.get_used_cells_by_id(0, 0, grass)
	#print(coolgrass)
	for i in range(randf_range(4,9)):
		placetree(Vector2i(coolgrass.pick_random()))
		#print(Vector2i(coolgrass.pick_random()))
	for i in range(coolgrass.size()):
		create_block(coolgrass[i]+Vector2i(0,1),dirt_block,tile_map)		
	#inventory.create_and_add_item("Dirt")
func _input(event):
	if Input.is_action_pressed("ui_up"):
		add_item(select_item_ns())
	if Input.is_action_pressed("ui_down"):
		remove_item(select_item_ns())
	if Input.is_action_pressed("1"):
		item_select.position.x = -585
	if Input.is_action_pressed("2"):
		item_select.position.x = -585 + (32*1)
	if Input.is_action_pressed("3"):
		item_select.position.x = -585 + (32*2)
	if Input.is_action_pressed("4"):
		item_select.position.x = -585 + (32*3)
	if Input.is_action_pressed("5"):
		item_select.position.x = -585 + (32*4)
	if Input.is_action_pressed("6"):
		item_select.position.x = -585 + (32*5)
	if Input.is_action_pressed("7"):
		item_select.position.x = -585 + (32*6)
	if Input.is_action_pressed("8"):
		item_select.position.x = -585 + (32*7)
	if Input.is_action_pressed("9"):
		item_select.position.x = -585 + (32*8)
	if Input.is_action_pressed("0"):
		item_select.position.x = -585 + (32*9)
		
	if Input.is_action_pressed("click"):
		var tile_pos = tile_map.local_to_map(get_global_mouse_position())
		var tile_pos2 = tile_map2.local_to_map(get_global_mouse_position())
		
		#print(tile_map.get_cell_atlas_coords(0,tile_pos))
		#print(tile_pos)
		select_item()
			#print("placed_item = "+str(placed_item))
		if can_place == 1:	
			if placed_item == "Dirt":
				
				if blocks.get_cell_atlas_coords(0,tile_pos) != Vector2i(-1,-1):
					create_block(tile_pos,wood_plank_ph, tile_map)		
				elif tile_map.get_cell_atlas_coords(0,tile_pos) == Vector2i(-1,-1):
					if tile_map.get_cell_atlas_coords(0,Vector2i(tile_pos.x,tile_pos.y+1)) != Vector2i(-1,-1):
						if tile_map.get_cell_atlas_coords(0,Vector2i(tile_pos.x,tile_pos.y-1)) != Vector2i(-1,-1):
							create_block(tile_pos, dirt_block,tile_map)
						else:
							create_block(tile_pos+Vector2i(0,1),dirt_block,tile_map)
							create_block(tile_pos+Vector2i(0,0),grass,tile_map)
					elif tile_map.get_cell_atlas_coords(0,Vector2i(tile_pos.x,tile_pos.y-1)) != Vector2i(-1,-1):
						create_block(tile_pos, dirt_block,tile_map)
					elif tile_map.get_cell_atlas_coords(0,Vector2i(tile_pos.x+1,tile_pos.y)) != Vector2i(-1,-1):
						create_block(tile_pos, grass,tile_map)
					elif tile_map.get_cell_atlas_coords(0,Vector2i(tile_pos.x-1,tile_pos.y)) != Vector2i(-1,-1):
						create_block(tile_pos, grass,tile_map)
						
			if placed_item == "Wood":
				if tile_map.get_cell_atlas_coords(0,tile_pos) != Vector2i(-1,-1):
					create_block(tile_pos,wood_plank_ph, blocks)	
				elif tile_map.get_cell_atlas_coords(0,Vector2i(tile_pos.x,tile_pos.y+1)) != Vector2i(-1,-1):
					create_block(tile_pos,wood_plank_ph, blocks)
				elif tile_map.get_cell_atlas_coords(0,Vector2i(tile_pos.x,tile_pos.y-1)) != Vector2i(-1,-1):
					create_block(tile_pos,wood_plank_ph, blocks)
				elif tile_map.get_cell_atlas_coords(0,Vector2i(tile_pos.x+1,tile_pos.y)) != Vector2i(-1,-1):
					create_block(tile_pos,wood_plank_ph, blocks)
				elif tile_map.get_cell_atlas_coords(0,Vector2i(tile_pos.x-1,tile_pos.y)) != Vector2i(-1,-1):
					create_block(tile_pos,wood_plank_ph, blocks)
				elif blocks.get_cell_atlas_coords(0,Vector2i(tile_pos.x,tile_pos.y+1)) != Vector2i(-1,-1):
					create_block(tile_pos,wood_plank_ph, blocks)
				elif blocks.get_cell_atlas_coords(0,Vector2i(tile_pos.x,tile_pos.y-1)) != Vector2i(-1,-1):
					create_block(tile_pos,wood_plank_ph, blocks)
				elif blocks.get_cell_atlas_coords(0,Vector2i(tile_pos.x+1,tile_pos.y)) != Vector2i(-1,-1):
					create_block(tile_pos,wood_plank_ph, blocks)
				elif blocks.get_cell_atlas_coords(0,Vector2i(tile_pos.x-1,tile_pos.y)) != Vector2i(-1,-1):
					create_block(tile_pos,wood_plank_ph, blocks)
								
				$"block delay".start(0.05)
				can_place = 0
			if tile_map2.get_cell_atlas_coords(1,tile_pos2) != Vector2i(-1,-1):
				destroytree(tile_pos2)
		else:
			pass


	if Input.is_action_pressed("right click"):
		var tile_pos = tile_map.local_to_map(get_global_mouse_position())
		var tile_pos2 = tile_map2.local_to_map(get_global_mouse_position())
		destroy_block(tile_pos,tile_map)
		destroy_block(tile_pos,blocks)


func _on_block_delay_timeout():
	print("a")
	can_place = 1
