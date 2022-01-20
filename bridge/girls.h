#ifndef GIRLS_H
#define GIRLS_H

#include <iostream>
#include <vector>
using namespace std;

typedef struct {
  std::string first_name;
  std::string last_name;
}Girl;



extern std::vector<Girl> girls;

#endif // GIRLS_H
