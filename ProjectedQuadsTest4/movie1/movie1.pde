import codeanticode.gsvideo.*;
 
GSMovie movie;
 
void setup() {
  size(640, 480);
  background(0);
  // Load and play the video in a loop
  movie = new GSMovie(this, "station.mov");
  movie.loop();
}
 
void movieEvent(GSMovie movie) {
  movie.read();
}
 
void draw() {
  image(movie, mouseX-movie.width/2, mouseY-movie.height/2);
}
