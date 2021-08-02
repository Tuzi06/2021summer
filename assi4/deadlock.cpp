#include <iostream>
#include <fstream>
#include <cstring>
#include <stack>
#include <vector>

using namespace std;

int main(){
    ifstream fin ("input.txt");
    cout<<"good"<<endl;
    
    int size =0;
    string *lock = new string[size];
    string *object = new string[size];
    string *trans = new string [size];
    while (fin.eof() == false){
        string s;
        fin >>s;
        if (s.substr(3,1) =="S" || s.substr(3,1)=="X"){
            size++;
            string *newlock = new string[size];
            string *newobject = new string[size];
            
            for(int i =0;i<size-1;i++){
                newlock[i]=lock[i];
                newobject[i]=object[i];
            }
            newobject[size-1]=s.substr(5,1);
            newlock[size-1]= s.substr(3,1);
            object = newobject;
            lock = newlock;
            
        }
        
    }
    for (int i=0;i<size;i++){
            cout<<"lock: "<<lock[i]<<"   object: "<< object[i]<<endl;
        }
    delete[] lock;
    delete[] object;
    return 0;
}