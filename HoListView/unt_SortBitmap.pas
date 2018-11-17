unit unt_SortBitmap;

interface

uses
  unt_const,
  
  Windows;

type
  TSortBitmap = class(TObject)
  private
    F_Width: Integer;
    F_Height: Integer;
    F_Handle: HBITMAP;
    F_SortBy: TSortBy;
  protected
    procedure SetSortBy(Value: TSortBy);
  public
    constructor Create;
    destructor Destroy; override;
    property R_Handle: HBITMAP read F_Handle;
    property R_SortBy: TSortBy read F_SortBy write SetSortBy;
  end;

implementation

uses
  Types;

{ TSortBitmap }

constructor TSortBitmap.Create;
var
  hdcScr, hdcMem: HDC;
  hbmpOld: HBITMAP;
begin
  F_Width := 16;
  F_Height := 16;
  F_SortBy := sbNone;
  hdcScr := GetDC(0);
  F_Handle := CreateCompatibleBitmap(hdcScr, F_Width, F_Height);
  ReleaseDC(0, hdcScr);
  hdcMem := CreateCompatibleDC(0);
  hbmpOld := SelectObject(hdcMem, F_Handle);
  FillRect(hdcMem, Rect(0, 0, F_Width, F_Height), COLOR_BTNFACE + 1);
  SelectObject(hdcMem, hbmpOld);
  DeleteDC(hdcMem);
end;

destructor TSortBitmap.Destroy;
begin
  DeleteObject(F_Handle);
  inherited;
end;

procedure TSortBitmap.SetSortBy(Value: TSortBy);
var
  hdcMem: HDC;
  hbmpOld: HBITMAP;
  rct: TRect;
  hfntNew, hfntOld: HFONT;
begin
  if F_SortBy <> Value then
  begin
    F_SortBy := Value;
    hdcMem := CreateCompatibleDC(0);
    hbmpOld := SelectObject(hdcMem, F_Handle);
    rct := Rect(0, 0, F_Width, F_Height);
    FillRect(hdcMem, rct, COLOR_BTNFACE + 1);
    SetTextColor(hdcMem, GetSysColor(COLOR_GRAYTEXT));
    SetBkMode(hdcMem, TRANSPARENT);
    if F_SortBy <> sbNone then
    begin
      hfntNew := CreateFontIndirect(lfMarlett);
      hfntOld := SelectObject(hdcMem, hfntNew); //设定字体            
      if F_SortBy = sbAsc then
        DrawText(hdcMem, '5', 1, rct, DT_CENTER + DT_TOP)  //上箭头，因指定了使用图形字体，若改为GB2312_CHARSET则显示字符'5'
      else
        DrawText(hdcMem, '6', 1, rct, DT_CENTER + DT_TOP); //下箭头
      SelectObject(hdcMem, hfntOld);
      DeleteObject(hfntNew);
    end;
    SelectObject(hdcMem, hbmpOld);
    DeleteDC(hdcMem);
  end;
end;

end.
