unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ClipBrd;

type
  TForm1 = class(TForm)
    GenerateButton: TButton;
    ComboBox1: TComboBox;
    LengthTextBox: TEdit;
    DecRadioButton: TRadioButton;
    HexRadioButton: TRadioButton;
    DashTextBox: TEdit;
    ReplaceCheckBox: TCheckBox;
    DashModeBox: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    CustomEditBox: TEdit;
    Label4: TLabel;
    SerialTextBox: TMemo;
    CopyButton: TButton;
    Label5: TLabel;
    procedure GenerateButtonClick(Sender: TObject);
    procedure DashModeBoxClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CopyButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

Function GenerateRandLetter(UC:boolean):Char;
var
myCase:byte;
Begin
if UC= true then
mycase:= 0
else
myCase:=$20;
  result:=chr(random(26)+$41+myCase);
End;

procedure TForm1.GenerateButtonClick(Sender: TObject);
var
serial,CustomStr: String;
CSlen, len, dashl, I: Cardinal;
begin
if combobox1.ItemIndex>-1 then begin
if length(LengthTextBox.text)>0 then begin
if DecRadioButton.Checked=True then begin
try
len:=strtoint(LengthTextBox.Text);
except
ShowMessage('"'+LengthTextBox.Text+'" is an Invalid Length!');
exit;
end;

end
Else
if HexRadioButton.Checked=True then Begin
try
len:=strtoint('$'+LengthTextBox.Text);
except
ShowMessage('"'+LengthTextBox.Text+'" is an Invalid Hex Length!');
exit;
end


End Else exit;

if len>0 then begin
serial:='';
case combobox1.ItemIndex of
0: Begin  //0-9
for I := 1 to len do
serial:= serial + inttostr(random(10));
End;
1: begin //hex UC
for I := 1 to len do
serial := serial+inttohex(random(16),1);
end;
2: begin //hex lc
for I := 1 to len do
serial := serial+inttohex(random(16),1);
serial := lowercase(serial);
end;
3: begin //UC A-Z
for I := 1 to len do
serial:=serial+GenerateRandLetter(true);
end;
4: begin //lc a-z
for I := 1 to len do
serial:=serial+GenerateRandLetter(false);
end;
5: begin
for I := 1 to len do
  if random(2)=1 then
  serial:=serial+inttostr(random(10))
  else
  serial:=serial+GenerateRandLetter(true);
end;
6: begin
for I := 1 to len do
  if random(2)=1 then
  serial:=serial+inttostr(random(10))
  else
  serial:=serial+GenerateRandLetter(false);
end;
7:  begin
for I := 1 to len do
  if random(2)=1 then
  serial:=serial+inttostr(random(10))
  else
  if random(2)=1 then
   serial:=serial+GenerateRandLetter(true)
   else
   serial:=serial+GenerateRandLetter(false);
end;
8: Begin
CustomStr:=CustomEditBox.Text;
CSLen:=length(CustomStr);
if CSLen>0 then
for I := 1 to len do
Serial:=Serial+CustomStr[Random(CSLen)+1]
else Begin
  ShowMessage('Custom Character Set is Empty.');
  Exit;
End;

End;
end;
if DashModeBox.Checked=true then begin
try
dashl:=strtoint(DashTextBox.Text);
except
ShowMessage('"'+DashTextBox.Text+'" is an Invalid Dash Location!');
exit;
end;
if dashl>1 then begin
I:=1;
if replaceCheckBox.Checked= true then

repeat
serial[I*dashl]:='-';
inc(I);
until (I*dashl)>len
else
repeat
Insert('-', Serial,(I*dashl));
inc(I);
Inc(len);
until (I*dashl)>len;
end else Begin
  showmessage('Dash Location must be greater than 1!');
  exit;
End;
end;

SerialTextBox.Text:=serial;
end
else
ShowMessage('Length must be greater than 0');
end
else
ShowMessage('Please specify the serial length.');
end
else
ShowMessage('Please choose a character set from the drop down menu.')
end;


procedure TForm1.CopyButtonClick(Sender: TObject);
begin
ClipBoard.AsText:=SerialTextBox.Text;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
if Combobox1.ItemIndex=8 then
CustomEditBox.Enabled:=true
Else
CustomEditBox.Enabled:=False;
end;

procedure TForm1.DashModeBoxClick(Sender: TObject);
begin
if DashModeBox.Checked= true then Begin
DashTextBox.Enabled:=True;
ReplaceCheckBox.Enabled:=True;
End
Else Begin
DashTextBox.Enabled:=False;
ReplaceCheckBox.Enabled:=False;
End;
end;

end.
