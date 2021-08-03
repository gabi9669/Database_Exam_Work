USE [msdb]
GO
DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'FULL_BACKUP', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'DESKTOP-H1TDU4S\User', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'FULL_BACKUP', @server_name = N'DESKTOP-H1TDU4S'
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'FULL_BACKUP', @step_name=N'FULLBACKUP', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=2, 
		@retry_interval=15, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @BackupName nvarchar(200)
SELECT @BackupName = ''E:\Codecool1\DBSPEC\MSSQL15.MSSQLSERVER\MSSQL\Backup\vizsga_FULL_'' + REPLACE(convert(nvarchar(20),GetDate(),120),'':'',''-'') +''.bak''

BACKUP DATABASE [vizsga] TO  DISK = @BackupName
						 WITH NOFORMAT,
						 NOINIT,
						 NAME = ''vizsga_FULLBACKUP'',
						 SKIP,
						 NOREWIND,
						 NOUNLOAD,
						 STATS = 10

BACKUP LOG [vizsga] TO  DISK = @BackupName
						 WITH NOFORMAT,
						 NOINIT,
						 NAME = ''vizsga_TR_LOGBACKUP'',
						 SKIP,
						 NOREWIND,
						 NOUNLOAD,
						 STATS = 10
GO', 
		@database_name=N'master', 
		@database_user_name=N'dbo', 
		@flags=0
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_update_job @job_name=N'FULL_BACKUP', 
		@enabled=1, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'DESKTOP-H1TDU4S\User', 
		@notify_email_operator_name=N'', 
		@notify_page_operator_name=N''
GO
USE [msdb]
GO
DECLARE @schedule_id int
EXEC msdb.dbo.sp_add_jobschedule @job_name=N'FULL_BACKUP', @name=N'FULL_BACKUP', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=2, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20210802, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959, @schedule_id = @schedule_id OUTPUT
select @schedule_id
GO
