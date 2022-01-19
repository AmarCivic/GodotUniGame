extends Node2D


func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("leave"):
		get_tree().quit()
