# [CS:GO] QUICK FIX FOR KICKING ISSUES 2017
This adds fake clients to prevent the first client from being kicked. This issue is related to Windows version of SRCDS and I've been running this solution for months and it works great. Valve has not solved it yet.

Resolve this error: Host_Error: CL_ReadPreserveEnt: u.m_nNewEntity == MAX_EDICTS

## Cvar
  - sm_fakeclients `<0-5>` - `Number of fake clients: Default 1`
