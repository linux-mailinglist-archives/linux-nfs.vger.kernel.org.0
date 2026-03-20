Return-Path: <linux-nfs+bounces-20297-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ICeOYKPvWnY+wIAu9opvQ
	(envelope-from <linux-nfs+bounces-20297-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 19:18:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D052DF4A1
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 19:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86EE0325E2BF
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Mar 2026 18:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86463E316E;
	Fri, 20 Mar 2026 18:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni3iMJzu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB33E1CFB
	for <linux-nfs@vger.kernel.org>; Fri, 20 Mar 2026 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030252; cv=none; b=VpRP/JP4IWZnS398yiGzPc6vQysyKV5IPe8bm0J8bH2H21g74Ubn//5EJpxHk6wa6Ig0QaoFMXOAXpyoxajDzhjq19dJzpKikxnA2Fj3jUJXgpiDi9PX+VJiLr1lbXGJZf99iEagVn1/My5WuHz2C0TaxHS0oOFDKTRy951VjFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030252; c=relaxed/simple;
	bh=CZYrSzJxOTHz3y2+Yn1YrwZjKF3A8fsmk9txEkZG5Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+xyLZhQYQMLE7pJR7HcYr1hkcGL9bixESyDdTx+QJHkXhZxMJMzyAwUlvsu25S5d+879FU8cABGIXcxT/Q01yS0dR0o2eiyFLRucJAQAdnv9/K+uNZDo/yFJxTClQQW5nJ7O4ycTUqye8Vz3SFG8O8vcRY28jwfZKQq81r0/T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ni3iMJzu; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35a09e0dd63so1095461a91.3
        for <linux-nfs@vger.kernel.org>; Fri, 20 Mar 2026 11:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774030247; x=1774635047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=capsefnRJybIkJWvu7BICDZ5yODeSG4sK/v0sJ/qwmE=;
        b=Ni3iMJzuv0zm9JIPpIqMAullCODUQPmcGAII9eD/pBg2BXI9he9MfyDLut/faWLMSh
         iO9w2tQHrORgyVCVkMvtulxwAJR29BAox7alDfH4vxpdyu+wv5tx5jFBHnTLRwy3jJK/
         Fw/lKwkWd6kQj4kyxaiINcsQ+L4cZXWw3BWIR4dilJVsQX3AdQd0WbINLU3MGALY6VIH
         DgdUxhfntXlvvNWI107p3qQklMogB4h2VEc45yIigU3oMnIus/IaFhhbLUVwrs//4FnS
         HFbxfpeyaRjgXJsVXjyPbZL00GlsOXjFfyxfMNUmf6aLbMIP+3O7aY+D+FU7k5tM3i3f
         lQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030247; x=1774635047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=capsefnRJybIkJWvu7BICDZ5yODeSG4sK/v0sJ/qwmE=;
        b=Mh+Y0Pb+MKU+pjvzOGa7NEBJICD0eWuq0Q0IuV8BsnsH2OQZdwH9AH1K4hEmO+GZkV
         udUaJ8rZJozqz+22Lzo0146442Uw+UKFRjOF6oS9ZXM3nbmzrkBKXelKKjn4GkxqdJqt
         rEGS4K8ZCBKQybEKedW33CroYUB0OPS49cU7auJ98W7G8YL19yTgUouRZ8B9szmWlo6P
         AMJ3ia4AP5hG4URYNaDEzbs1A+cfEcPAqRJAxXp2LOurOjKhPO342iQQ2dNbpADR8jV8
         pXDv8rBkr3e6pEbbeCugTMo7gov86WzZoUECHqXaqLB5OClOxYfuE+IwtPqnqRj2Bw82
         /aAg==
X-Forwarded-Encrypted: i=1; AJvYcCUUSWVNZRN1opSoh1vXD6IjxmWMIl4hpnHwoyk3jP0aUBmt1eyLDgG69q5kERjg5kjlXeU2ZyKjc24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxG//aqvkAvVs2l7Kq4PCZZyqkozd5l5gV/gj901q7b8bNihad
	3NRDO2lkTCc5gg+JUf3ngUSAZZUXM4S6wY0iYqN9/MIruiqtWuGMNQlB
X-Gm-Gg: ATEYQzyavu3zIDAmc7QjxKAxgidm2K3BAZnJjycv3AJcHhcXrqfFuoRBMZil3syr87C
	jG+ps7jUxpgHGV2m/J7i0ckQA/82MEa0juHlRyjaMWJHZ7h6fbZyuz3r3vh+gsdt2zXCR0EdVOd
	5Pkx6He1zb4PTc9CinRh8TSijtU7rWoBur1j4sRVRQmDfW9oimtfRzvpZS0TXXWnsQsk9JACBRv
	87eyWPCyIrwm6ITHFp6jC8Fc9lGUlMShxxPAUY1SM4aC9FAbdN0mkqpQjHc0Wia9rl+8/6fWmYE
	CJb6qQG7/GyQ07Hq5vxmV23dYK9jb6ZHfvJY5XfKjDs+hyE3ucvcAo+Lrr4UV7UTZgpM1ak7h5v
	ZeufKTQ43S49bwiSFWjvtzZXZNMW7qK5nKWk0ADvFKKwWMT1Ftt8qVkUtNCTHsgvCW5C0h3upqz
	XGUA/2nMnLk+rACV4yFcbZBoqhQkNbp8lUTnczJtrz8q6afTRO0/V3kXq2J3ArpgOfo9l2XAQ=
X-Received: by 2002:a17:90b:3e45:b0:35b:a1b6:5bf5 with SMTP id 98e67ed59e1d1-35bd2d79c38mr3132080a91.31.1774030246724;
        Fri, 20 Mar 2026 11:10:46 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd368837bsm959352a91.11.2026.03.20.11.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:10:46 -0700 (PDT)
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
Subject: [PATCH v4 2/5] nfsd/lockd: Remove redundant debug checks
Date: Sat, 21 Mar 2026 02:09:52 +0800
Message-Id: <20260320180955.150696-3-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320180955.150696-1-seanwascoding@gmail.com>
References: <20260320180955.150696-1-seanwascoding@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20297-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.864];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60D052DF4A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove unnecessary IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards and #ifdefs
in nfsfh.c and svclock.c.

Verification with .lst files under -O2 confirms that the compiler
successfully performs "dead code elimination". Even when variables
(like char buf[] in nfsfh.c) or static helper functions (like
nlmdbg_cookie2a() in svclock.c) are declared without #ifdef, they are
completely optimized out (no stack allocation, no symbol references in
the final executable) as they are only referenced within no_printk().

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/lockd/svclock.c | 7 -------
 fs/nfsd/nfsfh.c    | 8 +++-----
 2 files changed, 3 insertions(+), 12 deletions(-)

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
 
-- 
2.34.1


