int add1(int b) {
  int a=getint();
  return b+a;
}

int main(){
  const int b=add1(3);
  int arr[b+1]={};
  arr[3]=2;
  // arr[0]=1;
  // return arr[0];
  return arr[b];
}