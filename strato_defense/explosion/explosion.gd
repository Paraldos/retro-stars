extends CPUParticles2D

@onready var sound_effects = [
	%Sound1,
	%Sound2
]
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	_start_particles()
	_start_sound()

func _start_particles():
	restart()
	one_shot = true

func _start_sound():
	var effect_number = rng.randi_range(0, sound_effects.size()-1)
	sound_effects[effect_number].pitch_scale = rng.randf_range(0.95, 1.05)
	sound_effects[effect_number].play()

func _on_finished() -> void:
	queue_free()
