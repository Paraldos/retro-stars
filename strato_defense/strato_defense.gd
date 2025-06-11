extends CanvasLayer

@onready var main_gun_left: Node2D = %MainGunLeft
@onready var main_gun_middle: Node2D = %MainGunMiddle
@onready var main_gun_right: Node2D = %MainGunRight
@onready var attack_timer: Timer = %AttackTimer
@onready var spawnpoint_left: Marker2D = %SpawnpointLeft
@onready var spawnpoint_right: Marker2D = %SpawnpointRight
@onready var enemies_container: Node2D = %EnemiesContainer
var templates_for_enemies = [
	preload("res://strato_defense/enemies/enemy_template.tscn")
]

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
	var enemy_template = templates_for_enemies[randi() % templates_for_enemies.size()]
	var enemy = enemy_template.instantiate()
	enemy.spawn_pos_left = spawnpoint_left.global_position
	enemy.spawn_pos_right = spawnpoint_right.global_position
	enemies_container.add_child(enemy)
