#ifndef HOMMEXX_ELEMENTS_FORCING_HPP
#define HOMMEXX_ELEMENTS_FORCING_HPP

#include <Types.hpp>

namespace Homme {

class ElementsForcing {
public:

  // Per Element Forcings
  ExecViewManaged<Scalar * [3][NP][NP][NUM_LEV]  >  m_fm;   // Momentum forcing
  ExecViewManaged<Scalar *    [NP][NP][NUM_LEV]  >  m_ft;   // Temperature forcing
  ExecViewManaged<Scalar *    [NP][NP][NUM_LEV_P]>  m_fphi; // Phi (NH) forcing

  ElementsForcing() = default;

  void init(const int num_elems);

private:
  int m_num_elems;
};

} // namespace Homme

#endif // HOMMEXX_ELEMENTS_FORCING_HPP
