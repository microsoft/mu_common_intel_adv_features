# Overview
* **Feature Name:** USB3 Debug
* **PI Phase(s) Supported:** PEI, DXE
* **SMM Required?** No

More Information:
* [USB 3.1 Device-Class Specification for Debug Devices](https://www.usb.org/sites/default/files/documents/usb_debug_class_rev_1_0_final_0.pdf)
* [Intel&reg; UDK Debugger Tool](https://firmware.intel.com/develop/intel-uefi-tools-and-utilities/intel-uefi-development-kit-debugger-tool)
* [eXtensible Host Controller Interface for Universal Serial Bus (xHCI) Requirements Specification Rev. 1.2](https://www.intel.com/content/dam/www/public/us/en/documents/technical-specifications/extensible-host-controler-interface-usb-xhci.pdf)

## Purpose
The USB3 Debug feature enables EDK II compliant firmware to use a USB3 port on the system for firmware debug. This is an
important capability in firmware development as debug options are often constrained in the later phases of
research and development. In many cases, dedicated debug ports are often removed from an end product, especially in
small form factor devices where external ports are at a premium.

This feature provides a firmware implementation that enables EDK II firmware debug compliant with the USB 3.1 Device
Class Specification for Debug Devices. The feature is intended to be used with the
[UEFI Development Kit Debugger Tool (Intel&reg; UDK Debugger Tool)](https://firmware.intel.com/develop/intel-uefi-tools-and-utilities/intel-uefi-development-kit-debugger-tool).
The Intel&reg; UDK Debugger Tool can be used in a Linux or Windows host environment to retrieve debug message output
and provide runtime debug control via GNU Project Debugger (GDB) or the Microsoft Windows Debug Tool (WinDbg)
respectively.

# High-Level Theory of Operation
*_TODO_*
A description of how the device works at a high-level.

The description should not be constrained to implementation details but provide a simple mental model of how the
feature is supposed to work.

## Firmware Volumes
Not applicable, the feature only produces libraries.

## Modules
* Usb3DebugPortLibDxe
* Usb3DebugPortLibDxeIoMmu
* Usb3DebugPortLibNull
* Usb3DebugPortLibPei
* Usb3DebugPortLibPeiIoMmu
* Usb3DebugPortParamLibPcd

## <Module Name>
*_TODO_*
Each module in the feature should have a section that describes the module in a level of detail that is useful
to better understand the module source code.

## <Library Name>
*_TODO_*
Each library in the feature should have a section that describes the library in a level of detail that is useful
to better understand the library source code.

## Key Functions
*_TODO_*
A bulleted list of key functions for interacting with the feature.

Not all features need to be listed. Only functions exposed through external interfaces that are important for feature
users to be aware of.

## Configuration
*_TODO_*
Information that is useful for configuring the feature.

Not all configuration options need to be listed. This section is used to provide more background on configuration
options than possible elsewhere.

## Data Flows
*_TODO_*
Architecturally defined data structures and flows for the feature.

## Control Flows
*_TODO_*
Key control flows for the feature.

## Build Flows
*_TODO_*
Any special build flows should be described in this section.

This is particularly useful for features that use custom build tools or require non-standard tool configuration. If the
standard flow in the feature package template is used, this section may be empty.

## Test Point Results
No test points implemented

## Functional Exit Criteria
*_TODO_*
The testable functionality for the feature.

This section should provide an ordered list of criteria that a board integrator can reference to ensure the feature is
functional on their board.

## Feature Enabling Checklist
* In the board DSC file, enable the feature
```
[PcdsFeatureFlag]
  gUsb3DebugFeaturePkgTokenSpaceGuid.PcdUsb3DebugFeatureEnable|TRUE
```
* In the board DSC file, select the implementation desired
```
[PcdsFixedAtBuild]
  # 0 = Non-functional instance
  # 1 = Regular instance
  # 2 = IO MMU instance
  gUsb3DebugFeaturePkgTokenSpaceGuid.PcdUsb3DebugPortLibInstance|1
```
* In the board DSC file, configure the PCI device information
```
[PcdsFixedAtBuild]
  gUsb3DebugFeaturePkgTokenSpaceGuid.PcdUsbSerialXhciBus|0x00
  gUsb3DebugFeaturePkgTokenSpaceGuid.PcdUsbSerialXhciDev|0x14
  gUsb3DebugFeaturePkgTokenSpaceGuid.PcdUsbSerialXhciFunc|0x00
  gUsb3DebugFeaturePkgTokenSpaceGuid.PcdXhciDefaultBaseAddress|0xFEA10000
```


## Performance Impact
A general expectation for the impact on overall boot performance due to using this feature.

This section is expected to provide guidance on:
* How to estimate performance impact due to the feature
* How to measure performance impact of the feature
* How to manage performance impact of the feature

## Common Optimizations
* In the board DSC file, tune the timeout value
```
[PcdsFixedAtBuild]
  gUsb3DebugFeaturePkgTokenSpaceGuid.PcdXhciHostWaitTimeout|2000000
```
