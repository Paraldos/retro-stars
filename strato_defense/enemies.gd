extends Node2D

@onready var enemies_container: Node2D = %EnemiesContainer
@onready var spawn_timer: Timer = %SpawnTimer
var enemies_spawned = 0
var templates_for_enemies = [
	preload("res://strato_defense/enemies/enemy_1.tscn"),
	preload("res://strato_defense/enemies/enemy_2.tscn"),
	preload("res://strato_defense/enemies/enemy_3.tscn"),
	preload("res://strato_defense/enemies/enemy_4.tscn"),
]

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
