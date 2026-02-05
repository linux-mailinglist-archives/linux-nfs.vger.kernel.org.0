Return-Path: <linux-nfs+bounces-18759-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF7XKGe/hGnG4wMAu9opvQ
	(envelope-from <linux-nfs+bounces-18759-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 17:03:51 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0678EF4EE2
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 17:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20614309EF48
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Feb 2026 15:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF44F42B757;
	Thu,  5 Feb 2026 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYdray/k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D229421F10
	for <linux-nfs@vger.kernel.org>; Thu,  5 Feb 2026 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307056; cv=none; b=O3/UQYo7Fe/+HD5j2maRu9w9zPaMzEKp49k5EAb1rNspGQv2IlS20aw1zTnYPDLaOJKTv+PcSE/GWLc622dMCIlkjbc7u7Xk+f0QlssijwbbnLHjC+TEm0Xx0RFvKbpc2VHMNA4o1OC7eVMf24mAIdYlBm0wV8ifij4jROrHuo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307056; c=relaxed/simple;
	bh=4bwKrjPYgQfLTJsWP8Mk68C44biuznbM9ThV3oGT1gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdCKOrcogBue95fcxtiRGde0JXSxYmm60yiTVjzAP9u41BYlsMcuY2GjZQBqoToA6cK6T410I+uNJFDkF2R5hg3j7QQ9cg7YLz//9gXm+RUlfLoA1kLJyHty6e8XDfs/FHTyJ1sZthA4IysPxFVQumNYaCmvJeMac4+G6vuLkOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYdray/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5584C4CEF7;
	Thu,  5 Feb 2026 15:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770307056;
	bh=4bwKrjPYgQfLTJsWP8Mk68C44biuznbM9ThV3oGT1gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fYdray/kXDmIuYGY1C5HxMN4qTfdynDJQVkrim8ENPTNC2D5FI3kZafz8+tdWdicL
	 jg8Ka2cimUOGTY5+XXdyU6/ybewJo11Oj8pUI9gI2z+pbYPG+sc5xIhvm4ZTRJz6Q8
	 3wwzueJV1ErB9HmV9NO8qj82JvqO4UoY2vlwWpoyPruACAqMTsRabKX1OvdaI6TeFh
	 CR+cOHirOSzWxJOO3ijGHHIofKzkVBnHMlthO5i5/0WkqI0azqNP7B+Yox/f1fBMxf
	 RjI8t3oQEGwsfe19IsKZe5fLZb5Ddar0voB6JRW1o9dxlGWKOjH5TEhB+9AqxEiHCh
	 I95L7OVa02ssg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	daire@dneg.com,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 4/7] sunrpc: add dedicated TCP receiver thread
Date: Thu,  5 Feb 2026 10:57:26 -0500
Message-ID: <20260205155729.6841-5-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205155729.6841-1-cel@kernel.org>
References: <20260205155729.6841-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18759-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,dneg.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0678EF4EE2
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Eliminate receive-side socket lock contention for NFS server TCP
connections by dedicating one kernel thread per TCP socket to handle
all receives.

Current architecture has multiple nfsd worker threads competing for
the same socket, serializing on socket lock inside sock_recvmsg().
The new design creates a single receiver thread per TCP connection
that owns all sock_recvmsg() calls and queues complete RPC messages
for workers to process.

Architecture:

  Before:
    Worker 1 --+                     +-- sock_recvmsg() --+
    Worker 2 --+-- compete for xprt--+-- sock_recvmsg() --+-- CONTENTION
    Worker 3 --+                     +-- sock_recvmsg() --+

  After:
    Receiver Thread -- sock_recvmsg() --+-- Worker 1 -- process -- send
          (no contention)               +-- Worker 2 -- process -- send
                                        +-- Worker 3 -- process -- send

The receiver thread uses a lock-free llist queue to pass complete RPC
messages to worker threads, avoiding spinlock overhead in the fast
path. Flow control limits queue depth to SVC_TCP_MSG_QUEUE_MAX (64)
messages per socket to bound memory usage.

This mirrors the architecture used by svcrdma, where RDMA completion
handlers queue received messages for worker threads rather than having
workers compete for hardware resources.

NUMA Affinity:

The receiver thread is created on the NUMA node associated with the
service pool handling the accept, following the same NUMA placement
strategy used for nfsd worker threads. Page allocations for receive
buffers explicitly target this node via __alloc_pages_bulk(),
providing memory locality for the receive path. This mirrors how
svcrdma allocates resources on the RNIC's NUMA node.

svc_tcp_data_ready() now wakes the dedicated receiver thread instead
of enqueueing the transport for worker threads. If receiver thread
creation fails during connection accept, the connection is rejected;
the client will retry.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svcsock.h |  36 +++
 net/sunrpc/svcsock.c           | 472 ++++++++++++++++++++++++++++++---
 2 files changed, 477 insertions(+), 31 deletions(-)

diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index de37069aba90..391ce9c14f2d 100644
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
+ * The receiver thread allocates these to queue complete RPC messages
+ * for worker threads to process. Page ownership transfers from the
+ * receiver's rqstp to this structure, then to the worker's rqstp.
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
index 3ec50812b110..fa486a01ee3a 100644
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
@@ -440,8 +444,7 @@ static void svc_tcp_data_ready(struct sock *sk)
 		trace_svcsock_data_ready(&svsk->sk_xprt, 0);
 		if (test_bit(XPT_HANDSHAKE, &svsk->sk_xprt.xpt_flags))
 			return;
-		if (!test_and_set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags))
-			svc_xprt_enqueue(&svsk->sk_xprt);
+		wake_up(&svsk->sk_receiver_wq);
 	}
 }
 
@@ -934,8 +937,15 @@ static void svc_tcp_state_change(struct sock *sk)
 		rmb();
 		svsk->sk_ostate(sk);
 		trace_svcsock_tcp_state(&svsk->sk_xprt, svsk->sk_sock);
-		if (sk->sk_state != TCP_ESTABLISHED)
+		if (sk->sk_state != TCP_ESTABLISHED) {
 			svc_xprt_deferred_close(&svsk->sk_xprt);
+			/*
+			 * Wake the receiver thread so it sees XPT_CLOSE.
+			 * Without this, a receiver sleeping in wait_event
+			 * may not notice the connection has died.
+			 */
+			wake_up(&svsk->sk_receiver_wq);
+		}
 	}
 }
 
@@ -1003,8 +1013,22 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
 	if (serv->sv_stats)
 		serv->sv_stats->nettcpconn++;
 
+	/*
+	 * Disable busy polling for this socket. The dedicated receiver
+	 * thread does not benefit from busy polling since it is already
+	 * dedicated to this connection and will block in sock_recvmsg()
+	 * waiting for data. Busy polling just wastes CPU cycles.
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
@@ -1151,25 +1175,365 @@ static void svc_tcp_fragment_received(struct svc_sock *svsk)
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
+/*
+ * Dedicated receiver thread for a TCP socket. This thread owns all
+ * sock_recvmsg() calls for its connection, eliminating socket lock
+ * contention between workers. Complete RPC messages are queued for
+ * worker threads to process.
+ */
+static int svc_tcp_receiver_thread(void *data)
+{
+	struct svc_sock *svsk = data;
+	struct svc_serv *serv = svsk->sk_xprt.xpt_server;
+	struct svc_rqst rqstp_storage;
+	struct svc_rqst *rqstp = &rqstp_storage;
+	unsigned int i;
+	bool progress;
+	int len;
+
+	memset(rqstp, 0, sizeof(*rqstp));
+	rqstp->rq_server = serv;
+	rqstp->rq_maxpages = svc_serv_maxpages(serv);
+	rqstp->rq_pages = kcalloc(rqstp->rq_maxpages + 1,
+				  sizeof(struct page *), GFP_KERNEL);
+	if (!rqstp->rq_pages)
+		goto out_close;
+	rqstp->rq_bvec = kcalloc(rqstp->rq_maxpages,
+				 sizeof(struct bio_vec), GFP_KERNEL);
+	if (!rqstp->rq_bvec)
+		goto out_close_free_pages;
+	rqstp->rq_xprt = &svsk->sk_xprt;
+
+	if (svc_tcp_receiver_alloc_pages(rqstp) < 0)
+		goto out_close_free_bvec;
+
+	while (!kthread_should_stop() &&
+	       !test_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags)) {
+		/*
+		 * Wait until there is data in the socket and room in
+		 * the message queue. The condition is re-evaluated on
+		 * each wakeup, so spurious wakeups are harmless.
+		 *
+		 * Use a timeout when there is a partial RPC record.
+		 * This ensures periodic checks of the connection state
+		 * and timeout counters even if no new data arrives.
+		 */
+#define receiver_can_work(svsk) \
+		(tcp_inq((svsk)->sk_sk) > 0 && \
+		 atomic_read(&(svsk)->sk_msg_count) < SVC_TCP_MSG_QUEUE_MAX)
+
+		if (svsk->sk_tcplen > 0)
+			wait_event_interruptible_timeout(svsk->sk_receiver_wq,
+				receiver_can_work(svsk) ||
+				test_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags) ||
+				kthread_should_stop(),
+				msecs_to_jiffies(5000));
+		else
+			wait_event_interruptible(svsk->sk_receiver_wq,
+				receiver_can_work(svsk) ||
+				test_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags) ||
+				kthread_should_stop());
+#undef receiver_can_work
+
+		progress = false;
+		while (!kthread_should_stop() &&
+		       !test_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags)) {
+			if (atomic_read(&svsk->sk_msg_count) >=
+			    SVC_TCP_MSG_QUEUE_MAX)
+				break;
+
+			len = svc_tcp_recv_msg(rqstp);
+			if (len <= 0)
+				break;
+
+			progress = true;
+			if (svc_tcp_queue_msg(svsk, rqstp) < 0) {
+				svc_xprt_deferred_close(&svsk->sk_xprt);
+				break;
+			}
+			if (svc_tcp_receiver_alloc_pages(rqstp) < 0) {
+				svc_xprt_deferred_close(&svsk->sk_xprt);
+				break;
+			}
+		}
+
+		if (!llist_empty(&svsk->sk_msg_queue)) {
+			set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
+			svc_xprt_enqueue(&svsk->sk_xprt);
+		}
+
+		/*
+		 * Detect defunct connections with partial RPC records.
+		 * If data sits in the socket buffer but we cannot form
+		 * a complete RPC record, the client may have crashed
+		 * mid-request. Enable keepalives to probe the peer;
+		 * TCP will call state_change when the connection fails.
+		 */
+		if (!progress && svsk->sk_tcplen > 0) {
+			struct sock *sk = svsk->sk_sk;
+
+			/*
+			 * Check if TCP has already detected the dead peer.
+			 * state_change sets XPT_CLOSE, but we may have
+			 * missed the wake_up if we were not yet sleeping.
+			 */
+			if (sk->sk_state != TCP_ESTABLISHED || sk->sk_err) {
+				svc_xprt_deferred_close(&svsk->sk_xprt);
+				break;
+			}
+
+			/*
+			 * Still ESTABLISHED but stuck with partial record.
+			 * Enable keepalives to probe the peer. Use short
+			 * intervals to bound the time before detecting a
+			 * dead client.
+			 */
+			if (!sock_flag(sk, SOCK_KEEPOPEN)) {
+				sock_set_keepalive(sk);
+				tcp_sock_set_keepidle(sk, 10);
+				tcp_sock_set_keepintvl(sk, 5);
+				tcp_sock_set_keepcnt(sk, 3);
+			}
+
+			/*
+			 * Track how long we have been stuck. If keepalives
+			 * have not closed the connection after a reasonable
+			 * period, give up. This is a backstop against
+			 * pathological cases where keepalive probes succeed
+			 * but the client never sends more data.
+			 */
+			if (!svsk->sk_partial_record_time) {
+				svsk->sk_partial_record_time = ktime_get();
+			} else if (ktime_ms_delta(ktime_get(),
+					svsk->sk_partial_record_time) > 60000) {
+				svc_xprt_deferred_close(&svsk->sk_xprt);
+				break;
+			}
+		} else if (progress) {
+			svsk->sk_partial_record_time = 0;
+		}
+	}
+
+	for (i = 0; i < rqstp->rq_maxpages; i++)
+		if (rqstp->rq_pages[i])
+			put_page(rqstp->rq_pages[i]);
+
+	kfree(rqstp->rq_bvec);
+	kfree(rqstp->rq_pages);
+	complete(&svsk->sk_receiver_exit);
+	return 0;
+
+out_close_free_bvec:
+	kfree(rqstp->rq_bvec);
+out_close_free_pages:
+	kfree(rqstp->rq_pages);
+out_close:
+	svc_xprt_deferred_close(&svsk->sk_xprt);
+	complete(&svsk->sk_receiver_exit);
+	return 0;
+}
+
+/*
+ * The thread is created on the NUMA node associated with the current
+ * CPU's service pool, providing memory locality for receive buffer
+ * allocations.
+ */
+static int svc_tcp_start_receiver(struct svc_sock *svsk)
+{
+	struct svc_serv *serv = svsk->sk_xprt.xpt_server;
+	struct svc_page_pool *pool;
+	struct task_struct *task;
+	int numa_node;
+
+	/* Initialize receiver thread infrastructure.
+	 * The wait queue is initialized earlier in svc_tcp_init()
+	 * so svc_tcp_data_ready() can safely wake it.
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
+ * Called only by the dedicated receiver thread; does not call
+ * svc_xprt_received() since the receiver thread manages its own
+ * event loop.
+ */
+static int svc_tcp_recv_msg(struct svc_rqst *rqstp)
 {
 	struct svc_sock	*svsk =
 		container_of(rqstp->rq_xprt, struct svc_sock, sk_xprt);
@@ -1179,7 +1543,6 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	__be32 *p;
 	__be32 calldir;
 
-	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 	len = svc_tcp_read_marker(svsk, rqstp);
 	if (len < 0)
 		goto error;
@@ -1205,12 +1568,7 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
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
@@ -1229,7 +1587,6 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 		serv->sv_stats->nettcpcnt++;
 
 	svc_sock_secure_port(rqstp);
-	svc_xprt_received(rqstp->rq_xprt);
 	return rqstp->rq_arg.len;
 
 err_incomplete:
@@ -1254,10 +1611,56 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
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
+	 * Wake the receiver thread when the queue drops below the
+	 * threshold. The receiver may have been sleeping while the
+	 * queue was full.
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
@@ -1394,6 +1797,12 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 		sk->sk_data_ready = svc_tcp_listen_data_ready;
 		set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
 	} else {
+		/* Initialize receiver thread wait queue before installing
+		 * the data_ready callback. svc_tcp_data_ready() calls
+		 * wake_up() on this wait queue.
+		 */
+		init_waitqueue_head(&svsk->sk_receiver_wq);
+
 		sk->sk_state_change = svc_tcp_state_change;
 		sk->sk_data_ready = svc_tcp_data_ready;
 		sk->sk_write_space = svc_write_space;
@@ -1406,7 +1815,6 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 
 		tcp_sock_set_nodelay(sk);
 
-		set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 		switch (sk->sk_state) {
 		case TCP_SYN_RECV:
 		case TCP_ESTABLISHED:
@@ -1677,6 +2085,8 @@ static void svc_tcp_sock_detach(struct svc_xprt *xprt)
 {
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
 
+	svc_tcp_stop_receiver(svsk);
+
 	tls_handshake_close(svsk->sk_sock);
 
 	svc_sock_detach(xprt);
-- 
2.52.0


