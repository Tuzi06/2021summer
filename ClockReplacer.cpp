#include <iostream>
#include <fstream>
#include <cstring>
using namespace std;

class current {
private:
    bool use;
    bool replace;
    int pinCount;
    
public:
    current(){
        use = false;
        replace = false;
        pinCount=0; //unpin
    }
    void replacement(){
        use = true;
        replace = true;
    }
    void pin(){
        use = true;
        pinCount++;
    }
    void unpin(){
        use = true;
        if(pinCount >0)
            pinCount--;
    }
    bool getReplacement(){
        return replace;
    }
    int getPinCount(){
        return pinCount;
    }
    bool getUse(){
        return use;
    }
};

int main(){
    ifstream fin("input.txt");
    ofstream fout("output.txt");

    int count,j=0;
    int testcount =0;
    fin>>count;
    current frames [count];
    while (fin.eof() == false){
        testcount++;
        string currentStep;
        fin>>currentStep;
        if(currentStep[0] == 'U')
            frames[currentStep[1]].unpin();

        else if(currentStep[0] == 'P')
            frames[currentStep[1]-49].pin();

        else if(currentStep[0] == 'R'){
            while(frames[j].getPinCount()!=0)
                j++;
            int i=j+1;
            j++;
            fout<< i<<"\t";
        }
    }
    return 0;
}