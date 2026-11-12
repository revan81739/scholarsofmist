extends Area2D
@export var speed := 350.0
var direction =Vector2.ZERO
func _physics_process(delta):
	position += direction*speed*delta
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
