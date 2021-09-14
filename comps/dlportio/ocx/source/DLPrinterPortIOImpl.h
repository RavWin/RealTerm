//---------------------------------------------------------------------------
#ifndef DLPrinterPortIOImplH
#define DLPrinterPortIOImplH
//---------------------------------------------------------------------------
#include "DLPrinterPortIOXControl_TLB.h"
#include "TDLPortIOX.h"

// The following define is utilized by the IDEs Code Manager to ensure that
// your controls Library Identifier is kept up-to-date.
// NOTE: Do not remove or modify this macro.
//
#define LIBID_DLPrinterPortIOX LIBID_DLPrinterPortIOXControl

class ATL_NO_VTABLE TDLPrinterPortIOXImpl:
  VCLCONTROL_IMPL(TDLPrinterPortIOXImpl, DLPrinterPortIOX, TDLPrinterPortIOX, IDLPrinterPortIOX, DIID_IDLPrinterPortIOXEvents)
{
public:

  void InitializeControl()
  {
  }


// The COM MAP entries declares the interfaces your object exposes (through
// QueryInterface). CComRootObjectEx::InternalQueryInterface only returns
// pointers for interfaces in the COM map. VCL controls exposed as OCXes
// have a minimum set of interfaces defined by the
// VCL_CONTROL_COM_INTERFACE_ENTRIES macro. Add other interfaces supported
// by your object with additional COM_INTERFACE_ENTRY[_xxx] macros.
//
BEGIN_COM_MAP(TDLPrinterPortIOXImpl)
  VCL_CONTROL_COM_INTERFACE_ENTRIES(IDLPrinterPortIOX)
END_COM_MAP()



// The PROPERTY map stores property descriptions, property DISPIDs,
// property page CLSIDs and IDispatch IIDs. You may use use
// IPerPropertyBrowsingImpl, IPersistPropertyBagImpl, IPersistStreamInitImpl,
// and ISpecifyPropertyPageImpl to utilize the information in you property
// map.
//
// NOTE: The BCB Wizard does *NOT* maintain your PROPERTY_MAP table. You must
//       add or remove entries manually.
//
BEGIN_PROPERTY_MAP(TDLPrinterPortIOXImpl)
  // PROP_PAGE(CLSID_DLPrinterPortIOXPage)
END_PROPERTY_MAP()

// The DECLARE_ACTIVEXCONTROL_REGISTRY macro declares a static 'UpdateRegistry' 
// routine which registers the basic information about your control. The
// parameters expected by the macro are the ProgId & the ToolboxBitmap ID of
// your control.
//
DECLARE_ACTIVEXCONTROL_REGISTRY("DLPrinterPortIOXControl.DLPrinterPortIOX", 1);

protected: 
  STDMETHOD(AboutBox());
  STDMETHOD(ClassNameIs(BSTR string, VARIANT_BOOL* Value));
  STDMETHOD(CloseDriver());
  STDMETHOD(get_ActiveHW(VARIANT_BOOL* Value));
  STDMETHOD(get_Cursor(short* Value));
  STDMETHOD(get_DLLPath(BSTR* Value));
  STDMETHOD(get_DriverPath(BSTR* Value));
  STDMETHOD(get_Enabled(VARIANT_BOOL* Value));
  STDMETHOD(get_HardAccess(VARIANT_BOOL* Value));
  STDMETHOD(get_LastError(BSTR* Value));
  STDMETHOD(get_LPTAckwl(VARIANT_BOOL* Value));
  STDMETHOD(get_LPTBasePort(short* Value));
  STDMETHOD(get_LPTBusy(VARIANT_BOOL* Value));
  STDMETHOD(get_LPTError(VARIANT_BOOL* Value));
  STDMETHOD(get_LPTNumber(unsigned char* Value));
  STDMETHOD(get_LPTNumPorts(unsigned char* Value));
  STDMETHOD(get_LPTPaperEnd(VARIANT_BOOL* Value));
  STDMETHOD(get_LPTSlct(VARIANT_BOOL* Value));
  STDMETHOD(get_Visible(VARIANT_BOOL* Value));
  STDMETHOD(GetPin(unsigned char Index, VARIANT_BOOL* Value));
  STDMETHOD(LPTAutofd(VARIANT_BOOL Flag));
  STDMETHOD(LPTInit());
  STDMETHOD(LPTPrintChar(short Ch, VARIANT_BOOL* Value));
  STDMETHOD(LPTSlctIn());
  STDMETHOD(LPTStrobe());
  STDMETHOD(OpenDriver());
  STDMETHOD(ReadLPortFIFO(short PortAddr, short NumPorts, long Buffer));
  STDMETHOD(ReadPort(short Address, unsigned char* Value));
  STDMETHOD(ReadPortFIFO(short PortAddr, short NumPorts,
      unsigned char Buffer));
  STDMETHOD(ReadPortL(short Address, long* Value));
  STDMETHOD(ReadPortW(short Address, short* Value));
  STDMETHOD(ReadWPortFIFO(short PortAddr, short NumPorts, short Buffer));
  STDMETHOD(set_Cursor(short Value));
  STDMETHOD(set_DLLPath(BSTR Value));
  STDMETHOD(set_DriverPath(BSTR Value));
  STDMETHOD(set_Enabled(VARIANT_BOOL Value));
  STDMETHOD(set_HardAccess(VARIANT_BOOL Value));
  STDMETHOD(set_LPTNumber(unsigned char Value));
  STDMETHOD(set_Visible(VARIANT_BOOL Value));
  STDMETHOD(SetPin(unsigned char Index, VARIANT_BOOL State));
  STDMETHOD(WriteLPortFIFO(short PortAddr, short NumPorts, long Buffer));
  STDMETHOD(WritePort(short Address, unsigned char Data));
  STDMETHOD(WritePortFIFO(short PortAddr, short NumPorts,
      unsigned char Buffer));
  STDMETHOD(WritePortL(short Address, long Data));
  STDMETHOD(WritePortW(short Address, short Data));
  STDMETHOD(WriteWPortFIFO(short PortAddr, short NumPorts, short Buffer));
};
//---------------------------------------------------------------------------
#endif
