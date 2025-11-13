Return-Path: <linux-nfs+bounces-16352-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1548CC59146
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 18:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FFF4A07FB
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 16:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D2B33B96C;
	Thu, 13 Nov 2025 16:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUzo9MvK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF5328604
	for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052468; cv=none; b=PoAIRvJxoXQJ1q/MgH0ssOzDG7hK31UWQb95n0flgoseKmlqbL8b2RyYygpYwScNregeO2/kiJT+URrlDGTLkGiA+FyQ3J/2mIUUiHuQb05c+vLEqVEoh3EWWkLbXInJlKOxRKwhGWRQhulXI1fzrMgVydmiSfFJ8/MQo+GAARg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052468; c=relaxed/simple;
	bh=wxr3oyHuw4JBJD6eiR+G0Wyqv+Sl/Us4AF7aWNcwdh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pgbjWVSjnA757MfZ2afkLRotHQ6RXoIPaeCzvYuQYl/JKN3Pi2IfI88OCTupLDf53ywUMDcfp5bCTKwXDxCHtilOwvZe0DKFIWs5XxN40rIGL/jtW5sN1b2QFW4SjrVcUqi0KSKqNEUlVbCJiHWEnvxkgkubRsnt7CMuA6x6Lgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUzo9MvK; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-656b7f02b56so464127eaf.0
        for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 08:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763052466; x=1763657266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xtb1Tg4f0J+buM9U/6muLv9lSlDdspLzgrMc4VoD+Hg=;
        b=IUzo9MvKPRGPRheJBDerm9SQyRov59M6kF16s+n3bcfO+6oW+OFTmrvaCnzJMklK1u
         WJcYKugoUFegGkfItRwhvlhGi9saJ5EzjbHfddLkVdasnKDEl2AdlIfylmKLRiEsfswh
         8FunGBzCCKXFkfzyG1nrseXNzc7JQQeMoYNtsdf9eAbzhvp2krXrENcbKenq/FZmHHE/
         uy9O1Ehy4G96XNJY1SSeconBBf+cr7L949/KxsN9Av6u7l7pflvipP2ZbrWQzx1XIwXs
         2SGHNiB5cvJCmeOOBoqsLKSw6YrbDp1CzkzTwSMLOmS91vJI94ylzo3JTFCHbq6UbIqc
         E2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052466; x=1763657266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xtb1Tg4f0J+buM9U/6muLv9lSlDdspLzgrMc4VoD+Hg=;
        b=ZscHOcKoACUMLqBDrVT9wri8qYckYHanKLjJCL7BkL3jFsP7HwCVCe8kk+YPGfUUMj
         lh5QsKhw4LHZiqbyg3dYzuRM+t+mnXcw9HI/bQ6L8gGzI1DxwCcRtN7YBAqwGTh+gWCL
         57gij5WlB+Jjb4RHBDazG7ZL1iB8aKwo3OeL/OZKvY2Ae2LZbxtAQiQrUjEU5hKZr/Gt
         Yw3YX1llsnMXjcmeCf1juZWZr0Q+0NwLkloMHCQKRCwAJSpLTQ1pFTUEge3X6dpYDriY
         7V6JuZocgWr2KhCQyMygYpT6bflbKRoieJ98Z+/F1D5xAwAzc8Zv4WTO9ZG/FJag5gQi
         xSbA==
X-Gm-Message-State: AOJu0YwAty68QwwtXZKl7fQZTZsdpImTeyRrZmOdc1jvsVO2HqcQIiDm
	XVKudURyisLTrxwaLMit0iDJiDJWgKlttNyvRPDoOGptm1POPC4+A9sp
X-Gm-Gg: ASbGnct868GrmvEQEhmlWgdhah4gGbJxiueWkZ9HWgCYCKEwWhTz7R7Rvhgbufz/EEy
	BgBGuCFL7YPWrZzfSm+DmNGbn1vwwLQ4YyB14nYpU6un0YBXKFuIw8kgoFPMxASusa5MVmYf4uA
	8veLfeAXI35y47WLAnYwtE9za9MTXhj2m0pR/ZtHhaJHZRCiXvBtjanpSiDmI4J/YBiqOEOGSpx
	aajgolDGLmZfiNMqTBxQx3Weaf1GWPRhDyFIMqOjZHUlTgJoTauaaHl9yc5//dqXWIbi3CTcbCW
	4J9jYhjJInwhl2VDa5TTF+E04lK3o310rCSFjIDHK+E2WBd+SIlePOtfc4wmETtBteRPlpt2E9w
	jxipxGVe/4ZK6eD6PA3D6dhFrp+c84Z3JCCQnjx1adCAatGKtPD3IOpgpwZIXeb9gWa0NuJYGW3
	EVC0BcNc+TLmTeh6KgNGg=
X-Google-Smtp-Source: AGHT+IGFCNQet+BuHm7TrA8WU2G72HMPRvd91sqbtpEJ9RSuQNUwN8KOf9V9uynfETNdHuQJogNZYQ==
X-Received: by 2002:a05:6820:6487:b0:654:f200:1490 with SMTP id 006d021491bc7-65723304154mr1333715eaf.1.1763052466156;
        Thu, 13 Nov 2025 08:47:46 -0800 (PST)
Received: from localhost.localdomain ([192.146.154.240])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65724cfa261sm1227228eaf.5.2025.11.13.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:47:45 -0800 (PST)
From: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
To: chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
Subject: [PATCH] Make RPCRDMA_MAX_RECV_BATCH configurable.
Date: Thu, 13 Nov 2025 11:46:48 -0500
Message-ID: <20251113164648.20774-1-gaurav.gangalwar@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bumped up rpcrdma_max_recv_batch to 64.
Added param to change to it, it becomes handy to use higher value
to avoid hung.

Signed-off-by: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c           | 2 +-
 net/sunrpc/xprtrdma/module.c             | 6 ++++++
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 2 +-
 net/sunrpc/xprtrdma/verbs.c              | 2 +-
 net/sunrpc/xprtrdma/xprt_rdma.h          | 4 +---
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 31434aeb8e29..863a0c567915 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -246,7 +246,7 @@ int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
 	ep->re_attr.cap.max_send_wr += 1; /* for ib_drain_sq */
 	ep->re_attr.cap.max_recv_wr = ep->re_max_requests;
 	ep->re_attr.cap.max_recv_wr += RPCRDMA_BACKWARD_WRS;
-	ep->re_attr.cap.max_recv_wr += RPCRDMA_MAX_RECV_BATCH;
+	ep->re_attr.cap.max_recv_wr += rpcrdma_max_recv_batch;
 	ep->re_attr.cap.max_recv_wr += 1; /* for ib_drain_rq */
 
 	ep->re_max_rdma_segs =
diff --git a/net/sunrpc/xprtrdma/module.c b/net/sunrpc/xprtrdma/module.c
index 697f571d4c01..afeec5a68151 100644
--- a/net/sunrpc/xprtrdma/module.c
+++ b/net/sunrpc/xprtrdma/module.c
@@ -27,6 +27,12 @@ MODULE_ALIAS("svcrdma");
 MODULE_ALIAS("xprtrdma");
 MODULE_ALIAS("rpcrdma6");
 
+unsigned int rpcrdma_max_recv_batch = 64;
+module_param_named(max_recv_batch, rpcrdma_max_recv_batch, uint, 0644);
+MODULE_PARM_DESC(max_recv_batch,
+		 "Maximum number of Receive WRs to post in a batch "
+		 "(default: 64, set to 0 to disable batching)");
+
 static void __exit rpc_rdma_cleanup(void)
 {
 	xprt_rdma_cleanup();
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 3d7f1413df02..32a9ceb18389 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -440,7 +440,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	newxprt->sc_max_req_size = svcrdma_max_req_size;
 	newxprt->sc_max_requests = svcrdma_max_requests;
 	newxprt->sc_max_bc_requests = svcrdma_max_bc_requests;
-	newxprt->sc_recv_batch = RPCRDMA_MAX_RECV_BATCH;
+	newxprt->sc_recv_batch = rpcrdma_max_recv_batch;
 	newxprt->sc_fc_credits = cpu_to_be32(newxprt->sc_max_requests);
 
 	/* Qualify the transport's resource defaults with the
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 63262ef0c2e3..7cd0a2c152e6 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1359,7 +1359,7 @@ void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed)
 	if (likely(ep->re_receive_count > needed))
 		goto out;
 	needed -= ep->re_receive_count;
-	needed += RPCRDMA_MAX_RECV_BATCH;
+	needed += rpcrdma_max_recv_batch;
 
 	if (atomic_inc_return(&ep->re_receiving) > 1)
 		goto out;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 8147d2b41494..1051aa612f36 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -216,9 +216,7 @@ struct rpcrdma_rep {
  *
  * Setting this to zero disables Receive post batching.
  */
-enum {
-	RPCRDMA_MAX_RECV_BATCH = 7,
-};
+extern unsigned int rpcrdma_max_recv_batch;
 
 /* struct rpcrdma_sendctx - DMA mapped SGEs to unmap after Send completes
  */
-- 
2.43.7


