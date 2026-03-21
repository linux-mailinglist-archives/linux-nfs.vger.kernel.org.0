Return-Path: <linux-nfs+bounces-20306-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL/vKcWovmmJVwMAu9opvQ
	(envelope-from <linux-nfs+bounces-20306-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 15:18:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ADA2E5BF9
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 15:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A492304019D
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 14:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB7A38C415;
	Sat, 21 Mar 2026 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wvae4peJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD17306490
	for <linux-nfs@vger.kernel.org>; Sat, 21 Mar 2026 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102540; cv=none; b=VrRRKPyCMZBpKD9S/v8agfnhnu20flK9QQdwbvmQR6OP4MQL4lC2JhzAyadIwK7k5KEfLoXEXdtm+gDgCGCwx6z7OQ6zHJbuFHGeSaMNz2QhjB93v2VyW9g6OyD+4b3MY8WFLu78FCLgzEL4z5cAvcD5hvTAgdlr4PPAHVBTZFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102540; c=relaxed/simple;
	bh=Bj04iTXB7MhKSrOnlUvWs1/LZRy/U40aj1lrebnr4kE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lUupRH6lTpfZekDqMfilqke/FTVnTGi27XLLUOYNyiRxK9Bkh/oPvQ3ElUnGfr9W3mdmdzH2sZ0QjUi+gQ1uZVweSWufzsCJTkRAtzAatvRhimKaK7mrroozmdM7HUZxTxPvm81H+MrKwrm4HDbtatC8cDq2W56EvW49jnorkck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wvae4peJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aaf43014d0so17957135ad.2
        for <linux-nfs@vger.kernel.org>; Sat, 21 Mar 2026 07:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774102535; x=1774707335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOf9LcnO5IRemgfOLwtBwbNVtgVrreL+MONpjgDCJOc=;
        b=Wvae4peJeASYU18/ry3ujxdjcrZ9U58sJiuK5vPyIkxaX9ITB5Ia5vJdjJZS/rB+db
         Ai4CMWn18nGIKR8ZLKS2DqaHc+Mss0vwO6/MQyeinLwHZQJqcRxJ/nmGN4Vmz3NrwaTp
         /uJfcVT8dn0wD/PvYqFqVZ3iJQG2u63STFpvvTfIlhThPHShAfFRkIYONbAJP73ikTqr
         rdFnb9lXjUHwXO6EvmsQuYNuVBIXUP+tYYwd66YiRtt1T5VS/GixvlBIC+UZpHJzndpS
         gBB3ER7fVmCKkbNQH5fEJ4bEB8dzbVGB3W4YHrvFJv9jJcN/f8v8gqF1xm8Yg5LQnREq
         61LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774102535; x=1774707335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOf9LcnO5IRemgfOLwtBwbNVtgVrreL+MONpjgDCJOc=;
        b=X9gkPmM6tTi0uh6vGMij5ZjuvPjOvHwKRyv3RuoRq3NBUt9Cf9Nj1qg5z4gp2oiKZr
         7g68bN7/8jnXYQFOXxB8wFBUdWWzuy5cUWb+Ny8rLbD8vW8DYSpf9J0mqMBDoNwro/h+
         ku4/+sep9KddZeYkFlW2TsYyJUvOyT253vyrV+XZbOVc/igchHFe4Jmit4q13fhuUbDt
         YV/goy/1h7KZplqAZrJqUDRTLAUhNLKiz/YsKm81EOCNYNT8+71SEXNI8N+viPiLtoC5
         JeQYv51XKRl0SoBzuf9tL/+HsUPmPtPfKJ3/xrmX8t+BkfSG4c6dgdp6rmMeDWoOIDv9
         Xy5w==
X-Forwarded-Encrypted: i=1; AJvYcCX6uz0s1i6egnu+O1fHuveFhiXnSD7fARx8cvxX3VMmA2Ja7kTBCLG5ZhsESR7UiNO/rE+Y01aXyLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOq6Mld99XuJ5kGFKzTpaMWviLNiDM2lqT90+BHahM7vCdCnMy
	bBVKrKWPh0Si8o3omtQ2EefG9urFZSVQfqql+sMaYeWEmI0TJBcpg7hq
X-Gm-Gg: ATEYQzymfKwOqa4jlaNLpw5puZ16XcQbZsISK2Q/PqXAgqaqLq+gO+3jDxPQzYBqcfb
	mGBKddWrEzOoyk8JAoLFZZJeYOJ6vW+DBREbILICZIRTKnISbNCwJgVI5OTOR40ZXFhfcyFzVXH
	YJrQskTdBZufdKZyWcBbRFK6F0fIFl5hzCz/UGay4DINivyTIopv3PeQp9X5JmMwVGP50Bhx8IJ
	vKNGYKwFf8+kT7Oq1HlHANtJdt29fQw7tvfFUe13e86D/JHT1knyDnvlz/yM6iPuyCtcXDEBr+k
	AhmN84DDaRVMyz6LqwMhr+oSC4IVl9uOdsJ6AQWZPUepEir4x+gINMaYHhrq2nHWZTWHfPh3jcQ
	3hrb3bVfxqPaMHHqMArf/FdIm+Sv7E8tnl94nfRL4bfSCGzpbsO/whNTgnX2aUtx3zDa5tdIgSV
	FPhizDsJ7kCCzSjvPZerKXnd96SDe9uoqNTujHcevVrfBZUcrSN46ccsXxCVTRBORgT6bKFFo=
X-Received: by 2002:a17:903:1211:b0:2b0:4f9a:b794 with SMTP id d9443c01a7336-2b0827bb54dmr63715295ad.37.1774102535362;
        Sat, 21 Mar 2026 07:15:35 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm52680715ad.25.2026.03.21.07.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:15:35 -0700 (PDT)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	Anna Schumaker <anna@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v5 3/5] svcrdma: Remove redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
Date: Sat, 21 Mar 2026 22:15:08 +0800
Message-Id: <20260321141510.68214-4-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321141510.68214-1-seanwascoding@gmail.com>
References: <20260321141510.68214-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20306-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10ADA2E5BF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards in
svc_rdma_accept(). Since dprintk() already evaluates to a no-op
(via no_printk) when debugging is disabled, these explicit guards
are unnecessary.

Verification with .lst files under -O2 confirms that the compiler
successfully performs "dead code elimination". Even when variables
(like 'sap' in this case) are declared outside of #ifdef, they are
completely optimized out (no stack allocation, no symbol references
in the final executable) as they are only referenced within dprintk().

Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 25 +++++++++++-------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index f2d72181a6fe..0759444bda50 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -413,6 +413,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	struct rpcrdma_connect_private pmsg;
 	struct ib_qp_init_attr qp_attr;
 	struct ib_device *dev;
+	struct sockaddr *sap;
 	int ret = 0;
 
 	listen_rdma = container_of(xprt, struct svcxprt_rdma, sc_xprt);
@@ -559,20 +560,16 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		goto errout;
 	}
 
-	if (IS_ENABLED(CONFIG_SUNRPC_DEBUG)) {
-		struct sockaddr *sap;
-
-		dprintk("svcrdma: new connection accepted on device %s:\n", dev->name);
-		sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
-		dprintk("    local address   : %pIS:%u\n", sap, rpc_get_port(sap));
-		sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
-		dprintk("    remote address  : %pIS:%u\n", sap, rpc_get_port(sap));
-		dprintk("    max_sge         : %d\n", newxprt->sc_max_send_sges);
-		dprintk("    sq_depth        : %d\n", newxprt->sc_sq_depth);
-		dprintk("    rdma_rw_ctxs    : %d\n", ctxts);
-		dprintk("    max_requests    : %d\n", newxprt->sc_max_requests);
-		dprintk("    ord             : %d\n", conn_param.initiator_depth);
-	}
+	dprintk("svcrdma: new connection accepted on device %s:\n", dev->name);
+	sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
+	dprintk("    local address   : %pIS:%u\n", sap, rpc_get_port(sap));
+	sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.dst_addr;
+	dprintk("    remote address  : %pIS:%u\n", sap, rpc_get_port(sap));
+	dprintk("    max_sge         : %d\n", newxprt->sc_max_send_sges);
+	dprintk("    sq_depth        : %d\n", newxprt->sc_sq_depth);
+	dprintk("    rdma_rw_ctxs    : %d\n", ctxts);
+	dprintk("    max_requests    : %d\n", newxprt->sc_max_requests);
+	dprintk("    ord             : %d\n", conn_param.initiator_depth);
 
 	return &newxprt->sc_xprt;
 
-- 
2.34.1


