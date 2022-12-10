  //--------------//
 //Done in parses//
//--------------//
//(1) Generate empty plain, and wherever the edge of map is less than tolerance, change to water (e.g so map is an island), to prevent bugging at map edge and give a friendly border
//(2) Place structures that need more room to be built (essential THEN optional)
//(3) Select few points across map where lakes or forests will spawn
//(4) Look at points, enlarge them
//(5) Add other interesting features

void mapGeneration()
{
  formGridArray();
  seedTreesAndLakes();
  populateTreesAndLakes();
  placeMajorStructures();
  placeMinorStructures();
}

//Place essential structures such as trading outpost and port, etc
void placeMajorStructures(){
  //## FIXED NOW, BUT SHOULD CHANGE TO BE SLIGHTLY DIFFERING, E.G outpost can be slightly higher up or lower down ##//
  //**Port extends past ocean by 2 tiles if at edge --> 9x9**

  //Place the port
  majorStructureTile = ( floor(random(11, rowNum-10)) * colNum ) + 5;  //Random tile BETWEEN LIMITS on the edge of the side of the map
  multiTwidth  = 9; 
  multiTheight = 9;
  for(int j=-floor(multiTwidth/2); j<(multiTwidth+1)/2; j++)
  {
    for(int i=-floor(multiTheight/2); i<(multiTheight+1)/2; i++)
    {

      if( (i==floor(multiTheight/2))&&(j==floor(multiTwidth/2)) ){
        Tiles.get(majorStructureTile + i +(j*colNum)).index = 18;
      }
      else{
        Tiles.get(majorStructureTile + i +(j*colNum)).index = 15;
        Tiles.get(majorStructureTile + i +(j*colNum)).hiddenTileOrigin = majorStructureTile + ( floor((multiTheight+1)/2) -1 ) + ( ( floor((multiTwidth+1)/2) -1 ) *colNum);
      }

    }
  }

  //Place the trading outpost
  majorStructureTile = ( floor(random(11, rowNum-10)) * colNum ) + (colNum - 5);  //Random tile BETWEEN LIMITS on the edge of the side of the map
  multiTwidth  = 7; 
  multiTheight = 7;
  for(int j=-floor(multiTwidth/2); j<(multiTwidth+1)/2; j++)
  {
    for(int i=-floor(multiTheight/2); i<(multiTheight+1)/2; i++)
    {

      if( (i==floor(multiTheight/2))&&(j==floor(multiTwidth/2)) ){
        addTradingOutpostToList( Tiles.get( majorStructureTile + i +(j*colNum)).pos, (majorStructureTile + i +(j*colNum)) );
        Tiles.get(majorStructureTile + i +(j*colNum)).index = 17;
      }
      else{
        Tiles.get(majorStructureTile + i +(j*colNum)).index = 15;
        Tiles.get(majorStructureTile + i +(j*colNum)).hiddenTileOrigin = majorStructureTile + ( floor((multiTheight+1)/2) -1 ) + ( ( floor((multiTwidth+1)/2) -1 ) *colNum);
      }

    }
  }

}

//Place optional, smaller structures to the map for variety
void placeMinorStructures(){
  //pass
}

//Creates spots where trees and lakes will form
void seedTreesAndLakes(){
  for(int i=0; i<Tiles.size(); i++)
  {
    if(Tiles.get(i).edgeWater == false)
    {
      prob = Tiles.get(i).tSetO;
      if( (  0  <= prob) && (prob < 198) ){      //99% Nothing
      Tiles.get(i).index=0;}
      if( (198  <= prob) && (prob < 199) ){      //0.5% Tree
      Tiles.get(i).index=8;}
      if( (199  <= prob) && (prob < 200) ){      //0.5% Water
      Tiles.get(i).index=9;}
    }
  }
}

//##MAKE IT SO WATER WANTS TO SPAWN NEAR OTHER WATER, BUNCHING MECHANIC##//
//##NOW NEEDS TO FILL GAPS IN BUNCHING TO FORM LAKES##//
//##TRY BUNCHING WHERE FOR EACH WATER TILE, PROBABILITY IS INCREASED ##//
//##CONTRIBUTES TO LAG A LOT DUE TO LOTS OF TILES THAT CAN COLLIDE, AND SO ARE TRACKED, WILL NEED TO ADJUST APPROACH TO COLLISION OUTSIDE OF SCREEN ##//


//Expand the spots of trees and water into forests and lakes
void populateTreesAndLakes(){
  for (int i=0; i<Tiles.size(); i++)
  {
    if(Tiles.get(i).edgeWater == false)
    {
      if( floor(random(0,100)) < 55)   //55% chance
      {
        if(Tiles.get(i).index == 8)  //Tree
        {
          Tiles.get(i+1).index      = 8;
          Tiles.get(i-1).index      = 8;
          Tiles.get(i+colNum).index = 8;
          Tiles.get(i-colNum).index = 8;
        }
        if(Tiles.get(i).index == 9)  //Water
        {
          Tiles.get(i+1).index      = 9;
          Tiles.get(i-1).index      = 9;
          Tiles.get(i+colNum).index = 9;
          Tiles.get(i-colNum).index = 9;
        }
      }
    }
  }
}


//##ADD REJECTION OPTIONS TO ENSURE ALL MAPS ARE OF HIGH QUALITY##//

//######################################################################################//
//## CAN HAVE OTHER MAPS SAVED AND LOADED, SO YOU CAN VISIT SMALL TOWNS OR OTHER INNS ##//
//######################################################################################//
