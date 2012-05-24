#ifndef PARTICLELIST_H
#define PARTICLELIST_H 

/// Collection of particles
typedef struct ParticleList ParticleList;

/// Constructor
ParticleList * CreateParticleList();

/// Destructor
void FreeParticleList(ParticleList * list);

#endif /* PARTICLELIST_H */
