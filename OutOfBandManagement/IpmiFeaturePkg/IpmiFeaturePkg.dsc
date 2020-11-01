## @file
# This package provides advanced feature functionality to enable the
# Intelligent Platform Management Interface (IPMI).
# This package should only depend on EDK II Core packages, IntelSiliconPkg, and MinPlatformPkg.
#
# The DEC files are used by the utilities that parse DSC and
# INF files to generate AutoGen.c and AutoGen.h files
# for the build infrastructure.
#
# Copyright (c) 2019, Intel Corporation. All rights reserved.<BR>
#
# SPDX-License-Identifier: BSD-2-Clause-Patent
#
##

[Defines]
  PLATFORM_NAME                  = IpmiFeaturePkg
  PLATFORM_GUID                  = 7B2E74D7-9538-4818-B51A-492F3D33BD20
  PLATFORM_VERSION               = 0.1
  DSC_SPECIFICATION              = 0x00010005
  OUTPUT_DIRECTORY               = Build/$(PLATFORM_NAME)
  SUPPORTED_ARCHITECTURES        = IA32|X64
  BUILD_TARGETS                  = DEBUG|RELEASE|NOOPT
  SKUID_IDENTIFIER               = DEFAULT
  PEI_ARCH                       = IA32
  DXE_ARCH                       = X64

[Packages]
  MinPlatformPkg/MinPlatformPkg.dec

[PcdsFeatureFlag]
  #
  # PCD needed for MinPlatform build includes
  #
  gMinPlatformPkgTokenSpaceGuid.PcdSmiHandlerProfileEnable                |FALSE
  gMinPlatformPkgTokenSpaceGuid.PcdUefiSecureBootEnable                   |FALSE
  gMinPlatformPkgTokenSpaceGuid.PcdPerformanceEnable                      |FALSE

#
# Include common libraries
#
!include MinPlatformPkg/Include/Dsc/CoreCommonLib.dsc
!include MinPlatformPkg/Include/Dsc/CorePeiLib.dsc
!include MinPlatformPkg/Include/Dsc/CoreDxeLib.dsc

#
# This package always builds the feature.
#
!include Include/IpmiFeature.dsc

# MU_CHANGE [BEGIN] - [TCBZ3037] Add several components that are missing in DSCs
[Components]
    IpmiFeaturePkg/Library/IpmiCommandLib/IpmiCommandLib.inf
# MU_CHANGE [END] - [TCBZ3037] Add several components that are missing in DSCs
