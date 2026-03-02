Return-Path: <linux-nfs+bounces-19501-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHNcBW+4pWkiFQAAu9opvQ
	(envelope-from <linux-nfs+bounces-19501-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 17:18:55 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACECD1DC9BD
	for <lists+linux-nfs@lfdr.de>; Mon, 02 Mar 2026 17:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5C2330234F2
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Mar 2026 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F45E2FBDE0;
	Mon,  2 Mar 2026 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ozvc3BXp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B5F2F3C13
	for <linux-nfs@vger.kernel.org>; Mon,  2 Mar 2026 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468314; cv=none; b=X9IBXoS03/ZxFECebNwnl6zA/a9U/V29KA3HYb2z5b7Ju2zCmmX42bwTj5p+gYzZi5UBT6otLQirPHTdOJr1Tiq3Kn9oQey6eLYuLVGSuMprngwo0LIbYnvH0dEQeGBOmJdzmwGqAl6j86rVZYSwBVeTu51bZhx+sWshSO3ZUS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468314; c=relaxed/simple;
	bh=3RyZw1J33eIoZOy7izeY54Rk6a6ye5Bzt8iY6XpOGr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RmMlcapmjpe1YaDh/hHWa8yKdpZXZvi5kofk2h0d2zDDXw0gU2zcBH+HsLpMDnP6jVsCAl2cqLuzVb6IOOkBUF5TkynXoY4OoEhLl1nD86ZuPcdmm2s9+XtFHla3y5jKpq3gx8Tws/pHw/Jr/DuA1xKqYKOYuyuvbYCkC7tLtBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ozvc3BXp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-827307b12dfso2534284b3a.1
        for <linux-nfs@vger.kernel.org>; Mon, 02 Mar 2026 08:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772468312; x=1773073112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/n5FdJUguFV7iKwaO9oDyh+DvXwYdzvA1C7E2VBJBfk=;
        b=Ozvc3BXpneokbe6KbtH45nsGIvPWtKkHwO58Jadeqi7vTgvLiiUVIM1tBqHx8ALq8A
         WJzrUjB5m51087G5bHlg5+M/EVwikeO5GTrKwJdxPA+Jd9Tq6p+FUkepSUJmympBcljK
         tqNBkzBikJccfFJxpJ/EuaQyXZ9Lwg9EwdGbxFnOAqD7+troZZiyakacAT0BddIbJNaI
         NtXlCX5tzercuTT5/HsUQ7ZP+CNEIyamE71xPxjJzvTWpq5VhXXrHsCpRtiBR/sUIWn5
         IvVLVvWU4TbfU6sHLY0YEWODlA1G8HMt9CYy3xnna3WQKVE2LBuQKSKyP73Ynp3Y+esM
         qpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468312; x=1773073112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/n5FdJUguFV7iKwaO9oDyh+DvXwYdzvA1C7E2VBJBfk=;
        b=tNWtNRqhtfttSZHUJm+io8Sl2moD/wOQhUPdHlVfWg0GY+ykIAX5EZYhC3FRl+Waxt
         Dw9QF0VULwtT5+DC1dkHlfmquv3hE4mJkbeJBuhlDcev+L3JOKMd9FEbjWFG/suVAfxP
         2dqXv3zORmo9IdG/lfsJN0QDMwsRf53qT4XuGqadOi+BOZOT0ZniqmERbX3LBU4g0CmN
         sb638Lv+A6PrHgstSoCBm0L3L+XY9EgxQdr/wITZ+m8Ybve6RROhfocArZWVzNXyKhNO
         cwXM1c663JRICSiFcOdnkgbPqkyXh2kuHtZZmRVledck20jJYKvnNZDV5QIyCiH80URS
         BSPQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7pIGCa+57UZGutc07/eAnbCoQfgiGMqys68xMeckeumSp7wjBMU2pJDdwn9nNFHrVAm99amuIZMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ih5aAeyFAi0f46g+PkP+plMLEJgHz1Ojjxo0UjPsNYMhfbUN
	jjqPWe4UsSs0gyFgqMdjxvUyVYV2yiKowWjugQG3fKi2zX5DSysVYiKI
X-Gm-Gg: ATEYQzxcbaL9MPmhBFhp8YJUqEMD+1W1fV6MrWPYUxbXqgq7A7cBJLn+hNVIvG8fJ1Y
	S5wgITlhdNSjtwo7KJLKEIpUoNwBujNRAWwSOZboi9X7+x0+/bWNZGeEgrYcZgWMSToNgSeui8k
	C2NlBTstz1ioL2tCO0o8tLJmtJCIxYaubQR0qzTIARDTC1DKdJG+s8Sq/HslMNmrLGKuIjTOxhH
	n2rkoKy1SUij67waXJTuYc/3g9AYMFqXHxgVzgcPhZGFPsTPb50exeSmOQsZcQ0kd6+aRR76PoK
	sBLv/UeHWC8AqSci4GM3RAxkFjAUBFx4MRpvqH8SME0yA8jf77zqhNG0A2wGejMZrC5HSpzdslV
	j/zpgjd9g5w1Bd0pdKYN62M/8JFgZapHDcc+H08M7EquqNC4tJqpMEa/l2LYeJTq121yFAdQZ6R
	/UvXHbDGrbQS1zSbYV8oaneSJ+LEtxtbgBSB9O1w35Zfxq7wikgXqiDSgTb8x15ogq5dTx
X-Received: by 2002:a05:6a21:594:b0:394:6440:c13 with SMTP id adf61e73a8af0-395c476ef25mr11709902637.29.1772468312103;
        Mon, 02 Mar 2026 08:18:32 -0800 (PST)
Received: from sean-All-Series.. (1-160-230-14.dynamic-ip.hinet.net. [1.160.230.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa5asm147567775ad.60.2026.03.02.08.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:18:31 -0800 (PST)
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
Subject: [PATCH] sunrpc: simplify dprintk macros and cleanup redundant debug guards
Date: Tue,  3 Mar 2026 00:18:18 +0800
Message-Id: <20260302161818.63651-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ACECD1DC9BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19501-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:email]
X-Rspamd-Action: no action

Following David Laight's suggestion, simplify the macro definitions by
removing the unnecessary 'fmt' argument and using no_printk(__VA_ARGS__)
directly. This ensures the compiler performs type checking and "sees"
the variables, silencing the warnings without emitting any code.

Verification with .lst files under -O2 confirms that the compiler
successfully performs "dead code elimination". Even when variables
(like char buf[] in nfsfh.c) or static helper functions (like
nlmdbg_cookie2a in svclock.c) are declared without #ifdef, they are
completely optimized out (no stack allocation, no symbol references in
the final executable) as they are only referenced within no_printk().

This allows for significant cleanup:
- Remove redundant #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) from
  fs/nfsd/nfsfh.c and net/sunrpc/xprtrdma/svc_rdma_transport.c
- Remove the #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) guard around
  nlmdbg_cookie2a and stub function in fs/lockd/svclock.c
- Consolidate the dprintk definition to be more idiomatic.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/lockd/svclock.c                       |  7 -------
 fs/nfsd/nfsfh.c                          |  8 +++-----
 include/linux/sunrpc/debug.h             |  8 ++------
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 25 +++++++++++-------------
 4 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index ee23f5802af1..9b978a087b3c 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -47,7 +47,6 @@ static const struct rpc_call_ops nlmsvc_grant_ops;
 static LIST_HEAD(nlm_blocked);
 static DEFINE_SPINLOCK(nlm_blocked_lock);
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
 {
 	/*
@@ -74,12 +73,6 @@ static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
 
 	return buf;
 }
-#else
-static inline const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
-{
-	return "???";
-}
-#endif
 
 /*
  * Insert a blocked lock into the global list
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 68b629fbaaeb..91514326d1b4 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -105,12 +105,10 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 {
 	/* Check if the request originated from a secure port. */
 	if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
-		if (IS_ENABLED(CONFIG_SUNRPC_DEBUG)) {
-			char buf[RPC_MAX_ADDRBUFLEN];
+		char buf[RPC_MAX_ADDRBUFLEN];
 
-			dprintk("nfsd: request from insecure port %s!\n",
-			        svc_print_addr(rqstp, buf, sizeof(buf)));
-		}
+		dprintk("nfsd: request from insecure port %s!\n",
+			svc_print_addr(rqstp, buf, sizeof(buf)));
 		return nfserr_perm;
 	}
 
diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index ab61bed2f7af..f6f2a106eeaf 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -38,8 +38,6 @@ extern unsigned int		nlm_debug;
 do {									\
 	ifdebug(fac)							\
 		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
-	else								\
-		no_printk(fmt, ##__VA_ARGS__);				\
 } while (0)
 
 # define dfprintk_rcu(fac, fmt, ...)					\
@@ -48,15 +46,13 @@ do {									\
 		rcu_read_lock();					\
 		__sunrpc_printk(fmt, ##__VA_ARGS__);			\
 		rcu_read_unlock();					\
-	} else {							\
-		no_printk(fmt, ##__VA_ARGS__);				\
 	}								\
 } while (0)
 
 #else
 # define ifdebug(fac)		if (0)
-# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
-# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
+# define dfprintk(fac, ...)		no_printk(__VA_ARGS__)
+# define dfprintk_rcu(fac, ...)	no_printk(__VA_ARGS__)
 #endif
 
 /*
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index f2d72181a6fe..ba6fe0fd387d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -414,6 +414,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	struct ib_qp_init_attr qp_attr;
 	struct ib_device *dev;
 	int ret = 0;
+	struct sockaddr *sap;
 
 	listen_rdma = container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	clear_bit(XPT_CONN, &xprt->xpt_flags);
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


