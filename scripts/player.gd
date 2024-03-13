extends CharacterBody2D
#physics goy still to be figured out
const SPEED = 250
const JUMP_VELOCITY = -520
const maxVel = 500
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var body = get_node("bodySprite")
@onready var arm = get_node("armSprite")
@onready var tip = get_node("armSprite/tip")
var bullet = preload("res://scenes/bullet.tscn")
var canShoot1 = true
var stopVelocity = true
func _process(_delta):
	arm.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("shoot1"):
		shoot1()
	if get_global_mouse_position() >= self.get_global_position():
		body.flip_h = false
		arm.flip_v = false
	else:
		body.flip_h = true
		arm.flip_v = true
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > maxVel:
			velocity.y = maxVel
		if velocity.y >= 0:
			body.animation = "default"
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		body.animation = "jump"
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
	move_and_slide()
	if stopVelocity == true:
		velocity.x = 0
func shoot1():
	if canShoot1:
		canShoot1 = false
		arm.animation = "shoot"
		var bulletInstance = bullet.instantiate()
		bulletInstance.position = tip.get_global_position()
		bulletInstance.rotation_degrees = arm.rotation_degrees
		get_tree().get_root().add_child(bulletInstance)
		await get_tree().create_timer(0.2).timeout
		arm.animation = "default"
		canShoot1 = true
