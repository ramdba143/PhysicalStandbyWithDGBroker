connect sys/{{ password_sys }} as sysdba
alter system set LOG_ARCHIVE_DEST_1='LOCATION={{ db_recofile_path }} VALID_FOR=(ALL_LOGFILES,ALL_ROLES) DB_UNIQUE_NAME={{ sbdbunq_name }}' scope=spfile;
alter system set db_file_name_convert='{{ db_createfile_path }}/{{ prdbunq_name }}','{{ db_createfile_path }}/{{ sbdbunq_name }}' scope=spfile;
alter system set log_file_name_convert='{{ db_recofile_dest }}/{{ prdbunq_name }}','{{ db_recofile_dest }}/{{ sbdbunq_name }}' scope=spfile;
alter system set standby_file_management=auto scope=spfile;
alter system set dg_broker_config_file1='{{ db_createfile_path }}/{{ sbdbunq_name }}/dr1.dat' scope=spfile;
alter system set dg_broker_config_file2='{{ db_recofile_dest }}/{{ sbdbunq_name }}/dr2.dat' scope=spfile;
alter system set db_flashback_retention_target=120 scope=spfile;
alter database flashback on;
alter system set dg_broker_start=true scope=spfile;
shutdown immediate
startup
alter system register;
exit;
