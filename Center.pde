class Center {

  Player player;

  ArrayList<WavePattern> wavePatterns = new ArrayList<WavePattern>();


  Center() {
    
    centerSize = width/20;
    player = new Player(centerSize);
    
  }


  void update(String dir) {

    WavePattern currentWavePattern;
    
    if (!wavePatterns.isEmpty())
      currentWavePattern = wavePatterns.get(0);
    else 
      currentWavePattern = null;

    player.update(dir, centerSize, currentWavePattern);

  }


  // DISPLAY CENTER
  void display() {
    updateObstacles();
    
    fill(80, 10, 10);
    polygon(0, 0, centerSize, sections);
    player.display();
  }


  // DRAW A POLYGON
  //https://processing.org/examples/regularpolygon.html
  void polygon(float x, float y, float radius, int nPoints) {
    float angle = TWO_PI / nPoints;
    beginShape();
      for (float a = 0; a < TWO_PI; a += angle) {
        float sx = x + cos(a) * radius;
        float sy = y + sin(a) * radius;
        vertex(sx, sy);
      }
    endShape(CLOSE);
  }


  void updateObstacles() {

    ArrayList<WavePattern> wpsToRemove = new ArrayList<WavePattern>();

    // For all Wave Patterns
    for (WavePattern wp : wavePatterns) {

      ArrayList<Wave> wavesToRemove = new ArrayList<Wave>();

      // For all Waves in each Wave Pattern
      for (Wave wave : wp.waves) {
        
        if (wave.waveSections == 0) {
          wavesToRemove.add(wave);
        }
        
        // For all Obstacles in each Wave in each Wave Pattern
        for (Obstacle ob : wave.obstacles) {
          ob.display();
          ob.update();
          
          if (ob.thickness < centerSize) {
            //System.out.println("REMOVING WAVE");
            wavesToRemove.add(wave);
            break;
          }
          
        }
        
      }

      for (Wave wave : wavesToRemove) {
        wp.waves.remove(wave);
        //System.out.println("removing wave, wp.waves.size = " + wp.waves.size());
      }

      if (wp.waves.isEmpty()) {
        wpsToRemove.add(wp);
      } 

    }

    for (WavePattern wp : wpsToRemove) {
      wavePatterns.remove(wp);
    }

    // GENERATE WAVES
    // If there isn't any wave being generated, generate a new one
    if (!waveInProgress) {
      wavePatterns.add(new WavePattern());
    }
    
    // Go through all wave patterns and update them if they still have waves
    // they haven't generated yet
    for (WavePattern wp : wavePatterns) {
      if (!wp.wavesToAdd.isEmpty()) {
        wp.update();
      }
    }
    
    // Marks as ready to generate a new wave pattern once all waves have been generated
    // in current wave
    if (!wavePatterns.isEmpty()) {
      if (frameCount > wavePatterns.get(wavePatterns.size()-1).timeToEnd) 
        waveInProgress = false;
    }
    
  }
  
}
