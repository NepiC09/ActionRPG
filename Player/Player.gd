extends KinematicBody2D


#так записываются состояния
enum{
	MOVE,
	ROLL,
	ATTACK
}


#сделано, чтобы вызывать звук ранения и не привязывать его к игроку
#т.к. иначе, если игрок умрёт, то звук прервётся 
const PlayerHurtSound = preload("res://Player/PlayerHurtSound.tscn")


#переменная состояния
var state = MOVE
#вектор для roll (помнит направление игрока)
var roll_vector = Vector2.DOWN
#вектор изменения положения
var velocity = Vector2.ZERO
#PlayerStats наш глобальный объект
var stats = PlayerStats


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
onready var hurtbox = $Hurtbox #бокс получения урона
onready var blinkAnimationPlayer =$BlinkAnimationPlayer #блинки при получении урона

signal sq
#вызывается при готовности объекта
func _ready():
	#Мы говорим что произойдёт, над кем и при каком сигнале (сигнал есть в PlayerStats 
	stats.connect("no_health", self, "queue_free")
	animationTree.active = true #активируем анимации
	collisionShape.disabled = true #отключаем коллизии  
	swordHitbox.knockback_vector = roll_vector #задаём первоначальное значение
	blinkAnimationPlayer.play("Stop") #блинки при получении урона - по дефолту не играет
	
	#присваиваем игроку коориддинаты из сохранения
	global_transform.origin.x = stats.player_position_x 
	global_transform.origin.y = stats.player_position_y
	
	#если сохранилось с 0 хп и мы нажали продолжить
	#чтобы он не создавался 0 хп
	if(stats.health <= 0):
		pass
		#queue_free()
		#ff()
		
func ff():
	var option_menu = load("res://Смерть КЛ.tscn").instance()
	add_child(option_menu)
	print(get_node("Смерть КЛ").name)
	get_node("Смерть КЛ").connect("s1", self, "queue_free")

func CloseOptionalMenu():
	get_node("Настрйоки").queue_free()
	
	
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


#Установка направления персонажа 
func set_direction(input_vector):
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)


#функция движения
func move_state(delta):
	#получаемый вектор из кнопок
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	#для адекватного диагонального движения
	input_vector = input_vector.normalized()
	
	#если мы движемся
	if input_vector != Vector2.ZERO:
		#запоминаем направление персонажа
		roll_vector = input_vector
		#задаём направление "толкания/удара"
		swordHitbox.knockback_vector = input_vector
		#задаём "направление" анимаций в дереве
		set_direction(input_vector)
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
		
	#print("КОРДЫ ИЗ МУВ СТЕЙТ: ",position.x,"  ",position.y )


#функция если нажата attack
func attack_state():
	#останавливаем игрока
	velocity = Vector2.ZERO
	#включаем анимацию
	animationState.travel("Attack")


#функция если нажат roll
func roll_state():
	#включаем неуязвимость
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
		set_direction(input_vector)
		animationState.travel("Attack")
		hurtbox.collisionShape.set_deferred("disabled", false)
		state = ATTACK


#Движение задаётся через вектор положения и функцию move_and_slide (slide-для нормально прохождения через коллизии)
func move():
		velocity = move_and_slide(velocity)


#когда заканчивается анимация Roll в AnimationTree, то переводится состояние на движение 
func roll_animation_finished():
	hurtbox.collisionShape.set_deferred("disabled", false) #включаем получение урона
	state = MOVE


#когда заканчивается анимация Attack в AnimationTree, то переводится состояние на движение 
func attack_animation_finished():
	state = MOVE


#если персонажа ударили
func _on_Hurtbox_area_entered(_area):
	stats.health -= _area.damage #отнимается хп, указанное в хитбоксе врага
	hurtbox.start_invincibility(1) #начать неуязвимость
	hurtbox.create_hit_effect() #создать эффект получения урона
	#создаём объект со звуком, у которого автоплей и самостоятельное удаление
	var playerHurtSound = PlayerHurtSound.instance() #получаем "префабы" звука урона
	get_tree().current_scene.add_child(playerHurtSound) #загружаем на сцену
	if stats.health < 1:
		emit_signal("sq")


#если началась неуязвимость - начать блинкование
func _on_Hurtbox_invincibility_started():
	blinkAnimationPlayer.play("Start")

#когла закончилось - закончить блинкование
func _on_Hurtbox_invincibility_ended():
	blinkAnimationPlayer.play("Stop")


#Функция добавления хп
func AddHealth():
	stats.health +=1

#Иван это написал, я хз
func get_save_stats():
	return {
		'filename' : get_filename(),
		'parent' : get_parent().get_path(),
		'x_pos' : position.x,
		'y_pos' : position.y,
		'hp' : stats.health
	}
