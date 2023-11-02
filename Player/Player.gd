extends CharacterBody2D

@onready var SM = $StateMachine

var jump_power = Vector2.ZERO
var direction = 1

@export var gravity = Vector2(0,30)

@export var move_speed = 100
@export var max_move = 1000

@export var jump_speed = 200
@export var max_jump = 4000

@export var leap_speed = 200
@export var max_leap = 2000

var moving = false
var is_jumping = false
var double_jumped = false
var should_direction_flip = true # wether or not player controls (left/right) can flip the player sprite


func _physics_process(_delta):
	velocity.x = clamp(velocity.x,-max_move,max_move)
		
	if should_direction_flip:
		if direction < 0 and not $AnimatedSprite2D.flip_h: $AnimatedSprite2D.flip_h = true
		if direction > 0 and $AnimatedSprite2D.flip_h: $AnimatedSprite2D.flip_h = false
	
	if is_on_floor():
		double_jumped = false

func is_moving():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),1.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = -1
	if event.is_action_pressed("right"):
		direction = 1

func set_animation(anim):
	if $AnimatedSprite2D.animation == anim: return
	if $AnimatedSprite2D.sprite_frames.has_animation(anim): $AnimatedSprite2D.play(anim)
	else: $AnimatedSprite2D.play()

func die():
	queue_free()



func _on_coin_collector_body_entered(body):
	if body.name == "Coins":
		body.get_coin(global_position)
