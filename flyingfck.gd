extends CharacterBody2D

@export var move_speed:=100.0
const PROJECTILE =preload("res://projectile1.tscn")
@onready var player =get_tree().get_first_node_in_group("player")
@onready var shoot_timer= $Timer
@onready var spawn= $ProjectileSpawn
@onready var sprite= $Sprite2D

func _physics_process(_delta):
	if player:
		var direction =(player.global_position - global_position).normalized()
		var distance=global_position.distance_to(player.global_position)
		if distance > 250:
			velocity=velocity.lerp(direction*move_speed, 0.05)
		else:
			velocity=Vector2.ZERO
		sprite.flip_h =direction.x <0
	else:
		velocity= Vector2.ZERO
	move_and_slide()
func _on_timer_timeout():
	if player==null:
		return
	var projectile =PROJECTILE.instantiate()
	get_tree().current_scene.add_child(projectile)
	projectile.global_position= spawn.global_position
	projectile.direction=(player.global_position-spawn.global_position).normalized()
