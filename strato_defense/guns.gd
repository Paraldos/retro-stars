extends Node2D

@onready var attack_timer: Timer = %AttackTimer
@onready var main_gun_left: Node2D = %MainGunLeft
@onready var main_gun_middle: Node2D = %MainGunMiddle
@onready var main_gun_right: Node2D = %MainGunRight

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("up"):
		_attack()

func _attack():
	if !attack_timer.is_stopped(): return
	if Input.is_action_pressed("up"):
		main_gun_middle._attack()
	elif Input.is_action_pressed("left"):
		main_gun_left._attack()
	elif Input.is_action_pressed("right"):
		main_gun_right._attack()
	attack_timer.start()
