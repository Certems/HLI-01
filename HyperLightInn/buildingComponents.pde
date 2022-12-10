//(1) DRAW commands specifiy the texture location for object
//(2) COLLIDE commands specify the loci of collisons for the object, RETURNS reue or false (meaning keep velocity,o rmeaning stop velocity)

boolean buildingCollision(int n, PVector posEntity, int objTile, PVector vel, boolean IsUser){//Index n (of object at currentTile), current position of entity, currentTile position, gives rules for its collision
  if ((objTile > 0) && (objTile < (colNum*rowNum)) )
  {

    if(IsUser == false)//Not user
    {
      //relativePosEntity  = findRelativeCoordinatesEntity( posEntity );
      //## BECAUSE THE FINDRELATIVECORRDINATESENTITY WON'T RETURN NON INTEGER VALUES ##//
      relativeDifference.x = (posEntity.x - relativePos.x);
      relativeDifference.y = (posEntity.y - relativePos.y);
      relativePosEntity.x = (screenWidth /2)+(relativeDifference.x);
      relativePosEntity.y = (screenHeight/2)+(relativeDifference.y);
      //## BECAUSE THE FINDRELATIVECORRDINATESENTITY WON'T RETURN NON INTEGER VALUES ##//
    }
    else               //Is user
    {
      relativePosEntity.x = posEntity.x;//( (relativePos.x-screenWidth /2) + user.pos.x);
      relativePosEntity.y = posEntity.y;//( (relativePos.y-screenHeight/2) + user.pos.y);
      //##USER VALUE##
    }
    
    relativeObjPosTemp = findRelativeCoordinates(objTile);
    
    if (n == 1){//Wall
      pushStyle();                                                //*****//
      fill(150,255,150);                                          //*****//
      ellipse(relativeObjPosTemp.x,relativeObjPosTemp.y, 10,10);  //*****//
      popStyle();                                                 //*****//
     
      rectCollisionCond1 = ( abs( relativePosEntity.x - relativeObjPosTemp.x +vel.x ) <= ( wallWidth /2 ) );//Width vibe check  -->Change this to make specific for your given shape
      rectCollisionCond2 = ( abs( relativePosEntity.y - relativeObjPosTemp.y +vel.y ) <= ( wallHeight/2 ) );//Height vibe check -->"" ""
      if( rectCollisionCond1 && rectCollisionCond2 )//If within width and height specified
      {
        return true;
      }
      else
      {
        return false;
      }
      
    }
    if (n == 2){//Barrel
    
      //pushStyle();                                                                   //*****//
      //println("posEntity; ",posEntity);                                              //*****//
      //println("###objPosTemp (for 2/barrels)###; ",objPosTemp);                      //*****//
      //fill(20,20,220);                                                               //*****//
      //ellipse(objPosTemp.x, objPosTemp.y, 15,15);                                    //*****//
      //popStyle();                                                                    //*****//
      
      if ( pow( ( relativePosEntity.x - relativeObjPosTemp.x +vel.x ) ,2 ) + pow( ( relativePosEntity.y - relativeObjPosTemp.y +vel.y ) ,2 ) < ( pow((wallWidth/3),2) ) )
      {
        return true; //In the collision zone
      }
      else
      {
        return false; //Not in the collision zone
      }
    }
    if (n == 3){//Door
      /*
      rectCollisionCond1 = ( abs( relativePosEntity.x - relativeObjPosTemp.x ) < ( wallWidth /2 ) );//Width vibe check  -->Change this to make specific for your given shape
      rectCollisionCond2 = ( abs( relativePosEntity.y - relativeObjPosTemp.y ) < ( wallHeight/2 ) );//Height vibe check -->"" ""
      if( rectCollisionCond1 && rectCollisionCond2 )//If within width and height specified
      {
        return true;
      }
      else
      {
        return false;
      }
      */
      //## NO COLLISION FOR DOOR ATM ##//
      
      return false;
    }
    if (n == 4){//Table
      rectCollisionCond1 = ( abs( relativePosEntity.x - relativeObjPosTemp.x +vel.x ) <= ( wallWidth /2 ) );//Width vibe check  -->Change this to make specific for your given shape
      rectCollisionCond2 = ( abs( relativePosEntity.y - relativeObjPosTemp.y +vel.y ) <= ( wallHeight/2 ) );//Height vibe check -->"" ""
      if( rectCollisionCond1 && rectCollisionCond2 )//If within width and height specified
      {
        return true;
      }
      else
      {
        return false;
      }//##########################
    }
    if (n == 5){//Stool
      //No collision planned, can walk over it / sit on it
    }
    if (n == 6){//Counter
      rectCollisionCond1 = ( abs( relativePosEntity.x - relativeObjPosTemp.x +vel.x ) <= ( wallWidth/2  ) );//Width vibe check  -->Change this to make specific for your given shape
      rectCollisionCond2 = ( abs( relativePosEntity.y - relativeObjPosTemp.y +vel.y ) <= ( wallHeight/2 ) );//Height vibe check -->"" ""
      if( rectCollisionCond1 && rectCollisionCond2 )//If within width and height specified
      {
        return true;
      }
      else
      {
        return false;
      }
    }//####################
    if (n==7)
    {
      pushStyle();                                                //*****//
      fill(150,255,150);                                          //*****//
      ellipse(relativeObjPosTemp.x,relativeObjPosTemp.y, 10,10);  //*****//
      popStyle();                                                 //*****//
     
      rectCollisionCond1 = ( abs( relativePosEntity.x - relativeObjPosTemp.x +vel.x ) <= ( wallWidth /2 ) );//Width vibe check  -->Change this to make specific for your given shape
      rectCollisionCond2 = ( abs( relativePosEntity.y - relativeObjPosTemp.y +vel.y ) <= ( wallHeight/2 ) );//Height vibe check -->"" ""
      if( rectCollisionCond1 && rectCollisionCond2 )//If within width and height specified
      {
        return true;
      }
      else
      {
        return false;
      }
    }
    if (n==8)
    {
      pushStyle();                                                //*****//
      fill(150,255,150);                                          //*****//
      ellipse(relativeObjPosTemp.x,relativeObjPosTemp.y, 10,10);  //*****//
      popStyle();                                                 //*****//
     
      rectCollisionCond1 = ( abs( relativePosEntity.x - relativeObjPosTemp.x +vel.x ) <= ( wallWidth /2 ) );//Width vibe check  -->Change this to make specific for your given shape
      rectCollisionCond2 = ( abs( relativePosEntity.y - relativeObjPosTemp.y +vel.y ) <= ( wallHeight/2 ) );//Height vibe check -->"" ""
      if( rectCollisionCond1 && rectCollisionCond2 )//If within width and height specified
      {
        return true;
      }
      else
      {
        return false;
      }
    }
    if (n==9)
    {
      pushStyle();                                                //*****//
      fill(150,255,150);                                          //*****//
      ellipse(relativeObjPosTemp.x,relativeObjPosTemp.y, 10,10);  //*****//
      popStyle();                                                 //*****//
     
      rectCollisionCond1 = ( abs( relativePosEntity.x - relativeObjPosTemp.x +vel.x ) <= ( wallWidth /2 ) );//Width vibe check  -->Change this to make specific for your given shape
      rectCollisionCond2 = ( abs( relativePosEntity.y - relativeObjPosTemp.y +vel.y ) <= ( wallHeight/2 ) );//Height vibe check -->"" ""
      if( rectCollisionCond1 && rectCollisionCond2 )//If within width and height specified
      {
        return true;
      }
      else
      {
        return false;
      }
    }
    if (n==11)
    {
      pushStyle();                                                //*****//
      fill(150,255,150);                                          //*****//
      ellipse(relativeObjPosTemp.x,relativeObjPosTemp.y, 10,10);  //*****//
      popStyle();                                                 //*****//
     
      rectCollisionCond1 = ( abs( relativePosEntity.x - relativeObjPosTemp.x +vel.x ) <= ( wallWidth /2 ) );//Width vibe check  -->Change this to make specific for your given shape
      rectCollisionCond2 = ( abs( relativePosEntity.y - relativeObjPosTemp.y +vel.y ) <= ( wallHeight/2 ) );//Height vibe check -->"" ""
      if( rectCollisionCond1 && rectCollisionCond2 )//If within width and height specified
      {
        return true;
      }
      else
      {
        return false;
      }
    }
    if (n==12)
    {
      pushStyle();                                                //*****//
      fill(150,255,150);                                          //*****//
      ellipse(relativeObjPosTemp.x,relativeObjPosTemp.y, 10,10);  //*****//
      popStyle();                                                 //*****//

      rectCollisionCond1 = ( abs( relativePosEntity.x - relativeObjPosTemp.x +vel.x ) <= ( wallWidth /2 ) );//Width vibe check  -->Change this to make specific for your given shape
      rectCollisionCond2 = ( abs( relativePosEntity.y - relativeObjPosTemp.y +vel.y ) <= ( wallHeight/2 ) );//Height vibe check -->"" ""
      if( rectCollisionCond1 && rectCollisionCond2 )//If within width and height specified
      {
        return true;
      }
      else
      {
        return false;
      }
    }
    if (n==13)
    {
      pushStyle();                                                //*****//
      fill(150,255,150);                                          //*****//
      ellipse(relativeObjPosTemp.x,relativeObjPosTemp.y, 10,10);  //*****//
      popStyle();                                                 //*****//
     
      rectCollisionCond1 = ( abs( relativePosEntity.x - relativeObjPosTemp.x +vel.x ) <= ( wallWidth /2 ) );//Width vibe check  -->Change this to make specific for your given shape
      rectCollisionCond2 = ( abs( relativePosEntity.y - relativeObjPosTemp.y +vel.y ) <= ( wallHeight/2 ) );//Height vibe check -->"" ""
      if( rectCollisionCond1 && rectCollisionCond2 )//If within width and height specified
      {
        return true;
      }
      else
      {
        return false;
      }
    }
    if (n==15)  //Invisible collider, for multi-tiles
    {
      pushStyle();                                                //*****//
      fill(150,255,150);                                          //*****//
      ellipse(relativeObjPosTemp.x,relativeObjPosTemp.y, 10,10);  //*****//
      popStyle();                                                 //*****//
     
      rectCollisionCond1 = ( abs( relativePosEntity.x - relativeObjPosTemp.x +vel.x ) <= ( wallWidth /2 ) );//Width vibe check  -->Change this to make specific for your given shape
      rectCollisionCond2 = ( abs( relativePosEntity.y - relativeObjPosTemp.y +vel.y ) <= ( wallHeight/2 ) );//Height vibe check -->"" ""
      if( rectCollisionCond1 && rectCollisionCond2 )//If within width and height specified
      {
        return true;
      }
      else
      {
        return false;
      }
    }
    if (n==16)
    {
      pushStyle();                                                //*****//
      fill(150,255,150);                                          //*****//
      ellipse(relativeObjPosTemp.x,relativeObjPosTemp.y, 10,10);  //*****//
      popStyle();                                                 //*****//
     
      rectCollisionCond1 = ( abs( relativePosEntity.x - relativeObjPosTemp.x +vel.x ) <= ( wallWidth /2 ) );//Width vibe check  -->Change this to make specific for your given shape
      rectCollisionCond2 = ( abs( relativePosEntity.y - relativeObjPosTemp.y +vel.y ) <= ( wallHeight/2 ) );//Height vibe check -->"" ""
      if( rectCollisionCond1 && rectCollisionCond2 )//If within width and height specified
      {
        return true;
      }
      else
      {
        return false;
      }
    }
    if (n==17)
    {
      pushStyle();                                                //*****//
      fill(150,255,150);                                          //*****//
      ellipse(relativeObjPosTemp.x,relativeObjPosTemp.y, 10,10);  //*****//
      popStyle();                                                 //*****//
     
      rectCollisionCond1 = ( abs( relativePosEntity.x - relativeObjPosTemp.x +vel.x ) <= ( wallWidth /2 ) );//Width vibe check  -->Change this to make specific for your given shape
      rectCollisionCond2 = ( abs( relativePosEntity.y - relativeObjPosTemp.y +vel.y ) <= ( wallHeight/2 ) );//Height vibe check -->"" ""
      if( rectCollisionCond1 && rectCollisionCond2 )//If within width and height specified
      {
        return true;
      }
      else
      {
        return false;
      }
    }

  }
  return false; //If it finds no other solution (e.g nothing there to collide with / n==0, => keep vel the same)
}



void drawEmpty(PVector pos, int n){
  //Has spaces => draw floor
  drawFloor(pos, n);
}

void drawWall(PVector pos, int n){
  relativeObjPos = findRelativeCoordinates(n);
  borderIndicesFinal = findTileBorder(n, 1);//At n, looking for index 1 (wall)
  pushStyle();
  imageMode(CENTER);
  if(borderIndicesFinal.get(7) == 1)  //If tile below is a wall, this is a middle wall
  {
    image(magicWallHidden, relativeObjPos.x, relativeObjPos.y);
  }
  else
  {
    image(magicWallMiddle, relativeObjPos.x, relativeObjPos.y);
  }
  popStyle();
}

//1--2   quad(1,2,3,4)
//|  |
//4--3, quad coordinate labelling

//##POSSIBLY CHANGE TO LINES##//
//#### TRY TO USE RECTS FOR EASE OF ADDING TEXTURES ####//

void drawBarrel(PVector pos, int n){
  //Has spaces => draw floor
  drawFloor(pos, n);
  
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  //fill(210,170,30);
  //stroke(40);
  //ellipse(relativeObjPos.x, relativeObjPos.y,  wallWidth/2, wallHeight/2);
  imageMode(CENTER);
  image(magicBarrel, relativeObjPos.x, relativeObjPos.y);
  popStyle();
}

void drawDoor(PVector pos, int n){ //##BREAKS IF TWO DOORS POSSIBLE##//
  //Has spaces => draw floor
  drawFloor(pos, n);

  relativeObjPos = findRelativeCoordinates(n);
  borderIndicesFinal = findTileBorder(n, 1);//At n, looking for index 1 (wall)
  pushStyle();
  imageMode(CENTER);
  doorJoined = false;
  if( ((borderIndicesFinal.get(1) == 0)&&(borderIndicesFinal.get(3) == 1)) && ((borderIndicesFinal.get(5) == 1)&&(borderIndicesFinal.get(7) == 0)) )     //Right corner (UP DWN)
  {
    image(magicDoor, relativeObjPos.x, relativeObjPos.y);
    doorJoined = true;
  }
  if( ((borderIndicesFinal.get(1) == 1)&&(borderIndicesFinal.get(3) == 0)) && ((borderIndicesFinal.get(5) == 0)&&(borderIndicesFinal.get(7) == 1)) )     //Right corner (UP DWN)
  {
    image(magicDoorSideway, relativeObjPos.x, relativeObjPos.y);
    doorJoined = true;
  }
  if(doorJoined == false)
  {
    image(magicDoor, relativeObjPos.x, relativeObjPos.y);
  }
  popStyle();
}
//##MAKE DOORS TILE TOGETHER IN STRIAGHT LINES ONLY##//

void drawTable(PVector pos, int n){
  //Has spaces => draw floor
  drawFloor(pos, n);
  
  borderIndicesFinal = findTileBorder(n, 4);
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  imageMode(CENTER);
  image(magicTable, relativeObjPos.x, relativeObjPos.y);
  popStyle();
}
//##TILE TOGETHER IN RECTANGLES ONLY##//


void drawStool(PVector pos, int n){
  //Has spaces => draw floor
  drawFloor(pos, n);
  
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  //fill(255,255,255);
  //stroke(40);
  //ellipse(relativeObjPos.x, relativeObjPos.y,  wallWidth/2, wallHeight/2);
  imageMode(CENTER);
  image(magicStool, relativeObjPos.x, relativeObjPos.y);
  popStyle();
}

void drawCounter(PVector pos, int n){
  //Has spaces => draw floor
  drawFloor(pos, n);
  
  relativeObjPos = findRelativeCoordinates(n);
  borderIndicesFinal = findTileBorder(n, 6);
  //squarePos = findSquarePosition(borderIndicesFinal);        //##MAY WORK, LIKELY NOT##//
  
  pushStyle();
  imageMode(CENTER);
  counterJoined = false;
  if( ((borderIndicesFinal.get(1) == 1)&&(borderIndicesFinal.get(3) == 1)) && ((borderIndicesFinal.get(5) == 0)&&(borderIndicesFinal.get(7) == 0)) )     //Right corner (UP)
  {
    image(magicCounterCornerRight, relativeObjPos.x, relativeObjPos.y);
    counterJoined = true;
  }
  if( ((borderIndicesFinal.get(1) == 1)&&(borderIndicesFinal.get(3) == 0)) && ((borderIndicesFinal.get(5) == 1)&&(borderIndicesFinal.get(7) == 0)) )     //Left corner (UP)
  {
    image(magicCounterCornerLeft, relativeObjPos.x, relativeObjPos.y);
    counterJoined = true;
  }
  if( ((borderIndicesFinal.get(1) == 0)&&(borderIndicesFinal.get(3) == 1)) && ((borderIndicesFinal.get(5) == 0)&&(borderIndicesFinal.get(7) == 1)) )     //Right corner (DWN)
  {
    image(magicCounterCornerRightDown, relativeObjPos.x, relativeObjPos.y);
    counterJoined = true;
  }
  if( ((borderIndicesFinal.get(1) == 0)&&(borderIndicesFinal.get(3) == 0)) && ((borderIndicesFinal.get(5) == 1)&&(borderIndicesFinal.get(7) == 1)) )     //Left corner (DWN)
  {
    image(magicCounterCornerLeftDown, relativeObjPos.x, relativeObjPos.y);
    counterJoined = true;
  }
  if( ((borderIndicesFinal.get(1) == 1)&&(borderIndicesFinal.get(3) == 1)) && ((borderIndicesFinal.get(5) == 0)&&(borderIndicesFinal.get(7) == 1)) )     //Right corner (UP DWN)
  {
    image(magicCounterCornerRightUpDown, relativeObjPos.x, relativeObjPos.y);
    counterJoined = true;
  }
  if( ((borderIndicesFinal.get(1) == 1)&&(borderIndicesFinal.get(3) == 0)) && ((borderIndicesFinal.get(5) == 1)&&(borderIndicesFinal.get(7) == 1)) )     //Left corner (UP DWN)
  {
    image(magicCounterCornerLeftUpDown, relativeObjPos.x, relativeObjPos.y);
    counterJoined = true;
  }
  if( ((borderIndicesFinal.get(1) == 1)&&(borderIndicesFinal.get(3) == 0)) && ((borderIndicesFinal.get(5) == 0)&&(borderIndicesFinal.get(7) == 1)) )     //Vertical hidden
  {
    image(magicCounterHidden, relativeObjPos.x, relativeObjPos.y);
    counterJoined = true;
  }
  if( ((borderIndicesFinal.get(1) == 0)&&(borderIndicesFinal.get(3) == 0)) && ((borderIndicesFinal.get(5) == 0)&&(borderIndicesFinal.get(7) == 1)) )     //End Upper
  {
    image(magicCounterUpper, relativeObjPos.x, relativeObjPos.y);
    counterJoined = true;
  }
  if( ((borderIndicesFinal.get(1) == 1)&&(borderIndicesFinal.get(3) == 0)) && ((borderIndicesFinal.get(5) == 0)&&(borderIndicesFinal.get(7) == 0)) )     //End lower
  {
    image(magicCounterLower, relativeObjPos.x, relativeObjPos.y);
    counterJoined = true;
  }
  if( ((borderIndicesFinal.get(1) == 0)&&(borderIndicesFinal.get(3) == 1)) && ((borderIndicesFinal.get(5) == 1)&&(borderIndicesFinal.get(7) == 0)) )     //Middle
  {     
    image(magicCounterMiddle, relativeObjPos.x, relativeObjPos.y);
  }
  if( ((borderIndicesFinal.get(1) == 0)&&(borderIndicesFinal.get(3) == 0)) && ((borderIndicesFinal.get(5) == 1)&&(borderIndicesFinal.get(7) == 0)) )     //Middle
  {     
    image(magicCounterMiddle, relativeObjPos.x, relativeObjPos.y);
  }
  if( ((borderIndicesFinal.get(1) == 0)&&(borderIndicesFinal.get(3) == 1)) && ((borderIndicesFinal.get(5) == 0)&&(borderIndicesFinal.get(7) == 0)) )     //Middle
  {     
    image(magicCounterMiddle, relativeObjPos.x, relativeObjPos.y);
  }
  if( ((borderIndicesFinal.get(1) == 0)&&(borderIndicesFinal.get(3) == 0)) && ((borderIndicesFinal.get(5) == 0)&&(borderIndicesFinal.get(7) == 0)) )     //Middle
  {     
    image(magicCounterMiddle, relativeObjPos.x, relativeObjPos.y);
  }
  
  popStyle();
}

void drawTree(PVector pos, int n){
  //Has spaces => draw floor
  drawFloor(pos, n);
  
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  imageMode(CENTER);
  //## WILL EXTEND ABOVE MULTIPLE TILES ##//
  image(tree, relativeObjPos.x, relativeObjPos.y);
  popStyle();
}

void drawLrgTree(PVector pos, int n){
  //Has spaces => draw floor
  drawFloor(pos, n);
  
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  imageMode(CORNER);
  //## WILL EXTEND ABOVE MULTIPLE TILES ##//
  image(lrgTree, relativeObjPos.x-(3*wallWidth), relativeObjPos.y-(3*wallWidth));
  popStyle();
}

void drawWater(PVector pos, int n){
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  imageMode(CENTER);
  fill(100,100,255);
  if(n>=colNum)
  {
    if(Tiles.get(n-colNum).index == 9)
    {
      image(waterCenter, relativeObjPos.x, relativeObjPos.y);
    }
    else
    {
      image(waterFront, relativeObjPos.x, relativeObjPos.y);
    }
  }
  popStyle();
}

void drawPump(PVector pos, int n){
  //Has spaces => draw floor
  drawFloor(pos, n);
  
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  imageMode(CENTER);
  
  //fill(230,170,80);
  //ellipse(relativeObjPos.x, relativeObjPos.y, wallWidth/2, wallHeight/2);
  image(pump, relativeObjPos.x, relativeObjPos.y);
  
  popStyle();
}

void drawVat(PVector pos, int n){
  //Has spaces => draw floor
  drawFloor(pos, n);
  
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  imageMode(CENTER);
  
  //fill(100,150,200);
  //ellipse(relativeObjPos.x, relativeObjPos.y, wallWidth/2, wallHeight/2);
  image(vat, relativeObjPos.x, relativeObjPos.y);
  
  popStyle();
}

void drawMachinery(PVector pos, int n){
  //Has spaces => draw floor
  drawFloor(pos, n);
  
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  imageMode(CENTER);
  rectMode(CENTER);
  
  //fill(232, 63, 105);
  //rect(relativeObjPos.x, relativeObjPos.y, wallWidth, wallHeight);
  image(machinery, relativeObjPos.x, relativeObjPos.y);
  
  popStyle();
}

void drawField(PVector pos, int n){
  //Has spaces => draw floor
  drawFloor(pos, n);
  
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  rectMode(CENTER);
  imageMode(CENTER);
  
  //noFill();
  //rect(relativeObjPos.x, relativeObjPos.y, wallWidth-10, wallHeight-10);
  image(field, relativeObjPos.x, relativeObjPos.y);
  
  popStyle();
}

void drawInvisibleCollider(PVector pos, int n){  //Is invisible -> used for multi-tiles
  //Has spaces => draw floor
  drawFloor(pos, n);

  //################################################################################
  //## MAKE MORE EFFICIENT BY ONLY DOING THIS ONCE OUT OF ALL OF THE INVISFILLERS ## --> also don't draw certain floors
  //################################################################################
  if(Tiles.get(n).hiddenTileOrigin != -1)  //## SHOULD NOT BE NECESSARY, JUST A FAILSAFE ##
  {
    Tiles.get( Tiles.get(n).hiddenTileOrigin ).drawIndex();
  }
  //################################################################################
  //## MAKE MORE EFFICIENT BY ONLY DOING THIS ONCE OUT OF ALL OF THE INVISFILLERS ## --> also don't draw certain floors
  //################################################################################
  
  //**WILL ONLY EVER BE CALLED FOR BUG FIXING**//
  /*
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  
  fill(0);
  ellipse(relativeObjPos.x, relativeObjPos.y, wallWidth/2, wallHeight/2);
  
  popStyle();
  */
}

void drawFireContained(PVector pos, int n){
  //Has spaces => draw floor
  drawFloor(pos, n);
  
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  imageMode(CENTER);
  
  image(fireContained, relativeObjPos.x, relativeObjPos.y);
  
  popStyle();
}

//Multi-Tile
void drawTradingOutpost(PVector pos, int n){
  //Has spaces => draw floor
  drawFloor(pos, n);
  
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  imageMode(CENTER);  //##CORNER NOT WORKING CORRECTLY
  
  //Trading outpost on eastern part of map
  image(tradingOutpost, relativeObjPos.x-(3*wallWidth), relativeObjPos.y-(3*wallHeight));
  
  popStyle();
}

void drawPort(PVector pos, int n){
  //Has spaces => draw floor
  drawFloor(pos, n);
  
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  imageMode(CENTER);  //##CORNER NOT WORKING CORRECTLY
  
  //Port on western part of map
  image(port, relativeObjPos.x-(4*wallWidth), relativeObjPos.y-(4*wallHeight));
  
  popStyle();
}
//###########################################################//
//##FIX MULTITILES NOT BEING DRAWN WHEN MOVING OUT OF FRAME##//
//###########################################################//

void drawFloor(PVector pos, int n){
  if (Tiles.get(n).floorInd == 0) //Natural floor
  {
    relativeObjPos = findRelativeCoordinates(n);
    borderIndicesFinal = findTileBorder(n, 6);
    tileset = (Tiles.get(n).tSetF);
    pushStyle();
    imageMode(CENTER);
    if ( (0  <= tileset) && (tileset < 85) ){                                               //85% chance
      image(naturalFloorPlain, relativeObjPos.x, relativeObjPos.y);}
    if ( (85 <= tileset) && (tileset < 95) ){                                               //10% chance
      image(naturalFloorFlowered, relativeObjPos.x, relativeObjPos.y);}
    if ( (95 <= tileset) && (tileset < 100) ){                                              //5% chance
      image(naturalFloorStone, relativeObjPos.x, relativeObjPos.y);}
    popStyle();
  }
  
  if (Tiles.get(n).floorInd == 1) //Magic floor
  {
    relativeObjPos = findRelativeCoordinates(n);
    borderIndicesFinal = findTileBorder(n, 6);
    tileset = (Tiles.get(n).tSetF);
    pushStyle();
    imageMode(CENTER);
    //tSet currently ranges from 
    if ( (0  <= tileset) && (tileset < 88) ){                                                      
      //88% chance
      image(magicFloorPlain, relativeObjPos.x, relativeObjPos.y);}
    if ( (88 <= tileset) && (tileset < 98) ){                                                      //10% chance
      image(magicFloorBricked, relativeObjPos.x, relativeObjPos.y);}
    if ( (98 <= tileset) && (tileset < 100) ){                                                     //2% chance
      image(magicFloorFancy, relativeObjPos.x, relativeObjPos.y);}
    popStyle();
  }
}


void drawSquareMultiTile(PVector pos, int n){ //For all multi-tile structures, given index in here
  //->'p' is multiWidth, 'q' is multiHeight, 'ind' is the index of the multi-tile, n is tile number pressed over
  relativeObjPos = findRelativeCoordinates(n);  
  borderIndicesFinal = findTileBorder(n, 7);
  
  imageMode(CENTER);
  pushStyle();
  //fill(255,200,200);                                               //*****//
  //ellipse(relativeObjPos.x, relativeObjPos.y, 10,10);              //*****//
  squarePos = findSquarePosition(borderIndicesFinal);
  
  if( squarePos==0 ){
  image(test1, relativeObjPos.x, relativeObjPos.y);}
  if( squarePos==1 ){
  image(test2, relativeObjPos.x, relativeObjPos.y);}
  if( squarePos==2 ){
  image(test3, relativeObjPos.x, relativeObjPos.y);}
  //---
  if( squarePos==3 ){
  image(test4, relativeObjPos.x, relativeObjPos.y);}
  if( squarePos==4 ){
  image(test5, relativeObjPos.x, relativeObjPos.y);}
  if( squarePos==5 ){
  image(test6, relativeObjPos.x, relativeObjPos.y);}
  //---
  if( squarePos==6 ){
  image(test7, relativeObjPos.x, relativeObjPos.y);}
  if( squarePos==7 ){
  image(test8, relativeObjPos.x, relativeObjPos.y);}
  if( squarePos==8 ){
  image(test9, relativeObjPos.x, relativeObjPos.y);}
  
  popStyle();
  
  //## POSSIBLY MAKE IT DIFFERENTIATE BETWEEN ADJECENT MULTI-TILES, SO NO SPLICING OCCURS, ??HOWEVER COULD BE GOOD?? ##//
  //## MAKE ALL TILES IN 3X3 REVERT BACK (TO SOMETHING) WHEN ONE OF THEM IS CHANGED ##//
}

/*#####################################################
1. Add new "void draw..." -> specify shape here
(2.) Add "drawFloor" function if the texture has spaces where floor is visible (e.g not walls)
3. Add "n==..." in 'Grid' for this item's key
(4.) Add to collision lost in "Index" if needed, and therefore add collison condition above in 'collide' section
5. Add 'collideables' in index for collision

->If a multi-tile
1. Add ghost in "Overlays"
2. Add its draw normally (in this file)
3. Add placing in "key_bindings", multi-tile section
#####################################################*/
