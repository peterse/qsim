import argparse
import os

import numpy as np

# from z2_sim.src.QuantumCircuits.Cirq_Code import io

def make_noisy_htcondor_run_fname(
    proc: int,
    n: int,
    j: float,
    dt: float,
    tstart: int,
    tstop: int,
    zeta: int,
    eps: float,
    ):
    """Return a filename for noiseless parameter sweeps inputs.

    Args:
        tag: Some identifier string for this simulation result.
    """

    jrd = np.round(j, decimals=6)
    dtrd = np.round(dt, decimals=6)
    epsrd = np.round(eps, decimals=6)

    return (f"results_proc{proc}_n{n}_j{jrd}_dt{dtrd}_tstart{tstart}"
                + f"_tstop{tstop}_zeta{zeta}_eps{epsrd}.npy")


parser = argparse.ArgumentParser(add_help=True)
parser.add_argument('-proc', metavar='proc', type=int, nargs=1,
                    help='htcondor process number')
parser.add_argument('-n', metavar='n', type=int, nargs=1,
                    help='length of spacial dimension')
parser.add_argument('-j', metavar='j', type=float, nargs=1,
                    help='Electric Field Coupling (1/beta)')
parser.add_argument('-dt', metavar='dt', type=float, nargs=1,
                    help='Trotter time step')
parser.add_argument('-tstart', metavar='tstart', type=int, nargs=1,
                    help='Trotter step startpoint')
parser.add_argument('-tstop', metavar='tstop', type=int, nargs=1,
                    help='Trotter step stop-point')
parser.add_argument('-zeta', metavar='zeta', type=int, nargs=1,
                    help='Unitary crosstalk noise parameter')
parser.add_argument('-eps', metavar='eps', type=float, nargs=1,
                    help='Depolarizing noise parameter')

args = parser.parse_args()

# Subroutine
proc = args.proc[0]
n = args.n[0]
j = args.j[0]
dt = args.dt[0]
tstart = args.tstart[0]
tstop = args.tstop[0]
zeta = args.zeta[0]
eps = args.eps[0]


# This is to expedite file transfers from the submission nodes, since the .sub
# doesn't know the output file name
fout = make_noisy_htcondor_run_fname(proc, n, j, dt, tstart, tstop, zeta, eps)

outdir = "temp"
os.mkdir(outdir)
np.save(os.path.join(outdir, fout), np.ones(3))