Return-Path: <linux-nfs+bounces-20305-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJ/BEXOovmmJVwMAu9opvQ
	(envelope-from <linux-nfs+bounces-20305-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 15:17:23 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9931D2E5BC5
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 15:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81C4C300EF85
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CFA38BF6C;
	Sat, 21 Mar 2026 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmA1Qbi7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3963438CFE9
	for <linux-nfs@vger.kernel.org>; Sat, 21 Mar 2026 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102534; cv=none; b=Dl7xsNfeUTy6o9Ivo1P9WgWti5msAy9k0kJ9YB15vng0f16sOciy7Dz58BzcEz8xjSt562EFn8wqg+ZrlyIRpUWDstlZWB8NnK/aaz4fKnjUJXlTPkGRXBP6ehbWaoyaUHvn6pHzXqDQgXGBRicpHrNT4mD/b5nNdmx3MaaAj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102534; c=relaxed/simple;
	bh=CZYrSzJxOTHz3y2+Yn1YrwZjKF3A8fsmk9txEkZG5Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFAgmYA1cOIm9sjuPe6cmGP+/RzusDDQMNU3efwHOX+udBEaWFmph+SWXfc/TW7hfEHJ3N+bU2KdJH/K/+3U7jHytsL2sTe9fuDzMJOq92z8lJ4fa6EfL3WXc/3jSE9HbZY0FtkIetjdYU4YG/Do/UgtFfv3ir9+S7bmHhf32TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmA1Qbi7; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70c112cb61so1937472a12.0
        for <linux-nfs@vger.kernel.org>; Sat, 21 Mar 2026 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774102532; x=1774707332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=capsefnRJybIkJWvu7BICDZ5yODeSG4sK/v0sJ/qwmE=;
        b=kmA1Qbi7DWrr9wl9XxgOyKJhSkA29clirNv3pc+8FNyfYWZfax1HO+vyQ6xk2LozBV
         FC4syXzVAN1JdWuKVr4x/PBBP6LyTIAUMeKX2xw3lnkZ2COVn6sFOKnzcggj93vn/NbW
         br+Qre60lyv4308OfJrpy2WbE7hMgkYHjpQ1sLWD0sciNCGijeth8itNh/kjuQtv56XJ
         roaGieRghEE+sF9bDYqeCGy0n6rbotEWX1fyaC9iyIE1rQPfJAhsqaUNRtTXJPKmQ7HD
         nTZzclu0tpZQ9wBDsPwgTQ2RdhFuFOhyU44Rx+NhFRAS5Rs387BC31Bv3PnRHbk/8iup
         XotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774102532; x=1774707332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=capsefnRJybIkJWvu7BICDZ5yODeSG4sK/v0sJ/qwmE=;
        b=D8O3rd2zWezbu2o1/qqZjeb6irPwxPUuNYMmLTc5135SZnufvlJdCZOVG8UDCetQl1
         QGNMBJom2oepm/INT75LDJI7O/kocX0Ye4SbqpRZeV7vg63pUVrdFENSBPehZtNeIxHY
         6H0Gjj5o3BWheqjOmH45oJftvG5TWH/WLUeEEoqXA92xVu7mXXmgrIXP/VGCWkqkQCCJ
         ba0uMiCtmEL9EXKztp9asDTFz8+gJmSZgtBsc84kRhPuft4QcrNAAbVVkTW0FJ3W8Pzp
         qyTWMwIVz3cozMpWxNY/rXE/iAhsTZgp96hxheHHegEWqAY4alAERAuVN4N7TLx/qWvX
         YO+w==
X-Forwarded-Encrypted: i=1; AJvYcCUCD83FtKA9qqVbRBuShHqJxIBO4gxg4DiNNF6WkOu0L4Ff81m+bRR3RQ/fQB1Iuy3qT7/0/RqerxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoydxdxnhJd6W03MrrjLtlHLL683PYgO68xqB6F3Co6t3dPVN/
	QI7CHL9Sje8a/JTxh4On8oRth6V7C3JfAnSHc5KjFCdeP42PaC0z/j23O5Y+XA==
X-Gm-Gg: ATEYQzz44XpsdGBvvfBVuvFnz5ahOrQBfcTwhxucBV/ENH6xS3WDdLJEwyBc74+IZwJ
	m/sNYlONGbu+Gkq10beBaZsVf3wTu64mDwppMz8mp6w18nIvhhoJvpsqq5DAGiUMOmPLhJGhY5w
	8Ku/vtpWOygJfylmbRmHnNp8UBWCd3Vjj7K4K4u0DlgTNMwh/fM+yUTs477fcSiyJbyhwFBgjj5
	xLYJxyOKlpviN/2l1iesVNmSQKf8fnerMK881dk7v4h9/3KfNWyPDEa+Vk7+/okj6BBGFfwJlKy
	LmIBKdPZl2lf2+ZHBbJj2wV76XK8fbbEW460TEoWXOfkxes8OVJtfr5QofRMaKqdxYBXo6XYisa
	fodLNawOKTCs4D1p9KDkrB941soX1Dnfpwy77H3hOoaM8ytoyAs4pGPOc9mhWi/QJXRmSaIvXrk
	sFIk2pfFxjnqeLDcrwODEUbn8c1FCyy6XPfGe8BStY6xPGe6AJ5q7gefX2fAcZc6Ha9ZMif80=
X-Received: by 2002:a17:902:ebc2:b0:2ae:a8a8:92f3 with SMTP id d9443c01a7336-2b0827de557mr70039135ad.44.1774102532655;
        Sat, 21 Mar 2026 07:15:32 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm52680715ad.25.2026.03.21.07.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:15:32 -0700 (PDT)
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
Subject: [PATCH v5 2/5] nfsd/lockd: Remove redundant debug checks
Date: Sat, 21 Mar 2026 22:15:07 +0800
Message-Id: <20260321141510.68214-3-seanwascoding@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20305-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 9931D2E5BC5
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


