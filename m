Return-Path: <linux-nfs+bounces-1473-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E8E83DDAD
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 16:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0A232854CA
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 15:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B571CFBE;
	Fri, 26 Jan 2024 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="DQUt5ix7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D31D1CFA9
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283634; cv=none; b=irsuJft5D13wAUgKBtP/FKlDvAmEi8v9hSevrnvRCkw6b5GpO6T7pfg7YALn7UOazHmwBnDesyqJbMgYmQs4XM+ehy99A4uSBlZxPQf0Vn3r8nvPC1CtjdCpjQghLQJRvRHSQQ2qOxrNcqWjv4T+Zot23vSjv3553ptfx7n/i4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283634; c=relaxed/simple;
	bh=gj6BN5Ryi90FiGCGRLD4HyYT25snhN7XpbObeUR/VfU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asxaqwCP6CkPP00cCp7IPuv7fWzjcByFwYa+RvXzYg6w9/N5J4rJs4bJUmkE57KMMeq7iHf5zngJpT41Ox5KZRmM210Zw263M6kFlT14Rz+6UJ1FrnT2hiz75sP8UMi42To6vg6dW4z9zWtUoEdQeZeU4Ik1Oc2ttVwxhidov00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=DQUt5ix7; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ff7dc53ce0so3891367b3.1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 07:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1706283630; x=1706888430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDFJ4ofz5JnRdgl61rMW+8vTooiJNkqwX2WXWFw/o7A=;
        b=DQUt5ix7WCx07vMPsRGrGBAu1fe+RZb6X5T4FS2AJXRiYnyASob1ykax1hekCEEZXx
         eZnlgaVL+ep8LKVqv2L8wKilqKJaO0DCb+CClloOqvWiHLbofQlTR0AkS3ZStq6xVUpe
         q88W+6HvZH8IAsI0eAiDlWki5k74opMH55YYfbwrC8WejHEsWhACSwlGlIySbkAzOniI
         MkB0CYoyxZPA2Ab9jrb6i5JhPNcwVv0mqyo6ITjbSKR/EZS5pSO2YU8Q4uqFsYkaH+EF
         yIx+YmcXHfaCsb4+8QJH9RfWP7lUhVackzwrx8SQ4QNbS+z6jje2jPAdt+JHpI4FchMa
         FGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706283630; x=1706888430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDFJ4ofz5JnRdgl61rMW+8vTooiJNkqwX2WXWFw/o7A=;
        b=sHpuzy5Gu4h1Hc9FKyCexHMoCMoa3k4ai8PbS7T9qOzbj5S7PfvbiHtJVZl6IKA/RY
         VUAgd9j/QbqmH5R4cCQNt3AWZ5QPy3DO7SD6+2TwJaoOtTiX9Bl46VF6Z0ovUVvCWxzp
         W1Gjodknx0ljdyVEpjdUcQn8jZGcNZNABwht1LYVy4DEca/58m20jtqPV03Hp+a9qyo7
         /b+U0KV5HL+s5DgRT+tBjMGWU8K2rek6Js0n43HFYgDZAVMKgVWpstU4KiWx9Qry9MyG
         U2+OQAtD+UAICJ8n1IHiAAGz8EUW0ScDvBgffwx8MGPdO/A2SFB/diDGbRLQ+geV8Wx2
         MEAQ==
X-Gm-Message-State: AOJu0YwaZsH3IX/94OSiEjo21k40Y/zUXDProfHSBeg5qFkO+iewC3Gy
	iEzJExaPSRzOKW7Vxoltk61Un9kX8upUAaeS7BPlmMk9QoZvtNDSQu4e9plYOAM=
X-Google-Smtp-Source: AGHT+IFRYjtMG6YZIDONmyRsiSQ1ncogzoR7jMfPkHa2xC9dBqUIwkr5vUhihjqSgTHzZT8TZr02kA==
X-Received: by 2002:a0d:d40c:0:b0:600:228e:15cf with SMTP id w12-20020a0dd40c000000b00600228e15cfmr1168936ywd.92.1706283629946;
        Fri, 26 Jan 2024 07:40:29 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q206-20020a815cd7000000b005ff846d1f1dsm450775ywb.134.2024.01.26.07.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 07:40:27 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 01/10] sunrpc: don't change ->sv_stats if it doesn't exist
Date: Fri, 26 Jan 2024 10:39:40 -0500
Message-ID: <eebbdad4c1f6b6bd22ef58f578a605a84f98729e.1706283433.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706283433.git.josef@toxicpanda.com>
References: <cover.1706283433.git.josef@toxicpanda.com>
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


