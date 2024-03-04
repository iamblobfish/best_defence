class_name Fireball extends Sprite2D

var target: Node2D
var speed = 450
var damage: int

func _process(delta):
	var path_vector = (target.global_position - global_position)
	var delta_pos = path_vector.normalized() * speed * delta
	if path_vector.length() < delta_pos.length():
		delta_pos = path_vector
	position = position + delta_pos
	if (target.global_position - global_position).length() < 4:
		target.take_damage(damage)
		queue_free()

func init(enemy_target: Node2D, dmg: int, init_position: Vector2):
	target = enemy_target
	damage = dmg
	global_position = init_position
