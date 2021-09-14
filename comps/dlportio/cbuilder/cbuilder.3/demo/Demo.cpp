//*** TDLPortIO: DriverLINX Port IO Driver wrapper component DEMO ************
//**                                                                        **
//** File: Demo.cpp                                                         **
//**                                                                        **
//** Copyright (c) 1999 John Pappas (DiskDude). All rights reserved.        **
//**     This software is CardWare; if you use it, you must send me a       **
//**     PostCard - see the documentation, or contact me for more           **
//**     information.                                                       **
//**                                                                        **
//**     Please notify me if you make any changes to this file.             **
//**     Email: diskdude@poboxes.com                                        **
//**                                                                        **
//*** http://diskdude.cjb.net/ ***********************************************

#include <vcl.h>
#pragma hdrstop

USERES("Demo.res");
USEFORM("Main.cpp", Main_Win);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR, int)
{
    try
    {
        Application->Initialize();
        Application->Title = "DriverLINX wrapper component demo";
        Application->CreateForm(__classid(TMain_Win), &Main_Win);
                 Application->Run();
    }
    catch (Exception &exception)
    {
        Application->ShowException(&exception);
    }
    return 0;
}

