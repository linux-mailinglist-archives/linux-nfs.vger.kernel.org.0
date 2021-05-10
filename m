Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC7737930F
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 17:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhEJPw7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 11:52:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231553AbhEJPwz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 May 2021 11:52:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 952DE61278;
        Mon, 10 May 2021 15:51:50 +0000 (UTC)
Subject: [PATCH RFC 02/21] NFSD: Capture every CB state transition
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dwysocha@redhat.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 10 May 2021 11:51:49 -0400
Message-ID: <162066190986.94415.14169521998645521262.stgit@klimt.1015granger.net>
In-Reply-To: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We were missing one.

As a clean-up, add a helper that sets the new CB state and fires
a tracepoint. The tracepoint fires only when the state changes, to
help reduce trace log noise.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 7325592b456e..b6cc51a9f37c 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -945,20 +945,26 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 	return 0;
 }
 
+static void nfsd4_mark_cb_state(struct nfs4_client *clp, int newstate)
+{
+	if (clp->cl_cb_state != newstate) {
+		clp->cl_cb_state = newstate;
+		trace_nfsd_cb_state(clp);
+	}
+}
+
 static void nfsd4_mark_cb_down(struct nfs4_client *clp, int reason)
 {
 	if (test_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags))
 		return;
-	clp->cl_cb_state = NFSD4_CB_DOWN;
-	trace_nfsd_cb_state(clp);
+	nfsd4_mark_cb_state(clp, NFSD4_CB_DOWN);
 }
 
 static void nfsd4_mark_cb_fault(struct nfs4_client *clp, int reason)
 {
 	if (test_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags))
 		return;
-	clp->cl_cb_state = NFSD4_CB_FAULT;
-	trace_nfsd_cb_state(clp);
+	nfsd4_mark_cb_state(clp, NFSD4_CB_FAULT);
 }
 
 static void nfsd4_cb_probe_done(struct rpc_task *task, void *calldata)
@@ -968,10 +974,8 @@ static void nfsd4_cb_probe_done(struct rpc_task *task, void *calldata)
 	trace_nfsd_cb_done(clp, task->tk_status);
 	if (task->tk_status)
 		nfsd4_mark_cb_down(clp, task->tk_status);
-	else {
-		clp->cl_cb_state = NFSD4_CB_UP;
-		trace_nfsd_cb_state(clp);
-	}
+	else
+		nfsd4_mark_cb_state(clp, NFSD4_CB_UP);
 }
 
 static void nfsd4_cb_probe_release(void *calldata)
@@ -995,8 +999,7 @@ static const struct rpc_call_ops nfsd4_cb_probe_ops = {
  */
 void nfsd4_probe_callback(struct nfs4_client *clp)
 {
-	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
-	trace_nfsd_cb_state(clp);
+	nfsd4_mark_cb_state(clp, NFSD4_CB_UNKNOWN);
 	set_bit(NFSD4_CLIENT_CB_UPDATE, &clp->cl_flags);
 	nfsd4_run_cb(&clp->cl_cb_null);
 }
@@ -1009,11 +1012,10 @@ void nfsd4_probe_callback_sync(struct nfs4_client *clp)
 
 void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *conn)
 {
-	clp->cl_cb_state = NFSD4_CB_UNKNOWN;
+	nfsd4_mark_cb_state(clp, NFSD4_CB_UNKNOWN);
 	spin_lock(&clp->cl_lock);
 	memcpy(&clp->cl_cb_conn, conn, sizeof(struct nfs4_cb_conn));
 	spin_unlock(&clp->cl_lock);
-	trace_nfsd_cb_state(clp);
 }
 
 /*
@@ -1345,7 +1347,7 @@ nfsd4_run_cb_work(struct work_struct *work)
 	 * Don't send probe messages for 4.1 or later.
 	 */
 	if (!cb->cb_ops && clp->cl_minorversion) {
-		clp->cl_cb_state = NFSD4_CB_UP;
+		nfsd4_mark_cb_state(clp, NFSD4_CB_UP);
 		nfsd41_destroy_cb(cb);
 		return;
 	}


