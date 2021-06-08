#include <iostream>
#include <fstream>
#include <cstring>
#include <queue>
using namespace std;

class current {
private:
    bool candidate;
    int pinCount;
    
public:
    current(){
        candidate = false;
        pinCount=0;
    }
    void replace(){
        candidate = true;
    }
    void pin(){
        pinCount++;
    }
    void unpin(){
        if(pinCount >0)
            pinCount--;
    }

    int getPinCount(){
        return pinCount;
    }

    bool getCandidate(){
        return candidate;
    }
    
};

queue<int> removePinFromQueue(queue<int> q, int pin){
    int n=q.size();
    for(int i=0; i<n;i++){
        int intval =q.front();
        q.pop();
        if(intval != pin)
            q.push(intval);
    }
    return q;
}

int main(){
    ifstream fin("input.txt");
    ofstream fout("output.txt");

    int count;
    queue<int> oldest;

    fin>>count;
    current buffer[count];
    while (fin.eof() == false){
        string currentStep;
        fin>>currentStep;
        if(currentStep[0] == 'U'){
            buffer[currentStep[1]-49].unpin();
            if( buffer[currentStep[1]-49].getPinCount() == 0)
                oldest.push(currentStep[1]-48);
        }
        else if(currentStep[0] == 'P'){
            buffer[currentStep[1]-49].pin();
            oldest= removePinFromQueue(oldest,currentStep[1]-48);
        }

        else if(currentStep[0] == 'R'){
            buffer[currentStep[1]-49].replace();
            int refer = oldest.front();
            fout<<refer<<"\t";
            oldest.pop();
            oldest.push(refer);
        }
    }

    return 0;
}