Return-Path: <linux-nfs+bounces-19482-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cAouEQRnpGlcfgUAu9opvQ
	(envelope-from <linux-nfs+bounces-19482-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 17:19:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DBF1D095A
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 17:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6673130247DC
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2026 16:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277C530C625;
	Sun,  1 Mar 2026 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W19f5zHi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8EC3148D9
	for <linux-nfs@vger.kernel.org>; Sun,  1 Mar 2026 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772381852; cv=none; b=iRiN1tvQGoNqWPIPDj4rJ3p5xhaLI7/b8r35MLwKMOcCeTGWZSuXnBYLwYlV1w4pnTcBkV1IFIxNltq/okTX3d5tHXJpkWKZNN/VEFepNZcS/LlJh3fz3RDfs3rUsa2+4jIU5qTaUhaPYIRyHnE8gbeErkY0c9C2Lxer2HtjbjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772381852; c=relaxed/simple;
	bh=xqdDTVw/EwGn+QzPwJGCqGgnHV0i8uLIymXCYa+yyR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=blcaYs7DVyHIzvKxkHLzOlFi7cMT0sUd12FjUuJxsp2KhWyvVjvB3TY4s0vrkrPXCKNwlCfzJwG/AMk6cm4JumhsIETg04EzDFwBMtVRK3C8gGV6mD0ZAlbj49FeNVw/lDBOulDdFlTpkst19c+oEZkHb6lHS5ivBMwOlgVEy+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W19f5zHi; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c6e248aa446so1452121a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2026 08:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772381849; x=1772986649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2q4LQzRzv9NaruuYrSktCM2cTE1Cwp6g18iGWcF1kVg=;
        b=W19f5zHiGAT6WUTDpeKbHAq9ZYomkN9CTQ7KIqBk/i8OuW8CpHIlikDnp/TB4CFeKf
         Sm76uWb9deuYibrRplfHJQI3Qx/HvAUn4bM+dl2f1V/AWFyB7E59zYgS9F4nOetqL8/u
         z6mhyAPP8a03WLI4unSrL/9AOwckRx/0OzZS3aPC25HW4KIzKzw7XwNFutSX6aDg+NkH
         PkRvjAxF9OHI5s4NSHTE+4H00flZ1Rvpl1Ab90p1p/y3eUsvMq0rXlSVFIgCstne+b9I
         JQFYmf69UMaWhLNd9lplA2+IW01tyuMQ0pkWRWO8MwDWcw0spLbHGyfbp24jk8pbQ0Bm
         78iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772381849; x=1772986649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2q4LQzRzv9NaruuYrSktCM2cTE1Cwp6g18iGWcF1kVg=;
        b=cnM09aLO7i98kGbu/YSQVinqdjJ344z78ryHQj9GkvWo1Ao3/0eKcHwlo5jX1CAgeg
         3tNnmiI9LdZm1IGOJsOmJ6PiFsgfDrTiN66hiUFbUWhX44ex37u0RCsYWu6KTJ9BfJ6+
         a9/GiBv5Am1p774ok5LdJynOD0Ad4ZRvP9ziRh0XnZCOo3TRmEbxoLvMzdazLXDK7yID
         p6EEvjy3t5/xj6tRvnd1iiOa7MNZ/5UbuuAdkZSgv0XM1jXLcV9STEaN8oJ8YUx7hX4n
         eMn9LLZmS4ktaNndKjDO329/kUljU8CgQXRte4dMWdoBJQ05bT7LQpA6wdvP065CrusA
         QNhg==
X-Forwarded-Encrypted: i=1; AJvYcCWEH4VvtdZ4NpgWbe8fTCYqgGXTkHAP0MnXF5wLzyyiPvFVMeEmid4/23OntH3ZqVy6XfY7dxU3Mpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5LZpErGFWQqpVhL/ERgFRsy/20D/PghANmoVBQCTBizM8SruW
	1HilLvPMBR+BfGwDzTm3J/g9gjSarPcWCZDd24/C01HRSI3fA1DgHGI+
X-Gm-Gg: ATEYQzwwk2ZSNrjwnk5kCZD3JGCGqQaRDu+RkXj4PJ+QAzs3u+k4XPwkj7+u10v8r4M
	z46TULKWHctt1jBKl9oq6thwxE4cXGg9zZvtNp317fUfe2r9tfPYsTu8UF5b4hCq+2zI2/VPUlF
	FPZrbpWhdeMvt9cIyP0J+lCt0Xlv04gNe3D5c/Wm2Hp/AzxUCx5flDvdDy9JwpesvoyVIje2HLi
	BpOeuQQ550Zo0FhJ4D5FUcC/A+qP9tjtNcK0ixyplk17fyuqaIa/3R5/e2kMsOikoBvKhTqsjBt
	RTu37kkVwXqAw+s9x67BPjnSdg4LL7htht2XiQyARjHOM89rKHagFVJSoLYy8hWozJilC9M2bO6
	2rRaa6Mv+j7CDTY7UQkQcawYDrQCu+3tD4k1mIB5sU08cL1aLo37nQUMCnzgdWGs1+jeC+aljJL
	Z+Hh5zOgS3pVOvk075KRIdvaqI1FVC6tbE/7HLoGuHWs9SNccyCFwU51Q5vqK5DZ7d3wI6
X-Received: by 2002:a05:6a21:3a44:b0:395:732:2c8f with SMTP id adf61e73a8af0-395c3b16eb1mr7619251637.65.1772381848651;
        Sun, 01 Mar 2026 08:17:28 -0800 (PST)
Received: from sean-All-Series.. (1-160-230-14.dynamic-ip.hinet.net. [1.160.230.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa61fcdesm8651456a12.11.2026.03.01.08.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 08:17:28 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Chuck Lever <chuck.lever@oracle.com>,
	David Laight <david.laight.linux@gmail.com>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v6 1/2] sunrpc: simplify dprintk macros and cleanup redundant debug guards
Date: Mon,  2 Mar 2026 00:17:08 +0800
Message-Id: <20260301161709.1365975-2-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260301161709.1365975-1-seanwascoding@gmail.com>
References: <20260301161709.1365975-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,intel.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-19482-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,lunn.ch:email]
X-Rspamd-Queue-Id: 98DBF1D095A
X-Rspamd-Action: no action

When CONFIG_SUNRPC_DEBUG is disabled, the dfprintk() macros currently
expand to empty do-while loops. This causes variables used solely
within these calls to appear unused, triggering -Wunused-variable
warnings.

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
- Remove RPC_IFDEBUG() and associated #if blocks in fs/nfsd/nfsfh.c
  and net/sunrpc/xprtrdma/svc_rdma_transport.c.
- Remove the #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) guard around
  nlmdbg_cookie2a in fs/lockd/svclock.c.
- Consolidate the dprintk definition to be more idiomatic.

This fixes the build errors reported by the kernel test robot while
improving code maintainability.

Link: https://lore.kernel.org/all/69a2e269.050a0220.3a55be.003e.GAE@google.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603010612.uRmHYMsi-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202603010852.3RKXCwyF-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202603010808.w3TtG6fC-lkp@intel.com/
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/lockd/svclock.c                       | 2 --
 fs/nfsd/nfsfh.c                          | 2 +-
 include/linux/sunrpc/debug.h             | 6 ++----
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 4 +---
 4 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 255a847ca0b6..4bac32f009f6 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -53,7 +53,6 @@ static const struct rpc_call_ops nlmsvc_grant_ops;
 static LIST_HEAD(nlm_blocked);
 static DEFINE_SPINLOCK(nlm_blocked_lock);
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
 {
 	/*
@@ -80,7 +79,6 @@ static const char *nlmdbg_cookie2a(const struct nlm_cookie *cookie)
 
 	return buf;
 }
-#endif
 
 /*
  * Insert a blocked lock into the global list
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18..cb3fb91d18c0 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -105,7 +105,7 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 {
 	/* Check if the request originated from a secure port. */
 	if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
-		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
+		char buf[RPC_MAX_ADDRBUFLEN];
 		dprintk("nfsd: request from insecure port %s!\n",
 		        svc_print_addr(rqstp, buf, sizeof(buf)));
 		return nfserr_perm;
diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index eb4bd62df319..f6f2a106eeaf 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -49,12 +49,10 @@ do {									\
 	}								\
 } while (0)
 
-# define RPC_IFDEBUG(x)		x
 #else
 # define ifdebug(fac)		if (0)
-# define dfprintk(fac, fmt, ...)	do {} while (0)
-# define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
-# define RPC_IFDEBUG(x)
+# define dfprintk(fac, ...)		no_printk(__VA_ARGS__)
+# define dfprintk_rcu(fac, ...)	no_printk(__VA_ARGS__)
 #endif
 
 /*
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 9b623849723e..ba6fe0fd387d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -414,7 +414,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	struct ib_qp_init_attr qp_attr;
 	struct ib_device *dev;
 	int ret = 0;
-	RPC_IFDEBUG(struct sockaddr *sap);
+	struct sockaddr *sap;
 
 	listen_rdma = container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	clear_bit(XPT_CONN, &xprt->xpt_flags);
@@ -560,7 +560,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		goto errout;
 	}
 
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	dprintk("svcrdma: new connection accepted on device %s:\n", dev->name);
 	sap = (struct sockaddr *)&newxprt->sc_cm_id->route.addr.src_addr;
 	dprintk("    local address   : %pIS:%u\n", sap, rpc_get_port(sap));
@@ -571,7 +570,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	dprintk("    rdma_rw_ctxs    : %d\n", ctxts);
 	dprintk("    max_requests    : %d\n", newxprt->sc_max_requests);
 	dprintk("    ord             : %d\n", conn_param.initiator_depth);
-#endif
 
 	return &newxprt->sc_xprt;
 
-- 
2.34.1


