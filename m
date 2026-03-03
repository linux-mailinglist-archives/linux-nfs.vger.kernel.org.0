Return-Path: <linux-nfs+bounces-19678-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMznIE/rpmnjZgAAu9opvQ
	(envelope-from <linux-nfs+bounces-19678-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Mar 2026 15:08:15 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAD91F111C
	for <lists+linux-nfs@lfdr.de>; Tue, 03 Mar 2026 15:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99A053007A61
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Mar 2026 14:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2A735F5ED;
	Tue,  3 Mar 2026 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDB0noCF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF45F36405D
	for <linux-nfs@vger.kernel.org>; Tue,  3 Mar 2026 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546861; cv=none; b=qLi6iN+4K6iHp8v/SJBuhlMHRn/4/oOyU/eDHG2ykp0o7oOQSpiPGwhrf/67/VHqRgfRCSLmEwSSxeNBmKeo3yf7EnNasHT9hGGLSAt+9LrvPKg5WX7AZJVgdLFhQG+cTfrNYvEOVqvL8bsGZVAEJEl9YdTbNwcZ2iMWO/SmIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546861; c=relaxed/simple;
	bh=UwehxMHrmwHSRNEekpwxr0PA0ZKFDi1e3KFwspH0cx4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mwoAigQ3RJmNilzVmGiMu/73uLBLPN0jhGwb9wvjAShl4fmcW8AuAESMLPUjfsxtzRCUFd0bqZQQSUUNrUrC1YLQCz8LjLPWy+0RSkz3uQuVyQWdNvMHpqMveMIjGlBQuVUhLkeGVj9wINAi6iX6WF9cjd4Vvj+UC0QMaJcMXD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDB0noCF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8273e0fb87aso3126055b3a.1
        for <linux-nfs@vger.kernel.org>; Tue, 03 Mar 2026 06:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772546859; x=1773151659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qGn42rpsqVcew2iPbY1Z01ZsVFTS4vK/usD0Aqx9bko=;
        b=BDB0noCFjax3JP13xxyOi5P7EUxHpT6hwrH7R0QW95IgZj1ChU9Y9WrQnQoV24zXg8
         WATruYC7DnQGNdk6G6r7CSMpwg1fe6YT1J3lSIG54vnHX9ytgrnfkRmIiOq4UKt9TmP/
         cbbZeaEkkMGoVIcScEV8tMv+BlSM3Rx3ER+wxk4VuxlZ8v90aQBn6iY4vI8AF0Fm+A3x
         vqoTtNtMFd3qWHzzkqbvt1wzyvTtd7q84U2YnLnOFwfW1WKmauViXyg43ZTnW7uewbOk
         tGBdWxSJHqRO8V/mesBr2y3F+rGWhg0YSxhLhIKRqvp8kISQ6GEeZVTrDenT6t1xBGIh
         BolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772546859; x=1773151659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGn42rpsqVcew2iPbY1Z01ZsVFTS4vK/usD0Aqx9bko=;
        b=QNCW/DLWJ9UcBbaQataoRxaYVHYHa3JXQ1lyNmz4pjL2dQcuTNUdsWGidPC/u139WB
         erU0mI7JCLv1WAYMOjONroZeZU7RzmHvsB57t5vPLW9DWME4JtEo49xLOmCKpXqyVeJu
         kxKWdw+Q0O3A8ZEFjFH6BOc867+cSSg1naq/OUXHOS4pRYZ+AWF0T9qV2Bmt1pdVTbz6
         QO0/P2Ro2gW8iMBZ9FcS4VCe8Fww/5hpspWeYSnaCXJS9aa9xKdYrdzuH+E/tlunlCc6
         wYCqiyHdUKM4CtTLFXBm8fm/6lRJbax+vEaHUfKiVRxfnq3zJiw3oJEKvfvfMnG6S/Xi
         jF+g==
X-Forwarded-Encrypted: i=1; AJvYcCWt+9B3dZ+XaAUrLozapRPzQvLL4HLhz5PrqVOzWJbhE8ypFFJWn6Avn+U1aIiZAD0l4jWGMXdtE+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNaWYvKVGIoXbRFPcjHPLlW4KJAANzadB8O2bqwd7sjJLOwDMy
	C5xJ1PPNkee7VGAGNF0TLcw5/gV9ppsu/uOqpQUP5hR6ur62TDvIVEST
X-Gm-Gg: ATEYQzzYWTyiSdhJ46MbKiVFZ8T1LJT8kfsIC2oAwx0eqcC1fWDRMz3voM30XUqatCX
	peFUesCgI/q79/ywPREYdzbIZsCXNvFYIm6AApnRyuto/B/9u6X6rWUMOVZLrG/VtwAl8TVK8yJ
	d+NLt2erI4o0uvKBszHVualH25um4MPduJW+LCDLPi5ytdyH+cAaG9llBSelKrbclbzwOcVEUzP
	BCXs/DHIuZN9oKUnnC70YO0PvfJiP2Q1lXkrC9krB55M60iOBZFPRNfaquQ3g7tiZP5mXRSKjyu
	b4hpUK2F925gsk0dpiueOtw7KKnSWt4T7OcfqFm+yg6cldViEEaIntsXlhn/BknnNLfkeGLqwVo
	QfS4Fq+ghzt3zirdmav7D5Z7zODbmM4CLDYrc2lkTb37UEXVEpoobvxUN6PVJd+PyPJHNcKNg6R
	HENuLlRZAvC0nZDPVlBLh7c//dx5ePqW6DBplyzcuqa5cs/oUxjteOMP0eSJM5wLnvtyXx
X-Received: by 2002:a05:6a00:ab84:b0:81c:96b7:7faa with SMTP id d2e1a72fcca58-8274da12630mr14276407b3a.41.1772546858952;
        Tue, 03 Mar 2026 06:07:38 -0800 (PST)
Received: from sean-All-Series.. (1-160-230-14.dynamic-ip.hinet.net. [1.160.230.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739db3ab8sm16045781b3a.27.2026.03.03.06.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 06:07:38 -0800 (PST)
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
Subject: [PATCH v2] sunrpc: simplify dprintk() macros and cleanup redundant debug guards
Date: Tue,  3 Mar 2026 22:07:25 +0800
Message-Id: <20260303140725.86260-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BCAD91F111C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19678-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Following David Laight's suggestion, simplify the macro definitions by
removing the unnecessary 'fmt' argument and using no_printk(__VA_ARGS__)
directly.

Verification with .lst files under -O2 confirms that the compiler
successfully performs "dead code elimination". Even when variables
(like char buf[] in nfsfh.c) or static helper functions (like
nlmdbg_cookie2a() in svclock.c) are declared without #ifdef, they are
completely optimized out (no stack allocation, no symbol references in
the final executable) as they are only referenced within no_printk().

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
v2:
 - Follow reversed xmas tree order for variables in svc_rdma_transport.c
   as requested by Andy Shevchenko.
 - Polish commit message: use dprintk() and remove redundant file list.
 - Correct the technical claim about dprintk() type checking.

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


