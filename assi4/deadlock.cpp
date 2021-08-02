#include <iostream>
#include <fstream>
#include <cstring>
#include <stack>
#include <vector>

using namespace std;

class trans{
private:
    string transNum;
    int count;

public:
    trans() {
        transNum ='0';
        count = 0;
    }
    trans(string i){
        transNum =i;
        count = 1;
    }
    void inc (){
        count++;
    }
    
    void dec (){
        count--;
    }

    string getTransNum() {
        return transNum;
    }

    int getCount (){
        return count;
    }
};

vector<trans> enstack(vector<trans> Stack, trans t){
    Stack.push_back(t);
    return Stack;
}

vector<trans> destack(vector<trans> Stack, trans t){
   
}

int main(){
    ifstream fin ("input.txt");
    cout<<"good"<<endl;
    while (fin.eof() == false){
        string s;
        fin >>s;
        string sub1 = s.substr(0,2);
        string sub2 = s.substr(3,4);

        string tn = s.substr(1,1);
        cout<< sub1<<endl;
        cout<<sub2<<endl;
        
    }

    return 0;
}