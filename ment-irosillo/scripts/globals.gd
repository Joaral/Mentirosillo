extends Node


var coins:int = 0
var health:int = 10
var music_player: AudioStreamPlayer
var username:String = ""

var countdown: int = 60

func _ready():
	music_player = AudioStreamPlayer.new()
	add_child(music_player)
	
	music_player.stream = load("res://audio/background_music.ogg")
	music_player.autoplay = true
	music_player.play()
