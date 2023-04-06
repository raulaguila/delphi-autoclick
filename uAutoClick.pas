unit uAutoClick;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    btnStart: TButton;
    edtHours: TEdit;
    edtMin: TEdit;
    edtSec: TEdit;
    edtMiliSec: TEdit;
    grpIntervaloClique: TGroupBox;
    tmr1: TTimer;
    cbbTypeClick: TComboBox;
    grpOpcoesClique: TGroupBox;
    cbbMouseButton: TComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    grpRepetirClique: TGroupBox;
    se1: TSpinEdit;
    rbRepeat: TRadioButton;
    lbl3: TLabel;
    rbRepeat2: TRadioButton;
    grpPosiçãoCursor: TGroupBox;
    rbPos: TRadioButton;
    rbSetPos: TRadioButton;
    btnDefinirPos: TButton;
    edtX: TEdit;
    edtY: TEdit;
    lbl4: TLabel;
    lbl5: TLabel;
    grpOpcoesAutoClique: TGroupBox;
    chkFormStyle: TCheckBox;
    chkHideForm: TCheckBox;
    btnConfig: TButton;
    btnSobre: TButton;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    tmrKeyStatus: TTimer;
    function getTime: Integer;
    procedure enableCFGPos(enable: Boolean);
    procedure btnStartClick(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure cbbTypeClickChange(Sender: TObject);
    procedure cbbMouseButtonChange(Sender: TObject);
    procedure chkFormStyleClick(Sender: TObject);
    procedure rbSetPosClick(Sender: TObject);
    procedure rbPosClick(Sender: TObject);
    procedure btnDefinirPosClick(Sender: TObject);
    procedure tmrKeyStatusTimer(Sender: TObject);
    procedure start;
    procedure chkHideFormClick(Sender: TObject);
    function InstallMouseHook: Boolean;
    procedure edtXChange(Sender: TObject);
    procedure edtYChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  doubleClick: Boolean = True;
  MouseButtonDOWN: DWORD = MOUSEEVENTF_LEFTDOWN;
  MouseButtonUP: DWORD = MOUSEEVENTF_LEFTUP;
  i: Integer = 0;
  nRepeat: Integer = 0;
  tRepeat: Integer = 1;
  repetir: Boolean = False;
  back: Boolean = False;
  Pt: TPoint;

implementation

var
  HookHandle: Cardinal;

type
  tagMSLLHOOKSTRUCT = record
    POINT: TPoint;
    mouseData: DWORD;
    flags: DWORD;
    time: DWORD;
    dwExtraInfo: DWORD;
  end;

  TMSLLHOOKSTRUCT = tagMSLLHOOKSTRUCT;
  PMSLLHOOKSTRUCT = ^TMSLLHOOKSTRUCT;

  { Funcao de um dll do windows }
Function BlockInput(fbLookIt: Boolean): Integer; stdcall; external 'user32.dll';
{$R *.dfm}

procedure TForm1.tmrKeyStatusTimer(Sender: TObject);
var
  Key: Integer;
begin
  Key := GetKeyState(VK_F6);

  if (((Key = 1) and (i = 0)) or ((Key = 0) and (i = 1))) then
  begin
    i := Key;
    start;
  end;
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  start();
end;

procedure TForm1.tmr1Timer(Sender: TObject);
var
  t: TPoint;
begin
  BlockInput(True);
  Winapi.Windows.GetCursorPos(t);
  Pt.X := StrToInt(edtX.Text);
  Pt.Y := StrToInt(edtY.Text);

  if rbSetPos.Checked then
  begin
    SetCursorPos(Pt.X, Pt.Y);
    Mouse_Event(MOUSEEVENTF_ABSOLUTE or MouseButtonDOWN, Pt.X, Pt.Y, 0, 0);
  end
  else
    Mouse_Event(MOUSEEVENTF_ABSOLUTE or MouseButtonDOWN, 0, 0, 0, 0);

  if rbSetPos.Checked then
  begin
    SetCursorPos(Pt.X, Pt.Y);
    Mouse_Event(MOUSEEVENTF_ABSOLUTE or MouseButtonUP, Pt.X, Pt.Y, 0, 0);
  end
  else
    Mouse_Event(MOUSEEVENTF_ABSOLUTE or MouseButtonUP, 0, 0, 0, 0);

  if doubleClick then
  begin
    if rbSetPos.Checked then
    begin
      SetCursorPos(Pt.X, Pt.Y);
      Mouse_Event(MOUSEEVENTF_ABSOLUTE or MouseButtonDOWN, Pt.X, Pt.Y, 0, 0);
    end
    else
      Mouse_Event(MOUSEEVENTF_ABSOLUTE or MouseButtonDOWN, 0, 0, 0, 0);

    if rbSetPos.Checked then
    begin
      SetCursorPos(Pt.X, Pt.Y);
      Mouse_Event(MOUSEEVENTF_ABSOLUTE or MouseButtonUP, Pt.X, Pt.Y, 0, 0);
    end
    else
      Mouse_Event(MOUSEEVENTF_ABSOLUTE or MouseButtonUP, 0, 0, 0, 0);
  end;

  sleep(2);

  if repetir then
  begin
    nRepeat := nRepeat + 1;
    Application.ProcessMessages;
    if nRepeat = tRepeat then
    begin
      start;
    end;
  end;
  SetCursorPos(t.X, t.Y);
  BlockInput(False);
end;

function TForm1.getTime: Integer;
var
  hour, min, sec, milisec: Integer;
begin
  hour := StrToInt(edtHours.Text) * 3600000;
  min := StrToInt(edtMin.Text) * 60000;
  sec := StrToInt(edtSec.Text) * 1000;
  milisec := StrToInt(edtMiliSec.Text);

  Result := hour + min + sec + milisec;
end;

procedure TForm1.rbPosClick(Sender: TObject);
begin
  enableCFGPos(False);
end;

procedure TForm1.rbSetPosClick(Sender: TObject);
begin
  enableCFGPos(True);
end;

procedure TForm1.start;
begin
  if rbRepeat.Checked then
  begin
    nRepeat := 0;
    repetir := True;
    tRepeat := se1.Value;
  end
  else
    repetir := False;

  tmr1.Interval := getTime;
  Application.ProcessMessages;
  tmr1.Enabled := not tmr1.Enabled;

  if tmr1.Enabled then
  begin
    if back then
      Form1.Hide;
    btnStart.Caption := 'Stop (F6)';
  end
  else
  begin
    btnStart.Caption := 'Start (F6)';
    Form1.Show;
  end;

  grpPosiçãoCursor.Enabled := not tmr1.Enabled;
  grpOpcoesClique.Enabled := not tmr1.Enabled;
  grpRepetirClique.Enabled := not tmr1.Enabled;
  grpIntervaloClique.Enabled := not tmr1.Enabled;
  grpOpcoesAutoClique.Enabled := not tmr1.Enabled;
end;

procedure TForm1.cbbMouseButtonChange(Sender: TObject);
begin
  case cbbMouseButton.ItemIndex of
    0:
      begin
        MouseButtonDOWN := MOUSEEVENTF_LEFTDOWN;
        MouseButtonUP := MOUSEEVENTF_LEFTUP;
      end;
    1:
      begin
        MouseButtonDOWN := MOUSEEVENTF_RIGHTDOWN;
        MouseButtonUP := MOUSEEVENTF_RIGHTUP;
      end;
    2:
      begin
        MouseButtonDOWN := MOUSEEVENTF_MIDDLEDOWN;
        MouseButtonUP := MOUSEEVENTF_MIDDLEUP;
      end;
  end;
end;

procedure TForm1.cbbTypeClickChange(Sender: TObject);
begin
  case cbbTypeClick.ItemIndex of
    0:
      begin
        doubleClick := False;
      end;
    1:
      begin
        doubleClick := True;
      end;
  end;
end;

procedure TForm1.chkHideFormClick(Sender: TObject);
begin
  if chkHideForm.Checked then
  begin
    back := True;
  end
  else
    back := False;

end;

procedure TForm1.chkFormStyleClick(Sender: TObject);
begin
  if chkFormStyle.Checked then
  begin
    Form1.FormStyle := fsStayOnTop;
  end
  else
    Form1.FormStyle := fsNormal;
end;

procedure TForm1.enableCFGPos(enable: Boolean);
begin
  btnDefinirPos.Enabled := enable;
  edtX.Enabled := enable;
  edtY.Enabled := enable;
  lbl4.Enabled := enable;
  lbl5.Enabled := enable;
end;

function LowLevelMouseProc(nCode: Integer; wParam: wParam; lParam: lParam)
  : LRESULT; stdcall;
begin
  if (nCode >= 0) then
  begin
    if wParam = WM_LButtonUP then
    begin
      Form1.edtX.Text := PMSLLHOOKSTRUCT(lParam)^.POINT.X.ToString;
      Form1.edtY.Text := PMSLLHOOKSTRUCT(lParam)^.POINT.Y.ToString;
    end;

    // Form1.Caption := Format('X: %d  Y: %d ', [PMSLLHOOKSTRUCT(lParam)^.POINT.X, PMSLLHOOKSTRUCT(lParam)^.POINT.Y]);
    // Form1.Caption := Form1.Caption + ' >> ' + IntToStr(Delta);
  end;
  Result := CallNextHookEx(HookHandle, nCode, wParam, lParam);
end;

function TForm1.InstallMouseHook: Boolean;
begin
  Result := False;
  if HookHandle = 0 then
  begin
    HookHandle := SetWindowsHookEx(WH_MOUSE_LL, @LowLevelMouseProc,
      hInstance, 0);
    Result := HookHandle <> 0;
  end;
end;

procedure TForm1.btnDefinirPosClick(Sender: TObject);
begin
  InstallMouseHook;
end;

procedure TForm1.edtXChange(Sender: TObject);
begin
  if HookHandle <> 0 then
  begin
    UnhookWindowsHookEx(HookHandle);
    HookHandle := 0;
  end;
  Pt.X := StrToInt(edtX.Text);
end;

procedure TForm1.edtYChange(Sender: TObject);
begin
  Pt.Y := StrToInt(edtY.Text);
end;

end.
