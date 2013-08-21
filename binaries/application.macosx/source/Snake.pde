int snakesize = 10, fd, foodnums = 8, framerate = 12, gamovrcnt, highscore;
boolean keypressed = false, gamestarted = false, paused = false, gameover = false, freezescreen = false, 
hiscore = false, beguninput = false;
float spacingx, spacingy, numboxesx = 50.0, numboxesy;
ByteVector ky = new ByteVector(byte(5)), dir = new ByteVector(byte(random(0, 4)));
IntVector temp = new IntVector(0, 0), temp2 = new IntVector(0, 0);
ArrayList snake = new ArrayList(), foods = new ArrayList();
PFont gameOver, newGame;
Table highScores;
PGraphics scoreInput;
PGraphics buffer;
StringBuilder name = new StringBuilder();
String filename = new String();
String wordboxes = str(int(numboxesx));
String[] message = {"Enter the number\nof horizontal boxes\n", wordboxes};

void setup() {
  noCursor();
  frameRate(framerate);
  frame.setTitle("Snake");
  setFilename();
  if (fileExists(filename)) {
    highScores = loadTable(filename, "header, tsv");
  }
  else {
    highScores = new Table();
    highScores.addColumn("Name");
    highScores.addColumn("Score");
    highScores.addColumn("# of Boxes");
    for (int i = 0; i < 10; i++)
      highScores.addRow();
    for(int i = 0; i < 10; i++)
      highScores.setString(i, "Name", "nobody");
  }
  size(displayWidth, displayHeight);
  scoreInput = createGraphics(width, height);
  buffer = createGraphics(width, height);
  spacingx = width/numboxesx;
  numboxesy = int(height/spacingx);
  spacingy = height/numboxesy;
  gameOver = loadFont("Copperplate-Bold-70.vlw");
  newGame = loadFont("Courier-70.vlw");
}

void draw() {
  if (!gameover && !hiscore && gamestarted){
    if (keypressed) {
      dir.set(byte(-ky.x), byte(-ky.y));
      keypressed = false;
    }
    if (keyPressed) {
      if (key == 'x')
        frameRate(constrain(framerate++, 12, 60));
      else if (key == 'z')
        frameRate(constrain(framerate--, 12, 60));
    }
    temp.set(((IntVector) snake.get(0)).x, ((IntVector) snake.get(0)).y);
    ((IntVector) snake.get(0)).incr(dir);
    if (((IntVector) snake.get(0)).x < 0)
      ((IntVector) snake.get(0)).x = int(numboxesx - 1);
    else if (((IntVector) snake.get(0)).x > int(numboxesx - 1))
      ((IntVector) snake.get(0)).x = 0;
    else if (((IntVector) snake.get(0)).y < 0)
      ((IntVector) snake.get(0)).y = int(numboxesy - 1);
    else if (((IntVector) snake.get(0)).y > int(numboxesy - 1))
      ((IntVector) snake.get(0)).y = 0;
    buffer.beginDraw();
    buffer.background(255, 125, 0);
    buffer.fill(0, 0, 255);
    for (int i = 0; i < foods.size(); i++) {
      buffer.rect(((IntVector) foods.get(i)).x * spacingx, ((IntVector) foods.get(i)).y * spacingy, spacingx, spacingy);
    }
    buffer.fill(0, 137, 21);
    for (int i = 1; i < snake.size(); i++) {
      temp2.set(((IntVector) snake.get(i)).x, ((IntVector) snake.get(i)).y);
      ((IntVector) snake.get(i)).set(temp.x, temp.y);
      buffer.rect(((IntVector) snake.get(i)).x * spacingx, ((IntVector) snake.get(i)).y * spacingy, spacingx, spacingy);
      temp.set(temp2.x, temp2.y);
    }
    buffer.fill(255, 0, 0);
    buffer.rect(((IntVector) snake.get(0)).x * spacingx, ((IntVector) snake.get(0)).y * spacingy, spacingx, spacingy);
    buffer.endDraw();
    image(buffer, 0, 0);
    for (int i = 1; i < snake.size(); i++)
      if (((IntVector) snake.get(0)).eq((IntVector) snake.get(i))) {
        highscore = hiScore();
        if (highscore == -1){
          fill(255, 0, 0);
          gameOver();
        }
      }
    for (int i = 0; i < foods.size(); i++)
      if (((IntVector) snake.get(0)).eq((IntVector) foods.get(i))) {
        snake.add(new IntVector(temp2));
        foods.remove(i);
        fd = int(random(0, foodnums + 1 - foods.size()));
        for (int j = 0; j < fd; j++)
          foods.add(new IntVector(int(random(numboxesx)), int(random(numboxesy))));
        if (foods.size() == 0)
          foods.add(new IntVector(int(random(numboxesx)), int(random(numboxesy))));
        break;
      }
  }
  else if (!gamestarted) {
     if(!beguninput)
      startScreen();
  } 
  else if (hiscore){
    ;
  }
  else if (gameover || freezescreen) {
    gamovrcnt++;
    if (gamovrcnt == 32) {
      freezescreen = false;
      textSize(40);
      fill(255, 0, 255);
      text("hit any key to go to the main screen", width/2, (height*7)/8);
    }
  }
}

void keyPressed() {
  if(!gameover && gamestarted && !hiscore){
    if (key == 'p')
      if (!paused) {
        paused = true;
        noLoop();
      } 
      else {
        paused = false;
        loop();
      }
    if (!paused) {
      if (key == CODED) {
          if (keyCode == UP && (dir.numba != 1) && (dir.numba !=3)) {
          ky.set(byte(1));
          keypressed = true;
          redraw();
        }
        else if (keyCode == DOWN && (dir.numba != 3) && (dir.numba !=1)) {
          ky.set(byte(3));
          keypressed = true;
          redraw();
        }
        else if (keyCode == LEFT && (dir.numba != 2) && (dir.numba !=0)) {
          ky.set(byte(2));
          keypressed = true;
          redraw();
        }
        else if (keyCode == RIGHT && (dir.numba !=0) && (dir.numba !=2)) {
          ky.set(byte(0));
          keypressed = true;
          redraw();
        }
      } 
      else if (key == 'k' && (dir.numba != 1) && (dir.numba != 3)) {
        ky.set(byte(1));
        keypressed = true;
        redraw();
      }
      else if (key == 'j' && (dir.numba != 3) && (dir.numba != 1)) {
        ky.set(byte(3));
        keypressed = true;
        redraw();
      }
      else if (key == 'h' && (dir.numba != 2) && (dir.numba !=0)) {
        ky.set(byte(2));
        keypressed = true;
        redraw();
      }
      else if (key == 'l' && (dir.numba !=0) && (dir.numba != 2)) {
        ky.set(byte(0));
        keypressed = true;
        redraw();
      }
    }
    if (key == 'x')
      frameRate(constrain(framerate++, 12, 60));
    if (key == 'z')
      frameRate(constrain(framerate--, 12, 60));
  }
  if (hiscore) {
    if (key != CODED) {
      if (key != ENTER && key != RETURN) {
        if (key != BACKSPACE && key != DELETE)
          name.append(key);
        else name.deleteCharAt((name.length() - 1));
        image(scoreInput, 0, 0);
        text("New High Score! Enter your name:", width/2, height/4);
        text(name.toString(), width/2, height/2);
        redraw();
      }
      else {  
        image(scoreInput, 0, 0);      
        enterName(highscore);
      }
    }
  }
  else if (key == 'q')
    exit();
  else if(freezescreen)
    ;
  else if (gameover && !freezescreen){
    gameover = false;
    gamestarted = false;
    startScreen();
  }
  else if (!gamestarted) {
    if(key >= '0' && key <= '9'){
      if(!beguninput){
          name.setLength(0);
          beguninput = true;
      }
      name.append(key); 
      image(scoreInput, 0, 0);
      message[1] = name.toString();
      text(join(message, ""), (width*3)/4, (height*3)/4);
      redraw();
    }
    else if(beguninput && (key == BACKSPACE || key == DELETE)){
      name.deleteCharAt((name.length() - 1));
      image(scoreInput, 0, 0);
      message[1] = name.toString();
      text(join(message, ""), (width*3)/4, (height*3)/4);
      redraw();
    }
    else if(beguninput && (key == ENTER || key == RETURN)){
      beguninput = false;
      numboxesx = int(name.toString());
      wordboxes = str(numboxesx);
      spacingx = width/numboxesx;
      numboxesy = int(height/spacingx);
      spacingy = height/numboxesy;
      startScreen();
      redraw();
    }
    else {
      beguninput = false;
      gamestarted = true;
      loop();
    }
  }

}

void startScreen() {
  background(0);
  snake.clear();
  foods.clear();
  snake.add(new IntVector(int(random(numboxesx)), int(random(numboxesy))));
  for (int i = 1; i < snakesize; i++)
    snake.add(new IntVector(((IntVector) snake.get(i-1)).x + dir.x, ((IntVector) snake.get(i-1)).y + dir.y));
  dir.set(byte(-dir.x), byte(-dir.y));
  fd = int(random(3, foodnums));
  for (int i = 0; i < fd; i++)
    foods.add(new IntVector(int(random(numboxesx)), int(random(numboxesy))));
  fill(0, 0, 255);
  for (int i = 0; i < foods.size(); i++) {
    rect(((IntVector) foods.get(i)).x * spacingx, ((IntVector) foods.get(i)).y * spacingy, spacingx, spacingy);
  }
  fill(255, 0, 0);
  rect(((IntVector) snake.get(0)).x * spacingx, ((IntVector) snake.get(0)).y * spacingy, spacingx, spacingy);
  fill(0, 137, 21);
  for (int i = 1; i < snake.size(); i++) {
    rect(((IntVector) snake.get(i)).x * spacingx, ((IntVector) snake.get(i)).y * spacingy, spacingx, spacingy);
  }
  fill(255);
  textAlign(CENTER);
  textFont(newGame);
  textSize(70);
  text("Snake", width/2, height/6);
  textSize(30);
  text("press any key to begin, \n hit 'p' to pause, q to quit \n arrow keys or h,j,k,l for movement \n x + z faster/slower framerate", 
  width/2, height/2);
  loadPixels();
  scoreInput.beginDraw();
  scoreInput.loadPixels();
  for(int j = 0; j < width * height; j++)
    scoreInput.pixels[j] = pixels[j];
  scoreInput.updatePixels();
  scoreInput.endDraw();
  updatePixels();
  text(join(message, ""), (width*3)/4, (height*3)/4);
  noLoop();
}

void gameOver() {
  saveTable(highScores, filename, "tsv");
  gameover = true;
  freezescreen = true;
  framerate = 12;
  gamovrcnt = 0;
  frameRate(framerate);
  String[] message = {"Your score was ", str(snake.size())};
  text(join(message, ""), width/2, height/6);
  fill(255, 0, 0);
  textSize(20);
  textFont(gameOver);
  textSize(90);
  text("Game Over", width/2, height/8);
  String[] names = {"Name"}, scores = {"Score"}, tabnumbox = {"# of Boxes"};
  names = concat(names, highScores.getStringColumn("Name"));
  for (int i = 0; i < 10; i++){
    scores = append(scores, str(highScores.getInt(i, "Score")));
    tabnumbox = append(tabnumbox, str(highScores.getInt(i, "# of Boxes")));
  }
  fill(0);
  textSize(30);
  text(join(names, "\n\n"), width/4, height/4);
  text(join(scores, "\n\n"), width/2, height/4); 
  text(join(tabnumbox, "\n\n"), (width*3)/4, height/4);
}

int hiScore() {
  int dummy = -1;
  for (int i = 0; i < 10; i++)
    if (snake.size() > highScores.getInt(i, "Score")) {
      noLoop();
      fill(0, 0, 255);
      buffer.loadPixels();
      scoreInput.beginDraw();
      scoreInput.loadPixels();
      for(int j = 0; j < width * height; j++)
        scoreInput.pixels[j] = buffer.pixels[j];
      scoreInput.updatePixels();
      scoreInput.endDraw();
      text("New High Score! Enter your name:", width/2, height/4);
      hiscore = true;
      redraw();
      name.setLength(0);
      dummy = i;
      break;
    }
  return dummy;
}

void enterName(int i) {
  for (int j = 8; j >= i; j--) {
    highScores.setInt(j + 1, "Score", highScores.getInt(j, "Score"));
    highScores.setInt(j + 1, "# of Boxes", highScores.getInt(j, "# of Boxes"));
    highScores.setString(j + 1, "Name", highScores.getString(j, "Name"));
  }
  highScores.setInt(i, "Score", snake.size());
  highScores.setInt(i, "# of Boxes", int(numboxesx * numboxesy));
  highScores.setString(i, "Name", name.toString());
  loop();
  gameOver();
  hiscore = false;
}

void setFilename(){
  if(fileExists(sketchPath("Snake.app")))
    filename = sketchPath("Snake.app/Contents/Resources/Java/data/highscores.tsv");
  else filename = dataPath("highscores.tsv");
}

boolean fileExists(String filename) {
 File file = new File(filename);
 if(file.exists())
  return true;
 return false;
}
