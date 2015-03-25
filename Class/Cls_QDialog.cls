VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Cls_QDialog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit
'������Э�� VBͨ��ģ��⡿CodeInstitute VB Common Modules Library
'��ģ������QDialog ͨ�öԻ���
'�����ߡ�CI Deali-Axy

Private Declare Function GetOpenFileName Lib "comdlg32.dll" Alias "GetOpenFileNameA" (pOpenfilename As OPENFILENAME) As Long
Private Declare Function GetSaveFileName Lib "comdlg32.dll" Alias "GetSaveFileNameA" (pOpenfilename As OPENFILENAME) As Long
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Private Const SW_SHOWNORMAL = 1
Private Const OFN_OVERWRITEPROMPT = &H2
Private Const OFN_HIDEREADONLY = &H4
Private Const OFN_PATHMUSTEXIST = &H800
Private Const OFN_FILEMUSTEXIST = &H1000

Private Type OPENFILENAME
    lStructSize As Long
    hwndOwner As Long
    hInstance As Long
    lpstrFilter As String
    lpstrCustomFilter As String
    nMaxCustFilter As Long
    nFilterIndex As Long
    lpstrFile As String
    nMaxFile As Long
    lpstrFileTitle As String
    nMaxFileTitle As Long
    lpstrInitialDir As String
    lpstrTitle As String
    Flags As Long
    nFileOffset As Integer
    nFileExtension As Integer
    lpstrDefExt As String
    lCustData As Long
    lpfnHook As Long
    lpTemplateName As String
End Type

Private sTmp As OPENFILENAME

Public Property Let FileTitle(ByVal vData As String)
'������ָ��ֵʱʹ�ã�λ�ڸ�ֵ������ߡ�
'Syntax: X.FileTitle = 5
    sTmp.lpstrFileTitle = vData
End Property

Public Property Get FileTitle() As String
'��������ֵʱʹ�ã�λ�ڸ�ֵ�����ұߡ�
'Syntax: Debug.Print X.FileTitle
    FileTitle = sTmp.lpstrFileTitle
End Property

Public Property Let File(ByVal vData As String)
'������ָ��ֵʱʹ�ã�λ�ڸ�ֵ������ߡ�
'Syntax: X.File = 5
    sTmp.lpstrFile = vData
End Property

Public Property Get File() As String
'��������ֵʱʹ�ã�λ�ڸ�ֵ�����ұߡ�
'Syntax: Debug.Print X.File
    File = sTmp.lpstrFile
End Property

Public Property Let MaxFile(ByVal vData As Long)
'������ָ��ֵʱʹ�ã�λ�ڸ�ֵ������ߡ�
'Syntax: X.MaxFile = 5
    sTmp.nMaxFile = vData
End Property

Public Property Get MaxFile() As Long
'��������ֵʱʹ�ã�λ�ڸ�ֵ�����ұߡ�
'Syntax: Debug.Print X.MaxFile
    MaxFile = sTmp.nMaxFile
End Property

Public Property Let Filter(ByVal vData As String)
'������ָ��ֵʱʹ�ã�λ�ڸ�ֵ������ߡ�
'Syntax: X.Filter = 5
    sTmp.lpstrFilter = vData
End Property

Public Property Get Filter() As String
'��������ֵʱʹ�ã�λ�ڸ�ֵ�����ұߡ�
'Syntax: Debug.Print X.Filter
    Filter = sTmp.lpstrFilter
End Property

Public Property Let OwnerhWnd(ByVal vData As Long)
'������ָ��ֵʱʹ�ã�λ�ڸ�ֵ������ߡ�
'Syntax: X.OwnerhWnd = 5
    sTmp.hwndOwner = vData
End Property

Public Property Get OwnerhWnd() As Long
'��������ֵʱʹ�ã�λ�ڸ�ֵ�����ұߡ�
'Syntax: Debug.Print X.OwnerhWnd
    OwnerhWnd = sTmp.hwndOwner
End Property

Public Property Let AppInstance(ByVal vData As Long)
'������ָ��ֵʱʹ�ã�λ�ڸ�ֵ������ߡ�
'Syntax: X.AppInstance = 5
    sTmp.hInstance = vData
End Property

Public Property Get AppInstance() As Long
'��������ֵʱʹ�ã�λ�ڸ�ֵ�����ұߡ�
'Syntax: Debug.Print X.AppInstance
    AppInstance = sTmp.hInstance
End Property

Public Property Let MaxFileTitle(ByVal vData As Long)
'������ָ��ֵʱʹ�ã�λ�ڸ�ֵ������ߡ�
'Syntax: X.MaxFileTitle = 5
    sTmp.nMaxFileTitle = vData
End Property

Public Property Get MaxFileTitle() As Long
'��������ֵʱʹ�ã�λ�ڸ�ֵ�����ұߡ�
'Syntax: Debug.Print X.MaxFileTitle
    MaxFileTitle = sTmp.nMaxFileTitle
End Property

Public Property Let InitialDir(ByVal vData As String)
'������ָ��ֵʱʹ�ã�λ�ڸ�ֵ������ߡ�
'Syntax: X.InitialDir = 5
    sTmp.lpstrInitialDir = vData
End Property

Public Property Get InitialDir() As String
'��������ֵʱʹ�ã�λ�ڸ�ֵ�����ұߡ�
'Syntax: Debug.Print X.InitialDir
    InitialDir = sTmp.lpstrInitialDir
End Property

Public Property Let Title(ByVal vData As String)
'������ָ��ֵʱʹ�ã�λ�ڸ�ֵ������ߡ�
'Syntax: X.Title = 5
    sTmp.lpstrTitle = vData
End Property

Public Property Get Title() As String
'��������ֵʱʹ�ã�λ�ڸ�ֵ�����ұߡ�
'Syntax: Debug.Print X.Title
    Title = sTmp.lpstrTitle
End Property

Public Function ShowOpen() As String
    On Error GoTo Err
    Dim Rtn As Long
    Dim APICmdlg As String
    With sTmp
        .lpstrTitle = "���ļ�"
        .Flags = OFN_HIDEREADONLY + OFN_PATHMUSTEXIST + OFN_FILEMUSTEXIST
        Rtn = GetOpenFileName(sTmp)
        If Rtn >= 1 Then
            APICmdlg = .lpstrFile
            ShowOpen = APICmdlg
        End If
    End With
    Exit Function
Err:
    MsgBox "����" & vbCrLf & Err.Description
End Function

Public Function ShowSave() As String
    On Error GoTo Err
    Dim Rtn As Long
    Dim APICmdlg As String
    With sTmp
        .lpstrTitle = "�����ļ�"
        .Flags = OFN_HIDEREADONLY + OFN_PATHMUSTEXIST + OFN_FILEMUSTEXIST
        Rtn = GetSaveFileName(sTmp)
        If Rtn >= 1 Then
            APICmdlg = .lpstrFile
            ShowSave = APICmdlg
        End If
    End With
Err:
    MsgBox "����" & vbCrLf & Err.Description
End Function

Private Sub Class_Initialize()
    On Error GoTo Err
    sTmp.lStructSize = Len(sTmp)
    sTmp.hInstance = App.hInstance
    sTmp.lpstrInitialDir = App.Path
    sTmp.lpstrFile = Space(254)
    sTmp.nMaxFile = 255
    sTmp.lpstrFileTitle = Space(254)
    sTmp.nMaxFileTitle = 255
    sTmp.lpstrFilter = "�����ļ� (*.*)" + Chr$(0) + "*.*" + Chr$(0)
    Exit Sub
Err:
    MsgBox "����" & vbCrLf & Err.Description
End Sub
