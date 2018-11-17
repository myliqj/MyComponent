unit unt_const;

interface

uses
  Windows;
  
const
  HDF_SORTNONE = $0000;
  HDF_SORTDOWN = $0200;
  HDF_SORTUP = $0400;

  lfMarlett: LOGFONT =
    (lfHeight: -15;
     lfWidth: 0;
     lfEscapement: 0;
     lfOrientation: 0;
     lfWeight: FW_MEDIUM;
     lfItalic: 0;
     lfUnderline: 0;
     lfStrikeOut: 0;
     lfCharSet: SYMBOL_CHARSET; 
     lfOutPrecision: OUT_STROKE_PRECIS;
     lfClipPrecision: CLIP_STROKE_PRECIS;
     lfQuality: DRAFT_QUALITY;
     lfPitchAndFamily: VARIABLE_PITCH + FF_DONTCARE;
     lfFaceName: 'Marlett');

type

  TSortBy = (sbDesc = HDF_SORTDOWN, sbNone = HDF_SORTNONE, sbAsc = HDF_SORTUP);

implementation

end.
