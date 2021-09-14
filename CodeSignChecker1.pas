unit CodeSignChecker1;
// IsCodeSigned, which verifies that the exe hasn't been modified, uses
// WinVerifyTrust, so it's NT only.  IsCompanySigningCertificate works on Win9x,
// but it only checks that the signing certificate hasn't been replaced, which
// keeps someone from re-signing a modified executable.

//https://stackoverflow.com/questions/5993877/checking-digital-signature-programmatically-from-delphi
//Make sure you call both functions if you're running on NT. IsCompanySigningCertificate works on both 9x and NT, but only verifies that the exe has your certificate on it.
//IsCodeSigned actually verifies that file hasn't been tampered with.

//https://stackoverflow.com/questions/38332814/why-does-winverifytrust-failing-only-on-machine-which-is-not-connected-to-inte
//checking for internet might be only choice
//https://stackoverflow.com/questions/22389242/delphi-check-internet-connection/22404225#22404225

interface
uses types,windows,forms;

//if filename='' uses exename, if companyname is given, also checks that it is signed by...
function IsCodeSigned(Filename: string=''; const CompanyName :string=''): Boolean;
function CodeSignedString(Filename: string=''; const CompanyName :string=''):string; overload;
function IsCompanySigningCertificate(Filename:string; const CompanyName :string): Boolean;

implementation

// Imagehlp.dll

function ImageEnumerateCertificates(FileHandle: THandle; TypeFilter: WORD;
  out CertificateCount: DWORD; Indicies: PDWORD; IndexCount: Integer): BOOL; stdcall; external 'Imagehlp.dll';
function ImageGetCertificateHeader(FileHandle: THandle; CertificateIndex: Integer;
  var CertificateHeader: TWinCertificate): BOOL; stdcall; external 'Imagehlp.dll';
function ImageGetCertificateData(FileHandle: THandle; CertificateIndex: Integer;
  Certificate: PWinCertificate; var RequiredLength: DWORD): BOOL; stdcall; external 'Imagehlp.dll';

const
  CERT_SECTION_TYPE_ANY = $FF;      // Any Certificate type

// Crypt32.dll
const
  CERT_NAME_SIMPLE_DISPLAY_TYPE = 4;
  PKCS_7_ASN_ENCODING = $00010000;
  X509_ASN_ENCODING = $00000001;

type
  PCCERT_CONTEXT = type Pointer;
  HCRYPTPROV_LEGACY = type Pointer;
  PFN_CRYPT_GET_SIGNER_CERTIFICATE = type Pointer;

  CRYPT_VERIFY_MESSAGE_PARA = record
    cbSize: DWORD;
    dwMsgAndCertEncodingType: DWORD;
    hCryptProv: HCRYPTPROV_LEGACY;
    pfnGetSignerCertificate: PFN_CRYPT_GET_SIGNER_CERTIFICATE;
    pvGetArg: Pointer;
  end;

function CryptVerifyMessageSignature(const pVerifyPara: CRYPT_VERIFY_MESSAGE_PARA;
  dwSignerIndex: DWORD; pbSignedBlob: PByte; cbSignedBlob: DWORD; pbDecoded: PBYTE;
  pcbDecoded: PDWORD; ppSignerCert: PCCERT_CONTEXT): BOOL; stdcall; external 'Crypt32.dll';
function CertGetNameStringA(pCertContext: PCCERT_CONTEXT; dwType: DWORD; dwFlags: DWORD; pvTypePara: Pointer;
  pszNameString: PAnsiChar; cchNameString: DWORD): DWORD; stdcall; external 'Crypt32.dll';
function CertFreeCertificateContext(pCertContext: PCCERT_CONTEXT): BOOL; stdcall; external 'Crypt32.dll';
function CertCreateCertificateContext(dwCertEncodingType: DWORD;
  pbCertEncoded: PBYTE; cbCertEncoded: DWORD): PCCERT_CONTEXT; stdcall; external 'Crypt32.dll';

// WinTrust.dll
const
  WINTRUST_ACTION_GENERIC_VERIFY_V2: TGUID = '{00AAC56B-CD44-11d0-8CC2-00C04FC295EE}';
  WTD_CHOICE_FILE = 1;
  WTD_REVOKE_NONE = 0;
  WTD_UI_NONE = 2;

type
  PWinTrustFileInfo = ^TWinTrustFileInfo;
  TWinTrustFileInfo = record
    cbStruct: DWORD;                    // = sizeof(WINTRUST_FILE_INFO)
    pcwszFilePath: PWideChar;           // required, file name to be verified
    hFile: THandle;                     // optional, open handle to pcwszFilePath
    pgKnownSubject: PGUID;              // optional: fill if the subject type is known
  end;

  PWinTrustData = ^TWinTrustData;
  TWinTrustData = record
    cbStruct: DWORD;
    pPolicyCallbackData: Pointer;
    pSIPClientData: Pointer;
    dwUIChoice: DWORD;
    fdwRevocationChecks: DWORD;
    dwUnionChoice: DWORD;
    pFile: PWinTrustFileInfo;
    dwStateAction: DWORD;
    hWVTStateData: THandle;
    pwszURLReference: PWideChar;
    dwProvFlags: DWORD;
    dwUIContext: DWORD;
  end;

function WinVerifyTrust(hwnd: HWND; const ActionID: TGUID; ActionData: Pointer): Longint; stdcall; external wintrust;

{-----------------------------------------------}
function CodeSignedString(Filename: string=''; const CompanyName :string=''):string; overload;

begin
  if CompanyName=''
    then result:='CodeSigned'
    else result:='CodeSigned by '+CompanyName;
  if not IsCodeSigned(FileName,CompanyName)
    then result:='**BAD CODE SIGNATURE**';
end;

function IsCodeSigned(Filename: string=''; const CompanyName :string='' ): Boolean;
var
  file_info: TWinTrustFileInfo;
  trust_data: TWinTrustData;
begin
  if Filename='' then Filename:=Application.ExeName;

  // Verify that the exe is signed and the checksum matches
  FillChar(file_info, SizeOf(file_info), 0);
  file_info.cbStruct := sizeof(file_info);
  file_info.pcwszFilePath := PWideChar(WideString(Filename));
  FillChar(trust_data, SizeOf(trust_data), 0);
  trust_data.cbStruct := sizeof(trust_data);
  trust_data.dwUIChoice := WTD_UI_NONE;
  trust_data.fdwRevocationChecks := WTD_REVOKE_NONE;
  trust_data.dwUnionChoice := WTD_CHOICE_FILE;
  trust_data.pFile := @file_info;
  Result := WinVerifyTrust(INVALID_HANDLE_VALUE, WINTRUST_ACTION_GENERIC_VERIFY_V2,
    @trust_data) = ERROR_SUCCESS;
  if CompanyName<>'' then
    Result:= result and IsCompanySigningCertificate(Filename,CompanyName);

end;

{-----------------------------------------------}

function IsCompanySigningCertificate(Filename:string; const CompanyName :string): Boolean;
var
  hExe: HMODULE;
  Cert: PWinCertificate;
  CertContext: PCCERT_CONTEXT;
  CertCount: DWORD;
  CertName: AnsiString;
  CertNameLen: DWORD;
  VerifyParams: CRYPT_VERIFY_MESSAGE_PARA;
begin
  // Returns TRUE if the SubjectName on the certificate used to sign the exe is
  // "Company Name".  Should prevent a cracker from modifying the file and
  // re-signing it with their own certificate.
  //
  // Microsoft has an example that does this using CryptQueryObject and
  // CertFindCertificateInStore instead of CryptVerifyMessageSignature, but
  // CryptQueryObject is NT-only.  Using CertCreateCertificateContext doesn't work
  // either, though I don't know why.
  if Filename='' then Filename:=Application.ExeName;
  Result := False;
  // Verify that the exe was signed by our private key
  hExe := CreateFile(PChar(Filename), GENERIC_READ, FILE_SHARE_READ,
    nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL or FILE_FLAG_RANDOM_ACCESS, 0);
  if hExe = INVALID_HANDLE_VALUE then
    Exit;
  try
    // There should only be one certificate associated with the exe
    if (not ImageEnumerateCertificates(hExe, CERT_SECTION_TYPE_ANY, CertCount, nil, 0)) or
       (CertCount <> 1) then
      Exit;
    // Read the certificate header so we can get the size needed for the full cert
    GetMem(Cert, SizeOf(TWinCertificate) + 3); // ImageGetCertificateHeader writes an DWORD at bCertificate for some reason
    try
      Cert.dwLength := 0;
      Cert.wRevision := WIN_CERT_REVISION_1_0;
      if not ImageGetCertificateHeader(hExe, 0, Cert^) then
        Exit;
      // Read the full certificate
      ReallocMem(Cert, SizeOf(TWinCertificate) + Cert.dwLength);
      if not ImageGetCertificateData(hExe, 0, Cert, Cert.dwLength) then
        Exit;
      // Get the certificate context.  CryptVerifyMessageSignature has the
      // side effect of creating a context for the signing certificate.
      FillChar(VerifyParams, SizeOf(VerifyParams), 0);
      VerifyParams.cbSize := SizeOf(VerifyParams);
      VerifyParams.dwMsgAndCertEncodingType := X509_ASN_ENCODING or PKCS_7_ASN_ENCODING;
      if not CryptVerifyMessageSignature(VerifyParams, 0, @Cert.bCertificate,
         Cert.dwLength, nil, nil, @CertContext) then
        Exit;
      try
        // Extract and compare the certificate's subject names.  Don't
        // compare the entire certificate or the public key as those will
        // change when the certificate is renewed.
        CertNameLen := CertGetNameStringA(CertContext,
          CERT_NAME_SIMPLE_DISPLAY_TYPE, 0, nil, nil, 0);
        SetLength(CertName, CertNameLen - 1);
        CertGetNameStringA(CertContext, CERT_NAME_SIMPLE_DISPLAY_TYPE, 0,
          nil, PAnsiChar(CertName), CertNameLen);
        if CertName <> CompanyName then
          Exit;
      finally
        CertFreeCertificateContext(CertContext)
      end;
    finally
      FreeMem(Cert);
    end;
  finally
    CloseHandle(hExe);
  end;
  Result := True;
end;

end.
