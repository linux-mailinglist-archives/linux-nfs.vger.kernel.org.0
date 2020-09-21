Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165172731B1
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 20:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgIUSNJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 14:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgIUSNJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 14:13:09 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840D9C061755
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:13:09 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z25so16425611iol.10
        for <linux-nfs@vger.kernel.org>; Mon, 21 Sep 2020 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/2Q3elhH00r9aUMUVsPp9Kp/w14b9Y+65fXKNeC47fc=;
        b=LPvRI7171nAR8NrLu6PUWGRuIkpBUjsztCXXwLEW2ywhG+q8xolW4NIhNyOdRO4VPy
         oFEFNtOZnra/MqxTAXD96JLD+turqx/CZH0AfLNw4KBNIFMmL/OnHd9bTxfyjnQQrVNb
         hU30P1qReAI4gCpSBcAySbhK2gN87CMTdu6W30beTbX95jsYAWV2D+nGN8AlJQexxzV6
         MBLruDqFRywyaozG378l+cY4kl5VSVg9f+2f2hNjadEdUvhOv1e7Zow0hb3pl+WTPz+o
         YZy4vypTFu6OrfIEDOEk4CAl/n7IzKgFP4nLOV3UapL09d/Xb8xPD4KtHf2/Ky8A3Fks
         mlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=/2Q3elhH00r9aUMUVsPp9Kp/w14b9Y+65fXKNeC47fc=;
        b=cCiM2veiDAX99jIS8uzFrB2moLBhlYfpy2ZBMqpuM80mYTCJMcBM2sAStGjzeCEnHc
         r6kdqdSruiGisDEqyVK529SQBIv86vLCXl0o60VkdIpZ5AH8wDRTgUQOHAjasi0ilH7v
         a9/zErBGd1UsnjkYKSwQzKXufolOdVXNV/3hA19wjK1Wn/FR/ALdBtJQX6eItVG7fKNA
         zabJKdHL9TVho/yyhy9UCn5K+OY3C+l4oC88xG1tSu3btTh+VDE3fZy5ay24m5XwarUv
         zhFMEhr/a04yVtQjzkSBygfHFUqwIjK1VQpwPOi7Gr/1bSANrP7eg2xsuyhXtnVt4lKH
         KeNw==
X-Gm-Message-State: AOAM530aHjAjbbcD5dHkTNHWuTGzITmHVaPy4eX6uC9GoVKeY7ntnHyX
        xwfB+06rU9yKGQqI3QAOXUTKrf38KMw=
X-Google-Smtp-Source: ABdhPJwAUbpx9898z/c3bcNmo8J7/Bb9tbLNLFVHZYbKmeSVjp0FNt0NFWljx70d7SUeEYeepDKqrQ==
X-Received: by 2002:a02:cf22:: with SMTP id s2mr1046814jar.29.1600711988793;
        Mon, 21 Sep 2020 11:13:08 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i6sm3903134ils.55.2020.09.21.11.13.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 11:13:08 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 08LID7E2003920;
        Mon, 21 Sep 2020 18:13:07 GMT
Subject: [PATCH v2 26/27] NFSD: Add tracepoints in the NFS dispatcher
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org, Bill.Baker@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 21 Sep 2020 14:13:07 -0400
Message-ID: <160071198717.1468.14262284967190973528.stgit@klimt.1015granger.net>
In-Reply-To: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
References: <160071167664.1468.1365570508917640511.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is follow-on work to the tracepoints added in the NFS server's
duplicate reply cache. Here, tracepoints are introduced that report
replies from cache as well as encoding and decoding errors.

The NFSv2, v3, and v4 dispatcher requirements have diverged over
time, leaving us with a little bit of technical debt. In addition,
I wanted to add a tracepoint for NFSv2 and NFSv3 similar to the
nfsd4_compound/compoundstatus tracepoints. Lastly, removing some
conditional branches from this hot path helps optimize CPU
utilization. So, I've duplicated the nfsd_dispatcher function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs2acl.c  |    2 -
 fs/nfsd/nfs3acl.c  |    2 -
 fs/nfsd/nfs4proc.c |    2 -
 fs/nfsd/nfsd.h     |    1 
 fs/nfsd/nfssvc.c   |  198 ++++++++++++++++++++++++++++++++++------------------
 fs/nfsd/trace.h    |   50 +++++++++++++
 6 files changed, 183 insertions(+), 72 deletions(-)

diff --git a/fs/nfsd/nfs2acl.c b/fs/nfsd/nfs2acl.c
index 54e597918822..894b8f0594e2 100644
--- a/fs/nfsd/nfs2acl.c
+++ b/fs/nfsd/nfs2acl.c
@@ -416,6 +416,6 @@ const struct svc_version nfsd_acl_version2 = {
 	.vs_nproc	= 5,
 	.vs_proc	= nfsd_acl_procedures2,
 	.vs_count	= nfsd_acl_count2,
-	.vs_dispatch	= nfsd_dispatch,
+	.vs_dispatch	= nfsd4_dispatch,
 	.vs_xdrsize	= NFS3_SVC_XDRSIZE,
 };
diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 7f512dec7460..924ebb19c59c 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -282,7 +282,7 @@ const struct svc_version nfsd_acl_version3 = {
 	.vs_nproc	= 3,
 	.vs_proc	= nfsd_acl_procedures3,
 	.vs_count	= nfsd_acl_count3,
-	.vs_dispatch	= nfsd_dispatch,
+	.vs_dispatch	= nfsd4_dispatch,
 	.vs_xdrsize	= NFS3_SVC_XDRSIZE,
 };
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 49109645af24..61302641f651 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3320,7 +3320,7 @@ const struct svc_version nfsd_version4 = {
 	.vs_nproc		= 2,
 	.vs_proc		= nfsd_procedures4,
 	.vs_count		= nfsd_count3,
-	.vs_dispatch		= nfsd_dispatch,
+	.vs_dispatch		= nfsd4_dispatch,
 	.vs_xdrsize		= NFS4_SVC_XDRSIZE,
 	.vs_rpcb_optnl		= true,
 	.vs_need_cong_ctrl	= true,
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index cb742e17e04a..7fa4b19dd2f7 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -78,6 +78,7 @@ extern const struct seq_operations nfs_exports_op;
  */
 int		nfsd_svc(int nrservs, struct net *net, const struct cred *cred);
 int		nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp);
+int		nfsd4_dispatch(struct svc_rqst *rqstp, __be32 *statp);
 
 int		nfsd_nrthreads(struct net *);
 int		nfsd_nrpools(struct net *);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index f7f6473578af..d626eea1c78a 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -28,6 +28,7 @@
 #include "vfs.h"
 #include "netns.h"
 #include "filecache.h"
+#include "trace.h"
 
 #define NFSDDBG_FACILITY	NFSDDBG_SVC
 
@@ -964,7 +965,7 @@ static __be32 map_new_errors(u32 vers, __be32 nfserr)
 {
 	if (nfserr == nfserr_jukebox && vers == 2)
 		return nfserr_dropit;
-	if (nfserr == nfserr_wrongsec && vers < 4)
+	if (nfserr == nfserr_wrongsec)
 		return nfserr_acces;
 	return nfserr;
 }
@@ -980,18 +981,6 @@ static __be32 map_new_errors(u32 vers, __be32 nfserr)
 static bool nfs_request_too_big(struct svc_rqst *rqstp,
 				const struct svc_procedure *proc)
 {
-	/*
-	 * The ACL code has more careful bounds-checking and is not
-	 * susceptible to this problem:
-	 */
-	if (rqstp->rq_prog != NFS_PROGRAM)
-		return false;
-	/*
-	 * Ditto NFSv4 (which can in theory have argument and reply both
-	 * more than a page):
-	 */
-	if (rqstp->rq_vers >= 4)
-		return false;
 	/* The reply will be small, we're OK: */
 	if (proc->pc_xdrressize > 0 &&
 	    proc->pc_xdrressize < XDR_QUADLEN(PAGE_SIZE))
@@ -1000,81 +989,152 @@ static bool nfs_request_too_big(struct svc_rqst *rqstp,
 	return rqstp->rq_arg.len > PAGE_SIZE;
 }
 
-int
-nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
+/**
+ * nfsd_dispatch - Process an NFSv2 or NFSv3 request
+ * @rqstp: incoming NFS request
+ * @statp: OUT: RPC accept_stat value
+ *
+ * Return values:
+ *  %0: Processing complete; do not send a Reply
+ *  %1: Processing complete; send a Reply
+ */
+int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 {
-	const struct svc_procedure *proc;
-	__be32			nfserr;
-	__be32			*nfserrp;
-
-	dprintk("nfsd_dispatch: vers %d proc %d\n",
-				rqstp->rq_vers, rqstp->rq_proc);
-	proc = rqstp->rq_procinfo;
-
-	if (nfs_request_too_big(rqstp, proc)) {
-		dprintk("nfsd: NFSv%d argument too large\n", rqstp->rq_vers);
-		*statp = rpc_garbage_args;
-		return 1;
+	const struct svc_procedure *proc = rqstp->rq_procinfo;
+	struct kvec *argv = &rqstp->rq_arg.head[0];
+	struct kvec *resv = &rqstp->rq_res.head[0];
+	__be32 nfserr, *nfserrp;
+
+	if (nfs_request_too_big(rqstp, proc))
+		goto out_too_large;
+
+	if (proc->pc_decode && !procp->pc_decode(rqstp, argv->iov_base))
+		goto out_decode_err;
+
+	rqstp->rq_cachetype = proc->pc_cachetype;
+	switch (nfsd_cache_lookup(rqstp)) {
+	case RC_DROPIT:
+		goto out_dropit;
+	case RC_REPLY:
+		goto out_cached_reply;
+	case RC_DOIT:
+		break;
 	}
-	rqstp->rq_lease_breaker = NULL;
+
+	nfserrp = resv->iov_base + resv->iov_len;
+	resv->iov_len += sizeof(__be32);
+	nfserr = proc->pc_func(rqstp);
+	nfserr = map_new_errors(rqstp->rq_vers, nfserr);
+	if (nfserr == nfserr_dropit || test_bit(RQ_DROPME, &rqstp->rq_flags))
+		goto out_update_drop;
+	if (rqstp->rq_proc)
+		*nfserrp++ = nfserr;
+
+	/* For NFSv2, additional info is never returned in case of an error. */
+	if (!(nfserr && rqstp->rq_vers == 2))
+		if (proc->pc_encode && !proc->pc_encode(rqstp, nfserrp))
+			goto out_encode_err;
+
+	nfsd_cache_update(rqstp, proc->pc_cachetype, statp + 1);
+	trace_nfsd_svc_status(rqstp, proc, nfserr);
+	return 1;
+
+out_too_large:
+	trace_nfsd_svc_too_large_err(rqstp);
+	*statp = rpc_garbage_args;
+	return 1;
+
+out_decode_err:
+	trace_nfsd_svc_decode_err(rqstp);
+	*statp = rpc_garbage_args;
+	return 1;
+
+out_update_drop:
+	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
+out_dropit:
+	trace_nfsd_svc_dropit(rqstp);
+	return 0;
+
+out_cached_reply:
+	trace_nfsd_svc_cached_reply(rqstp);
+	return 1;
+
+out_encode_err:
+	trace_nfsd_svc_encode_err(rqstp);
+	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
+	*statp = rpc_system_err;
+	return 1;
+}
+
+/**
+ * nfsd4_dispatch - Process an NFSv4 or NFSACL request
+ * @rqstp: incoming NFS request
+ * @statp: OUT: RPC accept_stat value
+ *
+ * Return values:
+ *  %0: Processing complete; do not send a Reply
+ *  %1: Processing complete; send a Reply
+ */
+int nfsd4_dispatch(struct svc_rqst *rqstp, __be32 *statp)
+{
+	const struct svc_procedure *proc = rqstp->rq_procinfo;
+	struct kvec *argv = &rqstp->rq_arg.head[0];
+	struct kvec *resv = &rqstp->rq_res.head[0];
+	__be32 nfserr, *nfserrp;
+
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
 	 * (necessary in the NFSv4.0 compound case)
 	 */
 	rqstp->rq_cachetype = proc->pc_cachetype;
-	/* Decode arguments */
-	if (proc->pc_decode &&
-	    !proc->pc_decode(rqstp, (__be32*)rqstp->rq_arg.head[0].iov_base)) {
-		dprintk("nfsd: failed to decode arguments!\n");
-		*statp = rpc_garbage_args;
-		return 1;
-	}
+	rqstp->rq_lease_breaker = NULL;
+
+	if (proc->pc_decode && !procp->pc_decode(rqstp, argv->iov_base))
+		goto out_decode_err;
 
-	/* Check whether we have this call in the cache. */
 	switch (nfsd_cache_lookup(rqstp)) {
 	case RC_DROPIT:
-		return 0;
+		goto out_dropit;
 	case RC_REPLY:
-		return 1;
-	case RC_DOIT:;
-		/* do it */
+		goto out_cached_reply;
+	case RC_DOIT:
+		break;
 	}
 
-	/* need to grab the location to store the status, as
-	 * nfsv4 does some encoding while processing 
-	 */
-	nfserrp = rqstp->rq_res.head[0].iov_base
-		+ rqstp->rq_res.head[0].iov_len;
-	rqstp->rq_res.head[0].iov_len += sizeof(__be32);
-
-	/* Now call the procedure handler, and encode NFS status. */
+	nfserrp = resv->iov_base + resv->iov_len;
+	resv->iov_len += sizeof(__be32);
 	nfserr = proc->pc_func(rqstp);
-	nfserr = map_new_errors(rqstp->rq_vers, nfserr);
-	if (nfserr == nfserr_dropit || test_bit(RQ_DROPME, &rqstp->rq_flags)) {
-		dprintk("nfsd: Dropping request; may be revisited later\n");
-		nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
-		return 0;
-	}
-
-	if (rqstp->rq_proc != 0)
+	if (test_bit(RQ_DROPME, &rqstp->rq_flags))
+		goto out_update_drop;
+	if (rqstp->rq_proc)
 		*nfserrp++ = nfserr;
 
-	/* Encode result.
-	 * For NFSv2, additional info is never returned in case of an error.
-	 */
-	if (!(nfserr && rqstp->rq_vers == 2)) {
-		if (proc->pc_encode && !proc->pc_encode(rqstp, nfserrp)) {
-			/* Failed to encode result. Release cache entry */
-			dprintk("nfsd: failed to encode result!\n");
-			nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
-			*statp = rpc_system_err;
-			return 1;
-		}
-	}
+	if (proc->pc_encode && !proc->pc_encode(rqstp, nfserrp))
+		goto out_encode_err;
 
-	/* Store reply in cache. */
 	nfsd_cache_update(rqstp, rqstp->rq_cachetype, statp + 1);
 	return 1;
+
+out_decode_err:
+	trace_nfsd_svc_decode_err(rqstp);
+	*statp = rpc_garbage_args;
+	return 1;
+
+out_update_drop:
+	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
+out_dropit:
+	trace_nfsd_svc_dropit(rqstp);
+	return 0;
+
+out_cached_reply:
+	trace_nfsd_svc_cached_reply(rqstp);
+	return 1;
+
+out_encode_err:
+	trace_nfsd_svc_encode_err(rqstp);
+	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
+	*statp = rpc_system_err;
+	return 1;
 }
 
 int nfsd_pool_stats_open(struct inode *inode, struct file *file)
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 53115fbc00b2..50ab4a84c25f 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -32,6 +32,56 @@
 		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
 		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
 
+DECLARE_EVENT_CLASS(nfsd_simple_class,
+	TP_PROTO(
+		const struct svc_rqst *rqstp
+	),
+	TP_ARGS(rqstp),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+	),
+	TP_printk("xid=0x%08x", __entry->xid)
+);
+
+#define DEFINE_NFSD_SIMPLE_EVENT(name)			\
+DEFINE_EVENT(nfsd_simple_class, nfsd_##name,		\
+	TP_PROTO(const struct svc_rqst *rqstp),		\
+	TP_ARGS(rqstp))
+
+DEFINE_NFSD_SIMPLE_EVENT(svc_too_large_err);
+DEFINE_NFSD_SIMPLE_EVENT(svc_decode_err);
+DEFINE_NFSD_SIMPLE_EVENT(svc_dropit);
+DEFINE_NFSD_SIMPLE_EVENT(svc_cached_reply);
+DEFINE_NFSD_SIMPLE_EVENT(svc_encode_err);
+
+TRACE_EVENT(nfsd_svc_status,
+	TP_PROTO(
+		const struct svc_rqst *rqstp,
+		const struct svc_procedure *proc,
+		__be32 status
+	),
+	TP_ARGS(rqstp, proc, status),
+	TP_STRUCT__entry(
+		__field(u32, xid)
+		__field(u32, version)
+		__field(unsigned long, status)
+		__string(procedure, rqstp->rq_procinfo->pc_name)
+	),
+	TP_fast_assign(
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+		__entry->version = rqstp->rq_vers;
+		__entry->status = be32_to_cpu(status);
+		__assign_str(procedure, rqstp->rq_procinfo->pc_name);
+	),
+	TP_printk("xid=0x%08x version=%u procedure=%s status=%s",
+		__entry->xid, __entry->version, __get_str(procedure),
+		show_nfs_status(__entry->status)
+	)
+);
+
 TRACE_EVENT(nfsd_access,
 	TP_PROTO(
 		const struct svc_rqst *rqstp,


