void drawBackground(){
  //Needs to;
  //(0) Draw processing background (just in case)
  //(1) Draw floor index
  //(2) Draw tile index
  //(3) Draw character      ## MAYBE CHANGE SO SMALLER DRAWN FIRST, LARGER LAST (INCLUDING USER'S CHARACTER)
  //(4) Draw entities       ##
  //(5) Drawn extra overlays

  //(0)
  background(200,200,255);
  //drawGridBoxes();

  //(1)
  drawGridIndex();

  //(2)
  //pass

  //(3)
  //pass

  //(4)
  //pass

  //(5)
  findGridCenter();
  //drawGridCenter();          //The ellipse in exact center marker (for cursor)
}
