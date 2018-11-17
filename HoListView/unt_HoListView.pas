unit unt_HoListView;

interface

uses
  unt_SortBitmap, unt_const, 

  Windows, Messages, Classes, ComCtrls, CommCtrl, ExtCtrls;

type
  THoListView = class(TListView)
  private
    F_SortBy: TSortBy;
    F_HeaderHandle: HWND;
    F_SortedColumn: integer;
    F_SortBitmap: TSortBitmap;
    function ValidHeaderHandle: Boolean;
    procedure WMParentNotify(var Message: TWMParentNotify); message WM_PARENTNOTIFY;
    procedure WMNotify(var Message: TWMNotify); message WM_NOTIFY;
  protected
    procedure L_SetSortColumn(Value: Integer); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy(); override;
    
    property R_SortBy: TSortBy read F_SortBy;
    property R_SortedColumn: Integer read F_SortedColumn write L_SetSortColumn default -1;
  end;

function IsXPTheme: Boolean;
procedure Register;

implementation

uses
  SysUtils;

function IsXPTheme: Boolean;
begin
  Result := GetFileVersion(comctl32) >= ComCtlVersionIE6;
end;

procedure Register;
begin
  RegisterComponents('Samples', [THoListView]);
end;

{ THoListView }

constructor THoListView.Create(AOwner: TComponent);
begin
  inherited;
  F_SortedColumn := -1;
  F_SortBy := sbNone;
  F_SortBitmap := TSortBitmap.Create;
end;

destructor THoListView.Destroy;
begin
  F_SortBitmap.Free; // 2015-06-14 add liqj
  inherited;
end;

procedure THoListView.L_SetSortColumn(Value: Integer);
var
  hdi: THDItem;
begin
  FillChar(hdi, SizeOf(hdi), 0);
  //IE6 or later
  if IsXPTheme then
  begin
    hdi.Mask := HDI_FORMAT;
    if F_SortedColumn = Value then
    begin
      //如果上一次排序的字段与本次的字段相同，那么改变排列方向
      if F_SortedColumn >= 0 then
      begin
        //排序已开始
        Header_GetItem(F_HeaderHandle, F_SortedColumn, hdi);
        case F_SortBy of
          sbDesc, sbNone:
            begin
              hdi.fmt := hdi.fmt and not HDF_SORTDOWN or HDF_SORTUP;
              F_SortBy := sbAsc;
            end;
          sbAsc:
            begin
              hdi.fmt := hdi.fmt and not HDF_SORTUP or HDF_SORTDOWN;
              F_SortBy := sbDesc;
            end;
        end;
        Header_SetItem(F_HeaderHandle, F_SortedColumn, hdi);
      end;
    end
    else begin
      //如果上一次排序的字段与本次的字段不相同，
      //  那么先清除上一字段标题的箭头，然后再置本次字段标题的箭头
      if F_SortedColumn >= 0 then
      begin
        Header_GetItem(F_HeaderHandle, F_SortedColumn, hdi);
        hdi.fmt := hdi.fmt and not HDF_SORTDOWN and not HDF_SORTUP;
        F_SortBy := sbNone;
        Header_SetItem(F_HeaderHandle, F_SortedColumn, hdi);
      end;
      F_SortedColumn := Value;
      if F_SortedColumn >= 0 then
      begin
        Header_GetItem(F_HeaderHandle, F_SortedColumn, hdi);
        hdi.fmt := hdi.fmt and not HDF_SORTDOWN or HDF_SORTUP;
        F_SortBy := sbAsc;
        Header_SetItem(F_HeaderHandle, F_SortedColumn, hdi);
      end;
    end;
  end
  //IE5 or earlier
  else begin
    if F_SortedColumn = Value then
    begin
      //如果上一次排序的字段与本次的字段相同，那么改变排列方向
      if F_SortedColumn >= 0 then
      begin
        case F_SortBy of
          sbDesc, sbNone:
            begin
              F_SortBy := sbAsc;
              F_SortBitmap.R_SortBy := sbAsc;
            end;
          sbAsc:
            begin
              F_SortBy := sbDesc;
              F_SortBitmap.R_SortBy := sbDesc;
            end;
        end;
        hdi.Mask := HDI_FORMAT;
        Header_GetItem(F_HeaderHandle, F_SortedColumn, hdi);
        hdi.Mask := HDI_FORMAT or HDI_BITMAP;
        hdi.fmt := hdi.fmt or HDF_BITMAP or HDF_BITMAP_ON_RIGHT;
        hdi.hbm := F_SortBitmap.R_Handle;
        Header_SetItem(F_HeaderHandle, F_SortedColumn, hdi);
      end;
    end
    else begin
      //如果上一次排序的字段与本次的字段不相同，
      //  那么先清除上一字段标题的箭头，然后再置本次字段标题的箭头
      if F_SortedColumn >= 0 then
      begin
        F_SortBitmap.R_SortBy := sbNone;
        F_SortBy := sbNone;
        hdi.Mask := HDI_FORMAT;
        Header_GetItem(F_HeaderHandle, F_SortedColumn, hdi);
        hdi.Mask := HDI_FORMAT or HDI_BITMAP;
        hdi.fmt := hdi.fmt and not HDF_BITMAP;
        hdi.hbm := 0;
        Header_SetItem(F_HeaderHandle, F_SortedColumn, hdi);
      end;
      F_SortedColumn := Value;
      if F_SortedColumn >= 0 then
      begin
        F_SortBitmap.R_SortBy := sbAsc;
        F_SortBy := sbAsc;
        hdi.Mask := HDI_FORMAT;
        Header_GetItem(F_HeaderHandle, F_SortedColumn, hdi);
        hdi.Mask := HDI_FORMAT or HDI_BITMAP;
        hdi.fmt := hdi.fmt or HDF_BITMAP or HDF_BITMAP_ON_RIGHT;
        hdi.hbm := F_SortBitmap.R_Handle;
        Header_SetItem(F_HeaderHandle, F_SortedColumn, hdi);
      end;
    end;
  end; end;

function THoListView.ValidHeaderHandle: Boolean;
begin
  Result := F_HeaderHandle <> 0;
end;

procedure THoListView.WMNotify(var Message: TWMNotify);
begin
  if ValidHeaderHandle and (Message.NMHdr^.hWndFrom = F_HeaderHandle) then
    with Message.NMHdr^ do
      case code of
        //2009.06.25  , HDN_ITEMCLICKW # 2017-02-18 liqj xe7时 HDN_ITEMCLICKW 与 HDN_ITEMCLICK 是相同值，所以只需要使用一个.
        HDN_ITEMCLICK:
          L_SetSortColumn(PHDNotify(Message.NMHdr)^.Item);
      end;
  inherited;
end;

procedure THoListView.WMParentNotify(var Message: TWMParentNotify);
begin
  with Message do
    if (Event = WM_CREATE) and (F_HeaderHandle = 0) then
    begin
      F_HeaderHandle := ChildWnd;
//      FDefHeaderProc := Pointer(GetWindowLong(F_HeaderHandle, GWL_WNDPROC));
//      SetWindowLong(F_HeaderHandle, GWL_WNDPROC, LongInt(FHeaderInstance));
    end;
  inherited;
end;

end.

