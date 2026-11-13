extends CharacterBody2D
@export var speed: float=200.0
@export var jump_velocity: float =-400.0
@export var max_health:=5
var current_health
var gravity: float= ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	current_health=max_health
	

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y +=gravity*delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y=jump_velocity
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x=direction*speed
	else:
		velocity.x= move_toward(velocity.x, 0, speed)
	move_and_slide()
func take_damage(amount):
	current_health -= amount
	print("Health:", current_health)
	if current_health <= 0:
		die()
func die():
	print("You died...")
	queue_free()	
	
