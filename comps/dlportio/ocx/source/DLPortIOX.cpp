//*** TDLPortIOX: DriverLINX Port IO Driver wrapper OCX **********************
//**                                                                        **
//** File: DLPortIOX.cpp                                                    **
//**                                                                        **
//** Copyright (c) 1999 John Pappas (DiskDude). All rights reserved.        **
//**     This software is FreeWare.                                         **
//**                                                                        **
//**     Please notify me if you make any changes to this file.             **
//**     Email: diskdude@poboxes.com                                        **
//**                                                                        **
//*** http://diskdude.cjb.net/ ***********************************************

#include <vcl.h>
#pragma hdrstop
USERES("DLPortIOX.res");
USERES("DLPortIOX.dcr");
USEPACKAGE("VCL35.bpi");
USEUNIT("TDLPortIOX.cpp");
//---------------------------------------------------------------------------
#pragma package(smart_init)

//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
   return 1;
}


