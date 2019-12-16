class WavePattern {

  ArrayList<ArrayList<Integer>> wavesToAdd = new ArrayList<ArrayList<Integer>>();
  ArrayList<Wave> waves = new ArrayList<Wave>();

  ArrayList<Integer> intervalsToAddWaves = new ArrayList<Integer>();

  JSONObject json = loadJSONObject("patterns.json");

  String stringSections;
  JSONArray curSectionPatterns;

  int numWaves;
  int timeStarted;
  int timeToEnd;


  WavePattern() {

    timeStarted = frameCount;
    waveInProgress = true;
    stringSections = ""+sections;

    curSectionPatterns = json .getJSONObject("patterns")
                              .getJSONObject("sections")
                              .getJSONObject(stringSections)
                              .getJSONArray("wavePatterns");

    JSONArray pattern = curSectionPatterns.getJSONObject((int)(random(curSectionPatterns.size()))).getJSONArray("pattern");

    numWaves = pattern.size();


    for (int i = 0; i < pattern.size(); i++) {

      ArrayList<Integer> obSections = new ArrayList<Integer>();
      JSONArray wave = pattern.getJSONObject(i).getJSONArray("wave");

      for (int j = 0; j < wave.size(); j++) {
        obSections.add(wave.getInt(j));
        //System.out.println("Adding " + wave.getInt(j));
      }

      wavesToAdd.add(obSections);
    }

    timeToEnd = timeStarted + waveGap*numWaves;

    float interval = (timeToEnd - timeStarted) / (float)numWaves;

    // System.out.println("TS      : " + timeStarted);
    // System.out.println("TTE     : " + timeToEnd);
    // System.out.println("Interval: " + interval);
    // System.out.println("NumWaves: " + numWaves);

    for (int i = 0; i < numWaves; i++) {
      intervalsToAddWaves.add((int)(timeStarted + (interval*i)));
    }

    //System.out.println(pattern);
  }

  void update() {

    if (intervalsToAddWaves.contains(frameCount)) {
      waves.add(new Wave(wavesToAdd.get(0)));
      wavesToAdd.remove(0);
    }

  }
  
}
