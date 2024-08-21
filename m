Return-Path: <linux-nfs+bounces-5511-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 487A395A0A0
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 16:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B7C1C22916
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A31B1D66;
	Wed, 21 Aug 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lg2On6sv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CE0364D6;
	Wed, 21 Aug 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252202; cv=none; b=WxnQrMp1pPVx5Kbf5/f6YnkaFTwRqV41jffjfuVpyfQGXXmiJaNpX2TulkxT0EZuTU8LSIeAUqbHtNPupuX2epHqCMQYQczkWYDDbUDQt4ehyhCY5JnlEa9MGW7A63yv2sU7pS5p/9zS142fKatX4LlBGzgTdaD379AyrdsOJvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252202; c=relaxed/simple;
	bh=pMxN9cSimTL+NxY1GGRZpDHAxD9P+95gaD0N9lvhVq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSX33XRqrMhZaOn6wO/m33unh2Dquka98dwy5azIVZtoAb0awnFkluhfMsHmCkzfLlPJacG0go71jHpRhuG6aM6P/nspH+RFB94+UTjuYhgIX7VnfNtIHXE9tAIa9EQZA73yBaPdDnub9WGt9xXw/DfVJYvUeg0PswdoDty7L9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lg2On6sv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BFC9C32781;
	Wed, 21 Aug 2024 14:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724252202;
	bh=pMxN9cSimTL+NxY1GGRZpDHAxD9P+95gaD0N9lvhVq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lg2On6sv4rfDsUqkIOlIVbwThWqk+q7p20QUQc1UZ794C6I0B9clBBZms8lT5ulcI
	 IFWQ/7FD1algYKwhqJw0GgQ3WDORZCShOBFFZ1RnTw6WWnajylJQMKCZLBpD3FugcN
	 7VRmkcnlN2wHnS/1BoTq3LQrFoUTNquH0RKyylWFWWY/fiu81qnHW0z0jeSl47KAXX
	 mQpUvFN04405rdVaaQqV8cUW95BJ8YURePEXl2pwEUdfW+iV+oeEKphkhyb0+lAtn0
	 H79/YSdFwtMynzY1dKPnrH3QDeNp/U8MxC71Fypwc1jWl00L+Ie07TmSL6IiknTseS
	 cN9uYywHxtI9Q==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 5.15.y 09/18] sunrpc: don't change ->sv_stats if it doesn't exist
Date: Wed, 21 Aug 2024 10:55:39 -0400
Message-ID: <20240821145548.25700-10-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821145548.25700-1-cel@kernel.org>
References: <20240821145548.25700-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit ab42f4d9a26f1723dcfd6c93fcf768032b2bb5e7 ]

We check for the existence of ->sv_stats elsewhere except in the core
processing code.  It appears that only nfsd actual exports these values
anywhere, everybody else just has a write only copy of sv_stats in their
svc_program.  Add a check for ->sv_stats before every adjustment to
allow us to eliminate the stats struct from all the users who don't
report the stats.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
[ cel: adjusted to apply to v5.15.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 8d5897ed2816..447f515d445b 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1357,7 +1357,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 		goto err_bad_proc;
 
 	/* Syntactic check complete */
-	serv->sv_stats->rpccnt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpccnt++;
 	trace_svc_process(rqstp, progp->pg_name);
 
 	/* Build the reply header. */
@@ -1423,7 +1424,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	goto close_xprt;
 
 err_bad_rpc:
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, 1);	/* REJECT */
 	svc_putnl(resv, 0);	/* RPC_MISMATCH */
 	svc_putnl(resv, 2);	/* Only RPCv2 supported */
@@ -1436,7 +1438,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 err_bad_auth:
 	dprintk("svc: authentication failed (%d)\n",
 		be32_to_cpu(rqstp->rq_auth_stat));
-	serv->sv_stats->rpcbadauth++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadauth++;
 	/* Restore write pointer to location of accept status: */
 	xdr_ressize_check(rqstp, reply_statp);
 	svc_putnl(resv, 1);	/* REJECT */
@@ -1446,7 +1449,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 
 err_bad_prog:
 	dprintk("svc: unknown program %d\n", prog);
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, RPC_PROG_UNAVAIL);
 	goto sendit;
 
@@ -1454,7 +1458,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	svc_printk(rqstp, "unknown version (%d for prog %d, %s)\n",
 		       rqstp->rq_vers, rqstp->rq_prog, progp->pg_name);
 
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, RPC_PROG_MISMATCH);
 	svc_putnl(resv, process.mismatch.lovers);
 	svc_putnl(resv, process.mismatch.hivers);
@@ -1463,7 +1468,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 err_bad_proc:
 	svc_printk(rqstp, "unknown procedure (%d)\n", rqstp->rq_proc);
 
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, RPC_PROC_UNAVAIL);
 	goto sendit;
 
@@ -1472,7 +1478,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 
 	rpc_stat = rpc_garbage_args;
 err_bad:
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, ntohl(rpc_stat));
 	goto sendit;
 }
@@ -1513,7 +1520,8 @@ svc_process(struct svc_rqst *rqstp)
 	if (dir != 0) {
 		/* direction != CALL */
 		svc_printk(rqstp, "bad direction %d, dropping request\n", dir);
-		serv->sv_stats->rpcbadfmt++;
+		if (serv->sv_stats)
+			serv->sv_stats->rpcbadfmt++;
 		goto out_drop;
 	}
 
-- 
2.45.2


