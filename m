Return-Path: <linux-nfs+bounces-10724-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8821CA6AC55
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 18:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C39788A4A3C
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Mar 2025 17:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2594C225A38;
	Thu, 20 Mar 2025 17:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3E41ir+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01181225785
	for <linux-nfs@vger.kernel.org>; Thu, 20 Mar 2025 17:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492684; cv=none; b=kIRhlB9DZafnwC2xukgVoAe6RMBdI1IDOKkpvTuABP27uTNeazRCSzqcjnIS6fSXYiS4Oo3vOyUPDaOiFqPVyRuBar13i7Ma5B6DIqHbqlx9FeqZ8DT5U3FbVgx5GiA/YmQb159YHjxYBjpGigBUjqWw3aOhKMYMfZTALCAUo9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492684; c=relaxed/simple;
	bh=ndxDqrNtGbUlVIltdjcf/cZQe3NJiSbBPRvRc+/+WQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9eZK/hgRJmVoTEmejhe7zpY3ZMg3tpqrDI31kFWWJZCnZszZ17tWR8Nl+tArofxMHM4D1+TK2Ftjy9KMGsecxPN2Qbgd2qp5khScW+9FLav4CWvCJUDJ22nBt2huuTHSoqRaZAjI8LouDeuewlQw73J33odSRLHE+UBpkBQuzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3E41ir+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1363C4CEE8;
	Thu, 20 Mar 2025 17:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742492683;
	bh=ndxDqrNtGbUlVIltdjcf/cZQe3NJiSbBPRvRc+/+WQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O3E41ir+wlvY5sva4I+A+zHDAwXrPvEkZuFd1jVCd68UHelSu3dvkSou/Jw395kb/
	 aYKcDdXb6wbsLSeC5OTMt0PZ//YInX4CpIa2BnYpywF6JJHtluTqvJ50GWUKohevRO
	 oEr3OOrcTyWw4GMR6oZYkQkDqvfZY3MB8eFYVLxPTGYqfXsZn0seCDY8FrkltUFL06
	 rWHZsTs7EtmlPGBHAEJsGQxW2eBvjhdozVw48vd5XWsYIa9LAzTKVOx3v7oBGhuDXm
	 S7Vm2h/P+GRquzlWf1hnWPf8PcM+IFIQLW4IDZkmy/xvh3nWG4mu6Zz5pPyke39k+t
	 +Ll0iGYNTyS2Q==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH RFC 2/4] NFS: Treat ENETUNREACH errors as fatal in containers
Date: Thu, 20 Mar 2025 13:44:38 -0400
Message-ID: <af43d9d411baf9a08f5ae51180ac39374f6e4152.1742490771.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742490771.git.trond.myklebust@hammerspace.com>
References: <cover.1742490771.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Propagate the NFS_MOUNT_NETUNREACH_FATAL flag to work with the generic
NFS client. If the flag is set, the client will receive ENETDOWN and
ENETUNREACH errors from the RPC layer, and is expected to treat them as
being fatal.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c              |  5 +++++
 fs/nfs/nfs4proc.c            |  3 +++
 include/linux/nfs_fs_sb.h    |  1 +
 include/linux/sunrpc/clnt.h  |  5 ++++-
 include/linux/sunrpc/sched.h |  1 +
 net/sunrpc/clnt.c            | 30 ++++++++++++++++++++++--------
 6 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 3b0918ade53c..02c916a55020 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -546,6 +546,8 @@ int nfs_create_rpc_client(struct nfs_client *clp,
 		args.flags |= RPC_CLNT_CREATE_NOPING;
 	if (test_bit(NFS_CS_REUSEPORT, &clp->cl_flags))
 		args.flags |= RPC_CLNT_CREATE_REUSEPORT;
+	if (test_bit(NFS_CS_NETUNREACH_FATAL, &clp->cl_flags))
+		args.flags |= RPC_CLNT_CREATE_NETUNREACH_FATAL;
 
 	if (!IS_ERR(clp->cl_rpcclient))
 		return 0;
@@ -709,6 +711,9 @@ static int nfs_init_server(struct nfs_server *server,
 	if (ctx->flags & NFS_MOUNT_NORESVPORT)
 		set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
+	if (ctx->flags & NFS_MOUNT_NETUNREACH_FATAL)
+		__set_bit(NFS_CS_NETUNREACH_FATAL, &cl_init.init_flags);
+
 	/* Allocate or find a client reference we can use */
 	clp = nfs_get_client(&cl_init);
 	if (IS_ERR(clp))
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index f195e7ceca1b..6fb3708560cf 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -195,6 +195,9 @@ static int nfs4_map_errors(int err)
 		return -EBUSY;
 	case -NFS4ERR_NOT_SAME:
 		return -ENOTSYNC;
+	case -ENETDOWN:
+	case -ENETUNREACH:
+		break;
 	default:
 		dprintk("%s could not handle NFSv4 error %d\n",
 				__func__, -err);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index a6ce8590eaaf..71319637a84e 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -50,6 +50,7 @@ struct nfs_client {
 #define NFS_CS_DS		7		/* - Server is a DS */
 #define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
 #define NFS_CS_PNFS		9		/* - Server used for pnfs */
+#define NFS_CS_NETUNREACH_FATAL	10		/* - ENETUNREACH errors are fatal */
 	struct sockaddr_storage	cl_addr;	/* server identifier */
 	size_t			cl_addrlen;
 	char *			cl_hostname;	/* hostname of server */
diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 9ad353f26f4f..5d9cdf31853c 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -64,7 +64,9 @@ struct rpc_clnt {
 				cl_noretranstimeo: 1,/* No retransmit timeouts */
 				cl_autobind : 1,/* use getport() */
 				cl_chatty   : 1,/* be verbose */
-				cl_shutdown : 1;/* rpc immediate -EIO */
+				cl_shutdown : 1,/* rpc immediate -EIO */
+				cl_netunreach_fatal : 1;
+						/* Treat ENETUNREACH errors as fatal */
 	struct xprtsec_parms	cl_xprtsec;	/* transport security policy */
 
 	struct rpc_rtt *	cl_rtt;		/* RTO estimator data */
@@ -175,6 +177,7 @@ struct rpc_add_xprt_test {
 #define RPC_CLNT_CREATE_SOFTERR		(1UL << 10)
 #define RPC_CLNT_CREATE_REUSEPORT	(1UL << 11)
 #define RPC_CLNT_CREATE_CONNECTED	(1UL << 12)
+#define RPC_CLNT_CREATE_NETUNREACH_FATAL	(1UL << 13)
 
 struct rpc_clnt *rpc_create(struct rpc_create_args *args);
 struct rpc_clnt	*rpc_bind_new_program(struct rpc_clnt *,
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index eac57914dcf3..ccba79ebf893 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -134,6 +134,7 @@ struct rpc_task_setup {
 #define RPC_TASK_MOVEABLE	0x0004		/* nfs4.1+ rpc tasks */
 #define RPC_TASK_NULLCREDS	0x0010		/* Use AUTH_NULL credential */
 #define RPC_CALL_MAJORSEEN	0x0020		/* major timeout seen */
+#define RPC_TASK_NETUNREACH_FATAL 0x0040	/* ENETUNREACH is fatal */
 #define RPC_TASK_DYNAMIC	0x0080		/* task was kmalloc'ed */
 #define	RPC_TASK_NO_ROUND_ROBIN	0x0100		/* send requests on "main" xprt */
 #define RPC_TASK_SOFT		0x0200		/* Use soft timeouts */
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 3499b17ffea7..45f0154a0d07 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -512,6 +512,8 @@ static struct rpc_clnt *rpc_create_xprt(struct rpc_create_args *args,
 		clnt->cl_discrtry = 1;
 	if (!(args->flags & RPC_CLNT_CREATE_QUIET))
 		clnt->cl_chatty = 1;
+	if (args->flags & RPC_CLNT_CREATE_NETUNREACH_FATAL)
+		clnt->cl_netunreach_fatal = 1;
 
 	return clnt;
 }
@@ -662,6 +664,7 @@ static struct rpc_clnt *__rpc_clone_client(struct rpc_create_args *args,
 	new->cl_noretranstimeo = clnt->cl_noretranstimeo;
 	new->cl_discrtry = clnt->cl_discrtry;
 	new->cl_chatty = clnt->cl_chatty;
+	new->cl_netunreach_fatal = clnt->cl_netunreach_fatal;
 	new->cl_principal = clnt->cl_principal;
 	new->cl_max_connect = clnt->cl_max_connect;
 	return new;
@@ -1195,6 +1198,8 @@ void rpc_task_set_client(struct rpc_task *task, struct rpc_clnt *clnt)
 		task->tk_flags |= RPC_TASK_TIMEOUT;
 	if (clnt->cl_noretranstimeo)
 		task->tk_flags |= RPC_TASK_NO_RETRANS_TIMEOUT;
+	if (clnt->cl_netunreach_fatal)
+		task->tk_flags |= RPC_TASK_NETUNREACH_FATAL;
 	atomic_inc(&clnt->cl_task_count);
 }
 
@@ -2101,14 +2106,17 @@ call_bind_status(struct rpc_task *task)
 	case -EPROTONOSUPPORT:
 		trace_rpcb_bind_version_err(task);
 		goto retry_timeout;
+	case -ENETDOWN:
+	case -ENETUNREACH:
+		if (task->tk_flags & RPC_TASK_NETUNREACH_FATAL)
+			break;
+		fallthrough;
 	case -ECONNREFUSED:		/* connection problems */
 	case -ECONNRESET:
 	case -ECONNABORTED:
 	case -ENOTCONN:
 	case -EHOSTDOWN:
-	case -ENETDOWN:
 	case -EHOSTUNREACH:
-	case -ENETUNREACH:
 	case -EPIPE:
 		trace_rpcb_unreachable_err(task);
 		if (!RPC_IS_SOFTCONN(task)) {
@@ -2190,19 +2198,22 @@ call_connect_status(struct rpc_task *task)
 
 	task->tk_status = 0;
 	switch (status) {
+	case -ENETDOWN:
+	case -ENETUNREACH:
+		if (task->tk_flags & RPC_TASK_NETUNREACH_FATAL)
+			break;
+		fallthrough;
 	case -ECONNREFUSED:
 	case -ECONNRESET:
 		/* A positive refusal suggests a rebind is needed. */
-		if (RPC_IS_SOFTCONN(task))
-			break;
 		if (clnt->cl_autobind) {
 			rpc_force_rebind(clnt);
+			if (RPC_IS_SOFTCONN(task))
+				break;
 			goto out_retry;
 		}
 		fallthrough;
 	case -ECONNABORTED:
-	case -ENETDOWN:
-	case -ENETUNREACH:
 	case -EHOSTUNREACH:
 	case -EPIPE:
 	case -EPROTO:
@@ -2454,10 +2465,13 @@ call_status(struct rpc_task *task)
 	trace_rpc_call_status(task);
 	task->tk_status = 0;
 	switch(status) {
-	case -EHOSTDOWN:
 	case -ENETDOWN:
-	case -EHOSTUNREACH:
 	case -ENETUNREACH:
+		if (task->tk_flags & RPC_TASK_NETUNREACH_FATAL)
+			goto out_exit;
+		fallthrough;
+	case -EHOSTDOWN:
+	case -EHOSTUNREACH:
 	case -EPERM:
 		if (RPC_IS_SOFTCONN(task))
 			goto out_exit;
-- 
2.48.1


