#include <iostream>
#include <fstream>
#include <cstring>
#include <string>

using namespace std;

string detect (string* trans,string* object,int sizefortrans){
    int start = 0;
    int end =0;
    for(int i=0;i<sizefortrans;i++){
       string index1 =trans[i];
       string index2 =object[i];
       start =i;
       for (int j=i+1;j<sizefortrans;j++){
           if(index1 ==trans[j] && index2==object[j]){
               end =j;
           }
       }
       if(end!=0)
        break;
    }

    int countlock[sizefortrans];
    for(int i=0;i<sizefortrans;i++){
        countlock[i]=0;
    }
    for(int i=0;i<sizefortrans;i++){
        countlock[stoi(trans[i].substr(1,1),nullptr,0)-1]++;
    }

    //is in dead lock
    bool indeadlock [end];
    for(int i= 0;i<=end;i++){
     indeadlock[i]=false;
    }
    for(int i= start;i<end;i++){
        if(object[i] == object[start])
            indeadlock[stoi(trans[i].substr(1,1),nullptr,0)-1] =true;
    }

    bool counted[end];
    for(int i= 0;i<end;i++){
        counted[i]=false;
        cout<<counted[i]<<endl;
    }
    bool isequal =true;
    if(start<end){
        string least =trans[start];
        for (int i=start;i<end;i++){
            if((countlock[stoi(trans[i].substr(1,1),nullptr,0)-1] < countlock[stoi(least.substr(1,1),nullptr,0)-1])
             && indeadlock[stoi(trans[i].substr(1,1),nullptr,0)-1]==true){
                least = trans[i];
                isequal = false;
            }  
        }
        if(isequal){
            string youngest=trans[0];
            for(int i=0;i<end;i++){
                if(indeadlock[stoi(trans[i].substr(1,1),nullptr,0)-1]==true && counted[stoi(trans[i].substr(1,1),nullptr,0)-1]==false){
                    youngest = trans[i];
                    counted[stoi(trans[i].substr(1,1),nullptr,0)-1]=true;
                
                }
            
            }
            return youngest;
        }
        else
            return least;
    }
    return "OK";
}

int main(){
    ifstream fin ("input.txt");

    int size =0;
    string *lock = new string[size];
    string *object = new string[size];
    string *trans = new string [size];

    while (fin.eof() == false){
        string s;
        fin >>s;
        if (s.substr(3,1) =="S" || s.substr(3,1)=="X"){
            //when we have the first exclusive clock
            if (size ==0){
                if(s.substr(3,1)=="X"){
                    size++;
                     
                    string *newtrans = new string[size];
                    string *newlock = new string[size];
                    string *newobject = new string[size];
                    for(int i = 0;i<size-1;i++){
                        newtrans[i]=trans[i];
                        newlock[i]=lock[i];
                        newobject[i]=object[i];
                    }
                    newtrans[size-1]=s.substr(0,2);
                    newobject[size-1]=s.substr(5,1);
                    newlock[size-1]= s.substr(3,1);
                    object = newobject;
                    lock = newlock;
                    trans = newtrans;
                }
            }
            //have a exclusive clock infront
            else if(s.substr(3,1) =="S" || s.substr(3,1)=="X"){
                size++;
                string *newtrans = new string[size];
                string *newlock = new string[size];
                string *newobject = new string[size];
                for(int i = 0;i<size-1;i++){
                    newtrans[i]=trans[i];
                    newlock[i]=lock[i];
                    newobject[i]=object[i];
                }
                newtrans[size-1]=s.substr(0,2);
                newobject[size-1]=s.substr(5,1);
                newlock[size-1]= s.substr(3,1);
                object = newobject;
                lock = newlock;
                trans = newtrans;
            }
        }
        //abort or commit
        if(s.substr(3,1) =="A" || s.substr(3,1)=="C"){
            for(int i=0; i<size;i++){
                if(trans[i]==s.substr(0,2)){
                    for(int j=i;j<size-1;j++){
                        trans[j]=trans[j+1];
                        lock[j] =lock[j+1];
                        object[j]=object[j+1];
                    }
                    i--;
                    size--;
                }
            }
        }
  
    }
    cout<<endl<<detect(trans,object,size)<<endl;

    delete[] trans;
    delete[] lock;
    delete[] object;
    return 0;
}