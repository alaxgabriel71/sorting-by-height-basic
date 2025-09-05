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

(*DBG:char md5[] = "264bf9f99b1e77fc03f6d6290416b96b";*)
(*DBG:/**)
(*DBG: * This file is part of OpenPLC Runtime*)
(*DBG: **)
(*DBG: * Copyright (C) 2023 Autonomy, GP Orcullo*)
(*DBG: * Based on the work by GP Orcullo on Beremiz for uC*)
(*DBG: **)
(*DBG: * This program is free software; you can redistribute it and/or*)
(*DBG: * modify it under the terms of the GNU General Public License*)
(*DBG: * as published by the Free Software Foundation; either version 2*)
(*DBG: * of the License, or (at your option) any later version.*)
(*DBG: **)
(*DBG: * This program is distributed in the hope that it will be useful,*)
(*DBG: * but WITHOUT ANY WARRANTY; without even the implied warranty of*)
(*DBG: * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the*)
(*DBG: * GNU General Public License for more details.*)
(*DBG: **)
(*DBG: * You should have received a copy of the GNU General Public License*)
(*DBG: * along with this program; If not, see <http://www.gnu.org/licenses/>.*)
(*DBG: **)
(*DBG: */*)
(*DBG:*)
(*DBG:#include <stdbool.h>*)
(*DBG:*)
(*DBG:#include "iec_types_all.h"*)
(*DBG:#include "POUS.h"*)
(*DBG:*)
(*DBG:#define SAME_ENDIANNESS      0*)
(*DBG:#define REVERSE_ENDIANNESS   1*)
(*DBG:*)
(*DBG:uint8_t endianness;*)
(*DBG:*)
(*DBG:*)
(*DBG:extern PROGRAM0 RES0__INSTANCE0;*)
(*DBG:*)
(*DBG:static const struct {*)
(*DBG:    void *ptr;*)
(*DBG:    __IEC_types_enum type;*)
(*DBG:} debug_vars[] = {*)
(*DBG:    {&(RES0__INSTANCE0.HIGHSENSOR), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.LOWSENSOR), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.PALLETSENSOR), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.LOADED), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ATLEFTENTRY), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ATLEFTEXIT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ATRIGHTENTRY), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.ATRIGHTEXIT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.START), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.RESET), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.STOP), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.EMERGENCYSTOP), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.AUTO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CONVEYORENTRY), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.LOAD), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.UNLOAD), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TRANSFERLEFT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.TRANSFERRIGHT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CONVEYORLEFT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CONVEYORRIGHT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.STARTLIGHT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.RESETLIGHT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.STOPLIGHT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.MEMORYRIGHT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.MEMORYLEFT), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.COUNTER), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTU0.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTU0.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTU0.CU), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTU0.R), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTU0.PV), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTU0.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTU0.CV), INT_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTU0.CU_T.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTU0.CU_T.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTU0.CU_T.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTU0.CU_T.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.CTU0.CU_T.M), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.EN), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.ENO), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.CLK), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.Q), BOOL_ENUM},*)
(*DBG:    {&(RES0__INSTANCE0.R_TRIG1.M), BOOL_ENUM},*)
(*DBG:};*)
(*DBG:*)
(*DBG:#define VAR_COUNT               43*)
(*DBG:*)
(*DBG:uint16_t get_var_count(void)*)
(*DBG:{*)
(*DBG:    return VAR_COUNT;*)
(*DBG:}*)
(*DBG:*)
(*DBG:size_t get_var_size(size_t idx)*)
(*DBG:{*)
(*DBG:    if (idx >= VAR_COUNT)*)
(*DBG:    {*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:    switch (debug_vars[idx].type) {*)
(*DBG:    case BOOL_ENUM:*)
(*DBG:        return sizeof(BOOL);*)
(*DBG:    case INT_ENUM:*)
(*DBG:        return sizeof(INT);*)
(*DBG:    default:*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void *get_var_addr(size_t idx)*)
(*DBG:{*)
(*DBG:    void *ptr = debug_vars[idx].ptr;*)
(*DBG:*)
(*DBG:    switch (debug_vars[idx].type) {*)
(*DBG:    case BOOL_ENUM:*)
(*DBG:        return (void *)&((__IEC_BOOL_t *) ptr)->value;*)
(*DBG:    case INT_ENUM:*)
(*DBG:        return (void *)&((__IEC_INT_t *) ptr)->value;*)
(*DBG:    default:*)
(*DBG:        return 0;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void force_var(size_t idx, bool forced, void *val)*)
(*DBG:{*)
(*DBG:    void *ptr = debug_vars[idx].ptr;*)
(*DBG:*)
(*DBG:    if (forced) {*)
(*DBG:        size_t var_size = get_var_size(idx);*)
(*DBG:        switch (debug_vars[idx].type) {*)
(*DBG:        case BOOL_ENUM: {*)
(*DBG:            memcpy(&((__IEC_BOOL_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_BOOL_t *) ptr)->value = *((BOOL *) val);*)
(*DBG:            ((__IEC_BOOL_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        case INT_ENUM: {*)
(*DBG:            memcpy(&((__IEC_INT_t *) ptr)->value, val, var_size);*)
(*DBG:            //((__IEC_INT_t *) ptr)->value = *((INT *) val);*)
(*DBG:            ((__IEC_INT_t *) ptr)->flags |= __IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:        default:*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:    } else {*)
(*DBG:        switch (debug_vars[idx].type) {*)
(*DBG:        case BOOL_ENUM:*)
(*DBG:            ((__IEC_BOOL_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        case INT_ENUM:*)
(*DBG:            ((__IEC_INT_t *) ptr)->flags &= ~__IEC_FORCE_FLAG;*)
(*DBG:            break;*)
(*DBG:        default:*)
(*DBG:            break;*)
(*DBG:        }*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void swap_bytes(void *ptr, size_t size) *)
(*DBG:{*)
(*DBG:    uint8_t *bytePtr = (uint8_t *)ptr;*)
(*DBG:    size_t i;*)
(*DBG:    for (i = 0; i < size / 2; ++i) *)
(*DBG:    {*)
(*DBG:        uint8_t temp = bytePtr[i];*)
(*DBG:        bytePtr[i] = bytePtr[size - 1 - i];*)
(*DBG:        bytePtr[size - 1 - i] = temp;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void trace_reset(void)*)
(*DBG:{*)
(*DBG:    for (size_t i=0; i < VAR_COUNT; i++) *)
(*DBG:    {*)
(*DBG:        force_var(i, false, 0);*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void set_trace(size_t idx, bool forced, void *val)*)
(*DBG:{*)
(*DBG:    if (idx >= 0 && idx < VAR_COUNT) *)
(*DBG:    {*)
(*DBG:        if (endianness == REVERSE_ENDIANNESS)*)
(*DBG:        {*)
(*DBG:            // Aaaaarghhhh... Stupid AVR is Big Endian.*)
(*DBG:            swap_bytes(val, get_var_size(idx));*)
(*DBG:        }*)
(*DBG:*)
(*DBG:        force_var(idx, forced, val);*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)
(*DBG:void set_endianness(uint8_t value)*)
(*DBG:{*)
(*DBG:    if (value == SAME_ENDIANNESS || value == REVERSE_ENDIANNESS)*)
(*DBG:    {*)
(*DBG:        endianness = value;*)
(*DBG:    }*)
(*DBG:}*)
(*DBG:*)