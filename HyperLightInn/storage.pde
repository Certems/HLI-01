class Container{
    int tileNum;

    PVector pos;

    ArrayList<Integer> contentQuantity = new ArrayList<Integer>();
    ArrayList<String>  contentItem     = new ArrayList<String>();
    ArrayList<PImage>  contentIcon     = new ArrayList<PImage>();

    Container(PVector position, int tileNumber){
        pos     = position;
        tileNum = tileNumber;
    }
}

class Barrel extends Container{
    int invTwidth  = 4;
    int invTheight = 4;

    float invXwidth  = 30;
    float invYheight = 30;

    Barrel(PVector pos, int tileNum){
        super(pos, tileNum);
    }
}

class outpostCargo extends Container{
    int invTwidth  = 10;
    int invTheight =  6;

    float invXwidth  = 30;
    float invYheight = 30;

    outpostCargo(PVector pos, int tileNum){
        super(pos, tileNum);
    }
}

//**
//ContainerList;
// 0 = Barrels
// 1 = tradingOutpost
// 2 = ...
//**

void addBarrelToList(PVector pos, int tileNum){
    barrelExistsHere = false;
    for(int i=0; i<containerList.get(0).size(); i++)  //Check all barrels
    {
        if(containerList.get(0).size() > 0) //If no barrels exist...
        {
            if( containerList.get(0).get(i).tileNum == tileNum )  //If there is already a barrel here
            {
                barrelExistsHere = true;
            }
        }
        else
        {
            continue;
        }
    }
    if(barrelExistsHere == false)  //If there is not already a pump here
    {
        Barrel newBarrel = new Barrel(pos, tileNum);
        Tiles.get(tileNum).containerInd.x = 0;
        Tiles.get(tileNum).containerInd.y = containerList.get(0).size();
        containerList.get(0).add( newBarrel );
    }
}

void addTradingOutpostToList(PVector pos, int tileNum){
    tradingOutpostExistsHere = false;
    for(int i=0; i<containerList.get(1).size(); i++)  //Check all trading outposts
    {
        if(containerList.get(1).size() > 0) //If no trading outposts exist
        {
            if( containerList.get(1).get(i).tileNum == tileNum )  //If there is already an trading outpost here
            {
                tradingOutpostExistsHere = true;
            }
        }
        else
        {
            continue;
        }
    }
    if(tradingOutpostExistsHere == false)  //If there is not already a pump here
    {
        outpostCargo newOutpostCargo = new outpostCargo(pos, tileNum);
        Tiles.get(tileNum).containerInd.x = 1;
        Tiles.get(tileNum).containerInd.y = containerList.get(1).size();
        containerList.get(1).add( newOutpostCargo );
    }
}

void calcContainers(int tileNum){
    if(showContainer == true)
    { 
        showContainerContents( tileNum );
    } 
}

void showContainerContents(int tileNum){ 
    //Display the inventory of the container hovered
    //tileNum = hovered tile to have contents shown (if a container)
    textAlign(CENTER);
    rectMode(CORNER);
    imageMode(CENTER);
    textSize(8);                //## MAY WANT TO CHANGE THIS TO A VARIABLE FOR EASE OF ADJUSTABLILITY ##//
    pushStyle();
    if(showContainer == true)
    {
        if(Tiles.get(tileNum).containerInd.x > -1)  //If a container is here...
        {
            if(Tiles.get(tileNum).containerInd.x == 0)  //If barrel...
            {
                widthTemp   = ( (Barrel)containerList.get( int(Tiles.get(tileNum).containerInd.x ) ).get( int(Tiles.get(tileNum).containerInd.y ) ) ).invXwidth;
                heightTemp  = ( (Barrel)containerList.get( int(Tiles.get(tileNum).containerInd.x ) ).get( int(Tiles.get(tileNum).containerInd.y ) ) ).invYheight;
                tWidthTemp  = ( (Barrel)containerList.get( int(Tiles.get(tileNum).containerInd.x ) ).get( int(Tiles.get(tileNum).containerInd.y ) ) ).invTwidth;
                tHeightTemp = ( (Barrel)containerList.get( int(Tiles.get(tileNum).containerInd.x ) ).get( int(Tiles.get(tileNum).containerInd.y ) ) ).invTheight;
            }
            if(Tiles.get(tileNum).containerInd.x == 1)  //If trading outpost...
            {
                widthTemp   = ( (outpostCargo)containerList.get( int(Tiles.get(tileNum).containerInd.x ) ).get( int(Tiles.get(tileNum).containerInd.y ) ) ).invXwidth;
                heightTemp  = ( (outpostCargo)containerList.get( int(Tiles.get(tileNum).containerInd.x ) ).get( int(Tiles.get(tileNum).containerInd.y ) ) ).invYheight;
                tWidthTemp  = ( (outpostCargo)containerList.get( int(Tiles.get(tileNum).containerInd.x ) ).get( int(Tiles.get(tileNum).containerInd.y ) ) ).invTwidth;
                tHeightTemp = ( (outpostCargo)containerList.get( int(Tiles.get(tileNum).containerInd.x ) ).get( int(Tiles.get(tileNum).containerInd.y ) ) ).invTheight;
            }

            if( Tiles.get(tileNum).index == 17 )    //Special trading outpost inv position
            {
                containerBoxX = 0;
                containerBoxY = 0;
            }
            else                                    //Generic container inv position
            {
                containerBoxX = (inventoryX-inventoryWidth /2)                              -invToContainerOffset    -(widthTemp*tWidthTemp);
                containerBoxY = (inventoryY-inventoryHeight/2) +invCharacterOverlayHeight   +invToContainerOffset                           ;
            }
            allItemsDisplayed = false;
            for(int j=0; j<tHeightTemp; j++)
            {
                for(int i=0; i<tWidthTemp; i++)
                {
                    //(0)Move to top left corner of main inventory
                    //(1)Move down to bottom right of character overlay
                    //(2)Move away from main inventory and character overlay by offset
                    //(3)Move x away from main inventory by the width of the container grid
                    //(4)Display contents at given location

                    fill(242, 237, 170);       //Box colour
                    rect(containerBoxX+(i*widthTemp), containerBoxY+(j*heightTemp), widthTemp, heightTemp);
                    if( (i + j*tWidthTemp) >= (containerList.get( int(Tiles.get(tileNum).containerInd.x) ).get( int(Tiles.get(tileNum).containerInd.y) ).contentItem.size()) )    //If all items drawn...
                    {
                        allItemsDisplayed = true;
                    }
                    if(allItemsDisplayed == false)  //If more items in container to show...
                    {
                        fill(0);                //Word colour
                        image( containerList.get( int(Tiles.get(tileNum).containerInd.x) ).get( int(Tiles.get(tileNum).containerInd.y) ).contentIcon    .get( i + j*tWidthTemp ),  containerBoxX+(i*widthTemp)+widthTemp/2, containerBoxY+(j*heightTemp)+(1*heightTemp)/2);
                        text ( containerList.get( int(Tiles.get(tileNum).containerInd.x) ).get( int(Tiles.get(tileNum).containerInd.y) ).contentItem    .get( i + j*tWidthTemp ),  containerBoxX+(i*widthTemp)+widthTemp/2, containerBoxY+(j*heightTemp)+(1*heightTemp)/2);
                        text ( containerList.get( int(Tiles.get(tileNum).containerInd.x) ).get( int(Tiles.get(tileNum).containerInd.y) ).contentQuantity.get( i + j*tWidthTemp ),  containerBoxX+(i*widthTemp)+widthTemp/2, containerBoxY+(j*heightTemp)+(10*heightTemp)/10 );
                    }
                }
            }
        }
    }
    popStyle();
}

void exchangeItems(int itemQuantity, int hoveredInvInd, int containerType, int hoveredContainerInd){
    //##HOVERED INF TROUBLE, MAY BE PASSING WRONG THING, DEFINATELY NOT WORKING FOR BOTH CONTAINERS##//

    //Add given quantity of an item to this container
    //(0)On a button press...
    //(1)If tile has a container on it (by looking at index)...
    //(2)Select item from inventory
    //(3)Add to container (using containerInd from tile)
    //itemName     = Name of item to be added to container
    //itemQuantity = Number of items to be removed from container
    //tileNum      = hovered invTile to have item added to

    println("-----");                                                       //*****//
    println("ADDING item to inventory;");                                   //*****//
    println("hoveredInvInd; ", hoveredInvInd);                              //*****//
    println("-----");                                                       //*****//
    if(showContainer == true)    //If inventory open & container open
    {
        //IF PLAYER INV
        if( ( (inventoryX-inventoryWidth/2 < mouseX)&&(mouseX < inventoryX+inventoryWidth/2) )&&( (inventoryY-inventoryHeight/2 < mouseY)&&(mouseY < inventoryY+inventoryHeight/2) ) )
        {
            if(user.inventoryItems.size() > hoveredInvInd)    //If hovered is an item...
            {
                itemExchangeName   = user.inventoryItems.get(hoveredInvInd);      //(0) Store name of item to be moved

                //Remove from player
                if( user.inventoryQuantity.get(hoveredInvInd) > itemQuantity )    //If ABLE TO remove the given quantity (with some left over)...
                {
                    itemInInventoryVal  = user.inventoryQuantity.get(hoveredInvInd);    //(1) Set original value
                    itemInInventoryVal -= itemQuantity;                                 //(2) Change to new value
                    user.inventoryQuantity.remove(hoveredInvInd);                       //(3) Remove old value
                    user.inventoryQuantity.add   (hoveredInvInd, itemInInventoryVal);   //(4) Add new value
                }
                else    //If CANNOT remove given quantity...
                {
                    //## HERE, SELECTS NEXT INDEX IN INV TO MOVE INSTEAD
                    itemInInventoryVal = user.inventoryQuantity.get(hoveredInvInd);     //(1) Get number of item left
                    user.inventoryItems   .remove(hoveredInvInd);                       //(2) Remove item and all its quantity from inventory
                    user.inventoryQuantity.remove(hoveredInvInd);                       //
                    user.inventoryIcons   .remove(hoveredInvInd);                       //
                    itemQuantity = itemInInventoryVal;                                  //(3) Set new quantity to be how many are left for given item
                }
                //Find icon
                iconFound = false;
                for(int i=0; i<itemCatalogueIcons.size(); i++)
                {
                    if( itemExchangeName.equals( itemCatalogueNames.get(i) ) )
                    {
                        itemExchangeIcon = itemCatalogueIcons.get(i);
                        iconFound = true;
                    }
                }
                if(iconFound == false){ //If NO ICON found
                    itemExchangeIcon = test1;
                }
                //Add to container
                containerTemp = ( (Container)( containerList.get(containerType).get( int(Tiles.get(containerTile).containerInd.y )) ) );
                addItemToContainer( itemExchangeName, itemQuantity, itemExchangeIcon, containerType, int(Tiles.get(containerTile).containerInd.y ) );
            }
        }
        //IF CONTAINER INV
        if( ( (containerBoxX < mouseX)&&(mouseX < containerBoxX+(widthTemp*tWidthTemp)) )&&( (containerBoxY < mouseY)&&(mouseY < containerBoxY+(heightTemp*tHeightTemp)) ) )
        {
            if(containerList.get(containerType).get( int(Tiles.get(containerTile).containerInd.y) ).contentItem.size() > hoveredContainerInd)    //If hovered is an item...
            {
                containerTemp    = ( (Container)( containerList.get(containerType).get( int(Tiles.get(containerTile).containerInd.y )) ) );
                itemExchangeName = containerTemp.contentItem.get(hoveredContainerInd);            //(0) Store name of item to be moved

                //Remove from container
                if( containerTemp.contentQuantity.get(hoveredContainerInd) > itemQuantity ) //If ABLE TO remove the given quantity (with some left over)...
                {
                    itemInContainerVal  = containerTemp.contentQuantity.get(hoveredContainerInd);                                                                                                      //(1) Set original value
                    itemInContainerVal -= itemQuantity;                                                                                                                                                //(2) Change to new value
                    containerList.get( int(Tiles.get(containerTile).containerInd.x) ).get( int(Tiles.get(containerTile).containerInd.y) ).contentQuantity.remove(hoveredContainerInd);                       //(3) Remove old value
                    containerList.get( int(Tiles.get(containerTile).containerInd.x) ).get( int(Tiles.get(containerTile).containerInd.y) ).contentQuantity.add   (hoveredContainerInd, itemInContainerVal);   //(4) Add new value
                }
                else    //If CANNOT remove given quantity...
                {
                    itemInContainerVal = containerTemp.contentQuantity.get(hoveredContainerInd);                                                                                          //(1) Get number of item left
                    containerList.get( int(Tiles.get(containerTile).containerInd.x) ).get( int(Tiles.get(containerTile).containerInd.y) ).contentIcon    .remove(hoveredContainerInd);    //(2) Remove item and all its quantity from inventory
                    containerList.get( int(Tiles.get(containerTile).containerInd.x) ).get( int(Tiles.get(containerTile).containerInd.y) ).contentItem    .remove(hoveredContainerInd);    //
                    containerList.get( int(Tiles.get(containerTile).containerInd.x) ).get( int(Tiles.get(containerTile).containerInd.y) ).contentQuantity.remove(hoveredContainerInd);    //
                    itemQuantity = itemInContainerVal;                                                                                                                              //(3) Set new quantity to be how many are left for given item
                }
                //Find icon
                iconFound = false;
                for(int i=0; i<itemCatalogueIcons.size(); i++)
                {
                    if( itemExchangeName.equals( itemCatalogueNames.get(i) ) )
                    {
                        itemExchangeIcon = itemCatalogueIcons.get(i);
                        iconFound = true;
                    }
                }
                if(iconFound == false){ //If NO ICON found
                    itemExchangeIcon = test1;
                }
                //Add to player
                addItemToInventory(itemExchangeName,  itemQuantity, itemExchangeIcon);
            }
        }
    }
}
