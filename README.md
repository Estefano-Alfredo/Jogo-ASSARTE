# Jogo-ASSARTE
Repositório destinado à organização e desenvolvimento do jogo para a matéria de Desenvolvimento de Software em parceria com a ASSARTE

O jogo deve tratar de temas de sustentabilidade, ter cunho educacional, com conteúdo adequado para os alunos da ASSARTE, deve-se levar em conta que os usuários finais do jogo tem deficiência intelectual.

## Stakeholders
    Profª Eliana
    ASSARTE

## Scrum Master
    Estéfano

## Dev Team
    Gabriel
    João P.
    Samuel
    Kassio
    Enzo Pimentel
    Estéfano

Ideia de jogo:

## Nome: 
Bio-Geometria

### Tema:
Perda da Biodiversidade

## Conteúdo: 
Geometria 

## Descrição:
A idéia é usar a geometria para o usuário interagir de forma mais direta com o jogo, arrastando formas, girando e combinando

##### - Fase 1: O Quebra-Cabeça da Biodiversidade

    **Foco**: Reconhecer a beleza e a unicidade das espécies.

    **Conceito Geométrico**: Composição de Formas, Rotação e Espelhamento.

    **Apresentação**: O narrador apresenta o tema de perda da biodiversidade, falando sobre espécies que estão sendo mais afetadas pelas práticas não sustentáveis
    
    **Gameplay**: 2 cenários onde o jogador deve recompor a imagem de um animal ou planta conhecidamente afetados por práticas não sustentáveis (abelhas, tartarugas marinhas, baleias) que foi fragmentada em peças geométricas. Para isso, ele precisa não apenas encaixar as peças, mas também rotacioná-las e espelhá-las para que se alinhem perfeitamente. (decidir quantos tipos de movimentação tornam a gameplay menos intuitiva para os usuários em questão). 
    Obs: Mostrar a sombra do animal para facilitar, peça e local onde ela encaixa podem piscar para ajudar se o jogador passar muito tempo sem progredir

    **Mensagem de Sustentabilidade**: Cada espécie é uma "peça" fundamental no grande "quebra-cabeça" da natureza. A perda de uma espécie é como perder uma peça, deixando o todo incompleto.

##### - Fase 2: As Formas do Habitat

    **Foco**: Construir e proteger os ambientes que sustentam a vida.

    **Conceito Geométrico**: Formas Básicas e Área.

    **Gameplay**: 2 cenários onde o jogador precisa construir o habitat das espécies da primeira fase. Ele deve resolver um jogo da memória, reforçando o conceito de que o espaço é crucial para a sobrevivência das espécies. Diferente da fase 1 onde o foco é criar uma figura nova do "zero", na fase 2 existe um plano de fundo, onde será necessário encontrar os pares, preenchendo assim a imagem do fundo. A opção de ajuda da fase 1 funciona bem aqui também. Os pares vão cobrir buracos em formas geométricos do fundo

    **Mensagem de Sustentabilidade**: Proteger os animais exige proteger também o seu lar. A lição é que a conservação é uma questão de espaço e de garantir que os habitats permaneçam completos e interligados.

#### Principais considerações de design 

- **Respeito etário / tom adulto:** evitar mascotes cartunescos excessivamente infantis; usar paleta sóbria, ilustrações estilizadas/realistas leves ou fotos-ilustradas; linguagem direta, frases curtas e respeitosas; vozes/adultas para narração.
    
- **Aprendizagem integrada:** ligar mecânicas do jogo a objetivos curriculares (Geométrico: Formas Básicas e Área. Biológico: Conscientização da faune e biodiversidade).
    
- **Acessibilidade universal (essencial):** ícones + texto + áudio para todas as ações; alternativas de controle (mouse/touch/teclado/single-switch); tempo ilimitado/configurável; reforço positivo não-punitivo; modo assistido.
    
- **Complexidade:** mecânicas únicas e repetitivas com progressão por metas simples (ex.: 3–5 tarefas por nível). Isso facilita memorização e previsão — importante para aprendizado e autonomia.
    
- **Contexto social e cultural:** usar cenários plausíveis para adultos (praça do bairro, feira, casa, associação comunitária) e/ou imagens do bairro local para maior identificação.

## Relatórios:
Feedback para os alunos vai ser apresentado na forma de tempo por fase, tempo total, pontos (por clique).
Feedback para os professores poderá conter tempo de gameplay, tempo por fase, número de ajudas, acertos/erros por forma geométrica, nome do aluno.

Vou tentar adicionar figuras amanhã, também podemos começar o product Backlog, e organizar já organizar sprints

## Product Backlog
Listas de passos necessários para entregar o projeto completo (será revisado posteriormente spós desenvolvimento inicial do projeto)

| Direcionado para: |                                                            Item do Product Backlog                                                            | Prioridade |
| :---------------: | :-------------------------------------------------------------------------------------------------------------------------------------------: | :--------: |
|    **USUÁRIO**    |                                                **ícones + texto + áudio** para todas as ações.                                                |     P1     |
| **DESENVOLVEDOR** |                   **mecânica central de arrastar, girar e combinar formas** para viabilizar a interação geométrica do jogo.                   |     P1     |
|    **USUÁRIO**    |               **arte de Fundo da Interface** e **Arte dos Botões** que utilizem uma paleta sóbria para respeitar o tom etário.                |     P1     |
|    **USUÁRIO**    |                **tela Inicial** com **botões clicáveis** (Novo Jogo, Configurações, Relatório, Tutorial) para navegar no jogo.                |     P1     |
|    **USUÁRIO**    | **Fase 1: O Quebra-Cabeça da Biodiversidade**, que utiliza a mecânica de geometria e tem progressão por metas simples (3–5 tarefas por nível) |     P1     |
|    **USUÁRIO**    |                      **Popup de Nome** ao iniciar o jogo para me identificar, permitindo o rastreamento dos relatórios.                       |     P1     |
|    **USUÁRIO**    |                          **Fase 2: As Formas do Habitat** para progredir no conteúdo de biodiversidade e geometria.                           |     P1     |
|  **PROFESSORA**   |                           **tela de Relatório (Arte da Tela de Relatório)** para visualizar o feedback dos alunos.                            |     P1     |
|    **USUÁRIO**    |                                  **Popup de Tutorial** para entender as mecânicas de jogo antes de começar.                                   |     P2     |
|    **USUÁRIO**    |     **cenários plausíveis para adultos** (praça, feira, casa) ou **imagens do bairro local** para maior identificação social e cultural.      |     P2     |
|    **USUÁRIO**    |             **tempo ilimitado/configurável** e **reforço positivo não-punitivo** para garantir autonomia e foco na aprendizagem.              |     P3     |
|  **PROFESSORA**   |   armazenar e exiba **dados de relatório detalhados**, incluindo tempo de _gameplay_, número de ajudas e acertos/erros por forma geométrica   |     P3     |
|    **USUÁRIO**    |             receber **feedback imediato** após a conclusão da fase, incluindo tempo por fase, tempo total e pontos (por clique).              |     P3     |
|    **USUÁRIO**    |                       **Modo Assistido** que oferece ajuda durante as tarefas para facilitar a memorização e previsão.                        |     P3     |

##### Interace
- arte do fundo interface
- arte dos botões interface
- arte tela de relatório
- desenvolvimento botões clicáveis (novo jogo, configurações, relatório, tutorial)
- popup de nome
- popup de tutorial

---
- Link formulário de qualidade: https://forms.gle/sCFY8iyRCS78nTPq7
