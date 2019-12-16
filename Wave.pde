class Wave {

  ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

  int waveSections;

  Wave(ArrayList<Integer> obSections) {

    waveSections = obSections.size();

    for (Integer s : obSections) {
      obstacles.add(new Obstacle(s));
    }
    
  }

  void display() {
    for (Obstacle ob : obstacles) {
      ob.display();
    }
  }
  
}
