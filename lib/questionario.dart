import 'package:flutter/material.dart';
import './questao.dart';
import './resposta.dart';

class Questionario extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final void Function(int) quandoResponder;

  //Esses componentes são obrigatórios para serem passados
  //@required

  Questionario({
    required this.perguntas,
    required this.perguntaSelecionada,
    required this.quandoResponder,
  });

  //Tem pergunta selecionada, caso não tenha ele não mostra a pergunta
  bool get temPerguntaSelecionada {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    //Abordagem mais declarativas
    List<Map<String, Object>> respostas = temPerguntaSelecionada
        ? perguntas[perguntaSelecionada].cast()['respostas']
            as List<Map<String, Object>>
        : [];
    return Column(
      children: <Widget>[
        //Parametro posicional que ira receber
        //a pergunta selecionada
        Questao(perguntas[perguntaSelecionada]['texto'].toString()),
        //Peguei minhas respostas que é uma lista de string, usei o map
        //para converter uma lista de strings em uma lista de widgets.
        //Usei o ispred para ele pegar cada elementos da lista colocar da
        //lista que tenho aqui, que são filhos do elemento column
        ...respostas.map((resp) {
          return Resposta(
            resp['texto'].toString(),
            () => quandoResponder(int.parse(resp['pontuacao'].toString())),
          );
        }).toList(),
      ],
    );
  }
}
