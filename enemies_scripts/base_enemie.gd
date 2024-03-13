class_name BaseEnemie
extends RigidBody2D

signal hp_changed(new_value)
signal killed

var hp: int
var damage: int
var speed: int
#var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
