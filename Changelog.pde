/*

v0.0.1
- Added the rotating background, with a variable number of sections
- Added center shape on the background
- Added a player, controllable with the arrow keys
- Added placeholder obstacles (rectangles), which move 
  towards the center then disappear
  

v0.0.2
- Fix background colors with even/odd numbers of sections
- Add obstacles which fit the shape of the sections and resize correctly
- A random number of obstacles is generated in every group


v0.0.3
- Background rotation now changes speed every so often
- Added fast spinning rotation effect, very small chance to occur every frame
- The number of obstacles in a group is now always one less than the number
  of sections (still temporary)
- Center slowly increases in size, increasing difficulty over time


v0.0.4
- Added GameUI class for UI elements
- Added a new pixel-style font
- Added a basic timer in top left (UI) shows time since game started
- Added temporary FPS counter in top right (UI)
- Refactored code for keeping track of obstacles, created Wave class
- Added collisions:
    - Touching the bottom of an obstacle will freeze everything (temp. game over)
    - Running into left or right side of an obstacle won't let you move 
      into obstacle (still buggy, need to improve)
- Refactored code involving even/odd sections, added new global variable


v0.0.5
- Added WavePattern class to manage different wave patterns
- Reads patterns from a JSON file with pre-defined patterns, set differently for 
  different numbers of sections
- Refactored how generating waves works by going through the WavePattern class
- Made obstacleSpeed and waveGap global variables

v0.0.6
- Added a menu system and MainMenu class
- Added the ability to restart a new game after death, now taken back to the main
  menu when you die
- Added ability to keep track of high score, as well as see your most recent score
- Added two difficulty levels (easy/hard) with a different number of sections, therefore
  different patterns
- Refactoring, changed some variable names
- Tidied up code/added some extra comments
- Edited GameUI design
- Added counter for two seperate highscores, for the seperate difficulties

*/
