#include "component.hpp"
#define OWNED_DLCS      1

[getDLCs OWNED_DLCS] remoteExecCall [QFUNC(receiveOwnedDlcs),2,false];
