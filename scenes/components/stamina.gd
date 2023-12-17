extends Node
class_name Stamina

signal stamina_changed(target, current_stamina)

@export var infinite_stamina: bool = true
@export var regen_rate: float =  10.0 # amount per second
@export var max_stamina: float = 100.0:
	get:
		return max_stamina
var current_stamina: float = 100.0:
	set(value):
		_set_stamina(value)
	get:
		return current_stamina
var is_regenerating: bool = false

func _init():
	_set_stamina(max_stamina)

func _set_stamina(value:float):
	current_stamina = clamp(current_stamina, 0, max_stamina)

func _change_stamina(value:float):
	_set_stamina(value)
	emit_signal("stamina_changed", self, current_stamina)

func _process(delta):
	if not is_regenerating:
		return
	regenerate_stamina(delta)

func deplete_stamina(amount:float):
	_change_stamina(current_stamina - amount)

func regenerate_stamina(delta):
	_change_stamina(current_stamina + regen_rate * delta)
