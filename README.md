# [CS:GO] QUICK FIX FOR KICKING ISSUES 2017 1.0 BETA 2
This adds fake clients to prevent the first client from being kicked. This issue is related to Windows version of SRCDS and I've been running this solution for months and it works great. Valve has not solved it yet.

Resolve this error: Host_Error: CL_ReadPreserveEnt: u.m_nNewEntity == MAX_EDICTS

## Cvar
  - sm_fakeclients `<0-5>` - `Number of fake clients: Default 1`
  
## Change log
- **1.0 beta 2** - 2017-07-17
  - Adds a check for entities that exceed the maximum number and terminate bad entities.
- **1.0 beta 1** - 2017-07-17
  - beta released!
