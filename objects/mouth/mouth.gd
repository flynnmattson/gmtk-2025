class_name Mouth extends Sprite3D


@export var stream: AudioStreamPlayer3D
@export var voice_controller: VoiceController
@export var scale_multiplier: float = 1.5
@export var magnitude_threshold: float = 0.015

var spectrum_analyzer_instance: AudioEffectSpectrumAnalyzerInstance


func _ready() -> void:
	if not stream == null:
		_setup_instance(stream)
	if not voice_controller == null:
		_setup_instance(voice_controller.audio_stream_player_3d)


func _process(delta: float) -> void:
	if not spectrum_analyzer_instance == null:
		var magnitude = spectrum_analyzer_instance.get_magnitude_for_frequency_range(20, 20000, AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_MAX)
		var total_magnitude: float = magnitude.x + magnitude.y
		if total_magnitude < magnitude_threshold:
			scale.y = 0
		else:
			scale.y = total_magnitude * scale_multiplier


func _setup_instance(s: AudioStreamPlayer3D) -> void:
	var bus_index = AudioServer.get_bus_index(s.bus)
	spectrum_analyzer_instance = AudioServer.get_bus_effect_instance(bus_index, 0)
