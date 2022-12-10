//Grid background
class Tile{
  PVector pos;
  PVector pipeInd      = new PVector(-1,-1);    //Where the pipe present on this tile is in the 'pipeNetwork' ArrayList, -1 means no pipe present
  PVector cropInd      = new PVector(-1,-1);    //Which crop the tile contains (-1 means no crop)
  PVector containerInd = new PVector(-1,-1);    //Index in containerInd, specifying the storage type and its index in that type

  boolean edgeWater;
  boolean pathChecked = false;
  boolean tileUsed    = false;

  int inputterInd = -1;  //Index in __List if the tile is an inputter (vatList, machineryList)
  int n;
  int index;                  //Determines which object is present on the tile, e.g,walls, doors, barrels, etc
  int tSetF;                  //Determines the textures used for the tile floor
  int tSetO;                  //Determines the textures used for the tile object
  int floorInd;               //Determines floor texture used, so floor and building can superimpose
  int pathLast         = -2;  //Used for pathing, determining which tile this tile was travelled to from
  int hiddenTileOrigin = -1;  //Points to the tile in the multi-tile that is drawing the texture

  float runningWeight = 0;  //Used to determine how far away a path chain has travelled from its starting point (NOT including its distance from the destination)
  //Prob     = deciding which type of given obj is used, e.g 1 of 3ish variable textures
  //t        = deciding which object to use, e.g a grassy floor/wall or magic floor/wall => separated (from floor probability) for more variety
  //Index    = tile obj
  //floorInd = tile floor
  
  Tile(int tileNumber, PVector tilePosition, int probChosenFloor, int probChosenObj, int initialTileIndex){
    index    = initialTileIndex;  //Initialised as with no object
    floorInd = 0;  //Initialised as grass floor (##CAN BE SELECTED IN FUTURE, IF SNOWY/MOSSY/ETC FLOORS INTRODUCED##)
    n        = tileNumber;
    pos      = tilePosition;
    tSetF    = probChosenFloor;
    tSetO    = probChosenObj;
  }
  void drawIndex(){
    updateTileInfo(n);
    if(index==0){
      drawEmpty(pos, n);}
    if(index==1){
      drawWall(pos, n);}
    if(index==2){
      drawBarrel(pos, n);
      addBarrelToList(pos, n);}
    if(index==3){
      drawDoor(pos, n);}
    if(index==4){
      drawTable(pos, n);}
    if(index==5){
      drawStool(pos, n);}
    if(index==6){
      drawCounter(pos, n);}
    if(index==7){
      drawSquareMultiTile(pos, n);}
    if(index==8){
      drawTree(pos, n);}
    if(index==9){
      drawWater(pos, n);}
    if(index==10){
      drawLrgTree(pos, n);}
    if(index==11){
      drawPump(pos, n);
      addPumpToList(pos, n);}
    if(index==12){
      drawVat(pos, n);
      addVatToList(pos, n);}
    if(index==13){
      drawMachinery(pos, n);
      addMachineryToList(pos, n);}
    if(index==14){
      drawField(pos, n);}
    if(index==15){
      drawInvisibleCollider(pos, n);}
    if(index==16){
      drawFireContained(pos, n);}
    if(index==17){
      drawTradingOutpost(pos, n);}
    if(index==18){
      drawPort(pos, n);}
  }
}

//##HYPER SMALL BRAIN JANK, REMOVE AND REPLACE AS SOON AS POSSIBLE##//
void updateTileInfo(int n){
  //Sorts out the removal and listInd of vats and machinery
  //n = tile number        //*************************************************************//
  if( (12<=n) && (n<=13) )  //** this will need to be updated if more inputters are added**//
  {
    if(Tiles.get(n).inputterInd > -1)  //If there was a vat here...
    {
      for(int i=Tiles.get(n).inputterInd+1; i<vatList.size(); i++)//Shift other values
      {
        Tiles.get( vatList.get(i).tileNum ).inputterInd -= 1;
      }
      //println("VAT BEING REMOVED");                //*****//
      vatList.remove( Tiles.get(n).inputterInd );        //Remove from list
      Tiles.get(n).inputterInd = -1;                     //Reset to being not been an inputter
    }
  }
  if( (12<=n) && (n<=13) )  //** this will need to be updated if more inputters are added**//
  {
    if(Tiles.get(n).inputterInd > -1)  //If there was machinery here...
    {
      for(int i=Tiles.get(n).inputterInd+1; i<machineryList.size(); i++)//Shift other values
      {
        Tiles.get( machineryList.get(i).tileNum ).inputterInd -= 1;
      }
      //println("MACHINERY BEING REMOVED");          //*****//
      machineryList.remove( Tiles.get(n).inputterInd );  //Remove from list
      Tiles.get(n).inputterInd = -1;                     //Reset to being not been an inputter
    }
  }
}

//Forms a blank environment (grass center, water at edge)
void formGridArray(){
  for (int j=0; j<rowNum; j++)
  {
    
    for (int i=0; i<colNum; i++)
    {
      //RANDOMS ARE 1 ABOVE MAX TILE INDEX, DUR TO FLOORING ##CHANGING TO ROUND IS PROBABLY BETTER##
      //If at edge (water)
      if( ( (ceil(i*wallWidth) < edgeTolerance)||(floor(i*wallWidth) > (boardWidth-edgeTolerance)) ) || ( (ceil(j*wallHeight) < edgeTolerance)||(floor(j*wallHeight) > (boardHeight-edgeTolerance)) ) ){
      Tile currentTileAdded = new Tile( ( (colNum*j)+(i) ),  ( new PVector(( (wallWidth*i) + wallWidth/2 ), ( (wallHeight*j) + wallHeight/2 ) )), floor( random(0,100) ), floor( random(0,200) ), 9 );
      Tiles.add( currentTileAdded );
      Tiles.get( (colNum*j)+(i) ).edgeWater = true;}
      //If not at edge (grass)
      else{
      Tile currentTileAdded = new Tile( ( (colNum*j)+(i) ),  ( new PVector(( (wallWidth*i) + wallWidth/2 ), ( (wallHeight*j) + wallHeight/2 ) )), floor( random(0,100) ), floor( random(0,200) ), 0 );
      Tiles.add( currentTileAdded );
      Tiles.get( (colNum*j)+(i) ).edgeWater = false;}
    }
  }
}

void drawGridIndex(){
  
  //##MAY BE ERRORS WITH BOOLEAN, 2 IN ONE##
  screenEdgeCond1 = ( ( user.pos.x +user.vel.x ) <= ( edgeTolerance ) )               || ( ( user.pos.y +user.vel.y ) <= ( edgeTolerance ) ); //To the top-side and left-side
  screenEdgeCond2 = ( ( user.pos.x +user.vel.x ) >= ( screenWidth - edgeTolerance ) ) || ( ( user.pos.y +user.vel.y ) >= ( screenHeight - edgeTolerance ) );//To the bottom-side and right-side
  
  boardEdgeCond1 = ( ( relativePos.x - screenWidth /2 + user.vel.x) > ( 0 ) ) && ( ( relativePos.x + screenWidth /2 + user.vel.x) < ( boardWidth  ) );
  boardEdgeCond2 = ( ( relativePos.y - screenHeight/2 + user.vel.y) > ( 0 ) ) && ( ( relativePos.y + screenHeight/2 + user.vel.y) < ( boardHeight ) );

  //##CANT GO BEYOND TOLERANCE, BUT NO JANK##(--2--)//
  if(screenEdgeCond1 || screenEdgeCond2)
  {
    relativePos.x += user.vel.x;
    relativePos.y += user.vel.y;
    user.pos.x    -= user.vel.x;
    user.pos.y    -= user.vel.y;
    followerU.pos.x    -= user.vel.x;
    followerU.pos.y    -= user.vel.y;
    if( ( relativePos.x+screenWidth /2 + user.vel.x ) > (boardWidth) ) //X cond
    {
      relativePos.x = boardWidth-screenWidth/2;
      //user.pos.x    += user.vel.x;
      //user.pos.y    += user.vel.y;
    }
    if( ( relativePos.x-screenWidth /2 + user.vel.x ) < (0) )          //X cond
    {
      relativePos.x = screenWidth/2;
      //user.pos.x    += user.vel.x;
      //user.pos.y    += user.vel.y;
    }
    if( ( relativePos.y+screenHeight/2 + user.vel.x ) > (boardHeight) )//Y cond
    {
      relativePos.y = boardHeight-screenHeight/2;
      //user.pos.x    += user.vel.x;
      //user.pos.y    += user.vel.y;
    }
    if( ( relativePos.y-screenHeight/2 + user.vel.y ) < (0) )          //Y cond
    {
      relativePos.y = screenHeight/2;
      //user.pos.x    += user.vel.x;
      //user.pos.y    += user.vel.y;
    }
  }
  
  //##CANT GO BEYOND TOLERANCE, BUT NO JANK##(--2--)//
    
  
  if ( boardEdgeCond1 || boardEdgeCond2 )//If not at edge of board
  {
    //(1)Find how many columns and rows needed
    colEncounterLower = floor( ( (relativePos.x) - (screenWidth /2) ) / wallWidth );
    colEncounterUpper = ceil ( ( (relativePos.x) + (screenWidth /2) ) / wallWidth );
    rowEncounterLower = floor( ( (relativePos.y) - (screenHeight/2) ) / wallHeight );
    rowEncounterUpper = ceil ( ( (relativePos.y) + (screenHeight/2) ) / wallHeight );
    //println("colLower; ",colEncounterLower);    //*****//
    //println("rowLower; ",rowEncounterLower);    //*****//
    //println("{}");                              //*****//
    //println("colUpper; ",colEncounterUpper);    //*****//
    //println("rowUpper; ",rowEncounterUpper);    //*****//
    
    //     <--->
    //     <--------->
    // +  +
    // |  |
    // +  |        n
    //    |      0XXX
    //    |    m XXXX
    //    +      XXX1
    
    //(2)Establish start and end tiles
    startTile = ( colEncounterLower ) + ( colNum )*( rowEncounterLower ); //Labelled 0, will usually be half off-screen
    userTile  = ceil( (colNum)*( (rowEncounterLower) + ((user.pos.y)*(wallHeight))/(screenRows) ) + 
                  ( (( colEncounterLower ) + ( (user.pos.x)*(wallWidth) )/(screenCols)) ) ); //The tile of the user //##NOT CURRENTLY USED##//
    
    //(3)Draw between the established tiles
    for (int j=0; j<screenRows; j++)
    {
      for (int i=0; i<screenCols; i++)
      {
        pushStyle();
        noFill();
        stroke(180);
        pushMatrix();
        rectMode(CENTER);
        tileToDraw = startTile + ((j)*(colNum))+(i);
        if ( (tileToDraw > 0) && (tileToDraw < colNum*rowNum)) //To prevent errors trying to drawn -ve indices
        {
          Tiles.get( tileToDraw ).drawIndex();
        }
        popMatrix();
        popStyle();
      }
    }
    
    //* * * * *
    //* * * * *
    //* * X * *
    //* * * * *
    //* * * * * => centered (not at edge of board)
  }
  else
  {
    //## MAY NOT BE NEEDED, SEEMS TO ALREADY BE DEALING WITH IT (MOSTLY, STILL GETS STUCK ON EDGE) ##//
    
    //- - - - -
    //- * * * *
    //- * X * *
    //- * * * *
    //- * * * * => not centered (at edge of board)
  }
  
}
//##NEEDS TO ONLY DRAW THE TILES VISIBLE##//
//##SCREEN DRAW MOVES WITH USER TO CENTER USER, UNTIL AT EDGE THEN USER SHOULD NOT BE CENTERED##//

void drawGridBoxes(){
  for (int j=0; j<screenRows; j++)
  {
    for (int i=0; i<screenCols; i++)
    {
      pushStyle();
      noFill();
      stroke(180);
      pushMatrix();
      rectMode(CENTER);
      tileToDraw = startTile + ((j)*(colNum))+(i);
      if ( (tileToDraw > 0) && (tileToDraw < rowNum*colNum) )
      {
        relativeObjPos = findRelativeCoordinates(tileToDraw);
        rect(relativeObjPos.x, relativeObjPos.y, (wallWidth), (wallHeight));
        text(Tiles.get(tileToDraw).n, relativeObjPos.x -wallWidth/4, relativeObjPos.y);
      }
      
      popMatrix();
      popStyle();
    }
  }
}

//Find grid center
void findGridCenter(){
  for (int j=0; j<rowNum; j++) //## CAN MAKE MORE EFFICIENT , BUT TOO SMALL BRAIN (IS CHECKING ALL ROWS, ONLY NEEDS TO CHECK IN SCREEN AREA) ##//
  {  
    if ( ((mouseY-screenHeight/2)+relativePos.y > (wallHeight*j) ) && ((mouseY-screenHeight/2)+relativePos.y <= (wallHeight*(j+1)) ) )
    {
      centerY = ( screenHeight/2 ) - ( relativePos.y - ( wallHeight*j ) ) + wallHeight/2;
      centerXY.y = int(j);
      break;
    }  
  }
  for (int i=0; i<colNum; i++)
  {
    if ( ((mouseX-screenWidth/2)+relativePos.x > (wallWidth*i) ) && ((mouseX-screenWidth/2)+relativePos.x <= (wallWidth*(i+1)) ) )
    {
      centerX = ( screenWidth/2 ) - ( relativePos.x - ( wallWidth*i ) ) + wallWidth/2;
      centerXY.x = int(i);
      break;
    }
  }
  //println("CenterXY; ", centerX," , " ,centerY);           //*****//
}
//## IS FINDING CENTRES, BUT NOT AT MOUSE ##//

//Draw grid center
void drawGridCenter(){
  pushStyle();
  fill(255);
  ellipse(centerX, centerY, 10, 10);
  popStyle();
}
//##ADD PULSATING EFFECT, USING SINUSOIDAL##//
