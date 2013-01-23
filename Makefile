thin_cmd = bundle exec thin -d -P

em_pid = ./em-async.pid
em_port = 3000

as_pid = ./async.pid
as_port = 3001

syn_pid = ./sync.pid
syn_port = 3002


em-start:
	FF=emasync.rb $(thin_cmd) $(em_pid) -p $(em_port) -l em-async.log start
em-stop:
	FF=emasync.rb $(thin_cmd) $(em_pid) stop
em-log:
	tail -f em-async.log
em-test:
	@curl localhost:$(em_port) &
	@curl localhost:$(em_port) &
	@curl localhost:$(em_port) &
	@curl localhost:$(em_port) &
	@curl localhost:$(em_port) &


as-start:
	FF=asyncs.rb $(thin_cmd) $(as_pid) -p $(as_port) -l async.log start
as-stop:
	FF=asyncs.rb $(thin_cmd) $(as_pid) stop
as-log:
	tail -f async.log
as-test:
	@curl localhost:$(as_port) &
	@curl localhost:$(as_port) &
	@curl localhost:$(as_port) &
	@curl localhost:$(as_port) &
	@curl localhost:$(as_port) &


sync-start:
	FF=synch.rb $(thin_cmd) $(syn_pid) -p $(syn_port) -l synch.log start
sync-stop:
	FF=synch.rb $(thin_cmd) $(syn_pid) stop
sync-log:
	tail -f synch.log
sync-test:
	@curl localhost:$(syn_port) &
	@curl localhost:$(syn_port) &
	@curl localhost:$(syn_port) &
	@curl localhost:$(syn_port) &
	@curl localhost:$(syn_port) &

start-all: as-start em-start sync-start
stop-all: as-stop em-stop sync-stop
log-all: as-log em-log sync-log
test-all: as-test em-test sync-test

clean:
	rm *.log
	rm *.pid
	ps aux | grep thin | grep -v grep | awk '{ print $$2 }' | xargs kill -9
