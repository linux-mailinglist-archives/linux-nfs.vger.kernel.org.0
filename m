Return-Path: <linux-nfs+bounces-18838-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDd/Dd9ai2ljUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18838-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:47 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA4611D0FB
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4205303C2B3
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927F9207A09;
	Tue, 10 Feb 2026 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIElia9h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702DC31B114
	for <linux-nfs@vger.kernel.org>; Tue, 10 Feb 2026 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740432; cv=none; b=Cp/HbtF2KXpUOHjuyJQ9cl/bdVmbSqURoAfe7Jrl8Okrfh2FRAC5s+FdDFcjD9TPShdKk9dlyclBqc5J1hMCwKkZwr9p7W/px3e26oT/t+zpGtMQn0HUPaYhNQU8fqdPQH3jCUVsonXeJBFKyRPuK7MyDjGwcMANAJGgHaLSf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740432; c=relaxed/simple;
	bh=xmxJqMgpmncKEZbqd8Q+DURsJHZtQ4TQXbSt45z3CHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UC5PpoiYk1QanIO3oTI2HFPcodg45gp8hgV3AGKZVVBN6Juaz2Kfi+2qZo6E7NzxnfkERUnvEnyF6nSg3jG1Qj8JhzfPhb3qSMU1Thq0l3tAu+hr+YkAYQuu0r98/7SyneklMjvy+uLlRPlCE98dx2DHdK+OchvHh8uwnXjOods=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIElia9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99892C19425;
	Tue, 10 Feb 2026 16:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770740432;
	bh=xmxJqMgpmncKEZbqd8Q+DURsJHZtQ4TQXbSt45z3CHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mIElia9hBJBIlRTmBK94H9AX0bS9PzFaOAQqSeXBOxj928Nnp1TgpRrSnX8e7VsDt
	 eugin7lXrA+MjTwPNEmLbNkjdCzWnT4hcAR8JEoV4ESt/0cYs0wcXEukWwhwY9cyRc
	 7FqwPe2CkL+yzRR4oxzWwL56PZ4kftD3TGXiAmdI0xNrfGWoaUcvr0NQ9UEKtCU5H0
	 UmVjwpSKwaZiHFLBjPsIAgmrDnJY3eMlD+R6WcPnYWmZhxsOC0YT8SwlCgCA3nt8lF
	 i5a9relhUwnWZao+cpvWsMPKcP8KfS6uohBmvOhlSrl2CQYKIhBJ9tlNMnxHPkWWHc
	 C9oM8JoSWvFJQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 5/8] sunrpc: add dedicated TCP receiver thread
Date: Tue, 10 Feb 2026 11:20:22 -0500
Message-ID: <20260210162025.2356389-6-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210162025.2356389-1-cel@kernel.org>
References: <20260210162025.2356389-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18838-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BA4611D0FB
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Receive-side socket lock contention on NFS server TCP connections
is eliminated by dedicating one kernel thread per TCP socket to
handle all receives.

In the current architecture, multiple nfsd threads compete for
the same socket, serializing on the socket lock inside
sock_recvmsg(). A single receiver kthread per TCP connection
issues all sock_recvmsg() calls and enqueues complete RPC
messages for nfsd threads to process.

Architecture:

  Before:
    nfsd 1 --+                    +-- sock_recvmsg() --+
    nfsd 2 --+-- compete for xprt-+-- sock_recvmsg() --+- CONTENTION
    nfsd 3 --+                    +-- sock_recvmsg() --+

  After:
    Receiver kthread - sock_recvmsg() -+- nfsd 1 - process - send
         (no contention)               +- nfsd 2 - process - send
                                       +- nfsd 3 - process - send

A lock-free llist queue passes complete RPC messages from the
receiver to nfsd threads, avoiding spinlock overhead in the
fast path. Flow control limits queue depth to
SVC_TCP_MSG_QUEUE_MAX (64) messages per socket to bound
memory usage.

This mirrors the svcrdma architecture, where RDMA completion
handlers enqueue received messages for nfsd threads rather
than having nfsd threads compete for hardware resources.

NUMA Affinity:

The receiver kthread is placed on the NUMA node associated
with the service pool handling the accept, matching the NUMA
placement strategy used for nfsd threads. Page allocations
for receive buffers explicitly target this node via
__alloc_pages_bulk(), providing memory locality for the
receive path. This mirrors how svcrdma allocates resources
on the RNIC's NUMA node.

svc_tcp_data_ready() now wakes the dedicated receiver kthread
instead of enqueueing the transport for nfsd threads. If
receiver kthread creation fails during connection accept, the
connection is rejected; the client retries.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svcsock.h |  36 +++
 net/sunrpc/svcsock.c           | 502 ++++++++++++++++++++++++++++++---
 2 files changed, 498 insertions(+), 40 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index de37069aba90..b94096eeb890 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -12,6 +12,32 @@
 
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/svc_xprt.h>
+#include <linux/cache.h>
+#include <linux/llist.h>
+#include <linux/wait.h>
+#include <linux/completion.h>
+#include <linux/ktime.h>
+
+/* Maximum queued messages per TCP socket before backpressure */
+#define SVC_TCP_MSG_QUEUE_MAX	64
+
+/**
+ * struct svc_tcp_msg - queued RPC message ready for processing
+ * @tm_node: lock-free queue linkage
+ * @tm_len: total message length
+ * @tm_npages: number of pages holding message data
+ * @tm_pages: flexible array of pages containing the message
+ *
+ * Complete RPC messages are enqueued using these structures after
+ * reception. Page ownership transfers from the receiver's rqstp to
+ * this structure, then to an nfsd thread's rqstp during dequeue.
+ */
+struct svc_tcp_msg {
+	struct llist_node	tm_node;
+	size_t			tm_len;
+	unsigned int		tm_npages;
+	struct page		*tm_pages[];
+};
 
 /*
  * RPC server socket.
@@ -43,6 +69,16 @@ struct svc_sock {
 
 	struct completion	sk_handshake_done;
 
+	/* Dedicated receiver thread (TCP only) */
+	struct task_struct	*sk_receiver;
+	struct llist_head	sk_msg_queue;
+	wait_queue_head_t	sk_receiver_wq;
+	struct completion	sk_receiver_exit;
+	struct svc_page_pool	*sk_page_pool;
+	ktime_t			sk_partial_record_time;
+
+	atomic_t		sk_msg_count ____cacheline_aligned_in_smp;
+
 	/* received data */
 	unsigned long		sk_maxpages;
 	struct page *		sk_pages[] __counted_by(sk_maxpages);
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 73644f3b63c7..a89427b5fc70 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -22,6 +22,7 @@
 
 #include <linux/kernel.h>
 #include <linux/sched.h>
+#include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fcntl.h>
@@ -93,6 +94,9 @@ static int		svc_udp_sendto(struct svc_rqst *);
 static void		svc_sock_detach(struct svc_xprt *);
 static void		svc_tcp_sock_detach(struct svc_xprt *);
 static void		svc_sock_free(struct svc_xprt *);
+static int		svc_tcp_recv_msg(struct svc_rqst *);
+static int		svc_tcp_start_receiver(struct svc_sock *);
+static void		svc_tcp_stop_receiver(struct svc_sock *);
 
 static struct svc_xprt *svc_create_socket(struct svc_serv *, int,
 					  struct net *, struct sockaddr *,
@@ -423,26 +427,37 @@ static void svc_udp_data_ready(struct sock *sk)
 /**
  * svc_tcp_data_ready - sk->sk_data_ready callback for TCP sockets
  * @sk: socket whose receive buffer contains data
- *
- * Data ingest is skipped while a TLS handshake is in progress
- * (XPT_HANDSHAKE).
  */
 static void svc_tcp_data_ready(struct sock *sk)
 {
 	struct svc_sock	*svsk = (struct svc_sock *)sk->sk_user_data;
 
 	trace_sk_data_ready(sk);
+	if (!svsk)
+		return;
 
-	if (svsk) {
-		/* Refer to svc_setup_socket() for details. */
-		rmb();
+	/* Refer to svc_setup_socket() for details. */
+	rmb();
+
+	trace_svcsock_tcp_data_ready(&svsk->sk_xprt, 0);
+
+	/* During a TLS handshake, the socket fd is installed in the
+	 * handshake daemon's fdtable (see handshake_nl_accept_doit).
+	 * The daemon blocks on the standard sk->sk_wq via read()/poll(),
+	 * so sk_odata (sock_def_readable) is needed to wake it.
+	 */
+	if (test_bit(XPT_HANDSHAKE, &svsk->sk_xprt.xpt_flags)) {
 		svsk->sk_odata(sk);
-		trace_svcsock_tcp_data_ready(&svsk->sk_xprt, 0);
-		if (test_bit(XPT_HANDSHAKE, &svsk->sk_xprt.xpt_flags))
-			return;
-		if (!test_and_set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags))
-			svc_xprt_enqueue(&svsk->sk_xprt);
+		return;
 	}
+
+	/* Skip sk_odata: the dedicated receiver kthread waits on
+	 * sk_receiver_wq, not sk->sk_wq, so sk_odata (sock_def_readable)
+	 * would invoke rcu_read_lock, skwq_has_sleeper, and
+	 * sk_wake_async_rcu on every TCP segment with no effect.
+	 */
+	if (wq_has_sleeper(&svsk->sk_receiver_wq))
+		wake_up(&svsk->sk_receiver_wq);
 }
 
 /*
@@ -934,8 +949,10 @@ static void svc_tcp_state_change(struct sock *sk)
 		rmb();
 		svsk->sk_ostate(sk);
 		trace_svcsock_tcp_state(&svsk->sk_xprt, svsk->sk_sock);
-		if (sk->sk_state != TCP_ESTABLISHED)
+		if (sk->sk_state != TCP_ESTABLISHED) {
 			svc_xprt_deferred_close(&svsk->sk_xprt);
+			wake_up(&svsk->sk_receiver_wq);
+		}
 	}
 }
 
@@ -1003,8 +1020,22 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
 	if (serv->sv_stats)
 		serv->sv_stats->nettcpconn++;
 
+	/*
+	 * Disable busy polling for this socket. The receiver kthread
+	 * blocks in sock_recvmsg() waiting for data on a single
+	 * connection. Busy polling adds CPU overhead without reducing
+	 * latency.
+	 */
+	WRITE_ONCE(newsock->sk->sk_ll_usec, 0);
+
+	if (svc_tcp_start_receiver(newsvsk) < 0)
+		goto failed_start;
+
 	return &newsvsk->sk_xprt;
 
+failed_start:
+	svc_xprt_put(&newsvsk->sk_xprt);
+	return NULL;
 failed:
 	sockfd_put(newsock);
 	return NULL;
@@ -1151,25 +1182,375 @@ static void svc_tcp_fragment_received(struct svc_sock *svsk)
 	svsk->sk_marker = xdr_zero;
 }
 
-/**
- * svc_tcp_recvfrom - Receive data from a TCP socket
- * @rqstp: request structure into which to receive an RPC Call
- *
- * Called in a loop when XPT_DATA has been set.
- *
- * Read the 4-byte stream record marker, then use the record length
- * in that marker to set up exactly the resources needed to receive
- * the next RPC message into @rqstp.
- *
- * Returns:
- *   On success, the number of bytes in a received RPC Call, or
- *   %0 if a complete RPC Call message was not ready to return
- *
- * The zero return case handles partial receives and callback Replies.
- * The state of a partial receive is preserved in the svc_sock for
- * the next call to svc_tcp_recvfrom.
+static struct svc_tcp_msg *svc_tcp_msg_alloc(unsigned int npages)
+{
+	return kmalloc(struct_size_t(struct svc_tcp_msg, tm_pages, npages),
+		       GFP_KERNEL);
+}
+
+static void svc_tcp_msg_free(struct svc_tcp_msg *msg)
+{
+	unsigned int i;
+
+	for (i = 0; i < msg->tm_npages; i++)
+		if (msg->tm_pages[i])
+			put_page(msg->tm_pages[i]);
+	kfree(msg);
+}
+
+static void svc_tcp_drain_msg_queue(struct svc_sock *svsk)
+{
+	struct llist_node *node;
+	struct svc_tcp_msg *msg;
+
+	while ((node = llist_del_first(&svsk->sk_msg_queue)) != NULL) {
+		msg = llist_entry(node, struct svc_tcp_msg, tm_node);
+		atomic_dec(&svsk->sk_msg_count);
+		svc_tcp_msg_free(msg);
+	}
+}
+
+static inline void svc_tcp_setup_rqst(struct svc_rqst *rqstp,
+				      struct svc_xprt *xprt)
+{
+	rqstp->rq_xprt_ctxt = NULL;
+	rqstp->rq_prot = IPPROTO_TCP;
+	if (test_bit(XPT_LOCAL, &xprt->xpt_flags))
+		set_bit(RQ_LOCAL, &rqstp->rq_flags);
+	else
+		clear_bit(RQ_LOCAL, &rqstp->rq_flags);
+}
+
+/*
+ * Transfer page ownership from @msg to @rqstp and set up the xdr_buf
+ * for RPC processing.
  */
-static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
+static void svc_tcp_msg_to_rqst(struct svc_rqst *rqstp, struct svc_tcp_msg *msg)
+{
+	struct svc_sock *svsk = container_of(rqstp->rq_xprt,
+					     struct svc_sock, sk_xprt);
+	struct svc_page_pool *pool = svsk->sk_page_pool;
+	unsigned int i;
+
+	for (i = 0; i < msg->tm_npages; i++) {
+		if (rqstp->rq_pages[i])
+			svc_page_pool_put(pool, rqstp->rq_pages[i]);
+		rqstp->rq_pages[i] = msg->tm_pages[i];
+		msg->tm_pages[i] = NULL;
+	}
+
+	rqstp->rq_arg.head[0].iov_base = page_address(rqstp->rq_pages[0]);
+	rqstp->rq_arg.head[0].iov_len = min_t(size_t, msg->tm_len, PAGE_SIZE);
+	rqstp->rq_arg.pages = rqstp->rq_pages + 1;
+	rqstp->rq_arg.page_base = 0;
+	if (msg->tm_len <= PAGE_SIZE)
+		rqstp->rq_arg.page_len = 0;
+	else
+		rqstp->rq_arg.page_len = msg->tm_len - PAGE_SIZE;
+	rqstp->rq_arg.len = msg->tm_len;
+	rqstp->rq_arg.buflen = msg->tm_npages * PAGE_SIZE;
+
+	rqstp->rq_respages = &rqstp->rq_pages[msg->tm_npages];
+	rqstp->rq_next_page = rqstp->rq_respages + 1;
+	svc_xprt_copy_addrs(rqstp, rqstp->rq_xprt);
+	svc_tcp_setup_rqst(rqstp, rqstp->rq_xprt);
+}
+
+static int svc_tcp_queue_msg(struct svc_sock *svsk, struct svc_rqst *rqstp)
+{
+	struct svc_tcp_msg *msg;
+	unsigned int npages;
+	unsigned int i;
+
+	npages = DIV_ROUND_UP(rqstp->rq_arg.len, PAGE_SIZE);
+	msg = svc_tcp_msg_alloc(npages);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->tm_len = rqstp->rq_arg.len;
+	msg->tm_npages = npages;
+
+	for (i = 0; i < npages; i++) {
+		msg->tm_pages[i] = rqstp->rq_pages[i];
+		rqstp->rq_pages[i] = NULL;
+	}
+
+	llist_add(&msg->tm_node, &svsk->sk_msg_queue);
+	atomic_inc(&svsk->sk_msg_count);
+
+	return 0;
+}
+
+static int svc_tcp_receiver_alloc_pages(struct svc_rqst *rqstp)
+{
+	struct svc_sock *svsk = container_of(rqstp->rq_xprt,
+					     struct svc_sock, sk_xprt);
+	struct svc_page_pool *pool = svsk->sk_page_pool;
+	unsigned long pages, filled, ret;
+	struct page *page;
+
+	pages = rqstp->rq_maxpages;
+
+	for (filled = 0; filled < pages; filled++) {
+		page = svc_page_pool_get(pool);
+		if (!page)
+			break;
+		rqstp->rq_pages[filled] = page;
+	}
+	while (filled < pages) {
+		ret = __alloc_pages_bulk(GFP_KERNEL, pool->pp_numa_node, NULL,
+					 pages - filled,
+					 rqstp->rq_pages + filled);
+		if (ret == 0) {
+			while (filled--)
+				put_page(rqstp->rq_pages[filled]);
+			return -ENOMEM;
+		}
+		filled += ret;
+	}
+
+	rqstp->rq_page_end = &rqstp->rq_pages[pages];
+	rqstp->rq_pages[pages] = NULL;
+	rqstp->rq_arg.head[0].iov_base = page_address(rqstp->rq_pages[0]);
+	rqstp->rq_arg.head[0].iov_len = PAGE_SIZE;
+	rqstp->rq_arg.pages = rqstp->rq_pages + 1;
+	rqstp->rq_arg.page_base = 0;
+	rqstp->rq_arg.page_len = (pages - 2) * PAGE_SIZE;
+	rqstp->rq_arg.len = (pages - 1) * PAGE_SIZE;
+	rqstp->rq_arg.tail[0].iov_len = 0;
+
+	return 0;
+}
+
+static inline bool svc_tcp_receiver_can_work(struct svc_sock *svsk)
+{
+	return tcp_inq(svsk->sk_sk) > 0 &&
+	       atomic_read(&svsk->sk_msg_count) < SVC_TCP_MSG_QUEUE_MAX;
+}
+
+static int svc_tcp_receiver_rqst_init(struct svc_rqst *rqstp,
+				      struct svc_sock *svsk)
+{
+	struct svc_serv *serv = svsk->sk_xprt.xpt_server;
+
+	memset(rqstp, 0, sizeof(*rqstp));
+	rqstp->rq_server = serv;
+	rqstp->rq_maxpages = svc_serv_maxpages(serv);
+	rqstp->rq_pages = kcalloc(rqstp->rq_maxpages + 1,
+				  sizeof(struct page *), GFP_KERNEL);
+	if (!rqstp->rq_pages)
+		return -ENOMEM;
+	rqstp->rq_bvec = kcalloc(rqstp->rq_maxpages,
+				 sizeof(struct bio_vec), GFP_KERNEL);
+	if (!rqstp->rq_bvec) {
+		kfree(rqstp->rq_pages);
+		return -ENOMEM;
+	}
+	rqstp->rq_xprt = &svsk->sk_xprt;
+
+	if (svc_tcp_receiver_alloc_pages(rqstp) < 0) {
+		kfree(rqstp->rq_bvec);
+		kfree(rqstp->rq_pages);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void svc_tcp_receiver_rqst_free(struct svc_rqst *rqstp)
+{
+	unsigned int i;
+
+	for (i = 0; i < rqstp->rq_maxpages; i++)
+		if (rqstp->rq_pages[i])
+			put_page(rqstp->rq_pages[i]);
+	kfree(rqstp->rq_bvec);
+	kfree(rqstp->rq_pages);
+}
+
+/*
+ * Receive complete RPC messages and queue them for nfsd threads.
+ * Return true if at least one message was queued.
+ */
+static noinline bool
+svc_tcp_recv_and_queue(struct svc_sock *svsk, struct svc_rqst *rqstp)
+{
+	bool progress = false;
+	int len;
+
+	while (!kthread_should_stop() &&
+	       !test_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags)) {
+		if (atomic_read(&svsk->sk_msg_count) >=
+		    SVC_TCP_MSG_QUEUE_MAX)
+			break;
+
+		len = svc_tcp_recv_msg(rqstp);
+		if (len <= 0)
+			break;
+
+		progress = true;
+		if (svc_tcp_queue_msg(svsk, rqstp) < 0) {
+			svc_xprt_deferred_close(&svsk->sk_xprt);
+			break;
+		}
+		if (svc_tcp_receiver_alloc_pages(rqstp) < 0) {
+			svc_xprt_deferred_close(&svsk->sk_xprt);
+			break;
+		}
+	}
+
+	return progress;
+}
+
+/*
+ * Check for a stalled partial RPC record. Enable keepalives to
+ * probe the peer; close the connection if it has already failed
+ * or the stall exceeds a timeout.
+ *
+ * Return true if the connection should be closed.
+ */
+static noinline bool
+svc_tcp_check_partial_record(struct svc_sock *svsk, bool progress)
+{
+	struct sock *sk = svsk->sk_sk;
+
+	if (!progress && svsk->sk_tcplen > 0) {
+		if (sk->sk_state != TCP_ESTABLISHED || sk->sk_err) {
+			svc_xprt_deferred_close(&svsk->sk_xprt);
+			return true;
+		}
+
+		if (!sock_flag(sk, SOCK_KEEPOPEN)) {
+			sock_set_keepalive(sk);
+			tcp_sock_set_keepidle(sk, 10);
+			tcp_sock_set_keepintvl(sk, 5);
+			tcp_sock_set_keepcnt(sk, 3);
+		}
+
+		if (!svsk->sk_partial_record_time) {
+			svsk->sk_partial_record_time = ktime_get();
+		} else if (ktime_ms_delta(ktime_get(),
+				svsk->sk_partial_record_time) > 60000) {
+			svc_xprt_deferred_close(&svsk->sk_xprt);
+			return true;
+		}
+	} else if (progress) {
+		svsk->sk_partial_record_time = 0;
+	}
+
+	return false;
+}
+
+/*
+ * Dedicated receiver kthread for a TCP socket. All sock_recvmsg()
+ * calls for this connection occur in this context, eliminating
+ * socket lock contention between nfsd threads. Complete RPC
+ * messages are enqueued for nfsd threads to process.
+ */
+static int svc_tcp_receiver_thread(void *data)
+{
+	struct svc_sock *svsk = data;
+	struct svc_rqst rqstp_storage;
+	struct svc_rqst *rqstp = &rqstp_storage;
+	bool progress;
+
+	if (svc_tcp_receiver_rqst_init(rqstp, svsk) < 0) {
+		svc_xprt_deferred_close(&svsk->sk_xprt);
+		complete(&svsk->sk_receiver_exit);
+		return 0;
+	}
+
+	while (!kthread_should_stop() &&
+	       !test_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags)) {
+		/*
+		 * Wait until data arrives and the message queue has
+		 * room. Use a timeout when a partial RPC record
+		 * remains so connection health is checked periodically.
+		 */
+		if (svsk->sk_tcplen > 0)
+			wait_event_interruptible_timeout(svsk->sk_receiver_wq,
+				svc_tcp_receiver_can_work(svsk) ||
+				test_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags) ||
+				kthread_should_stop(),
+				msecs_to_jiffies(5000));
+		else
+			wait_event_interruptible(svsk->sk_receiver_wq,
+				svc_tcp_receiver_can_work(svsk) ||
+				test_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags) ||
+				kthread_should_stop());
+
+		progress = svc_tcp_recv_and_queue(svsk, rqstp);
+
+		if (!llist_empty(&svsk->sk_msg_queue)) {
+			set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
+			svc_xprt_enqueue(&svsk->sk_xprt);
+		}
+
+		if (svc_tcp_check_partial_record(svsk, progress))
+			break;
+	}
+
+	svc_tcp_receiver_rqst_free(rqstp);
+	complete(&svsk->sk_receiver_exit);
+	return 0;
+}
+
+static int svc_tcp_start_receiver(struct svc_sock *svsk)
+{
+	struct svc_serv *serv = svsk->sk_xprt.xpt_server;
+	struct svc_page_pool *pool;
+	struct task_struct *task;
+	int numa_node;
+
+	/* The wait queue is initialized earlier in svc_tcp_init()
+	 * so svc_tcp_data_ready() can wake it before this function
+	 * runs.
+	 */
+	init_llist_head(&svsk->sk_msg_queue);
+	init_completion(&svsk->sk_receiver_exit);
+	atomic_set(&svsk->sk_msg_count, 0);
+
+	numa_node = svc_pool_node(svc_pool_for_cpu(serv));
+	pool = svc_page_pool_alloc(numa_node, svsk->sk_maxpages);
+	if (!pool)
+		return -ENOMEM;
+	svsk->sk_page_pool = pool;
+
+	task = kthread_create_on_node(svc_tcp_receiver_thread, svsk,
+				      numa_node, "tcp-recv/%s",
+				      svsk->sk_xprt.xpt_remotebuf);
+	if (IS_ERR(task)) {
+		svc_page_pool_free(pool);
+		svsk->sk_page_pool = NULL;
+		return PTR_ERR(task);
+	}
+
+	svsk->sk_receiver = task;
+	wake_up_process(task);
+	return 0;
+}
+
+static void svc_tcp_stop_receiver(struct svc_sock *svsk)
+{
+	if (!svsk->sk_receiver)
+		return;
+
+	wake_up(&svsk->sk_receiver_wq);
+	kthread_stop(svsk->sk_receiver);
+	wait_for_completion(&svsk->sk_receiver_exit);
+	svsk->sk_receiver = NULL;
+
+	svc_tcp_drain_msg_queue(svsk);
+	svc_page_pool_free(svsk->sk_page_pool);
+	svsk->sk_page_pool = NULL;
+}
+
+/*
+ * Called only by the dedicated receiver kthread. Does not call
+ * svc_xprt_received() because the receiver implements its own
+ * event loop separate from the nfsd thread pool.
+ */
+static int svc_tcp_recv_msg(struct svc_rqst *rqstp)
 {
 	struct svc_sock	*svsk =
 		container_of(rqstp->rq_xprt, struct svc_sock, sk_xprt);
@@ -1179,7 +1560,6 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	__be32 *p;
 	__be32 calldir;
 
-	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 	len = svc_tcp_read_marker(svsk, rqstp);
 	if (len < 0)
 		goto error;
@@ -1205,12 +1585,7 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	} else
 		rqstp->rq_arg.page_len = rqstp->rq_arg.len - rqstp->rq_arg.head[0].iov_len;
 
-	rqstp->rq_xprt_ctxt   = NULL;
-	rqstp->rq_prot	      = IPPROTO_TCP;
-	if (test_bit(XPT_LOCAL, &svsk->sk_xprt.xpt_flags))
-		set_bit(RQ_LOCAL, &rqstp->rq_flags);
-	else
-		clear_bit(RQ_LOCAL, &rqstp->rq_flags);
+	svc_tcp_setup_rqst(rqstp, &svsk->sk_xprt);
 
 	p = (__be32 *)rqstp->rq_arg.head[0].iov_base;
 	calldir = p[1];
@@ -1229,7 +1604,6 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 		serv->sv_stats->nettcpcnt++;
 
 	svc_sock_secure_port(rqstp);
-	svc_xprt_received(rqstp->rq_xprt);
 	return rqstp->rq_arg.len;
 
 err_incomplete:
@@ -1254,10 +1628,55 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	trace_svcsock_tcp_recv_err(&svsk->sk_xprt, len);
 	svc_xprt_deferred_close(&svsk->sk_xprt);
 err_noclose:
-	svc_xprt_received(rqstp->rq_xprt);
 	return 0;	/* record not complete */
 }
 
+/**
+ * svc_tcp_recvfrom - Receive an RPC Call from a TCP socket
+ * @rqstp: request structure into which to receive an RPC Call
+ *
+ * Return values:
+ *   %0: no complete message ready
+ *   positive: length of received RPC Call, in bytes
+ */
+static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
+{
+	struct svc_sock *svsk = container_of(rqstp->rq_xprt,
+					     struct svc_sock, sk_xprt);
+	struct llist_node *node;
+	struct svc_tcp_msg *msg;
+	int len;
+
+	node = llist_del_first(&svsk->sk_msg_queue);
+	if (!node) {
+		clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
+		svc_xprt_received(rqstp->rq_xprt);
+		return 0;
+	}
+
+	msg = llist_entry(node, struct svc_tcp_msg, tm_node);
+
+	/*
+	 * Wake the receiver when the queue drops below the threshold.
+	 * The receiver may be blocked waiting for queue space.
+	 */
+	if (atomic_dec_return(&svsk->sk_msg_count) == SVC_TCP_MSG_QUEUE_MAX - 1)
+		wake_up_interruptible(&svsk->sk_receiver_wq);
+
+	svc_tcp_msg_to_rqst(rqstp, msg);
+	len = rqstp->rq_arg.len;
+
+	svc_sock_secure_port(rqstp);
+
+	if (llist_empty(&svsk->sk_msg_queue))
+		clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
+
+	svc_xprt_received(rqstp->rq_xprt);
+	kfree(msg);
+
+	return len;
+}
+
 /*
  * MSG_SPLICE_PAGES is used exclusively to reduce the number of
  * copy operations in this path. Therefore the caller must ensure
@@ -1394,6 +1813,8 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 		sk->sk_data_ready = svc_tcp_listen_data_ready;
 		set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
 	} else {
+		init_waitqueue_head(&svsk->sk_receiver_wq);
+
 		sk->sk_state_change = svc_tcp_state_change;
 		sk->sk_data_ready = svc_tcp_data_ready;
 		sk->sk_write_space = svc_write_space;
@@ -1406,7 +1827,6 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 
 		tcp_sock_set_nodelay(sk);
 
-		set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 		switch (sk->sk_state) {
 		case TCP_SYN_RECV:
 		case TCP_ESTABLISHED:
@@ -1677,6 +2097,8 @@ static void svc_tcp_sock_detach(struct svc_xprt *xprt)
 {
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
 
+	svc_tcp_stop_receiver(svsk);
+
 	tls_handshake_close(svsk->sk_sock);
 
 	svc_sock_detach(xprt);
-- 
2.52.0


