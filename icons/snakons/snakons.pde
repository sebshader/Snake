int dimensions = 1024;
String[] filenamejoin = new String[5];
String[] filenamejoinhires = new String[5];

boolean highres = false, lores = false;
void setup(){
strokeWeight(dimensions/52);
if(lores){
  filenamejoin[0] = "icon_";
  filenamejoin[1] = str(dimensions);
  filenamejoin[2] = "x";
  filenamejoin[3] = str(dimensions);
  filenamejoin[4] = ".png";
}
if(highres){
  filenamejoinhires[0] = "icon_";
  filenamejoinhires[1] = str(dimensions/2);
  filenamejoinhires[2] = "x";
  filenamejoinhires[3] = str(dimensions/2);
  filenamejoinhires[4] = "@2x.png";
}
String filename = join(filenamejoin, "");
String filenamehires = join(filenamejoinhires, "");
size(dimensions, dimensions);
background(255, 125, 0);
fill(255, 0, 0);
fillRect(0, 0);
fill(0, 137, 21);
fillRect(0, 1);
fillRect(0, 2);
fillRect(1, 2);
fillRect(1, 3);
fillRect(2, 3);
fillRect(3, 3);
fillRect(3, 2);
fillRect(3, 1);
fillRect(3, 0);
fillRect(2, 0);
fill(0, 0, 255);
fillRect(2, 2);
if(lores)
  save(filename);
if(highres)
  save(filenamehires);
}

void fillRect(int x, int y){
  rect((x*dimensions)/4, (y*dimensions)/4, dimensions/4, dimensions/4);
}

