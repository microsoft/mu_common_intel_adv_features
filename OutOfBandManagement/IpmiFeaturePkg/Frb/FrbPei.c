/** @file
    IPMI FRB PEIM.

Copyright (c) 2018 - 2019, Intel Corporation. All rights reserved.<BR>
SPDX-License-Identifier: BSD-2-Clause-Patent

**/

#include <PiPei.h>
#include <Library/DebugLib.h>
#include <Library/BaseMemoryLib.h>
#include <Library/IoLib.h>
#include <Library/PcdLib.h>
#include <Library/IpmiCommandLib.h>

#include <IndustryStandard/Ipmi.h>

VOID
SetWatchDogTimer (
  IN BOOLEAN  Frb2Enabled
  )
{
  EFI_STATUS                        Status;
  IPMI_SET_WATCHDOG_TIMER_REQUEST   FrbTimer;
  IPMI_GET_WATCHDOG_TIMER_RESPONSE  GetWatchdogTimer;
  UINT8                             CompletionCode;

  Status = IpmiGetWatchdogTimer (&GetWatchdogTimer);
  if (EFI_ERROR (Status)) {
    return;
  }

  if (Frb2Enabled) {
    ZeroMem (&FrbTimer, sizeof (FrbTimer));
    // Byte 1
    FrbTimer.TimerUse.Bits.TimerUse = IPMI_WATCHDOG_TIMER_BIOS_FRB2;
    // Byte 2
    FrbTimer.TimerActions.Uint8 = 0;    // NormalBoot, NoTimeOutInterrupt. i.e no action when BMC watchdog timeout
    // Byte 3
    FrbTimer.PretimeoutInterval = 0;
    // Byte 4
    FrbTimer.TimerUseExpirationFlagsClear |= BIT1;  // set Frb2ExpirationFlag

    // Data Byte 5/6
    FrbTimer.InitialCountdownValue = PcdGet16 (PcdFRBTimeoutValue) * 10;

    // Set BMC watchdog timer
    Status = IpmiSetWatchdogTimer (&FrbTimer, &CompletionCode);
    Status = IpmiResetWatchdogTimer (&CompletionCode);
  }
}

EFI_STATUS
EFIAPI
InitializeFrbPei (
  IN       EFI_PEI_FILE_HANDLE  FileHandle,
  IN CONST EFI_PEI_SERVICES     **PeiServices
  )

/*++

Routine Description:

Arguments:

  FfsHeader
  PeiServices

Returns:

  EFI_SUCCESS

--*/
{
  BOOLEAN  Frb2Enabled;

  //
  // If we are booting with defaults, then make sure FRB2 is enabled.
  //
  Frb2Enabled = PcdGetBool (PcdFRB2EnabledFlag);

  SetWatchDogTimer (Frb2Enabled);

  return EFI_SUCCESS;
}
