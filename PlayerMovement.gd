extends KinematicBody2D

const UP = Vector2(0,-1)
const ACCEL = 20
const GRAVITY = 20
const MAXFALLSPEED = 300
const MAXSPEED = 160
const JUMPFORCE = 350

var motion = Vector2()
var facing_right = true
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	motion.y += GRAVITY
	if motion.y > MAXFALLSPEED:
		motion.y = MAXFALLSPEED
	
	if facing_right == true:
		$Sprite.scale.x = 1
	else:
		$Sprite.scale.x = -1
	
	motion.x = clamp(motion.x,-MAXSPEED,MAXSPEED)
	
	if Input.is_action_pressed("right"):
		motion.x += ACCEL
		facing_right = true
		$AnimationPlayer.play("PlayerRunAni")
	elif Input.is_action_pressed("left"):
		motion.x += -ACCEL
		facing_right = false
		$AnimationPlayer.play("PlayerRunAni")
	else:
		motion.x = lerp(motion.x,0,0.2)
		$AnimationPlayer.play("PlayerIdleAni")
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			$AnimationPlayer.play("Jump")
			motion.y = -JUMPFORCE
	else:
		if motion.y < 0:
			$AnimationPlayer.play("Jump")
		elif motion.y > 0:
			$AnimationPlayer.play("PlayerFallAni")
	motion = move_and_slide(motion,UP)
	
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Enemies"):
			position = Vector2(0,0)
		if collision.collider.is_in_group("Finish"):
			get_tree().change_scene("res://EndScreen.tscn")
