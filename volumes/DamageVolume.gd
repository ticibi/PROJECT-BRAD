extends Area3D

@export var text: String = "take damage"

@export var damage_amount: float = 10.0
@export var damage_interval: float = 0.0
var objects_in_area = [] # this will be a list of health components

func _ready():
	connect("area_entered", Callable(self, "_on_body_entered"))
	connect("area_exited", Callable(self, "_on_body_exited"))
	$Label3D.text = text

func _on_body_entered(body):
	print("body entered")
	if body.has_node("HealthComponent"):
		body.get_node("HealthComponent").take_damage(damage_amount)

func _on_body_exited(body):
	if objects_in_area.has(body):
		objects_in_area.erase(body)

func _process(delta):
	for body in objects_in_area:
		objects_in_area[body] -= delta
		if objects_in_area[body] <= 0.0:
			body.take_damage(damage_amount)
			objects_in_area[body] = damage_interval
