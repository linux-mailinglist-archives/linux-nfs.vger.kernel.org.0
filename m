Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4A4977F0
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 04:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbiAXDy5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 22:54:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47094 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241247AbiAXDy5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 22:54:57 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0BD4F1F3A0;
        Mon, 24 Jan 2022 03:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642996496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tmK71EqBNg8tnfZkC+LruaM0kNp6W9oOaGPTMjJ8PB4=;
        b=uYL7di7uzKVDvKhk4/TIixNyQGpyZdN/fsnIafEtUp6sY/FoSo8FHnhOixkdxzRb0HW07m
        sh2v9FUMQKDcUD0FPy81aL+sA0NCMbekW8advOn0HAR4KlxXNyzCUmTpflUXZlPEWsqEbS
        gHoZU9eO37l/5P+JS5hRKh3rd2/7i5I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642996496;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tmK71EqBNg8tnfZkC+LruaM0kNp6W9oOaGPTMjJ8PB4=;
        b=96z+6d6B8k/Y1+X3FiAseSrAvJKJGFZWOLKawrct75Qw8cq7EliXvbgB0EDoziVTiOweeo
        5G5X+hyVgkHKwvCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEDD513305;
        Mon, 24 Jan 2022 03:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id y8f0Jgwj7mEgRgAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 03:54:52 +0000
Subject: [PATCH 20/23] SUNRPC: improve 'swap' handling: scheduling and
 PF_MEMALLOC
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 24 Jan 2022 14:48:32 +1100
Message-ID: <164299611285.26253.480157765187909362.stgit@noble.brown>
In-Reply-To: <164299573337.26253.7538614611220034049.stgit@noble.brown>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

rpc tasks can be marked as RPC_TASK_SWAPPER.  This causes GFP_MEMALLOC
to be used for some allocations.  This is needed in some cases, but not
in all where it is currently provided, and in some where it isn't
provided.

Currently *all* tasks associated with a rpc_client on which swap is
enabled get the flag and hence some GFP_MEMALLOC support.

GFP_MEMALLOC is provided for ->buf_alloc() but only swap-writes need it.
However xdr_alloc_bvec does not get GFP_MEMALLOC - though it often does
need it.

xdr_alloc_bvec is called while the XPRT_LOCK is held.  If this blocks,
then it blocks all other queued tasks.  So this allocation needs
GFP_MEMALLOC for *all* requests, not just writes, when the xprt is used
for any swap writes.

Similarly, if the transport is not connected, that will block all
requests including swap writes, so memory allocations should get
GFP_MEMALLOC if swap writes are possible.

So with this patch:
 1/ we ONLY set RPC_TASK_SWAPPER for swap writes.
 2/ __rpc_execute() sets PF_MEMALLOC while handling any task
    with RPC_TASK_SWAPPER set, or when handling any task that
    holds the XPRT_LOCKED lock on an xprt used for swap.
    This removes the need for the RPC_IS_SWAPPER() test
    in ->buf_alloc handlers.
 3/ xprt_prepare_transmit() sets PF_MEMALLOC after locking
    any task to a swapper xprt.  __rpc_execute() will clear it.
 3/ PF_MEMALLOC is set for all the connect workers.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/write.c                  |    2 ++
 net/sunrpc/clnt.c               |    2 --
 net/sunrpc/sched.c              |   20 +++++++++++++++++---
 net/sunrpc/xprt.c               |    3 +++
 net/sunrpc/xprtrdma/transport.c |    6 ++++--
 net/sunrpc/xprtsock.c           |    8 ++++++++
 6 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 987a187bd39a..9f7176745fef 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1409,6 +1409,8 @@ static void nfs_initiate_write(struct nfs_pgio_header *hdr,
 {
 	int priority = flush_task_priority(how);
 
+	if (IS_SWAPFILE(hdr->inode))
+		task_setup_data->flags |= RPC_TASK_SWAPPER;
 	task_setup_data->priority = priority;
 	rpc_ops->write_setup(hdr, msg, &task_setup_data->rpc_client);
 	trace_nfs_initiate_write(hdr);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 238b2ef5491f..cb76fbea3ed5 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1085,8 +1085,6 @@ void rpc_task_set_client(struct rpc_task *task, struct rpc_clnt *clnt)
 		task->tk_flags |= RPC_TASK_TIMEOUT;
 	if (clnt->cl_noretranstimeo)
 		task->tk_flags |= RPC_TASK_NO_RETRANS_TIMEOUT;
-	if (atomic_read(&clnt->cl_swapper))
-		task->tk_flags |= RPC_TASK_SWAPPER;
 	/* Add to the client's list of all tasks */
 	spin_lock(&clnt->cl_lock);
 	list_add_tail(&task->tk_task, &clnt->cl_tasks);
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 256302bf6557..9020cedb7c95 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -869,6 +869,15 @@ void rpc_release_calldata(const struct rpc_call_ops *ops, void *calldata)
 		ops->rpc_release(calldata);
 }
 
+static bool xprt_needs_memalloc(struct rpc_xprt *xprt, struct rpc_task *tk)
+{
+	if (!xprt)
+		return false;
+	if (!atomic_read(&xprt->swapper))
+		return false;
+	return test_bit(XPRT_LOCKED, &xprt->state) && xprt->snd_task == tk;
+}
+
 /*
  * This is the RPC `scheduler' (or rather, the finite state machine).
  */
@@ -877,6 +886,7 @@ static void __rpc_execute(struct rpc_task *task)
 	struct rpc_wait_queue *queue;
 	int task_is_async = RPC_IS_ASYNC(task);
 	int status = 0;
+	unsigned long pflags = current->flags;
 
 	WARN_ON_ONCE(RPC_IS_QUEUED(task));
 	if (RPC_IS_QUEUED(task))
@@ -899,6 +909,10 @@ static void __rpc_execute(struct rpc_task *task)
 		}
 		if (!do_action)
 			break;
+		if (RPC_IS_SWAPPER(task) ||
+		    xprt_needs_memalloc(task->tk_xprt, task))
+			current->flags |= PF_MEMALLOC;
+
 		trace_rpc_task_run_action(task, do_action);
 		do_action(task);
 
@@ -936,7 +950,7 @@ static void __rpc_execute(struct rpc_task *task)
 		rpc_clear_running(task);
 		spin_unlock(&queue->lock);
 		if (task_is_async)
-			return;
+			goto out;
 
 		/* sync task: sleep here */
 		trace_rpc_task_sync_sleep(task, task->tk_action);
@@ -960,6 +974,8 @@ static void __rpc_execute(struct rpc_task *task)
 
 	/* Release all resources associated with the task */
 	rpc_release_task(task);
+out:
+	current_restore_flags(pflags, PF_MEMALLOC);
 }
 
 /*
@@ -1018,8 +1034,6 @@ int rpc_malloc(struct rpc_task *task)
 
 	if (RPC_IS_ASYNC(task))
 		gfp = GFP_NOWAIT | __GFP_NOWARN;
-	if (RPC_IS_SWAPPER(task))
-		gfp |= __GFP_MEMALLOC;
 
 	size += sizeof(struct rpc_buffer);
 	if (size <= RPC_BUFFER_MAXSIZE)
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index a0a2583fe941..0614e7463d4b 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1492,6 +1492,9 @@ bool xprt_prepare_transmit(struct rpc_task *task)
 		return false;
 
 	}
+	if (atomic_read(&xprt->swapper))
+		/* This will be clear in __rpc_execute */
+		current->flags |= PF_MEMALLOC;
 	return true;
 }
 
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 32df23796747..256b06a92391 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -239,8 +239,11 @@ xprt_rdma_connect_worker(struct work_struct *work)
 	struct rpcrdma_xprt *r_xprt = container_of(work, struct rpcrdma_xprt,
 						   rx_connect_worker.work);
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
+	unsigned int pflags = current->flags;
 	int rc;
 
+	if (atomic_read(&xprt->swapper))
+		current->flags |= PF_MEMALLOC;
 	rc = rpcrdma_xprt_connect(r_xprt);
 	xprt_clear_connecting(xprt);
 	if (!rc) {
@@ -254,6 +257,7 @@ xprt_rdma_connect_worker(struct work_struct *work)
 		rpcrdma_xprt_disconnect(r_xprt);
 	xprt_unlock_connect(xprt, r_xprt);
 	xprt_wake_pending_tasks(xprt, rc);
+	current_restore_flags(pflags, PF_MEMALLOC);
 }
 
 /**
@@ -576,8 +580,6 @@ xprt_rdma_allocate(struct rpc_task *task)
 	flags = RPCRDMA_DEF_GFP;
 	if (RPC_IS_ASYNC(task))
 		flags = GFP_NOWAIT | __GFP_NOWARN;
-	if (RPC_IS_SWAPPER(task))
-		flags |= __GFP_MEMALLOC;
 
 	if (!rpcrdma_check_regbuf(r_xprt, req->rl_sendbuf, rqst->rq_callsize,
 				  flags))
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index d8ee06a9650a..9d34c71004fa 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2047,7 +2047,10 @@ static void xs_udp_setup_socket(struct work_struct *work)
 	struct rpc_xprt *xprt = &transport->xprt;
 	struct socket *sock;
 	int status = -EIO;
+	unsigned int pflags = current->flags;
 
+	if (atomic_read(&xprt->swapper))
+		current->flags |= PF_MEMALLOC;
 	sock = xs_create_sock(xprt, transport,
 			xs_addr(xprt)->sa_family, SOCK_DGRAM,
 			IPPROTO_UDP, false);
@@ -2067,6 +2070,7 @@ static void xs_udp_setup_socket(struct work_struct *work)
 	xprt_clear_connecting(xprt);
 	xprt_unlock_connect(xprt, transport);
 	xprt_wake_pending_tasks(xprt, status);
+	current_restore_flags(pflags, PF_MEMALLOC);
 }
 
 /**
@@ -2226,7 +2230,10 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 	struct socket *sock = transport->sock;
 	struct rpc_xprt *xprt = &transport->xprt;
 	int status;
+	unsigned int pflags = current->flags;
 
+	if (atomic_read(&xprt->swapper))
+		current->flags |= PF_MEMALLOC;
 	if (!sock) {
 		sock = xs_create_sock(xprt, transport,
 				xs_addr(xprt)->sa_family, SOCK_STREAM,
@@ -2291,6 +2298,7 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 	xprt_clear_connecting(xprt);
 out_unlock:
 	xprt_unlock_connect(xprt, transport);
+	current_restore_flags(pflags, PF_MEMALLOC);
 }
 
 /**


