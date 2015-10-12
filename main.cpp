#include <iostream>
#include <string>
#include "src/tail_call.h"

int factorial(int n)
{
  return n<2 ? 1 : n*factorial(n - 1);
}

int tailcall_factorial(int n, int r)
{
  return n<2 ? r : factorial(n - 1, n*r);
}

int main()
{
  using namespace TailCallCpp;
  auto MyFactorial = TailCallCpp::RecWrapper<int(int, int)>([](auto& fact) {
    return [=](int n, int r) {
      return n < 2 ? r : fact(n - 1, n*r);
    };
  });

  std::cout << MyFactorial(5, 1) << std::endl;
  std::cout << factorial(5) << std::endl;
  std::cout << tailcall_factorial(5, 1) << std::endl;


  //const int N = 1000000;
  //std::cout << MyFactorial(N, 1) << std::endl; // never segfaults thanks to tail call optimization :)
  //std::cout << factorial(N) << std::endl; // will segfault (due to recursivity)
  //std::cout << tailcall_factorial(N, 1) << std::endl; // no tail call optimization :( also segfaults

}
