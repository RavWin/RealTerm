//---------------------------------------------------------------------------
#ifndef AboutH
#define AboutH
//---------------------------------------------------------------------------
#include <classes.hpp>
#include <controls.hpp>
#include <stdCtrls.hpp>
#include <forms.hpp>
#include <Buttons.hpp>
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
//---------------------------------------------------------------------------
class TDLPrinterPortIOXAbout : public TForm
{
__published:	// IDE-managed Components
        TSpeedButton *CtlImage;
        TLabel *NameLbl;
        TButton *OkBtn;
   TLabel *Label2;
   TLabel *Label3;
   TLabel *Label4;
private:	// User declarations
public:		// User declarations
   __fastcall TDLPrinterPortIOXAbout(TComponent* Owner);
};
//---------------------------------------------------------------------------
void ShowDLPrinterPortIOXAbout(void);
//---------------------------------------------------------------------------
#endif
