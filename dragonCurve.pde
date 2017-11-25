ArrayList series;
int position;

PVector loc;
PVector step;

final float theta = TWO_PI*90/360;

void setup() {
  size(1280, 720);
  background(0);

  series = new ArrayList();
  series.add(true);

  for (int k = 0; k < 12; k++)  {
    ArrayList newSeries = new ArrayList();
    newSeries.addAll(series);
    newSeries.add(true);
    newSeries.addAll(flip(series));
    series = newSeries;
  }
  position = 0;

  //starting position
  loc = new PVector(.5*width, .5*height);
  
  //step-size
  step = new PVector(5, 0);
}

ArrayList flip(ArrayList a) {
  ArrayList flipped = new ArrayList();

  for (int i = a.size() - 1; i >= 0; i--)  {
    Boolean b = (Boolean)(a.get(i));
    flipped.add(!b);
  }

  return flipped;
}

void draw() {
  for (int i=0; i<200; i++) {
    drawStep(getStep());
  }
}


//gets the T/F (right/left) of current position
boolean getStep() {
  if (position == series.size()) {
    noLoop();
    return false;
  }

  boolean turn = (Boolean)series.get(position);
  
  //move to next position
  position++;
  
  return turn;
}

void drawStep(boolean turn) {
  stroke(180);
  strokeWeight(2);

  PVector newLoc = PVector.add(loc, step);
  line(loc, newLoc);
  loc = newLoc;

  PVector newStep = new PVector();
  newStep.x = cos(theta)*step.x - sin(theta)*step.y;
  newStep.y = sin(theta)*step.x + cos(theta)*step.y;
  step = newStep;

  // Turn opposite direction if true
  if (turn)
    step.mult(-1);
}

void line(PVector start, PVector end) {
  line(start.x, start.y, end.x, end.y);
}