//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
#include <atl\atlvcl.h>

#include "DLPrinterPortIOImpl.h"
#include "About.h"
//---------------------------------------------------------------------------
#pragma link "TDLPortIOX"
#pragma package(smart_init)
STDMETHODIMP TDLPrinterPortIOXImpl::AboutBox()
{
  try
  {
    ShowDLPrinterPortIOXAbout();
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::ClassNameIs(BSTR string,
  VARIANT_BOOL* Value)
{
  try
  {
    *Value = m_VclCtl->ClassNameIs(string);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::CloseDriver()
{
  try
  {
    m_VclCtl->CloseDriver();
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_ActiveHW(VARIANT_BOOL* Value)
{
  try
  {
    *Value = m_VclCtl->ActiveHW;
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_Cursor(short* Value)
{
  try
  {
    *Value = (short)(m_VclCtl->Cursor);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_DLLPath(BSTR* Value)
{
  try
  {
    *Value = WideString(m_VclCtl->DLLPath).Copy();
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_DriverPath(BSTR* Value)
{
  try
  {
    *Value = WideString(m_VclCtl->DriverPath).Copy();
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_Enabled(VARIANT_BOOL* Value)
{
  try
  {
    *Value = m_VclCtl->Enabled;
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_HardAccess(VARIANT_BOOL* Value)
{
  try
  {
    *Value = m_VclCtl->HardAccess;
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_LastError(BSTR* Value)
{
  try
  {
    *Value = WideString(m_VclCtl->LastError).Copy();
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_LPTAckwl(VARIANT_BOOL* Value)
{
  try
  {
    *Value = m_VclCtl->LPTAckwl;
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_LPTBasePort(short* Value)
{
  try
  {
    *Value = (short)(m_VclCtl->LPTBasePort);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_LPTBusy(VARIANT_BOOL* Value)
{
  try
  {
    *Value = m_VclCtl->LPTBusy;
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_LPTError(VARIANT_BOOL* Value)
{
  try
  {
    *Value = m_VclCtl->LPTError;
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_LPTNumber(unsigned char* Value)
{
  try
  {
    *Value = m_VclCtl->LPTNumber;
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_LPTNumPorts(unsigned char* Value)
{
  try
  {
    *Value = m_VclCtl->LPTNumPorts;
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_LPTPaperEnd(VARIANT_BOOL* Value)
{
  try
  {
    *Value = m_VclCtl->LPTPaperEnd;
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_LPTSlct(VARIANT_BOOL* Value)
{
  try
  {
    *Value = m_VclCtl->LPTSlct;
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::get_Visible(VARIANT_BOOL* Value)
{
  try
  {
    *Value = m_VclCtl->Visible;
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::GetPin(unsigned char Index,
  VARIANT_BOOL* Value)
{
  try
  {
    *Value = m_VclCtl->GetPin(Index);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::LPTAutofd(VARIANT_BOOL Flag)
{
  try
  {
    m_VclCtl->LPTAutofd(Flag);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::LPTInit()
{
  try
  {
    m_VclCtl->LPTInit();
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::LPTPrintChar(short Ch,
  VARIANT_BOOL* Value)
{
  try
  {
    *Value = m_VclCtl->LPTPrintChar(Ch);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::LPTSlctIn()
{
  try
  {
    m_VclCtl->LPTSlctIn();
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::LPTStrobe()
{
  try
  {
    m_VclCtl->LPTStrobe();
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::OpenDriver()
{
  try
  {
    m_VclCtl->OpenDriver();
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::ReadLPortFIFO(short PortAddr,
  short NumPorts, long Buffer)
{
  try
  {
  
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::ReadPort(short Address,
  unsigned char* Value)
{
  try
  {
    *Value = m_VclCtl->ReadPort(Address);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::ReadPortFIFO(short PortAddr,
  short NumPorts, unsigned char Buffer)
{
  try
  {
  
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::ReadPortL(short Address, long* Value)
{
  try
  {
    *Value = m_VclCtl->ReadPortL(Address);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::ReadPortW(short Address, short* Value)
{
  try
  {
    *Value = m_VclCtl->ReadPortW(Address);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::ReadWPortFIFO(short PortAddr,
  short NumPorts, short Buffer)
{
  try
  {
  
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::set_Cursor(short Value)
{
  try
  {
     const DISPID dispid = 38;
     if (FireOnRequestEdit(dispid) == S_FALSE)
       return S_FALSE;
     m_VclCtl->Cursor = (TCursor)(Value);
     FireOnChanged(dispid);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::set_DLLPath(BSTR Value)
{
  try
  {
     const DISPID dispid = 31;
     if (FireOnRequestEdit(dispid) == S_FALSE)
       return S_FALSE;
     m_VclCtl->DLLPath = AnsiString(Value);
     FireOnChanged(dispid);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::set_DriverPath(BSTR Value)
{
  try
  {
     const DISPID dispid = 30;
     if (FireOnRequestEdit(dispid) == S_FALSE)
       return S_FALSE;
     m_VclCtl->DriverPath = AnsiString(Value);
     FireOnChanged(dispid);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::set_Enabled(VARIANT_BOOL Value)
{
  try
  {
     const DISPID dispid = -514;
     if (FireOnRequestEdit(dispid) == S_FALSE)
       return S_FALSE;
     m_VclCtl->Enabled = Value;
     FireOnChanged(dispid);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::set_HardAccess(VARIANT_BOOL Value)
{
  try
  {
     const DISPID dispid = 33;
     if (FireOnRequestEdit(dispid) == S_FALSE)
       return S_FALSE;
     m_VclCtl->HardAccess = Value;
     FireOnChanged(dispid);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::set_LPTNumber(unsigned char Value)
{
  try
  {
     const DISPID dispid = 14;
     if (FireOnRequestEdit(dispid) == S_FALSE)
       return S_FALSE;
     m_VclCtl->LPTNumber = Value;
     FireOnChanged(dispid);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::set_Visible(VARIANT_BOOL Value)
{
  try
  {
     const DISPID dispid = 37;
     if (FireOnRequestEdit(dispid) == S_FALSE)
       return S_FALSE;
     m_VclCtl->Visible = Value;
     FireOnChanged(dispid);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::SetPin(unsigned char Index,
  VARIANT_BOOL State)
{
  try
  {
    m_VclCtl->SetPin(Index, State);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::WriteLPortFIFO(short PortAddr,
  short NumPorts, long Buffer)
{
  try
  {
  
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::WritePort(short Address,
  unsigned char Data)
{
  try
  {
    m_VclCtl->WritePort(Address, Data);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::WritePortFIFO(short PortAddr,
  short NumPorts, unsigned char Buffer)
{
  try
  {
  
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::WritePortL(short Address, long Data)
{
  try
  {
    m_VclCtl->WritePortL(Address, Data);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::WritePortW(short Address, short Data)
{
  try
  {
    m_VclCtl->WritePortW(Address, Data);
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

STDMETHODIMP TDLPrinterPortIOXImpl::WriteWPortFIFO(short PortAddr,
  short NumPorts, short Buffer)
{
  try
  {
  
  }
  catch(Exception &e)
  {
    return Error(e.Message.c_str(), IID_IDLPrinterPortIOX);
  }
  return S_OK;
};
//---------------------------------------------------------------------------

