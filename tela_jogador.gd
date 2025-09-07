extends Node2D
@onready var nome_label: Label = $NomeLabel
@onready var score_label: Label = $ScoreLabel
@onready var chave_label: Label = $ChaveLabel
@onready var entrada_nome_line_edit: TextEdit = $EntradaNomeLineEdit
@onready var botao_aumentar_score: Button = $BotaoAumentarScore
@onready var confirmar: Button = $Confirmar
@onready var reset: Button = $Reset
@onready var best_pontuacao: Label = $Best_pontuacao


var best : int = 0
var nome : String = ""
var score : int = 0
var chave : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    nome_label.text = nome
    score_label.text ="Score: " + str(score)
    chave_label.text = "Sem Chave" 
    botao_aumentar_score.hide()
    reset.hide()
    


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass  
    




func _on_botao_aumentar_score_pressed() -> void:
    score += 1
    score_label.text = "Score: "+ str(score)
    if score > 10:
        chave_label.text = "Possui Chave"
    print("Foi") # Replace with function body.
    


func _on_confirmar_pressed() -> void:
    var novo_nome :String = ""
    if not entrada_nome_line_edit.text.is_empty():
        nome = entrada_nome_line_edit.text
        nome_label.text = nome
        entrada_nome_line_edit.hide()
        confirmar.hide()
        botao_aumentar_score.show()
        reset.show()
    

func _on_reset_pressed() -> void:
    nome_label.text = ""
    score_label.text ="Score: " + str(score)
    chave_label.text = "Sem Chave"
    entrada_nome_line_edit.text = ""
    entrada_nome_line_edit.placeholder_text = "Digite seu nome"
    
    botao_aumentar_score.hide()
    entrada_nome_line_edit.show()
    confirmar.show()
    if score > best:
        best = score
        best_pontuacao.text = "BEST Point: " + str(best)
        
    score = 0

    
