TYPE
  LOGLEVEL : (CRITICAL, WARNING, INFO, DEBUG) := INFO;
END_TYPE

FUNCTION_BLOCK LOGGER
  VAR_INPUT
    TRIG : BOOL;
    MSG : STRING;
    LEVEL : LOGLEVEL := INFO;
  END_VAR
  VAR
    TRIG0 : BOOL;
  END_VAR

  IF TRIG AND NOT TRIG0 THEN
  {{
   LogMessage(GetFbVar(LEVEL),(char*)GetFbVar(MSG, .body),GetFbVar(MSG, .len));
  }}
  END_IF;
  TRIG0:=TRIG;
END_FUNCTION_BLOCK


PROGRAM program0
  VAR
    HighSensor : BOOL;
    LowSensor : BOOL;
    PalletSensor : BOOL;
    Loaded : BOOL;
    AtLeftEntry : BOOL;
    AtLeftExit : BOOL;
    AtRightEntry : BOOL;
    AtRightExit : BOOL;
    Start : BOOL;
    Reset : BOOL;
    Stop : BOOL;
    EmergencyStop : BOOL;
    Auto : BOOL;
    ConveyorEntry : BOOL;
    Load : BOOL;
    Unload : BOOL;
    TransferLeft : BOOL;
    TransferRight : BOOL;
    ConveyorLeft : BOOL;
    ConveyorRight : BOOL;
    StartLight : BOOL;
    ResetLight : BOOL;
    StopLight : BOOL;
  END_VAR
  VAR
    MemoryRight : BOOL;
    MemoryLeft : BOOL;
  END_VAR
  VAR
    Counter : INT;
  END_VAR
  VAR
    CTU0 : CTU;
    R_TRIG1 : R_TRIG;
  END_VAR

  ConveyorEntry := AtRightEntry AND AtLeftEntry AND NOT(Loaded) AND EmergencyStop AND (Auto OR Stop AND (ConveyorEntry OR ConveyorLeft OR Start));
  ConveyorLeft := EmergencyStop AND (Auto OR Stop AND (ConveyorEntry OR ConveyorLeft OR Start));
  ConveyorRight := EmergencyStop AND (Auto OR Stop AND (ConveyorEntry OR ConveyorLeft OR Start));
  Load := EmergencyStop AND NOT(Loaded) AND (Load OR PalletSensor);
  MemoryLeft := AtLeftEntry AND (HighSensor OR MemoryLeft);
  MemoryRight := AtRightEntry AND (MemoryRight OR NOT(HighSensor) AND LowSensor);
  TransferLeft := EmergencyStop AND (MemoryLeft AND Loaded OR NOT(AtLeftEntry) AND TransferLeft);
  TransferRight := EmergencyStop AND (MemoryRight AND Loaded OR NOT(AtRightEntry) AND TransferRight);
  StartLight := EmergencyStop AND Stop AND (Start OR StartLight);
  StopLight := EmergencyStop AND NOT(Start) AND (NOT(Stop) OR StopLight);
  ResetLight := Reset;
  R_TRIG1(CLK := NOT(AtLeftExit) OR NOT(AtRightExit));
  CTU0(CU := R_TRIG1.Q, R := Reset OR Start, PV := 9999);
  Counter := CTU0.CV;
END_PROGRAM


CONFIGURATION Config0

  RESOURCE Res0 ON PLC
    TASK task0(INTERVAL := T#20ms,PRIORITY := 0);
    PROGRAM instance0 WITH task0 : program0;
  END_RESOURCE
END_CONFIGURATION
