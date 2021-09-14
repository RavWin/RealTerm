// ************************************************************************ //
// WARNING                                                                  //
// -------                                                                  //
// The types declared in this file were generated from data read from a     //
// Type Library. If this type library is explicitly or indirectly (via      //
// another type library referring to this type library) re-imported, or the //
// 'Refresh' command of the Type Library Editor activated while editing the //
// Type Library, the contents of this file will be regenerated and all      //
// manual modifications will be lost.                                       //
// ************************************************************************ //

/* File generated on 10/07/99 4:39:08  from Type Library described below. */

// ************************************************************************ //
// Type Lib: C:\Source\TDLPortIO\ocx\source\DLPrinterPortIOXControl.tlb
// IID\LCID: {0CF882A0-36E5-11D3-AEA1-02608CA7A319}\0
// Helpfile: C:\Source\TDLPortIO\ocx\source\DLPrinterPortIOXControl.tlb
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\SYSTEM\STDOLE2.TLB)
//   (2) v4.0 StdVCL, (C:\WINDOWS\SYSTEM\STDVCL40.DLL)
// ************************************************************************ //

#include <vcl.h>
#pragma hdrstop
#if defined(USING_ATLVCL)
#include <atl\atlvcl.h>
#endif

#include "DLPrinterPortIOXControl_TLB.h"

#if !defined(__PRAGMA_PACKAGE_SMART_INIT)
#define      __PRAGMA_PACKAGE_SMART_INIT
#pragma package(smart_init)
#endif

namespace Dlprinterportioxcontrol_tlb
{


// *********************************************************************//
// GUIDS declared in the TypeLibrary                                    //
// *********************************************************************//
extern "C" const GUID LIBID_DLPrinterPortIOXControl = {0x0CF882A0, 0x36E5, 0x11D3,{ 0xAE, 0xA1, 0x02, 0x60, 0x8C, 0xA7, 0xA3, 0x19} };
extern "C" const GUID IID_IDLPrinterPortIOX = {0x0CF882A1, 0x36E5, 0x11D3,{ 0xAE, 0xA1, 0x02, 0x60, 0x8C, 0xA7, 0xA3, 0x19} };
extern "C" const GUID DIID_IDLPrinterPortIOXEvents = {0x0CF882A3, 0x36E5, 0x11D3,{ 0xAE, 0xA1, 0x02, 0x60, 0x8C, 0xA7, 0xA3, 0x19} };
extern "C" const GUID CLSID_DLPrinterPortIOX = {0x0CF882A5, 0x36E5, 0x11D3,{ 0xAE, 0xA1, 0x02, 0x60, 0x8C, 0xA7, 0xA3, 0x19} };


// *********************************************************************//
// OCX PROXY CLASS IMPLEMENTATION
// (The following variables/methods implement the class TDLPrinterPortIOXProxy which
// allows "DLPrinterPortIOX Control" to be hosted in CBuilder IDE/apps).
// *********************************************************************//
TControlData TDLPrinterPortIOXProxy::CControlData =
{
  // GUID of Primary and Event Interfaces of Control
  {0x0CF882A5, 0x36E5, 0x11D3,{ 0xAE, 0xA1, 0x02, 0x60, 0x8C, 0xA7, 0xA3, 0x19} },
  {0x0CF882A3, 0x36E5, 0x11D3,{ 0xAE, 0xA1, 0x02, 0x60, 0x8C, 0xA7, 0xA3, 0x19} },

  // Count of Events and array of their DISPIDs
  0, NULL,

  // Pointer to runtime License string
  NULL,

  // Flags for OnChanged PropertyNotification
  0x00000008,
  300,// (IDE Version)

  // Count of Font Prop and array of their DISPIDs
  0, (Activex::TDispIDList*)NULL,

  // Count of Pict Prop and array of their DISPIDs
  0, (Activex::TDispIDList*)NULL,
  0, // Reserved
  0, // Instance count (used internally)
  0, // List of Enum descriptions (internal)
};

static inline void ValidCtrCheck(TDLPrinterPortIOXProxy *)
{
   delete new TDLPrinterPortIOXProxy((TComponent*)(0));
};

void __fastcall TDLPrinterPortIOXProxy::InitControlData(void)
{
  ControlData = &CControlData;
};

void __fastcall TDLPrinterPortIOXProxy::CreateControl(void)
{
  if (!m_OCXIntf)
  {
    _ASSERTE(DefaultDispatch);
    DefaultDispatch->QueryInterface(IID_IDLPrinterPortIOX, (LPVOID*)&m_OCXIntf);
  }
};

TCOMIDLPrinterPortIOX __fastcall TDLPrinterPortIOXProxy::GetControlInterface(void)
{
  CreateControl();
  return m_OCXIntf;
};

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::LPTStrobe(void)
{
  CreateControl();
  OLECHECK(m_OCXIntf->LPTStrobe());
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::LPTAutofd(VARIANT_BOOL Flag/*[in]*/)
{
  CreateControl();
  OLECHECK(m_OCXIntf->LPTAutofd(Flag/*[in]*/));
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::LPTInit(void)
{
  CreateControl();
  OLECHECK(m_OCXIntf->LPTInit());
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::LPTSlctIn(void)
{
  CreateControl();
  OLECHECK(m_OCXIntf->LPTSlctIn());
}

VARIANT_BOOL __fastcall TDLPrinterPortIOXProxy::LPTPrintChar(short Ch/*[in]*/)
{
  CreateControl();
  VARIANT_BOOL _retval;
  OLECHECK(m_OCXIntf->LPTPrintChar(Ch/*[in]*/, &_retval));
  return _retval;
}

VARIANT_BOOL __fastcall TDLPrinterPortIOXProxy::GetPin(unsigned char Index/*[in]*/)
{
  CreateControl();
  VARIANT_BOOL _retval;
  OLECHECK(m_OCXIntf->GetPin(Index/*[in]*/, &_retval));
  return _retval;
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::SetPin(unsigned char Index/*[in]*/, 
                                                          VARIANT_BOOL State/*[in]*/)
{
  CreateControl();
  OLECHECK(m_OCXIntf->SetPin(Index/*[in]*/, State/*[in]*/));
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::OpenDriver(void)
{
  CreateControl();
  OLECHECK(m_OCXIntf->OpenDriver());
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::CloseDriver(void)
{
  CreateControl();
  OLECHECK(m_OCXIntf->CloseDriver());
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::ReadPortFIFO(short PortAddr/*[in]*/, 
                                                                short NumPorts/*[in]*/, 
                                                                unsigned char Buffer/*[in]*/)
{
  CreateControl();
  OLECHECK(m_OCXIntf->ReadPortFIFO(PortAddr/*[in]*/, NumPorts/*[in]*/, Buffer/*[in]*/));
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::WritePortFIFO(short PortAddr/*[in]*/, 
                                                                 short NumPorts/*[in]*/, 
                                                                 unsigned char Buffer/*[in]*/)
{
  CreateControl();
  OLECHECK(m_OCXIntf->WritePortFIFO(PortAddr/*[in]*/, NumPorts/*[in]*/, Buffer/*[in]*/));
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::ReadWPortFIFO(short PortAddr/*[in]*/, 
                                                                 short NumPorts/*[in]*/, 
                                                                 short Buffer/*[in]*/)
{
  CreateControl();
  OLECHECK(m_OCXIntf->ReadWPortFIFO(PortAddr/*[in]*/, NumPorts/*[in]*/, Buffer/*[in]*/));
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::WriteWPortFIFO(short PortAddr/*[in]*/, 
                                                                  short NumPorts/*[in]*/, 
                                                                  short Buffer/*[in]*/)
{
  CreateControl();
  OLECHECK(m_OCXIntf->WriteWPortFIFO(PortAddr/*[in]*/, NumPorts/*[in]*/, Buffer/*[in]*/));
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::ReadLPortFIFO(short PortAddr/*[in]*/, 
                                                                 short NumPorts/*[in]*/, 
                                                                 long Buffer/*[in]*/)
{
  CreateControl();
  OLECHECK(m_OCXIntf->ReadLPortFIFO(PortAddr/*[in]*/, NumPorts/*[in]*/, Buffer/*[in]*/));
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::WriteLPortFIFO(short PortAddr/*[in]*/, 
                                                                  short NumPorts/*[in]*/, 
                                                                  long Buffer/*[in]*/)
{
  CreateControl();
  OLECHECK(m_OCXIntf->WriteLPortFIFO(PortAddr/*[in]*/, NumPorts/*[in]*/, Buffer/*[in]*/));
}

unsigned char __fastcall TDLPrinterPortIOXProxy::ReadPort(short Address/*[in]*/)
{
  CreateControl();
  unsigned char _retval;
  OLECHECK(m_OCXIntf->ReadPort(Address/*[in]*/, &_retval));
  return _retval;
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::WritePort(short Address/*[in]*/, 
                                                             unsigned char Data/*[in]*/)
{
  CreateControl();
  OLECHECK(m_OCXIntf->WritePort(Address/*[in]*/, Data/*[in]*/));
}

short __fastcall TDLPrinterPortIOXProxy::ReadPortW(short Address/*[in]*/)
{
  CreateControl();
  short _retval;
  OLECHECK(m_OCXIntf->ReadPortW(Address/*[in]*/, &_retval));
  return _retval;
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::WritePortW(short Address/*[in]*/, 
                                                              short Data/*[in]*/)
{
  CreateControl();
  OLECHECK(m_OCXIntf->WritePortW(Address/*[in]*/, Data/*[in]*/));
}

long __fastcall TDLPrinterPortIOXProxy::ReadPortL(short Address/*[in]*/)
{
  CreateControl();
  long _retval;
  OLECHECK(m_OCXIntf->ReadPortL(Address/*[in]*/, &_retval));
  return _retval;
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::WritePortL(short Address/*[in]*/, 
                                                              long Data/*[in]*/)
{
  CreateControl();
  OLECHECK(m_OCXIntf->WritePortL(Address/*[in]*/, Data/*[in]*/));
}

VARIANT_BOOL __fastcall TDLPrinterPortIOXProxy::ClassNameIs(BSTR string/*[in]*/)
{
  CreateControl();
  VARIANT_BOOL _retval;
  OLECHECK(m_OCXIntf->ClassNameIs(string/*[in]*/, &_retval));
  return _retval;
}

void/*HRESULT*/ __fastcall TDLPrinterPortIOXProxy::AboutBox(void)
{
  CreateControl();
  OLECHECK(m_OCXIntf->AboutBox());
}



// *********************************************************************//
// The Register function is invoked by the IDE when this module is 
// installed in a Package. It provides the list of Components (including
// OCXes) implemented by this module. The following implementation
// informs the IDE of the OCX proxy classes implemented here.
// *********************************************************************//
void __fastcall PACKAGE Register()
{
  // [1]
  TComponentClass classes[] = {
                              __classid(TDLPrinterPortIOXProxy)
                             };
  RegisterComponents("ActiveX", classes,
                     sizeof(classes)/sizeof(classes[0])-1);
}
};     // namespace Dlprinterportioxcontrol_tlb
