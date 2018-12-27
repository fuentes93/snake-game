class Bubble 
{
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  int broken = 0;
  float growrate = 0;
  ArrayList others;
 
  Bubble(float xin, float yin, float din, int idin, ArrayList oin) 
  {
    x = xin;
    y = yin;
    diameter = din;
    growrate = 0;
    id = idin;
    vx = random(0,100)/50. - 1.;
    vy = random(0,100)/50. - 1.;
    
    others = oin;
  } 
  void burst()
  {
      if (this.broken != BROKEN) // only burst once
      {
         this.broken = BROKEN;
         this.growrate = 2; // start it expanding
      }
  }
  
  void collide() 
  {
      Bubble b;
      // check collisions with all bubbles
      for (int i = 0; i < numBubbles; i++) 
      {      
         b = (Bubble)others.get(i);
         float dx = b.x - x;
         float dy = b.y - y;
         float distance = sqrt(dx*dx + dy*dy);
         float minDist = b.diameter/2 + diameter/2;
     
         if (distance < minDist) 
         {   // collision has happened
             if ((this.broken == BROKEN) || (b.broken == BROKEN))
             {
                // broken bubbles cause others to break also
                b.burst();
             }
         }
     }   
  }
  
  
  void update() 
  {
     if (this.broken == BROKEN)
     {
         this.diameter += this.growrate;
 
         if (this.diameter > MAXDIAMETER) // reached max size
               this.growrate = -0.75; // start shrinking
     }
     else
     {
        // move via Euler integration
        x += vx;
        y += vy;
  
       // the rest: reflect off the sides and top and bottom of the screen
       if (x + diameter/2 > width) 
       {
           x = width - diameter/2;
           vx *= -1; 
       }
       else if (x - diameter/2 < 0) 
       {
           x = diameter/2;
           vx *= -1;
       }

       if (y + diameter/2 > height) 
       {
           y = height - diameter/2;
           vy *= -1; 
       } 
       else if (y - diameter/2 < 0) 
       {
           y = diameter/2;
           vy *= -1;
       }
      
    }
  }
  
  void display() 
  {
    // how to draw a bubble: set to white with some transparency, draw a circle
    fill(10, 14 , 131); 
    ellipse(x, y, diameter, diameter);
  }
  
}