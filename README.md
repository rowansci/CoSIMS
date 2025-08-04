# CoSIMS (Rowan's Version)
CoSIMS is a **co**llision **s**imulator for **i**on-**m**obility **s**pectrometry. CoSIMS uses a trajectory-based algorithm for calculating molecular collision cross section (CCS) values for use with ion-mobility mass-spectrometry experiments.

This is a modified version of [CoSIMS](https://github.com/ChristopherAMyers/CoSIMS) that allows the end user to modify the mass and polarizability (in multiples of helium's polarizability) of the collision gas through run-time options. Here's what an input file looks like when using dinitrogen as the collision case:

```
multipole true
gas_mass 28.0134
gas_pos 8.221
threads 8
dt 0.05
iter 10
```

CoSIMS (Rowan's version) is a fork of the original implementation and is available under the same license. If you use CoSIMS, please cite [the original paper](https://pubs.acs.org/doi/10.1021/acs.jpcb.9b01018).
