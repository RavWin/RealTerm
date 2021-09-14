//*** TDLPortIO: DriverLINX Port IO Driver wrapper component *****************
//**                                                                        **
//** File: Main.h                                                           **
//**                                                                        **
//** Copyright (c) 1999 John Pappas (DiskDude). All rights reserved.        **
//**     This software is FreeWare.                                         **
//**                                                                        **
//**     Please notify me if you make any changes to this file.             **
//**     Email: diskdude@poboxes.com                                        **
//**                                                                        **
//*** http://diskdude.cjb.net/ ***********************************************

#ifndef __Main_H__
#define __Main_H__

#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ExtCtrls.hpp>

//---------------------------------------------------------------------------
// TMain_Win class
//---------------------------------------------------------------------------
class TMain_Win : public TForm
{
__published:	// IDE-managed Components
    TImage *InstallImage;
    TBevel *Bevel1;
    TButton *CancelButton;
    TButton *InstallButton;
    TPanel *InstructionPanel;
    TLabel *Label1;
    TLabel *Label2;
    TLabel *Label3;
    TLabel *Label4;
    TPanel *InstallPanel;
    TLabel *InstallText;
    void __fastcall CancelButtonClick(TObject *Sender);
    void __fastcall InstallButtonClick(TObject *Sender);
private:	// User declarations
    bool FRunningWinNT;     // True when we're running Windows NT

    AnsiString FDLLPath;    // Windows System directory
    AnsiString FDriverPath; // Windows System\Drivers directory

    AnsiString FProgPath;   // Directory of this program

    // Installs the DriverLINX driver into the registry
    bool __fastcall InstallDriver();

public:		// User declarations
    __fastcall TMain_Win(TComponent* Owner);
};

//---------------------------------------------------------------------------
extern PACKAGE TMain_Win *Main_Win;
//---------------------------------------------------------------------------

#endif
