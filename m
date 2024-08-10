Return-Path: <linux-nfs+bounces-5289-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010E194DE64
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 22:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8366282C6E
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Aug 2024 20:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD9E13D285;
	Sat, 10 Aug 2024 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q05OG1EV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C9C200A3;
	Sat, 10 Aug 2024 20:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723320065; cv=none; b=oeVXLFgCU/tRZor/Bb5HwHm5/owb7AbbUhkvpWJIYG9CNGHE8PJSsSCFEI4NbrrwXYj30bGyQItMsWKBdZsqrBnKkolig6daWUYaz9RMW2wfs9KQZ7/lnEp4Zu0eHxkhJsYIw+h0nNxoiziaQJwLBfo0W3miAzEqrBq3NIHNdrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723320065; c=relaxed/simple;
	bh=xs7HnfZCCB9Ip02K6Gku4N1JNJWSTiK3XxKuz+ndHcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKshCL8IfAW3Gm11mHlG8UdCXkx4BTJtMGeIuMNP/om5SlKD6WKFNhq1YJcP6RgBtprEwTb/sJMCGVV/yqLbzmtdchpKaz+m6vKX7PDAl3qm4M9u6oiyq3rZAGE3ANwMQSBuBE2BVpoMhZDnRnd4hvdp7m8XvzwbEbxTxu3E8VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q05OG1EV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EA2C4AF0D;
	Sat, 10 Aug 2024 20:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723320065;
	bh=xs7HnfZCCB9Ip02K6Gku4N1JNJWSTiK3XxKuz+ndHcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q05OG1EVv4b/8XKiCVxlnJPtVYtdUR/chucv67yfbCd6JymCoWnpMfbR7Gy2RkZBE
	 PplKjdZmu4h6K5eicWFnuOwehGxGnvFumhQGWxIEVFwRQTHAEG778MJvAhFBRQcmvI
	 /JB5ld3dw9xvd1nYCoHtpjbyjxS5ygZdTLC8rvadkloLaf45XjJtbyk0GLw8HjC/tN
	 FKjJBnmrjN4p0/cmKhZ4n8BViUxAzCm04ItFF/5rRwAtjh6FY7FG2w/ZcB98IZSeaj
	 X/ddyFfaj35gbQS7tdDC6DW15qJWSIInogYNepfke+YOpUlon1Zt0zhwMOKJzW4KpY
	 Z5DCO+ejlTDYQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	ltp@lists.linux.it,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.1.y 09/18] sunrpc: don't change ->sv_stats if it doesn't exist
Date: Sat, 10 Aug 2024 16:00:00 -0400
Message-ID: <20240810200009.9882-10-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
References: <20240810200009.9882-1-cel@kernel.org>
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
[ cel: adjusted to apply to v6.1.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 666d738bcf07..35c0651cc002 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1324,7 +1324,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 		goto err_bad_proc;
 
 	/* Syntactic check complete */
-	serv->sv_stats->rpccnt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpccnt++;
 	trace_svc_process(rqstp, progp->pg_name);
 
 	/* Build the reply header. */
@@ -1377,7 +1378,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	goto close_xprt;
 
 err_bad_rpc:
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, 1);	/* REJECT */
 	svc_putnl(resv, 0);	/* RPC_MISMATCH */
 	svc_putnl(resv, 2);	/* Only RPCv2 supported */
@@ -1387,7 +1389,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 err_bad_auth:
 	dprintk("svc: authentication failed (%d)\n",
 		be32_to_cpu(rqstp->rq_auth_stat));
-	serv->sv_stats->rpcbadauth++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadauth++;
 	/* Restore write pointer to location of accept status: */
 	xdr_ressize_check(rqstp, reply_statp);
 	svc_putnl(resv, 1);	/* REJECT */
@@ -1397,7 +1400,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 
 err_bad_prog:
 	dprintk("svc: unknown program %d\n", prog);
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, RPC_PROG_UNAVAIL);
 	goto sendit;
 
@@ -1405,7 +1409,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	svc_printk(rqstp, "unknown version (%d for prog %d, %s)\n",
 		       rqstp->rq_vers, rqstp->rq_prog, progp->pg_name);
 
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, RPC_PROG_MISMATCH);
 	svc_putnl(resv, process.mismatch.lovers);
 	svc_putnl(resv, process.mismatch.hivers);
@@ -1414,7 +1419,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 err_bad_proc:
 	svc_printk(rqstp, "unknown procedure (%d)\n", rqstp->rq_proc);
 
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, RPC_PROC_UNAVAIL);
 	goto sendit;
 
@@ -1423,7 +1429,8 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 
 	rpc_stat = rpc_garbage_args;
 err_bad:
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, ntohl(rpc_stat));
 	goto sendit;
 }
@@ -1469,7 +1476,8 @@ svc_process(struct svc_rqst *rqstp)
 out_baddir:
 	svc_printk(rqstp, "bad direction 0x%08x, dropping request\n",
 		   be32_to_cpu(dir));
-	rqstp->rq_server->sv_stats->rpcbadfmt++;
+	if (rqstp->rq_server->sv_stats)
+		rqstp->rq_server->sv_stats->rpcbadfmt++;
 out_drop:
 	svc_drop(rqstp);
 	return 0;
-- 
2.45.1


