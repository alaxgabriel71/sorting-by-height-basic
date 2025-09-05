void LOGGER_init__(LOGGER *data__, BOOL retain) {
  __INIT_VAR(data__->EN,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->ENO,__BOOL_LITERAL(TRUE),retain)
  __INIT_VAR(data__->TRIG,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MSG,__STRING_LITERAL(0,""),retain)
  __INIT_VAR(data__->LEVEL,LOGLEVEL__INFO,retain)
  __INIT_VAR(data__->TRIG0,__BOOL_LITERAL(FALSE),retain)
}

// Code part
void LOGGER_body__(LOGGER *data__) {
  // Control execution
  if (!__GET_VAR(data__->EN)) {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(FALSE));
    return;
  }
  else {
    __SET_VAR(data__->,ENO,,__BOOL_LITERAL(TRUE));
  }
  // Initialise TEMP variables

  if ((__GET_VAR(data__->TRIG,) && !(__GET_VAR(data__->TRIG0,)))) {
    #define GetFbVar(var,...) __GET_VAR(data__->var,__VA_ARGS__)
    #define SetFbVar(var,val,...) __SET_VAR(data__->,var,__VA_ARGS__,val)

   LogMessage(GetFbVar(LEVEL),(char*)GetFbVar(MSG, .body),GetFbVar(MSG, .len));
  
    #undef GetFbVar
    #undef SetFbVar
;
  };
  __SET_VAR(data__->,TRIG0,,__GET_VAR(data__->TRIG,));

  goto __end;

__end:
  return;
} // LOGGER_body__() 





void PROGRAM0_init__(PROGRAM0 *data__, BOOL retain) {
  __INIT_VAR(data__->HIGHSENSOR,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->LOWSENSOR,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->PALLETSENSOR,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->LOADED,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->ATLEFTENTRY,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->ATLEFTEXIT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->ATRIGHTENTRY,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->ATRIGHTEXIT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->START,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RESET,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->STOP,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->EMERGENCYSTOP,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->AUTO,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->CONVEYORENTRY,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->LOAD,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->UNLOAD,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->TRANSFERLEFT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->TRANSFERRIGHT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->CONVEYORLEFT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->CONVEYORRIGHT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->STARTLIGHT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->RESETLIGHT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->STOPLIGHT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MEMORYRIGHT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->MEMORYLEFT,__BOOL_LITERAL(FALSE),retain)
  __INIT_VAR(data__->COUNTER,0,retain)
  CTU_init__(&data__->CTU0,retain);
  R_TRIG_init__(&data__->R_TRIG1,retain);
}

// Code part
void PROGRAM0_body__(PROGRAM0 *data__) {
  // Initialise TEMP variables

  __SET_VAR(data__->,CONVEYORENTRY,,((((__GET_VAR(data__->ATRIGHTENTRY,) && __GET_VAR(data__->ATLEFTENTRY,)) && !(__GET_VAR(data__->LOADED,))) && __GET_VAR(data__->EMERGENCYSTOP,)) && (__GET_VAR(data__->AUTO,) || (__GET_VAR(data__->STOP,) && ((__GET_VAR(data__->CONVEYORENTRY,) || __GET_VAR(data__->CONVEYORLEFT,)) || __GET_VAR(data__->START,))))));
  __SET_VAR(data__->,CONVEYORLEFT,,(__GET_VAR(data__->EMERGENCYSTOP,) && (__GET_VAR(data__->AUTO,) || (__GET_VAR(data__->STOP,) && ((__GET_VAR(data__->CONVEYORENTRY,) || __GET_VAR(data__->CONVEYORLEFT,)) || __GET_VAR(data__->START,))))));
  __SET_VAR(data__->,CONVEYORRIGHT,,(__GET_VAR(data__->EMERGENCYSTOP,) && (__GET_VAR(data__->AUTO,) || (__GET_VAR(data__->STOP,) && ((__GET_VAR(data__->CONVEYORENTRY,) || __GET_VAR(data__->CONVEYORLEFT,)) || __GET_VAR(data__->START,))))));
  __SET_VAR(data__->,LOAD,,((__GET_VAR(data__->EMERGENCYSTOP,) && !(__GET_VAR(data__->LOADED,))) && (__GET_VAR(data__->LOAD,) || __GET_VAR(data__->PALLETSENSOR,))));
  __SET_VAR(data__->,MEMORYLEFT,,(__GET_VAR(data__->ATLEFTENTRY,) && (__GET_VAR(data__->HIGHSENSOR,) || __GET_VAR(data__->MEMORYLEFT,))));
  __SET_VAR(data__->,MEMORYRIGHT,,(__GET_VAR(data__->ATRIGHTENTRY,) && (__GET_VAR(data__->MEMORYRIGHT,) || (!(__GET_VAR(data__->HIGHSENSOR,)) && __GET_VAR(data__->LOWSENSOR,)))));
  __SET_VAR(data__->,TRANSFERLEFT,,(__GET_VAR(data__->EMERGENCYSTOP,) && ((__GET_VAR(data__->MEMORYLEFT,) && __GET_VAR(data__->LOADED,)) || (!(__GET_VAR(data__->ATLEFTENTRY,)) && __GET_VAR(data__->TRANSFERLEFT,)))));
  __SET_VAR(data__->,TRANSFERRIGHT,,(__GET_VAR(data__->EMERGENCYSTOP,) && ((__GET_VAR(data__->MEMORYRIGHT,) && __GET_VAR(data__->LOADED,)) || (!(__GET_VAR(data__->ATRIGHTENTRY,)) && __GET_VAR(data__->TRANSFERRIGHT,)))));
  __SET_VAR(data__->,STARTLIGHT,,((__GET_VAR(data__->EMERGENCYSTOP,) && __GET_VAR(data__->STOP,)) && (__GET_VAR(data__->START,) || __GET_VAR(data__->STARTLIGHT,))));
  __SET_VAR(data__->,STOPLIGHT,,((__GET_VAR(data__->EMERGENCYSTOP,) && !(__GET_VAR(data__->START,))) && (!(__GET_VAR(data__->STOP,)) || __GET_VAR(data__->STOPLIGHT,))));
  __SET_VAR(data__->,RESETLIGHT,,__GET_VAR(data__->RESET,));
  __SET_VAR(data__->R_TRIG1.,CLK,,(!(__GET_VAR(data__->ATLEFTEXIT,)) || !(__GET_VAR(data__->ATRIGHTEXIT,))));
  R_TRIG_body__(&data__->R_TRIG1);
  __SET_VAR(data__->CTU0.,CU,,__GET_VAR(data__->R_TRIG1.Q,));
  __SET_VAR(data__->CTU0.,R,,(__GET_VAR(data__->RESET,) || __GET_VAR(data__->START,)));
  __SET_VAR(data__->CTU0.,PV,,9999);
  CTU_body__(&data__->CTU0);
  __SET_VAR(data__->,COUNTER,,__GET_VAR(data__->CTU0.CV,));

  goto __end;

__end:
  return;
} // PROGRAM0_body__() 





