unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.StdCtrls;

type
  TgameBoard = array[1..9, 1..9] of String;
  TMainForm = class(TForm)
    boardUI: TStringGrid;
    btnReset: TBitBtn;
    btnSetQ: TBitBtn;
    BtnShowAns: TBitBtn;
    BtnNewGame: TBitBtn;
    LBTitle: TLabel;
    BtnExit: TBitBtn;
    Image1: TImage;
    procedure BtnExitClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure printBoard(board: TgameBoard);
    procedure btnSetQClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure BtnNewGameClick(Sender: TObject);
    procedure BtnShowAnsClick(Sender: TObject);
    procedure boardUIDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
    procedure boardUIGetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

  gameBoard: TgameBoard;              //gameBoard[row, col]

  gameBoard1: TgameBoard = (('-', '-', '-', '-', '-', '-', '-', '-', '-'),
                            ('-', '-', '-', '-', '-', '-', '-', '-', '-'),
                            ('-', '-', '-', '-', '-', '-', '-', '-', '-'),

                            ('-', '-', '-', '-', '-', '-', '-', '-', '-'),
                            ('-', '-', '-', '-', '-', '-', '-', '-', '-'),
                            ('-', '-', '-', '-', '-', '-', '-', '-', '-'),

                            ('-', '-', '-', '-', '-', '-', '-', '-', '-'),
                            ('-', '-', '-', '-', '-', '-', '-', '-', '-'),
                            ('-', '-', '-', '-', '-', '-', '-', '-', '-'));

  gameBoard2: TgameBoard = (('9', '-', '-', '8', '3', '-', '-', '6', '-'),
                            ('-', '8', '7', '-', '-', '1', '-', '2', '-'),
                            ('1', '6', '-', '7', '9', '4', '-', '-', '-'),

                            ('-', '-', '3', '-', '7', '-', '5', '8', '-'),
                            ('-', '-', '-', '-', '4', '-', '-', '-', '-'),
                            ('-', '2', '1', '-', '5', '-', '9', '-', '-'),

                            ('-', '-', '-', '4', '1', '6', '-', '9', '8'),
                            ('-', '3', '-', '9', '-', '-', '2', '5', '-'),
                            ('-', '1', '-', '-', '2', '5', '-', '-', '4'));

  gameBoard3: TgameBoard = (('1', '-', '-', '8', '-', '-', '6', '5', '-'),
                            ('-', '-', '-', '9', '1', '-', '-', '2', '-'),
                            ('-', '8', '-', '-', '5', '-', '7', '-', '9'),

                            ('-', '-', '-', '-', '-', '-', '-', '9', '-'),
                            ('-', '5', '3', '-', '4', '-', '1', '7', '-'),
                            ('-', '4', '-', '-', '-', '-', '-', '-', '-'),

                            ('5', '-', '2', '-', '9', '-', '-', '3', '-'),
                            ('-', '9', '-', '-', '7', '5', '-', '-', '-'),
                            ('-', '7', '6', '-', '-', '2', '-', '-', '5'));

  gameBoard4: TgameBoard = (('7', '9', '-', '-', '-', '-', '3', '-', '-'),
                            ('-', '-', '-', '-', '-', '6', '9', '-', '-'),
                            ('8', '-', '-', '-', '3', '-', '-', '7', '6'),

                            ('-', '-', '-', '-', '-', '5', '-', '-', '2'),
                            ('-', '-', '5', '4', '1', '8', '7', '-', '-'),
                            ('4', '-', '-', '7', '-', '-', '-', '-', '-'),

                            ('6', '1', '-', '-', '9', '-', '-', '-', '8'),
                            ('-', '-', '2', '3', '-', '-', '-', '-', '-'),
                            ('-', '-', '9', '-', '-', '-', '-', '5', '4'));

  gameBoard5: TgameBoard = (('-', '-', '9', '7', '4', '8', '-', '-', '-'),
                            ('7', '-', '-', '-', '-', '-', '-', '-', '-'),
                            ('-', '2', '-', '1', '-', '9', '-', '-', '-'),

                            ('-', '-', '7', '-', '-', '-', '2', '4', '-'),
                            ('-', '6', '4', '-', '1', '-', '5', '9', '-'),
                            ('-', '9', '8', '-', '-', '-', '3', '-', '-'),

                            ('-', '-', '-', '8', '-', '3', '-', '2', '-'),
                            ('-', '-', '-', '-', '-', '-', '-', '-', '6'),
                            ('-', '-', '-', '2', '7', '5', '9', '-', '-'));

  gameBoard6: TgameBoard = (('-', '-', '-', '-', '-', '-', '-', '-', '-'),
                            ('-', '-', '-', '-', '-', '3', '-', '8', '5'),
                            ('-', '-', '1', '-', '2', '-', '-', '-', '-'),

                            ('-', '-', '-', '5', '-', '7', '-', '-', '-'),
                            ('-', '-', '4', '-', '-', '-', '1', '-', '-'),
                            ('-', '9', '-', '-', '-', '-', '-', '-', '-'),

                            ('5', '-', '-', '-', '-', '-', '-', '7', '3'),
                            ('-', '-', '2', '-', '1', '-', '-', '-', '-'),
                            ('-', '-', '-', '-', '4', '-', '-', '-', '9'));

  gameBoard7: TgameBoard = (('5', '3', '-', '-', '7', '-', '-', '-', '-'),
                            ('6', '-', '-', '1', '9', '5', '-', '-', '-'),
                            ('-', '9', '8', '-', '-', '-', '-', '6', '-'),

                            ('8', '-', '-', '-', '6', '-', '-', '-', '3'),
                            ('4', '-', '-', '8', '-', '3', '-', '-', '1'),
                            ('7', '-', '-', '-', '2', '-', '-', '-', '6'),

                            ('-', '6', '-', '-', '-', '-', '2', '8', '-'),
                            ('-', '-', '-', '4', '1', '9', '-', '-', '5'),
                            ('-', '-', '-', '-', '8', '-', '-', '7', '9'));

function findAnswer(board: TgameBoard): TgameBoard; Forward;
function checkValid(board: TgameBoard; row, col: Integer; val: Char): Boolean; Forward;
function bruteForce(var board: TgameBoard; row, col: Integer): TgameBoard; Forward;
function endGame(board: TgameBoard): Boolean; Forward;
implementation

{$R *.dfm}

//Check end game status
function endGame(board: TgameBoard): Boolean;
var
  val: String;
begin
  for val in board do
    if val[1] = '-' then Exit(false);
  Result := true;
end;

//Use to find the final answer of the puzzle
function findAnswer(board: TgameBoard): TgameBoard;
var
  row, col: Integer;
begin
  row := 1;
  col := 1;
  while board[row, col][1] <> '-' do begin
    if (col = 9) and (row = 9) then
      Exit(board)
    else if col = 9 then begin
      row := row + 1;
      col := 1;
    end else
      col := col + 1;
  end;
  Result := bruteForce(board, row, col);
end;

function bruteForce(var board: TgameBoard; row, col: Integer): TgameBoard;
var
  i, nextRow, nextCol: Integer;
  isNoValid: Boolean;
begin
  for i := 9 downto 1 do begin
    if checkValid(board, row, col, Char(i + 48)) then begin
      board[row, col] := Char(i + 48) + '-';
      isNoValid := false;
      nextRow := row;
      nextCol := Col;
      repeat
        if (nextCol = 9) and (nextRow = 9) then
          Exit(board)
        else if nextCol = 9 then begin
          nextRow := nextRow + 1;
          nextCol := 1;
        end else
          nextCol := nextCol + 1;
      until (board[nextRow, nextCol][1] = '-');
      Result := bruteForce(board, nextRow, nextCol);
      isNoValid := true;
    end;
  end;
  if isNoValid = true then begin
    if not endGame(board) then board[row, col][1] := '-';
    Exit(board);
  end;
end;


//Check a value can fill in to certain cell or not
function checkValid(board: TgameBoard; row, col: Integer; val: Char): Boolean;
var
  i, j, newRow, newCol: Integer;
begin
  //check for row, col
  for i := 1 to 9 do
    if (board[i, col][1] = val) or (board[row, i][1] = val) then
      Exit(false);

  //check for box
  newRow := (row - 1) div 3 * 3 + 1;
  newCol := (col - 1) div 3 * 3 + 1;
  for i := newRow to newRow + 2 do begin
    for j := newCol to newCol + 2 do
      if (board[i, j][1] = val) then
        Exit(false);
  end;

  Result := true;
end;

procedure TMainForm.BtnShowAnsClick(Sender: TObject);
begin
  BtnSetQ.Enabled := false;
  BtnReset.Enabled := false;
  BtnShowAns.Enabled := false;
  gameBoard := findAnswer(gameBoard);
  printBoard(gameBoard);
  BtnNewGame.Enabled := true;
end;


procedure TMainForm.boardUIDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if (ACol div 3 = ARow div 3) or (ACol div 3 = 2 - (ARow div 3)) then begin
    boardUI.Canvas.Brush.Color := RGB(230, 230, 230);
  end;

  if length(gameBoard[aRow + 1, aCol + 1]) = 1 then begin
    boardUI.Canvas.Font.Color := clNavy;
    boardUI.Canvas.Font.Style := [fsBold];
  end;
  boardUI.Canvas.FillRect(Rect);
  boardUI.Canvas.TextRect(Rect, Rect.Left, Rect.Top, boardUI.Cells[ACol, ARow]);
end;

procedure TMainForm.boardUIGetEditMask(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
  value := '!0';
end;

procedure TMainForm.BtnExitClick(Sender: TObject);
var
  msg: String;
begin
  msg := 'Do you want to Exit?';
  if MessageDlg(msg, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    Application.Terminate;
end;

//Print the game UI
procedure TMainForm.printBoard(board: TgameBoard);
var
  row, col: Integer;
begin
  for col := 1 to 9 do begin
    for row := 1 to 9 do begin
      if board[row, col] <> '-' then
        boardUI.Cells[col - 1, row - 1] := board[row, col][1]
      else
        boardUI.Cells[col - 1, row - 1] := '';
    end;
  end;
end;

procedure TMainForm.BtnNewGameClick(Sender: TObject);
var
  row, col: Integer;
begin
  for row := 1 to 9 do begin
    for col := 1 to 9 do begin
      gameBoard[row, col] := '-';
    end;
  end;
  printBoard(gameBoard);
  btnSetQ.Caption := 'Set Question';
  boardUI.Options := boardUI.Options + [goEditing];
  btnReset.Enabled := true;
  btnShowAns.Enabled := false;
  BtnSetQ.Enabled := true;
  BtnNewGame.Enabled := false;
end;

procedure TMainForm.btnResetClick(Sender: TObject);
var
  row, col: Integer;
begin
  for col := 1 to 9 do begin
    for row := 1 to 9 do begin
      boardUI.Cells[col - 1, row - 1] := '';
    end;
  end;
end;

procedure TMainForm.btnSetQClick(Sender: TObject);
var
  row, col: Integer;
begin
  if btnSetQ.Caption = 'Set Question' then begin
    boardUI.Options := boardUI.Options - [goEditing];
    btnSetQ.Caption := 'Edit Question';
    btnReset.Enabled := false;
    btnShowAns.Enabled := true;
  end else begin
    btnSetQ.Caption := 'Set Question';
    boardUI.Options := boardUI.Options + [goEditing];
    btnReset.Enabled := true;
    btnShowAns.Enabled := false;
  end;

  for col := 1 to 9 do begin
    for row := 1 to 9 do begin
      if boardUI.Cells[col - 1, row - 1] <> '' then begin
        gameBoard[row, col][1] := boardUI.Cells[col - 1, row - 1][1];
      end else begin
        gameBoard[row, col] := '-';
      end;
    end;
  end;

end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  gameBoard := gameBoard6;
  printBoard(gameBoard);
end;


end.
