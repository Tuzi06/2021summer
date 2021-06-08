#include <iostream>
#include <fstream>
using namespace std;

int main(){
    ifstream fin("input.exe");
    int count;
    fin>>count;
    cout<< count <<endl;
    return 0;
}