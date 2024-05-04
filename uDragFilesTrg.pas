unit uDragFilesTrg;

{
TDragFilesTrg Component
© Angus Johnson
ajohnson@rpi.net.au
Version 1.0
September 1997.

DESCRIPTION: Enables dragging of filesnames FROM Windows Explorer TO your Form.
Single or multiple files can dragged and then acted upon in the OnDrop event.

PUBLISHED PROPERTIES:
  Enabled: boolean;
  Target: TWinControl
PUBLIC PROPERTIES: (not available at design time)
  DropPoint: TPoint
  FileList: Tstrings
METHODS:
  OnDrop: TNotifyEvent

USAGE:
1. Add this non-visual component to the Form you wish to drag TO.
2. Select the Target Component (eg: ListView, Listbox etc.). This
   is the component which will register the Drop Event (ie: the
   cursor changes to a valid drop cursor over this component.)
   Note: It doesn't HAVE to be the component will display the
   dropped files although it does makes more visual sense if it is.
3. Set enabled to true. (Under some situations it is desirable to
   temporarily turn this off. See demo for example.)
4. Assign an OnDrop event (ie: what to do when files are dropped
   on your component). When this event is triggered the files that
   have been dropped are listed in FileList and the DropPoint is
   also assigned.

DISCLAIMER:
This software may be freely used but no guarantees are given
as to reliability. Please keep this header to acknowledge source.
USE AT YOUR OWN RISK.

PROBLEMS/COMMENTS/THANKS ...
ajohnson@rpi.net.au
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ShellApi;

type
  TDragFilesTrg = class(TComponent)
  private
    fEnabled: boolean;
    fTarget: TWinControl;
    fDrop: TNotifyEvent;

    TargetNewWndProc, TargetOldWndProc: pointer;
    procedure WndProc( var Msg: TMessage );
    procedure DropFiles( hDropHandle: HDrop );
  protected
    procedure SetEnabled(Enabl: boolean);
    procedure SetTarget(targ: TWinControl);
    function GetFileCount: integer;
    procedure Notification(comp: TComponent; Operation: TOperation); override;
  public
    DropPoint: TPoint;
    FileList: TStrings;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled: Boolean read fEnabled write SetEnabled;
    property FileCount: Integer read GetFileCount;
    property Target: TWinControl read fTarget write SetTarget;
    property OnDrop: TNotifyEvent read fDrop write fDrop;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('System2', [TDragFilesTrg]);
end;

constructor TDragFilesTrg.Create( AOwner: TComponent );
begin
   inherited Create( AOwner );
   FileList := TStringList.Create;
   TargetNewWndProc := MakeObjectInstance( WndProc );
end;

destructor TDragFilesTrg.Destroy;
begin
  FileList.Free;
  SetEnabled(false);
  {Reverse subclassing}
  if assigned(fTarget) then
    SetWindowLong(fTarget.handle, GWL_WNDPROC, Longint( TargetOldWndProc ));

  FreeObjectInstance(TargetNewWndProc);
  inherited Destroy;
end;

procedure TDragFilesTrg.SetTarget(Targ: TWinControl);
begin
  if fTarget = Targ then exit;

  {Reverse subclassing}
  if assigned(fTarget) then begin
    DragAcceptFiles( fTarget.handle, false );
    SetWindowLong(fTarget.handle, GWL_WNDPROC, Longint( TargetOldWndProc ));
  end;

  fTarget := Targ;
  if not assigned(fTarget) then exit;

  fTarget.FreeNotification(self);

  {Subclass target here}
  TargetOldWndProc := Pointer( GetWindowLong( fTarget.Handle, GWL_WNDPROC ));
  SetWindowLong( fTarget.Handle, GWL_WNDPROC, Longint( TargetNewWndProc ));

  DragAcceptFiles( fTarget.handle, fEnabled );

end;

procedure TDragFilesTrg.WndProc( var Msg: TMessage );
begin
   with Msg do
     if Msg = WM_DROPFILES then
         DropFiles( HDrop( wParam ))
     else
         Result := CallWindowProc( TargetOldWndProc,
                      fTarget.Handle, Msg, WParam, LParam);
end;


procedure TDragFilesTrg.Notification(comp: TComponent; Operation: TOperation);
begin
  inherited Notification(comp, Operation);
  if (comp = fTarget) and (Operation = opRemove) then fTarget := nil;
end;

procedure TDragFilesTrg.SetEnabled(Enabl: boolean);
begin
  fEnabled := Enabl;
  if assigned(fTarget) then
    DragAcceptFiles( fTarget.handle, fEnabled );
end;

function TDragFilesTrg.GetFileCount: integer;
begin
  result := FileList.count;
end;

procedure TDragFilesTrg.DropFiles( hDropHandle: HDrop );
var
  i, num: integer;
  pszFile: array [0..MAX_PATH] of char;
begin

  FileList.Clear;

  num := DragQueryFile( hDropHandle, $FFFFFFFF, pszFile, MAX_PATH);
  DragQueryPoint( hDropHandle, DropPoint );
  for i := 1 to num do begin
   DragQueryFile( hDropHandle, i-1, pszFile, MAX_PATH );
   FileList.Add( StrPas( pszFile ));
  end;

  if Assigned(fDrop) then fDrop(Self);
end;

end.
