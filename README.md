Calling slow APIs in non blocking fashion from within Sinatra is quite possible with Event Machine and few simple libraries.


This repo contains some examples and very, very basic test showing how stuff works in practice.

# how to

- clone the repo

- `bundle install`

Now that you have the dependencies you can start serves and run some simple tests.

Everthing is managed thourgh [make](http://www.gnu.org/software/make/) - because it's simple, everyhere and allows parallel execution of tasks.

Example session:


#### terminal 1

    make -j 3 start-all # starts all 3 variants in parallel

#### terminal 2
    make -j 3 log-all  # tails all logs from all apps simultanously


#### terminal 1

    make -j 3 test-all # fires 5 http requests per api (15 requests in total) in parallel


Watch the logs and responses coming in :-)

### Sample output:


*terminal 2*

```
unicorn lukaszkorecki # make -j3 test-all           master ~/Dev/Projects/asynchronous_web_services
Async Body: sit quam doloribus
Async Body: sed ab omnis
EM Synchrony Body: esse dolor nisi
EM Synchrony Body: quis et qui
EM Synchrony Body: quae omnis eos
EM Synchrony Body: recusandae corporis harum
Async Body: ex vel eos
Async Body: aut ipsam officiis
EM Synchrony Body: sunt deserunt velit
Async Body: reiciendis nam dolor
Synchronous Body: in quae cumque
Synchronous Body: quasi in a
Synchronous Body: omnis minus quia
Synchronous Body: voluptas esse aut
Synchronous Body: est totam repudiandae
```


*terminal 1*


```

I, [2013-01-23T22:49:29.066624 #94253]  INFO -- : Async Calling slow api
I, [2013-01-23T22:49:29.067298 #94257]  INFO -- : EM Synchrony Calling slow api
I, [2013-01-23T22:49:29.089200 #94255]  INFO -- : Synchronous Calling slow api
I, [2013-01-23T22:49:29.127221 #94257]  INFO -- : EM Synchrony Calling slow api
I, [2013-01-23T22:49:29.129367 #94253]  INFO -- : Async Calling slow api
I, [2013-01-23T22:49:29.131819 #94257]  INFO -- : EM Synchrony Calling slow api
I, [2013-01-23T22:49:29.132207 #94253]  INFO -- : Async Calling slow api
I, [2013-01-23T22:49:29.135271 #94253]  INFO -- : Async Calling slow api
I, [2013-01-23T22:49:29.137390 #94253]  INFO -- : Async Calling slow api
I, [2013-01-23T22:49:29.139478 #94257]  INFO -- : EM Synchrony Calling slow api
I, [2013-01-23T22:49:29.142330 #94257]  INFO -- : EM Synchrony Calling slow api
I, [2013-01-23T22:49:32.447609 #94257]  INFO -- : EM Synchrony We got body
I, [2013-01-23T22:49:32.443074 #94255]  INFO -- : Synchronous We got body
127.0.0.1 - - [23/Jan/2013 22:49:32] "GET / HTTP/1.1" 200 33 3.3581
I, [2013-01-23T22:49:32.447299 #94255]  INFO -- : Synchronous Calling slow api
I, [2013-01-23T22:49:32.443342 #94253]  INFO -- : Async We got body
I, [2013-01-23T22:49:32.447734 #94253]  INFO -- : Async We got body
I, [2013-01-23T22:49:32.452642 #94257]  INFO -- : EM Synchrony We got body
I, [2013-01-23T22:49:32.453042 #94257]  INFO -- : EM Synchrony We got body
I, [2013-01-23T22:49:32.453338 #94257]  INFO -- : EM Synchrony We got body
I, [2013-01-23T22:49:32.574019 #94253]  INFO -- : Async We got body
I, [2013-01-23T22:49:32.636942 #94253]  INFO -- : Async We got body
I, [2013-01-23T22:49:32.652166 #94257]  INFO -- : EM Synchrony We got body
I, [2013-01-23T22:49:32.911847 #94253]  INFO -- : Async We got body
I, [2013-01-23T22:49:35.719648 #94255]  INFO -- : Synchronous We got body
127.0.0.1 - - [23/Jan/2013 22:49:35] "GET / HTTP/1.1" 200 29 3.2732
I, [2013-01-23T22:49:35.720659 #94255]  INFO -- : Synchronous Calling slow api
I, [2013-01-23T22:49:39.095270 #94255]  INFO -- : Synchronous We got body
127.0.0.1 - - [23/Jan/2013 22:49:39] "GET / HTTP/1.1" 200 35 3.3754
I, [2013-01-23T22:49:39.096748 #94255]  INFO -- : Synchronous Calling slow api
I, [2013-01-23T22:49:42.473966 #94255]  INFO -- : Synchronous We got body
127.0.0.1 - - [23/Jan/2013 22:49:42] "GET / HTTP/1.1" 200 36 3.3782
I, [2013-01-23T22:49:42.474924 #94255]  INFO -- : Synchronous Calling slow api
I, [2013-01-23T22:49:45.723494 #94255]  INFO -- : Synchronous We got body
127.0.0.1 - - [23/Jan/2013 22:49:45] "GET / HTTP/1.1" 200 40 3.2494
k

```
