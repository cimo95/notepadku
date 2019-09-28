object f: Tf
  Left = 321
  Top = 244
  Caption = 'Notepadku - Tak Berjudul 1'
  ClientHeight = 396
  ClientWidth = 862
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sb: TStatusBar
    Left = 0
    Top = 377
    Width = 862
    Height = 19
    Panels = <
      item
        Text = 'Baris 1, Kolom 1'
        Width = 50
      end>
  end
  object m: TRichEdit
    Left = 0
    Top = 0
    Width = 862
    Height = 377
    Align = alClient
    BorderStyle = bsNone
    Font.Charset = SHIFTJIS_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    WordWrap = False
    Zoom = 100
    OnChange = mChange
  end
  object mm: TMainMenu
    Left = 200
    Top = 80
    object mi: TMenuItem
      Caption = 'Berkas'
      object mic: TMenuItem
        Caption = 'Baru'
        ShortCut = 16462
        OnClick = micClick
      end
      object mic0: TMenuItem
        Caption = 'Buka...'
        ShortCut = 16463
        OnClick = mic0Click
      end
      object mic1: TMenuItem
        Caption = 'Simpan'
        ShortCut = 16467
        OnClick = mic1Click
      end
      object mic2: TMenuItem
        Caption = 'Simpan Sebagai'
        ShortCut = 49235
        OnClick = mic2Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object mic3: TMenuItem
        Caption = 'Penyetelan halaman'
        OnClick = mic3Click
      end
      object mic4: TMenuItem
        Caption = 'Cetak...'
        ShortCut = 16464
        OnClick = mic4Click
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object mic5: TMenuItem
        Caption = 'Keluar'
        ShortCut = 32883
        OnClick = mic5Click
      end
    end
    object mi0: TMenuItem
      Caption = 'Edit'
      OnClick = mi0Click
      object mi0c: TMenuItem
        Caption = 'Batalkan'
        ShortCut = 16474
        OnClick = mi0cClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object mi0c0: TMenuItem
        Caption = 'Gunting'
        ShortCut = 16472
        OnClick = mi0c0Click
      end
      object mi0c1: TMenuItem
        Caption = 'Salin'
        ShortCut = 16451
        OnClick = mi0c1Click
      end
      object mi0c2: TMenuItem
        Caption = 'Tempel'
        ShortCut = 16470
        OnClick = mi0c2Click
      end
      object mi0c3: TMenuItem
        Caption = 'Hapus'
        ShortCut = 46
        OnClick = mi0c3Click
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object mi0c4: TMenuItem
        Caption = 'Cari dengan Google'
        ShortCut = 16453
        OnClick = mi0c4Click
      end
      object mi0c5: TMenuItem
        Caption = 'Cari dan Ganti'
        ShortCut = 16454
        OnClick = mi0c5Click
      end
      object mi0c6: TMenuItem
        Caption = 'Pergi Ke...'
        ShortCut = 16455
        OnClick = mi0c6Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mi0c7: TMenuItem
        Caption = 'Pilih Semua'
        ShortCut = 16449
        OnClick = mi0c7Click
      end
      object mi0c8: TMenuItem
        Caption = 'Waktu/Tanggal'
        ShortCut = 116
        OnClick = mi0c8Click
      end
    end
    object mi1: TMenuItem
      Caption = 'Format'
      object mi1c: TMenuItem
        Caption = 'Kemas Kata'
        OnClick = mi1cClick
      end
      object mi1c0: TMenuItem
        Caption = 'Fon...'
        OnClick = mi1c0Click
      end
    end
    object mi2: TMenuItem
      Caption = 'Lihat'
      object mi2c: TMenuItem
        Caption = 'Zoom'
        object mi2cs: TMenuItem
          Caption = 'Perbesar Tampilan'
          ShortCut = 16491
          OnClick = mi2csClick
        end
        object mi2cs0: TMenuItem
          Caption = 'Perkecil Tampilan'
          ShortCut = 16493
          OnClick = mi2cs0Click
        end
        object mi2cs1: TMenuItem
          Caption = 'Kembalikan Zoom Default'
          ShortCut = 16480
          OnClick = mi2cs1Click
        end
      end
      object mi2c0: TMenuItem
        Caption = 'Bilah Status'
        Checked = True
        OnClick = mi2c0Click
      end
    end
    object mi3: TMenuItem
      Caption = 'Bantuan'
      object mi3c: TMenuItem
        Caption = 'Tentang Notepadku'
        ShortCut = 112
        OnClick = mi3cClick
      end
    end
  end
  object od: TOpenDialog
    Filter = 
      'Semua Berkas Yang Didukung|*.txt;*.text;*.rtf|Berkas Teks|*.txt;' +
      '*.text|Berkas Rich Text|*.rtf'
    Title = 'Buka Berkas'
    Left = 200
    Top = 24
  end
  object sd: TSaveDialog
    Filter = 'Berkas Teks|*.txt|Berkas Rich Text|*.rtf|Berkas Buku|*.buku'
    Title = 'Simpan Berkas'
    Left = 232
    Top = 24
  end
  object fd: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 272
    Top = 24
  end
  object rd: TReplaceDialog
    OnFind = rdFind
    OnReplace = rdReplace
    Left = 232
    Top = 80
  end
  object pd: TPrintDialog
    Options = [poSelection, poWarning, poDisablePrintToFile]
    Left = 272
    Top = 80
  end
  object td: TTaskDialog
    Buttons = <>
    Caption = 'Tentang Notepadku'
    CommonButtons = [tcbClose]
    ExpandButtonCaption = 'Proyek kami yang lain'
    ExpandedText = 
      'Layanan :'#13#10'TranSub Subtitle Translator : https://transub.cimosof' +
      't.com'#13#10'TranPas Desktop Translator : https://tranpas.cimosoft.com' +
      #13#10#13#10'Produk:'#13#10'SanCaes Simple string encrypt-decrypt : https://san' +
      'caes.cimosoft.com'#13#10'BelBD7 Bel Sekolah Anti Ribet : https://belse' +
      'kolah.cimosoft.com'#13#10'Project Misha Rem'#39'Py Translator : -on goning' +
      ', pm for info-'#13#10#13#10'Hiburan :'#13#10'Doki-Doki Ekskul Sastra : https://d' +
      'dlcid.cimosoft.com'#13#10'Katawa Shoujo Bahasa Indonesia : https://ksi' +
      'd.cimosoft.com'#13#10'Ojamajo DoReMi Bahasa Indonesia : https://doremi' +
      '.cimosoft.com'#13#10'Anitsu Anime Word Guessing Game : http://anitsu.c' +
      'imosoft.com'
    Flags = [tfEnableHyperlinks, tfExpandFooterArea]
    FooterIcon = 4
    FooterText = 'Versi 3.0 (Build:'#8237'13416D0'#8236')'
    RadioButtons = <>
    Text = 
      'Notepadku adalah sebuah proyek DIY (do-it-yourself) untuk para p' +
      'rogrammer Delphi, yang ingin membuat aplikasi Notepad-nya sendir' +
      'i'#13#10'Notepadku dibuat mengacu pada Notepad di Windows 10 Build 190' +
      '3'#13#10#13#10'Proyek ini dibuat oleh : Arachmadi Putra Pambudi'#13#10'Hak Cipta' +
      ' '#169' 2019 Cimosoft Codelicious, Org'
    Title = 'Notepadku'
    Left = 312
    Top = 48
  end
end
