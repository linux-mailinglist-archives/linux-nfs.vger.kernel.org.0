Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75279F52F8
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2019 18:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfKHRw3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Nov 2019 12:52:29 -0500
Received: from fieldses.org ([173.255.197.46]:36442 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbfKHRw3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 Nov 2019 12:52:29 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 5FCA01C15; Fri,  8 Nov 2019 12:52:28 -0500 (EST)
Date:   Fri, 8 Nov 2019 12:52:28 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] nfsd: Fix races between nfsd4_cb_release() and
 nfsd4_shutdown_callback()
Message-ID: <20191108175228.GB758@fieldses.org>
References: <20191023214318.9350-1-trond.myklebust@hammerspace.com>
 <20191025145147.GA16053@pick.fieldses.org>
 <97f56de86f0aeafb56998023d0561bb4a6233eb8.camel@hammerspace.com>
 <20191025152119.GC16053@pick.fieldses.org>
 <20191025153336.GA20283@fieldses.org>
 <20191029214705.GA29280@fieldses.org>
 <20191107222712.GB10806@fieldses.org>
 <20191108175109.GA758@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108175109.GA758@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Nov 08, 2019 at 12:51:09PM -0500, J. Bruce Fields wrote:
> On Thu, Nov 07, 2019 at 05:27:12PM -0500, J. Bruce Fields wrote:
> > On Tue, Oct 29, 2019 at 05:47:05PM -0400, J. Bruce Fields wrote:
> > > On Fri, Oct 25, 2019 at 11:33:36AM -0400, bfields wrote:
> > > > On Fri, Oct 25, 2019 at 11:21:19AM -0400, J. Bruce Fields wrote:
> > > > > I thought I was running v2, let me double-check....
> > > > 
> > > > Yes, with v2 I'm getting a hang on generic/013.
> > > > 
> > > > I checked quickly and didn't see anything interesting in the logs,
> > > > otherwise I haven't done any digging.
> > > 
> > > Reproduceable just with ./check -nfs generic/013.  The last thing I see
> > > in wireshark is an asynchronous COPY call and reply.  Which means it's
> > > probably trying to do a CB_OFFLOAD.  Hm.
> > 
> > Oh, I think it just needs the following.
> 
> Applying as follows, with part of the change split out into a separate
> patch (since that's how I noticed the bug).
> 
> --b.

Oops, remembered to append the patches this time.--b.

commit 2bbfed98a4d8
Author: Trond Myklebust <trondmy@gmail.com>
Date:   Wed Oct 23 17:43:18 2019 -0400

    nfsd: Fix races between nfsd4_cb_release() and nfsd4_shutdown_callback()
    
    When we're destroying the client lease, and we call
    nfsd4_shutdown_callback(), we must ensure that we do not return
    before all outstanding callbacks have terminated and have
    released their payloads.
    
    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 1542e1d6dd1a..67d24a536082 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -826,6 +826,31 @@ static int max_cb_time(struct net *net)
 	return max(nn->nfsd4_lease/10, (time_t)1) * HZ;
 }
 
+static struct workqueue_struct *callback_wq;
+
+static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
+{
+	return queue_work(callback_wq, &cb->cb_work);
+}
+
+static void nfsd41_cb_inflight_begin(struct nfs4_client *clp)
+{
+	atomic_inc(&clp->cl_cb_inflight);
+}
+
+static void nfsd41_cb_inflight_end(struct nfs4_client *clp)
+{
+
+	if (atomic_dec_and_test(&clp->cl_cb_inflight))
+		wake_up_var(&clp->cl_cb_inflight);
+}
+
+static void nfsd41_cb_inflight_wait_complete(struct nfs4_client *clp)
+{
+	wait_var_event(&clp->cl_cb_inflight,
+			!atomic_read(&clp->cl_cb_inflight));
+}
+
 static const struct cred *get_backchannel_cred(struct nfs4_client *clp, struct rpc_clnt *client, struct nfsd4_session *ses)
 {
 	if (clp->cl_minorversion == 0) {
@@ -937,14 +962,21 @@ static void nfsd4_cb_probe_done(struct rpc_task *task, void *calldata)
 		clp->cl_cb_state = NFSD4_CB_UP;
 }
 
+static void nfsd4_cb_probe_release(void *calldata)
+{
+	struct nfs4_client *clp = container_of(calldata, struct nfs4_client, cl_cb_null);
+
+	nfsd41_cb_inflight_end(clp);
+
+}
+
 static const struct rpc_call_ops nfsd4_cb_probe_ops = {
 	/* XXX: release method to ensure we set the cb channel down if
 	 * necessary on early failure? */
 	.rpc_call_done = nfsd4_cb_probe_done,
+	.rpc_release = nfsd4_cb_probe_release,
 };
 
-static struct workqueue_struct *callback_wq;
-
 /*
  * Poke the callback thread to process any updates to the callback
  * parameters, and send a null probe.
@@ -1004,6 +1036,16 @@ static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
 	}
 }
 
+static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
+{
+	struct nfs4_client *clp = cb->cb_clp;
+
+	nfsd41_cb_release_slot(cb);
+	if (cb->cb_ops && cb->cb_ops->release)
+		cb->cb_ops->release(cb);
+	nfsd41_cb_inflight_end(clp);
+}
+
 /*
  * TODO: cb_sequence should support referring call lists, cachethis, multiple
  * slots, and mark callback channel down on communication errors.
@@ -1101,8 +1143,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		ret = false;
 	goto out;
 need_restart:
-	task->tk_status = 0;
-	cb->cb_need_restart = true;
+	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
+		task->tk_status = 0;
+		cb->cb_need_restart = true;
+	}
 	return false;
 }
 
@@ -1144,9 +1188,9 @@ static void nfsd4_cb_release(void *calldata)
 	struct nfsd4_callback *cb = calldata;
 
 	if (cb->cb_need_restart)
-		nfsd4_run_cb(cb);
+		nfsd4_queue_cb(cb);
 	else
-		cb->cb_ops->release(cb);
+		nfsd41_destroy_cb(cb);
 
 }
 
@@ -1180,6 +1224,7 @@ void nfsd4_shutdown_callback(struct nfs4_client *clp)
 	 */
 	nfsd4_run_cb(&clp->cl_cb_null);
 	flush_workqueue(callback_wq);
+	nfsd41_cb_inflight_wait_complete(clp);
 }
 
 /* requires cl_lock: */
@@ -1265,8 +1310,7 @@ nfsd4_run_cb_work(struct work_struct *work)
 	clnt = clp->cl_cb_client;
 	if (!clnt) {
 		/* Callback channel broken, or client killed; give up: */
-		if (cb->cb_ops && cb->cb_ops->release)
-			cb->cb_ops->release(cb);
+		nfsd41_destroy_cb(cb);
 		return;
 	}
 
@@ -1275,6 +1319,7 @@ nfsd4_run_cb_work(struct work_struct *work)
 	 */
 	if (!cb->cb_ops && clp->cl_minorversion) {
 		clp->cl_cb_state = NFSD4_CB_UP;
+		nfsd41_destroy_cb(cb);
 		return;
 	}
 
@@ -1300,5 +1345,9 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 
 void nfsd4_run_cb(struct nfsd4_callback *cb)
 {
-	queue_work(callback_wq, &cb->cb_work);
+	struct nfs4_client *clp = cb->cb_clp;
+
+	nfsd41_cb_inflight_begin(clp);
+	if (!nfsd4_queue_cb(cb))
+		nfsd41_cb_inflight_end(clp);
 }
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 46f56afb6cb8..d61b83b9654c 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -367,6 +367,7 @@ struct nfs4_client {
 	struct net		*net;
 	struct list_head	async_copies;	/* list of async copies */
 	spinlock_t		async_lock;	/* lock for async copies */
+	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
 };
 
 /* struct nfs4_client_reset

commit 12357f1b2c8e
Author: Trond Myklebust <trondmy@gmail.com>
Date:   Thu Nov 7 17:11:57 2019 -0500

    nfsd: minor 4.1 callback cleanup
    
    Move all the cb_holds_slot management into helper functions.  No change
    in behavior.
    
    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 524111420b48..1542e1d6dd1a 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -975,9 +975,12 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
  * If the slot is available, then mark it busy.  Otherwise, set the
  * thread for sleeping on the callback RPC wait queue.
  */
-static bool nfsd41_cb_get_slot(struct nfs4_client *clp, struct rpc_task *task)
+static bool nfsd41_cb_get_slot(struct nfsd4_callback *cb, struct rpc_task *task)
 {
-	if (test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
+	struct nfs4_client *clp = cb->cb_clp;
+
+	if (!cb->cb_holds_slot &&
+	    test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
 		rpc_sleep_on(&clp->cl_cb_waitq, task, NULL);
 		/* Race breaker */
 		if (test_and_set_bit(0, &clp->cl_cb_slot_busy) != 0) {
@@ -986,9 +989,21 @@ static bool nfsd41_cb_get_slot(struct nfs4_client *clp, struct rpc_task *task)
 		}
 		rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
 	}
+	cb->cb_holds_slot = true;
 	return true;
 }
 
+static void nfsd41_cb_release_slot(struct nfsd4_callback *cb)
+{
+	struct nfs4_client *clp = cb->cb_clp;
+
+	if (cb->cb_holds_slot) {
+		cb->cb_holds_slot = false;
+		clear_bit(0, &clp->cl_cb_slot_busy);
+		rpc_wake_up_next(&clp->cl_cb_waitq);
+	}
+}
+
 /*
  * TODO: cb_sequence should support referring call lists, cachethis, multiple
  * slots, and mark callback channel down on communication errors.
@@ -1005,11 +1020,8 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 	 */
 	cb->cb_seq_status = 1;
 	cb->cb_status = 0;
-	if (minorversion) {
-		if (!cb->cb_holds_slot && !nfsd41_cb_get_slot(clp, task))
-			return;
-		cb->cb_holds_slot = true;
-	}
+	if (minorversion && !nfsd41_cb_get_slot(cb, task))
+		return;
 	rpc_call_start(task);
 }
 
@@ -1076,9 +1088,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 			cb->cb_seq_status);
 	}
 
-	cb->cb_holds_slot = false;
-	clear_bit(0, &clp->cl_cb_slot_busy);
-	rpc_wake_up_next(&clp->cl_cb_waitq);
+	nfsd41_cb_release_slot(cb);
 	dprintk("%s: freed slot, new seqid=%d\n", __func__,
 		clp->cl_cb_session->se_cb_seq_nr);
 
