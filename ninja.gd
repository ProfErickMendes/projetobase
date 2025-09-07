extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_force: float = -400.0

var is_attacking: bool = false

@onready var anim: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var attack_sound: AudioStreamPlayer = $AttackSound
@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var walk_sound: AudioStreamPlayer = $WalkSound
  


func _physics_process(delta: float) -> void:
    var input_dir = Input.get_axis("ui_left", "ui_right")
    velocity.x = input_dir * speed

    # PULO
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = jump_force
        anim.play("jump")
        jump_sound.stop()
        jump_sound.play()

    # ATAQUE
    if Input.is_action_just_pressed("attack") and not is_attacking:
        is_attacking = true
        anim.play("ataque")
        attack_sound.stop()
        attack_sound.play()

    # MOVIMENTO + ANIMAÇÕES
    if is_on_floor():
        if input_dir != 0:
            sprite.flip_h = input_dir < 0
            if not is_attacking:  # se não está atacando
                anim.play("walk")
            if not walk_sound.playing:
                walk_sound.play()
        else:
            if not is_attacking:
                anim.play("idle")
            walk_sound.stop()
    else:
        if not is_attacking:
            anim.play("jump")

    # Gravidade
    if not is_on_floor():
        velocity.y += 900 * delta

    move_and_slide()


# Callback quando a animação termina
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
    if anim_name == "ataque":
        is_attacking = false
