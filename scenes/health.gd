extends Node
class_name Health

signal health_changed(target, current_health)
signal died(target)

@export var damageable: bool = true
@export var healable: bool = true
@export var invincible: bool = true
@export var max_health: float = 100.0:
	get: 
		return max_health
var current_health: float = 100.0:
	set(value):
		current_health = value
	get:
		return current_health

func _init():
	current_health = max_health

func _ready():
	pass

func _process(delta):
	pass
	
func _change_health(value:float):
	current_health = clamp(value, 0, max_health)
	emit_signal("health_changed", self, current_health)
	if current_health <= 0:
		emit_signal("died", self)

func take_damage(amount:float):
	if not damageable:
		return
	_change_health(current_health - amount)

func heal(amount:float):
	if not healable:
		return
	_change_health(current_health + amount)
	
func on_death():
	if invincible:
		return
	# handle death functionality here

func is_alive():
	return current_health > 0
