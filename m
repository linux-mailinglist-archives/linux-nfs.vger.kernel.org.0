Return-Path: <linux-nfs+bounces-18853-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIM5KSBei2mYUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18853-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:34:40 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC1811D40F
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AAC430715C3
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B8B3033D2;
	Tue, 10 Feb 2026 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMvUka6x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324B92D979C;
	Tue, 10 Feb 2026 16:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741155; cv=none; b=QCLEDzS5gePMl5DZkCnXn4A7QNFqNZ3RCh615pY7yi6R13foMKt6yMPtEhlGSh5kp7ml5bAJtkAf6e9scdNQ8xhQ1hWD9uDjXif9MXwycsbrGqjwPBIlQasFpzyTFONuP+IbWvrKi7fQyI2vhllmL1Z30YlCtRTV/TOiSohR1uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741155; c=relaxed/simple;
	bh=E5Yaxv/coXQEaPHp1u/LuQ+Nh1sLN5Sv2XL78bpPID4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlm99WVFr1oXoM0GnNee5U7WXjwN0/PXSD8jRp/prt647zRY29I6lQsFU+buSRZ+sLrsnS9rTprkClGTq3SEUl6Z4n0fNTy9lVFf3Tj/9jtUY14sNuHjNGMj/zeT5dqrPNENUoNXxxZ6c5bisr1kffsMUSHv4/ESZjF2crBNHkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMvUka6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7286BC116C6;
	Tue, 10 Feb 2026 16:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741155;
	bh=E5Yaxv/coXQEaPHp1u/LuQ+Nh1sLN5Sv2XL78bpPID4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vMvUka6xwibYdITqavl+m9x1X0UEHf2uMdMyGKmeaXckZbgKvYzBl6BMHqaGlrLON
	 drclBIyYqBqT5G3Wx/U/LFBYJiOLzZZIMNCFhjcgkiAu2+5ZM6olBnYTqk8PT0TK9I
	 FwrjUFxR8VFrDVC9zzWux3nuSvTL+hIuBrbzSn7L8Uq9TDgytpUDyJyLilczZDrfcg
	 31rsYiGS3Tsh77f+rMLKehm9EP48Zrlk3pisHMET8QJ2ItsX4/RNaAzaJCCBsLHzNY
	 PAEUWGge762eE/+SlDCy17vogEQ/VGeh2vWp5SiW1spGvW4VxZuxIE7s0yc5K01+Qi
	 dfzLU49YIDcIA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 10/15] svcrdma: Use per-transport kthread for send context release
Date: Tue, 10 Feb 2026 11:32:17 -0500
Message-ID: <20260210163222.2356793-11-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210163222.2356793-1-cel@kernel.org>
References: <20260210163222.2356793-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18853-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFC1811D40F
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Each RDMA Send completion queues a separate work item to the
global svcrdma_wq (an unbound workqueue) to handle DMA
unmapping and page release. Under load, many worker threads
contend on the shared workqueue pool lock -- profiling an
NFSv3 8KB read+write workload over RDMA shows ~2.6% of
total CPU cycles spent in native_queued_spin_lock_slowpath
on this lock.

The contention arises from three directions: CQ completion
handlers acquiring the pool lock to enqueue work, a dozen
unbound workers re-acquiring it after each work item
completes, and XFS CIL flush callers hitting the same
unbound pool lock.

Replace the workqueue with a per-transport kthread that
drains a lock-free list. The CQ handler appends completed
send contexts via llist_add() (a single cmpxchg) and wakes
the kthread. The kthread collects all pending items with
llist_del_all() (a single xchg) and releases them in a
batch. Both operations are wait-free, eliminating the pool
lock entirely.

This also removes the global svcrdma_wq workqueue, which
has no remaining users.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |  9 ++--
 net/sunrpc/xprtrdma/svc_rdma.c           | 18 +------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 62 +++++++++++++++++++++---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  8 ++-
 4 files changed, 69 insertions(+), 28 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 9691238df47f..874941b22485 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -66,8 +66,6 @@ extern unsigned int svcrdma_ord;
 extern unsigned int svcrdma_max_requests;
 extern unsigned int svcrdma_max_bc_requests;
 extern unsigned int svcrdma_max_req_size;
-extern struct workqueue_struct *svcrdma_wq;
-
 extern struct percpu_counter svcrdma_stat_read;
 extern struct percpu_counter svcrdma_stat_recv;
 extern struct percpu_counter svcrdma_stat_sq_starve;
@@ -120,6 +118,10 @@ struct svcxprt_rdma {
 
 	struct llist_head    sc_recv_ctxts;
 
+	struct llist_head    sc_send_release_list;
+	wait_queue_head_t    sc_release_wait;
+	struct task_struct   *sc_release_task;
+
 	atomic_t	     sc_completion_ids;
 };
 /* sc_flags */
@@ -237,7 +239,6 @@ struct svc_rdma_write_info {
 struct svc_rdma_send_ctxt {
 	struct llist_node	sc_node;
 	struct rpc_rdma_cid	sc_cid;
-	struct work_struct	sc_work;
 
 	struct svcxprt_rdma	*sc_rdma;
 	struct ib_send_wr	sc_send_wr;
@@ -301,6 +302,8 @@ extern int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 
 /* svc_rdma_sendto.c */
 extern void svc_rdma_send_ctxts_destroy(struct svcxprt_rdma *rdma);
+extern int svc_rdma_start_release_thread(struct svcxprt_rdma *rdma);
+extern void svc_rdma_stop_release_thread(struct svcxprt_rdma *rdma);
 extern struct svc_rdma_send_ctxt *
 		svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma);
 extern void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index 415c0310101f..f67f0612b1a9 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -264,38 +264,22 @@ static int svc_rdma_proc_init(void)
 	return rc;
 }
 
-struct workqueue_struct *svcrdma_wq;
-
 void svc_rdma_cleanup(void)
 {
 	svc_unreg_xprt_class(&svc_rdma_class);
 	svc_rdma_proc_cleanup();
-	if (svcrdma_wq) {
-		struct workqueue_struct *wq = svcrdma_wq;
-
-		svcrdma_wq = NULL;
-		destroy_workqueue(wq);
-	}
 
 	dprintk("SVCRDMA Module Removed, deregister RPC RDMA transport\n");
 }
 
 int svc_rdma_init(void)
 {
-	struct workqueue_struct *wq;
 	int rc;
 
-	wq = alloc_workqueue("svcrdma", WQ_UNBOUND, 0);
-	if (!wq)
-		return -ENOMEM;
-
 	rc = svc_rdma_proc_init();
-	if (rc) {
-		destroy_workqueue(wq);
+	if (rc)
 		return rc;
-	}
 
-	svcrdma_wq = wq;
 	svc_reg_xprt_class(&svc_rdma_class);
 
 	dprintk("SVCRDMA Module Init, register RPC RDMA transport\n");
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index e9056039c118..1ff39c88b3cb 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -99,6 +99,7 @@
  * where two different Write segments send portions of the same page.
  */
 
+#include <linux/kthread.h>
 #include <linux/spinlock.h>
 #include <linux/unaligned.h>
 
@@ -260,12 +261,57 @@ static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
 	llist_add(&ctxt->sc_node, &rdma->sc_send_ctxts);
 }
 
-static void svc_rdma_send_ctxt_put_async(struct work_struct *work)
+static int svc_rdma_release_fn(void *data)
 {
-	struct svc_rdma_send_ctxt *ctxt;
+	struct svcxprt_rdma *rdma = data;
+	struct svc_rdma_send_ctxt *ctxt, *next;
+	struct llist_node *node;
 
-	ctxt = container_of(work, struct svc_rdma_send_ctxt, sc_work);
-	svc_rdma_send_ctxt_release(ctxt->sc_rdma, ctxt);
+	while (!kthread_should_stop()) {
+		wait_event(rdma->sc_release_wait,
+			   !llist_empty(&rdma->sc_send_release_list) ||
+			   kthread_should_stop());
+
+		node = llist_del_all(&rdma->sc_send_release_list);
+		llist_for_each_entry_safe(ctxt, next, node, sc_node)
+			svc_rdma_send_ctxt_release(rdma, ctxt);
+	}
+
+	/* Defensive: the list is usually empty here. */
+	node = llist_del_all(&rdma->sc_send_release_list);
+	llist_for_each_entry_safe(ctxt, next, node, sc_node)
+		svc_rdma_send_ctxt_release(rdma, ctxt);
+	return 0;
+}
+
+/**
+ * svc_rdma_start_release_thread - Launch release kthread
+ * @rdma: controlling transport
+ *
+ * Returns zero on success, or a negative errno.
+ */
+int svc_rdma_start_release_thread(struct svcxprt_rdma *rdma)
+{
+	struct task_struct *task;
+
+	task = kthread_run(svc_rdma_release_fn, rdma,
+			   "svcrdma-rel");
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+	rdma->sc_release_task = task;
+	return 0;
+}
+
+/**
+ * svc_rdma_stop_release_thread - Stop release kthread
+ * @rdma: controlling transport
+ *
+ * Waits for the kthread to drain and exit.
+ */
+void svc_rdma_stop_release_thread(struct svcxprt_rdma *rdma)
+{
+	if (rdma->sc_release_task)
+		kthread_stop(rdma->sc_release_task);
 }
 
 /**
@@ -273,13 +319,15 @@ static void svc_rdma_send_ctxt_put_async(struct work_struct *work)
  * @rdma: controlling svcxprt_rdma
  * @ctxt: object to return to the free list
  *
- * Pages left in sc_pages are DMA unmapped and released.
+ * DMA unmapping and page release are deferred to a
+ * per-transport kthread to keep these costs off the
+ * completion handler's critical path.
  */
 void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 			    struct svc_rdma_send_ctxt *ctxt)
 {
-	INIT_WORK(&ctxt->sc_work, svc_rdma_send_ctxt_put_async);
-	queue_work(svcrdma_wq, &ctxt->sc_work);
+	llist_add(&ctxt->sc_node, &rdma->sc_send_release_list);
+	wake_up(&rdma->sc_release_wait);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 286806ac0739..0a3969d36a80 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -177,7 +177,9 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	init_llist_head(&cma_xprt->sc_send_ctxts);
 	init_llist_head(&cma_xprt->sc_recv_ctxts);
 	init_llist_head(&cma_xprt->sc_rw_ctxts);
+	init_llist_head(&cma_xprt->sc_send_release_list);
 	init_waitqueue_head(&cma_xprt->sc_send_wait);
+	init_waitqueue_head(&cma_xprt->sc_release_wait);
 
 	spin_lock_init(&cma_xprt->sc_lock);
 	spin_lock_init(&cma_xprt->sc_send_lock);
@@ -526,6 +528,10 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	if (!svc_rdma_post_recvs(newxprt))
 		goto errout;
 
+	ret = svc_rdma_start_release_thread(newxprt);
+	if (ret)
+		goto errout;
+
 	/* Construct RDMA-CM private message */
 	pmsg.cp_magic = rpcrdma_cmp_magic;
 	pmsg.cp_version = RPCRDMA_CMP_VERSION;
@@ -605,7 +611,7 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 	/* This blocks until the Completion Queues are empty */
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
 		ib_drain_qp(rdma->sc_qp);
-	flush_workqueue(svcrdma_wq);
+	svc_rdma_stop_release_thread(rdma);
 
 	svc_rdma_flush_recv_queues(rdma);
 
-- 
2.52.0


