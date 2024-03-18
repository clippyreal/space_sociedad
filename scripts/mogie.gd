extends CharacterBody2D
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var arm = get_node("arm")
@onready var laser = get_node("arm/laser")
var bullet = preload("res://scenes/bullet.tscn")
var player
var seesPlayer = false
var drawLaser = false

func _process(_delta):
	if seesPlayer:
		arm.look_at(player.position)
		laser.points[1] = Vector2(position.distance_to(player.position), 0)
func _draw():
	if drawLaser:
		draw_line(player.position,laser.position,Color.RED,2000)
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
func _on_detect_box_body_entered(body):
	player = body
	seesPlayer = true
	shoot()
func _on_detect_box_body_exited(_body):
	seesPlayer = false
	drawLaser = false
func shoot():
	pass
