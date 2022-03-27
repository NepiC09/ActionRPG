extends KinematicBody2D

#предзагружаем один раз навсегда
const EnemyDeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

#характеристики
export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200
export var WANDER_TARGET_RANGE = 5

func _ready():
	state = pick_random_state([IDLE, WANDER])
	animationPlayer.play("Stop")

#состояния
enum {
	IDLE,
	WANDER,
	CHASE
}

var state = CHASE

#движение
var velocity = Vector2.ZERO

#вектор отталкивания 
var knockback = Vector2.ZERO

#переменная нода статистики 
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var sprite = $AnimatedSprite
onready var hurtbox = $Hurtbox 
onready var softCollision = $SoftCollision
onready var wanderController = $WanderController
onready var animationPlayer = $AnimationPlayer

#задаём движение оттакливания
func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, FRICTION * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION*delta)
			seek_player()
			
			if wanderController.get_time_left() == 0:
				update_wander()
			
		WANDER:
			seek_player()
			
			if wanderController.get_time_left() == 0:
				update_wander()
			
			accelerate_towards_point(wanderController.target_position, delta)
			
			if global_position.distance_to(wanderController.target_position) <= WANDER_TARGET_RANGE:
				update_wander()
			 
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE
	
	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)


func update_wander():
	 state = pick_random_state([IDLE, WANDER])
	 wanderController.start_wander_timer(rand_range(1,3))


func accelerate_towards_point(point, delta):
	var direction  = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0


func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE


func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()


#сюда входит какая-то Area2D
func _on_Hurtbox_area_entered(area):
	#берём значение damage из area и вычитаем здоровье
	stats.health -= area.damage
	#мы берём значение knockback_vector (которая прописана у "арены" меча)
	knockback = area.knockback_vector * 120
	hurtbox.create_hit_effect()
	hurtbox.start_invincibility(0.4)


#написанный нами сигнал
func _on_Stats_no_health():
	#удаляем объект
	queue_free()
	#получаем данные сцены эффекта
	var enemyDeathEffect = EnemyDeathEffect.instance()
	#добавляем родителю ребёнка - эффект
	get_parent().add_child(enemyDeathEffect)
	#на всякий случай
	enemyDeathEffect.global_position = global_position


func _on_Hurtbox_invincibility_started():
	animationPlayer.play("Start")


func _on_Hurtbox_invincibility_ended():
	animationPlayer.play("Stop")
