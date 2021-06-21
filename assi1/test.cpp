#include <iostream>
using namespace std;

int main(){
    int a =3;
    for (int i=0; i<20;i++){
        a = 10 % a;
        cout<<a<<endl;
    }
    return 0;
}