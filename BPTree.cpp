#include <climits>
#include <fstream>
#include <iostream>
#include <sstream>
using namespace std;

// TODO: Try different numbers
// Note different behavior for odd numbers
int MAX = 3;

// BP node 
class Node {
  bool IS_LEAF;
  int *key, size;
  Node **ptr;
  friend class BPTree;

  public:
    Node();
};

// BP tree
class BPTree {
  Node *root;
  void insertInternal(int, Node *, Node *);
  Node *findParent(Node *, Node *);

  public:
    BPTree();
    void search(int);
    void insert(int);
    void deletes(int);
    void display(Node *);
    Node *getRoot();
};

Node::Node() {
  key = new int[MAX];
  ptr = new Node *[MAX + 1];
}

BPTree::BPTree() {
  root = NULL;
}

// Search operation
void BPTree::search(int x) {
  // Emtry tree
  if (root == NULL) {
    cout << "Tree is empty\n";
  } else {
    Node *cursor = root;
    // Traverse the tree
    while (cursor->IS_LEAF == false) {
      for (int i = 0; i < cursor->size; i++) {
        // Check left child pointer to key
        if (x < cursor->key[i]) {
          cursor = cursor->ptr[i];
          break;
        }
        // Check right child pointer to node
        if (i == cursor->size - 1) {
          cursor = cursor->ptr[i + 1];
          break;
        }
      }
    }
    // Check the current leaf
    for (int i = 0; i < cursor->size; i++) {
      if (cursor->key[i] == x) {
        cout << "Found\n";
        return;
      }
    }
    cout << "Not found\n";
  }
}

// Insert Operation
void BPTree::insert(int x) {
  // Empty root : insert at root
  if (root == NULL) {
    root = new Node;
    root->key[0] = x;
    root->IS_LEAF = true;
    root->size = 1;
  } else {
    // Otherwise traverse to find appropriate insert place
    Node *cursor = root;
    Node *parent;
    // Traverse to appropriate leaf
    while (cursor->IS_LEAF == false) {
      parent = cursor;
      // Explore children
      for (int i = 0; i < cursor->size; i++) {
        if (x < cursor->key[i]) {
          cursor = cursor->ptr[i];
          break;
        }
        if (i == cursor->size - 1) {
          cursor = cursor->ptr[i + 1];
          break;
        }
      }
    }
    // Leaf node found
    if (cursor->size < MAX) {
      // Space available on node: insert key
      int i = 0;
      while (x > cursor->key[i] && i < cursor->size)
        i++;
      for (int j = cursor->size; j > i; j--) {
        cursor->key[j] = cursor->key[j - 1];
      }
      cursor->key[i] = x;
      cursor->size++;
      cursor->ptr[cursor->size] = cursor->ptr[cursor->size - 1];
      cursor->ptr[cursor->size - 1] = NULL;
    } else { 
      // No space on node: create new interim node
      Node *newLeaf = new Node; 
      int virtualNode[MAX + 1];
      // Find key location on new node 
      for (int i = 0; i < MAX; i++) {
        virtualNode[i] = cursor->key[i];
      }
      // Insert new key value and shift larger keys
      int i = 0, j;
      while (x > virtualNode[i] && i < MAX)
        i++;
      for (int j = MAX + 1; j > i; j--) {
        virtualNode[j] = virtualNode[j - 1];
      }
      virtualNode[i] = x;
      newLeaf->IS_LEAF = true;
      cursor->size = (MAX + 1) / 2;
      newLeaf->size = MAX + 1 - (MAX + 1) / 2;
      cursor->ptr[cursor->size] = newLeaf;
      newLeaf->ptr[newLeaf->size] = cursor->ptr[MAX];
      cursor->ptr[MAX] = NULL;
      for (i = 0; i < cursor->size; i++) {
        cursor->key[i] = virtualNode[i];
      }
      // Copy search keys to new node
      for (i = 0, j = cursor->size; i < newLeaf->size; i++, j++) {
        newLeaf->key[i] = virtualNode[j];
      }
      if (cursor == root) {
        // Perform root split
        Node *newRoot = new Node;
        newRoot->key[0] = newLeaf->key[0];
        newRoot->ptr[0] = cursor;
        newRoot->ptr[1] = newLeaf;
        newRoot->IS_LEAF = false;
        newRoot->size = 1;
        root = newRoot;
      } else {
        // Perform parent updates
        insertInternal(newLeaf->key[0], parent, newLeaf);
      }
    }
  }
}

// Insert Operation (internal parent updates)
void BPTree::insertInternal(int x, Node *cursor, Node *child) {
  if (cursor->size < MAX) {
    // No split required, just parent updates
    int i = 0;
    while (x > cursor->key[i] && i < cursor->size)
      i++;
    for (int j = cursor->size; j > i; j--) {
      cursor->key[j] = cursor->key[j - 1];
    }
    for (int j = cursor->size + 1; j > i + 1; j--) {
      cursor->ptr[j] = cursor->ptr[j - 1];
    }
    cursor->key[i] = x;
    cursor->size++;
    cursor->ptr[i + 1] = child;
  } else {
    // Split and parent updates
    Node *newInternal = new Node;
    int virtualKey[MAX + 1];
    Node *virtualPtr[MAX + 2];
    for (int i = 0; i < MAX; i++) {
      virtualKey[i] = cursor->key[i];
    }
    for (int i = 0; i < MAX + 1; i++) {
      virtualPtr[i] = cursor->ptr[i];
    }
    int i = 0, j;
    while (x > virtualKey[i] && i < MAX)
      i++;
    for (int j = MAX; j > i; j--) {
      virtualKey[j] = virtualKey[j - 1];
    }
    virtualKey[i] = x;
    for (int j = MAX + 1; j > i + 1; j--) {
      virtualPtr[j] = virtualPtr[j - 1];
    }
    virtualPtr[i + 1] = child;
    newInternal->IS_LEAF = false;
    cursor->size = (MAX + 1) / 2;
    newInternal->size = MAX - (MAX + 1) / 2;
    // The split
    for (i = 0; i < cursor->size; i++){
      cursor->key[i] = virtualKey[i];
      cursor->ptr[i] = virtualPtr[i];
    }
    cursor->ptr[i] = virtualPtr[i];
    for (i = 0, j = cursor->size + 1; i < newInternal->size; i++, j++) {
      newInternal->key[i] = virtualKey[j];
    }
    for (i = 0, j = cursor->size + 1; i < newInternal->size + 1; i++, j++) {
      newInternal->ptr[i] = virtualPtr[j];
    }
    if (cursor == root) {
      Node *newRoot = new Node;
      newRoot->ptr[0] = cursor;
      newRoot->ptr[1] = newInternal;
      newRoot->IS_LEAF = false;
      newRoot->size = 1;
      cursor = newInternal;
      // Find smallest key of right tree
      while(cursor->ptr[0] != NULL){
        cursor = cursor->ptr[0];
      }
      // Root key is the smallest key of the right tree
      newRoot->key[0] = cursor->key[0];
      root = newRoot;
    } else {
      insertInternal(cursor->key[cursor->size], findParent(root, cursor), newInternal);
    }
  }
}

// Delete Operation
void BPTree::deletes(int x) {
    //TODO: Fill this part out!
    int max;
    if(MAX%2!=0)
        max= MAX+1;
    else 
        max = MAX;

    if(root == NULL) 
        return;
    Node *cursor = root;
    Node *parent;
    while (cursor->IS_LEAF == false) {
        parent = cursor;
        for (int i = 0; i < cursor->size; i++) {
            if (x < cursor->key[i]) {
                cursor = cursor->ptr[i];
                break;
            }
            if (i == cursor->size - 1) {
                cursor = cursor->ptr[i + 1];
                break;
            }
        }
    }

    for (int i = 0; i < cursor->size; i++) {
        // we have more element than the minimum occupancy requirement, so can just delete
        if (cursor->key[i] == x && cursor->size> max/2) {
            if(i==0)
                for(int j=0; j <=parent->size; j++)
                    if(parent->ptr[j] == cursor)
                        parent->key[j-1]= cursor->key[1];
                for(int j= i; j<cursor->size -1;j++)
                    cursor->key[j]= cursor->key[j+1];
            cursor->size -= 1;
        }
        // we get the condition where we need either redistribution or merge
        else if(cursor->key[i] == x && cursor->size<=max/2){
            cout<<"merge or redist"<<endl;
            Node* sibL=NULL;
            Node* sibR=NULL;
            //we find siblings for redistribution
            int j=0;// j is the index in the parent for the current child page we have
            for(; j <=parent->size; j++){
                if(parent->ptr[j] == cursor){
                    if(j>0)
                        sibL = parent->ptr[j-1];
                    if(j<parent->size)
                        sibR = parent->ptr[j+1];
                    break;
                }
            }
            //if we have only one element in the page, then just delete the page
            if(cursor->size ==1){
                delete parent->ptr[j];
                for(int l=j;l<parent->size;l++){
                    parent->key[l]=parent->key[l+1];
                    parent->ptr[l+1]=parent->ptr[l+2];
                }
                parent->ptr[parent->size]=NULL;
                parent->size--;
            }
            //redistribution with left sibling
            else if(sibL!=NULL && sibL->size>max/2){
                cout<<"redistribution left"<<endl;
                int swap = sibL->key[sibL->size-1];
                sibL->size -=1;
                cursor->size ++;
                for(int l= cursor->size -1; l>0;l--)
                    cursor->key[l]= cursor->key[l-1];
                cursor->key[0] = swap;
                parent->key[j-1]=swap;
            }
            //redistribution with right sibling
            else if(sibR!=NULL && sibR->size>max/2){
                cout<<"redistribution right"<<endl;
                int swap =sibR->key[0];
                for(int l =0; l<sibR->size -1; l++)
                    sibR->key[l]=sibR->key[l+1];
                sibR->size --;
                cursor->size++;
                cursor->key[cursor->size-1] =swap;
                parent->key[j]= sibR->key[0];
            }
            //we have to do merge now
            else {
                cout<<"merge"<<endl;
                for(int l= i; l<cursor->size -1;l++){
                    cursor->key[l]= cursor->key[l+1];
                }
                cursor->size -= 1;
                do{
                    if(sibL!= NULL){
                        cout<<"merge with left"<<endl;
                        while(cursor->size>0){
                            sibL->size++;
                            sibL->key[sibL->size-1]=cursor->key[0];
                            if(!cursor->IS_LEAF)
                            sibL->ptr[sibL->size]=cursor->ptr[0];
                            for(int l=0; l<cursor->size-1;l++){
                                cursor->key[l]=cursor->key[l+1];
                                if(!cursor->IS_LEAF)
                                    cout<<"NOthing"<<endl;
                                    //cursor->ptr[l]=cursor->ptr[l+1];
                            }
                            cursor->size--;
                        }
                    }
                    else if(sibR!=NULL){
                        cout<<"merge with right"<<endl;
                        while(cursor->size >0){
                            sibR->size++;
                            for(int l=sibR->size;l>0;l--){
                                sibR->key[l]= sibR->key[l-1];
                                if(!cursor->IS_LEAF)
                                    cout<<"NOthing"<<endl;
                                    //sibR->ptr[l+1]= sibR->ptr[l];
                            }
                            sibR->key[0]=cursor->key[cursor->size];
                            if(!cursor->IS_LEAF)
                                cout<<"NOthing"<<endl;
                                //sibR->ptr[0]=cursor->ptr[cursor->size];
                            cursor->size--;
                            parent->key[j] = sibR->key[0];
                        }
                    }   
                    //delete parent->ptr[j];
                    for(int l=j;l<parent->size;l++){
                        parent->key[l-1] =parent->key[l];
                        parent->ptr[l] = parent->ptr[l+1];
                    }
          
                    parent->size--;
                    if(findParent(root, cursor)==NULL)
                        cursor = parent;
                    else
                        cursor = findParent(root, cursor);
                }while(cursor!= root && cursor->size <max/2);
            }
        }
    }
}

// Find the parent
Node *BPTree::findParent(Node *cursor, Node *child) {
  Node *parent;
  // Parent is not leaf & the tree is balanced
  if ((cursor->IS_LEAF) || (cursor->ptr[0])->IS_LEAF) {
    return NULL;
  }
  for (int i = 0; i < cursor->size + 1; i++) {
    // If this node is the parent of passed child
    if (cursor->ptr[i] == child) {
      parent = cursor;
      return parent;
    // Otherwise traverse recursively to find parent
    } else {
      parent = findParent(cursor->ptr[i], child);
      if (parent != NULL)
        return parent;
    }
  }
  return parent;
}

// Print the tree (each node then its pointers)
void BPTree::display(Node *cursor) {
  if (cursor != NULL) {
    // Print keys of the current node
    for (int i = 0; i < cursor->size; i++) {
      cout << cursor->key[i] << " ";
    }
    cout << "\n";
    // Recursively call to print the next level
    if (cursor->IS_LEAF != true) {
      for (int i = 0; i < cursor->size + 1; i++) {
        display(cursor->ptr[i]);
      }
    }
  }
}

// Get the root
Node *BPTree::getRoot() {
  return root;
}

int main() {
  BPTree node;
  node.insert(5);
  node.insert(15);
  node.insert(25);
  node.insert(35);
  node.insert(45);
  node.insert(55);
  node.insert(40);
  node.insert(30);
  node.insert(20);
  node.display(node.getRoot());

  node.search(15);
}