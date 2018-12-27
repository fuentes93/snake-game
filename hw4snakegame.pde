              // Luis Fuentes HW 4 Professsor Ling Xu  CS 3310
              // For every orange dot the snake grows by 1, you receive 5 points, a bubble pops where the mouse is located and you gain 1 point for every bubble
  Timer sw;              
  import ddf.minim.*;    // sound library
  Minim minim;
  AudioPlayer hum;
  ArrayList<Integer> x = new ArrayList<Integer>(), y = new ArrayList<Integer>();
  int w = 60, h = 30, bs = 20, dir = 2, applex = 12, appley = 10;
  int[] dx = {0,0,1,-1}, dy = {1,-1,0,0};
  // score and snake length variables
  int score;
  int snakel=1;
  
    int numBubbles = 50; // initial bubble count
    final int BROKEN = -99; // code for "broken", may have other states later
    final int MAXDIAMETER = 120; // maximum size of expanding bubble
    int gameState;              // game states
    public final int INTRO = 1;
    public final int PLAY = 2;
    public final int PAUSE = 3;
    public final int GAMEOVER = 4;
    public final int WON = 5;
    public final int CREDITS = 6;
  

    ArrayList pieces; // all the playing pieces
     
    boolean gameover = false;

  void setup() {
      pieces = new ArrayList(numBubbles);
      size(1200,600);
      gameState = INTRO;
      minim= new Minim(this);
      hum = minim.loadFile("hum.mp3"); // plays human music
              println (millis());
              sw = new Timer();
              sw.start();
    noStroke();
    smooth();
    
  for (int i = 0; i < numBubbles; i++) 
      pieces.add(new Bubble(random(width), random(height), 30, i, pieces)); 
              x.add(5);
              y.add(5);
  }
    void keyPressed()
  {  // game state for play
  if(key== 's' && ( gameState==INTRO || gameState==GAMEOVER )) 
  {
    gameState=PLAY;    
  }
  
        if(key=='p' && gameState==PLAY)
          gameState=PAUSE;
        else if(key=='p' && gameState==PAUSE)
          gameState=PLAY;
        
          if(key=='c' && gameState==PLAY)
            gameState=CREDITS;
          else if(key=='c' && gameState==CREDITS)
           gameState=PLAY;
       
        }

    void draw() {
  
    switch(gameState) 
  {
    case INTRO:  // intro text
      drawScreen("Welcome Press s to start!", "Collect the orange dot the snake grows and \na bubble pops where the mouse is located.\nYou gain 5 points for every orange dot and 1 for every bubble popped.\nTry to see how big you can make the snake. \n If the snake goes out of bounds you lose. \n Controls w=up s=down a= left d = right");
      break;
    case PAUSE:
      drawScreen("PAUSED", "Press p to resume the game");
      break;
    case GAMEOVER:
      drawScreen("GAME OVER", "Press s to try again");
      snakel=1;
            numBubbles = 10;
      break;
     case CREDITS:
      drawScreen("Credits: \nHW 4  \nBy Luis Fuentes \nPress c to resume ", "Music all rights given to Rick and Morty  Justin Roiland and Dan Harmon");
      break;
        case WON:
      drawScreen("You won", "Press s to try again");

      break;
    case PLAY:
            background(225);
    
             textSize(20);
            fill(0, 102, 153);
            text("Score", 30, 33);
            text(score,90,33);
           text("Snake length", 65, 60);   
            text(snakel,155,60); 
             textSize(30);
            text(nf(sw.minute(), 2)+":"+nf(sw.second(), 2), 600, 40);
        for(int i = 0 ; i < w; i++) line(i*bs, 0, i*bs, height); 
        for(int i = 0 ; i < h; i++) line(0, i*bs, width, i*bs); 
        for(int i = 0 ; i < x.size(); i++) 
        {
        fill (0,255,0);
        rect(x.get(i)*bs, y.get(i)*bs, bs, bs);
        }
           for (int i = 0; i < numBubbles; i++) 
    {
      Bubble b = (Bubble)pieces.get(i); // get the current piece
      
      if (b.diameter < 1) // if too small, remove
    {
        pieces.remove(i);
        numBubbles--;
        score++;
        i--;
    }
    else
    {
        // check collisions, update state, and draw this piece
        if (b.broken == BROKEN)  // only bother to check collisions with broken bubbles
           b.collide();
       
        b.update();
        b.display();  
         }
       }
        if(!gameover) {
                    hum.play();
        fill(255,100,0);
        rect(applex*bs, appley*bs, bs, bs); // created an apple however I preferred prange color 
         if(frameCount%5==0) 
         {
        x.add(0,x.get(0) + dx[dir]);
        y.add(0,y.get(0) + dy[dir]);
        if(x.get(0) < 0 || y.get(0) < 0 || x.get(0) >= w || y.get(0) >= h) gameover = true;
        for(int i = 1; i < x.size(); i++) if(x.get(0) == x.get(i) &&  y.get(0) == y.get(i)) gameover = true;
        if(x.get(0)==applex && y.get(0)==appley) {
          // randomize apple location
        applex = (int)random(0,w);
        appley = (int)random(0,h);
             // on click, create a new burst bubble at the mouse location and add it to the field      
      Bubble b = new Bubble(mouseX,mouseY,2,numBubbles,pieces);
      b.burst();
      pieces.add(b);
      numBubbles++;   
      score++;score++; score++; score++;score++; snakel++; // score and snakelength  

         }
         else {
            x.remove(x.size()-1);
            y.remove(y.size()-1);
        }
      }
    }
    else {
        fill(100);
        textSize(30);      // reset score and snakelength 
        score=0;
        snakel=1;
        text("GAME OVER. Press Space to Play Again", 600, height/2);
        if(keyPressed && key == ' ') {
        x.clear(); //Clear array list
        y.clear(); //Clear array list
        x.add(5);
        y.add(5);
      gameover = false;
      }
  }
      // controls for game
  if (keyPressed == true) {
    int newdir = key=='s' ? 0 : (key=='w' ? 1 : (key=='d' ? 2 : (key=='a' ? 3 : -1)));
    if(newdir != -1 && (x.size() <= 1 || !(x.get(1) ==x.get(0) + dx[newdir] && y.get (1) == y.get(0) + dy[newdir]))) dir = newdir;

       }
    }
  }
  void drawScreen(String title, String instructions) 
  {
  background(0,0,0);
  
  // draw title
  fill(255,100,0);
  textSize(60);
  textAlign(CENTER, BOTTOM);
  text(title, width/2, height/4);
  
  // draw instructions
  fill(255,255,255);
  textSize(32);
  textAlign(CENTER, TOP);
  text(instructions, width/2, height/3);
    }