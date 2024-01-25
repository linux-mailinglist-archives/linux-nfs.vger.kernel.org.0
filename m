Return-Path: <linux-nfs+bounces-1412-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C320283CCE1
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 20:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7323C28E5BE
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9108135A45;
	Thu, 25 Jan 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="vhuoelGH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6B91339B2
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212421; cv=none; b=teEKLMmLC61UtW43h2e0vxmRHbMzlPVSY6TUcbK3YnL+8N6lLjUG7i/N08cS6vm3cZ8DdQx4Myd30r+CSazr6Q0PrtMH3qIIHLp1HM/My6ujYLDmYbO1ZrV4BpJxL92gaZl3hzaZlMVJmUWHc6SoCmv5i4IVM+nLZpaLC67CiXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212421; c=relaxed/simple;
	bh=gj6BN5Ryi90FiGCGRLD4HyYT25snhN7XpbObeUR/VfU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLKoHZFTCWN+Mx2mDvUBRAFczQj71ZqOhrQtB/XwJUkpZCSFyHrvGM3hp5RPiAogKRB+myx3wHTNTNZPVqLWey0BdgehoZ2VqXTnrM0HSswbxNi8MOvNH4qeqBC/DNjkpktjM0mA7qka/r8c24AC6LCo3ml6HBv7QDnbtMylr+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=vhuoelGH; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc372245aefso3290197276.2
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 11:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706212419; x=1706817219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDFJ4ofz5JnRdgl61rMW+8vTooiJNkqwX2WXWFw/o7A=;
        b=vhuoelGHCuW93gZFYbpLy7Q56DDz7aTwoGFGDbvSmttEmkGTrGkVFJco5NEvtXIRfQ
         U/FASuM3Z/x1Dj9HT7lRzPRmbwWVgRzUY3GzaL8bbg8FEAXOaAzCQNhv49hcrnYKGDLg
         TSfJZ1TGYufnyFPLPylqOF4tS9bYyqqcGk4sZH3QtFoW4mqCmPv/XuYsWjS7fQD4XBaU
         bCtMsDHGhdtaHd8Dck6u1BuHw3sMAd5pIak2lD+6F/QfDUXmZF3GWf5cxnvVQ4aGMfUa
         +dfaXVS9Trnx4+WdnSkUe/TOhW3Lgeq50zf8fSfCQix1uOkX96WR/fcXcwD/0LR1MqHv
         4vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212419; x=1706817219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDFJ4ofz5JnRdgl61rMW+8vTooiJNkqwX2WXWFw/o7A=;
        b=jVJiAsZ4hUFlAlQ2kcGFdXZ6hFNHBf1rwDPaCUK0vPN2BVYZjGPQnpFtnmnKNF79iF
         U0NgzMSGHCuONYxVKxySXSwKXvltKXZ0ZHSyBRlij2tPW5IErmT0TGLv1RfwxdfrS1Il
         Emtmv4YTj7lydXnLVNDxpMShUNFwt4LmlQDuIhiKcWHOB+8h9abNijXbnEKxLZ+XQHOJ
         /glxjhHdVojtv/5pt7qcSyi6bAyjJMxPdk4IvtQ8fANf5AiEd8v60FyYhQHzMxW8E46r
         bXtIYJTSyURmM1d9bGoIaTlZG+ec/XEIWYk0rFlrRun/JaDN1x3jZAS6QsnXB1k/YsAU
         8qNQ==
X-Gm-Message-State: AOJu0YzpDIbwKcAKaQIu4klpwlNkwHqkS8/yH47pl9sFupyOoP9Jd2FQ
	+gAPFWWfuZjq8kTckRVTUoa++gNoXpKyFlAAI7OyLoJ1LLN80ITm60yOJcL6drcdHRUSTXEJjXj
	M
X-Google-Smtp-Source: AGHT+IESBSFidcjHUAc5SVVVilyydQld9Spj3Na0lIVbxNua5M1RWIhAjyTDLCHaHEAkeufXHgaDow==
X-Received: by 2002:a25:bcce:0:b0:dc2:3ec3:95d4 with SMTP id l14-20020a25bcce000000b00dc23ec395d4mr306069ybm.47.1706212417486;
        Thu, 25 Jan 2024 11:53:37 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s65-20020a25c244000000b00dc2310abe8bsm3692949ybf.38.2024.01.25.11.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:53:37 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-nfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 01/13] sunrpc: don't change ->sv_stats if it doesn't exist
Date: Thu, 25 Jan 2024 14:53:11 -0500
Message-ID: <eebbdad4c1f6b6bd22ef58f578a605a84f98729e.1706212207.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706212207.git.josef@toxicpanda.com>
References: <cover.1706212207.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We check for the existence of ->sv_stats elsewhere except in the core
processing code.  It appears that only nfsd actual exports these values
anywhere, everybody else just has a write only copy of sv_stats in their
svc_program.  Add a check for ->sv_stats before every adjustment to
allow us to eliminate the stats struct from all the users who don't
report the stats.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/sunrpc/svc.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f60c93e5a25d..d2e6f3d59218 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1375,7 +1375,8 @@ svc_process_common(struct svc_rqst *rqstp)
 		goto err_bad_proc;
 
 	/* Syntactic check complete */
-	serv->sv_stats->rpccnt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpccnt++;
 	trace_svc_process(rqstp, progp->pg_name);
 
 	aoffset = xdr_stream_pos(xdr);
@@ -1427,7 +1428,8 @@ svc_process_common(struct svc_rqst *rqstp)
 	goto close_xprt;
 
 err_bad_rpc:
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	xdr_stream_encode_u32(xdr, RPC_MSG_DENIED);
 	xdr_stream_encode_u32(xdr, RPC_MISMATCH);
 	/* Only RPCv2 supported */
@@ -1438,7 +1440,8 @@ svc_process_common(struct svc_rqst *rqstp)
 err_bad_auth:
 	dprintk("svc: authentication failed (%d)\n",
 		be32_to_cpu(rqstp->rq_auth_stat));
-	serv->sv_stats->rpcbadauth++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadauth++;
 	/* Restore write pointer to location of reply status: */
 	xdr_truncate_encode(xdr, XDR_UNIT * 2);
 	xdr_stream_encode_u32(xdr, RPC_MSG_DENIED);
@@ -1448,7 +1451,8 @@ svc_process_common(struct svc_rqst *rqstp)
 
 err_bad_prog:
 	dprintk("svc: unknown program %d\n", rqstp->rq_prog);
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	*rqstp->rq_accept_statp = rpc_prog_unavail;
 	goto sendit;
 
@@ -1456,7 +1460,8 @@ svc_process_common(struct svc_rqst *rqstp)
 	svc_printk(rqstp, "unknown version (%d for prog %d, %s)\n",
 		       rqstp->rq_vers, rqstp->rq_prog, progp->pg_name);
 
-	serv->sv_stats->rpcbadfmt++;
+	if (serv->sv_stats)
+		serv->sv_stats->rpcbadfmt++;
 	*rqstp->rq_accept_statp = rpc_prog_mismatch;
 
 	/*
@@ -1470,19 +1475,22 @@ svc_process_common(struct svc_rqst *rqstp)
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
@@ -1534,7 +1542,8 @@ void svc_process(struct svc_rqst *rqstp)
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
2.43.0


