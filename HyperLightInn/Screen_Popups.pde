void displayHomeScreen(){
  pushStyle();
  imageMode(CENTER);
  rectMode (CENTER);
  textAlign(CENTER);
  
  image(menu1, screenWidth/2, screenHeight/2);
  
  //
  
  
  
  
  //
  
  stroke(2);
  fill(255);
  rect(screenWidth/8, (3*screenWidth/8)+(2*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
  fill(0);
  textSize(20);
  text ("Continue", screenWidth/8, (3*screenWidth/8)+(2*homeButtonSpacing));
  
  stroke(2);
  fill(255);
  rect(7*screenWidth/8, (3*screenWidth/8)+(2*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
  fill(0);
  textSize(20);
  text ("New Game", 7*screenWidth/8, (3*screenWidth/8)+(2*homeButtonSpacing));
  
  stroke(2);
  fill(255);
  rect(screenWidth/8, (3*screenWidth/8)+(4*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
  fill(0);
  textSize(20);
  text ("Options", screenWidth/8, (3*screenWidth/8)+(4*homeButtonSpacing));
  
  stroke(2);
  fill(255);
  rect(7*screenWidth/8, (3*screenWidth/8)+(4*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
  fill(0);
  textSize(20);
  text ("Exit", 7*screenWidth/8, (3*screenWidth/8)+(4*homeButtonSpacing));
  
  popStyle();
}

void displayOptions(){
  pushStyle();
  rectMode(CENTER);  //##WILL REPLACE WITH IMAGE EVENTUALLY##//
  imageMode(CENTER);
  textAlign(CENTER);
  
  /*
  fill(150,220,205);
  strokeWeight(4);
  ellipse(screenWidth/2, screenHeight/2, screenWidth/2, screenHeight/6);
  
  fill(0);
  textSize(15);
  text("CURRENTLY NO OPTIONS, PRESS 'u' TO LEAVE", screenWidth/2, screenHeight/2);
  */
  
  //1st
  stroke(2);
  fill(255);
  rect(screenWidth/2, (screenHeight/8)+(2*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
  fill(0);
  textSize(20);
  text ("Tile index list", screenWidth/2, (screenHeight/8)+(2*homeButtonSpacing));
  
  //2nd
  stroke(2);
  fill(255);
  rect(screenWidth/2, (screenHeight/8)+(4*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
  fill(0);
  textSize(20);
  text ("Select2", screenWidth/2, (screenHeight/8)+(4*homeButtonSpacing));
  
  //3rd
  stroke(2);
  fill(255);
  rect(screenWidth/2, (screenHeight/8)+(6*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
  fill(0);
  textSize(20);
  text ("Select3", screenWidth/2, (screenHeight/8)+(6*homeButtonSpacing));
  
  //4th
  stroke(2);
  fill(255);
  rect(screenWidth/2, (screenHeight/8)+(8*homeButtonSpacing), homeButtonWidth, homeButtonHeight);
  fill(0);
  textSize(20);
  text ("Back", screenWidth/2, (screenHeight/8)+(8*homeButtonSpacing));
  
  popStyle();
}

void displayTileStats(int n){
  relativeObjPos = findRelativeCoordinates(n);
  pushStyle();
  imageMode(CENTER);
  rectMode (CENTER);
  textAlign(CENTER);
  
  
  //(1)Highlighting selected tile
  stroke(120,250,100);
  strokeWeight(6);
  //
  //TopLeft
  line(relativeObjPos.x-wallWidth/2,relativeObjPos.y-wallHeight/2,   relativeObjPos.x-wallWidth/2,relativeObjPos.y-tileCursorTolerance);
  line(relativeObjPos.x-wallWidth/2,relativeObjPos.y-wallHeight/2,   relativeObjPos.x-tileCursorTolerance,relativeObjPos.y-wallHeight/2);
  
  //TopRight
  line(relativeObjPos.x+wallWidth/2,relativeObjPos.y-wallHeight/2,   relativeObjPos.x+wallWidth/2,relativeObjPos.y-tileCursorTolerance);
  line(relativeObjPos.x+wallWidth/2,relativeObjPos.y-wallHeight/2,   relativeObjPos.x+tileCursorTolerance,relativeObjPos.y-wallHeight/2);
  
  //BottomLeft
  line(relativeObjPos.x-wallWidth/2,relativeObjPos.y+wallHeight/2,   relativeObjPos.x-wallWidth/2,relativeObjPos.y+tileCursorTolerance);
  line(relativeObjPos.x-wallWidth/2,relativeObjPos.y+wallHeight/2,   relativeObjPos.x-tileCursorTolerance,relativeObjPos.y+wallHeight/2);
  
  //BottomRight
  line(relativeObjPos.x+wallWidth/2,relativeObjPos.y+wallHeight/2,   relativeObjPos.x+wallWidth/2,relativeObjPos.y+tileCursorTolerance);
  line(relativeObjPos.x+wallWidth/2,relativeObjPos.y+wallHeight/2,   relativeObjPos.x+tileCursorTolerance,relativeObjPos.y+wallHeight/2);
  //
  
  //(2)Draw box holding description and other info
  stroke(120,250,100);
  strokeWeight(3);
  noFill();
  rect(relativeObjPos.x+(2*wallWidth), relativeObjPos.y, screenWidth/8, screenHeight/6);
  
  //(3)Description text + extras
  tileDescription(Tiles.get(n).index, relativeObjPos.x+(2*wallWidth)-screenWidth/16, relativeObjPos.y);
  
  //(4)Show image of selected tile (##??MAYBE NOT NEEDED??##)
  image(test2, relativeObjPos.x+(2*wallWidth)-(wallWidth/2), relativeObjPos.y-(wallHeight));
  
  //(5)Show star-rating of tile (##??;LIKE IDEA, BUT POSSIBLY NOT FOR TILES, MORE TO DO WITH ITEMS --> POSSIBLY IF SELECTING A BARREL CONTAINING ITEMS??##)
  image(test3, relativeObjPos.x+(2*wallWidth)+(wallWidth/2), relativeObjPos.y-(wallHeight));
  
  popStyle();
}

void calcTileStats(int n){
  if( (abs(user.vel.x) > 0)||(abs(user.vel.y) > 0) )  //Condition to stop display (##WILL WANT TO CHANGE TO BE SMARTER##)--> ##PERHAPS WHEN SCREEN STARTS TO SCROLL, STOP STATS SCREEN##
  {
    tileStatScreen = false;
  }
  if(tileStatScreen == true)
  {
    displayTileStats(n);
  }
}

void calcInventoryScreen(){
  if( (abs(user.vel.x) > 0)||(abs(user.vel.y) > 0) )  //Condition to stop display (##WILL WANT TO CHANGE TO BE SMARTER##)--> ##PERHAPS WHEN SCREEN STARTS TO SCROLL, STOP STATS SCREEN##
  {
    inventoryScreen = false;
    showContainer   = false;
  }
  if(inventoryScreen == true)
  {
    displayInventoryScreen();
  }
}

void displayInventoryScreen(){
  //(1)Create grid
  pushStyle();
  rectMode(CENTER);
  imageMode(CENTER);
  
  fill(170, 160, 100);
  stroke(0);
  strokeWeight(2);
  rect(inventoryX, inventoryY, inventoryWidth, inventoryHeight);
  
  fill(210, 200, 140);
  inventoryXspace = inventoryWidth /inventoryCols;
  inventoryYspace = inventoryHeight/inventoryRows;
  strokeWeight(1);
  for(int j=0; j<inventoryRows-(inventoryRowsSpare); j++)    //-inventoryRowsSpare, so there is space at bottom for description
  {
    for(int i=0; i<inventoryCols; i++)
    {
      rectMode(CORNER);
      imageMode(CORNER);
      rect(inventoryXspace*i+(inventoryX-inventoryWidth/2), inventoryYspace*j+inventoryY-inventoryHeight/2, inventoryXspace,inventoryYspace); //##CAN REPLACE THIS WITH IMAGE##//
    }
  }
  
  //(2)Draw components within grid (e.g, items, descriptions, etc)
  textAlign(CENTER);
  textSize(10);
  imageMode(CENTER);
  fill(0);
  for(int i=0; i<user.inventoryItems.size(); i++)
  {
    //##WILL NEED ICONS, POSSIBLY OF SCALABLE SIZE##// --> can be done using last and 2nd to last arguements
    InvXcoord = ( inventoryX - inventoryWidth /2 ) + ( (inventoryXspace)*( i%inventoryCols ) )        + (inventoryXspace/2);
    InvYcoord = ( inventoryY - inventoryHeight/2 ) + ( (inventoryYspace)*( floor(i/inventoryCols) ) ) + (inventoryYspace/2);

    for(int j=0; j<itemCatalogueNames.size(); j++)
    {
      if( user.inventoryItems.get(i).equals( itemCatalogueNames.get(j) ) )
      {

        image( itemCatalogueIcons.get(j) , InvXcoord, InvYcoord                     );
        text ( itemCatalogueNames.get(j) , InvXcoord, InvYcoord+inventoryYspace/2-4 );

      }
    }

  }
  
  //(3)Description at bottom of inventory / in stat panel ??POSSIBLY??
  if(invCursorInd < user.inventoryItems.size()){  //If an item exists in that location
  itemDescription( user.inventoryItems.get(invCursorInd) );}
  
  //(4)Draw character panel to left
  rectMode(CORNER);
  imageMode(CORNER);
  fill(60,50,60);
  //rect(inventoryX-inventoryWidth/2-invCharacterOverlayWidth, inventoryY-inventoryHeight/2, invCharacterOverlayWidth, invCharacterOverlayHeight); //##JUST FOR DESIGN, WILL BE REPLACED WITH TEXTURED IMAGE LATER##//
  image(characterOverlay, inventoryX-inventoryWidth/2-invCharacterOverlayWidth, inventoryY-inventoryHeight/2);

  popStyle();
}

void itemDescription(String item){
  pushStyle();
  fill(0);
  stroke(0);
  textSize(15);
  textAlign(LEFT);
  
  //##MAKE ADJUSTABLE TO SIZE OF WINDOW NEEDED TO BE DISPLAYED IN e.g, Stat OR inventory##//
  if(item == "Sticks"){
  text("Description of stick", screenWidth/2-inventoryWidth/2+(screenWidth/60), screenHeight/2+inventoryHeight/2-(screenHeight/40+inventoryYspace));
  //## CHANGE TO TEXT FORMATTER ##
  }
  else if(item == "Water bucket"){
  text("Description of water bucket", screenWidth/2-inventoryWidth/2+(screenWidth/60), screenHeight/2+inventoryHeight/2-(screenHeight/40+inventoryYspace));
  //## CHANGE TO TEXT FORMATTER ##
  }
  else{
  text("|| ----------------------------------- ||", screenWidth/2-inventoryWidth/2+(screenWidth/60), screenHeight/2+inventoryHeight/2-(screenHeight/40+inventoryYspace)+(0*inventoryYspace/2));
  text("|| **ERROR**, No description available ||", screenWidth/2-inventoryWidth/2+(screenWidth/60), screenHeight/2+inventoryHeight/2-(screenHeight/40+inventoryYspace)+(1*inventoryYspace/2));
  text("|| ----------------------------------- ||", screenWidth/2-inventoryWidth/2+(screenWidth/60), screenHeight/2+inventoryHeight/2-(screenHeight/40+inventoryYspace)+(2*inventoryYspace/2));
  }
  
  popStyle();
}

void tileDescription(int ind, float x, float y){
  //ind = index of tile being looked at
  //x   = Xposition of words
  //y   = Xposition of words
  //println("Stat panel ind; ",ind);              //*****//
  pushStyle();
  fill(0);
  stroke(0);
  textSize(8);
  textAlign(LEFT);
  
  //##MAKE ADJUSTABLE TO SIZE OF WINDOW NEEDED TO BE DISPLAYED IN e.g, different sized inventories
  if(ind == 0){
  text("Description of plain tile", x, y);
  //Add more text lines here, ...
  }
  else if(ind == 8){
  text("Description of tree tile", x, y);
  //Add more text lines here, ...
  }
  else if(ind == 9){
  text("Description of water tile", x, y);
  //Add more text lines here, ...
  }
  else{
    //##CHANGE TO MAKE MORE SCALABLE##//
  text("|| ----------------------------------- ||", x, y);
  text("|| **ERROR**, No description available ||", x, y+10);
  text("|| ----------------------------------- ||", x, y+20);
  }
  
  popStyle();
}

void calcPieSelector(){
  if( (pieToggle == true) && (modeSelector == 1) )
  {
    displayPieSelector( pieSelected.get(catalogueType), pieSelectorRadius, new PVector(pieSelectorPosX, pieSelectorPosY) );
  }
}

void displayPieSelector(ArrayList<Integer> selection, float radius, PVector centrePos){
  //A pie selector for marked items
  //selection = the options for each segment. Check the word to find out what action is needed next
  //(1)Find number of segments needed / angle between each
  //(2)Draw pie chart in centre of screen
  //(3)Place the type changer button to the side
  //(4)Put text into each segment

  pushStyle();
  strokeWeight(3);
  fill(215, 173, 219, 200);

  segAngle = (2.0*PI) / ( selection.size() );
  removalRadius = 2*radius/3;
  calcPieHovered(centrePos, radius, removalRadius);
  //Draw main circle border
  if(selection.size() > 0)
  {
    ellipse(centrePos.x, centrePos.y, 2*radius,2*radius);
  }

  //Draw the type changer icon (top-right of selector)
  pushStyle();
  pushMatrix();
  imageMode(CENTER);
  //rectMode(CENTER);
  //noStroke();

  translate(centrePos.x, centrePos.y);

  //rect(radius+catalogueTypeSpaceX, -radius-catalogueTypeSpaceY, catalogueTypeWidth,catalogueTypeWidth);
  image(userManual, radius+catalogueTypeSpaceX, -radius-catalogueTypeSpaceY);                             //## PLACEHOLDER TEXTURE ##

  popMatrix();
  popStyle();

  //Draw the splits within the circle
  for(int i=0; i<selection.size(); i++)
  {
    if(selection.size() > 1)
    {
      pushMatrix();
      translate(centrePos.x, centrePos.y);
      line(0,0, -radius*sin(i*segAngle),-radius*cos(i*segAngle));
      rotate(i*segAngle);
      popMatrix();
    }
    
    //Draw icon + text
    if(selection.size() > 1)  //If many items to show
    {

      //############################################################
      //## EVENTUALLY MAKE FLOORS AND TILES AVAILABLE IN SAME PIE ##
      //############################################################
      if(catalogueType == 0)  //Tiles
      {
        currentCatalogueIcons = tileCatalogueIcons;
        //currentCatalogueNames = ; //##IF NEEDED, CAN BE ADDED##
      }
      if(catalogueType == 1)  //Floors
      {
        currentCatalogueIcons = floorCatalogueIcons;
        //currentCatalogueNames = ; //##IF NEEDED, CAN BE ADDED##
      }
      //...

      pushMatrix();
      translate(centrePos.x, centrePos.y);
      image( currentCatalogueIcons.get( int(selection.get(i)) ), pieIconDist*radius*sin(i*segAngle + segAngle/2), -pieIconDist*radius*cos(i*segAngle + segAngle/2)+20, radius/4, radius/4 );

      //## IF WANTED, MAY NOT BE NEEDED ##//
      //textFormatted(String displayText, PVector displayPosition, int displaySize, PVector textBoxDim, PVector textColour)
      //text( currentCatalogueNames.get( int(selection.get(i)) ), pieIconDist*radius*sin(i*segAngle + segAngle/2), -pieIconDist*radius*cos(i*segAngle + segAngle/2) );
      //textformatted(...); ## SHOULD BE USED ##//
      //## IF WANTED, MAY NOT BE NEEDED ##//
      popMatrix();

    }
    else  //If only 1 item to show
    {

      pushMatrix();
      translate(centrePos.x, centrePos.y);
      image( currentCatalogueIcons.get( int(selection.get(i)) ), 0, -pieIconDist*radius + 20, radius/4, radius/4 );

      //## IF WANTED, MAY NOT BE NEEDED ##//
      //textFormatted(String displayText, PVector displayPosition, int displaySize, PVector textBoxDim, PVector textColour)
      //text( currentCatalogueNames.get( int(selection.get(i)) ), pieIconDist*radius*sin(i*segAngle + segAngle/2), -pieIconDist*radius*cos(i*segAngle + segAngle/2) );
      //textformatted(...); ## SHOULD BE USED ##//
      //## IF WANTED, MAY NOT BE NEEDED ##//
      popMatrix();

    }
    
  }

    popStyle();

  //Removal circle (smaller)
  pushStyle();
  fill(215, 173, 219);
  strokeWeight(2);
  ellipse(centrePos.x, centrePos.y, removalRadius,removalRadius);
  image(removeIcon, centrePos.x, centrePos.y, 80, 80);
  textFormatted("Remove", centrePos, 20, new PVector(radius, radius), new PVector(0,0,0));
  popStyle();

}

//#####################################// --> When hovered, highlight and pop-out slightly
//## CHANGES FOR CIRCLE PIE SELECTOR ##// --> When hovered, show text. Otherwise, show icon only
//#####################################//

Integer calcPieHovered(PVector centrePos, float radius, float removalRadius){
  if( pow( (centrePos.x - mouseX) ,2) + pow( (centrePos.y - mouseY) ,2) < pow( (radius) ,2) )  //If in main circle...
  {

    //(0)If in central 'Remove' section, do a thing....#########################################
    if( pow( (centrePos.x - mouseX) ,2) + pow( (centrePos.y - mouseY) ,2) < pow( (removalRadius/2) ,2) )
    {

      hoveredIndPie = -2; //** -2 means use the removal tool **//

    }
    else
    {

      //(1)First, set to arctan(dY/dX)
      mouseAng = atan( (mouseY - centrePos.y) / (mouseX - centrePos.x) );
      //println("---Mouse angle 1; ",mouseAng);                                 //*****//
      //(2)Then, adjust according to its position
      if( (mouseX < centrePos.x) )  //If left side of graph
      {

        if(mouseY > centrePos.y)  //If bottom of graph
        {
          mouseAng = (3*PI/2) + mouseAng;
        }
        else                      //If top of graph
        {
          mouseAng = (3*PI/2) + mouseAng;
        }

      }
      else  //If right side of graph
      {

        if(mouseY > centrePos.y)  //If bottom of graph
        {
          mouseAng = (PI/2) + abs(mouseAng);
        }
        else                      //If top of graph
        {
          mouseAng = (PI/2) + mouseAng;
        }

      }

      //println("--Mouse angle 2 ; ",mouseAng);                                 //*****//
      hoveredIndPie = floor( mouseAng / segAngle );

    }
  }
  else
  {
    hoveredIndPie = -1;
  }

  return hoveredIndPie;
}

void calcCatalogueSelector(){
  if( (catalogueToggle == true) && (modeSelector == 1) )
  {
    displayCatalogueSelector(new PVector(screenWidth/2, screenHeight/2), new PVector(screenWidth/3, 8*screenHeight/10), 15);
  }
}

Integer calcCatalogueHovered(PVector centrePos, PVector boxDim, int textSize){
  //## CAN ALSO RESTRICT TO ONLY WORK IF ON THE RIGHT SIDE OF THE CATALOGUE ##//
  if( ( (centrePos.x - boxDim.x/2 < mouseX)&&(mouseX < centrePos.x + boxDim.x/2) ) && ( (centrePos.y - boxDim.y/2 < mouseY)&&(mouseY < centrePos.y + boxDim.y/2) ) )  //If within box
  {
    hoveredIndCata = floor( ( mouseY - (centrePos.y - (boxDim.y/2)) ) / textSize );
  }
  else  //If not within box
  {
    hoveredIndCata = -1;
  }

  return hoveredIndCata;
}


//## ADD PRICES AND QUANTITIES ##
void displayCatalogueSelector(PVector centrePos, PVector boxDim, int textSize){
  //A full list of all items, which can be marked for use in the pie selector
  //allItems = list of every item available to be chosen
  //(1)Draw bounding box for displayed catalogue
  //(2)Display each item NAME and ICON
  //(3)Have be scrollable ##***##
  //#############################################################################################
  //## ALL VERY UP FOR DEBATE, NOT A GREAT IDEA, BUT NOT TERRIBLE EITHER -> JUST UNIMAGINATIVE ##
  //#############################################################################################

  textSize( textSize );
  textAlign(RIGHT);

  pushStyle();
  imageMode(CENTER);
  rectMode(CENTER);

  fill(148, 99, 153, 200);
  rect(centrePos.x,centrePos.y, boxDim.x,boxDim.y);
  popStyle();

  hoveredIndCata = calcCatalogueHovered(centrePos, boxDim, textSize);

  if(catalogueType == 0)  //Tiles...
  {
    if( (-1 < hoveredIndCata) && (hoveredIndCata < tileCatalogueNames.size()) )
    {
      //Draw glow effect
      pushStyle();
      rectMode(CENTER);
      noStroke();
      fill(255,255,255, 100);
      rect(centrePos.x, (centrePos.y - boxDim.y/2 + (hoveredIndCata*textSize))+ textSize/2, boxDim.x, (boxDim.y / textSize)/2 - textSize/4  );
      popStyle();
    }
  }
  if(catalogueType == 1)  //Floors...
  {
    if( (-1 < hoveredIndCata) && (hoveredIndCata < floorCatalogueNames.size()) )
    {
      //Draw glow effect
      pushStyle();
      rectMode(CENTER);
      noStroke();
      fill(255,255,255, 100);
      rect(centrePos.x, (centrePos.y - boxDim.y/2 + (hoveredIndCata*textSize))+ textSize/2, boxDim.x, (boxDim.y / textSize)/2 - textSize/4  );
      popStyle();
    }
  }
  if(catalogueType == 2)  //Items...
  {
    if( (-1 < hoveredIndCata) && (hoveredIndCata < itemCatalogueNames.size()) )
    {
      //Draw glow effect
      pushStyle();
      rectMode(CENTER);
      noStroke();
      fill(255,255,255, 100);
      rect(centrePos.x, (centrePos.y - boxDim.y/2 + (hoveredIndCata*textSize))+ textSize/2, boxDim.x, (boxDim.y / textSize)/2 - textSize/4  );
      popStyle();
    }
  }

  if( catalogueType == 0 )  //If tiles catalogue...
  {

    for(int i=0; i<tileCatalogueNames.size(); i++)
    {

      //Draw price
      text( (tileCataloguePrices .get(i))*(tileCatalogueQuantity.get(i)), centrePos.x - (boxDim.x* (3.0/8.0)), centrePos.y - (boxDim.y/2) + ( (i+1)*textSize) );
      //Draw quantity
      text( tileCatalogueQuantity.get(i)                                , centrePos.x - (boxDim.x* (1.0/8.0)), centrePos.y - (boxDim.y/2) + ( (i+1)*textSize) );
      //Draw name
      text( tileCatalogueNames   .get(i)                                , centrePos.x + (boxDim.x* (1.0/8.0)), centrePos.y - (boxDim.y/2) + ( (i+1)*textSize) );
      //Draw icon
      image(tileCatalogueIcons   .get(i)                                , centrePos.x + (boxDim.x* (3.0/8.0)), centrePos.y - (boxDim.y/2) + ( (i+1)*textSize) -textSize/3, textSize, textSize );

      //#############################################
      //## NEEDS TO CUT OFF AT END OF BOUNDING BOX ## --> with a '...'
      //#############################################
      
    }

  }
  if( catalogueType == 1 )  //If floor catalogue...
  {

    for(int i=0; i<floorCatalogueNames.size(); i++)
    {

      //Draw price
      text( (floorCataloguePrices .get(i))*(floorCatalogueQuantity.get(i)), centrePos.x - (boxDim.x* (3.0/8.0)), centrePos.y - (boxDim.y/2) + ( (i+1)*textSize) );
      //Draw quantity
      text( floorCatalogueQuantity.get(i)                                 , centrePos.x - (boxDim.x* (1.0/8.0)), centrePos.y - (boxDim.y/2) + ( (i+1)*textSize) );
      //Draw name
      text( floorCatalogueNames   .get(i)                                 , centrePos.x + (boxDim.x* (1.0/8.0)), centrePos.y - (boxDim.y/2) + ( (i+1)*textSize) );
      //Draw icon
      image(floorCatalogueIcons   .get(i)                                 , centrePos.x + (boxDim.x* (3.0/8.0)), centrePos.y - (boxDim.y/2) + ( (i+1)*textSize) -textSize/3, textSize, textSize );
      
      //#############################################
      //## NEEDS TO CUT OFF AT END OF BOUNDING BOX ## --> with a '...'
      //#############################################
      
    }

  }
  if( catalogueType == 2 )  //If item catalogue...
  {

    for(int i=0; i<itemCatalogueNames.size(); i++)
    {

      //Draw price
      text( (itemCataloguePrices .get(i))*(itemCatalogueQuantity.get(i)), centrePos.x - (boxDim.x* (3.0/8.0)), centrePos.y - (boxDim.y/2) + ( (i+1)*textSize) );
      //Draw quantity
      text( itemCatalogueQuantity.get(i)                                , centrePos.x - (boxDim.x* (1.0/8.0)), centrePos.y - (boxDim.y/2) + ( (i+1)*textSize) );
      //Draw name
      text( itemCatalogueNames   .get(i)                                , centrePos.x + (boxDim.x* (1.0/8.0)), centrePos.y - (boxDim.y/2) + ( (i+1)*textSize) );
      //Draw icon
      image(itemCatalogueIcons   .get(i)                                , centrePos.x + (boxDim.x* (3.0/8.0)), centrePos.y - (boxDim.y/2) + ( (i+1)*textSize) -textSize/3, textSize, textSize );
      
      //#############################################
      //## NEEDS TO CUT OFF AT END OF BOUNDING BOX ## --> with a '...'
      //#############################################
      
    }

  }
  
  //scrollable
  // ---
  // ---
  // ----
  // --
  // ---
  // ......
}


//#######################################################//
//## CHANGE SO SCANNER VALUES ARE CALCULATED JUST ONCE ##//
//#######################################################//
void calcScannerModule(){
  //centrePos   = central position of the scanner menu
  //ellipseSize = the size of the scanner nodes located
  
  //(1)Draw the background menu colour --> with analytics on the side
  //(2)Go through all tiles
  //(3)Draw tiles at the correct position, and with the correct colour

  if((scannerToggle == true) && (modeSelector == 0))  //If want to scan AND in exploration mode
  {

    if(scannerMode == 0){
      displayScannerNatural(new PVector(screenWidth/2, screenHeight/2), new PVector(screenWidth/2, screenHeight/8), 50.0, 10);
    }
    if(scannerMode == 1){
      displayScannerStructural(new PVector(screenWidth/2, screenHeight/2),new PVector(screenWidth/2, screenHeight/8), 100.0, 10);
    }
    //...

  }
}

void displayScannerNatural(PVector centrePos, PVector scannerPiePos, float scannerPieRadius, float ellipseSize){
  //Shows the location of natural tiles

  pushStyle();
  //##
  noStroke(); //**For giga weird effect**//
  //##
  //Draw scanned environment
  for(int i=0; i<Tiles.size(); i++)
  {
    if(Tiles.get(i).index == 0){       //Grass
      fill(80, 209, 54);
    }
    else if(Tiles.get(i).index == 8){  //Tree
      fill(168, 135, 13);
    }
    else if(Tiles.get(i).index == 9){  //Water
      fill(52, 204, 235);
    }
    else{                              //Everything else
      fill(191, 191, 191);
    }
    ellipse(centrePos.x - (ellipseSize*colNum/2) + ( i % colNum )*(ellipseSize), centrePos.y - (ellipseSize*rowNum/2) + ( floor(i / colNum) )*(ellipseSize), ellipseSize, ellipseSize);
  }

  //Draw analytics
  scannerTileTotal = 0;
  for(int i=0; i<scannerTile.size(); i++)
  {
    if( (scannerTile.get(i) == 0) || ((scannerTile.get(i) == 8) || (scannerTile.get(i) == 9)) ){
      scannerTileTotal += scannerTileQuantity.get(i);
    }
  }
  scannerRunningAng = 0;
  for(int i=0; i<scannerTile.size(); i++)
  {
    if( scannerTile.get(i) == 0 ){
      fill(80, 209, 54);
      arc( scannerPiePos.x, scannerPiePos.y,  scannerPieRadius, scannerPieRadius,  scannerRunningAng, scannerRunningAng+( (2.0*PI) * (float(scannerTileQuantity.get(i)) / float(scannerTileTotal)) ),  PIE );
      scannerRunningAng += (2*PI) * (float(scannerTileQuantity.get(i)) / float(scannerTileTotal));
    }
    if( scannerTile.get(i) == 8 ){
      fill(168, 135, 13);
      arc( scannerPiePos.x, scannerPiePos.y,  scannerPieRadius, scannerPieRadius,  scannerRunningAng, scannerRunningAng+( (2.0*PI) * (float(scannerTileQuantity.get(i)) / float(scannerTileTotal)) ),  PIE );
      scannerRunningAng += (2*PI) * (float(scannerTileQuantity.get(i)) / float(scannerTileTotal));
    }
    if( scannerTile.get(i) == 9 ){
      fill(52, 204, 235);
      arc( scannerPiePos.x, scannerPiePos.y,  scannerPieRadius, scannerPieRadius,  scannerRunningAng, scannerRunningAng+( (2.0*PI) * (float(scannerTileQuantity.get(i)) / float(scannerTileTotal)) ),  PIE );
      scannerRunningAng += (2*PI) * (float(scannerTileQuantity.get(i)) / float(scannerTileTotal));
    }
  }
  popStyle();

}

void displayScannerStructural(PVector centrePos, PVector scannerPiePos, float scannerPieRadius, float ellipseSize){
  //Shows the location of structural

  pushStyle();
  //##
  noStroke(); //**For giga weird effect**//
  //##
  //Draw scanned environment
  for(int i=0; i<Tiles.size(); i++)
  {
    if(Tiles.get(i).index == 1){       //Wall
      fill(182, 92, 214);
    }
    else if(Tiles.get(i).index == 2){  //Barrel
      fill(57, 79, 117);
    }
    else if(Tiles.get(i).index == 3){  //Door
      fill(220, 152, 245);
    }
    else{                              //Everything else
      fill(191, 191, 191);
    }
    ellipse(centrePos.x - (ellipseSize*colNum/2) + ( i % colNum )*(ellipseSize), centrePos.y - (ellipseSize*rowNum/2) + ( floor(i / colNum) )*(ellipseSize), ellipseSize, ellipseSize);
  }

  //Draw analytics
  for(int i=0; i<scannerTile.size(); i++)
  {
    //pass
  }
  popStyle();

}

void drawTradingOutpostMenu(){
  if(tradingOutpostMenuToggle == true)
  {

    //######################################################################
    //## GET CONTAINER INVENTORY TO SHOW AS WELL, IN THE CORRECT DROP BOX ##
    //######################################################################
    //showContainerContents(tradingOutpostInd);

    pushStyle();
    imageMode(CENTER);
    textAlign(CENTER);
    rectMode(CENTER);

    //Draw outpost menu
    image(tradingOutpostMenu, screenWidth/2, screenHeight/2, 600,500);

    //Draw shop menu
    displayCatalogueSelector(new PVector(screenWidth/2 + 145 , screenHeight/2 + 145 ), new PVector(250,180), 10);
    //## RECTANGLES AT EACH INV SPACE ##

    //Draw headers (e.g, price, quantity, name, icon)
    textSize(10);
    fill(0);
    //Price header
    text("Price <>"    , screenWidth/2 + 145 - (2.05/8.0)*(250.0) , screenHeight/2 + 145 - 90 - 15 );
    //Quantity header
    text("Quantity <>" , screenWidth/2 + 145 + (0.05/8.0)*(250.0) , screenHeight/2 + 145 - 90 - 15 );
    //Name header
    text("Name <>"     , screenWidth/2 + 145 + (1.9/8.0)*(250.0) , screenHeight/2 + 145 - 90 - 15 );
    //Icon header
    text("Icon <>"     , screenWidth/2 + 145 + (3.55/8.0)*(250.0) , screenHeight/2 + 145 - 90 - 15 );
    //Filter header
    if(catalogueType == 0)
    {
      text("-Tiles-"      , screenWidth/2 + 145 + 20                   , screenHeight/2 + 145 - 90 - 40 );
    }
    if(catalogueType == 1)
    {
      text("-Floors-"     , screenWidth/2 + 145 + 20                   , screenHeight/2 + 145 - 90 - 40 );
    }
    if(catalogueType == 2)
    {
      text("-Items-"      , screenWidth/2 + 145 + 20                   , screenHeight/2 + 145 - 90 - 40 );
    }

    popStyle();
  }
  
}
