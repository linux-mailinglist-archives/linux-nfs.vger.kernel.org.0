Return-Path: <linux-nfs+bounces-16339-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AD1C56A40
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 10:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D12CE34E9B0
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Nov 2025 09:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B94F32720B;
	Thu, 13 Nov 2025 09:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btyoGRoT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5EC25F975
	for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 09:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026662; cv=none; b=l/rb6L7Q8ZbdypRd82gCKz13fjl+WZqGzDZ4sXbcPgNS3xAmloPUQxpcaeyChb50u0WgoK8AuPoxS5lVa7jZtUsR844VnBm/Rw6f3IfbLrhtBS9zq8ACD3ZdZl5fR1k20IQIrdVlrtds/+JvPELp+d+yyHamA2mVtsTZRlUIjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026662; c=relaxed/simple;
	bh=wxr3oyHuw4JBJD6eiR+G0Wyqv+Sl/Us4AF7aWNcwdh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nowiJWtcgDqHPFyeZOwyVOEDSYrCtFUqQeNYOWRs8oBp96vJCkLduNotOBQ4E2sT47w5/CT6eAPv9Q2KGoCxMPgvWaj53UHtOC1AqqIVSEqnO3o4VVVfeP2LAe5KNJSwkUz38SmvoG3wSsRpsqR+ZKfN90oJ/a+me5BfIbWReqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btyoGRoT; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c6d699610cso190781a34.0
        for <linux-nfs@vger.kernel.org>; Thu, 13 Nov 2025 01:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763026660; x=1763631460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xtb1Tg4f0J+buM9U/6muLv9lSlDdspLzgrMc4VoD+Hg=;
        b=btyoGRoTYyzn6nyfz1yiavqaGy5cZKTsgZUZTVvxntuS2Mv9Fo5Vxw00avpIpOGSyc
         LlOgL9kgBtiZqtBNK9uFV5QooR2bmVF5zMszr2+Y2iaDQKqnHLn9HQUk2y7SWvCLf+qc
         y51JS86DVEGO4RByzaFQGiL7N0cXHy3Ys7mWT6cSWuMQCMalbKmGhTgTV1+wHJKPjX2N
         nNSuNwddVAKE8vz7DWS1ly3EKjYx4h6V1yU0/94jDNXmorbnErkPoUpnQKgafZQNwavd
         2lvz3Jj6HM8MW9XZf5sSxt4+llHEg97hAVKKS3+baULBq0IlLbqmSrK1qra23WVqcmPf
         BW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763026660; x=1763631460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xtb1Tg4f0J+buM9U/6muLv9lSlDdspLzgrMc4VoD+Hg=;
        b=CV77UU3tZaQr+Ccv7lKTbcqz88Vu9KdQwGe2GnGFyXV8RwVj0YDK4Aib7Vgbo6diUM
         OD/dUQ9l6pyc2X0KVPzOW751fAZTIlv5+qnqniuigQ1Kc9B/H339hJ43R1vRv/3c816S
         WsQvGw8SGZTPDt9GIC6w9GbzLQPLBgMOn6jjD4vJyZlkdaSDmT++hScQIMoImOAzwEfn
         LK4CCInKyL/kJrBOKwEie6Hpi7Rol5C1RvvB65DeWP+K1ZaeMiOLQeMMnT6JIpVn1tCw
         DIEgNcHKx9vo9Xe+BNsDyv9G2Y2j1t+HeMyeCH6aHXvEpCEoKDoc23tYgcBPrj8uE5BX
         hpCQ==
X-Gm-Message-State: AOJu0YxNumXxRU7iVkqW4WXdLOy3B/GnbD/KLgupLPr+tXwIhwgrOoEX
	EO5zOqnNejGW5BIYNWA18u8lv1gjF/eBet8AnXw5yI+j7WzwRT0N0Phh
X-Gm-Gg: ASbGncs8RuFZjedPWxW8+PaObtSmD/1LZAX/h2tO5LOna3/4jdflZ25jAqwq7hrUeve
	HSq0f0oGuQa16t3XAmm8ANgl8/ZCzR6Y6+RZSYc4Bz7NS2CiI4f1nmjklGtbuKMLeHWzeyak1KM
	funPh2wNDT7fuFr5h76jbHRpkb7OUM+dqty3KNXXfDLCKjpw9f4yQVNaSfO+gwRvbX52qntHCOB
	tb7qntLKIdqGyhks1hH3QluqHBUPe9wWu6X2lgnzQKRJpb55bFKSeOdtgy/pZinfUjeeSXVoSzs
	1ZOv4lqry3JQjt1r7jft77CYCeVvFkVuoUR7Z35CkC+HgbXFTtoFkkDujo4eMi9OzGfzrs70cjg
	gkVgxyatzheOecn4eyLWzhBlGqPwrxBHV7QpvhzTrRMd2H/JRmzwBDlwNEk8Xd95Yf9K6QfYZlf
	p9JJL0OL8xXGxEny3bFQo=
X-Google-Smtp-Source: AGHT+IHMKNbQ4oz0wihWMIL+HlfKr0NWvpV6k+t4a49W5gEIiaOVGKxER8IWM64Jp7bFq1GlN+1q+g==
X-Received: by 2002:a05:6830:808a:b0:7c5:3798:fa44 with SMTP id 46e09a7af769-7c72e1f72c8mr3612623a34.12.1763026659863;
        Thu, 13 Nov 2025 01:37:39 -0800 (PST)
Received: from localhost.localdomain ([192.146.154.240])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c73a283b6asm858841a34.5.2025.11.13.01.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 01:37:39 -0800 (PST)
From: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
To: chuck.lever@oracle.com,
	talpey@netapp.com
Cc: linux-nfs@vger.kernel.org,
	Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
Subject: [PATCH] Make RPCRDMA_MAX_RECV_BATCH configurable.
Date: Thu, 13 Nov 2025 04:37:20 -0500
Message-ID: <20251113093720.20428-1-gaurav.gangalwar@gmail.com>
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


