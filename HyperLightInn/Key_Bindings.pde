void keyPressed(){
  mouseTile = findMouseTile();

  //----------------------------//
  //## Available in all modes ##//
  //----------------------------//
  allModePressCommands();

  //----------------------//
  //## Exploration mode ##//
  //----------------------//
  if(modeSelector == 0)
  {
    explorationModePressCommands();  
  }  

  //-------------------//
  //## Building mode ##//
  //-------------------//
  if(modeSelector == 1)
  {
    buildingModePressCommands();
  }

  //-----------------//
  //## Piping mode ##//
  //-----------------//
  if(modeSelector == 2)
  {
    pipingModePressCommands();
  }

  //---------------//
  //## Crop mode ##//
  //---------------//
  if(modeSelector == 3)
  {
    cropModePressCommands();
  }
  
}


void keyReleased(){
  movementReleaseCommands();
}


void mousePressed(){
  //--------// HOME SCREEN //--------//
  if(homeScreen == true)
  {
    inHomeCommands();  
  }
  //--------//   OPTIONS   //--------//
  if(optionsScreen == true)
  {
    inOptionsCommands();   
  }
  //--------//    GAME     //--------//
  if( (homeScreen == false) && (optionsScreen == false) ) //If in-game...
  {
    inGameMouseCommands();
  }
  //--------// ClickSounds //-------//
  playClickSounds();
    
}


//** +ve getCount = scroll down (towards you)
//** -ve getCount = scroll up (away from you)
void mouseWheel(MouseEvent event){
  if(scannerToggle == true)
  {
    calcScannerType( event.getCount() );
  }
  
}


void allModePressCommands(){

  if (key == '0'){  //Cycle through modes
    modeSelector++;
    if(modeSelector > 3){  //**Increase value when more modes are added**
    modeSelector = 0;}
    //(0)ExplorationMode
    //(1)BuildingMode
    //(2)PipingMode
    //(3)CropMode
  }

  if (key == 'i')
  {
    inventoryScreen =! inventoryScreen;
  }
  if (key == 'u')
  {
    homeScreen =! homeScreen;
    optionsScreen = false;
    indexMenu     = false;
  }
  if (key == 'e')  //Interact button
  {
    //EITHER
    //(1)Add item to inventory
    findHoveredIndex( findMouseTile() );
    
    //(2)OR harvest crop
    if(Tiles.get( findMouseTile() ).cropInd.x > -1){  //If crop here...
    harvestCrop( findMouseTile() );}                  //Try harvest it
    
    //(3)OR open trading outpost shop
    showContainer            = false;
    tradingOutpostMenuToggle = false;
    if( Tiles.get( findMouseTile() ).index == 17 )  //If is a port (DONT WANT regular container actions)
    {
      containerTile            = findMouseTile();
      showContainer            = !showContainer;
      tradingOutpostMenuToggle = !tradingOutpostMenuToggle;
      tradingOutpostInd        = findMouseTile();
    }

    showContainer   = false;
    inventoryScreen = false;
    //(4)OR open container
    if( (Tiles.get( findMouseTile() ).containerInd.x > -1) && (!tradingOutpostMenuToggle) ){ //If is a container...
      containerTile   = findMouseTile();
      showContainer   = !showContainer;
      inventoryScreen = !inventoryScreen;
      
    }

    
    //(5)OR use machine
    //...
  }
  if(key == 'h')  //Hotkey menu toggle
  {
    hotkeyMenuScreen =! hotkeyMenuScreen;
  }
}
void explorationModePressCommands(){
  if (key == 'w')      //Up
  {
    user.vel.y = -user.urgency;
  }
  if (key == 'a')      //Left
  {
    user.vel.x = -user.urgency;
  }
  if (key == 's')      //Down
  {
    user.vel.y =  user.urgency;
  }
  if (key == 'd')      //Right
  {
    user.vel.x =  user.urgency;
  }

  if (key == 't')
  {
    playerTorchActive = !playerTorchActive;
  }
  if (key == 'z')
  {
    user.urgency -= 1;
  }
  if (key == 'x')
  {
    user.urgency += 1;
  }
  if (key == 'o')
  {
    addItemToInventory("Fertiliser", 2, fertiliser);
    addItemToInventory("Seeds", 5, seeds);
    addItemToInventory("Board", 1, test1);
    addItemToInventory("Spade", 1, spade);
  }
  if (key == 'p')
  {
    if(user.inventoryItems.size() > 0)
    {
      user.inventoryItems.remove( user.inventoryItems.size()-1 );
      user.inventoryQuantity.remove( user.inventoryQuantity.size()-1 );
    }
    else
    {
      println("*No items in inventory*");
    }
  }  
  if (key == 'v')
  {
    //if within given area around stats box OR while not moving OR ...
    if(true)
    {
      followerUstatTravel = true;            //Move follower over to "investigate" / display description
      tileStatScreen = true;
      currentStatTile = findMouseTile();
      relativeObjPos = findRelativeCoordinates(currentStatTile); 
      followerWaypointU.x = ( relativeObjPos.x ) - wallWidth /2 -wallWidth /6;
      followerWaypointU.y = ( relativeObjPos.y ) + wallHeight/2 +wallHeight/6;
    }
  }
  if (key == 'b')
  {
    followerUstatTravel = true;   //## To allow him to move freely, should be given a more apprpporiate name ##//
    followerPathFollow = !followerPathFollow;
  }
  if(key == '1')
  {
    if( int(Tiles.get( containerTile ).containerInd.x) > -1 ){ //If a container here...
      exchangeItems( 5, calcInvCursor(), int(Tiles.get( containerTile ).containerInd.x), calcContainerCursor() );
    }
  }
  if (key == 'k')
  {
    println("Filler Event Added");
    eventsShort.add      (0,"New event here");
    eventsDescription.add(0,"The lengthy description of the event in question here, formatted properly");
  }
  if (key == '9')
  {
    increaseFactionInterest(0);
  }
  if (key == '8')
  {
    decreaseFactionInterest(0);
  }
  if (key == '7')
  {
    structureToggle = !structureToggle;
  }
  if (key == '6')
  {
    calcPlaceableStructure();
  }
  if (key == '5')
  {
    println("Drink 1 added to user");
    user.currentDrink.clear();
    user.currentDrink.add(1);   //Type
    user.currentDrink.add(568); //Volume
    user.currentDrink.add(1);   //Bitterness
    user.currentDrink.add(5);   //Sweetness
    user.currentDrink.add(2);   //Alcoholicness
    user.currentDrink.add(8);   //Quality
  }
  if (key == '4')
  {
    for(int i=0; i<entityList.size(); i++) //## VERY INEFFICIENT ##//
    {
      for(int j=0; j<entityList.get(i).size(); j++)
      {
        relativeObjPos = findRelativeCoordinatesEntity( entityList.get(i).get(j).pos );
        if( pow(relativeObjPos.x - mouseX,2) + pow(relativeObjPos.y - mouseY,2) < pow(wallWidth,2) )
        {
          entityList.get(i).get(j).currentDrink.clear();
          for(int z=0; z<user.currentDrink.size(); z++){
            entityList.get(i).get(j).currentDrink.add( user.currentDrink.get(z) );
          }
          println("Drink given to entity");
          break;
        }
      }
    }
  }

  if (key == 'm')
  {
    scannerToggle = !scannerToggle;

    //#### CAN OPTIMISE BY SAYING ONLY DO THE SCAN WHEN OPENING THE SCANNER, NOT WHEN CLOSING IT TOO ####//
    //(1)Reset scanned values
    scannerTile.clear();
    scannerTileQuantity.clear();
    scannerTile.add( Tiles.get(0).index );  //To start off the process
    scannerTileQuantity.add( 0 );           //

    //(2)Re-scan the area, store all values
    for(int i=0; i<Tiles.size(); i++)           //Go through all tiles...
    {
      for(int j=0; j<scannerTile.size(); j++)   //For each, go through all currently scanned tile types recorded...
      {

        //If the tile HAS appeared before...
        if(Tiles.get(i).index == scannerTile.get(j)){
          scannerQuantityTemp = scannerTileQuantity.get(j);
          scannerTileQuantity.remove(j);
          scannerTileQuantity.add(j, scannerQuantityTemp+1);
          break;
        }

        //If the tile HAS NOT appeared before (after reaching end of list)...
        if(j == scannerTile.size() -1){
          scannerTile.add( Tiles.get(i).index );
          scannerTileQuantity.add(1);
          break;
        }
        
      }
    }

  }
}
void buildingModePressCommands(){
  //##ADD SCREEN DARKENING EDGE EFFECT, SLIGHTLY DIFFERENTLY HOWEVER##//
  if (key == '1'){
    pieToggle = !pieToggle;}
  if (key == '2'){
    catalogueToggle = !catalogueToggle;}

  
  if (key == 'k')
  {
    Tiles.get( mouseTile ).tSetF -= 1;
  }
  if (key == 'j')
  {
    Tiles.get( mouseTile ).tSetF += 1;
  }
  if (key == 'h')
  {
    Tiles.get( mouseTile ).tSetO -= 1;
  }
  if (key == 'g')
  {
    Tiles.get( mouseTile ).tSetO += 1;
  }
}
void pipingModePressCommands(){
  networkNum = int( Tiles.get(findMouseTile()).pipeInd.x );
  if (key == '1'){      //Place output pipe
    increasePipeNetwork(findMouseTile(), 1);
    calcPipeConnections( networkNum );
    calcPipeStarts();}
  if (key == '2'){      //Place input pipe
    increasePipeNetwork(findMouseTile(), 2);
    calcPipeConnections( networkNum );
    calcPipeStarts();}
  if (key == '3'){      //Place connecting pipe
    increasePipeNetwork(findMouseTile(), 3);
    calcPipeConnections( networkNum );
    calcPipeStarts();}
  if (key == '4'){      //Place connecting pipe
    removePipeNetwork(findMouseTile());
    calcPipeConnections( networkNum );
    calcPipeStarts();}
  if (key == '5'){      //Allow water to flow
    calcPipeConnections( networkNum );
    calcPipePaths( outputPipesTemp, networkNum );
    calcInputFlows();}
  if (key == '6'){      //Toggle fluid display
    showPipeFluidFlow =! showPipeFluidFlow;}
}
void cropModePressCommands(){
  if (key == '1'){      //Increase crop selection
    cropSelector ++;}
  if (key == '2'){      //Decrease crop selection
    cropSelector--;}
  if (key == '3'){      //Place crop selection on hovered field
    placeCrop();}
  if (key == '4'){      //Remove crop from hovered field
    removeCrop( findMouseTile() );}
}

void movementReleaseCommands(){
  if (key == 'w')      //Up
  {
    user.vel.y = 0;
    frameTimerY = 0;
  }
  if (key == 'a')      //Left
  {
    user.vel.x = 0;
    frameTimerX = 0;
  }
  if (key == 's')      //Down
  {
    user.vel.y = 0;
    frameTimerY = 0;
  }
  if (key == 'd')      //Right
  {
    user.vel.x = 0;
    frameTimerX = 0;
  }
}

void addToPieSelector(int ind){
  //Clicking LEFT CLICK adds it to the pie selector
  if( tradingOutpostMenuToggle == true )
  {

    if( catalogueType == 0 )
    {
      user.coins -= (  tileCataloguePrices.get(ind) ) * ( tileCatalogueQuantity.get(ind) );
    }
    if( catalogueType == 1 )
    {
      user.coins -= ( floorCataloguePrices.get(ind) ) * ( floorCatalogueQuantity.get(ind) );
    }
    if( catalogueType == 2 )
    {
      user.coins -= (  itemCataloguePrices.get(ind) ) * ( itemCatalogueQuantity.get(ind) );
    }
    
  }
  pieSelected.get(catalogueType).add( ind );
}

void selectFromPieSelector(){
  //Clicking LEFT CLICK chooses item to be placed + closing selection screen
  //#### CURRENTLY IS NOT SUPPORTING FLOOR PLACEMENT ####//
  if(catalogueType == 0)  //If for tiles...
  {
    if(hoveredIndPie > -1)
    {
      tileIndSel = pieSelected.get(catalogueType).get( hoveredIndPie ) +1; //**Because does not include 0**//
      pieToggle = false;
    }
    if(hoveredIndPie == -2) //Signifies 'removal tool'
    {
      tileIndSel = 0;
      pieToggle = false;
    }
  }
  if(catalogueType == 1)  //If for floors...
  {
    if(hoveredIndPie > -1)
    {
      floorIndSel = pieSelected.get(catalogueType).get( hoveredIndPie );
      pieToggle = false;
    }
    if(hoveredIndPie == -2) //Signifies 'removal tool'
    {
      floorIndSel = 0;
      pieToggle = false;
    }
  }
  
}

void removeFromPieSelector(){
  //Clicking RIGHT CLICK removes the item from the pie selector
  if(hoveredIndPie > -1)  //If anything available to be deleted    //## pieSelected.get(catalogueType).size() > 0 ##// BUSTED ???
  {
    pieSelected.get(catalogueType).remove( hoveredIndPie );
  }
  else
  {
    println("--Pie selector already empty--");
  }
}

void playClickSounds(){
  //Some general sounds on mouse click
  if(homeScreen == true)
  {
    buttonSelectionSound.play();
  }
  else if(inventoryScreen == true)
  {
    openInventorySound.play();
  }
  else
  {

    if(mouseButton == LEFT){
      generalClickSound.play();
    }
    else{
      placeTileSound.play();
    }
    
  }
}

void inHomeCommands(){

  //1 , 2
  //3 , 4
  
  //1st
  if( (  (screenWidth/8-homeButtonWidth/2<mouseX)&&(mouseX<screenWidth/8+homeButtonWidth/2)  )&&(  ((3*screenWidth/8)+(2*homeButtonSpacing)-homeButtonHeight/2 < mouseY)&&(mouseY < ((3*screenWidth/8))+(2*homeButtonSpacing)+homeButtonHeight/2)  ) )//xCond then yCond for 1st box
  {
    println("Click 1st home button");
    homeScreen = false;
  }
  //2nd
  if( (  (7*screenWidth/8-homeButtonWidth/2<mouseX)&&(mouseX<7*screenWidth/8+homeButtonWidth/2)  )&&(  ((3*screenWidth/8)+(2*homeButtonSpacing)-homeButtonHeight/2 < mouseY)&&(mouseY < ((3*screenWidth/8))+(2*homeButtonSpacing)+homeButtonHeight/2)  ) )//xCond then yCond for 1st box
  {
    //##NEEDS SOME TESTING, VERY RUDIMENTARY, NOT COVERING ALL BASES##//
    println("Click 2nd home button");
    entityList.clear();
    Tiles.clear();
    pipeNetwork.clear();
    user.pos.x = screenWidth/2; user.pos.y = screenHeight/2;
    initialiseValues();
    mapGeneration();
    homeScreen = false;
  }
  //3rd
  if( (  (screenWidth/8-homeButtonWidth/2<mouseX)&&(mouseX<screenWidth/8+homeButtonWidth/2)  )&&(  (((3*screenWidth/8))+(4*homeButtonSpacing)-homeButtonHeight/2 < mouseY)&&(mouseY < ((3*screenWidth/8))+(4*homeButtonSpacing)+homeButtonHeight/2)  ) )//xCond then yCond for 1st box
  {
    println("Click 3rd home button");
    optionsScreen = true;
    homeScreen    = false;
  }
  //4th
  if( (  (7*screenWidth/8-homeButtonWidth/2<mouseX)&&(mouseX<7*screenWidth/8+homeButtonWidth/2)  )&&(  (((3*screenWidth/8))+(4*homeButtonSpacing)-homeButtonHeight/2 < mouseY)&&(mouseY < ((3*screenWidth/8))+(4*homeButtonSpacing)+homeButtonHeight/2)  ) )//xCond then yCond for 1st box
  {
    println("Click 4th home button");
    exit();
  }

}

void inOptionsCommands(){

  //  1
  //  2
  //  3
  //  4
  
  //1st
  if( (  (screenWidth/2-homeButtonWidth/2<mouseX)&&(mouseX<screenWidth/2+homeButtonWidth/2)  )&&(  ((screenWidth/8)+(2*homeButtonSpacing)-homeButtonHeight/2 < mouseY)&&(mouseY < (screenWidth/8)+(2*homeButtonSpacing)+homeButtonHeight/2)  ) )//xCond then yCond for 1st box
  {
    println("Click 1st home button");
    optionsScreen = false;
    indexMenu     = true;
  }
  //2nd
  if( (  (screenWidth/2-homeButtonWidth/2<mouseX)&&(mouseX<screenWidth/2+homeButtonWidth/2)  )&&(  ((screenWidth/8)+(4*homeButtonSpacing)-homeButtonHeight/2 < mouseY)&&(mouseY < (screenWidth/8)+(4*homeButtonSpacing)+homeButtonHeight/2)  ) )//xCond then yCond for 1st box
  {
    //##NEEDS SOME TESTING, VERY RUDIMENTARY, NOT COVERING ALL BASES##//
    println("Click 2nd home button");
  }
  //3rd
  if( (  (screenWidth/2-homeButtonWidth/2<mouseX)&&(mouseX<screenWidth/2+homeButtonWidth/2)  )&&(  ((screenWidth/8)+(6*homeButtonSpacing)-homeButtonHeight/2 < mouseY)&&(mouseY < (screenWidth/8)+(6*homeButtonSpacing)+homeButtonHeight/2)  ) )//xCond then yCond for 1st box
  {
    println("Click 3rd home button");
  }
  //4th
  if( (  (screenWidth/2-homeButtonWidth/2<mouseX)&&(mouseX<screenWidth/2+homeButtonWidth/2)  )&&(  ((screenWidth/8)+(8*homeButtonSpacing)-homeButtonHeight/2 < mouseY)&&(mouseY < (screenWidth/8)+(8*homeButtonSpacing)+homeButtonHeight/2)  ) )//xCond then yCond for 1st box
  {
    println("Click 4th home button");
    optionsScreen = false;
    homeScreen    = true;
  }

}

void inGameMouseCommands(){

  if( ((pieToggle == false) && (catalogueToggle == false)) && ((modeSelector == 1) && (mouseButton == LEFT)) )  //Placing tiles --> If in game AND in building mode AND you left click AND the (pie seletcor OR catalogue) are NOT open
  {

    alreadyDrawn = false;
    //---------------------//
    //Multi-Tile conditions//
    //---------------------//
    if ( tileIndSel==7 )      //e.g, where tile#7 is a tractor specifically
    {
      multiTwidth  = 3; 
      multiTheight = 3;
      structurePlaceable = calcStructurePlaceable(findMouseTile(), multiTwidth, multiTheight);
      if(structurePlaceable == true)
      {
        alreadyDrawn = true;
        for(int j=-floor(multiTwidth/2); j<(multiTwidth+1)/2; j++)
        {
          for(int i=-floor(multiTheight/2); i<(multiTheight+1)/2; i++)
          {
            Tiles.get(mouseTile + i +(j*colNum)).index = 7;     //## DOING THIS SO IT IS A ONE-OFF ASSIGNING OF TILES ##//
          }
        }
      }
    }
    if ( tileIndSel==10 )
    {
      multiTwidth  = 3; 
      multiTheight = 3;
      structurePlaceable = calcStructurePlaceable(findMouseTile(), multiTwidth, multiTheight);
      if(structurePlaceable == true)
      {
        alreadyDrawn = true;
        for(int j=-floor(multiTwidth/2); j<(multiTwidth+1)/2; j++)
        {
          for(int i=-floor(multiTheight/2); i<(multiTheight+1)/2; i++)
          {

            if( (i==floor(multiTheight/2))&&(j==floor(multiTwidth/2)) ){
              Tiles.get(mouseTile + i +(j*colNum)).index = 10;
            }
            else{
              Tiles.get(mouseTile + i +(j*colNum)).index = 15;
              Tiles.get(mouseTile + i +(j*colNum)).hiddenTileOrigin = mouseTile + ( floor((multiTheight+1)/2) -1 ) + ( ( floor((multiTwidth+1)/2) -1 ) *colNum);
            }

          }
        }
      }
    }
    if ( tileIndSel==17 ) //Trading Outpost
    {
      multiTwidth  = 7; 
      multiTheight = 7;
      structurePlaceable = calcStructurePlaceable(findMouseTile(), multiTwidth, multiTheight);
      if(structurePlaceable == true)
      {
        alreadyDrawn = true;
        for(int j=-floor(multiTwidth/2); j<(multiTwidth+1)/2; j++)
        {
          for(int i=-floor(multiTheight/2); i<(multiTheight+1)/2; i++)
          {

            if( (i==floor(multiTheight/2))&&(j==floor(multiTwidth/2)) ){
              Tiles.get(mouseTile + i +(j*colNum)).index = 17;
            }
            else{
              Tiles.get(mouseTile + i +(j*colNum)).index = 15;
              Tiles.get(mouseTile + i +(j*colNum)).hiddenTileOrigin = mouseTile + ( floor((multiTheight+1)/2) -1 ) + ( ( floor((multiTwidth+1)/2) -1 ) *colNum);
            }

          }
        }
      }
    }
    if ( tileIndSel==18 ) //Port
    {
      multiTwidth  = 9; 
      multiTheight = 9;
      structurePlaceable = calcStructurePlaceable(findMouseTile(), multiTwidth, multiTheight);
      if(structurePlaceable == true)
      {
        alreadyDrawn = true;
        for(int j=-floor(multiTwidth/2); j<(multiTwidth+1)/2; j++)
        {
          for(int i=-floor(multiTheight/2); i<(multiTheight+1)/2; i++)
          {

            if( (i==floor(multiTheight/2))&&(j==floor(multiTwidth/2)) ){
              addTradingOutpostToList( Tiles.get( mouseTile + i +(j*colNum)).pos, (mouseTile + i +(j*colNum)) );
              Tiles.get(mouseTile + i +(j*colNum)).index = 18;
            }
            else{
              Tiles.get(mouseTile + i +(j*colNum)).index = 19;
              Tiles.get(mouseTile + i +(j*colNum)).hiddenTileOrigin = mouseTile + ( floor((multiTheight+1)/2) -1 ) + ( ( floor((multiTwidth+1)/2) -1 ) *colNum);
            }

          }
        }
      }
    }
    //------------------//
    //Regular conditions//
    //------------------//
    if(alreadyDrawn == false)
    {
      if(structurePlaceable == true)  //##Seems to be working, double check
      {

        if(catalogueType == 0)
        {
          Tiles.get( mouseTile ).index    = tileIndSel;
        }
        if(catalogueType == 1)
        {
          Tiles.get( mouseTile ).floorInd = floorIndSel;
        }

      }
    }

  }

  if( (  (innStatusSignX - innStatusSignWidth/2<mouseX)&&(mouseX<innStatusSignX + innStatusSignWidth/2)  )&&(  (innStatusSignY - innStatusSignHeight/2 < mouseY)&&(mouseY < innStatusSignY + innStatusSignHeight/2 ) ) )
  {
    //If within inn status sign bounds...
    innStatus = !innStatus;
  }
  //##MAKE BUTTONS FLASH WHEN PRESSED##//
  if(eventsShort.size() > 0)  //If anything to remove...
  {
    if(eventCurrentlyHovered == true)
    {
      eventsShort.      remove( eventHovered() );
      eventsDescription.remove( eventHovered() );
    }
  }

  
  if( (mouseButton == LEFT) && (( (catalogueToggle == true) || (tradingOutpostMenuToggle == true) ) && (hoveredIndCata != -1)) )  //If showing the catalogue screen AND are hovered over an item...
  {
    addToPieSelector(hoveredIndCata);   
  }
  //Pick hovered item from pie selector
  if( (mouseButton == LEFT) && (( (pieToggle == true)&&(catalogueToggle == false) ) && (hoveredIndPie != -1)) )  //If showing the pie selector screen AND are hovered over an item...
  {
    selectFromPieSelector();   
  }
  //Remove hovered item from pie selector
  if( (mouseButton == RIGHT) && ((pieToggle == true) && (hoveredIndPie != -1)) )  //If showing the pie selector screen AND are hovered over an item...
  {
    removeFromPieSelector();      
  }

  //Button for catalogue type changer
  if( (pieToggle == true) && ( ((pieSelectorPosX + pieSelectorRadius + catalogueTypeSpaceX - catalogueTypeWidth/2 < mouseX) && ( mouseX < pieSelectorPosX + pieSelectorRadius + catalogueTypeSpaceX + catalogueTypeWidth/2)) && ((pieSelectorPosY - pieSelectorRadius-catalogueTypeSpaceY - catalogueTypeWidth/2 < mouseY) && ( mouseY < pieSelectorPosY - pieSelectorRadius-catalogueTypeSpaceY + catalogueTypeWidth/2)) ) )
  {
    
    catalogueType++;                        //Increase type...
    println("Catalogue type changed to ",catalogueType);
    if(catalogueType >= catalogueTypeMax){  //Loops back to the start when last type is reached
      catalogueType = 0;
    }
    
  }

}

void calcScannerType(int eventCount){
  //Scanner functionality
  if( eventCount < 0 ){
    scannerMode++;}
  if( eventCount > 0 ){
    scannerMode--;}
  
  if(scannerMode < 0){
    scannerMode = maxScannerMode;
  }
  if(scannerMode > maxScannerMode){
    scannerMode = 0;
  }
}

//##
//##WORST CASE SCENARIO, JUST DETECT PUMP AT OUTPUT, THEN MAKE ALL PIPES IN THAT NETWORK THE NEEDED VALUES##//
//##
