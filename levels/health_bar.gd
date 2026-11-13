extends ProgressBar
@export var player_path: NodePath
var player
func _ready():
	player=get_node(player_path)
	max_value=player.max_health
	value=player.current_health
func _process(delta):
	if player:
		value=player.current_health
