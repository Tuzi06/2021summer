#include <iostream>
#include <fstream>
#include <cstring>
#include <queue>
using namespace std;
class frame{
private:
    int pinCount;
public:
    frame(){
        pinCount = 0;
    }

    void unpin(){
        if (pinCount >0)
            pinCount --;
    }

    void pin(){
        pinCount ++;
    }

    int getPinCount(){
        return pinCount;
    }
};

queue<frame*> removePinFromQueue(queue<frame*> q ,frame* s){
    int n = q.size();
    for(int i=0; i<n; i++){
        frame* head = q.front();
        q.pop();
        if(head != s)
            q.push(head);
    }
    return q;
}
queue<int> removePinFromShowQueue(queue<int> q ,int s){
    int n = q.size();
    for(int i=0; i<n; i++){
        int head = q.front();
        q.pop();
        if(head != s)
            q.push(head);
    }
    return q;
}
int sizeOfQueue (queue<frame*> q){
    return q.size();
}
frame* Candidate(queue <frame*> q){
    frame* candidate = q.front();
    return candidate;
}
int main(){
    ifstream fin("input.txt");
    ofstream fout("output.txt");

    int count;
    queue<frame*> oldest;
    queue <int> show;
    fin>>count;

    frame buffer [count];

    while (fin.eof() == false){
        string currentStep;
        fin>>currentStep;
        if(currentStep[0] == 'U'){
            buffer[currentStep[1]-49].unpin();
            oldest.push(& buffer[currentStep[1]-49]);
            show.push (currentStep[1]-48);
            cout<<"after U length of queue="<<sizeOfQueue(oldest)<<endl;
        }
        else if(currentStep[0] == 'P'){
            buffer[currentStep[1]-49].pin();
            oldest = removePinFromQueue (oldest, &buffer[currentStep[1]-49]);
            show = removePinFromShowQueue(show, currentStep[1]-48);
            cout<<"after P length of queue="<<sizeOfQueue(oldest)<<endl;
        }

        else if(currentStep[0] == 'R'){
            frame* candidate = Candidate (oldest);
            int candiateShow = show.front();
            fout<< candiateShow <<"\t";
            show.pop();
            show.push(candiateShow);
            oldest.pop();
            oldest.push(candidate);
            cout<<"after R length of queue="<<sizeOfQueue(oldest)<<endl;
        }
    }

    return 0;
}