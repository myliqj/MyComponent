';

select substr(STMT_TEXT,1,100),a.*  from SYSIBMADM.LONG_RUNNING_SQL a with ur;
select substr(STMT_TEXT,1,100),a.* from SYSIBMADM.TOP_DYNAMIC_SQL a order by num_executions+AVERAGE_EXECUTION_TIME_S desc with ur;
select substr(STMT_TEXT,1,100),a.*  from