PROGRAM program0
  VAR
    HighSensor AT %IX100.0 : BOOL;
    LowSensor AT %IX100.1 : BOOL;
    PalletSensor AT %IX100.2 : BOOL;
    Loaded AT %IX100.3 : BOOL;
    AtLeftEntry AT %IX100.4 : BOOL;
    AtLeftExit AT %IX100.5 : BOOL;
    AtRightEntry AT %IX100.6 : BOOL;
    AtRightExit AT %IX100.7 : BOOL;
    Start AT %IX100.8 : BOOL;
    Reset AT %IX100.9 : BOOL;
    Stop AT %IX100.10 : BOOL;
    EmergencyStop AT %IX100.11 : BOOL;
    Auto AT %IX100.12 : BOOL;
    ConveyorEntry AT %QX100.0 : BOOL;
    Load AT %QX100.1 : BOOL;
    Unload AT %QX100.2 : BOOL;
    TransferLeft AT %QX100.3 : BOOL;
    TransferRight AT %QX100.4 : BOOL;
    ConveyorLeft AT %QX100.5 : BOOL;
    ConveyorRight AT %QX100.6 : BOOL;
    StartLight AT %QX100.7 : BOOL;
    ResetLight AT %QX100.8 : BOOL;
    StopLight AT %QX100.9 : BOOL;
  END_VAR
  VAR
    MemoryRight : BOOL;
    MemoryLeft : BOOL;
  END_VAR
  VAR
    Counter AT %QW100 : INT;
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
