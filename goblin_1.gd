extends CharacterBody2D
@export var move_speed :=80.0
@export var gravity := 1200.0

const PROJECTILE =preload("res://projectile1.tscn")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var shoot_timer=$Timer
@onready var spawn=$ProjectileSpawn
@onready var sprite=$Sprite2D

func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y +=gravity* delta
	if player:
		var direction=sign(player.global_position.x-global_position.x)
		velocity.x=direction*move_speed
		sprite.flip_h=direction<0
	move_and_slide()
func _on_timer_timeout():
	if player==null:
		return
	var blob= PROJECTILE.instantiate()
	get_tree().current_scene.add_child(blob)
	blob.global_position= spawn.global_position
	blob.direction=(player.global_position - spawn.global_position).normalized()
