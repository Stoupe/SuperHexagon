class MainMenu {

  float angle = 0;
  ArrayList<Integer> menuCols;

  MainMenu() {

    menuCols = new ArrayList<Integer>();

    for (int i = 0; i < 6; i ++) {
      if (i % 2 == 0) {
        menuCols.add(color(60, 10, 10));
      } 
      else {
        menuCols.add(color(50, 10, 10));
      }
    }
    
  }

  void update() {
    angle -= 0.005;
  }

  void display() {

    background(0);

    pushMatrix();
    
      translate(width/2, height * 1.1);
      rotate(angle);
  
      for (int i = 6; i > 0; i--) {
        fill(menuCols.get(i-1));
        arc(0, 0, height*3, height*3, TWO_PI/6.0*(i-1), TWO_PI/6.0*i);
      }
      
    popMatrix();

    // SUPER HEXAGON TITLE TEXT
    String titleSuper = "SUPER";
    String titleHexagon = "HEXAGON";


    // SUPER
    textSize(120);
    // Black Shadow (x+1,y+1) to give text some edge/contrast
    fill(color(0, 0, 0, 150));
    text(titleSuper, width/2.0 - textWidth(titleSuper)/2.0 + 1, height/2.0 - 100 + 1);
    // Text
    fill(color(200, 10, 10, 200));
    text(titleSuper, width/2.0 - textWidth(titleSuper)/2.0, height/2.0 - 100);


    // HEXAGON
    textSize(75);
    fill(color(0, 0, 0, 150));
    text(titleHexagon, width/2.0 - textWidth(titleHexagon)/2.0 + 90 + 1, height/2.0 - 10 + 1);
    fill(color(200, 10, 10, 200));
    text(titleHexagon, width/2.0 - textWidth(titleHexagon)/2.0 + 90, height/2.0 - 10);


    // HIGHSCORES
    fill(color(255, 80, 80));
    textSize(24);
    String ls = "         LAST SCORE:  " + timer + " SECONDS";
    text(ls, width/2.0 - textWidth(ls) / 2.0, height/2.0 + 70);
    String ehs = "EASY HIGHSCORE:  " + easyHighScore + " SECONDS";
    text(ehs, width/2.0 - textWidth(ehs) / 2.0, height/2.0 + 110);
    String hhs = "HARD HIGHSCORE:  " + hardHighScore + " SECONDS";
    text(hhs, width/2.0 - textWidth(hhs) / 2.0, height/2.0 + 150);


    if (!inLevelSelect) {
      
      // START GAME BUTTON
      PVector center = new PVector(width/2.0, height/2.0);
      stroke(color(200, 30, 30, 240));
      strokeWeight(7);
      fill(color(80, 10, 10, 100));

      quad( center.x - 250, center.y * 1.5, center.x + 250, center.y * 1.5, 
            center.x + 230, center.y * 1.5 + 70, center.x - 230, center.y * 1.5 + 70);

      fill(color(200, 30, 30));
      textSize(24);
      String sg = "START GAME (ENTER)";
      text(sg, center.x - textWidth(sg) / 2.0, center.y * 1.5 + 45);
      
    } 
    else {
      
      PVector center = new PVector(width/2.0, height/2.0);

      stroke(color(200, 30, 30, 240));
      strokeWeight(7);
      fill(color(80, 10, 10, 100));

      quad( center.x - 350, center.y * 1.5, center.x - 250, center.y * 1.5 - 20, 
            center.x - 250, center.y * 1.5 + 80, center.x - 350, center.y * 1.5 + 60);

      line( center.x - 310, center.y * 1.5 + 30, center.x - 290, center.y * 1.5 + 20);
      line( center.x - 310, center.y * 1.5 + 30, center.x - 290, center.y * 1.5 + 40);

      quad( center.x + 350, center.y * 1.5, center.x + 250, center.y * 1.5 - 20, 
            center.x + 250, center.y * 1.5 + 80, center.x + 350, center.y * 1.5 + 60);

      line( center.x + 310, center.y * 1.5 + 30, center.x + 290, center.y * 1.5 + 20);
      line( center.x + 310, center.y * 1.5 + 30, center.x + 290, center.y * 1.5 + 40);

      fill(color(200, 30, 30));
      textSize(24);

      String difficulty = "";

      if (selectedDifficulty == 1) {
        difficulty = "DIFFICULTY: EASY";
      } 
      else if (selectedDifficulty == 2) {
        difficulty = "DIFFICULTY: HARD";
      }

      text(difficulty, center.x - textWidth(difficulty) / 2.0, center.y * 1.5 + 45);
      
    }
    
  }
  
}
