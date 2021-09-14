unit NoSleep;
{ functions to prevent the PC automatically entering sleep
Used for data logging applications where you want to leave a laptop
unattended, without it sleeping

https://stackoverflow.com/questions/629240/prevent-windows-from-going-into-sleep-when-my-program-is-running
Seem to be two methods - before W7 and post W7

https://stackoverflow.com/questions/8733457/how-to-programatically-prevent-windows-from-hard-disk-drive-spin-down

AWAY_MODE means that the monitor blanks, but keeps running

ToDo: change to PowerCreateRequest method....

}

interface

procedure BlockSleep(NoSleep:boolean=true);

implementation
uses types;
type
  EXECUTION_STATE = DWORD;
const
  ES_SYSTEM_REQUIRED = $00000001;
  ES_DISPLAY_REQUIRED = $00000002;
  ES_USER_PRESENT = $00000004;
  ES_AWAYMODE_REQUIRED = $00000040;
  ES_CONTINUOUS = $80000000;

function SetThreadExecutionState(esFlags: EXECUTION_STATE): EXECUTION_STATE;
  stdcall; external 'kernel32.dll' name 'SetThreadExecutionState';

procedure BlockSleep(NoSleep:boolean=true);
begin
  if NoSleep then begin
    // try this for vista, it will fail on XP
    if (SetThreadExecutionState(ES_CONTINUOUS or ES_SYSTEM_REQUIRED or ES_AWAYMODE_REQUIRED) <>0)
     then    // try XP variant as well just to make sure
       SetThreadExecutionState(ES_CONTINUOUS or ES_SYSTEM_REQUIRED);
      // if
    end else begin
      // set state back to normal
      SetThreadExecutionState(ES_CONTINUOUS);
  end;
end;
end.
