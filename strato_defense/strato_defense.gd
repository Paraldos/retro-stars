extends CanvasLayer

@onready var main_gun_left: Node2D = %MainGunLeft
@onready var main_gun_middle: Node2D = %MainGunMiddle
@onready var main_gun_right: Node2D = %MainGunRight
@onready var attack_timer: Timer = %AttackTimer
@onready var enemies_container: Node2D = %EnemiesContainer
@onready var spawn_timer: Timer = %SpawnTimer
var templates_for_enemies = [
	preload("res://strato_defense/enemies/enemy_template.tscn")
]
var enemies_spawned = 0

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

func _on_spawn_timer_timeout() -> void:
	if enemies_spawned == 9:
		enemies_spawned = 0
		if spawn_timer.wait_time >= 2.0:
			spawn_timer.wait_time -= 0.2
	enemies_spawned += 1
	var enemy_template = templates_for_enemies[randi() % templates_for_enemies.size()]
	var enemy = enemy_template.instantiate()
	enemy.time_to_cross_row = spawn_timer.wait_time -0.5
	enemies_container.add_child(enemy)
