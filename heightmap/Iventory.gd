extends Node2D

var gold = 0
var diamond = 0
var iron_pickaxe = 1
var iron_axe = 1
var gold_pickaxe = 0
var gold_axe = 0
var diamond_pickaxe = 0
var diamond_axe = 0

var goldi = 0
var diamondi = 1
var iron_pickaxei = 2
var iron_axei = 3
var gold_pickaxei = 4
var gold_axei = 5
var diamond_pickaxei = 6
var diamond_axei = 7

var inventory = []

# Called when the node enters the scene tree for the first time.

func pickup(item):
	item += 1
	print(item)
func unpickup(item):
	item -= 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
