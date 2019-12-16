Background bg;
GameUI ui;
MainMenu mainMenu;

PFont bumpItUp;

int sections = 6;
boolean evenSections;

int timer = 0;
int easyHighScore = 0;
int hardHighScore = 0;

int selectedDifficulty = 1;

int centerSize;
float playerSpeed = 0.14;
float obstacleSpeed = 8;
float obThickness = 60;
int waveGap = 8;
boolean waveInProgress = false;

boolean inMenu = true;
boolean inLevelSelect = false;
boolean inGame = false;
boolean gameOver = false;

boolean isLeft, isRight; // For arrow keys

void setup() {
  size(1200, 800);
  //fullScreen();

  bumpItUp = createFont("bump-it-up.ttf", 32);
  textFont(bumpItUp);
  fill(255);
  strokeWeight(7);
  stroke(200, 0, 0);

  mainMenu = new MainMenu();
}

void draw() {

  if (inMenu) {
    mainMenu.update();
    mainMenu.display();
  }

  if (gameOver) {
    gameOver = false;
    inGame = false;
    inMenu = true;
    mainMenu = new MainMenu();
  } else if (inGame) {
    drawGame();
  }
}


void loadGame(int difficulty) {

  if (difficulty == 1) {
    sections = 5;
  } else if (difficulty == 2) {
    sections = 6;
  }

  evenSections = sections % 2 == 0;

  waveInProgress = false;
  timer = 0;
  isLeft = false;
  isRight = false;

  bg = new Background();
  ui = new GameUI();

  inMenu = false;
  inLevelSelect = false;
  inGame = true;
}



void drawGame() {

  pushMatrix();
    translate(width/2, height/2);
  
    strokeWeight(7);
    stroke(200, 0, 0);
  
    bg.update();
    bg.display();
  
    float rand = random(1);
    if (rand < 0.002) {  
      float rotationSpeed = random(0.02, 0.05);
      rotationSpeed = -rotationSpeed;
      bg.updateRotationSpeed(rotationSpeed);
    } 
    else if (rand < 0.0025) {
      bg.doSpin();
    }
  popMatrix();

  // Display GameUI
  pushMatrix();
    ui.update();
    ui.display();
  popMatrix();
}

// KEYCODES
int space = 32;
int left = 37;
int right = 39;
int enter = 10;

void keyPressed() {
  if (inGame)
    setMove(keyCode, true);
}

void keyReleased() {
  if (inGame)
    setMove(keyCode, false);
  else if (inMenu && !inLevelSelect) {
    if (keyCode == enter || keyCode == space) {
      inLevelSelect = true;
    }
  } 
  else if (inMenu && inLevelSelect) {
    if (keyCode == left) {
      selectedDifficulty--;
      if (selectedDifficulty < 1) selectedDifficulty = 2;
    } 
    else if (keyCode == right) {
      selectedDifficulty++;
      if (selectedDifficulty > 2) selectedDifficulty = 1;
    } 
    else if (keyCode == enter || keyCode == space) {
      loadGame(selectedDifficulty);
    }
  }
}

boolean setMove(int k, boolean b) {
  switch (k) {
  case LEFT:
    return isLeft = b;

  case RIGHT:
    return isRight = b;

  default:
    return b;
  }
}
