Return-Path: <linux-nfs+bounces-20274-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IPVKncIvGkArgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20274-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 15:30:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6D62CCD61
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 15:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 299833087EF3
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA7E3644D3;
	Thu, 19 Mar 2026 14:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R81D17Cd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E27361671
	for <linux-nfs@vger.kernel.org>; Thu, 19 Mar 2026 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929943; cv=none; b=UU1WuL9HFEC7nS/hR5giK/CpDaBkkidP5NiY+MbVCHbcxZ7m4ZTMLpb9Rgk/6BESWsjmivEbNYtfyqEN3SXrtEJfXW0fEiEY+BcmjBQdkK79IC5tUlB/pXAO6w+kzPD5iUppGpCTOMv15xPjnt+T64tCfAHkrO4Z2S87cMdQLRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929943; c=relaxed/simple;
	bh=Bj04iTXB7MhKSrOnlUvWs1/LZRy/U40aj1lrebnr4kE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pH1FCRQgbpTYQ5f7Eg17HXz8RmM7mtqJpPGt0rjJox2Pi0v4c4ymBbPnHdei8O07u1AgrHzS+7FfEADfw6uFzcsPmbul/iIWi1XUBxKzAfGwUL8EuByBrmqjRHXrqatjoQ4DvB6XBWTNxRG5FYUwgLCwgSs00xsCJj2fJbry9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R81D17Cd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so316783a91.0
        for <linux-nfs@vger.kernel.org>; Thu, 19 Mar 2026 07:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773929942; x=1774534742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOf9LcnO5IRemgfOLwtBwbNVtgVrreL+MONpjgDCJOc=;
        b=R81D17CdNHfsMNlMgTTSiDVNzGT4uUxmExPFqk3TUP6Y9NUw9Mv1LvneXLDnPsaefG
         nh1FpnsAMLu+Oq1wqTiVQgbkdwnH/TD2afQEMBNo/qAUhz1J2gT3bcZcmUedPXBveMzU
         MVxeZ8QYAH5G4Z+NlY/mnZK6D6xbQyYRQW9F0XTZVodLh95X7VJJP3TKh7QlUvMDvmBJ
         5Q1VairZ1Jruodd++GeGk3A9f+XvBGe/bm5Eh+bj1uj3p9sKKZ5OLQOYjnkFeeLBSWon
         WNBGr9wN4F6YvR2YhIVMML9R62jjECS+T+xoQ2qdqmDx8XmPVjKcwj7sGlQDwPoNuo0J
         vxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773929942; x=1774534742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TOf9LcnO5IRemgfOLwtBwbNVtgVrreL+MONpjgDCJOc=;
        b=CoHtC9dNzzyx8TXtXseV6VSCaxFQdkZbz3BTMRPs8xRDb5KBZaxlEYu5K5+ga/oula
         S8vrbn3vsKTOw5W4+akY6kgxu1psgoXEsj6HRjLeI3yYSs411wRthSlGG494W10k8ywa
         Van/jd/LzDBzj3UFy5PTzytya28at4JBrd+2hTDqcsplW6KF8k/3qrXDG8kc+rMoq1qG
         cJAHug/DjrXGq0L8nFLEy6m/ur4t2sswfVs+XTjYU23LcO8Us125NPb0IeWBHElfZdD4
         +mB2o6m3/BSyxxsdUzHpcGbn7vzwpp3J0MeCe7T9N5tRSUerfI8CwZnkIH3nYgDyUobk
         tiDw==
X-Forwarded-Encrypted: i=1; AJvYcCWoDXDCHAa4ic6Vsuh6AZMYa1RmL0t4OWiKOzFUYv/bFE0bjzY3oIbv+k+QluWHGXnHAXItllo1sKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVBeE+caOI5rSiJSCLUz0sKltWGtiBPfAtEEDU0Y3Pe53yODYn
	lzNjlUpuStfzzd2o+Ii43eRGfZB0PW1bsF+O8TFctWqc13SRVcE1tqgS
X-Gm-Gg: ATEYQzyK/fhagdiPkNgidYplQs3phZygl+dnD6tRiPyG6a6cZm9GLE1HYXH2ixHvigq
	xZwcz1Fw5H9ZhH9u8bwokCdDtF6YRn41O4vuUOARDti88qHA71gTnYpLLq81PAXqEiyov2BjLM6
	p86YZ6YPpHeRWON3vwlWJCt87Wgo8BOJV7rgASB2ItmE//92f2DTBZjZXoIRzC6D59p/GLlWlKf
	0unC9Qo98wT3X0JjQr3/sZ25RSlrfKdmsuu5tcTRVlK4lyfkkxtBwvF916VjISsIVyHYHS1pfWQ
	mX+AGRkh2j99QjG8BeP6JjWYgUbh30FzJ5LXJ1c1Ld9luWQzbgigYvJV1brG7fg35FVyEO0ck6x
	z5Lq5REgKV1598lx0Wt0987PP67zSYacp7ga3MngI6OWVkAh3+PevfrqX4NyF+tv0SGIBuzQsZJ
	OhAGWklaJ0Y3chs/h9nMfE2UoV2Ayu3RZXWg52mPWe/+uiaPv7tu0bnCXdm43AYmU/RCAozrSLv
	K0bslhVfA==
X-Received: by 2002:a17:90a:d604:b0:35a:24f3:2c88 with SMTP id 98e67ed59e1d1-35bb9e579c5mr6654313a91.8.1773929941824;
        Thu, 19 Mar 2026 07:19:01 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc63286ebsm2695321a91.17.2026.03.19.07.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:19:01 -0700 (PDT)
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
Subject: [PATCH v3 2/3] svcrdma: remove redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
Date: Thu, 19 Mar 2026 22:18:45 +0800
Message-Id: <20260319141846.78222-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319141846.78222-1-seanwascoding@gmail.com>
References: <20260319141846.78222-1-seanwascoding@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20274-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.847];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF6D62CCD61
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


