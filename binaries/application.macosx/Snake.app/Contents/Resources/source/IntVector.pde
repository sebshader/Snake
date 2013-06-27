class IntVector {
  int x, y;
  
  IntVector(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  IntVector(IntVector ivector){
    this.x = ivector.x;
    this.y = ivector.y;
  }
  
  void incr(ByteVector bvector){
    this.x += bvector.x;
    this.y += bvector.y;
  }
  
  void decr(ByteVector bvector){
    this.x -= bvector.x;
    this.y -= bvector.y;
  }
  
  void set(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  boolean eq(IntVector ivector){
    if(this.x == ivector.x && this.y == ivector.y)
      return true;
    else return false;
  }
}
