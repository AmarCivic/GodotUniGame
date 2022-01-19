extends Node2D


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("Start"):
		get_tree().change_scene("res://World.tscn")
