Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0BA4E25A2
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2019 23:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405564AbfJWVpg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 17:45:36 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:40807 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389405AbfJWVpf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 17:45:35 -0400
Received: by mail-il1-f196.google.com with SMTP id d83so11921394ilk.7
        for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2019 14:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PHnSgD2Uy9pcHnCm2FBOfZcByp+z8cNliYChsZsjoM=;
        b=ETSfo2AiiNVAvCPO4rIiqt7RIP/QfGR0Q7SyfgbEJlbZ9HetiniJDY1+RN8TJDIPzd
         lxLx/M9flbU13Nxew7nbSuwLnEkNGffNV0o3RkKpTMEc6yCUzjiu6e+yjpG7+ceAe/V2
         S5G8qVCvTs5ZdH1eJ6/4aZQuhMAac0JUpE5Q529cv58MXeivjP6naqlIN8p67WsjdBpS
         WOFCFC8vKtRjgeQSlqIgUeHF5BErrwFZ+4s3Z1UVsk/0bzfdQQKGh+z5UVxnDwRwW6UM
         XiXKOzVwIhFS6nT5cQ5/7jQSyRqkoap1GJ6MQ77tMP2GnDEwhgMJMqaOZF41mEp84NrM
         qRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6PHnSgD2Uy9pcHnCm2FBOfZcByp+z8cNliYChsZsjoM=;
        b=CkO3Ypq14/9/wU3S4PhRASrqz/2pC1UKC9KF8BCcywTQLiWR2ub9jbM6sUa6enbH0J
         QE+hh9lzqHS3z3OpCVXPaAUVjiMOWvL3rJfzDFEwDNsN9i9veFWnimg7j9lveY62D+eS
         oNhGPOB9WFtVsdb//ut2cAX1EJOZZ1haUXvTMcwWpncFlRgwb0Ml41DVNiO3Av1GXR21
         D++4IVtXcuYCQZhYtTWHhDLojtSiat38JFPv1mw5dj1mTWUlg9vk8Jkq2FO2pG+uOJq/
         AhwmhnWP7U2Gj3yflwp4eczxmYJAP86hJ6UbjMliquY2keW4BJ/foKCqbT16SEB2TuvB
         j4uQ==
X-Gm-Message-State: APjAAAXDeuX1Zhi7U2234HMiiiesRjERPncpHw+xFPpbwHJbCG2VMAgi
        UvhRv3fQasABH0j+SbTqDp0r0EA=
X-Google-Smtp-Source: APXvYqyJkasL2DHRQbYVgFzM02kclyRnGyeLWDzY7KyGOs6UKGky4rKttkDkfSNqg77lZUysdVhysQ==
X-Received: by 2002:a92:99c7:: with SMTP id t68mr41575239ilk.279.1571867133094;
        Wed, 23 Oct 2019 14:45:33 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id v17sm8166715ilg.1.2019.10.23.14.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 14:45:32 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: Fix races between nfsd4_cb_release() and nfsd4_shutdown_callback()
Date:   Wed, 23 Oct 2019 17:43:18 -0400
Message-Id: <20191023214318.9350-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When we're destroying the client lease, and we call
nfsd4_shutdown_callback(), we must ensure that we do not return
before all outstanding callbacks have terminated and have
released their payloads.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
v2 - Fix a leak of clp->cl_cb_inflight when running null probes

 fs/nfsd/nfs4callback.c | 97 +++++++++++++++++++++++++++++++++---------
 fs/nfsd/state.h        |  1 +
 2 files changed, 79 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 524111420b48..a3c9517bcc64 100644
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
@@ -975,9 +1007,12 @@ void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
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
@@ -985,10 +1020,32 @@ static bool nfsd41_cb_get_slot(struct nfs4_client *clp, struct rpc_task *task)
 			return false;
 		}
 		rpc_wake_up_queued_task(&clp->cl_cb_waitq, task);
+		cb->cb_holds_slot = true;
 	}
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
@@ -1005,11 +1062,8 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
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
 
@@ -1076,9 +1130,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 			cb->cb_seq_status);
 	}
 
-	cb->cb_holds_slot = false;
-	clear_bit(0, &clp->cl_cb_slot_busy);
-	rpc_wake_up_next(&clp->cl_cb_waitq);
+	nfsd41_cb_release_slot(cb);
 	dprintk("%s: freed slot, new seqid=%d\n", __func__,
 		clp->cl_cb_session->se_cb_seq_nr);
 
@@ -1091,8 +1143,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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
 
@@ -1134,9 +1188,9 @@ static void nfsd4_cb_release(void *calldata)
 	struct nfsd4_callback *cb = calldata;
 
 	if (cb->cb_need_restart)
-		nfsd4_run_cb(cb);
+		nfsd4_queue_cb(cb);
 	else
-		cb->cb_ops->release(cb);
+		nfsd41_destroy_cb(cb);
 
 }
 
@@ -1170,6 +1224,7 @@ void nfsd4_shutdown_callback(struct nfs4_client *clp)
 	 */
 	nfsd4_run_cb(&clp->cl_cb_null);
 	flush_workqueue(callback_wq);
+	nfsd41_cb_inflight_wait_complete(clp);
 }
 
 /* requires cl_lock: */
@@ -1255,8 +1310,7 @@ nfsd4_run_cb_work(struct work_struct *work)
 	clnt = clp->cl_cb_client;
 	if (!clnt) {
 		/* Callback channel broken, or client killed; give up: */
-		if (cb->cb_ops && cb->cb_ops->release)
-			cb->cb_ops->release(cb);
+		nfsd41_destroy_cb(cb);
 		return;
 	}
 
@@ -1265,6 +1319,7 @@ nfsd4_run_cb_work(struct work_struct *work)
 	 */
 	if (!cb->cb_ops && clp->cl_minorversion) {
 		clp->cl_cb_state = NFSD4_CB_UP;
+		nfsd41_destroy_cb(cb);
 		return;
 	}
 
@@ -1290,5 +1345,9 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 
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
-- 
2.21.0

