{-------------------------------------------------------------------------------
   ��Ԫ: SynEditStrRes.pas
   ����: Ҧ�Ƿ�       
   ����: 2004.11.26
   ˵��: �����ַ��������ĵ�Ԫ
   �汾: 1.00 00
-------------------------------------------------------------------------------}
(*
  -- ʹ���� --
  * Uesr : liqj
  * Date : 2006-09-29
  * Modi : xx
  * Var  : 1.0.0.1
*)

unit u_SynEditStrRes;

interface

const
  {$J+}
  { unit SynEditSearcher }
  sSplitSymbol             = #13#10#13#10;
  sNotFindText             = 'û�в��ҵ�"%s"��';
  sReplacePromptText       = '�Ƿ�Ҫ����ǰ��괦�� %s �滻�� %s ��';
  sReplacePromptTitle      = '��ʾ�滻';
  sReplacePromptYesBtn     = '�滻(&R)';
  sReplacePromptAllBtn     = '�滻ȫ��';
  sReplacePromptSkipBtn    = '����(&I)';
  sReplacePromptCancelBtn  = 'ȡ��';
  { unit SynEditor }
  sOpenDocumentError       = '%s �ĵ���ʱ����' + sSplitSymbol + '���ܸ��ĵ������ڻ����������Զ�ռ��ʽ�򿪣�';
  sSaveDocumentError       = '%s �ĵ�����ʱ����' + sSplitSymbol + '���ܸ��ĵ�������Ϊֻ�������������Զ�ռ��ʽ�򿪣�';
  sSaveDocumentTitle       = '�����ĵ� %s';
  sOpenDocumentTitle       = '���ĵ�...';
  sExportDocumentTitle     = '�����ĵ� %s';
  sSavePromptText          = '%s �ĵ��������Ѿ����޸�' + sSplitSymbol + '�Ƿ�Ҫ���ĵ����̣�';
  sSavePromptTitle         = '����';
  sSavePromptYesBtn        = '����(&S)';
  sSavePromptNotBtn        = '����(&N)';
  sSavePromptCancelBtn     = 'ȡ��';
  { unit SynEditActions }
  sNoHighlighter           = '[����ʾ�﷨����]';
 {$J-}

implementation

end.
 
 