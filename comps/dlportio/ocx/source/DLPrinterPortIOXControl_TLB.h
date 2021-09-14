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
#ifndef   __DLPrinterPortIOXControl_TLB_h__
#define   __DLPrinterPortIOXControl_TLB_h__

#pragma option push -b


#include <sysdefs.h>
#include <utilcls.h>
#include <stdvcl.hpp>
#include <ocxproxy.h>

namespace Dlprinterportioxcontrol_tlb
{

// *********************************************************************//
// HelpString: DLPrinterPortIOXControl1 Library
// Version:    1.0
// *********************************************************************//


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:      //
//   Type Libraries     : LIBID_xxxx                                    //
//   CoClasses          : CLSID_xxxx                                    //
//   DISPInterfaces     : DIID_xxxx                                     //
//   Non-DISP interfaces: IID_xxxx                                      //
// *********************************************************************//
DEFINE_GUID(LIBID_DLPrinterPortIOXControl, 0x0CF882A0, 0x36E5, 0x11D3, 0xAE, 0xA1, 0x02, 0x60, 0x8C, 0xA7, 0xA3, 0x19);
DEFINE_GUID(IID_IDLPrinterPortIOX, 0x0CF882A1, 0x36E5, 0x11D3, 0xAE, 0xA1, 0x02, 0x60, 0x8C, 0xA7, 0xA3, 0x19);
DEFINE_GUID(DIID_IDLPrinterPortIOXEvents, 0x0CF882A3, 0x36E5, 0x11D3, 0xAE, 0xA1, 0x02, 0x60, 0x8C, 0xA7, 0xA3, 0x19);
DEFINE_GUID(CLSID_DLPrinterPortIOX, 0x0CF882A5, 0x36E5, 0x11D3, 0xAE, 0xA1, 0x02, 0x60, 0x8C, 0xA7, 0xA3, 0x19);

// *********************************************************************//
// Forward declaration of interfaces defined in Type Library            //
// *********************************************************************//
interface IDLPrinterPortIOX;
interface IDLPrinterPortIOXEvents;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                     //
// (NOTE: Here we map each CoClass to it's Default Interface            //
// *********************************************************************//
typedef IDLPrinterPortIOX DLPrinterPortIOX;
// *********************************************************************//
// Interface: IDLPrinterPortIOX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0CF882A1-36E5-11D3-AEA1-02608CA7A319}
// *********************************************************************//
interface IDLPrinterPortIOX : public IDispatch
{
public:
  virtual HRESULT STDMETHODCALLTYPE LPTStrobe(void) = 0; // [1]
  virtual HRESULT STDMETHODCALLTYPE LPTAutofd(VARIANT_BOOL Flag/*[in]*/) = 0; // [2]
  virtual HRESULT STDMETHODCALLTYPE LPTInit(void) = 0; // [3]
  virtual HRESULT STDMETHODCALLTYPE LPTSlctIn(void) = 0; // [4]
  virtual HRESULT STDMETHODCALLTYPE LPTPrintChar(short Ch/*[in]*/, 
                                                 VARIANT_BOOL* Value/*[out,retval]*/) = 0; // [5]
  virtual HRESULT STDMETHODCALLTYPE GetPin(unsigned char Index/*[in]*/, 
                                           VARIANT_BOOL* Value/*[out,retval]*/) = 0; // [6]
  virtual HRESULT STDMETHODCALLTYPE SetPin(unsigned char Index/*[in]*/, VARIANT_BOOL State/*[in]*/) = 0; // [7]
  virtual HRESULT STDMETHODCALLTYPE get_LPTAckwl(VARIANT_BOOL* Value/*[out,retval]*/) = 0; // [8]
  virtual HRESULT STDMETHODCALLTYPE get_LPTBusy(VARIANT_BOOL* Value/*[out,retval]*/) = 0; // [9]
  virtual HRESULT STDMETHODCALLTYPE get_LPTPaperEnd(VARIANT_BOOL* Value/*[out,retval]*/) = 0; // [10]
  virtual HRESULT STDMETHODCALLTYPE get_LPTSlct(VARIANT_BOOL* Value/*[out,retval]*/) = 0; // [11]
  virtual HRESULT STDMETHODCALLTYPE get_LPTError(VARIANT_BOOL* Value/*[out,retval]*/) = 0; // [12]
  virtual HRESULT STDMETHODCALLTYPE get_LPTNumPorts(unsigned char* Value/*[out,retval]*/) = 0; // [13]
  virtual HRESULT STDMETHODCALLTYPE get_LPTNumber(unsigned char* Value/*[out,retval]*/) = 0; // [14]
  virtual HRESULT STDMETHODCALLTYPE set_LPTNumber(unsigned char Value/*[in]*/) = 0; // [14]
  virtual HRESULT STDMETHODCALLTYPE get_LPTBasePort(short* Value/*[out,retval]*/) = 0; // [15]
  virtual HRESULT STDMETHODCALLTYPE OpenDriver(void) = 0; // [16]
  virtual HRESULT STDMETHODCALLTYPE CloseDriver(void) = 0; // [17]
  virtual HRESULT STDMETHODCALLTYPE ReadPortFIFO(short PortAddr/*[in]*/, short NumPorts/*[in]*/, 
                                                 unsigned char Buffer/*[in]*/) = 0; // [18]
  virtual HRESULT STDMETHODCALLTYPE WritePortFIFO(short PortAddr/*[in]*/, short NumPorts/*[in]*/, 
                                                  unsigned char Buffer/*[in]*/) = 0; // [19]
  virtual HRESULT STDMETHODCALLTYPE ReadWPortFIFO(short PortAddr/*[in]*/, short NumPorts/*[in]*/, 
                                                  short Buffer/*[in]*/) = 0; // [20]
  virtual HRESULT STDMETHODCALLTYPE WriteWPortFIFO(short PortAddr/*[in]*/, short NumPorts/*[in]*/, 
                                                   short Buffer/*[in]*/) = 0; // [21]
  virtual HRESULT STDMETHODCALLTYPE ReadLPortFIFO(short PortAddr/*[in]*/, short NumPorts/*[in]*/, 
                                                  long Buffer/*[in]*/) = 0; // [22]
  virtual HRESULT STDMETHODCALLTYPE WriteLPortFIFO(short PortAddr/*[in]*/, short NumPorts/*[in]*/, 
                                                   long Buffer/*[in]*/) = 0; // [23]
  virtual HRESULT STDMETHODCALLTYPE ReadPort(short Address/*[in]*/, 
                                             unsigned char* Value/*[out,retval]*/) = 0; // [24]
  virtual HRESULT STDMETHODCALLTYPE WritePort(short Address/*[in]*/, unsigned char Data/*[in]*/) = 0; // [25]
  virtual HRESULT STDMETHODCALLTYPE ReadPortW(short Address/*[in]*/, short* Value/*[out,retval]*/) = 0; // [26]
  virtual HRESULT STDMETHODCALLTYPE WritePortW(short Address/*[in]*/, short Data/*[in]*/) = 0; // [27]
  virtual HRESULT STDMETHODCALLTYPE ReadPortL(short Address/*[in]*/, long* Value/*[out,retval]*/) = 0; // [28]
  virtual HRESULT STDMETHODCALLTYPE WritePortL(short Address/*[in]*/, long Data/*[in]*/) = 0; // [29]
  virtual HRESULT STDMETHODCALLTYPE get_DriverPath(BSTR* Value/*[out,retval]*/) = 0; // [30]
  virtual HRESULT STDMETHODCALLTYPE set_DriverPath(BSTR Value/*[in]*/) = 0; // [30]
  virtual HRESULT STDMETHODCALLTYPE get_DLLPath(BSTR* Value/*[out,retval]*/) = 0; // [31]
  virtual HRESULT STDMETHODCALLTYPE set_DLLPath(BSTR Value/*[in]*/) = 0; // [31]
  virtual HRESULT STDMETHODCALLTYPE get_ActiveHW(VARIANT_BOOL* Value/*[out,retval]*/) = 0; // [32]
  virtual HRESULT STDMETHODCALLTYPE get_HardAccess(VARIANT_BOOL* Value/*[out,retval]*/) = 0; // [33]
  virtual HRESULT STDMETHODCALLTYPE set_HardAccess(VARIANT_BOOL Value/*[in]*/) = 0; // [33]
  virtual HRESULT STDMETHODCALLTYPE get_LastError(BSTR* Value/*[out,retval]*/) = 0; // [34]
  virtual HRESULT STDMETHODCALLTYPE get_Visible(VARIANT_BOOL* Value/*[out,retval]*/) = 0; // [37]
  virtual HRESULT STDMETHODCALLTYPE set_Visible(VARIANT_BOOL Value/*[in]*/) = 0; // [37]
  virtual HRESULT STDMETHODCALLTYPE get_Enabled(VARIANT_BOOL* Value/*[out,retval]*/) = 0; // [-514]
  virtual HRESULT STDMETHODCALLTYPE set_Enabled(VARIANT_BOOL Value/*[in]*/) = 0; // [-514]
  virtual HRESULT STDMETHODCALLTYPE get_Cursor(short* Value/*[out,retval]*/) = 0; // [38]
  virtual HRESULT STDMETHODCALLTYPE set_Cursor(short Value/*[in]*/) = 0; // [38]
  virtual HRESULT STDMETHODCALLTYPE ClassNameIs(BSTR string/*[in]*/, 
                                                VARIANT_BOOL* Value/*[out,retval]*/) = 0; // [40]
  virtual HRESULT STDMETHODCALLTYPE AboutBox(void) = 0; // [-552]
};

// *********************************************************************//
// SmartIntf: TCOMIDLPrinterPortIOX
// Interface: IDLPrinterPortIOX
// *********************************************************************//
class TCOMIDLPrinterPortIOX : public TComInterface<IDLPrinterPortIOX>
{
public:
  TCOMIDLPrinterPortIOX() {}
  TCOMIDLPrinterPortIOX(IDLPrinterPortIOX *intf, bool addRef = false) : TComInterface<IDLPrinterPortIOX>(intf, addRef) {}
};

// *********************************************************************//
// DispIntf:  IDLPrinterPortIOX
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {0CF882A1-36E5-11D3-AEA1-02608CA7A319}
// *********************************************************************//
class IDLPrinterPortIOXDisp : public TAutoDriver<IDLPrinterPortIOX>
{
  typedef TDispId<IDLPrinterPortIOX> _TDispID;
public:

  IDLPrinterPortIOXDisp()
  {}

  IDLPrinterPortIOXDisp& operator=(IDLPrinterPortIOX *pintf)
  {
    TAutoDriver<IDLPrinterPortIOX>::Bind(pintf);
  }

  HRESULT BindDefault(/*Binds to CoClass DLPrinterPortIOX*/)
  {
    return OLECHECK(Bind(CLSID_DLPrinterPortIOX));
  }

  HRESULT /*[VT_HRESULT:0]*/  LPTStrobe()
  {
    static _TDispID _dispid(*this, OLETEXT("LPTStrobe"), DISPID(1));
    return OleFunction(_dispid);
  }

  HRESULT /*[VT_HRESULT:0]*/  LPTAutofd(VARIANT_BOOL Flag/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("LPTAutofd"), DISPID(2));
    TAutoArgs<1> _args;
    _args[1] = Flag /*[VT_BOOL:0]*/;
    return OleFunction(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  LPTInit()
  {
    static _TDispID _dispid(*this, OLETEXT("LPTInit"), DISPID(3));
    return OleFunction(_dispid);
  }

  HRESULT /*[VT_HRESULT:0]*/  LPTSlctIn()
  {
    static _TDispID _dispid(*this, OLETEXT("LPTSlctIn"), DISPID(4));
    return OleFunction(_dispid);
  }

  HRESULT /*[VT_HRESULT:0]*/  LPTPrintChar(short Ch/*[in]*/,VARIANT_BOOL* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("LPTPrintChar"), DISPID(5));
    TAutoArgs<1> _args;
    _args[1] = Ch /*[VT_I2:0]*/;
    return OutRetValSetterPtr(Value /*[VT_BOOL:1]*/, _args, OleFunction(_dispid, _args));
  }

  HRESULT /*[VT_HRESULT:0]*/  GetPin(unsigned char Index/*[in]*/,VARIANT_BOOL* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("GetPin"), DISPID(6));
    TAutoArgs<1> _args;
    _args[1] = Index /*[VT_UI1:0]*/;
    return OutRetValSetterPtr(Value /*[VT_BOOL:1]*/, _args, OleFunction(_dispid, _args));
  }

  HRESULT /*[VT_HRESULT:0]*/  SetPin(unsigned char Index/*[in]*/,VARIANT_BOOL State/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("SetPin"), DISPID(7));
    TAutoArgs<2> _args;
    _args[1] = Index /*[VT_UI1:0]*/;
    _args[2] = State /*[VT_BOOL:0]*/;
    return OleFunction(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  get_LPTAckwl(VARIANT_BOOL* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("LPTAckwl"), DISPID(8));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_BOOL:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  VARIANT_BOOL get_LPTAckwl(void)
  {
    VARIANT_BOOL Value;
    get_LPTAckwl(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  get_LPTBusy(VARIANT_BOOL* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("LPTBusy"), DISPID(9));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_BOOL:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  VARIANT_BOOL get_LPTBusy(void)
  {
    VARIANT_BOOL Value;
    get_LPTBusy(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  get_LPTPaperEnd(VARIANT_BOOL* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("LPTPaperEnd"), DISPID(10));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_BOOL:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  VARIANT_BOOL get_LPTPaperEnd(void)
  {
    VARIANT_BOOL Value;
    get_LPTPaperEnd(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  get_LPTSlct(VARIANT_BOOL* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("LPTSlct"), DISPID(11));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_BOOL:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  VARIANT_BOOL get_LPTSlct(void)
  {
    VARIANT_BOOL Value;
    get_LPTSlct(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  get_LPTError(VARIANT_BOOL* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("LPTError"), DISPID(12));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_BOOL:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  VARIANT_BOOL get_LPTError(void)
  {
    VARIANT_BOOL Value;
    get_LPTError(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  get_LPTNumPorts(unsigned char* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("LPTNumPorts"), DISPID(13));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_UI1:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  unsigned char get_LPTNumPorts(void)
  {
    unsigned char Value;
    get_LPTNumPorts(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  get_LPTNumber(unsigned char* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("LPTNumber"), DISPID(14));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_UI1:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  unsigned char get_LPTNumber(void)
  {
    unsigned char Value;
    get_LPTNumber(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  set_LPTNumber(unsigned char Value/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("LPTNumber"), DISPID(14));
    TAutoArgs<1> _args;
    _args[1] = Value /*[VT_UI1:0]*/;
    return OlePropertyPut(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  get_LPTBasePort(short* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("LPTBasePort"), DISPID(15));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_I2:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  short get_LPTBasePort(void)
  {
    short Value;
    get_LPTBasePort(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  OpenDriver()
  {
    static _TDispID _dispid(*this, OLETEXT("OpenDriver"), DISPID(16));
    return OleFunction(_dispid);
  }

  HRESULT /*[VT_HRESULT:0]*/  CloseDriver()
  {
    static _TDispID _dispid(*this, OLETEXT("CloseDriver"), DISPID(17));
    return OleFunction(_dispid);
  }

  HRESULT /*[VT_HRESULT:0]*/  ReadPortFIFO(short PortAddr/*[in]*/,short NumPorts/*[in]*/,
                                           unsigned char Buffer/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("ReadPortFIFO"), DISPID(18));
    TAutoArgs<3> _args;
    _args[1] = PortAddr /*[VT_I2:0]*/;
    _args[2] = NumPorts /*[VT_I2:0]*/;
    _args[3] = Buffer /*[VT_UI1:0]*/;
    return OleFunction(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  WritePortFIFO(short PortAddr/*[in]*/,short NumPorts/*[in]*/,
                                            unsigned char Buffer/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("WritePortFIFO"), DISPID(19));
    TAutoArgs<3> _args;
    _args[1] = PortAddr /*[VT_I2:0]*/;
    _args[2] = NumPorts /*[VT_I2:0]*/;
    _args[3] = Buffer /*[VT_UI1:0]*/;
    return OleFunction(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  ReadWPortFIFO(short PortAddr/*[in]*/,short NumPorts/*[in]*/,
                                            short Buffer/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("ReadWPortFIFO"), DISPID(20));
    TAutoArgs<3> _args;
    _args[1] = PortAddr /*[VT_I2:0]*/;
    _args[2] = NumPorts /*[VT_I2:0]*/;
    _args[3] = Buffer /*[VT_I2:0]*/;
    return OleFunction(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  WriteWPortFIFO(short PortAddr/*[in]*/,short NumPorts/*[in]*/,
                                             short Buffer/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("WriteWPortFIFO"), DISPID(21));
    TAutoArgs<3> _args;
    _args[1] = PortAddr /*[VT_I2:0]*/;
    _args[2] = NumPorts /*[VT_I2:0]*/;
    _args[3] = Buffer /*[VT_I2:0]*/;
    return OleFunction(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  ReadLPortFIFO(short PortAddr/*[in]*/,short NumPorts/*[in]*/,
                                            long Buffer/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("ReadLPortFIFO"), DISPID(22));
    TAutoArgs<3> _args;
    _args[1] = PortAddr /*[VT_I2:0]*/;
    _args[2] = NumPorts /*[VT_I2:0]*/;
    _args[3] = Buffer /*[VT_I4:0]*/;
    return OleFunction(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  WriteLPortFIFO(short PortAddr/*[in]*/,short NumPorts/*[in]*/,
                                             long Buffer/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("WriteLPortFIFO"), DISPID(23));
    TAutoArgs<3> _args;
    _args[1] = PortAddr /*[VT_I2:0]*/;
    _args[2] = NumPorts /*[VT_I2:0]*/;
    _args[3] = Buffer /*[VT_I4:0]*/;
    return OleFunction(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  ReadPort(short Address/*[in]*/,unsigned char* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("ReadPort"), DISPID(24));
    TAutoArgs<1> _args;
    _args[1] = Address /*[VT_I2:0]*/;
    return OutRetValSetterPtr(Value /*[VT_UI1:1]*/, _args, OleFunction(_dispid, _args));
  }

  HRESULT /*[VT_HRESULT:0]*/  WritePort(short Address/*[in]*/,unsigned char Data/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("WritePort"), DISPID(25));
    TAutoArgs<2> _args;
    _args[1] = Address /*[VT_I2:0]*/;
    _args[2] = Data /*[VT_UI1:0]*/;
    return OleFunction(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  ReadPortW(short Address/*[in]*/,short* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("ReadPortW"), DISPID(26));
    TAutoArgs<1> _args;
    _args[1] = Address /*[VT_I2:0]*/;
    return OutRetValSetterPtr(Value /*[VT_I2:1]*/, _args, OleFunction(_dispid, _args));
  }

  HRESULT /*[VT_HRESULT:0]*/  WritePortW(short Address/*[in]*/,short Data/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("WritePortW"), DISPID(27));
    TAutoArgs<2> _args;
    _args[1] = Address /*[VT_I2:0]*/;
    _args[2] = Data /*[VT_I2:0]*/;
    return OleFunction(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  ReadPortL(short Address/*[in]*/,long* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("ReadPortL"), DISPID(28));
    TAutoArgs<1> _args;
    _args[1] = Address /*[VT_I2:0]*/;
    return OutRetValSetterPtr(Value /*[VT_I4:1]*/, _args, OleFunction(_dispid, _args));
  }

  HRESULT /*[VT_HRESULT:0]*/  WritePortL(short Address/*[in]*/,long Data/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("WritePortL"), DISPID(29));
    TAutoArgs<2> _args;
    _args[1] = Address /*[VT_I2:0]*/;
    _args[2] = Data /*[VT_I4:0]*/;
    return OleFunction(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  get_DriverPath(BSTR* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("DriverPath"), DISPID(30));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_BSTR:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  BSTR get_DriverPath(void)
  {
    BSTR Value;
    get_DriverPath(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  set_DriverPath(BSTR Value/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("DriverPath"), DISPID(30));
    TAutoArgs<1> _args;
    _args[1] = Value /*[VT_BSTR:0]*/;
    return OlePropertyPut(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  get_DLLPath(BSTR* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("DLLPath"), DISPID(31));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_BSTR:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  BSTR get_DLLPath(void)
  {
    BSTR Value;
    get_DLLPath(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  set_DLLPath(BSTR Value/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("DLLPath"), DISPID(31));
    TAutoArgs<1> _args;
    _args[1] = Value /*[VT_BSTR:0]*/;
    return OlePropertyPut(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  get_ActiveHW(VARIANT_BOOL* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("ActiveHW"), DISPID(32));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_BOOL:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  VARIANT_BOOL get_ActiveHW(void)
  {
    VARIANT_BOOL Value;
    get_ActiveHW(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  get_HardAccess(VARIANT_BOOL* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("HardAccess"), DISPID(33));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_BOOL:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  VARIANT_BOOL get_HardAccess(void)
  {
    VARIANT_BOOL Value;
    get_HardAccess(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  set_HardAccess(VARIANT_BOOL Value/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("HardAccess"), DISPID(33));
    TAutoArgs<1> _args;
    _args[1] = Value /*[VT_BOOL:0]*/;
    return OlePropertyPut(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  get_LastError(BSTR* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("LastError"), DISPID(34));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_BSTR:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  BSTR get_LastError(void)
  {
    BSTR Value;
    get_LastError(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  get_Visible(VARIANT_BOOL* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("Visible"), DISPID(37));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_BOOL:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  VARIANT_BOOL get_Visible(void)
  {
    VARIANT_BOOL Value;
    get_Visible(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  set_Visible(VARIANT_BOOL Value/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("Visible"), DISPID(37));
    TAutoArgs<1> _args;
    _args[1] = Value /*[VT_BOOL:0]*/;
    return OlePropertyPut(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  get_Enabled(VARIANT_BOOL* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("Enabled"), DISPID(-514));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_BOOL:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  VARIANT_BOOL get_Enabled(void)
  {
    VARIANT_BOOL Value;
    get_Enabled(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  set_Enabled(VARIANT_BOOL Value/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("Enabled"), DISPID(-514));
    TAutoArgs<1> _args;
    _args[1] = Value /*[VT_BOOL:0]*/;
    return OlePropertyPut(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  get_Cursor(short* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("Cursor"), DISPID(38));
    TAutoArgs<0> _args;
    return OutRetValSetterPtr(Value /*[VT_I2:1]*/, _args, OlePropertyGet(_dispid, _args));
  }

  short get_Cursor(void)
  {
    short Value;
    get_Cursor(&Value);
    return Value;
  }

  HRESULT /*[VT_HRESULT:0]*/  set_Cursor(short Value/*[in]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("Cursor"), DISPID(38));
    TAutoArgs<1> _args;
    _args[1] = Value /*[VT_I2:0]*/;
    return OlePropertyPut(_dispid, _args);
  }

  HRESULT /*[VT_HRESULT:0]*/  ClassNameIs(BSTR string/*[in]*/,VARIANT_BOOL* Value/*[out,retval]*/)
  {
    static _TDispID _dispid(*this, OLETEXT("ClassNameIs"), DISPID(40));
    TAutoArgs<1> _args;
    _args[1] = string /*[VT_BSTR:0]*/;
    return OutRetValSetterPtr(Value /*[VT_BOOL:1]*/, _args, OleFunction(_dispid, _args));
  }

  HRESULT /*[VT_HRESULT:0]*/  AboutBox()
  {
    static _TDispID _dispid(*this, OLETEXT("AboutBox"), DISPID(-552));
    return OleFunction(_dispid);
  }

  __property VARIANT_BOOL LPTAckwl = {read = get_LPTAckwl};
  __property VARIANT_BOOL LPTBusy = {read = get_LPTBusy};
  __property VARIANT_BOOL LPTPaperEnd = {read = get_LPTPaperEnd};
  __property VARIANT_BOOL LPTSlct = {read = get_LPTSlct};
  __property VARIANT_BOOL LPTError = {read = get_LPTError};
  __property unsigned char LPTNumPorts = {read = get_LPTNumPorts};
  __property unsigned char LPTNumber = {read = get_LPTNumber, write = set_LPTNumber};
  __property short LPTBasePort = {read = get_LPTBasePort};
  __property BSTR DriverPath = {read = get_DriverPath, write = set_DriverPath};
  __property BSTR DLLPath = {read = get_DLLPath, write = set_DLLPath};
  __property VARIANT_BOOL ActiveHW = {read = get_ActiveHW};
  __property VARIANT_BOOL HardAccess = {read = get_HardAccess, write = set_HardAccess};
  __property BSTR LastError = {read = get_LastError};
  __property VARIANT_BOOL Visible = {read = get_Visible, write = set_Visible};
  __property VARIANT_BOOL Enabled = {read = get_Enabled, write = set_Enabled};
  __property short Cursor = {read = get_Cursor, write = set_Cursor};
};

// *********************************************************************//
// Interface: IDLPrinterPortIOXEvents
// Flags:     (0)
// GUID:      {0CF882A3-36E5-11D3-AEA1-02608CA7A319}
// *********************************************************************//
interface IDLPrinterPortIOXEvents : public IDispatch
{
// DispInterfaces have no methods. Their methods and properties are
// accessed via IDispatch::Invoke. See the class IDLPrinterPortIOXEventsDisp provided
// below for an easy way to access the methods/properties of this
// interface.
};
// *********************************************************************//
// DispIntf:  IDLPrinterPortIOXEvents
// Flags:     (0)
// GUID:      {0CF882A3-36E5-11D3-AEA1-02608CA7A319}
// *********************************************************************//
class IDLPrinterPortIOXEventsDisp : public TAutoDriver<IDLPrinterPortIOXEvents>
{
  typedef TDispId<IDLPrinterPortIOXEvents> _TDispID;
public:

  IDLPrinterPortIOXEventsDisp()
  {}

  IDLPrinterPortIOXEventsDisp& operator=(IDLPrinterPortIOXEvents *pintf)
  {
    TAutoDriver<IDLPrinterPortIOXEvents>::Bind(pintf);
  }

};


// *********************************************************************//
// OCX PROXY CLASS DECLARATION
// Control Name     : TDLPrinterPortIOXProxy
// Help String      : DLPrinterPortIOX Control
// Default Interface: IDLPrinterPortIOX
// Def. Intf. Object: TCOMIDLPrinterPortIOX
// Def. Intf. DISP? : No
// Event   Interface: IDLPrinterPortIOXEvents
// *********************************************************************//

// *********************************************************************//
// Definition of closures to allow VCL handlers to catch OCX events.    //
// *********************************************************************//
//+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
// Proxy class to host DLPrinterPortIOX Control in CBuilder IDE/Applications.
//-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
class PACKAGE TDLPrinterPortIOXProxy : public TOCXProxy
{
private:

  // Instance of Closures to expose OCX Events as VCL ones
  //

  // Default Interace of OCX
  //
  TCOMIDLPrinterPortIOX m_OCXIntf;
  // VCL Property Getters/Setters which delegate to OCX
  //

  // Static variables used by all instances of OCX proxy
  //
  static TControlData CControlData;

  // Method providing access to interface as __property 
  //
  TCOMIDLPrinterPortIOX __fastcall GetControlInterface(void);

protected:
  void     __fastcall CreateControl  (void);
  void     __fastcall InitControlData(void);

public:
  virtual  __fastcall TDLPrinterPortIOXProxy(TComponent* AOwner) : TOCXProxy(AOwner)
  {};
  virtual  __fastcall TDLPrinterPortIOXProxy(HWND        Parent) : TOCXProxy(Parent)
  {};

  // OCX methods
  //
  void/*HRESULT*/ __fastcall LPTStrobe(void);
  void/*HRESULT*/ __fastcall LPTAutofd(VARIANT_BOOL Flag/*[in]*/);
  void/*HRESULT*/ __fastcall LPTInit(void);
  void/*HRESULT*/ __fastcall LPTSlctIn(void);
  VARIANT_BOOL __fastcall LPTPrintChar(short Ch/*[in]*/);
  VARIANT_BOOL __fastcall GetPin(unsigned char Index/*[in]*/);
  void/*HRESULT*/ __fastcall SetPin(unsigned char Index/*[in]*/, VARIANT_BOOL State/*[in]*/);
  void/*HRESULT*/ __fastcall OpenDriver(void);
  void/*HRESULT*/ __fastcall CloseDriver(void);
  void/*HRESULT*/ __fastcall ReadPortFIFO(short PortAddr/*[in]*/, short NumPorts/*[in]*/, 
                                          unsigned char Buffer/*[in]*/);
  void/*HRESULT*/ __fastcall WritePortFIFO(short PortAddr/*[in]*/, short NumPorts/*[in]*/, 
                                           unsigned char Buffer/*[in]*/);
  void/*HRESULT*/ __fastcall ReadWPortFIFO(short PortAddr/*[in]*/, short NumPorts/*[in]*/, 
                                           short Buffer/*[in]*/);
  void/*HRESULT*/ __fastcall WriteWPortFIFO(short PortAddr/*[in]*/, short NumPorts/*[in]*/, 
                                            short Buffer/*[in]*/);
  void/*HRESULT*/ __fastcall ReadLPortFIFO(short PortAddr/*[in]*/, short NumPorts/*[in]*/, 
                                           long Buffer/*[in]*/);
  void/*HRESULT*/ __fastcall WriteLPortFIFO(short PortAddr/*[in]*/, short NumPorts/*[in]*/, 
                                            long Buffer/*[in]*/);
  unsigned char __fastcall ReadPort(short Address/*[in]*/);
  void/*HRESULT*/ __fastcall WritePort(short Address/*[in]*/, unsigned char Data/*[in]*/);
  short __fastcall ReadPortW(short Address/*[in]*/);
  void/*HRESULT*/ __fastcall WritePortW(short Address/*[in]*/, short Data/*[in]*/);
  long __fastcall ReadPortL(short Address/*[in]*/);
  void/*HRESULT*/ __fastcall WritePortL(short Address/*[in]*/, long Data/*[in]*/);
  VARIANT_BOOL __fastcall ClassNameIs(BSTR string/*[in]*/);
  void/*HRESULT*/ __fastcall AboutBox(void);

  // OCX properties
  //
  __property Word LPTAckwl={ read=GetWordBoolProp, index=8 };
  __property Word LPTBusy={ read=GetWordBoolProp, index=9 };
  __property Word LPTPaperEnd={ read=GetWordBoolProp, index=10 };
  __property Word LPTSlct={ read=GetWordBoolProp, index=11 };
  __property Word LPTError={ read=GetWordBoolProp, index=12 };
  __property Byte LPTNumPorts={ read=GetByteProp, index=13 };
  __property short LPTBasePort={ read=GetSmallintProp, index=15 };
  __property Word ActiveHW={ read=GetWordBoolProp, index=32 };
  __property System::WideString LastError={ read=GetWideStringProp, index=34 };
  __property TCOMIDLPrinterPortIOX ControlInterface={ read=GetControlInterface };

  // Published properties
  //
__published:

  // Standard properties
  //

  // OCX properties
  //
  __property Byte LPTNumber={ read=GetByteProp, write=SetByteProp, stored=false, index=14 };
  __property System::WideString DriverPath={ read=GetWideStringProp, write=SetWideStringProp, stored=false, index=30 };
  __property System::WideString DLLPath={ read=GetWideStringProp, write=SetWideStringProp, stored=false, index=31 };
  __property Word HardAccess={ read=GetWordBoolProp, write=SetWordBoolProp, stored=false, index=33 };
  __property Word Visible={ read=GetWordBoolProp, write=SetWordBoolProp, stored=false, index=37 };
  __property Word Enabled={ read=GetWordBoolProp, write=SetWordBoolProp, stored=false, index=-514 };
  __property short Cursor={ read=GetSmallintProp, write=SetSmallintProp, stored=false, index=38 };

  // OCX Events
  //
};

#if defined(USING_ATL) || defined(USING_ATLVCL)

// *********************************************************************//
// CONNECTIONPOINT/EVENT PROXY
// CoClass         : DLPrinterPortIOX
// Event Interface : IDLPrinterPortIOXEvents
// *********************************************************************//
template <class T>
class TEvents_DLPrinterPortIOX : public IConnectionPointImpl<T, &DIID_IDLPrinterPortIOXEvents, CComUnkArray<CONNECTIONPOINT_ARRAY_SIZE> >
{
public:
};


#endif // USING_ATL || USING_ATLVCL

};     // namespace Dlprinterportioxcontrol_tlb

#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using  namespace Dlprinterportioxcontrol_tlb;
#endif

#pragma option pop

#endif // __DLPrinterPortIOXControl_TLB_h__
