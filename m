Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B66D430528
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244692AbhJPWFO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:05:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235616AbhJPWFN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:05:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 318AA60F57;
        Sat, 16 Oct 2021 22:03:05 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 7/7] NFS: Remove --> and <-- dprintk call sites
Date:   Sat, 16 Oct 2021 18:03:04 -0400
Message-Id:  <163442178407.1585.13005264694170305348.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To:  <163442096873.1585.8967342784030733636.stgit@morisot.1015granger.net>
References:  <163442096873.1585.8967342784030733636.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=12007; h=from:subject:message-id; bh=VSc6Cb0mFxPIAQDYsqnvw8sxZZ5cuebOYaZR04iQupc=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha0wY+lE+V5a6qUFWOsmTw2jnT1FsOj/lL3kXRglf 7zZabMKJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtMGAAKCRAzarMzb2Z/l56bD/ sHkzSw6cfTbUFqh62JhkB7qniVjQLc0XV7HxeR5rqEar9G15rvTF/YimUG1/nw6HSG3t/xqssvy/Oo gZ+Bajbe0ui0aioIPCjj/4pcPPrJ2hoSLZGHqpORMIqFBMXlmk6eLsEaPzblSKOkKn41MhuW2yWsxj 443DCz+TOe2KNSJGFI0hXgFlAJETt96k3smP/DOMz9AHq9DQs0YXp4GD2c+p1X8mX8zUfLw8tdUMd2 rERwMSTeMyiDGaBZoTXeL7l3B8d6rGTSw2cbulEmeZl3T6kn5Oymc5dpekEPlrR0q6cMb9spFP59Y/ gNY9lCIbodtZS7/CmYw4AAkGCRTrN0ywWIdRbRpZJaYMjvzXfJyxD4wwCZEvnpVxLfS3Pb2VhtCSgF yieH4DCYC2gPuIIe0vnURqDtUPqscwtyyb+Zt+jyorqG/5Q43ly39fwP0QUVGXB5/zdgmwedvLBhgU tJJkQ/mNNVv+n0ir2h8E/bgZ6JOV8z44xjiLn1j+4XPel9mUGwcsuXwlmsEuQw0Wq/mWPvb7+EQVTO zA8A+0Ymujx/Phxcn6Xciaycg1jsDDjGixeQRgQMnqLVLS0RPTP1U5EjQVgqybVIuhFx97cE/LrlVn 9G7Sh4fWpzVD8Zi36MgRX78MlL1EzRx+Fml+3LqHqEK29t8eaBm2o4uWe/9Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

dprintk call sites that display no other information than the
function name can be replaced with use of the trace "function" or
"function_graph" plug-ins.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/nfs4proc.c |   54 +++++------------------------------------------------
 1 file changed, 5 insertions(+), 49 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e1214bb6b7ee..1e51ed1167c8 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3561,7 +3561,6 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
 		.stateid = &calldata->arg.stateid,
 	};
 
-	dprintk("%s: begin!\n", __func__);
 	if (!nfs4_sequence_done(task, &calldata->res.seq_res))
 		return;
 	trace_nfs4_close(state, &calldata->arg, &calldata->res, task->tk_status);
@@ -3616,7 +3615,7 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
 	task->tk_status = 0;
 	nfs_release_seqid(calldata->arg.seqid);
 	nfs_refresh_inode(calldata->inode, &calldata->fattr);
-	dprintk("%s: done, ret = %d!\n", __func__, task->tk_status);
+	dprintk("%s: ret = %d\n", __func__, task->tk_status);
 	return;
 out_restart:
 	task->tk_status = 0;
@@ -3634,7 +3633,6 @@ static void nfs4_close_prepare(struct rpc_task *task, void *data)
 	bool is_rdonly, is_wronly, is_rdwr;
 	int call_close = 0;
 
-	dprintk("%s: begin!\n", __func__);
 	if (nfs_wait_on_sequence(calldata->arg.seqid, task) != 0)
 		goto out_wait;
 
@@ -3708,7 +3706,6 @@ static void nfs4_close_prepare(struct rpc_task *task, void *data)
 				&calldata->res.seq_res,
 				task) != 0)
 		nfs_release_seqid(calldata->arg.seqid);
-	dprintk("%s: done!\n", __func__);
 	return;
 out_no_action:
 	task->tk_action = NULL;
@@ -5347,8 +5344,6 @@ static bool nfs4_read_plus_not_supported(struct rpc_task *task,
 
 static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 {
-	dprintk("--> %s\n", __func__);
-
 	if (!nfs4_sequence_done(task, &hdr->res.seq_res))
 		return -EAGAIN;
 	if (nfs4_read_stateid_changed(task, &hdr->args))
@@ -7003,7 +6998,6 @@ static void nfs4_lock_prepare(struct rpc_task *task, void *calldata)
 	struct nfs4_lockdata *data = calldata;
 	struct nfs4_state *state = data->lsp->ls_state;
 
-	dprintk("%s: begin!\n", __func__);
 	if (nfs_wait_on_sequence(data->arg.lock_seqid, task) != 0)
 		goto out_wait;
 	/* Do we need to do an open_to_lock_owner? */
@@ -7037,7 +7031,7 @@ static void nfs4_lock_prepare(struct rpc_task *task, void *calldata)
 	nfs_release_seqid(data->arg.lock_seqid);
 out_wait:
 	nfs4_sequence_done(task, &data->res.seq_res);
-	dprintk("%s: done!, ret = %d\n", __func__, data->rpc_status);
+	dprintk("%s: ret = %d\n", __func__, data->rpc_status);
 }
 
 static void nfs4_lock_done(struct rpc_task *task, void *calldata)
@@ -7045,8 +7039,6 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 	struct nfs4_lockdata *data = calldata;
 	struct nfs4_lock_state *lsp = data->lsp;
 
-	dprintk("%s: begin!\n", __func__);
-
 	if (!nfs4_sequence_done(task, &data->res.seq_res))
 		return;
 
@@ -7080,7 +7072,7 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 				goto out_restart;
 	}
 out_done:
-	dprintk("%s: done, ret = %d!\n", __func__, data->rpc_status);
+	dprintk("%s: ret = %d!\n", __func__, data->rpc_status);
 	return;
 out_restart:
 	if (!data->cancelled)
@@ -7092,7 +7084,6 @@ static void nfs4_lock_release(void *calldata)
 {
 	struct nfs4_lockdata *data = calldata;
 
-	dprintk("%s: begin!\n", __func__);
 	nfs_free_seqid(data->arg.open_seqid);
 	if (data->cancelled && data->rpc_status == 0) {
 		struct rpc_task *task;
@@ -7106,7 +7097,6 @@ static void nfs4_lock_release(void *calldata)
 	nfs4_put_lock_state(data->lsp);
 	put_nfs_open_context(data->ctx);
 	kfree(data);
-	dprintk("%s: done!\n", __func__);
 }
 
 static const struct rpc_call_ops nfs4_lock_ops = {
@@ -7153,7 +7143,6 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
 	if (client->cl_minorversion)
 		task_setup_data.flags |= RPC_TASK_MOVEABLE;
 
-	dprintk("%s: begin!\n", __func__);
 	data = nfs4_alloc_lockdata(fl, nfs_file_open_context(fl->fl_file),
 			fl->fl_u.nfs4_fl.owner,
 			recovery_type == NFS_LOCK_NEW ? GFP_KERNEL : GFP_NOFS);
@@ -7184,7 +7173,7 @@ static int _nfs4_do_setlk(struct nfs4_state *state, int cmd, struct file_lock *f
 		data->cancelled = true;
 	trace_nfs4_set_lock(fl, state, &data->res.stateid, cmd, ret);
 	rpc_put_task(task);
-	dprintk("%s: done, ret = %d!\n", __func__, ret);
+	dprintk("%s: ret = %d\n", __func__, ret);
 	return ret;
 }
 
@@ -8855,14 +8844,12 @@ static void nfs4_get_lease_time_prepare(struct rpc_task *task,
 	struct nfs4_get_lease_time_data *data =
 			(struct nfs4_get_lease_time_data *)calldata;
 
-	dprintk("--> %s\n", __func__);
 	/* just setup sequence, do not trigger session recovery
 	   since we're invoked within one */
 	nfs4_setup_sequence(data->clp,
 			&data->args->la_seq_args,
 			&data->res->lr_seq_res,
 			task);
-	dprintk("<-- %s\n", __func__);
 }
 
 /*
@@ -8874,13 +8861,11 @@ static void nfs4_get_lease_time_done(struct rpc_task *task, void *calldata)
 	struct nfs4_get_lease_time_data *data =
 			(struct nfs4_get_lease_time_data *)calldata;
 
-	dprintk("--> %s\n", __func__);
 	if (!nfs4_sequence_done(task, &data->res->lr_seq_res))
 		return;
 	switch (task->tk_status) {
 	case -NFS4ERR_DELAY:
 	case -NFS4ERR_GRACE:
-		dprintk("%s Retry: tk_status %d\n", __func__, task->tk_status);
 		rpc_delay(task, NFS4_POLL_RETRY_MIN);
 		task->tk_status = 0;
 		fallthrough;
@@ -8888,7 +8873,6 @@ static void nfs4_get_lease_time_done(struct rpc_task *task, void *calldata)
 		rpc_restart_call_prepare(task);
 		return;
 	}
-	dprintk("<-- %s\n", __func__);
 }
 
 static const struct rpc_call_ops nfs4_get_lease_time_ops = {
@@ -9120,7 +9104,6 @@ int nfs4_proc_create_session(struct nfs_client *clp, const struct cred *cred)
 	dprintk("%s client>seqid %d sessionid %u:%u:%u:%u\n", __func__,
 		clp->cl_seqid, ptr[0], ptr[1], ptr[2], ptr[3]);
 out:
-	dprintk("<-- %s\n", __func__);
 	return status;
 }
 
@@ -9138,8 +9121,6 @@ int nfs4_proc_destroy_session(struct nfs4_session *session,
 	};
 	int status = 0;
 
-	dprintk("--> nfs4_proc_destroy_session\n");
-
 	/* session is still being setup */
 	if (!test_and_clear_bit(NFS4_SESSION_ESTABLISHED, &session->session_state))
 		return 0;
@@ -9151,8 +9132,6 @@ int nfs4_proc_destroy_session(struct nfs4_session *session,
 	if (status)
 		dprintk("NFS: Got error %d from the server on DESTROY_SESSION. "
 			"Session has been destroyed regardless...\n", status);
-
-	dprintk("<-- nfs4_proc_destroy_session\n");
 	return status;
 }
 
@@ -9200,7 +9179,7 @@ static void nfs41_sequence_call_done(struct rpc_task *task, void *data)
 	if (task->tk_status < 0) {
 		dprintk("%s ERROR %d\n", __func__, task->tk_status);
 		if (refcount_read(&clp->cl_count) == 1)
-			goto out;
+			return;
 
 		if (nfs41_sequence_handle_errors(task, clp) == -EAGAIN) {
 			rpc_restart_call_prepare(task);
@@ -9208,8 +9187,6 @@ static void nfs41_sequence_call_done(struct rpc_task *task, void *data)
 		}
 	}
 	dprintk("%s rpc_cred %p\n", __func__, task->tk_msg.rpc_cred);
-out:
-	dprintk("<-- %s\n", __func__);
 }
 
 static void nfs41_sequence_prepare(struct rpc_task *task, void *data)
@@ -9356,7 +9333,6 @@ static void nfs4_reclaim_complete_done(struct rpc_task *task, void *data)
 	struct nfs_client *clp = calldata->clp;
 	struct nfs4_sequence_res *res = &calldata->res.seq_res;
 
-	dprintk("--> %s\n", __func__);
 	if (!nfs41_sequence_done(task, res))
 		return;
 
@@ -9365,7 +9341,6 @@ static void nfs4_reclaim_complete_done(struct rpc_task *task, void *data)
 		rpc_restart_call_prepare(task);
 		return;
 	}
-	dprintk("<-- %s\n", __func__);
 }
 
 static void nfs4_free_reclaim_complete_data(void *data)
@@ -9400,7 +9375,6 @@ static int nfs41_proc_reclaim_complete(struct nfs_client *clp,
 	};
 	int status = -ENOMEM;
 
-	dprintk("--> %s\n", __func__);
 	calldata = kzalloc(sizeof(*calldata), GFP_NOFS);
 	if (calldata == NULL)
 		goto out;
@@ -9423,19 +9397,15 @@ nfs4_layoutget_prepare(struct rpc_task *task, void *calldata)
 	struct nfs4_layoutget *lgp = calldata;
 	struct nfs_server *server = NFS_SERVER(lgp->args.inode);
 
-	dprintk("--> %s\n", __func__);
 	nfs4_setup_sequence(server->nfs_client, &lgp->args.seq_args,
 				&lgp->res.seq_res, task);
-	dprintk("<-- %s\n", __func__);
 }
 
 static void nfs4_layoutget_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs4_layoutget *lgp = calldata;
 
-	dprintk("--> %s\n", __func__);
 	nfs41_sequence_process(task, &lgp->res.seq_res);
-	dprintk("<-- %s\n", __func__);
 }
 
 static int
@@ -9524,7 +9494,6 @@ nfs4_layoutget_handle_exception(struct rpc_task *task,
 			status = err;
 	}
 out:
-	dprintk("<-- %s\n", __func__);
 	return status;
 }
 
@@ -9538,10 +9507,8 @@ static void nfs4_layoutget_release(void *calldata)
 {
 	struct nfs4_layoutget *lgp = calldata;
 
-	dprintk("--> %s\n", __func__);
 	nfs4_sequence_free_slot(&lgp->res.seq_res);
 	pnfs_layoutget_free(lgp);
-	dprintk("<-- %s\n", __func__);
 }
 
 static const struct rpc_call_ops nfs4_layoutget_call_ops = {
@@ -9577,8 +9544,6 @@ nfs4_proc_layoutget(struct nfs4_layoutget *lgp, long *timeout)
 	};
 	int status = 0;
 
-	dprintk("--> %s\n", __func__);
-
 	nfs4_init_sequence(&lgp->args.seq_args, &lgp->res.seq_res, 0, 0);
 
 	task = rpc_run_task(&task_setup_data);
@@ -9614,7 +9579,6 @@ nfs4_layoutreturn_prepare(struct rpc_task *task, void *calldata)
 {
 	struct nfs4_layoutreturn *lrp = calldata;
 
-	dprintk("--> %s\n", __func__);
 	nfs4_setup_sequence(lrp->clp,
 			&lrp->args.seq_args,
 			&lrp->res.seq_res,
@@ -9628,8 +9592,6 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 	struct nfs4_layoutreturn *lrp = calldata;
 	struct nfs_server *server;
 
-	dprintk("--> %s\n", __func__);
-
 	if (!nfs41_sequence_process(task, &lrp->res.seq_res))
 		return;
 
@@ -9660,7 +9622,6 @@ static void nfs4_layoutreturn_done(struct rpc_task *task, void *calldata)
 			break;
 		goto out_restart;
 	}
-	dprintk("<-- %s\n", __func__);
 	return;
 out_restart:
 	task->tk_status = 0;
@@ -9673,7 +9634,6 @@ static void nfs4_layoutreturn_release(void *calldata)
 	struct nfs4_layoutreturn *lrp = calldata;
 	struct pnfs_layout_hdr *lo = lrp->args.layout;
 
-	dprintk("--> %s\n", __func__);
 	pnfs_layoutreturn_free_lsegs(lo, &lrp->args.stateid, &lrp->args.range,
 			lrp->res.lrs_present ? &lrp->res.stateid : NULL);
 	nfs4_sequence_free_slot(&lrp->res.seq_res);
@@ -9683,7 +9643,6 @@ static void nfs4_layoutreturn_release(void *calldata)
 	nfs_iput_and_deactive(lrp->inode);
 	put_cred(lrp->cred);
 	kfree(calldata);
-	dprintk("<-- %s\n", __func__);
 }
 
 static const struct rpc_call_ops nfs4_layoutreturn_call_ops = {
@@ -9714,7 +9673,6 @@ int nfs4_proc_layoutreturn(struct nfs4_layoutreturn *lrp, bool sync)
 			NFS_SP4_MACH_CRED_PNFS_CLEANUP,
 			&task_setup_data.rpc_client, &msg);
 
-	dprintk("--> %s\n", __func__);
 	lrp->inode = nfs_igrab_and_active(lrp->args.inode);
 	if (!sync) {
 		if (!lrp->inode) {
@@ -9761,7 +9719,6 @@ _nfs4_proc_getdeviceinfo(struct nfs_server *server,
 	};
 	int status;
 
-	dprintk("--> %s\n", __func__);
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 	if (res.notification & ~args.notify_types)
 		dprintk("%s: unsupported notification\n", __func__);
@@ -9933,7 +9890,6 @@ _nfs41_proc_secinfo_no_name(struct nfs_server *server, struct nfs_fh *fhandle,
 		msg.rpc_cred = cred;
 	}
 
-	dprintk("--> %s\n", __func__);
 	nfs4_init_sequence(&args.seq_args, &res.seq_res, 0, 0);
 	status = nfs4_call_sync_custom(&task_setup);
 	dprintk("<-- %s status=%d\n", __func__, status);

