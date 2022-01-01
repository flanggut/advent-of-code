#include <list>
#include <array>
#include <iostream>
#include <vector>

constexpr int large = 1'000'000;
constexpr int numMoves = 10'000'000;
// constexpr int large = 9;
// constexpr int numMoves = 10;

std::string a = "asasas";

std::vector<std::list<int>::iterator> iterForV(large);

void advanceIter(std::list<int>& circle, std::list<int>::iterator& iter) {
  ++iter;
  if(iter == circle.end()) {
    iter = circle.begin();
  }
}

void move(std::list<int>& circle, std::list<int>::iterator iterin) {
  auto iter = iterin;
  const int currentV = *iter;
  advanceIter(circle, iter);

  std::array<int, 3> next3V;
  for (int i = 0; i < 3; ++i) {
    next3V[i] = *iter;
    iter = circle.erase(iter);
    if(iter == circle.end()) {
      iter = circle.begin();
    }
  }

  int nextV = currentV - 1;
  if (nextV < 1) {
    nextV = large;
  }
  while (nextV == next3V[0] || nextV == next3V[1] || nextV == next3V[2]) {
    nextV = nextV - 1;
    if (nextV < 1) {
      nextV = large;
    }
  }
  iter = iterForV[nextV];

  iter = circle.insert(++iter, next3V.begin(), next3V.end());
  iterForV[next3V[0]] = iter;
  iterForV[next3V[1]] = ++iter;
  iterForV[next3V[2]] = ++iter;
}

void printC(std::list<int>& c) {
  for (int a : c) {
    std::cout << a << ", ";
  }
  std::cout << std::endl;
}

int main() {
  // std::list<int> circle = {3, 8, 9, 1, 2, 5, 4, 6, 7};
  std::list<int> circle = {1,9,3,4,6,7,2,5,8};
  for (int i = 10; i <= large; ++i) {
    circle.push_back(i);
  }
  for (auto iter = circle.begin(); iter != circle.end(); ++iter) {
    iterForV[*iter] = iter;
  }

  auto currentIter = circle.begin();
  for (int i = 1; i <= numMoves; ++i) {
    if (i % 1000 == 0) std::cout << i << std::endl;
    move(circle, currentIter);
    advanceIter(circle, currentIter);
  }
  if (numMoves < 1000)
    printC(circle);

  currentIter = std::find(circle.begin(), circle.end(), 1);
  advanceIter(circle, currentIter);
  int64_t v1 = *currentIter;
  advanceIter(circle, currentIter);
  int64_t v2 = *currentIter;
  std::cout << v1 * v2 << std::endl;
  return 0;
}
