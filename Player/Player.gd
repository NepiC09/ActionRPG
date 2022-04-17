extends KinematicBody2D

#так записываются состояния
enum{
	MOVE,
	ROLL,
	ATTACK
}

const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")

#переменная состояния
var state = MOVE
#вектор для roll (помнит направление игрока)
var roll_vector = Vector2.DOWN
#вектор изменения положения
var velocity = Vector2.ZERO
#PlayerStats наш глобальный объект
var stats = PlayerStats

#var input_vector = Vector2.ZERO
#onready var input_vector = get_node("/root/FS").input_vectorG


#константы передвижения
export var ACCELERATION = 600
export var MAX_SPEED = 80
export var FRICTION = 600
export var ROLL_SPEED = 125

#эти переменные работают, когда могут принять какое-то значение
onready var animationPlayer = $AnimationPlayer #Анимация игрока
onready var animationTree = $AnimationTree #дерево анимаций
onready var animationState = animationTree.get("parameters/playback") #для переключения анимаций
onready var collisionShape = $HitboxPivot/SwordHibox/CollisionShape2D #коллизия меча
onready var swordHitbox = $HitboxPivot/SwordHibox #хитбокс меча
onready var hurtbox = $Hurtbox
onready var blinkAnimationPlayer =$BlinkAnimationPlayer

#вызывается при готовности объекта
func _ready():
	#Мы говорим что произойдёт, над кем и при каком сигнале (сигнал есть в PlayerStats 
	stats.connect("no_health", self, "queue_free")
	animationTree.active = true #активируем анимации
	collisionShape.disabled = true #отключаем коллизии  
	swordHitbox.knockback_vector = roll_vector #задаём первоначальное значение
	blinkAnimationPlayer.play("Stop")
	animationPlayer.playback_speed = 2

#функция которая вызывается каждый фрейм
func _physics_process(delta):
	#переключение состояний
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state()
		ATTACK:
			attack_state()

#функция движения
func move_state(delta):
	#получаемый вектор из кнопок
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	#print(input_vector.x, " ", input_vector.y)
	#для адекватного диагонального движения
	input_vector = input_vector.normalized()
	
	#если мы движемся
	if input_vector != Vector2.ZERO:
		#запоминаем направление персонажа
		roll_vector = input_vector
		#задаём направление "толкания/удара"
		swordHitbox.knockback_vector = input_vector
		#задаём "направление" анимаций в дереве
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		#переключаем анимацию
		animationState.travel("Run")
		#равномерно увеличиваем вектор изменения положения
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta )
	else:
		#если не движемся
		#включаем анимацию "стояния"
		animationState.travel("Idle")
		#замедляемся равномерно
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	#актвируем функцию движения
	move()
	
	#если нажато действие attack - переключаем состояние на ATTACK
	if Input.is_action_just_pressed("attack"):
		state = ATTACK
	#если нажато действие roll - переключаем состояние на ROLL
	if Input.is_action_just_pressed("roll"):
		state = ROLL
		
	print("КОРДЫ ИЗ МУВ СТЕЙТ: ",global_transform.origin.x,"  ",global_transform.origin.y )

#функция если нажата attack
func attack_state():
	#останавливаем игрока
	velocity = Vector2.ZERO
	#включаем анимацию
	animationState.travel("Attack")

#функция если нажат roll
func roll_state():
	hurtbox.collisionShape.set_deferred("disabled", true)
	#задаём вектор изменения положения через roll_vector
	velocity = roll_vector * ROLL_SPEED
	#методя travel переключает анимацию в AnimationTree
	animationState.travel("Roll")
	#катимся
	move()
#	#Это на случай прерывания анимации Roll
	if Input.is_action_just_pressed("attack"):
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		input_vector = input_vector.normalized()
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Attack")
		hurtbox.collisionShape.set_deferred("disabled", false)
		state = ATTACK

#Движение задаётся через вектор положения и функцию move_and_slide (slide-для нормально прохождения через коллизии)
func move():
		velocity = move_and_slide(velocity)

#когда заканчивается анимация Roll в AnimationTree, то переводится состояние на движение 
func roll_animation_finished():
	hurtbox.collisionShape.set_deferred("disabled", false)
	state = MOVE

#когда заканчивается анимация Attack в AnimationTree, то переводится состояние на движение 
func attack_animation_finished():
	state = MOVE

func _on_Hurtbox_area_entered(_area):
	stats.health -= _area.damage
	hurtbox.start_invincibility(1)
	hurtbox.create_hit_effect()
	var playerHurtSound = PlayerHurtSound.instance()
	get_tree().current_scene.add_child(playerHurtSound)


func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")

func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")
	

func AddHealth():
	stats.health +=1

func get_save_stats():
	print("КОРДЫ ИЗ ГЕТ СЕЙВА: ",global_transform.origin.x,"  ",global_transform.origin.y )
	return {
		"filename" : get_filename(),
		"x_pos" : global_transform.origin.x,
		"y_pos" : global_transform.origin.y,

}
