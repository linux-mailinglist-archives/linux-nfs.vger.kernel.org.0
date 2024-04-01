Return-Path: <linux-nfs+bounces-2589-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6D88945D9
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 22:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313D11C20F88
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Apr 2024 20:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BA84087B;
	Mon,  1 Apr 2024 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qa/+l9Ka"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F4A3A1C2
	for <linux-nfs@vger.kernel.org>; Mon,  1 Apr 2024 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712001941; cv=none; b=iBRnOgze8hnSoRz5uEpYDieHj6o3j2ag8JIsohxlRKCR+FowoVZ7ly35d3jxzFARSwKzdaG84ZaPmr9BDWlEczHSk2nV03boWMp0RS9rjUMQZ7yt6BhxQJrdPW1WV/dCIkom5GLLdZvh6BBnpMYcuNEnNSNfqIaJhOsRqGvy+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712001941; c=relaxed/simple;
	bh=yWrOuoprPUMBfSCojHgguavSC+XKrYZHHhK9RGRWuIU=;
	h=Subject:From:To:Date:Message-ID:MIME-Version:Content-Type; b=KczOg2FsQbAkwnmbRIqDXY3NcP9LawVH4KGrXcIyPd0/+nrKttECc/zsR5ZEL1zNckWZcMNMWNNsFl+YbsBGy4vuIp5OvYv4cZUp+1JR++brNvxm+NysXUGgBpEhTO8gn/uLTezmR9S+8iNu6jG0SeN+FOS6LOIvopTd6+e4W40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qa/+l9Ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B05C433C7
	for <linux-nfs@vger.kernel.org>; Mon,  1 Apr 2024 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712001940;
	bh=yWrOuoprPUMBfSCojHgguavSC+XKrYZHHhK9RGRWuIU=;
	h=Subject:From:To:Date:From;
	b=qa/+l9Ka1yf4zw0AHqfeg+6ChfjqkNo5momvqdqZ751Tfd+TkAeeeOfZoNn/RBCO+
	 2rR0eiIABI0+OTtKvFQT6s21df2ulVTLV84ykvfo45kswfoho0PbaAztN2cFfC1e+u
	 jEvEh0dkidjdTbecg/SjwZvXhKSYabb7rbzO2+C36oDwLHB2gLHpmcYKVBIS7+zJMP
	 y8RcYWHfzA7CWzr14w5QSPzdZtrtPXFr4PYdfqaTHopwMLBQxqHzf/82F0nXnnYl9v
	 Qw2ZZY1dUXB93OibnBHh8JGprZmHlqCD5Vt0dtSFXuP9lkXbsOqQMv+JYwPpaSJIXd
	 D9/PFjaLsVCwA==
Subject: [PATCH RFC] NFSD: Move callback_wq into struct nfs4_client
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Mon, 01 Apr 2024 16:05:39 -0400
Message-ID: 
 <171200183231.5439.7855646322906072619.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Commit 883820366747 ("nfsd: update workqueue creation") made the
callback_wq single-threaded, presumably to protect modifications of
cl_cb_client. See documenting comment for nfsd4_process_cb_update().

However, cl_cb_client is per-lease. There's no other reason that all
callback operations need to be dispatched via a single thread. The
single threading here means all client callbacks can be blocked by a
problem with one client.

Change the NFSv4 callback client so it serializes per-lease instead
of serializing all NFSv4 callback operations on the server.

Reported-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |   37 +++++++++++++------------------------
 fs/nfsd/nfs4state.c    |   14 +++++++-------
 fs/nfsd/state.h        |    4 ++--
 3 files changed, 22 insertions(+), 33 deletions(-)

This has seen some light testing with a single client, and has been
pushed to the nfsd-testing branch of:

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 87c9547989f6..cf87ace7a1b0 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -978,19 +978,21 @@ static int max_cb_time(struct net *net)
 	return max(((u32)nn->nfsd4_lease)/10, 1u) * HZ;
 }
 
-static struct workqueue_struct *callback_wq;
-
 static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
 {
-	trace_nfsd_cb_queue(cb->cb_clp, cb);
-	return queue_delayed_work(callback_wq, &cb->cb_work, 0);
+	struct nfs4_client *clp = cb->cb_clp;
+
+	trace_nfsd_cb_queue(clp, cb);
+	return queue_delayed_work(clp->cl_callback_wq, &cb->cb_work, 0);
 }
 
 static void nfsd4_queue_cb_delayed(struct nfsd4_callback *cb,
 				   unsigned long msecs)
 {
-	trace_nfsd_cb_queue(cb->cb_clp, cb);
-	queue_delayed_work(callback_wq, &cb->cb_work,
+	struct nfs4_client *clp = cb->cb_clp;
+
+	trace_nfsd_cb_queue(clp, cb);
+	queue_delayed_work(clp->cl_callback_wq, &cb->cb_work,
 			   msecs_to_jiffies(msecs));
 }
 
@@ -1161,7 +1163,7 @@ void nfsd4_probe_callback(struct nfs4_client *clp)
 void nfsd4_probe_callback_sync(struct nfs4_client *clp)
 {
 	nfsd4_probe_callback(clp);
-	flush_workqueue(callback_wq);
+	flush_workqueue(clp->cl_callback_wq);
 }
 
 void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
@@ -1380,19 +1382,6 @@ static const struct rpc_call_ops nfsd4_cb_ops = {
 	.rpc_release = nfsd4_cb_release,
 };
 
-int nfsd4_create_callback_queue(void)
-{
-	callback_wq = alloc_ordered_workqueue("nfsd4_callbacks", 0);
-	if (!callback_wq)
-		return -ENOMEM;
-	return 0;
-}
-
-void nfsd4_destroy_callback_queue(void)
-{
-	destroy_workqueue(callback_wq);
-}
-
 /* must be called under the state lock */
 void nfsd4_shutdown_callback(struct nfs4_client *clp)
 {
@@ -1406,7 +1395,7 @@ void nfsd4_shutdown_callback(struct nfs4_client *clp)
 	 * client, destroy the rpc client, and stop:
 	 */
 	nfsd4_run_cb(&clp->cl_cb_null);
-	flush_workqueue(callback_wq);
+	flush_workqueue(clp->cl_callback_wq);
 	nfsd41_cb_inflight_wait_complete(clp);
 }
 
@@ -1428,9 +1417,9 @@ static struct nfsd4_conn * __nfsd4_find_backchannel(struct nfs4_client *clp)
 
 /*
  * Note there isn't a lot of locking in this code; instead we depend on
- * the fact that it is run from the callback_wq, which won't run two
- * work items at once.  So, for example, callback_wq handles all access
- * of cl_cb_client and all calls to rpc_create or rpc_shutdown_client.
+ * the fact that it is run from clp->cl_callback_wq, which won't run two
+ * work items at once.  So, for example, clp->cl_callback_wq handles all
+ * access of cl_cb_client and all calls to rpc_create or rpc_shutdown_client.
  */
 static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 {
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2ece3092a4e3..19e15c093f0a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2233,6 +2233,10 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
 						 GFP_KERNEL);
 	if (!clp->cl_ownerstr_hashtbl)
 		goto err_no_hashtbl;
+	clp->cl_callback_wq = alloc_ordered_workqueue("nfsd4_callbacks", 0);
+	if (!clp->cl_callback_wq)
+		goto err_no_callback_wq;
+
 	for (i = 0; i < OWNER_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&clp->cl_ownerstr_hashtbl[i]);
 	INIT_LIST_HEAD(&clp->cl_sessions);
@@ -2255,6 +2259,8 @@ static struct nfs4_client *alloc_client(struct xdr_netobj name,
 	spin_lock_init(&clp->cl_lock);
 	rpc_init_wait_queue(&clp->cl_cb_waitq, "Backchannel slot table");
 	return clp;
+err_no_callback_wq:
+	kfree(clp->cl_ownerstr_hashtbl);
 err_no_hashtbl:
 	kfree(clp->cl_name.data);
 err_no_name:
@@ -2268,6 +2274,7 @@ static void __free_client(struct kref *k)
 	struct nfs4_client *clp = container_of(c, struct nfs4_client, cl_nfsdfs);
 
 	free_svc_cred(&clp->cl_cred);
+	destroy_workqueue(clp->cl_callback_wq);
 	kfree(clp->cl_ownerstr_hashtbl);
 	kfree(clp->cl_name.data);
 	kfree(clp->cl_nii_domain.data);
@@ -8644,12 +8651,6 @@ nfs4_state_start(void)
 	if (ret)
 		return ret;
 
-	ret = nfsd4_create_callback_queue();
-	if (ret) {
-		rhltable_destroy(&nfs4_file_rhltable);
-		return ret;
-	}
-
 	set_max_delegations();
 	return 0;
 }
@@ -8690,7 +8691,6 @@ nfs4_state_shutdown_net(struct net *net)
 void
 nfs4_state_shutdown(void)
 {
-	nfsd4_destroy_callback_queue();
 	rhltable_destroy(&nfs4_file_rhltable);
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 0400441c87c1..f42d8d782c84 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -408,6 +408,8 @@ struct nfs4_client {
 					 1 << NFSD4_CLIENT_CB_KILL)
 #define NFSD4_CLIENT_CB_RECALL_ANY	(6)
 	unsigned long		cl_flags;
+
+	struct workqueue_struct *cl_callback_wq;
 	const struct cred	*cl_cb_cred;
 	struct rpc_clnt		*cl_cb_client;
 	u32			cl_cb_ident;
@@ -735,8 +737,6 @@ extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *
 extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
 extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
-extern int nfsd4_create_callback_queue(void);
-extern void nfsd4_destroy_callback_queue(void);
 extern void nfsd4_shutdown_callback(struct nfs4_client *);
 extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
 extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name,



