Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B893D2E9C6
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 02:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfE3AnY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 20:43:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:46426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfE3AnY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 20:43:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EEE3FAC66;
        Thu, 30 May 2019 00:43:21 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Thu, 30 May 2019 10:41:28 +1000
Subject: [PATCH 3/9] NFS: send state management on a single connection.
Cc:     linux-nfs@vger.kernel.org
Message-ID: <155917688863.3988.8318604225894720148.stgit@noble.brown>
In-Reply-To: <155917564898.3988.6096672032831115016.stgit@noble.brown>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

With NFSv4.1, different network connections need to be explicitly
bound to a session.  During session startup, this is not possible
so only a single connection must be used for session startup.

So add a task flag to disable the default round-robin choice of
connections (when nconnect > 1) and force the use of a single
connection.
Then use that flag on all requests for session management - for
consistence, include NFSv4.0 management (SETCLIENTID) and session
destruction

Reported-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 fs/nfs/nfs4proc.c            |   22 +++++++++++++---------
 include/linux/sunrpc/sched.h |    1 +
 net/sunrpc/clnt.c            |   24 +++++++++++++++++++++++-
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c29cbef6b53f..22b3dbfc4fa1 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5978,7 +5978,7 @@ int nfs4_proc_setclientid(struct nfs_client *clp, u32 program,
 		.rpc_message = &msg,
 		.callback_ops = &nfs4_setclientid_ops,
 		.callback_data = &setclientid,
-		.flags = RPC_TASK_TIMEOUT,
+		.flags = RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN,
 	};
 	int status;
 
@@ -6044,7 +6044,8 @@ int nfs4_proc_setclientid_confirm(struct nfs_client *clp,
 	dprintk("NFS call  setclientid_confirm auth=%s, (client ID %llx)\n",
 		clp->cl_rpcclient->cl_auth->au_ops->au_name,
 		clp->cl_clientid);
-	status = rpc_call_sync(clp->cl_rpcclient, &msg, RPC_TASK_TIMEOUT);
+	status = rpc_call_sync(clp->cl_rpcclient, &msg,
+			       RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN);
 	trace_nfs4_setclientid_confirm(clp, status);
 	dprintk("NFS reply setclientid_confirm: %d\n", status);
 	return status;
@@ -7633,7 +7634,7 @@ static int _nfs4_proc_secinfo(struct inode *dir, const struct qstr *name, struct
 		NFS_SP4_MACH_CRED_SECINFO, &clnt, &msg);
 
 	status = nfs4_call_sync(clnt, NFS_SERVER(dir), &msg, &args.seq_args,
-				&res.seq_res, 0);
+				&res.seq_res, RPC_TASK_NO_ROUND_ROBIN);
 	dprintk("NFS reply  secinfo: %d\n", status);
 
 	put_cred(cred);
@@ -7971,7 +7972,7 @@ nfs4_run_exchange_id(struct nfs_client *clp, const struct cred *cred,
 		.rpc_client = clp->cl_rpcclient,
 		.callback_ops = &nfs4_exchange_id_call_ops,
 		.rpc_message = &msg,
-		.flags = RPC_TASK_TIMEOUT,
+		.flags = RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN,
 	};
 	struct nfs41_exchange_id_data *calldata;
 	int status;
@@ -8196,7 +8197,8 @@ static int _nfs4_proc_destroy_clientid(struct nfs_client *clp,
 	};
 	int status;
 
-	status = rpc_call_sync(clp->cl_rpcclient, &msg, RPC_TASK_TIMEOUT);
+	status = rpc_call_sync(clp->cl_rpcclient, &msg,
+			       RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN);
 	trace_nfs4_destroy_clientid(clp, status);
 	if (status)
 		dprintk("NFS: Got error %d from the server %s on "
@@ -8475,7 +8477,8 @@ static int _nfs4_proc_create_session(struct nfs_client *clp,
 	nfs4_init_channel_attrs(&args, clp->cl_rpcclient);
 	args.flags = (SESSION4_PERSIST | SESSION4_BACK_CHAN);
 
-	status = rpc_call_sync(session->clp->cl_rpcclient, &msg, RPC_TASK_TIMEOUT);
+	status = rpc_call_sync(session->clp->cl_rpcclient, &msg,
+			       RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN);
 	trace_nfs4_create_session(clp, status);
 
 	switch (status) {
@@ -8551,7 +8554,8 @@ int nfs4_proc_destroy_session(struct nfs4_session *session,
 	if (!test_and_clear_bit(NFS4_SESSION_ESTABLISHED, &session->session_state))
 		return 0;
 
-	status = rpc_call_sync(session->clp->cl_rpcclient, &msg, RPC_TASK_TIMEOUT);
+	status = rpc_call_sync(session->clp->cl_rpcclient, &msg,
+			       RPC_TASK_TIMEOUT | RPC_TASK_NO_ROUND_ROBIN);
 	trace_nfs4_destroy_session(session->clp, status);
 
 	if (status)
@@ -8805,7 +8809,7 @@ static int nfs41_proc_reclaim_complete(struct nfs_client *clp,
 		.rpc_client = clp->cl_rpcclient,
 		.rpc_message = &msg,
 		.callback_ops = &nfs4_reclaim_complete_call_ops,
-		.flags = RPC_TASK_ASYNC,
+		.flags = RPC_TASK_ASYNC | RPC_TASK_NO_ROUND_ROBIN,
 	};
 	int status = -ENOMEM;
 
@@ -9324,7 +9328,7 @@ _nfs41_proc_secinfo_no_name(struct nfs_server *server, struct nfs_fh *fhandle,
 
 	dprintk("--> %s\n", __func__);
 	status = nfs4_call_sync(clnt, server, &msg, &args.seq_args,
-				&res.seq_res, 0);
+				&res.seq_res, RPC_TASK_NO_ROUND_ROBIN);
 	dprintk("<-- %s status=%d\n", __func__, status);
 
 	put_cred(cred);
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index d0e451868f02..11424bdf09e6 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -126,6 +126,7 @@ struct rpc_task_setup {
 #define RPC_CALL_MAJORSEEN	0x0020		/* major timeout seen */
 #define RPC_TASK_ROOTCREDS	0x0040		/* force root creds */
 #define RPC_TASK_DYNAMIC	0x0080		/* task was kmalloc'ed */
+#define	RPC_TASK_NO_ROUND_ROBIN	0x0100		/* send requests on "main" xprt */
 #define RPC_TASK_SOFT		0x0200		/* Use soft timeouts */
 #define RPC_TASK_SOFTCONN	0x0400		/* Fail if can't connect */
 #define RPC_TASK_SENT		0x0800		/* message was sent */
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 3619dd5e9e0e..45802dd3fc86 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1013,6 +1013,24 @@ xprt_get_client(struct rpc_xprt *xprt, struct rpc_clnt *clnt)
 	return xprt;
 }
 
+static struct rpc_xprt *
+rpc_task_get_first_xprt(struct rpc_clnt *clnt)
+{
+	struct rpc_xprt_switch *xps;
+	struct rpc_xprt *xprt;
+
+	rcu_read_lock();
+	xprt = xprt_get(rcu_dereference(clnt->cl_xprt));
+	if (xprt) {
+		atomic_long_inc(&xprt->queuelen);
+		xps = rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
+		atomic_long_inc(&xps->xps_queuelen);
+	}
+	rcu_read_unlock();
+
+	return xprt;
+}
+
 static void
 rpc_task_release_xprt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
 {
@@ -1060,7 +1078,11 @@ void rpc_task_release_client(struct rpc_task *task)
 static
 void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *clnt)
 {
-	if (!task->tk_xprt)
+	if (task->tk_xprt)
+		return;
+	if (task->tk_flags & RPC_TASK_NO_ROUND_ROBIN)
+		task->tk_xprt = rpc_task_get_first_xprt(clnt);
+	else
 		task->tk_xprt = rpc_task_get_xprt(clnt);
 }
 


