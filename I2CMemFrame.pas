unit I2CMemFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls;

type
  TFrameI2CMem = class(TFrame)
    GroupBoxI2CMem: TGroupBox;
    Panel1: TPanel;
    Label30: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    LabelI2CMemMemSize: TLabel;
    ComboBoxI2CMemType: TComboBox;
    SpinEditI2CMemPointerBytes: TSpinEdit;
    SpinEditIMWriteTime: TSpinEdit;
    ComboBox1: TComboBox;
    Panel6: TPanel;
    ButtonWriteFromFile: TButton;
    ButtonI2CMemBrowseWriteFiles: TButton;
    ComboBoxI2CMemWriteFName: TComboBox;
    GroupBox11: TGroupBox;
    Label43: TLabel;
    Label45: TLabel;
    EditI2CMemStartAdd: TEdit;
    EditI2CMemNumBytesToRead: TEdit;
    UpDown1: TUpDown;
    ComboBoxI2CMemReadFName: TComboBox;
    ButtonI2CMemBrowseReadFiles: TButton;
    ButtonReadToFile: TButton;
    OpenDialogI2CMem: TOpenDialog;
    procedure ButtonI2CMemBrowseReadFilesClick(Sender: TObject);
    procedure ButtonI2CMemBrowseWriteFilesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
 uses i2cx, Helpers;
{$R *.dfm}

procedure TFrameI2CMem.ButtonI2CMemBrowseReadFilesClick(Sender: TObject);
begin
  ComboBoxI2CMemReadFName.FileChoose(OpenDialogI2CMem);
  ComboBoxI2CMemReadFName.SetFilenameCheckPathExists;
//    OpenDialogI2CMem.Filename:= ComboBoxI2CMemReadFName.text;
//  if OpenDialogI2CMem.Execute then                              { Display Open dialog box}
//    begin
//      ComboBoxI2CMemReadFName.text:=OpenDialogI2CMem.FileName;
//    end;
end;

procedure TFrameI2CMem.ButtonI2CMemBrowseWriteFilesClick(Sender: TObject);
begin
  OpenDialogI2CMem.Filename:= ComboBoxI2CMemWriteFName.text;
  if OpenDialogI2CMem.Execute then                              { Display Open dialog box}
    begin
      ComboBoxI2CMemWriteFName.text:=OpenDialogI2CMem.FileName;
    end;
end;



end.
