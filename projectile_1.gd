extends Area2D
@export var speed := 350.0
@export var damage :=1

var direction =Vector2.ZERO
func _physics_process(delta):
	position += direction * speed* delta

func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
