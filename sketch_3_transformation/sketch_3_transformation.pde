


void myColorTriangle (int x0, int y0, int r0, int g0, int b0, 
                      int x1, int y1, int r1, int g1, int b1,
                      int x2, int y2, int r2, int g2, int b2)
{
  // insert your code here to draw a triangle with vertices (x0, y0), (x1, y1) and (x2, y2) 
  // with colors (r0, g0, b0), (r1, g1, b1) and (r2, g2, b2) attached to each vertex respectively.
  //
  // Your implementation should interpolate the colors accross the triangle.
  //
  // Only use calls to the function drawColorPoint() which is below the do not edit line
  // This function has the following signature
  
  // your code should be an extension of the myTrangle function from Assignment 2.
  
  int[] xs = {x0, x1, x2};
  xs = sort(xs);
  int[] ys = {y0, y1, y2};
  ys = sort(ys);
  
  // slope 0 - 1
  Boolean e0_v = false;
  float m0 = 0.0f;
  if((x1 - x0) == 0){
    e0_v = true;
  }
  else{
    m0 = (float)(y1 - y0) / (float)(x1 - x0);
  }
  // slope 1 - 2
  Boolean e1_v = false;
  float m1 = 0.0f;
  if((x2-x1) == 0){
    e1_v = true;
  }
  else{
    int temp1 = (y2 - y1);
    int temp2 = (x2 - x1);
    m1 = (float)temp1 / temp2; //<>//
  }
  // slope 2 - 0
  Boolean e2_v = false;
  float m2 = 0.0f;
  if((x0-x2) == 0){
    e2_v = true;
  }
  else{
    m2 = (float)(y0 - y2) / (float)(x0 - x2);
  }
  
  for(int y=ys[0]; y<=ys[2]; ++y){
    ArrayList<Integer> intersections = new ArrayList();
    for(int x=xs[0]; x<=xs[2]; x++){
      // check intersection with edge0-1
      if(e0_v == true){
        if(x == x0) {
          intersections.add(x);
          continue;
        }
      }
      else{
        int d1 = (int)(m0 * (x - x0) + y0 );
        if(abs(y - d1) <= abs(m0) && (y-d1) >=0){
          intersections.add(x);
          continue;
        }
      }
      
      if(e1_v == true){
          if(x == x1) {
            intersections.add(x);
            continue;
          }
      }
      else{
        int d2 = (int)(m1 * (x - x1) + y1 );
        if(abs(y - d2) <= abs(m1) && (y-d2)>=0){
          intersections.add(x);
          continue;
        }
      }
      
      if(e2_v == true){
          if(x == x2) {
            intersections.add(x);
            continue;
          }
      }
      else{
        int d3 = (int)(m2 * (x - x2) + y2 );
        if(abs(y - d3) <= abs(m2) && (y-d3)>=0){
          intersections.add(x);
          continue;
        }
      }
    }
      
      // if there is only 1 point of intersection
      if(intersections.size() == 1){
        point(intersections.get(0), y);
      }
      else if(intersections.size() >= 2){
        int start = intersections.get(0);
        int end = intersections.get(intersections.size()-1);
        for(int i=start; i<end; i++){
          int xp = i;
          int yp = y;
          // Calculate the interpolated color
          // A(x0, y0) B(x1, y1), C(x2, y2)
          float AB = sqrt(abs(x1 - x0) + abs(y1 - y0));
          float BC = sqrt(abs(x2 - x1) + abs(y2 - y1));
          float AC = sqrt(abs(x2 - x0) + abs(y2 - y0));
          float AP = sqrt(abs(xp - x0) + abs(yp - y0));
          float BP = sqrt(abs(xp - x1) + abs(yp - y1));
          float CP = sqrt(abs(xp - x2) + abs(yp - y2));
          
          float alpha = (AB * AP) / (AB * AC);
          float beta = (BC * BP) / (BC * AB);
          float charle = (AC * CP) / (AC * BC);
          
          int r = (int)(alpha * r0 + beta * r1 + charle * r2);
          int g = (int)(alpha * g0 + beta * g1 + charle * g2);
          int b = (int)(alpha * b0 + beta * b1 + charle * b2);
          
          drawColorPoint(xp, yp, r, g, b);
        }
      }
    }
  
}


PMatrix2D transformTheHouse()
{
  // return a matrix that has all of the transformations of the highest level you reached in the 
  // transformation game of last week's online assignment
  //
  
  // start with the identity matrix
  PMatrix2D retval = new PMatrix2D();
  
  // Add your transformations here....remember you must preMultiply
  // Also recall, in Processing +y is down (in transformation game +y is up)
  // in processing: +rotation is clockwise (and in radians)....in transformation game +rotation is counter-clockwise (and in degrees).
  
  
  float theta2 = 44 * PI / 180; // in radian
  retval.preApply(cos(theta2), -sin(theta2), 0, sin(theta2), cos(theta2), 0);
  
  retval.preApply(3, 0, 0, 0, 1, 0);
  
  float theta = -17 * PI / 180; // in radian
  retval.preApply(cos(theta), -sin(theta), 0, sin(theta), cos(theta), 0);
  
  retval.preApply(1, 0, 0, 0, 1, -26);
  
  
 
  // return the result
  return retval;
}

// --------------------------------------------------------------------------------------------
//
//  Do not edit below this lne
//
// --------------------------------------------------------------------------------------------

boolean doMine = true;
int scene = 1;
color backgroundColor = color (150, 150, 150);

void setup () 
{
  size (500, 500);
  background (backgroundColor);
}

void draw ()
{
  if (scene == 1) doHouse();
  if (scene == 2) doTriangle();
}

//
// fills in the pixel (x, y) with the color (r,g,b)
//
void drawColorPoint (int x, int y, int r, int g, int b)
{
  stroke (r, g, b);
  point (x,y);
}

void doHouse()
{
  PMatrix2D trn = new PMatrix2D();
 
  
  stroke (0,0,0);
  line (0, 250, 500, 250);
  line (250, 0, 250, 500);
  
  trn.translate (250, 250);  
  trn.apply (transformTheHouse());

    applyMatrix (trn);
    
    fill (255, 0, 0);
    stroke (255,0,0);
    triangle (-25, 25, 25, -25, -25, -25);
    triangle (25, 25, 25, -25, -25, 25);
    
    fill (0, 255, 0);
    stroke (0,255,0);
    triangle (-25,-25, 25, -25, 0, -50);
    
    stroke (0,0,255);
    fill (0,0,255);
   triangle (10, 0, 10, 25, 20, 25);
   triangle (10, 0, 20, 25, 20, 0);
}

void doTriangle ()
{
  myColorTriangle (300, 400, 0, 0, 255,
                   400, 100, 0, 255, 0,
                   50, 50, 255, 0, 0);
}

void keyPressed()
{
  if (key == '1') 
  {
    background (backgroundColor);
    scene = 1;
  }
  
  if (key == '2') 
  {
    background (backgroundColor);
    scene = 2;
  }

  
  if (key == 'q') exit();
}
