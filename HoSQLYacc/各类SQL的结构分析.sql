--最普通的SQL
select * from tt a where a.id=1;
+Text: Type:sntNode Keyword:snkNone
  +Text:<QUERY> Type:sntSentence Keyword:snkQuery
    +Text:<FIELDS> Type:sntKey Keyword:snkFields
      +Text:* Type:sntNode Keyword:snkIdentifier
    +Text:<TABLES> Type:sntKey Keyword:snkTables
      +Text:tt Type:sntNode Keyword:snkIdentifier Alias Name:a
    +Text:<CONDITIONS> Type:sntKey Keyword:snkWhereClause
      +Text:= Type:sntNode Keyword:snkOperator
        +Text:a.id Type:sntNode Keyword:snkAliasAndField
          +Text:a Type:sntNode Keyword:snkIdentifier
          +Text:id Type:sntNode Keyword:snkIdentifier
        +Text:1 Type:sntNode Keyword:snkExpression

--出错的情况
select * from tt a  where a.| id;      

+Text: Type:sntNode Keyword:snkNone
  +Text:<FIELDS> Type:sntKey Keyword:snkFields
    +Text:* Type:sntNode Keyword:snkIdentifier
  +Text:where Type:sntNode Keyword:snkKeyword
  +Text:<TABLES> Type:sntKey Keyword:snkTables
    +Text:tt Type:sntNode Keyword:snkIdentifier Alias Name:a
  +Text:a. Type:sntNode Keyword:snkAliasAndField
    +Text:a Type:sntNode Keyword:snkIdentifier
    +Text: Type:sntNode Keyword:snkIdentifier Current:True
  +Text:id Type:sntNode Keyword:snkIdentifier


--嵌套查询
select * from tt a  where exists     
  (select * from t2 where t2.id=a.|);
  
+Text: Type:sntNode Keyword:snkNone                                   
  +Text:<QUERY> Type:sntSentence Keyword:snkQuery                     
    +Text:<FIELDS> Type:sntKey Keyword:snkFields                      
      +Text:* Type:sntNode Keyword:snkIdentifier                      
    +Text:<TABLES> Type:sntKey Keyword:snkTables                      
      +Text:tt Type:sntNode Keyword:snkIdentifier Alias Name:a        
    +Text:<CONDITIONS> Type:sntKey Keyword:snkWhereClause             
      +Text:exists Type:sntNode Keyword:snkConditionClause            
        +Text:<QUERY> Type:sntSentence Keyword:snkQuery               
          +Text:<FIELDS> Type:sntKey Keyword:snkFields                
            +Text:* Type:sntNode Keyword:snkIdentifier                
          +Text:<TABLES> Type:sntKey Keyword:snkTables                
            +Text:t2 Type:sntNode Keyword:snkIdentifier               
          +Text:<CONDITIONS> Type:sntKey Keyword:snkWhereClause       
            +Text:= Type:sntNode Keyword:snkOperator                  
              +Text:t2.id Type:sntNode Keyword:snkAliasAndField       
                +Text:t2 Type:sntNode Keyword:snkIdentifier           
                +Text:id Type:sntNode Keyword:snkIdentifier           
              +Text:a. Type:sntNode Keyword:snkAliasAndField          
                +Text:a Type:sntNode Keyword:snkIdentifier            
                +Text: Type:sntNode Keyword:snkIdentifier Current:True

--join连接                
select b.| from tt a
  inner join t2 b on b.seq=a.seq
where a.id=1;

+Text: Type:sntNode Keyword:snkNone
  +Text:<QUERY> Type:sntSentence Keyword:snkQuery
    +Text:<FIELDS> Type:sntKey Keyword:snkFields
      +Text:b. Type:sntNode Keyword:snkAliasAndField
        +Text:b Type:sntNode Keyword:snkIdentifier
        +Text: Type:sntNode Keyword:snkIdentifier Current:True
    +Text:<TABLES> Type:sntKey Keyword:snkTables
      +Text:tt Type:sntNode Keyword:snkIdentifier Alias Name:a
    +Text:<JOINS> Type:sntKey Keyword:snkJoins
      +Text:<INNER JOIN> Type:sntKey Keyword:snkJoinClause
        +Text:<TABLES> Type:sntKey Keyword:snkTables
          +Text:t2 Type:sntNode Keyword:snkIdentifier Alias Name:b
        +Text:<JOIN CONDITIONS> Type:sntKey Keyword:snkWhereClause
          +Text:= Type:sntNode Keyword:snkOperator
            +Text:b.seq Type:sntNode Keyword:snkAliasAndField
              +Text:b Type:sntNode Keyword:snkIdentifier
              +Text:seq Type:sntNode Keyword:snkIdentifier
            +Text:a.seq Type:sntNode Keyword:snkAliasAndField
              +Text:a Type:sntNode Keyword:snkIdentifier
              +Text:seq Type:sntNode Keyword:snkIdentifier
    +Text:<CONDITIONS> Type:sntKey Keyword:snkWhereClause
      +Text:= Type:sntNode Keyword:snkOperator
        +Text:a.id Type:sntNode Keyword:snkAliasAndField
          +Text:a Type:sntNode Keyword:snkIdentifier
          +Text:id Type:sntNode Keyword:snkIdentifier
        +Text:1 Type:sntNode Keyword:snkExpression


--update
update cw_szmx a set a.JE=(select b.GRJFJE from ys_ylbxgryjsjmx b where b.GRJFJE=a.|);

+Text: Type:sntNode Keyword:snkNone
  +Text:<UPDATE> Type:sntKey Keyword:snkUpdate
    +Text:<TABLES> Type:sntKey Keyword:snkTables PATH:(4)WhereClause1
      +Text:cw_szmx Type:sntNode Keyword:snkIdentifier Alias Name:a
    +Text:<SET> Type:sntKey Keyword:snkSet
      +Text:= Type:sntNode Keyword:snkOperator
        +Text:a.JE Type:sntNode Keyword:snkAliasAndField
          +Text:a Type:sntNode Keyword:snkIdentifier
          +Text:JE Type:sntNode Keyword:snkIdentifier
        +Text:<QUERY> Type:sntSentence Keyword:snkQuery
          +Text:<FIELDS> Type:sntKey Keyword:snkFields
            +Text:b.GRJFJE Type:sntNode Keyword:snkAliasAndField
              +Text:b Type:sntNode Keyword:snkIdentifier
              +Text:GRJFJE Type:sntNode Keyword:snkIdentifier
          +Text:<TABLES> Type:sntKey Keyword:snkTables
            +Text:ys_ylbxgryjsjmx Type:sntNode Keyword:snkIdentifier Alias Name:b
          +Text:<CONDITIONS> Type:sntKey Keyword:snkWhereClause
            +Text:= Type:sntNode Keyword:snkOperator
              +Text:b.GRJFJE Type:sntNode Keyword:snkAliasAndField
                +Text:b Type:sntNode Keyword:snkIdentifier
                +Text:GRJFJE Type:sntNode Keyword:snkIdentifier
              +Text:a. Type:sntNode Keyword:snkAliasAndField
                +Text:a Type:sntNode Keyword:snkIdentifier
                +Text: Type:sntNode Keyword:snkIdentifier Current:True
