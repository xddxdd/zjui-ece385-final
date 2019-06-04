#include "httpc.h"
#include <string.h>
#include <time.h>
#include "ethernet.h"

httpc_connection_t httpc_connection_settings = {
		IP4_ADDR_ANY4,
		0,
		0,
		httpc_request_finish,
		NULL
};

err_t httpc_callback(void *arg, struct tcp_pcb *tpcb, struct pbuf *p, err_t err) {
	struct pbuf* ptr = p;
	httpc_request* result = (httpc_request*) arg;
	int len_done = 0;
	while(ptr) {
		if(!arg) {
			// No position to store result, print it out instead
			for(int i = 0; i < ptr->len; i++) {
				putchar(((char*) ptr->payload)[i]);
			}
		} else {
			// Copy result to storage
			memcpy(result->data + len_done, ptr->payload, ptr->len);
			len_done += ptr->len;
		}
		ptr = ptr->next;
	}

	result->processing = 0;
	result->error = err;

	return ERR_OK;
}

void httpc_request_finish(void *arg, httpc_result_t httpc_result, u32_t rx_content_len, u32_t srv_res, err_t err) {
	if(!arg) return;
	httpc_request* result = (httpc_request*) arg;
	result->processing = 0;
	result->error = err;
}

void httpc_send_request(const char* server, uint16_t port, const char* uri, httpc_request* req) {
	if(eth0_ip() == 0) {
		req->error = 1;
		req->processing = 0;
		return;
	}

	err_t err;
	if(ERR_OK != (err = httpc_get_file_dns(server, port, uri, &httpc_connection_settings, httpc_callback, req, NULL))) {
		req->error = err;
		req->processing = 0;
	} else {
		req->processing = 1;
	}
}

int httpc_processing(httpc_request* req) {
	return req->processing;
}

int httpc_success(httpc_request* req) {
	return req->error == ERR_OK;
}
