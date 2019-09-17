unit kalendar;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    kalendarDBGrid: TDBGrid;
    Button1: TButton;
    FromLabel: TLabel;
    ToLabel: TLabel;
    Memo1: TMemo;
    toDateTimePicker: TDateTimePicker;
    fromDateTimePicker: TDateTimePicker;
    procedure AddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses dtgDM;

{$R *.DFM}

procedure TForm1.AddClick(Sender: TObject);
var
  fromDate,toDate,aDate : TDate;
  numOfDays,i     : Integer;
begin
   toDate := toDateTimePicker.Date;
   fromDate := fromDateTimePicker.Date;
   numOfDays := Trunc(toDate - fromDate);
   //fromDay := LongDayNames[DayOfWeek(fromDate)];
   //toDay := LongDayNames[DayOfWeek(toDate)];
   //ShowMessage(DateToStr(toDate)+ ' is ' + toDay + ' diff is ' + IntToStr(period));
   for i := 0 to numOfDays do
      begin
         with dtgDataModule.kalendarTbl do
           begin
              aDate := fromDate + i;
              Insert;
              FieldByName('Datum').AsDateTime := aDate;
              FieldByName('Den').AsInteger := DayOfWeek(aDate);
              FieldByName('DruhDne').AsInteger := DayOfWeek(aDate) + 1;
              FieldByName('Tyden').AsInteger := DayOfWeek(aDate) + 2;
              Post;
           end;
      end;
end;

end.
