## @file
# This package provides advanced feature functionality for LOGO.
# This package should only depend on EDK II Core packages.
#
# The DEC files are used by the utilities that parse DSC and
# INF files to generate AutoGen.c and AutoGen.h files
# for the build infrastructure.
#
# Copyright (c) 2020, Intel Corporation. All rights reserved.<BR>
#
# SPDX-License-Identifier: BSD-2-Clause-Patent
#
##

[Defines]
  PLATFORM_NAME                  = LogoFeaturePkg
  PLATFORM_GUID                  = 0618AB19-9507-4D6A-A0D7-1F43D74736CF
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
  LogoFeaturePkg/LogoFeaturePkg.dec

[PcdsFeatureFlag]
  gLogoFeaturePkgTokenSpaceGuid.PcdJpgEnable                              |FALSE

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
!include Include/LogoFeature.dsc

#
# Since the feature include only builds the x64 BMP version, allow building
# all drivers in this package in 32b or 64b modes
#
[Components]
  LogoFeaturePkg/LogoDxe/JpegLogoDxe.inf
  LogoFeaturePkg/LogoDxe/LogoDxe.inf
