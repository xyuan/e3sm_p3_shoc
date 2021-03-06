#include "ekat_comm.hpp"

#include <cassert>

namespace ekat
{

Comm::Comm()
{
  check_mpi_inited();
  reset_mpi_comm (MPI_COMM_SELF);
}

Comm::Comm(MPI_Comm mpi_comm)
{
  check_mpi_inited();
  reset_mpi_comm (mpi_comm);
}

void Comm::reset_mpi_comm (MPI_Comm new_mpi_comm)
{
  m_mpi_comm = new_mpi_comm;

  MPI_Comm_size(m_mpi_comm,&m_size);
  MPI_Comm_rank(m_mpi_comm,&m_rank);

#ifdef EKAT_MPI_ERRORS_ARE_FATAL
  MPI_Comm_set_errhandler(m_mpi_comm,MPI_ERRORS_ARE_FATAL);
#else
  MPI_Comm_set_errhandler(m_mpi_comm,MPI_ERRORS_RETURN);
#endif
}

void Comm::barrier () const
{
  check_mpi_inited();
  MPI_Barrier(m_mpi_comm);
}

Comm Comm::split (const int color) const
{
  check_mpi_inited ();

  MPI_Comm new_comm;
  MPI_Comm_split(m_mpi_comm,color,m_rank,&new_comm);

  return Comm(new_comm);
}

void Comm::check_mpi_inited () const
{
  int flag;
  MPI_Initialized (&flag);
  assert (flag!=0);
}


} // namespace ekat
