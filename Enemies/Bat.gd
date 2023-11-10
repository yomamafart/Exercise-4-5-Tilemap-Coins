extends CharacterBody2D

var player = null
@onready var ray = $See
@export var speed = 800
@export var looking_speed = 100
var line_of_sight = false
var nav_ready = false
var inital_position

var mode = ""


var points = []
const margin = 1.5

func _ready():
	$AnimatedSprite2D.play("move")
	call_deferred("nav_setup")
	inital_position = global_position

func nav_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame
	$NavigationAgent2D.target_position = global_position
	nav_ready = true

func _physics_process(_delta):
	player = get_node_or_null("/root/Game/Player_Container/Player")
	var s = looking_speed
	var points = inital_position
	if player != null and nav_ready:
		$NavigationAgent2D.target_position = player.global_position
		points = $NavigationAgent2D.get_next_path_position()
		$See.target_position = to_local(player.global_position)
		var c = $See.get_collider()
		if c == player:
			s = speed
		var distance = player.global_position - global_position
		var direction = distance.normalized()
		if distance.length() > margin or points.size() > 2:
			velocity = direction*s
		else:
			velocity = Vector2.ZERO
		move_and_slide()


func _on_attack_body_entered(body):
	if body.name == "Player":
		body.die()
		queue_free()


func _on_above_and_below_body_entered(body):
	if body.name == "Player":
		body.die()
		queue_free()
