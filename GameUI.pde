class GameUI {

  int count;

  GameUI() {
    count = 0;
  }

  void update() {
    count++;
    if (count == 60) {
      timer++;
      count = 0;
    }
  }

  void display() {

    fill(color(50,10,10,200));
    noStroke();
    quad(0, 0, 250, 0, 230, 80, 0, 80);

    fill(255);
    String diff = "";
    if (selectedDifficulty == 1) {
      diff = "EASY";
    }
    else if (selectedDifficulty == 2) {
      diff = "HARD";
    }
    text(diff, 40, 50);

    translate(width, 0);
    fill(color(50,10,10,200));
    quad(0, 0, -250, 0, -230, 80, 0, 80);

    fill(255);
    String time = "TIME: " + timer;
    text(time, -textWidth(time) - 40, 50);
    
  }
  
}
