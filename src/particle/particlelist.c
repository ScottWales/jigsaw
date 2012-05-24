#include "particle/particlelist.h"

struct ParticleList {
    size_t count;
};

struct ParticleList * CreateParticleList(){
    struct ParticleList * list = calloc(1,sizeof(*list));
    return list;
}

void FreeParticleList(struct ParticleList * list){
    free(list);
}
