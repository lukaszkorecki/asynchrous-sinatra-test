thin_cmd = bundle exec thin -d -P

em_pid = ./em-async.pid
em_port = 3000

as_pid = ./async.pid
as_port = 3001

syn_pid = ./sync_pid
syn_port = 3002


em-start:
	FF=emasync.rb $(thin_cmd) $(em_pid) -p $(em_port) -l em-async.log start
em-stop:
	FF=emasync.rb $(thin_cmd) $(em_pid) stop
em-log:
	tail -f em-async.log
em-test:
	curl localhost:$(em_port) &
	curl localhost:$(em_port) &
	curl localhost:$(em_port) &
	curl localhost:$(em_port) &
	curl localhost:$(em_port) &


as-start:
	FF=asyncs.rb $(thin_cmd) $(as_pid) -p $(as_port) -l async.log start
as-stop:
	FF=asyncs.rb $(thin_cmd) $(as_pid) stop
as-log:
	tail -f async.log
asc-test:
	curl localhost:$(as_port) &
	curl localhost:$(as_port) &
	curl localhost:$(as_port) &
	curl localhost:$(as_port) &
	curl localhost:$(as_port) &


sync-start:
	FF=synch.rb $(thin_cmd) $(sync_pid) -p $(syn_port) -l synch.log start
sync-stop:
	FF=synch.rb $(thin_cmd) $(sync_pid) stop
sync-log:
	tail -f synch.log
sync-test:
	curl localhost:$(syn_port) &
	curl localhost:$(syn_port) &
	curl localhost:$(syn_port) &
	curl localhost:$(syn_port) &
	curl localhost:$(syn_port) &
