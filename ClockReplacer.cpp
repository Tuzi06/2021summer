#include <iostream>
#include <fstream>
#include <cstring>
#include <queue>
using namespace std;

class frame{
private:
    bool referenceBit;
    int pinCount;
    
public:
    frame(){
        referenceBit = false;
        pinCount=0;
    }
    void replace(){
        referenceBit = true;
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

    bool getRefernceBit(){
        return referenceBit;
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

frame Candiate(frame buffer[], int i)
{
    return buffer[i];
}

int sizeOfQueue (queue<int> q){
    return q.size();
}
int main(){
    ifstream fin("input.txt");
    ofstream fout("output.txt");

    int count;
    queue<int> oldest;

    fin>>count;
    frame buffer[count];
    while (fin.eof() == false){
        string currentStep;
        fin>>currentStep;
        if(currentStep[0] == 'U'){
            buffer[currentStep[1]-49].unpin();
            if( buffer[currentStep[1]-49].getPinCount() == 0)
                oldest.push(currentStep[1]-48);
            cout<<"after U length of queue="<<sizeOfQueue(oldest)<<endl;
        }
        else if(currentStep[0] == 'P'){
            buffer[currentStep[1]-49].pin();
            oldest= removePinFromQueue(oldest,currentStep[1]-48);
            cout<<"after P length of queue="<<sizeOfQueue(oldest)<<endl;
        }

        else if(currentStep[0] == 'R'){
            buffer[currentStep[1]-49].replace();
            int refer = oldest.front();
            frame currentCandidate = Candiate(buffer,refer);
            fout<<refer<<"\t";
            oldest.pop();
            oldest.push(refer);
            cout<<"after R length of queue="<<sizeOfQueue(oldest)<<endl;
        }
    }

    return 0;
}