//*** TDLPortIO: DriverLINX Port IO Driver wrapper component *****************
//**                                                                        **
//** File: Instal.cpp                                                       **
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

USERES("Install.res");
USEFORM("Main.cpp", Main_Win);

//---------------------------------------------------------------------------
// WinMain()
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->Title = "TDLPortIO: DriverLINX driver install";
        Application->CreateForm(__classid(TMain_Win), &Main_Win);
        Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}

