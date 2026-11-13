extends CharacterBody2D
@export var dash_speed:=1000.0
@export var dash_duration:=0.5
@export var dash_cooldown:=3.0
@onready var sprite=$Sprite2D
var can_dash:=true
var is_dashing:=false
var is_invincible:=false
var dash_timer:=0.0
var cooldown_timer:=0.0
var dash_direction:=1
@export var speed: float=200.0
@export var jump_velocity: float =-680.0
@export var max_health:=5
var current_health
var gravity: float= ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	current_health=max_health
	

func _physics_process(delta: float) -> void:
	if not can_dash:
		cooldown_timer-=delta
		if cooldown_timer <=0:
			can_dash=true
	if is_dashing:
		velocity.x = dash_direction * dash_speed
		velocity.y = 0
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
			is_invincible = false
	else:
		if not is_on_floor():
			velocity.y +=gravity*delta
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y=jump_velocity
		if Input.is_action_just_pressed("Dash") and can_dash:
			start_dash()
		else:
			var direction := Input.get_axis("ui_left", "ui_right")
			if direction !=0:
				velocity.x=direction*speed
				sprite.flip_h=direction<0
			else:
				velocity.x= move_toward(velocity.x, 0, speed)
	move_and_slide()
	
func start_dash():
	can_dash=false
	is_dashing=true
	is_invincible=true
	dash_timer=dash_duration
	cooldown_timer=dash_cooldown
	
	var input_dir=Input.get_axis("ui_left", "ui_right")
	if input_dir !=0:
		dash_direction=int(input_dir)
	else:
		dash_direction=-1 if sprite.flip_h else 1
	flash()


func take_damage(amount):
	current_health -= amount
	print("Health:", current_health)
	if current_health <= 0:
		die()
func die():
	print("You died...")
	queue_free()	
	
func flash():
	sprite.modulate=Color(10,10,10,1)
	await get_tree().create_timer(0.05).timeout
	sprite.modulate=Color(1,1,1,1)
	
