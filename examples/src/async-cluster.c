/*
 * gcc -levent_core -lhiredis_vip -L/usr/local/lib -L/usr/lib64 -o example-async example-async.c
*/

#include <stdio.h>
#include <hircluster.h>
#include <adapters/libevent.h>
 
#pragma comment (lib, "ws2_32.lib")

int all_count=0;

typedef struct calldata
{
	redisClusterAsyncContext *acc;
	int count;
}calldata;

void getCallback(redisClusterAsyncContext *acc, void *r, void *privdata)
{
	redisReply *reply = r;
	int count =  *(int*)privdata;
	all_count ++;
	if(all_count >= count)
	{
		redisClusterAsyncDisconnect(acc);
	}
}

void connectCallback(const redisAsyncContext *c, int status)
{
	if (status != REDIS_OK) {
		printf("Error: %s\n", c->errstr);
		return;
	}
	printf("%s -> %s:%d connected...\n", c->c.tcp.source_addr, c->c.tcp.host, c->c.tcp.port);
}

void disconnectCallback(const redisAsyncContext *c, int status)
{
	if (status != REDIS_OK) {
		printf("Error: %s\n", c->errstr);
		return;
	}
	
    printf("%s -> %s:%d disconnected...\n", c->c.tcp.source_addr, c->c.tcp.host, c->c.tcp.port);
}

int main(int argc, char **argv)
{
    int status, i;
    struct event_base *base;
    
#ifdef _WIN32
    WSADATA wsa_data;
    WSAStartup(0x0201, &wsa_data);
#endif

    base = event_base_new();
	redisClusterAsyncContext *acc = redisClusterAsyncConnect("135.251.249.241:7000", 
		HIRCLUSTER_FLAG_NULL);
	if (acc->err)
	{
		printf("Error: %s\n", acc->errstr);
		return 1;
	}
	redisClusterLibeventAttach(acc,base);
	redisClusterAsyncSetConnectCallback(acc,connectCallback);
	redisClusterAsyncSetDisconnectCallback(acc,disconnectCallback);
	
	int count = 200;
	for(i = 0; i < 200; i ++)
	{
		status = redisClusterAsyncCommand(acc, getCallback, &count, "set %d %d", i, i);
		if(status != REDIS_OK)
		{
			printf("error: %d %s\n", acc->err, acc->errstr);
		}
	}
	
	event_base_dispatch(base);
#ifdef _WIN32
    WSACleanup();
#endif

    return 0;
}
