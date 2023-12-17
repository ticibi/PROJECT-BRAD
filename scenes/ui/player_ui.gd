extends Control

@onready var health_bar: TextureProgressBar = $HBoxContainer/HealthBar
@onready var stamina_bar: TextureProgressBar = $HBoxContainer/StaminaBar
@onready var health_label: Label = $HBoxContainer/HealthBar/HealthLabel
@onready var stamina_label: Label = $HBoxContainer/StaminaBar/StaminaLabel

func _ready():
	var player = get_parent()
	if player.has_node("HealthComponent"):
		player.get_node("HealthComponent").connect("health_changed", Callable(self, "_on_health_changed"))
	if player.has_node("StaminaComponent"):
		print("we got the node")
		player.get_node("StaminaComponent").connect("stamina_changed", Callable(self, "on_stamina_changed"))

func _on_health_changed(target, value:float):
	interpolate_progress_bar(health_bar, value)
	health_label.text = "health: %s" % value
	$AnimationPlayer.play("HealthFlash")

func on_stamina_changed(target, value:float):
	interpolate_progress_bar(stamina_bar, value)
	stamina_label.text = "stamina: %s" % value
	$AnimationPlayer.play("StaminaFlash")

func interpolate_progress_bar(pbar:TextureProgressBar, new_value:float, duration:float=0.5):
	var current_value = pbar.value
	pbar.value = new_value
	#var tween = create_tween()
	#tween.interpolate_value(current_value, new_value-current_value, duration, duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
