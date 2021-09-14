//*** TDLPortIO: DriverLINX Port IO Driver wrapper component DEMO ************
//**                                                                        **
//** File: Main.cpp                                                         **
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

#include "Main.h"

#pragma package(smart_init)
#pragma link "TDLPortIO"
#pragma resource "*.dfm"

TMain_Win *Main_Win;

//---------------------------------------------------------------------------
// TMain_Win()
//---------------------------------------------------------------------------
__fastcall TMain_Win::TMain_Win(TComponent* Owner) : TForm(Owner)
{
   FBaseMode=bHex;   // Hex mode as default
   FDataType=dtByte; // Byte mode as default

   // Default port
   PortEdit->Text="0x378"; // LPT1:
   DataEdit->Text="0x00";

   // Driver is in the same directory as the demo.exe file!
   DLPortIO->DriverPath=ExtractFileDir(ParamStr(0));
   // Open the DriverLINX driver
   DLPortIO->OpenDriver();
   if (!DLPortIO->ActiveHW)
   {
      MessageDlg("Could not open the DriverLINX driver.",
                 mtError, TMsgDlgButtons() << mbOK, 0);
      PortGroup->Enabled=false;
      BaseGroup->Enabled=false;
      TypeGroup->Enabled=false;
   }
}


//---------------------------------------------------------------------------
// Base10RadioClick()
//    Change the base of the edit boxes to decimal
//---------------------------------------------------------------------------
void __fastcall TMain_Win::Base10RadioClick(TObject *Sender)
{
   if (FBaseMode!=bDecimal)
   {
      // Now in decimal mode
      FBaseMode=bDecimal;
      try {
         PortEdit->Text=IntToStr(StrToInt(PortEdit->Text));
      } catch (...) {
         PortEdit->Text="0";
      }
      try {
         DataEdit->Text=IntToStr(StrToInt(DataEdit->Text));
      } catch (...) {
         DataEdit->Text="0";
      }
   }
}


//---------------------------------------------------------------------------
// Base16RadioClick()
//    Change the base of the edit boxes to hex
//---------------------------------------------------------------------------
void __fastcall TMain_Win::Base16RadioClick(TObject *Sender)
{
   if (FBaseMode!=bHex)
   {
      // Now in hex mode
      FBaseMode=bHex;
      try {
         PortEdit->Text="0x"+IntToHex(StrToInt(PortEdit->Text),0);
      } catch (...) {
         DataEdit->Text="0x0000";
      }
      try {
         DataEdit->Text="0x"+IntToHex(StrToInt(DataEdit->Text),0);
      } catch (...) {
         DataEdit->Text="0x00";
      }
   }
}


//---------------------------------------------------------------------------
// QuitButtonClick()
//    Quit the demo
//---------------------------------------------------------------------------
void __fastcall TMain_Win::QuitButtonClick(TObject *Sender)
{
   Close();
}


//---------------------------------------------------------------------------
// ReadButtonClick()
//    Reads a byte into the DataEdit box
//---------------------------------------------------------------------------
void __fastcall TMain_Win::ReadButtonClick(TObject *Sender)
{
   WORD DataPort;  // Port to read data from
   DWORD DataRead; // Data read from port

   // Get the data port address
   try {
      DataPort=(WORD)StrToInt(PortEdit->Text);
   } catch (...) {
      MessageDlg("You have specified an invalid port.\nNo action performed.",
                 mtError, TMsgDlgButtons() << mbOK, 0);
      return;
   }

   // Read the data
   switch (FDataType)
   {
      case dtByte:  DataRead=DLPortIO->Port[DataPort];  break;
      case dtWord:  DataRead=DLPortIO->PortW[DataPort]; break;
      case dtDWord: DataRead=DLPortIO->PortL[DataPort]; break;
   }

   if (FBaseMode==bDecimal)
      DataEdit->Text=IntToStr(DataRead);
   else
      DataEdit->Text="0x"+IntToHex(DataRead, 0);
}


//---------------------------------------------------------------------------
// WriteButtonClick()
//    Writes a byte of data from DataEdit to PortEdit
//---------------------------------------------------------------------------
void __fastcall TMain_Win::WriteButtonClick(TObject *Sender)
{
   WORD DataPort;   // Port to read data from
   DWORD DataWrite; // Data to write to port

   // Get the data port address
   try {
      DataPort=(WORD)StrToInt(PortEdit->Text);
   } catch (...) {
      MessageDlg("You have specified an invalid port.\nNo action performed.",
                 mtError, TMsgDlgButtons() << mbOK, 0);
      return;
   }

   // Get the data to write
   try {
      DataWrite=(DWORD)StrToInt(DataEdit->Text);
   } catch (...) {
      MessageDlg("You have specified an invalid port.\nNo action performed.",
                 mtError, TMsgDlgButtons() << mbOK, 0);
      return;
   }

   // Write the data
   switch (FDataType)
   {
      case dtByte:  DLPortIO->Port[DataPort]=(BYTE)(DataWrite&0xFF);    break;
      case dtWord:  DLPortIO->PortW[DataPort]=(WORD)(DataWrite&0xFFFF); break;
      case dtDWord: DLPortIO->PortL[DataPort]=DataWrite;                break;
   }
}


//---------------------------------------------------------------------------
// ByteRadioClick()
//    Set for Byte writing
//---------------------------------------------------------------------------
void __fastcall TMain_Win::ByteRadioClick(TObject *Sender)
{
   FDataType=dtByte;
}


//---------------------------------------------------------------------------
// WordRadioClick()
//    Set for Word writing
//---------------------------------------------------------------------------
void __fastcall TMain_Win::WordRadioClick(TObject *Sender)
{
   FDataType=dtWord;
}


//---------------------------------------------------------------------------
// DWordRadioClick()
//    Set for Double Word writing
//---------------------------------------------------------------------------
void __fastcall TMain_Win::DWordRadioClick(TObject *Sender)
{
   FDataType=dtDWord;
}


//---------------------------------------------------------------------------
// AboutButtonClick()
//    Shows the about dialog box
//---------------------------------------------------------------------------
void __fastcall TMain_Win::AboutButtonClick(TObject *Sender)
{
   MessageDlg(
      "DriverLINX driver wrapper component Demo\n"
      "Copyright (c) 1999 John Pappas (DiskDude). All rights reserved.\n\n"
      "See http://diskdude.cjb.net/ for the latest version.",
      mtInformation,
      TMsgDlgButtons() << mbOK,
      0);
}

