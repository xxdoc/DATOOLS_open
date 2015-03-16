VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSubClass"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'---------------------------�����໯����¼��----------------------------
'ʹ�ñ����¼һ�������໯������¼�� hwnd�� Ĭ�ϴ��ڳ���ĵ�ַ �� _
 '�û��Զ��崰�ڳ���ĵ�ַ��
'������󱣴� �û��Զ��崰�ڳ���ĵ�ַ ���б���������һ����������֧�� _
 '��ͬһ�����ڵĶ�����໯��ÿ�����໯�в�ͬ���Զ��崰�ڳ���
'������ж��ʱ���Զ��ָ������໯�������ô��ڳ����ַΪ Ĭ�ϴ��ڳ���ĵ�ַ��

'# ���ʻ�������ʾ��Ϣ�ַ�������
'------------------------------------------------------------------------

'-------------------------------�÷���-----------------------------------
'�� CreateSubClass ��������¼һ�����࣬���ر�����ĵ�ַ����������0 _
 '����ͬһ�����ڶ�����࣬�ظ����ñ��������ɣ��� hwnd ����ÿ�α���һ�£� _
 '��ÿ�� hwnd ��һ�£���������һ�����໯���Զ��ָ���ǰ�� hwnd ���ദ���� _
 '������һ���µ����ࡣ
'�����󻹿ɷ�ֹ ������໯ʱ ͬһ�����Զ��崰�ڳ��򡱵ĵ�ַ�ظ����ӵ��б�
'�� UserProcAddrsCount ��� �Զ��崰�ڳ���� ������Ȼ���1ѭ���������� _
 �� UserProcAddr(i) ��� ÿ���Զ��崰�ڳ���ĵ�ַ����һ�����Զ��崰�ڳ��� _
 ����� AddrPrevWndProc ���Ĭ�ϴ��ڳ���ĵ�ַ���ٵ���Ĭ�ϵĴ��ڳ���
'�� UnSubclassOne ���ָ�һ�� �Զ��崰�ڳ��� �����ࣨ��ͬһ���ڶ������ʱ���� _
 'ֻ���� �Զ��崰�ڳ��� �б�Ϊ��ʱ�����ô��ڳ���Ϊ��Ĭ�ϴ��ڳ��򡱣����׻ָ����ࡣ
'�� UnSubclassWhole ���׻ָ����࣬�ָ����ڳ���Ϊ��Ĭ�ϴ��ڳ��򡱡�����������ʱ _
 '�Զ����ñ�����
'------------------------------------------------------------------------

'mUserProcAddrs() ֻ���桰�Զ��崰�ڳ��򡱵ĵ�ַ����û���桰Ĭ�� _
 ���ڳ��򡱵ĵ�ַ����Ĭ�ϴ��ڳ��򡱵ĵ�ַ�� lAddrPrevWndProc ����

Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Declare Sub SetLastError Lib "kernel32" (ByVal dwErrCode As Long)
Private Declare Function GetLastError Lib "kernel32" () As Long

Private Const GWL_WNDPROC = (-4)



Private lHwnd As Long
Private lAddrPrevWndProc As Long
Private mUserProcAddrs() As Long, mUserProcAddrsCount As Long    '���� �Զ��崰�ڳ��� �ĵ�ַ���б�
Attribute mUserProcAddrsCount.VB_VarUserMemId = 1073938434

Public Function CreateSubClass(ByVal hwnd As Long, _
                               ByVal currUserProcAddr As Long) As Long
'�ñ�����������¼һ�����࣬���ر�����ĵ�ַ����������0
'hwndΪҪ���ദ���Ĵ��ڵľ����currUserProcAddr Ϊ�Զ��崰�ڳ���ĵ�ַ
'��¼ Hwnd ��Ĭ�ϴ��ڳ���ĵ�ַ����ǰ������Զ��崰�ڳ���ĵ�ַ���� _
  '�����˽�г�Ա��������������໯�Ĳ���
'���������ж��Ƿ��ǶԴ��ڵĵ�һ�����໯��ֻ�е�һ�����໯��ʱ _
  '�ż�¼ Hwnd �� Ĭ�ϴ��ڳ���ĵ�ַ��Ҳ�Ż�ı� hwnd �Ĵ��ڳ���ĵ�ַ�� _
  '�Ժ������໯ֻ��¼�Զ��崰�ڳ���ĵ�ַ
'���ǵڶ����Ժ�����໯��hwnd �䲻���ظ���¼���������� hwnd �������� _
  '�͵�һ�ε�һ�£�����ɾ����ǰ�����໯��¼��������һ���������¼�¼

    If lAddrPrevWndProc <> 0 And lHwnd <> 0 Then
        '//////// �������Ѽ�¼��һ�����໯ ////////
        '�����ڵ� hwnd �Ƿ��Ǽ�¼�� lHwnd
        If lHwnd = hwnd Then
            '//////// ���ڵ� hwnd ���Ǽ�¼�� lHwnd��˵���Ƕ�һ�����ڵĶ�� _
             '���໯��ֻ�����Զ��崰�ڳ���ĵ�ַ�����鼴�� ////////
            'AddOneUserProcAddr �������ж�����б����Ѵ��ڸõ�ַ�������ӣ�ֱ�ӷ���
            AddOneUserProcAddr currUserProcAddr
            CreateSubClass = ObjPtr(Me)
            Exit Function
        Else
            '//////// ���ڵ� hwnd ���¼�� lHwnd ������˵���Ƕ�һ���µ� _
             '�������໯��ɾ����ǰ�����໯�����¼�¼���໯ ////////
            If Not UnSubclassWhole Then GoTo errH    'ɾ����ǰ�����໯
            '���½�������ִ������ĳ���
        End If
    End If

    '**************** ���³�����ǵ�һ�����໯ִ�еĳ��� ***************
    '��ȡ"Ĭ�ϴ��ڳ���"�ĵ�ַ�������浽ģ�鼶���� lAddrPrevWndProc
    lAddrPrevWndProc = GetWindowLong(hwnd, GWL_WNDPROC)
    '�������ȡ��"Ĭ�ϴ��ڳ���"��ַ��Ч������ת errH ��ִ�У��ܾ����ദ���ô���
    If lAddrPrevWndProc = 0 Then GoTo errH
    '�����ھ�����浽ģ�鼶���� lHwnd
    lHwnd = hwnd

    '�������໯
    SetLastError 0&
    If SetWindowLong(hwnd, GWL_WNDPROC, AddressOf SCMyWndProc) = 0 Then
        'SetWindowLong �������ʧ�ܣ��ͻָ����ദ��������ת�� errH ��ִ��
        If GetLastError Then UnSubclassWhole: GoTo errH  'If GetLastError <> 0 Then
    End If

    '���ӵ�ǰ �Զ��崰�ڳ����ַ ������
    AddOneUserProcAddr currUserProcAddr
    CreateSubClass = ObjPtr(Me)
    Exit Function
errH:
    CreateSubClass = 0
End Function

Public Function UnSubclassOne(addrUserProc As Long) As Boolean
'�ָ�һ�� �Զ��崰�ڳ��� �����ֻ࣬�Ǵ� �Զ��崰�ڳ��� �б���ɾ������
'�ָ����ж��� �Զ��崰�ڳ��� �б���Ϊ�գ�����ȫ�ָ����࣬���� _
  '������ UnSubclassWhole ��ȫ�ָ�����
'���� false ʱ���������if �б�Ϊ�գ����ǵ��� UnSubclassWhole ʧ�� _
  'if �б���Ϊ�գ��������б���û���ҵ���ַ����ʱӦ����ʹ��
'���� true ʱ���������if �б�Ϊ�գ����ǵ��� UnSubclassWhole �ɹ� _
  'if �б���Ϊ�գ�����ֻɾ��һ������ɹ�����ʱӦ����ʹ��
'��֮��if �б���Ϊ�գ���ʲô������������ʹ�ã������б�Ϊ�գ��ж� _
  '����������ֵ������ֵ��ʾ�˵��� UnSubclassWhole �ĳɹ����

    Dim i As Long
    '-------- ��һ�������� UnSubclassOne ����ֵ������ĳ��򻹿��ٸ� --------
    For i = 1 To mUserProcAddrsCount
        If mUserProcAddrs(i) = addrUserProc Then Exit For
    Next i
    If i <= mUserProcAddrsCount Then
        '�ҵ�ȷʵ��һ�����ڳ���addrUserProc
        '�� �Զ��崰�ڳ��� �б���ɾ������
        Dim j As Long
        For j = i To mUserProcAddrsCount - 1
            mUserProcAddrs(j) = mUserProcAddrs(j + 1)
        Next j
        mUserProcAddrsCount = mUserProcAddrsCount - 1
        If mUserProcAddrsCount > 0 _
           Then ReDim Preserve mUserProcAddrs(1 To mUserProcAddrsCount)
        UnSubclassOne = True
    Else
        'û�д��ڳ���addrUserProc������ false
        UnSubclassOne = False
    End If

    '-------- ����б���ʱ��Ϊ�գ�����������һ��ķ���ֵ�����򷵻�����ķ���ֵ --------
    '�ж��Ƿ� �Զ��崰�ڳ��� �б�Ϊ�գ���Ϊ���򳹵׻ָ�����
    If mUserProcAddrsCount <= 0 Then UnSubclassOne = UnSubclassWhole
End Function

Public Function UnSubclassWhole() As Boolean
'�ָ��������໯���ָ����ڵ�Ĭ�ϴ��ڳ���ĵ�ַ��
'UnSubclassOne �ǻָ�һ�� �Զ��崰�ڳ����� �Զ��崰�ڳ��� �б� _
  ����������������ȫ�ָ�����
    Dim Ret As Long

    If lHwnd = 0 Or lAddrPrevWndProc = 0 Then
        ClearUserProcAddr
        UnSubclassWhole = False
        Exit Function
    Else
        ClearUserProcAddr
        SetLastError 0&
        Ret = SetWindowLong(lHwnd, GWL_WNDPROC, lAddrPrevWndProc)
        '��ʱ���ָ����ɹ����������� lHwnd = 0 �� lAddrPrevWndProc = 0 _
         '��Ϊ��������Ҫ�����������������ָ����ɹ�����Ϣ�Ա��������
        If Ret = 0 And GetLastError <> 0 Then UnSubclassWhole = False: Exit Function

        lHwnd = 0
        lAddrPrevWndProc = 0
        UnSubclassWhole = True
    End If
End Function

Private Sub AddOneUserProcAddr(ByVal oneProcAddr As Long)
'����һ���µ� �Զ��崰�ڳ���ĵ�ַ ������
'ע�⣺������������и���������
    Dim i As Long
    '����������Ƿ����и����������ֱ���˳�
    For i = 1 To mUserProcAddrsCount
        If mUserProcAddrs(i) = oneProcAddr Then Exit Sub
    Next i
    '������������һ��
    mUserProcAddrsCount = mUserProcAddrsCount + 1
    ReDim Preserve mUserProcAddrs(1 To mUserProcAddrsCount)
    mUserProcAddrs(mUserProcAddrsCount) = oneProcAddr
End Sub

Private Sub ClearUserProcAddr()
'��� �Զ��崰�ڳ���ĵ�ַ �б�
'���� mUserProcAddrs() ֻ�����Զ��崰�ڳ���ĵ�ַ����û����Ĭ�� _
  ���ڳ���ĵ�ַ�����Կɴ�ɾ��
    mUserProcAddrsCount = 0
    Erase mUserProcAddrs
End Sub




Public Property Get hwnd() As Long
    hwnd = lHwnd
End Property

Public Property Get PrevWndProcAddr() As Long
    PrevWndProcAddr = lAddrPrevWndProc
End Property

'��ȡ��ǰ�ж��ٸ� �Զ��崰�ڳ���
Public Property Get UserProcAddrsCount() As Long
    UserProcAddrsCount = mUserProcAddrsCount
End Property

'��ȡһ�� �Զ��崰�ڳ��� �ĵ�ַ
Public Property Get UserProcAddr(index As Long) As Long
    If index > 0 And index <= mUserProcAddrsCount Then UserProcAddr = mUserProcAddrs(index)
End Property

Private Sub Class_Initialize()
    lHwnd = 0
    lAddrPrevWndProc = 0
    mUserProcAddrsCount = 0
End Sub

Private Sub Class_Terminate()
'Terminate ʱ���� UnSubclassWhole����� UnSubclassWhole û�гɹ���Ҳ���ٶ���
    If lHwnd <> 0 And lAddrPrevWndProc <> 0 Then UnSubclassWhole
End Sub