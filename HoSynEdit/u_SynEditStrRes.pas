{-------------------------------------------------------------------------------
   单元: SynEditStrRes.pas
   作者: 姚乔锋       
   日期: 2004.11.26
   说明: 定义字符串常量的单元
   版本: 1.00 00
-------------------------------------------------------------------------------}
(*
  -- 使用者 --
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
  sNotFindText             = '没有查找到"%s"！';
  sReplacePromptText       = '是否要将当前光标处的 %s 替换成 %s ？';
  sReplacePromptTitle      = '提示替换';
  sReplacePromptYesBtn     = '替换(&R)';
  sReplacePromptAllBtn     = '替换全部';
  sReplacePromptSkipBtn    = '忽略(&I)';
  sReplacePromptCancelBtn  = '取消';
  { unit SynEditor }
  sOpenDocumentError       = '%s 文档打开时出错' + sSplitSymbol + '可能该文档不存在或被其它程序以独占方式打开！';
  sSaveDocumentError       = '%s 文档保存时出错' + sSplitSymbol + '可能该文档属性是为只读被其它程序以独占方式打开！';
  sSaveDocumentTitle       = '保存文档 %s';
  sOpenDocumentTitle       = '打开文档...';
  sExportDocumentTitle     = '导出文档 %s';
  sSavePromptText          = '%s 文档的内容已经被修改' + sSplitSymbol + '是否要将文档存盘？';
  sSavePromptTitle         = '保存';
  sSavePromptYesBtn        = '存盘(&S)';
  sSavePromptNotBtn        = '丢弃(&N)';
  sSavePromptCancelBtn     = '取消';
  { unit SynEditActions }
  sNoHighlighter           = '[不显示语法高亮]';
 {$J-}

implementation

end.
 
 