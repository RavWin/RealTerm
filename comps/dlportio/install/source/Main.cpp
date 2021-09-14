//*** TDLPortIO: DriverLINX Port IO Driver wrapper component *****************
//**                                                                        **
//** File: Main.cpp                                                         **
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

#include "Main.h"

#pragma package(smart_init)
#pragma resource "*.dfm"

TMain_Win *Main_Win;

// WinNT DriverLINX Information
const AnsiString DRIVER_NAME  = "DLPortIO";
const AnsiString DISPLAY_NAME = "DriverLINX Port I/O Driver";
const AnsiString DRIVER_GROUP = "SST miniport drivers";

//---------------------------------------------------------------------------
// TMain_Win()
//---------------------------------------------------------------------------
__fastcall TMain_Win::TMain_Win(TComponent* Owner) : TForm(Owner)
{
   // Are we running Windows NT?
   OSVERSIONINFO os;
   memset(&os, NULL, sizeof(OSVERSIONINFO));
   os.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
   GetVersionEx(&os);
   FRunningWinNT=(os.dwPlatformId==VER_PLATFORM_WIN32_NT);

   // Get the Windows NT driver path
   char Buffer[MAX_PATH];
   GetSystemDirectory(Buffer, MAX_PATH);
   FDriverPath = AnsiString(Buffer)+"\\DRIVERS";

   // Get the Windows System path
   FDLLPath = AnsiString(Buffer);

   // Get the program path (path of .EXE)
   FProgPath = ExtractFileDir(ParamStr(0));
   if (FProgPath.c_str()[FProgPath.Length()-1]=='\\')
      FProgPath=FProgPath.SubString(1, FProgPath.Length()-1);
}

//---------------------------------------------------------------------------
// InstallDriver()
//    Installs the DriverLINX driver into the registry.
//---------------------------------------------------------------------------
bool __fastcall TMain_Win::InstallDriver()
{
   DWORD dwStatus = 0; // Assume success, until we prove otherwise
   SC_HANDLE hSCMan;   // For use with WinNT Service Control Manager
   SC_HANDLE hService; // Handle to the new service

   // Driver path including filename
   AnsiString DriverPath = FDriverPath+"\\"+DRIVER_NAME+".SYS";

   // Connect to the SCM as Administrator
   hSCMan = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);

   if (hSCMan!=NULL)
   {
      // Is the DriverLINX driver already in the SCM? If so, indicate success.
      hService=OpenService(hSCMan, DRIVER_NAME.c_str(), SERVICE_QUERY_STATUS);
      if (hService!=NULL)
      {
         CloseServiceHandle(hService); // Close the service
         CloseServiceHandle(hSCMan);   // Disconnect from the SCM
         return true;                  // Success
      }

      // Install the driver to the system
      hService=CreateService(
                  hSCMan,
                  DRIVER_NAME.c_str(),
                  DISPLAY_NAME.c_str(),
                  SERVICE_ALL_ACCESS,
                  SERVICE_KERNEL_DRIVER,
                  SERVICE_AUTO_START,
                  SERVICE_ERROR_NORMAL,
                  DriverPath.c_str(),
                  DRIVER_GROUP.c_str(),
                  NULL, NULL, NULL, NULL);
      if (hService==NULL)
         dwStatus=GetLastError();
      else
         CloseServiceHandle(hService);

      // Disconnect from the SCM
      CloseServiceHandle(hSCMan);
   }
   else
      dwStatus=GetLastError();
      
   return dwStatus==0; // Success == 0
}

//---------------------------------------------------------------------------
// CancelButtonClick()
//    Quit the installer
//---------------------------------------------------------------------------
void __fastcall TMain_Win::CancelButtonClick(TObject *Sender)
{
   Close();
}

//---------------------------------------------------------------------------
// InstallButtonClick()
//    Install the drivers
//---------------------------------------------------------------------------
void __fastcall TMain_Win::InstallButtonClick(TObject *Sender)
{
   bool ErrorOccurred = false; // Assume error free until we find an error

   // Source paths for the files
   AnsiString DLLPathSrc = FProgPath + "\\DLPortIO.DLL";
   AnsiString DriverPathSrc = FProgPath + "\\DLPortIO.SYS";

   // Destination paths for the files
   AnsiString DLLPathDest = FDLLPath + "\\DLPortIO.DLL";
   AnsiString DriverPathDest = FDriverPath + "\\DLPortIO.SYS";

   // Disable buttons until we're done
   InstallButton->Enabled=false;
   CancelButton->Enabled=false;

   // Hide the fist panel, and show the second
   InstructionPanel->Visible=false;
   InstallPanel->Visible=true;

   // Copy the DriverLINX DLL
   InstallText->Caption="\nCopying 'dlportio.dll' into "+
                        FDLLPath.LowerCase()+"... ";
   InstallText->Refresh();
   if (CopyFile(DLLPathSrc.c_str(), DLLPathDest.c_str(), false))
      InstallText->Caption=InstallText->Caption+"done\n";
   else
   {
      InstallText->Caption=InstallText->Caption+"error!\n";
      ErrorOccurred=true;
   }

   if (!ErrorOccurred && FRunningWinNT)
   {
      // Copy the DriverLINX kernel mode driver
      InstallText->Caption=InstallText->Caption+"Copying 'dlportio.sys' into "+
                                                FDriverPath.LowerCase()+"... ";
      InstallText->Refresh();
      CreateDirectory(FDriverPath.c_str(), NULL);
      if (CopyFile(DriverPathSrc.c_str(), DriverPathDest.c_str(), false))
         InstallText->Caption=InstallText->Caption+"done\n";
      else
      {
         InstallText->Caption=InstallText->Caption+"error!\n";
         ErrorOccurred=true;
      }

      // Install the DriverLINX kernel mode driver into the system, if
      // no errors have occurred so far.
      if (!ErrorOccurred)
      {
         InstallText->Caption=InstallText->Caption+"Installing Windows NT driver... ";
         InstallText->Refresh();
         if (InstallDriver())
            InstallText->Caption=InstallText->Caption+"done\n";
         else
         {
            ErrorOccurred=true;
            InstallText->Caption=InstallText->Caption+"error!\n";
         }
      }
   }

   // Display a conclusion
   if (ErrorOccurred)
      // An installation error occurred
      InstallText->Caption=InstallText->Caption+
                            "\n\nAn error occurred; please make sure that the "
                            "relavent files (DLPortIO.DLL and DLPortIO.SYS) "
                            "are located in the same directory as this "
                            "program, and you are running this program under "
                            "an administrator account if using Windows NT.";
   else
      // Installation success: need to reboot the PC
      InstallText->Caption=InstallText->Caption+
                            "\n\nInstallation complete.\n"+
                            "\nYou need to reboot for the driver to take "
                            "effect.";

   // Re-enable buttons
   CancelButton->Caption="&Exit";
   CancelButton->Enabled=true;
   CancelButton->SetFocus();
}

