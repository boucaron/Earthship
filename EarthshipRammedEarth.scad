// Earthship Generator  with RammedEarth Walls + Insulation on External Walls
// One additional room 
// Rooms : 18 sqm * 4 + 21.6 sqm
// Main Rooms: 36 sqm * 2
// Corridor = 36 sqm
// Plan Surface = 36 sqm
//  Total = 237 sqm
// (c) 2022 Julien BOUCARON under MIT License

// Transform everything from meters to mm
scaleFactor = 1000.0;

// Length in meters of the corridor
length = 30.0;

// Window
windowAngle = 90.0; // Not used
windowHeight = 1.8;
windowWidth = 1.0;
windowDepth = 0.03;
windowColor = "LightBlue";
windowColorAlpha = 0.3;

// WindowChassis
windowChassisWidth = 0.120;
windowChassisHeight = 0.200;
windowChassisColor = "Brown";

// PlantZone between the window and the main corridor
plantZoneWidth = 1.2;
plantHeight = 0.6;
plantColor = "DarkGreen";

// Corridor
corridorWidth = 1.2;
corridorHeight = 0.4;
corridorColor = "MediumBlue";

// "Rooms"
roomColor = "Gold";
roomHeight = 0.4;
roomLength = 6.0;
// room wall internal width
roomWallInternalWidth = 0.4; // Non insulated 
roomWallInternalHeight = 2.5 + roomHeight;
roomWallInternalColor = "Grey";
// List of rooms width
roomListWidth = [0.0, 3.0 , 
    3.0 + roomWallInternalWidth, 3.0,
    6.0 + 2 * roomWallInternalWidth, 3.0,
    9.0 + 3 * roomWallInternalWidth, 6.0,
    15.0 + 4 * roomWallInternalWidth, 6.0,
    21.0 + 5 * roomWallInternalWidth, 3.0,
    24.0 + 6 * roomWallInternalWidth, 3.6];            
     

// LightWells for Rooms
lightWellColor = "LightBlue";
lightWellColorAlpha = 0.3;
lightWellColorHeight = 1.0;
lightWellList = [ 1.0 ,  1.0,
    1.0, 1.0,
    1.0, 1.0,   
    1.5, 1.5,
    1.5, 1.5,
    1.0, 1.0,
    1.0, 1.0];
            
// External Walls - Insulated
// NB: This is just a "visualization", all external insulations are not open to the outside element and form a single wall around the whole house
wallSideWidthExternal = 0.2;
wallSideWidthInternal = 0.2;
wallSideWidthInsulation = 0.2;
wallSideColor = "Red";
wallSideInsulationColor = "Grey";
wallSideFrontOffset = 1.0;

frontWallWidthExternal = 0.2;
frontWallWidthInternal = 0.2;
frontWallWidthInsulation = 0.2;
frontWallHeight = 1.0;
frontWallColor = "Violet";
frontWallInsulationColor = "Grey";

backWallWidthExternal = 0.2;
backWallWidthInternal = 0.2;
backWallWidthInsulation = 0.2;
backWallHeight = roomWallInternalHeight;
backWallColor = "Violet";
backWallInsulationColor = "Grey";


// Beams (assuming IPE) - assuming about 6 Ton load per beam (just a guess)
roomBeamColor = "Indigo";
roomBeamsList= [ 0.16, 0.16,
    0.16, 0.16,
    0.16, 0.16,
    0.22, 0.22,
    0.22, 0.22,
    0.16, 0.16,
    0.16, 0.16
];
roomBeamsCountList = [ 3, 3,
    3, 3,
    3, 3,
    3, 3,
    3, 3,
    3, 3,
    3, 3
];




// Generating corridor
color(corridorColor) cube([corridorWidth * scaleFactor, length * scaleFactor, corridorHeight * scaleFactor]);
// Generating plantZone
translate([corridorWidth * scaleFactor, 0, 0]) color(plantColor) cube([plantZoneWidth * scaleFactor, length * scaleFactor, plantHeight * scaleFactor]);
// Generating rooms
for( i = [0:2:len(roomListWidth) -1]) {
    // Debug
   echo("Index " ); echo(i);
   
    translate([ - roomLength * scaleFactor, roomListWidth[i] * scaleFactor,  0]) color(roomColor) cube([roomLength * scaleFactor,   roomListWidth[i+1] * scaleFactor, roomHeight * scaleFactor]);
    // Walls
    // Debug
     echo("Room Internal Wall Offset "); echo(roomListWidth[i+1] * scaleFactor);
    if ( i < len(roomListWidth) - 2 ) {
       translate([ - roomLength * scaleFactor, (roomListWidth[i] + roomListWidth[i+1]) * scaleFactor,  0]) color(roomWallInternalColor) cube([roomLength * scaleFactor,   roomWallInternalWidth * scaleFactor, roomWallInternalHeight * scaleFactor]);
    }
}
// Generate Side Walls
translate([ - roomLength * scaleFactor, - wallSideWidthInternal * scaleFactor, 0]) color(wallSideColor) cube([( plantZoneWidth + corridorWidth + roomLength + wallSideFrontOffset) * scaleFactor, wallSideWidthInternal * scaleFactor, roomWallInternalHeight * scaleFactor]);
translate([ - roomLength * scaleFactor, length  * scaleFactor, 0]) color(wallSideColor) cube([( plantZoneWidth + corridorWidth + roomLength + wallSideFrontOffset) * scaleFactor, wallSideWidthInternal * scaleFactor, roomWallInternalHeight * scaleFactor]);
translate([ - roomLength * scaleFactor, (- wallSideWidthExternal - wallSideWidthInsulation) * scaleFactor, 0]) color(wallSideInsulationColor) cube([( plantZoneWidth + corridorWidth + roomLength + wallSideFrontOffset) * scaleFactor, wallSideWidthInternal * scaleFactor, roomWallInternalHeight * scaleFactor]);
translate([ - roomLength * scaleFactor, (wallSideWidthInsulation + length)  * scaleFactor, 0]) color(wallSideInsulationColor) cube([( plantZoneWidth + corridorWidth + roomLength + wallSideFrontOffset) * scaleFactor, wallSideWidthInternal * scaleFactor, roomWallInternalHeight * scaleFactor]);
translate([ - roomLength * scaleFactor, (- wallSideWidthExternal - wallSideWidthInsulation - wallSideWidthExternal) * scaleFactor, 0]) color(wallSideColor) cube([( plantZoneWidth + corridorWidth + roomLength + wallSideFrontOffset) * scaleFactor, wallSideWidthInternal * scaleFactor, roomWallInternalHeight * scaleFactor]);
translate([ - roomLength * scaleFactor, (wallSideWidthExternal+ wallSideWidthInsulation + length)  * scaleFactor, 0]) color(wallSideColor) cube([( plantZoneWidth + corridorWidth + roomLength + wallSideFrontOffset) * scaleFactor, wallSideWidthInternal * scaleFactor, roomWallInternalHeight * scaleFactor]);
// Generate Front Wall
translate([(corridorWidth + plantZoneWidth  ) * scaleFactor, 0, 0]) color(frontWallColor) cube([ frontWallWidthInternal* scaleFactor, length * scaleFactor , frontWallHeight * scaleFactor]);
translate([(corridorWidth + plantZoneWidth + frontWallWidthInternal ) * scaleFactor, 0, 0]) color(frontWallInsulationColor) cube([ frontWallWidthInsulation* scaleFactor, length * scaleFactor , frontWallHeight * scaleFactor]);
translate([(corridorWidth + plantZoneWidth + frontWallWidthInternal + frontWallWidthInsulation ) * scaleFactor, 0, 0]) color(frontWallColor) cube([ frontWallWidthExternal* scaleFactor, length * scaleFactor , frontWallHeight * scaleFactor]);
// Generate Back Wall
translate([-(roomLength +backWallWidthInternal ) * scaleFactor, - (wallSideWidthExternal +wallSideWidthInsulation + wallSideWidthInternal ) * scaleFactor, 0]) color(backWallColor) cube([ backWallWidthInternal* scaleFactor, ( length + 2.0 * (wallSideWidthExternal +wallSideWidthInsulation + wallSideWidthInternal ))  * scaleFactor , backWallHeight * scaleFactor]);
translate([-(roomLength +backWallWidthInternal + backWallWidthInsulation ) * scaleFactor, - (wallSideWidthExternal +wallSideWidthInsulation + wallSideWidthInternal ) * scaleFactor, 0]) color(backWallInsulationColor) cube([ backWallWidthInsulation* scaleFactor, ( length + 2.0 * (wallSideWidthExternal +wallSideWidthInsulation + wallSideWidthInternal ))  * scaleFactor , backWallHeight * scaleFactor]);
translate([-(roomLength +backWallWidthInternal + backWallWidthInsulation + backWallWidthExternal ) * scaleFactor, - (wallSideWidthExternal +wallSideWidthInsulation + wallSideWidthInternal ) * scaleFactor, 0]) color(backWallColor) cube([ backWallWidthExternal * scaleFactor, ( length + 2.0 * (wallSideWidthExternal +wallSideWidthInsulation + wallSideWidthInternal ))  * scaleFactor , backWallHeight * scaleFactor]);
// Generate windows + chassis
for( i = [0:windowWidth:length]) {
    // Debug
    echo ("Index Window "); echo (i);
    translate([ (corridorWidth + plantZoneWidth + frontWallWidthInternal  + frontWallWidthInsulation + 0.5 *  frontWallWidthExternal ) * scaleFactor, i * windowWidth * scaleFactor, frontWallHeight * scaleFactor]) color(windowColor, windowColorAlpha) cube([windowDepth * scaleFactor, windowWidth * scaleFactor,  windowHeight * scaleFactor]);
    translate([ (corridorWidth + plantZoneWidth - windowDepth - windowChassisHeight + frontWallWidthInternal  + frontWallWidthInsulation  + 0.5 *  frontWallWidthExternal ) * scaleFactor, ( i + 1) * (windowWidth - 0.5 * windowChassisWidth) * scaleFactor, frontWallHeight * scaleFactor]) color(windowChassisColor) cube([ (windowDepth + windowChassisHeight) * scaleFactor, windowChassisWidth * scaleFactor,  windowHeight * scaleFactor]);
}
// Add chassis Beam all along
 translate([ (corridorWidth + plantZoneWidth - windowDepth - windowChassisHeight + frontWallWidthInternal  + frontWallWidthInsulation  + 0.5 *  frontWallWidthExternal ) * scaleFactor, -(wallSideWidthInternal + wallSideWidthInsulation) * scaleFactor, (windowHeight + frontWallHeight) * scaleFactor]) color(windowChassisColor) cube([ (windowChassisHeight) * scaleFactor, (length + 2 * (wallSideWidthInternal + wallSideWidthInsulation)) * scaleFactor,  windowChassisHeight * scaleFactor]);

// Generate Light Wells for Rooms
for( i = [0:2:len(lightWellList) -1]) {
    // Debug
   echo("Light Well Index " ); echo(i);
   
    translate([ (- roomLength/2 - lightWellList[i]/2 )  * scaleFactor,  (roomListWidth[i] + roomListWidth[i+1]/2 - lightWellList[i+1]/2 )  * scaleFactor,  roomWallInternalHeight * scaleFactor]) color(lightWellColor, lightWellColorAlpha) cube([lightWellList[i] * scaleFactor,   lightWellList[i+1] * scaleFactor, lightWellColorHeight * scaleFactor]);
    // Walls
}


// Generate Beams for Rooms
for( i = [0:2:len(roomBeamsList) -1]) {
    for( j = [0:1:roomBeamsCountList[i]-1]) {
        
        echo(str("Beams Distance to remove = ",(roomBeamsCountList[i]*roomBeamsList[i]) ));
        dist = (roomLength - ((roomBeamsCountList[i]-1)*roomBeamsList[i]))/roomBeamsCountList[i];
        
    // Debug
   echo("Room Beams List Index " ); echo(i);
        if ( i == len(roomBeamsList) -2) {
            translate([ (- roomLength + (j+1) * dist) * scaleFactor, (roomListWidth[i] - roomWallInternalWidth/2)* scaleFactor, roomWallInternalHeight * scaleFactor ]) color(roomBeamColor) cube([ roomBeamsList[i] * scaleFactor, (roomListWidth[i+1]  + roomWallInternalWidth * 1.5) * scaleFactor , roomBeamsList[i+1] * scaleFactor]);
        }
        else if ( i != 0 ) {
            translate([ (- roomLength + (j+1) * dist) * scaleFactor, (roomListWidth[i] - roomWallInternalWidth/2)* scaleFactor, roomWallInternalHeight * scaleFactor ]) color(roomBeamColor) cube([ roomBeamsList[i] * scaleFactor, (roomListWidth[i+1]  + roomWallInternalWidth ) * scaleFactor , roomBeamsList[i+1] * scaleFactor]);
        }       
        else {
             translate([ (- roomLength + (j+1) * dist) * scaleFactor, (roomListWidth[i] - roomWallInternalWidth)* scaleFactor, roomWallInternalHeight * scaleFactor ]) color(roomBeamColor) cube([ roomBeamsList[i] * scaleFactor, (roomListWidth[i+1]  + roomWallInternalWidth * 1.5 ) * scaleFactor , roomBeamsList[i+1] * scaleFactor]);
        }
    }
     
}

// Generate Window Beam // TODO


// Stats
countWindows = length/windowWidth;
echo (str("Windows count = ",countWindows));
rooms = len(roomListWidth)/2;
echo (str("Rooms = ", rooms));
roomSurface = 0;
for( i = [0:2:len(roomListWidth) -1]) {
    currentRoomSurface = roomListWidth[i+1] * roomLength;
    echo (str("Surface Room[",i/2,"] = ", currentRoomSurface  ," square meters"));   
}
echo (str("Plant Surface = ", plantZoneWidth * length)," square meters");
echo (str("Corridor surface = ", corridorWidth * length," square meters"));

