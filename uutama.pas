unit uutama;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ShellAPI, FileCtrl, XPMan, ComCtrls, StdCtrls, Menus, RichEdit,
  inifiles, Vcl.ExtCtrls, clipbrd;

type
  Tf = class(TForm)
    fd: TFontDialog;
    m: TRichEdit;
    mi: TMenuItem;
    mic: TMenuItem;
    mic0: TMenuItem;
    mic1: TMenuItem;
    mic2: TMenuItem;
    mic5: TMenuItem;
    mi0: TMenuItem;
    mi0c: TMenuItem;
    mi0c0: TMenuItem;
    mi0c1: TMenuItem;
    mi0c2: TMenuItem;
    mi0c3: TMenuItem;
    mi0c7: TMenuItem;
    mi0c5: TMenuItem;
    mi1: TMenuItem;
    mi1c: TMenuItem;
    mi1c0: TMenuItem;
    mi2: TMenuItem;
    mi2c0: TMenuItem;
    mi3: TMenuItem;
    mi3c: TMenuItem;
    mm: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    od: TOpenDialog;
    rd: TReplaceDialog;
    sb: TStatusBar;
    sd: TSaveDialog;
    mi0c4: TMenuItem;
    N4: TMenuItem;
    mi0c6: TMenuItem;
    mi0c8: TMenuItem;
    mi2c: TMenuItem;
    mi2cs: TMenuItem;
    mi2cs0: TMenuItem;
    mi2cs1: TMenuItem;
    N5: TMenuItem;
    mic3: TMenuItem;
    mic4: TMenuItem;
    pd: TPrintDialog;
    td: TTaskDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure mChange(Sender: TObject);
    procedure micClick(Sender: TObject);
    procedure mic0Click(Sender: TObject);
    procedure mic1Click(Sender: TObject);
    procedure mic2Click(Sender: TObject);
    procedure mic5Click(Sender: TObject);
    procedure mi0c0Click(Sender: TObject);
    procedure mi0c1Click(Sender: TObject);
    procedure mi0c2Click(Sender: TObject);
    procedure mi0c3Click(Sender: TObject);
    procedure mi0c7Click(Sender: TObject);
    procedure mi0c5Click(Sender: TObject);
    procedure mi0cClick(Sender: TObject);
    procedure mi1c0Click(Sender: TObject);
    procedure mi1cClick(Sender: TObject);
    procedure mi2c0Click(Sender: TObject);
    procedure mi3cClick(Sender: TObject);
    procedure rdFind(Sender: TObject);
    procedure rdReplace(Sender: TObject);
    procedure mic4Click(Sender: TObject);
    procedure mic3Click(Sender: TObject);
    procedure mi0Click(Sender: TObject);
    procedure mi0c4Click(Sender: TObject);
    procedure mi0c6Click(Sender: TObject);
    procedure mi0c8Click(Sender: TObject);
    procedure mi2csClick(Sender: TObject);
    procedure mi2cs0Click(Sender: TObject);
    procedure mi2cs1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Deklarasi hanya untuk penggunaan dalam unit ini saja }
  public
    { Deklarasi untuk penggunaan ke semua unit yang terintegerasi }
    iBaru, iHalaman, iZoomFont, iDefZoomFont: integer;
    bSimpan, bStatus: Boolean;
    sBerkas, sPathAkhir, sFolderTemp: string;
  end;

var
  f: Tf;

implementation

{$R *.dfm} //template tweaked by : Araachmadi Putra Pambudi

procedure pKillBS(kill: Boolean);
begin
  with f do
  begin
    mi2c0.Enabled := not kill;
    if kill then
    begin
      bStatus := sb.Visible;
      sb.Hide;
    end
    else
      sb.Visible := bStatus;
  end;
end;

procedure pBacaKonfig;
var
  tif: tinifile;
begin
  with f do
  begin
    if not FileExists(ChangeFileExt(Application.ExeName, '.itu')) then
      Exit
    else
    begin
      tif := tinifile.Create(ChangeFileExt(Application.ExeName, '.itu'));
      fd.Font.Name := tif.ReadString('konfigurasi', 'nama', 'Courier New');
      fd.Font.Size := tif.ReadInteger('konfigurasi', 'ukuran', 8);
      fd.Font.Color := tif.ReadInteger('konfigurasi', 'warna', clBlack);
      if tif.ReadBool('konfigurasi', 'mtebal', true) then
        fd.Font.Style := fd.Font.Style + [fsBold];
      if tif.ReadBool('konfigurasi', 'mmiring', true) then
        fd.Font.Style := fd.Font.Style + [fsitalic];
      if tif.ReadBool('konfigurasi', 'mgb', true) then
        fd.Font.Style := fd.Font.Style + [fsUnderline];
      if tif.ReadBool('konfigurasi', 'mgc', true) then
        fd.Font.Style := fd.Font.Style + [fsStrikeOut];
      m.Font := fd.Font;
      if tif.ValueExists('konfigurasi', 'mzoom') then
        m.Font.Size := tif.ReadInteger('konfigurasi', 'mzoom', fd.Font.Size);
      if DirectoryExists(tif.ReadString('konfigurasi', 'terakhir', '')) then
        spathAkhir := tif.ReadString('konfigurasi', 'terakhir', '');
      tif.Free;
    end;
  end;
end;

procedure pTulisKonfig;
var
  tif: tinifile;
begin
  with f do
  begin
    tif := tinifile.Create(ChangeFileExt(Application.ExeName, '.itu'));
    tif.WriteString('konfigurasi', 'nama', fd.Font.Name);
    tif.WriteInteger('konfigurasi', 'ukuran', fd.Font.Size);
    tif.WriteInteger('konfigurasi', 'warna', fd.Font.Color);
    tif.WriteBool('konfigurasi', 'mtebal', (fd.Font.Style = [fsBold]));
    tif.WriteBool('konfigurasi', 'mmiring', (fd.Font.Style = [fsItalic]));
    tif.WriteBool('konfigurasi', 'mgb', (fd.Font.Style = [fsUnderline]));
    tif.WriteBool('konfigurasi', 'mgc', (fd.Font.Style = [fsStrikeOut]));
    if iZoomFont = iDefZoomFont then
      tif.DeleteKey('konfigurasi', 'mzoom')
    else
      tif.WriteInteger('konfigurasi', 'mzoom', iZoomFont);
    tif.WriteString('konfigurasi', 'terakhir', sPathAkhir);
    tif.Free;
  end;
end;

procedure Tf.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not bSimpan then
  begin
    CanClose := false;
    case messagebox(Handle, PChar('Anda ingin menyimpan perubahan ke ' + sBerkas + '?'), 'Menutup Notepadku', MB_YESNOCANCEL + 32) of
      mrno:
        CanClose := True;
      mryes:
        mic1.Click;
      mrcancel:
        CanClose := False;
    end;
  end;
end;

procedure Tf.FormCreate(Sender: TObject);
var
  tif: TIniFile;
begin
  if iBaru <= 0 then
    iBaru := 1
  else
    Inc(iBaru);
  Caption := 'Notepadku - Tak Berjudul ' + inttostr(iBaru);
  bSimpan := True;
  bStatus := True;
  sBerkas := 'Tak Berjudul ' + IntToStr(iBaru);
  m.Clear;
  pBacaKonfig;
end;

procedure Tf.mChange(Sender: TObject);
begin
  bSimpan := false;
  sb.Panels.Items[0].Text := 'Baris ' + inttostr(SendMessage(m.Handle, EM_EXLINEFROMCHAR, 0, m.SelStart + m.SelLength) + 1) + ', Kolom ' + inttostr(m.SelStart + m.SelLength - SendMessage(m.Handle, EM_LINEINDEX, -1, 0) + 1);
end;

procedure Tf.micClick(Sender: TObject);
begin
  if not bSimpan then
  begin
    if MessageBox(Handle, 'Perubahan terakhir belum tersimpan, apakah anda ingin melanjutkan membuat berkas baru ?', 'Baru', 32 + 4) = mrno then
      Exit
    else
      FormCreate(Sender);
  end
  else
    FormCreate(Sender);
end;

procedure Tf.mic0Click(Sender: TObject);
begin
  if not od.Execute then
    Exit
  else
  begin
    m.Lines.LoadFromFile(od.FileName);
    Caption := 'Notepadku - ' + ExtractFileName(od.FileName);
    bSimpan := True;
    sBerkas := od.FileName;
    sPathAkhir := ExtractFilePath(od.FileName);
  end;
end;

procedure Tf.mic1Click(Sender: TObject);
begin
  if FileExists(sBerkas) then
  begin
    m.Lines.SaveToFile(sBerkas);
    bSimpan := True;
  end
  else
    mic2.Click;
end;

procedure Tf.mic2Click(Sender: TObject);
begin
  if not sd.Execute then
    Exit
  else
  begin
    sd.Title := 'Simpan Sebagai';
    sd.FileName := sBerkas;
    sd.Filter := 'Berkas Teks|*.txt|Berkas Rich Text|*.rtf|Berkas Lain|*.*';
    case sd.FilterIndex of
      0:
        begin
          m.PlainText := True;
          m.Lines.SaveToFile(ChangeFileExt(sd.FileName, '.txt'));
          Caption := 'Notepadku - ' + ExtractFileName(ChangeFileExt(sd.FileName, '.txt'));
        end;
      1:
        begin
          m.Lines.SaveToFile(ChangeFileExt(sd.FileName, '.rtf'));
          Caption := 'Notepadku - ' + ExtractFileName(ChangeFileExt(sd.FileName, '.rtf'));
        end;
      2:
        begin
          m.PlainText := True;
          m.Lines.SaveToFile(sd.FileName);
          Caption := 'Notepadku - ' + ExtractFileName(sd.FileName);
        end;
    end;
    m.PlainText := False;
    bSimpan := True;
  end;
end;

procedure Tf.mic3Click(Sender: TObject);
begin
  pd.Execute;
end;

procedure Tf.mic4Click(Sender: TObject);
begin
  m.Print(m.Text);
end;

procedure Tf.mic5Click(Sender: TObject);
begin
  if bSimpan then
    Application.Terminate
  else
  begin
    if MessageBox(handle, 'Perubahan terakhir belum disimpan, apakah anda ingin keluar dari aplikasi ?', 'Keluar', 32 + 4) = mrNo then
      Exit
    else
      Application.Terminate;
  end;
end;

procedure Tf.mi3cClick(Sender: TObject);
begin
  td.Execute;
end;

procedure Tf.mi2c0Click(Sender: TObject);
begin
  mi2c.Checked := not mi2c.Checked;
  sb.Visible := mi2c.Checked;
end;

procedure Tf.mi2cs0Click(Sender: TObject);
begin
  Dec(iZoomFont);
  m.Font.Size := iZoomFont;
end;

procedure Tf.mi2cs1Click(Sender: TObject);
begin
  m.Font.Size := iDefZoomFont;
end;

procedure Tf.mi2csClick(Sender: TObject);
begin
  Inc(iZoomFont);
  m.Font.Size := iZoomFont;
end;

procedure Tf.mi1cClick(Sender: TObject);
begin
  mi1c.Checked := not mi1c.Checked;
  m.WordWrap := mi1c.Checked;
  pKillBS(mi1c.Checked);
end;

procedure Tf.mi1c0Click(Sender: TObject);
begin
  fd.Font := m.Font;
  if not fd.Execute then
    Exit
  else
  begin
    m.Font := fd.Font;
    iZoomFont := fd.Font.Size;
    iDefZoomFont := fd.Font.Size;
  end;
end;

procedure Tf.mi0cClick(Sender: TObject);
begin
  m.Undo;
end;

procedure Tf.mi0Click(Sender: TObject);
begin
  mi0c.Enabled := m.Perform(EM_CANUNDO, 0, 0) <> 0;
  mi0c0.Enabled := m.SelLength <> 0;
  mi0c1.Enabled := m.SelLength <> 0;
  mi0c2.Enabled := Clipboard.HasFormat(CF_TEXT) or Clipboard.HasFormat(CF_UNICODETEXT);
  mi0c3.Enabled := m.SelLength <> 0;
  mi0c5.Enabled := Length(m.Text) <> 0;
  mi0c6.Enabled := m.Lines.Count > 1;
  mi0c7.Enabled := Length(m.Text) <> 0;
end;

procedure Tf.mi0c0Click(Sender: TObject);
begin
  if m.SelLength < 1 then
    MessageBox(Handle, 'Pilih teks yang ingin anda potong', 'Potong', 16)
  else
    m.CutToClipboard;
end;

procedure Tf.mi0c1Click(Sender: TObject);
begin
  if m.SelLength < 1 then
    MessageBox(Handle, 'Pilih teks yang ingin anda salin', 'Salin', 16)
  else
    m.CopyToClipboard;
end;

procedure Tf.mi0c2Click(Sender: TObject);
begin
  m.PasteFromClipboard;
end;

procedure Tf.mi0c3Click(Sender: TObject);
begin
  if m.SelLength < 1 then
    MessageBox(Handle, 'Pilih teks yang ingin anda hapus', 'Hapus', 16)
  else
    m.SelText := '';
end;

procedure Tf.mi0c4Click(Sender: TObject);
begin
  if m.SelLength = 0 then
    ShellExecute(0, 'open', 'https://google.com/', nil, nil, SW_SHOW)
  else
    ShellExecute(0, 'open', pchar('https://google.com/search?q=' + m.SelText), nil, nil, SW_SHOW);
end;

procedure Tf.mi0c7Click(Sender: TObject);
begin
  m.SelectAll;
end;

procedure Tf.mi0c8Click(Sender: TObject);
var
  tre: TRichEdit;

  procedure pStrClip(StrValue: string);
  var
    A: array[0..255] of char;
  begin
    StrPCopy(A, StrValue);
    Clipboard.SetTextBuf(A);
  end;

begin
  try
    tre := TRichEdit.Create(nil);
    tre.Hide;
    tre.Parent := f;
    tre.PasteFromClipboard;
    pStrClip(FormatDateTime('hh:mm dd/mm/yyyy', now));
    m.PasteFromClipboard;
    tre.SelectAll;
    tre.CopyToClipboard;
  finally
    tre.Free;
  end;
end;

procedure Tf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  pTulisKonfig;
end;

procedure Tf.mi0c5Click(Sender: TObject);
begin
  rd.Position := Point(m.Left + m.Width, m.Top);
  rd.Execute;
end;

procedure Tf.mi0c6Click(Sender: TObject);
var
  s: string;
  i: integer;
begin
  s := '1';
  if InputQuery('Pergi Ke...', 'Isikan baris yang dituju (Maks.' + inttostr(m.Lines.Count) + ')', s) then
  begin
    try
      i := strtoint(s);
      if i < 1 then
        i := 1;
      if i > m.Lines.Count then
        i := m.Lines.Count;
      m.SelStart := m.Perform(EM_LINEINDEX, i - 1, 0);
      m.SelLength := 0;
    except
      MessageBox(Handle, pchar('Masukkan angka dengan benar'), 'Pergi Ke...', 16);
    end;
  end;
end;

procedure Tf.rdFind(Sender: TObject);
label
  A;
var
  FoundAt: LongInt;
  StartPos, ToEnd: Integer;
begin
  with m do
  begin
A:
    if SelLength <> 0 then
      StartPos := SelStart + SelLength
    else
      StartPos := 0;
    ToEnd := Length(Text) - StartPos;
    FoundAt := FindText(rd.FindText, StartPos, ToEnd, [stMatchCase]);
    if FoundAt <> -1 then
    begin
      SetFocus;
      SelStart := FoundAt;
      SelLength := Length(rd.FindText);
    end;
  end;
end;

procedure Tf.rdReplace(Sender: TObject);
var
  SelPos: Integer;
begin
  with TReplaceDialog(Sender) do
  begin
    SelPos := Pos(FindText, m.Lines.Text);
    if SelPos > 0 then
    begin
      m.SelStart := SelPos - 1;
      m.SelLength := Length(FindText);
      m.SelText := ReplaceText;
    end
    else
      MessageDlg(Concat('Could not find "', FindText, '" in m.'), mtError, [mbOk], 0);
  end;
end;

end.

