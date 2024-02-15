import 'package:flutter/material.dart';

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Tic Tac Toe'),
          centerTitle: true,
        ),
        body: TicTacToeGame(),
      ),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  late List<List<String>> board;
  late String currentPlayer;
  late String winner;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    board = List.generate(3, (_) => List.filled(3, ''));
    currentPlayer = 'X';
    winner = '';
  }

  void checkWinner() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] &&
          board[i][1] == board[i][2] &&
          board[i][0] != '') {
        winner = board[i][0];
        break;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[0][i] == board[1][i] &&
          board[1][i] == board[2][i] &&
          board[0][i] != '') {
        winner = board[0][i];
        break;
      }
    }

    // Check diagonals
    if ((board[0][0] == board[1][1] &&
            board[1][1] == board[2][2] &&
            board[0][0] != '') ||
        (board[0][2] == board[1][1] &&
            board[1][1] == board[2][0] &&
            board[0][2] != '')) {
      winner = board[1][1];
    }

    // Check for a draw
    if (!board.any((row) => row.any((cell) => cell == '')) && winner == '') {
      winner = 'Draw';
    }
  }

  void makeMove(int row, int col) {
    if (board[row][col] == '' && winner == '') {
      setState(() {
        board[row][col] = currentPlayer;
        checkWinner();
        currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
      });
    }
  }

  Widget buildCell(int row, int col) {
    return GestureDetector(
      onTap: () => makeMove(row, col),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Center(
          child: Text(
            board[row][col],
            style: const TextStyle(fontSize: 36),
          ),
        ),
      ),
    );
  }

  Widget buildBoard() {
    List<Widget> rows = [];
    for (int i = 0; i < 3; i++) {
      List<Widget> cells = [];
      for (int j = 0; j < 3; j++) {
        cells.add(buildCell(i, j));
      }
      rows.add(Row(
        children: cells,
      ));
    }
    return Column(
      children: rows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (winner != '')
              Text(
                (winner == 'Draw') ? 'It\'s a Draw!' : '$winner wins!',
                style: const TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 20),
            buildBoard(),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black, // Set the background color
                onPrimary: Colors.white, // Set the text color
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(5.0), // Set button border radius
                ),
              ),
              onPressed: () {
                setState(() {
                  initializeGame();
                });
              },
              child: const Text(
                'Restart Game',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
