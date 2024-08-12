Return-Path: <linux-nfs+bounces-5329-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F7B94F99F
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Aug 2024 00:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0FE71F22C43
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 22:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6315D197A8E;
	Mon, 12 Aug 2024 22:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH25Bjjg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388D4197552;
	Mon, 12 Aug 2024 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502202; cv=none; b=WqoWvljOIOM5RuFoe9x4rAsXqX9tll7cftBPvTmsAM7Gwm1Oo1Wo3K7AtTluvXC75Ag8JTdE/U+TQtSEgpE9VVdwcOkGGK/Ev77+K9ZK7nT7dDg28nVF/3l5vS1R2c5x3vmhqt3z1iqxXqAtFM/2kYS5y2lzBB5DzyvN7bFmoZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502202; c=relaxed/simple;
	bh=1Bh5CbbMX7hZ1zl701mxKKQB40Taa/z12S5WCsGZMRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qqDajBLNpZxjSMZ79DZsuidrZ2R5iQgWHKLcSZSUXGhgNUwmeKp7JPh1mXIQgAMD73HsDO7CiZ2dqox0IBuPm08TpB+pIFVAunPgQbPR/wleyDtmzWGdMLg4MqAgDW1asUGJICrpB0LqeuD9zskUo9ChPPZGU94fE9JrN6jjC0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH25Bjjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8DDC4AF0D;
	Mon, 12 Aug 2024 22:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723502201;
	bh=1Bh5CbbMX7hZ1zl701mxKKQB40Taa/z12S5WCsGZMRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XH25BjjgYxsn7DK744zC2XHon1rNugIPURNla6VcvG3VH7QBW/zX9kRne2SDd8Dds
	 dRUI2VLIHVCuPf8khJmSncll4UKNadgvlQkYctF4pWjInttqmwZQecN5Z7qZrVkGWT
	 DmxXo7NkA7FFH1TKL2O2jvgeVEpIiuDpgMcY4FaR0EUKpxUWcuRt/XVUx9I5Ppnj6h
	 TXJ4yp0OLM9rU9sr0C9tSQ/KyhPFXHtcwr4TbbQcTMr/aQa+VUAVVTNd7Dd745hxcR
	 2VIWmE4kP1Y7LJ5LPBBLvKuBPikICmOXPKNPr6WK+2rjhOpjcAUjIc9/rlCuuuSzHn
	 eoLFAPGFFY4QA==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	pvorel@suse.cz,
	sherry.yang@oracle.com,
	calum.mackay@oracle.com,
	kernel-team@fb.com,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.6.y 03/12] sunrpc: don't change ->sv_stats if it doesn't exist
Date: Mon, 12 Aug 2024 18:35:55 -0400
Message-ID: <20240812223604.32592-4-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240812223604.32592-1-cel@kernel.org>
References: <20240812223604.32592-1-cel@kernel.org>
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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 691499d1d231..03a51c5ec822 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1377,7 +1377,8 @@ svc_process_common(struct svc_rqst *rqstp)
 		goto err_bad_proc;
 
 	/* Syntactic check complete */
-	serv->sv_stats->rpccnt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpccnt++;
 	trace_svc_process(rqstp, progp->pg_name);
 
 	aoffset = xdr_stream_pos(xdr);
@@ -1429,7 +1430,8 @@ svc_process_common(struct svc_rqst *rqstp)
 	goto close_xprt;
 
 err_bad_rpc:
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	xdr_stream_encode_u32(xdr, RPC_MSG_DENIED);
 	xdr_stream_encode_u32(xdr, RPC_MISMATCH);
 	/* Only RPCv2 supported */
@@ -1440,7 +1442,8 @@ svc_process_common(struct svc_rqst *rqstp)
 err_bad_auth:
 	dprintk("svc: authentication failed (%d)\n",
 		be32_to_cpu(rqstp->rq_auth_stat));
-	serv->sv_stats->rpcbadauth++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadauth++;
 	/* Restore write pointer to location of reply status: */
 	xdr_truncate_encode(xdr, XDR_UNIT * 2);
 	xdr_stream_encode_u32(xdr, RPC_MSG_DENIED);
@@ -1450,7 +1453,8 @@ svc_process_common(struct svc_rqst *rqstp)
 
 err_bad_prog:
 	dprintk("svc: unknown program %d\n", rqstp->rq_prog);
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	*rqstp->rq_accept_statp = rpc_prog_unavail;
 	goto sendit;
 
@@ -1458,7 +1462,8 @@ svc_process_common(struct svc_rqst *rqstp)
 	svc_printk(rqstp, "unknown version (%d for prog %d, %s)\n",
 		       rqstp->rq_vers, rqstp->rq_prog, progp->pg_name);
 
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	*rqstp->rq_accept_statp = rpc_prog_mismatch;
 
 	/*
@@ -1472,19 +1477,22 @@ svc_process_common(struct svc_rqst *rqstp)
 err_bad_proc:
 	svc_printk(rqstp, "unknown procedure (%d)\n", rqstp->rq_proc);
 
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	*rqstp->rq_accept_statp = rpc_proc_unavail;
 	goto sendit;
 
 err_garbage_args:
 	svc_printk(rqstp, "failed to decode RPC header\n");
 
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	*rqstp->rq_accept_statp = rpc_garbage_args;
 	goto sendit;
 
 err_system_err:
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	*rqstp->rq_accept_statp = rpc_system_err;
 	goto sendit;
 }
@@ -1536,7 +1544,8 @@ void svc_process(struct svc_rqst *rqstp)
 out_baddir:
 	svc_printk(rqstp, "bad direction 0x%08x, dropping request\n",
 		   be32_to_cpu(*p));
-	rqstp->rq_server->sv_stats->rpcbadfmt++;
+	if (rqstp->rq_server->sv_stats)
+		rqstp->rq_server->sv_stats->rpcbadfmt++;
 out_drop:
 	svc_drop(rqstp);
 }
-- 
2.45.1


