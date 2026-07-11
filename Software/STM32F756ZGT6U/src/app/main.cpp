#include <cstdint>


class Test
{
private:
  /* data */
public:
  Test(std::uint32_t test)
  : test_(test)
  {};
  
  std::uint32_t test_;

  ~Test() = default;

};



int main(){
  
  Test test(5);
  std::uint32_t t = test.test_;
  
  return 0;
}