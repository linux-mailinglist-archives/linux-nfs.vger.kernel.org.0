Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0493D7A70
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2019 17:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfJOPux (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 15 Oct 2019 11:50:53 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39890 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfJOPux (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 15 Oct 2019 11:50:53 -0400
Received: by mail-qk1-f193.google.com with SMTP id 4so19618438qki.6
        for <linux-nfs@vger.kernel.org>; Tue, 15 Oct 2019 08:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FpawBQL7R8NWNYGYh8Hng/+3GTXhVGU5iH/IOU5Pmn8=;
        b=LYwSrUqT0nWpp5VW/YoQjnuof7tnqhkcOh5uKUOTDKB4kJ6XDj10M9KqZBQx5Myb9q
         1C1LWpmQdDvMGImqtflA061+E402KFFuYRurY4fE9s8hGC8gLfbG/hq+NqAyfklqKWK+
         /huarn0PZF+IRIp9LS+B3ahI85PmQb6gTZaDoquJThTl2XnuOAF4Kn5bURZ4D3WtnFyn
         5Wf39vAz8K+UZxIn4Jpb4zcaBj8R+BgnpNNl+99ATz2UJ4JW+uqYfX/W3ysdVmoL+6ph
         A4GzkR6BhxqCRUl7YF7YX3e5y02qiElozY5kKl6iTSnohTgSbYaHzVnM+C/ATPEVAOmw
         9CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FpawBQL7R8NWNYGYh8Hng/+3GTXhVGU5iH/IOU5Pmn8=;
        b=QvOelN6IbdTvexxMCTD3zEStkkwi0A/neGOWhUYq7z4ZNdN1t7myI9IkUPlGwI9fja
         rbQbbgId4eP0hAyre9OaqEdpg2sQRsQZ5P+zAW9hhgGo9hkNCb7LsTL4cgCM36aB4RkD
         cdl9/ZHtmlyoyNF2Riyl0hvkVFTKiUCk9yd8zObXgzOJhc0LZo6EtSiQPs+RZWML6Xkn
         uQ3xofJU76ujvBzPdEhu1oMTqpwWufSbghccAussmIY7cYKEwZ1rExcZGY7Y+wtRgh92
         r52CMz7CBqibYjrxYRYve7u3o1+DAIYdPhMsKJ/b/fJznv7bXJBVPM4wEiJmrdJNE14l
         PXkA==
X-Gm-Message-State: APjAAAWjH7tHGqdw1b8ROF+k0+3u1U+0fjhfYXcb+OTvT1c7eP+JEs+z
        j1akNFJRYWRkanyDKYoo50ycuwY=
X-Google-Smtp-Source: APXvYqxnGLDH6t1A+P0AvMy9GbUaO/qI0THxb0j0s1lBFBRSC+HtYfy/gz9bq5+IONndX+Cf/OcphQ==
X-Received: by 2002:a37:b442:: with SMTP id d63mr35981488qkf.458.1571154651862;
        Tue, 15 Oct 2019 08:50:51 -0700 (PDT)
Received: from localhost.localdomain ([66.187.232.66])
        by smtp.gmail.com with ESMTPSA id r7sm10320195qkf.124.2019.10.15.08.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:50:51 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: Fix races between nfsd4_cb_release() and nfsd4_shutdown_callback()
Date:   Tue, 15 Oct 2019 11:47:24 -0400
Message-Id: <20191015154724.50988-1-trond.myklebust@hammerspace.com>
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
 fs/nfsd/nfs4callback.c | 80 ++++++++++++++++++++++++++++++++++--------
 fs/nfsd/state.h        |  2 ++
 2 files changed, 67 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 524111420b48..39436ef9b0d0 100644
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
@@ -985,10 +988,57 @@ static bool nfsd41_cb_get_slot(struct nfs4_client *clp, struct rpc_task *task)
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
+static void nfs41_cb_inflight_begin(struct nfsd4_callback *cb)
+{
+	struct nfs4_client *clp = cb->cb_clp;
+
+	if (!cb->cb_inflight) {
+		atomic_inc(&clp->cl_cb_inflight);
+		cb->cb_inflight = true;
+	}
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
+static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
+{
+	struct nfs4_client *clp = cb->cb_clp;
+	bool clear_inflight = cb->cb_inflight;
+
+	nfsd41_cb_release_slot(cb);
+	if (cb->cb_ops && cb->cb_ops->release)
+		cb->cb_ops->release(cb);
+	if (clear_inflight)
+		nfsd41_cb_inflight_end(clp);
+}
+
 /*
  * TODO: cb_sequence should support referring call lists, cachethis, multiple
  * slots, and mark callback channel down on communication errors.
@@ -1005,11 +1055,8 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
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
 
@@ -1076,9 +1123,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 			cb->cb_seq_status);
 	}
 
-	cb->cb_holds_slot = false;
-	clear_bit(0, &clp->cl_cb_slot_busy);
-	rpc_wake_up_next(&clp->cl_cb_waitq);
+	nfsd41_cb_release_slot(cb);
 	dprintk("%s: freed slot, new seqid=%d\n", __func__,
 		clp->cl_cb_session->se_cb_seq_nr);
 
@@ -1091,8 +1136,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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
 
@@ -1136,7 +1183,7 @@ static void nfsd4_cb_release(void *calldata)
 	if (cb->cb_need_restart)
 		nfsd4_run_cb(cb);
 	else
-		cb->cb_ops->release(cb);
+		nfsd41_destroy_cb(cb);
 
 }
 
@@ -1170,6 +1217,7 @@ void nfsd4_shutdown_callback(struct nfs4_client *clp)
 	 */
 	nfsd4_run_cb(&clp->cl_cb_null);
 	flush_workqueue(callback_wq);
+	nfsd41_cb_inflight_wait_complete(clp);
 }
 
 /* requires cl_lock: */
@@ -1255,8 +1303,7 @@ nfsd4_run_cb_work(struct work_struct *work)
 	clnt = clp->cl_cb_client;
 	if (!clnt) {
 		/* Callback channel broken, or client killed; give up: */
-		if (cb->cb_ops && cb->cb_ops->release)
-			cb->cb_ops->release(cb);
+		nfsd41_destroy_cb(cb);
 		return;
 	}
 
@@ -1265,6 +1312,7 @@ nfsd4_run_cb_work(struct work_struct *work)
 	 */
 	if (!cb->cb_ops && clp->cl_minorversion) {
 		clp->cl_cb_state = NFSD4_CB_UP;
+		nfsd41_destroy_cb(cb);
 		return;
 	}
 
@@ -1286,9 +1334,11 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	cb->cb_status = 0;
 	cb->cb_need_restart = false;
 	cb->cb_holds_slot = false;
+	cb->cb_inflight = false;
 }
 
 void nfsd4_run_cb(struct nfsd4_callback *cb)
 {
+	nfs41_cb_inflight_begin(cb);
 	queue_work(callback_wq, &cb->cb_work);
 }
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 46f56afb6cb8..a35020151409 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -72,6 +72,7 @@ struct nfsd4_callback {
 	int cb_status;
 	bool cb_need_restart;
 	bool cb_holds_slot;
+	bool cb_inflight;
 };
 
 struct nfsd4_callback_ops {
@@ -367,6 +368,7 @@ struct nfs4_client {
 	struct net		*net;
 	struct list_head	async_copies;	/* list of async copies */
 	spinlock_t		async_lock;	/* lock for async copies */
+	atomic_t		cl_cb_inflight;	/* Outstanding callbacks */
 };
 
 /* struct nfs4_client_reset
-- 
2.21.0

