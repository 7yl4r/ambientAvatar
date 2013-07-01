/*
  sinmplestProjectedQuads - a simple class for projection mapping demo
  adapted for Projection Mapping Workshop by Codasign and Openlab Workshops
 
  ProjectedQuads / ProjectedQuadsTest.pde
  v1.0 / 2010.01.30
 
  Keyboard:
  - 'd' toggle debug mode
  - 'S' save settings
  - 'L' load settings
  - '>' select next quad in debug mode
  - '<' select prev quad in debug mode
  - '1', '2', '3', '4' select one of selected quad's corners 
  - Arrow keys (left, right, up, down) move selected corner's position (you can also use mouse for that)  
*/
 
/* 
 * Adapted by Becky Stewart http://codasign.com
 * from the example by Marcin Ignac http://marcinignac.com
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * http://creativecommons.org/licenses/LGPL/2.1/
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
import processing.video.*; 
String configFile = "data/quadsconfig.txt";
Capture video; 
ProjectedQuads projectedQuads;
PImage    checkered, maleFace, femaleFace; //image textures
PGraphics quadGraphics1, quadGraphics2;    //dynamic textures
 
int circleX;
int directionX = 1;
int whiteness = 0;
int colourSpeed = 1;
 
void setup() {
  size(800, 600, P3D);
  video = new Capture(this, width, height);
  video.start();
 
  projectedQuads = new ProjectedQuads();  
  projectedQuads.load(configFile);  
  //we want to display n quads so if there was no config file
  //or less than n were defined we increase number to n
  int n = 5; //number of quads to display
  if (projectedQuads.getNumQuads() < n) {
    projectedQuads.setNumQuads(n);  
  }  
 
  // setup quad textures
  checkered = loadImage("checker.png");
  maleFace      = loadImage("maleFace.png");
  femaleFace    = loadImage("femaleFace.png");
  quadGraphics1 = createGraphics(256, 256, P2D);
  quadGraphics2 = createGraphics(256, 256, P2D);
  
  projectedQuads.getQuad(0).setTexture(maleFace);
  projectedQuads.getQuad(1).setTexture(quadGraphics1); 
  projectedQuads.getQuad(2).setTexture(quadGraphics2);
  projectedQuads.getQuad(3).setTexture(checkered);
  projectedQuads.getQuad(4).setTexture(checkered);
 
  // variables for our graphics
  circleX = quadGraphics1.width/2;
}
 
void draw() {
  video.read();
  pushMatrix();
  scale(-1,1);               //Gira el video para que sea como un espejo
  image(video, -width, 0);
  translate(-width, 0);
  popMatrix();
  
  //animation code is here
  quadGraphics1.beginDraw();
  quadGraphics1.fill(200, 0, 120);
 
  if( circleX < 0 || circleX > quadGraphics1.width) {
   directionX = directionX * -1; 
  }
  circleX = circleX + directionX;
  quadGraphics1.ellipse(circleX, quadGraphics1.height/2, 50, 50);
  quadGraphics1.endDraw();
  
  quadGraphics2.beginDraw();
  // second projected quad
  quadGraphics2.fill(whiteness);
  quadGraphics2.rect(quadGraphics2.width/2, quadGraphics2.height/2, 100, 100);
 
  whiteness = whiteness + colourSpeed;   // change the brightness 
 
  // if it is TOO bright, let's make it darker:
  if (whiteness > 255)  
  {
    whiteness = 255;
    colourSpeed = -colourSpeed;  // negative (getting darker)
  }
  // otherwise, if it's too dark, make it lighter:
  else if (whiteness < 0)
  {
    whiteness = 0;
    colourSpeed = -colourSpeed;  // positive (getting brighter)
  }
  quadGraphics2.endDraw();
  
 
  //draw projected quads on the screen
  projectedQuads.draw();

}
 
void keyPressed() {
  //let projectedQuads handle keys by itself
  projectedQuads.keyPressed();
}
 
void mousePressed() {
  //let projectedQuads handle mousePressed by itself
  projectedQuads.mousePressed();
}
 
void mouseDragged() {
  //let projectedQuads handle mouseDragged by itself
  projectedQuads.mouseDragged();
}
