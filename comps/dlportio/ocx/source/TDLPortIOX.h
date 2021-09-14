//*** TDLPortIO: DriverLINX Port IO Driver wrapper component *****************
//**                                                                        **
//** File: TDLPortIO.h                                                      **
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

#ifndef __TDLPortIOX_H__
#define __TDLPortIOX_H__

//---------------------------------------------------------------------------
// DLL Import Types
//    Pointer to functions, to dynamically link into the DLL
//---------------------------------------------------------------------------

typedef unsigned char UCHAR;    // BYTE
typedef unsigned short USHORT;  // WORD
typedef unsigned long ULONG;    // DWORD

typedef UCHAR (__stdcall *TDlPortReadPortUchar)(ULONG Port);
typedef USHORT (__stdcall *TDlPortReadPortUshort)(ULONG Port);
typedef ULONG (__stdcall *TDlPortReadPortUlong)(ULONG Port);

typedef void (__stdcall *TDlPortWritePortUchar)(ULONG Port, UCHAR Value);
typedef void (__stdcall *TDlPortWritePortUshort)(ULONG Port, USHORT Value);
typedef void (__stdcall *TDlPortWritePortUlong)(ULONG Port, ULONG Value);

typedef void (__stdcall *TDlPortReadPortBufferUchar)(ULONG Port, UCHAR *Buffer, ULONG Count);
typedef void (__stdcall *TDlPortReadPortBufferUshort)(ULONG Port, USHORT *Buffer, ULONG Count);
typedef void (__stdcall *TDlPortReadPortBufferUlong)(ULONG Port, ULONG *Buffer, ULONG Count);

typedef void (__stdcall *TDlPortWritePortBufferUchar)(ULONG Port, UCHAR *Buffer, ULONG Count);
typedef void (__stdcall *TDlPortWritePortBufferUshort)(ULONG Port, USHORT *Buffer, ULONG Count);
typedef void (__stdcall *TDlPortWritePortBufferUlong)(ULONG Port, ULONG *Buffer, ULONG Count);


//---------------------------------------------------------------------------
// TDLPortIO class
//    This is supposed to be compatible with TVicPort
//---------------------------------------------------------------------------

class TDLPortIOX : public TCustomControl
{
private:
   bool FActiveHW;     // Is the DLL loaded?
   bool FHardAccess;   // Not used: for compatibility only
   bool FRunningWinNT; // True when we're running Windows NT

   HINSTANCE FDLLInst; // For use with DLL
   SC_HANDLE hSCMan;   // For use with WinNT Service Control Manager

   AnsiString FDriverPath; // Full path of WinNT driver
   AnsiString FDLLPath;    // Full path of DriverLINX DLL
   AnsiString FLastError;  // Last error which occurred in Open/CloseDriver()

   // Used for the Windows NT version only
   bool FDrvPrevInst;   // DriverLINX driver already installed?
   bool FDrvPrevStart;  // DriverLINX driver already running?

   // Connects and disconnects to the WinNT Service Control Manager
   bool ConnectSCM();
   void DisconnectSCM();

   // Installs, starts, stops and removes the WinNT kernel mode driver
   bool DriverInstall();
   bool DriverStart();
   bool DriverStop();
   bool DriverRemove();

   // Pointers to the functions within the DLL
   TDlPortReadPortUchar  DlReadByte;
   TDlPortReadPortUshort DlReadWord;
   TDlPortReadPortUlong  DlReadDWord;

   TDlPortWritePortUchar  DlWriteByte;
   TDlPortWritePortUshort DlWriteWord;
   TDlPortWritePortUlong  DlWriteDWord;

   TDlPortReadPortBufferUchar  DlReadBufferByte;
   TDlPortReadPortBufferUshort DlReadBufferWord;
   TDlPortReadPortBufferUlong  DlReadBufferDWord;

   TDlPortWritePortBufferUchar  DlWriteBufferByte;
   TDlPortWritePortBufferUshort DlWriteBufferWord;
   TDlPortWritePortBufferUlong  DlWriteBufferDWord;

protected:
   // Paints our little icon
   virtual void __fastcall Paint();

   // returns true if the DLL/Driver is loaded
   bool __fastcall IsLoaded()
      { return FActiveHW; }

   // Access any port as you like, similar to the old pascal way of doing things
   // This is here to remain compatible with many of the member functions
   __property BYTE Port[WORD Address]={read=ReadPort,write=WritePort};
   __property WORD PortW[WORD Address]={read=ReadPortW,write=WritePortW};
   __property DWORD PortL[WORD Address]={read=ReadPortL,write=WritePortL};

public:
   // Constructor
   __fastcall TDLPortIOX(TComponent *Owner);
   // Destructor
   __fastcall ~TDLPortIOX();

   // These open and close the DLL/Driver
   void __fastcall OpenDriver();
   void __fastcall CloseDriver();

   // Allows read/write array of bytes from single port.
   void __fastcall ReadPortFIFO(WORD PortAddr, WORD NumPorts, BYTE Buffer[])
     { DlReadBufferByte(PortAddr, Buffer, NumPorts); }
   void __fastcall WritePortFIFO(WORD PortAddr, WORD NumPorts, BYTE Buffer[])
     { DlWriteBufferByte(PortAddr, Buffer, NumPorts); }

   // Extended block read/write routines for WORD and DWORD
   void __fastcall ReadWPortFIFO(WORD PortAddr, WORD NumPorts, WORD Buffer[])
     { DlReadBufferWord(PortAddr, Buffer, NumPorts); }
   void __fastcall WriteWPortFIFO(WORD PortAddr, WORD NumPorts, WORD Buffer[])
     { DlWriteBufferWord(PortAddr, Buffer, NumPorts); }
   void __fastcall ReadLPortFIFO(WORD PortAddr, WORD NumPorts, DWORD Buffer[])
     { DlReadBufferDWord(PortAddr, Buffer, NumPorts); }
   void __fastcall WriteLPortFIFO(WORD PortAddr, WORD NumPorts, DWORD Buffer[])
     { DlWriteBufferDWord(PortAddr, Buffer, NumPorts); }

   // Access any port as you like
   BYTE __fastcall ReadPort(WORD Address)
     { return DlReadByte(Address); }
   void __fastcall WritePort(WORD Address, BYTE Data)
     { DlWriteByte(Address, Data); }
   WORD __fastcall ReadPortW(WORD Address)
     { return DlReadWord(Address); }
   void __fastcall WritePortW(WORD Address, WORD Data)
     { DlWriteWord(Address, Data); }
   DWORD __fastcall ReadPortL(WORD Address)
     { return DlReadDWord(Address); }
   void __fastcall WritePortL(WORD Address, DWORD Data)
     { DlWriteDWord(Address, Data); }

__published:
   // Sets the path (no ending \, nor any filename) of the DLPortIO.SYS file
   // Assumed to be <windows system directory>\DRIVERS if not specified
   // Has no effect if the DriverLINX driver is already installed
   __property AnsiString DriverPath={read=FDriverPath,write=FDriverPath};

   // Sets the path (no ending \, nor any filename) of the DLPortIO.DLL file
   // Assumed to be "" if not specified, meaning it will search the program
   // path, windows directory and computer's path for the DLL
   __property AnsiString DLLPath={read=FDLLPath,write=FDLLPath};

   // True when the DLL/Driver has been loaded successfully after OpenDriver()
   __property bool ActiveHW={read=FActiveHW};
   // This doesn't really do anything; provided for compatibility only
   __property bool HardAccess={read=FHardAccess,write=FHardAccess,default=true};

   // Returns the last error which occurred in Open/CloseDriver()
   __property AnsiString LastError={read=FLastError};
};


//---------------------------------------------------------------------------
// TDLPrinterPortIOX class
//    This is supposed to be compatible with TVicLPT
//---------------------------------------------------------------------------

class TDLPrinterPortIOX : public TDLPortIOX
{
private:
   // Masks
   static const BYTE BIT0 = 0x01;
   static const BYTE BIT1 = 0x02;
   static const BYTE BIT2 = 0x04;
   static const BYTE BIT3 = 0x08;
   static const BYTE BIT4 = 0x10;
   static const BYTE BIT5 = 0x20;
   static const BYTE BIT6 = 0x40;
   static const BYTE BIT7 = 0x80;

   // Printer Port pin numbers
   static const ACK_PIN       = 10;
   static const BUSY_PIN      = 11;
   static const PAPEREND_PIN  = 12;
   static const SELECTOUT_PIN = 13;
   static const ERROR_PIN     = 15;
   static const STROBE_PIN    = 1;
   static const AUTOFD_PIN    = 14;
   static const INIT_PIN      = 16;
   static const SELECTIN_PIN  = 17;

public:
   // Maximum number of printer ports
   // that would be installed on a system
   static const MAX_LPT_PORTS = 8;

private:
   BYTE FLPTNumber;    // Current number of the printer port, default=1
   WORD FLPTBase;      // The address of the current printer port (faster)

   int  FLPTCount;     // Number of LPT ports on the system

   // List of port addresses installed on the system
   WORD FLPTAddress[MAX_LPT_PORTS+1];

   // Detects the printer ports using the registry
   void __fastcall DetectPorts();
   void __fastcall DetectPorts9x(); // Win9x version
   void __fastcall DetectPortsNT(); // WinNT version

protected:
   // Paints our little icon
   virtual void __fastcall Paint(void);

   BYTE __fastcall GetLPTNumPorts() { return FLPTCount; }
   WORD __fastcall GetLPTBasePort() { return FLPTBase; }
   void __fastcall SetLPTNumber(BYTE Number);

   bool __fastcall GetLPTAckwl()    { return GetPin(ACK_PIN); }
   bool __fastcall GetLPTBusy()     { return GetPin(BUSY_PIN); }
   bool __fastcall GetLPTPaperEnd() { return GetPin(PAPEREND_PIN); }
   bool __fastcall GetLPTSlct()     { return GetPin(SELECTOUT_PIN); }
   bool __fastcall GetLPTError()    { return GetPin(ERROR_PIN); }

public:
   // Constructor
   __fastcall TDLPrinterPortIOX(TComponent *Owner);

   // Sends STROBE signal to the printer
   void __fastcall LPTStrobe();
   // Sends AUTOFD (auto line feed) signal to the printer
   void __fastcall LPTAutofd(bool Flag);
   // Resets printer by sending INIT signal
   void __fastcall LPTInit();
   // Sends SLCTIN signal to the printer
   void __fastcall LPTSlctIn();
   // Sends a character to the printer.
   // Returns true on success. Repeat as neccessary.
   bool __fastcall LPTPrintChar(char Ch);

   // Index valid is in the range 1-25 only (other values return false)
   // Reading the pin returns true when it is 5V, or false when it at 0V.
   // Writing true sets the pin to 5V, or 0V when false.
   bool __fastcall GetPin(BYTE Index);
   void __fastcall SetPin(BYTE Index, bool State);

   // Returns ACKWL state from the printer
   __property bool LPTAckwl={read=GetLPTAckwl};
   // Returns BUSY state from the printer
   __property bool LPTBusy={read=GetLPTBusy};
   // Returns PAPER END state from the printer
   __property bool LPTPaperEnd={read=GetLPTPaperEnd};
   // Returns SLCT state from the printer
   __property bool LPTSlct={read=GetLPTSlct};
   // Returns ERROR state from the printer
   __property bool LPTError={read=GetLPTError};

__published:
   // Shows how many LPT ports are installed on your PC.
   __property BYTE LPTNumPorts={read=GetLPTNumPorts};
   // Selects the LPT port to use for all LPT operations
   __property BYTE LPTNumber={read=FLPTNumber,write=SetLPTNumber,default=1};
   // Returns a base address of the current LPT port.
   __property WORD LPTBasePort={read=GetLPTBasePort};
};


//---------------------------------------------------------------------------
// Inline Functions
//---------------------------------------------------------------------------


//---------------------------------------------------------------------------
// LPTStrobe()
//    Sends STROBE signal to the printer
//---------------------------------------------------------------------------
inline
void __fastcall TDLPrinterPortIOX::LPTStrobe()
{
   // Set to strobe pin to 0V
   SetPin(STROBE_PIN, false);
   // Wait one millisecond
   Sleep(1);
   // Set strobe pin back to 5V
   SetPin(STROBE_PIN, true);
}


//---------------------------------------------------------------------------
// LPTAutofd()
//    Sends AUTOFD (auto line feed) signal to the printer
//---------------------------------------------------------------------------
inline
void __fastcall TDLPrinterPortIOX::LPTAutofd(bool Flag)
{
   // Set the auto line feed pin
   SetPin(AUTOFD_PIN, Flag);
}


//---------------------------------------------------------------------------
// LPTInit()
//    Resets printer by sending INIT signal
//---------------------------------------------------------------------------
inline
void __fastcall TDLPrinterPortIOX::LPTInit()
{
   // Set pin to a 0V
   SetPin(INIT_PIN, false);
   // Wait 1 ms
   Sleep(1);
   // Set pin back to 5V
   SetPin(INIT_PIN, true);
}


//---------------------------------------------------------------------------
// LPTSlctIn()
//    Sends SLCTIN signal to the printer
//---------------------------------------------------------------------------
inline
void __fastcall TDLPrinterPortIOX::LPTSlctIn()
{
   // Send the signal (0V)
   SetPin(SELECTIN_PIN, false);
}


#endif
