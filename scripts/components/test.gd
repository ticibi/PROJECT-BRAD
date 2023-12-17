extends Node
class_name Test

@onready var target = get_parent()

func _input(event):
	if event is InputEventKey and event.pressed:
		print(event)
		match event.keycode:
			KEY_1:
				test_take_damage(10.0)
			KEY_2:
				test_heal(10.0)
			KEY_3:
				test_change_stamina(10.0)

func test_take_damage(amount:float):
	if target.has_node("HealthComponent"):
		target.get_node("HealthComponent").take_damage(amount)

func test_heal(amount:float):
	if target.has_node("HealthComponent"):
		target.get_node("HealthComponent").heal(amount)

func test_change_stamina(amount:float):
	if target.has_node("StaminaComponent"):
		target.get_node("StaminaComponent").deplete_stamina(amount)
