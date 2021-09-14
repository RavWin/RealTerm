//*** TDLPortIO: DriverLINX Port IO Driver wrapper component DEMO ************
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
#include "TDLPortIO.h"

//---------------------------------------------------------------------------
// Types
//---------------------------------------------------------------------------

typedef enum {bDecimal, bHex} TBase;
typedef enum {dtByte, dtWord, dtDWord} TDataType;


//---------------------------------------------------------------------------
// TMain_Win class
//---------------------------------------------------------------------------

class TMain_Win : public TForm
{
__published:   // IDE-managed Components
    TDLPortIO *DLPortIO;
    TButton *QuitButton;
    TGroupBox *PortGroup;
    TLabel *Label1;
    TLabel *Label2;
    TEdit *PortEdit;
    TButton *ReadButton;
    TButton *WriteButton;
    TEdit *DataEdit;
    TGroupBox *BaseGroup;
    TRadioButton *Base10Radio;
    TRadioButton *Base16Radio;
    TGroupBox *TypeGroup;
    TRadioButton *ByteRadio;
    TRadioButton *WordRadio;
    TRadioButton *DWordRadio;
    TButton *AboutButton;
    void __fastcall Base10RadioClick(TObject *Sender);
    void __fastcall Base16RadioClick(TObject *Sender);
    void __fastcall QuitButtonClick(TObject *Sender);
    void __fastcall ReadButtonClick(TObject *Sender);
    void __fastcall WriteButtonClick(TObject *Sender);
    void __fastcall ByteRadioClick(TObject *Sender);
    void __fastcall WordRadioClick(TObject *Sender);
    void __fastcall DWordRadioClick(TObject *Sender);
    void __fastcall AboutButtonClick(TObject *Sender);
private: // User declarations
    TBase     FBaseMode;
    TDataType FDataType;

public:     // User declarations
    __fastcall TMain_Win(TComponent* Owner);
};


//---------------------------------------------------------------------------
extern PACKAGE TMain_Win *Main_Win;
//---------------------------------------------------------------------------

#endif

