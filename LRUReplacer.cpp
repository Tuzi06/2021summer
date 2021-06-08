#include <iostream>
#include <fstream>
#include <cstring>
#include <queue>
using namespace std;

queue<string*> removePinFromQueue(queue<string*> q ,string s){
    int n = q.size();
    for(int i=0; i<n; i++){
        string* head = q.front();
        q.pop();
        if((*head)[1] != s[1])
            q.push(head);
    }
    return q;
}

int sizeOfQueue (queue<string*> q){
    return q.size();
}

int main(){
    ifstream fin("input.txt");
    ofstream fout("output.txt");

    int count;
    queue<string*> oldest;

    fin>>count;

    string buffer [count];

    while (fin.eof() == false){
        string currentStep;
        fin>>currentStep;
        if(currentStep[0] == 'U'){
            buffer[currentStep[1]-49] = currentStep;
            oldest.push(& buffer[currentStep[1]-49]);
            cout<<"after U length of queue="<<sizeOfQueue(oldest)<<endl;
        }
        else if(currentStep[0] == 'P'){
            buffer[currentStep[1]-49] = currentStep;
            oldest = removePinFromQueue (oldest, currentStep);
            cout<<"after P length of queue="<<sizeOfQueue(oldest)<<endl;
        }

        else if(currentStep[0] == 'R'){
            string* candidate = oldest.front();
            fout<< (*candidate)[1] <<"\t";
            oldest.pop();
            oldest.push(candidate);
            cout<<"after R length of queue="<<sizeOfQueue(oldest)<<endl;
        }
    }

    return 0;
}