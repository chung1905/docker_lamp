INSTALL PLUGIN server_audit SONAME 'server_audit.so';
SET GLOBAL server_audit_logging=ON;
SET GLOBAL server_audit_events='QUERY_DML_NO_SELECT';
SHOW GLOBAL VARIABLES LIKE 'server_audit%';
