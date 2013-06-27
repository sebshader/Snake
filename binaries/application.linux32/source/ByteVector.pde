
class ByteVector {
  byte x, y, numba;
  
  ByteVector(byte x, byte y){
    this.x = x;
    this.y = y;
    if(x == 0)
      if(y == 1)
        numba = 1;
      else if(y == -1)
        numba = 3;
    if(y == 0)
      if(x == -1)
        numba = 0;
      else if(x == 1)
        numba = 2;
  }
  
  ByteVector(byte numba){
    switch(numba) {
      case 0: this.x = -1; this.y = 0;
        break;
      case 1: this.x = 0; this.y = 1;
        break;
      case 2: this.x = 1; this.y = 0;
        break;
      case 3: this.x = 0; this.y = -1;
    }
  }
  
  void set(byte numba){
    this.numba = numba;
    switch(numba) {
      case 0: this.x = byte(-1); this.y = byte(0);
        break;
      case 1: this.x = byte(0); this.y = byte(1);
        break;
      case 2: this.x = byte(1); this.y = byte(0);
        break;
      case 3: this.x = byte(0); this.y = byte(-1);
    }
  }
  
  void set(byte x, byte y){
    this.x = x;
    this.y = y;
    if(x == 0)
      if(y == 1)
        numba = 1;
      else if(y == -1)
        numba = 3;
    if(y == 0)
      if(x == -1)
        numba = 0;
      else if(x == 1)
        numba = 2;
  }
}
