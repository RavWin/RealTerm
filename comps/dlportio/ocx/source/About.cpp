//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop

#include "About.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
//---------------------------------------------------------------------------
void ShowDLPrinterPortIOXAbout(void)
{
  TDLPrinterPortIOXAbout* Form;
  Form = new TDLPrinterPortIOXAbout(NULL);
  try
  {
    Form->ShowModal();
  }
  catch(...)
  {
    Form->Free();
    return;
  }
  Form->Free();
}
//---------------------------------------------------------------------------
__fastcall TDLPrinterPortIOXAbout::TDLPrinterPortIOXAbout(TComponent* Owner)
   : TForm(Owner)
{
}
//---------------------------------------------------------------------------

