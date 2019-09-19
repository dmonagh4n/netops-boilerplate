## Replication configuration commands
## psql -c 'select application_name, state, sync_priority, sync_state from pg_stat_replication;'
## psql -x -c 'select * from pg_stat_replication;'

# Master 

/var/lib/pgsql/9.6/data/postgresql.conf

#------------------------------------------------------------------------------
# REPLICATION
#------------------------------------------------------------------------------

# - Sending Server(s) -

# Set these on the master and on any standby that will send replication data.

max_wal_senders = 2             # max number of walsender processes
                                # (change requires restart)
wal_keep_segments = 10          # in logfile segments, 16MB each; 0 disables
#wal_sender_timeout = 60s       # in milliseconds; 0 disables

#max_replication_slots = 0      # max number of replication slots
                                # (change requires restart)
#track_commit_timestamp = off   # collect timestamp of transaction commit
                                # (change requires restart)

# - Master Server -

# These settings are ignored on a standby server.

synchronous_standby_names = 'pgslave01' # standby servers that provide sync rep
                                        # number of sync standbys and comma-separated list of application_name
                                # from standby(s); '*' = all
#vacuum_defer_cleanup_age = 0   # number of xacts by which cleanup is delayed

# - Standby Servers -

# These settings are ignored on a master server.

#hot_standby = off                      # "on" allows queries during recovery
                                        # (change requires restart)
#max_standby_archive_delay = 30s        # max delay before canceling queries
                                        # when reading WAL from archive;
                                        # -1 allows indefinite delay
#max_standby_streaming_delay = 30s      # max delay before canceling queries
                                        # when reading streaming WAL;
                                        # -1 allows indefinite delay
#wal_receiver_status_interval = 10s     # send replies at least this often
                                        # 0 disables
#hot_standby_feedback = off             # send info from standby to prevent
                                        # query conflicts
#wal_receiver_timeout = 60s             # time that receiver waits for
                                        # communication from master
                                        # in milliseconds; 0 disables
#wal_retrieve_retry_interval = 5s       # time to wait before retrying to
                                        # retrieve WAL after a failed attempt


/var/lib/pgsql/9.6/data/pg_hba.conf

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
#host    all             all             127.0.0.1/32                   md5
host    all             netbox          172.29.68.15/32         md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
# Allow replication connections from localhost, by a user with the
# replication privilege.
#local   replication     postgres                                peer
host    replication     postgres        127.0.0.1/32            md5
#host    replication     postgres        ::1/128                 md5
# PGSQL Master IP Address
host    replication     replica         172.29.68.15/32         md5
# PGSQL Slave IP Address
host    replication     replica         172.30.68.15/32         md5

# Standby

/var/lib/pgsql/9.6/data/postgresql.conf

#------------------------------------------------------------------------------
# REPLICATION
#------------------------------------------------------------------------------

# - Sending Server(s) -

# Set these on the master and on any standby that will send replication data.

max_wal_senders = 2             # max number of walsender processes
                                # (change requires restart)
wal_keep_segments = 10          # in logfile segments, 16MB each; 0 disables
#wal_sender_timeout = 60s       # in milliseconds; 0 disables

#max_replication_slots = 0      # max number of replication slots
                                # (change requires restart)
#track_commit_timestamp = off   # collect timestamp of transaction commit
                                # (change requires restart)

# - Master Server -

# These settings are ignored on a standby server.

synchronous_standby_names = 'pgslave01' # standby servers that provide sync rep
                                        # number of sync standbys and comma-separated list of application_name
                                # from standby(s); '*' = all
#vacuum_defer_cleanup_age = 0   # number of xacts by which cleanup is delayed

# - Standby Servers 

# These settings are ignored on a master server.

hot_standby = on                        # "on" allows queries during recovery
                                        # (change requires restart)
#max_standby_archive_delay = 30s        # max delay before canceling queries
                                        # when reading WAL from archive;
                                        # -1 allows indefinite delay
#max_standby_streaming_delay = 30s      # max delay before canceling queries
                                        # when reading streaming WAL;
                                        # -1 allows indefinite delay
#wal_receiver_status_interval = 10s     # send replies at least this often
                                        # 0 disables
#hot_standby_feedback = off             # send info from standby to prevent
                                        # query conflicts
#wal_receiver_timeout = 60s             # time that receiver waits for
                                        # communication from master
                                        # in milliseconds; 0 disables
#wal_retrieve_retry_interval = 5s       # time to wait before retrying to
                                        # retrieve WAL after a failed attempt

/var/lib/pgsql/9.6/data/pg_hba.conf

# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     peer
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
# Allow replication connections from localhost, by a user with the
# replication privilege.
#local   replication     postgres                                peer
host    replication     postgres        127.0.0.1/32            md5
#host    replication     postgres        ::1/128                 md5
# PGSQL Master IP Address
host    replication     replica         172.29.68.15/32         md5
# PGSQL Slave IP Address
host    replication     replica         172.30.68.15/32         md5
