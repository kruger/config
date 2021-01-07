#include <functional>
#include <iostream>

void print_num(int i)
{
    std::cout << i << '\n';
}

std::function<int()> getEnumerator(const int input) {
   //      std::function<int()> enumerator;
   std::cout << input << std::endl;
   return 0;
}
int main()
{
    // store a free function
    getEnumerator(1);
   return 0;
}
