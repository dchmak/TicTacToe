final color BACKGROUND_COLOR = color(255, 255, 255);
final color GRID_COLOR = color(0, 0, 0);
final color X_COLOR = color(255, 100, 100);
final color O_COLOR = color(100, 100, 255);

final int WIDTH = 800;
final int HEIGHT = 800;
final int LINE_SPACING = min(WIDTH, HEIGHT) / 5;
final int TB_MARGIN = (HEIGHT - 3 * LINE_SPACING) / 2;
final int LR_MARGIN = (WIDTH - 3 * LINE_SPACING) / 2;
final int GRID_STROKE = 5;
final int OX_SIZE = 60;
final int ANNOUNCE_SIZE = 30;
final int SCORE_SIZE = 20;
final int WIN_ALPHA = 50;

final int EMPTY = -1;
final int X = 0;
final int O = 1;


int board[][] = new int[3][3];
int turn = 0;
int Oscore = 0;
int Xscore = 0;

boolean gameDone = false;

void reset() {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      board[i][j] = EMPTY;
    }
  }

  turn = 0;
  gameDone = false;
}

void displayGrid() {
  // display grid
  // rect(LR_MARGIN, TB_MARGIN, 3 * LINE_SPACING, 3 * LINE_SPACING);
  stroke(GRID_COLOR);
  strokeWeight(GRID_STROKE);
  for (int i = 0; i < 2; i++) {
    line(LR_MARGIN, TB_MARGIN + LINE_SPACING * (i + 1), 
      WIDTH - LR_MARGIN, TB_MARGIN + LINE_SPACING * (i + 1));
  }
  for (int i = 0; i < 2; i++) {
    line(LR_MARGIN + LINE_SPACING * (i + 1), TB_MARGIN, 
      LR_MARGIN + LINE_SPACING * (i + 1), HEIGHT - TB_MARGIN);
  }
}

void displayOX() {
  // display Os, Xs
  textSize(OX_SIZE);
  for (int y = 0; y < 3; y++) {
    for (int x = 0; x < 3; x++) {
      if (board[x][y] == O) {
        fill(O_COLOR);
        text("O", LR_MARGIN + LINE_SPACING * x, TB_MARGIN + LINE_SPACING * y, 
          LINE_SPACING, LINE_SPACING);
      }
      if (board[x][y] == X) {
        fill(X_COLOR);
        text("X", LR_MARGIN + LINE_SPACING * x, TB_MARGIN + LINE_SPACING * y, 
          LINE_SPACING, LINE_SPACING);
      }
    }
  }
}

void displayScore() {
  fill(O_COLOR);
  textSize(SCORE_SIZE);
  String OscoreText = "O's score: " + Oscore;
  text(OscoreText, 0, TB_MARGIN * 2, LR_MARGIN, TB_MARGIN);

  fill(X_COLOR);
  textSize(SCORE_SIZE);
  String XscoreText = "X's score: " + Xscore;
  text(XscoreText, WIDTH - LR_MARGIN, TB_MARGIN * 2, LR_MARGIN, TB_MARGIN);
}

int checkWin() {
  // horizontal check
  stroke(GRID_COLOR, WIN_ALPHA);

  for (int y = 0; y < 3; y++) {
    if (board[0][y] == O && board[1][y] == O && board[2][y] == O) {
      line(LR_MARGIN, TB_MARGIN + (y + 0.5) * LINE_SPACING, 
        WIDTH - LR_MARGIN, TB_MARGIN + (y + 0.5) * LINE_SPACING);
      return O;
    }
    if (board[0][y] == X && board[1][y] == X && board[2][y] == X) {
      line(LR_MARGIN, TB_MARGIN + (y + 0.5) * LINE_SPACING, 
        WIDTH - LR_MARGIN, TB_MARGIN + (y + 0.5) * LINE_SPACING);
      return X;
    }
  }

  // vertical check
  for (int x = 0; x < 3; x++) {
    if (board[x][0] == O && board[x][1] == O && board[x][2] == O) {
      line(LR_MARGIN + (x + 0.5) * LINE_SPACING, TB_MARGIN, 
        LR_MARGIN + (x + 0.5) * LINE_SPACING, HEIGHT - TB_MARGIN);
      return O;
    }
    if (board[x][0] == X && board[x][1] == X && board[x][2] == X) {
      line(LR_MARGIN + (x + 0.5) * LINE_SPACING, TB_MARGIN, 
        LR_MARGIN + (x + 0.5) * LINE_SPACING, HEIGHT - TB_MARGIN);
      return X;
    }
  }

  // diagonal 1 check
  if (board[0][0] == O && board[1][1] == O && board[2][2] == O) {
    line(LR_MARGIN, TB_MARGIN, WIDTH - LR_MARGIN, HEIGHT - TB_MARGIN);
    return O;
  }
  if (board[0][0] == X && board[1][1] == X && board[2][2] == X) {
    line(LR_MARGIN, TB_MARGIN, WIDTH - LR_MARGIN, HEIGHT - TB_MARGIN);
    return X;
  }

  // diagonal 2 check
  if (board[0][2] == O && board[1][1] == O && board[2][0] == O) {
    line(LR_MARGIN, HEIGHT - TB_MARGIN, WIDTH - LR_MARGIN, TB_MARGIN);
    return O;
  }
  if (board[0][2] == X && board[1][1] == X && board[2][0] == X) {
    line(LR_MARGIN, HEIGHT - TB_MARGIN, WIDTH - LR_MARGIN, TB_MARGIN);
    return X;
  }

  return EMPTY;
}

void announce() {
  // annoucements and check for winner
  textSize(ANNOUNCE_SIZE);
  if (turn == 9 || checkWin() != EMPTY) { // game done
    if (checkWin() == O) {
      // println("O wins");
      fill(O_COLOR);
      text("O wins", LR_MARGIN, 0, 3 * LINE_SPACING, TB_MARGIN);
      Oscore++;
    } else if (checkWin() == X) {
      // println("X wins");
      fill(X_COLOR);
      text("X wins", LR_MARGIN, 0, 3 * LINE_SPACING, TB_MARGIN);
      Xscore++;
    } else {
      text("Draw", LR_MARGIN, 0, 3 * LINE_SPACING, TB_MARGIN);
    }
    text("Press R to reset, Press Esc to exit", LR_MARGIN / 2, HEIGHT - TB_MARGIN, 
      3 * LINE_SPACING + LR_MARGIN, TB_MARGIN);

    gameDone = true;
  } else {
    if (turn % 2 == O) {
      fill(O_COLOR);
      text("O's turn", LR_MARGIN, 0, 3 * LINE_SPACING, TB_MARGIN);
    }
    if (turn % 2 == X) {
      fill(X_COLOR);
      text("X's turn", LR_MARGIN, 0, 3 * LINE_SPACING, TB_MARGIN);
    }
  }
}


void settings() {
  size(WIDTH, HEIGHT);
}

void setup() {
  textAlign(CENTER, CENTER);

  reset();
}

void draw() {
  background(BACKGROUND_COLOR);
  announce();
  displayGrid();
  displayOX();
  displayScore();

  if (gameDone) {
    noLoop();
  }
}

void mousePressed() {
  // print(mouseX, mouseY);
  if (mouseX > LR_MARGIN && mouseX < WIDTH - LR_MARGIN &&
    mouseY > TB_MARGIN && mouseY < HEIGHT - TB_MARGIN) {
    int ix = (mouseX - LR_MARGIN) / LINE_SPACING;
    int iy = (mouseY - TB_MARGIN) / LINE_SPACING; 
    // print(ix, iy);

    if (board[ix][iy] == EMPTY) {
      if (turn % 2 == O) {
        board[ix][iy] = O;
      }
      if (turn % 2 == X) {
        board[ix][iy] = X;
      }

      turn += 1;
    }
  }
}

void keyPressed() {
  loop();

  if (gameDone) {
    if (key == 'r' || key == 'R') {
      reset();
    }
  }
  
  if (key == 's' || key == 'S') {
    saveFrame("screenshot-###.jpg");
  }
}
