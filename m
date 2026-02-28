Return-Path: <linux-nfs+bounces-19445-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO+HIk5do2nW/AQAu9opvQ
	(envelope-from <linux-nfs+bounces-19445-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 22:25:34 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1971C908B
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 22:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFD8D3197A41
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 19:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4631138CFEC;
	Sat, 28 Feb 2026 18:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igEuzZYs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65B383C98
	for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772302120; cv=none; b=BD6iOjxzwZffg+VJAhLRGc/JDc90k//hvRoG4BmOFVcp1RE4DgRWOytopJBVwDyrPJq12UZ4Jr4b5S5I80cj43L049IFFabmv3qNSBsshYfMOSOw2+QzCFReJGHi/1rhLWnHVVeJwbiG5LI2/K2JY5c5dSjGcNqPZgPB/9VF3qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772302120; c=relaxed/simple;
	bh=EO7jsIkjy8zcpTckBUW3cT/KYocmnqn8xEzGqyuAgvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iF0TJrCmOx59tl7yrMNvbYOH8+bePt7M+gFnWCzjhCWcK2kRzbm7lA+7z7KGKnH8+9NyDDRx+dLZHNZ8TcVPIKGGp3YUQXGwfP8wcxIDr/4Qef1r52KHPXWDXcVLgh75+/DFElEzqV/ge5jvii0gvSSExYZc1v6h0heGfdkypwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igEuzZYs; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82735a41985so1812906b3a.2
        for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 10:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772302117; x=1772906917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1b/B2f0Vk0y2rjHQ9oplWOwEPv2E78m9d0l1U5eNgvc=;
        b=igEuzZYs0FLulukX5TLCjH0ZFbTEc0NPSxnQ653Bq4me+wQxy/P/2utSkQNO4k4bfn
         XHDE185wIdFwTIyaJjd4xRBv5v8c6jutrodQAex8+pwtsq+L8qhj+EQSMUKlNrpED0Zm
         JUbYEOOJp410I2e1byDReMYeRr6mdV2wsKEl3bLh0AMKYVt1Hm0dX4/9Mgf76roBKZyj
         zP3RSa/raDoTv2lyfhHmR0j38wl2k6EvCcBL5xFOSyIm0OKXRdzNrPWTxb19RUNyyMz1
         cz+vyFdhuX59a63ALhsaN2IYwLIa96zB2f2f0XLWqGliICVl/i4/hgksVqokID/aRiM6
         /7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772302117; x=1772906917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1b/B2f0Vk0y2rjHQ9oplWOwEPv2E78m9d0l1U5eNgvc=;
        b=HtW/05S1MDfaH/QnD9cZkh7vQkukls/4xvxJ9y0DBas8JcWVgO1w56QcpF7v8z8L4B
         PEIP4VvOEbYHTs7tSgshTO2pqFyL8c0R5r0X59FncmvKavD/+afQtH1+iDk+8YOoRmgT
         CWNrEC5C1RzhMld03kuejVk3K12oPnkXDg+LWTI1bbtDrQ7FlmBUj0i3QAgU6LzY6Lti
         vRdupekGR4MurbVn+yPPs/eZFRIyBXPHS+uJ4zdHJ5VV0izGdeLvL1J0JLbGYPxNpXvq
         ZO89Hvtc5DIVKv95Tz9lJvPhhCSfvzPxwKwldmoQi6cGEPvQFp0gEzLqGVGMraDZfoXU
         /Wow==
X-Forwarded-Encrypted: i=1; AJvYcCVrc9PUXi6PW8eGY26ph5DzoYEWjbYyRjN7W0InZMLzWJtFkGe5YS27c2u1ZxHKhbbnfscJo+hi5E4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzakdvHK7hus1bL/1cBFCrXVpR5JE7fQkkWLfeMznZIOoFbu8lM
	lTjCVITcw9O0J1hCcd7Ue6GCP7I95yteBBwvoy/1f6IJlMIBKL2apJ9HtQLADw==
X-Gm-Gg: ATEYQzwL2dNMAq7vJ99a0Eb31/ZGycdM2Jr/F5DjUnpBlaZbB4c7BBdkETQ6RPtrs1D
	psjWUCw6jwOuGyMk7Nx3QduoVDR5NZLOwP1j9Fg5F76yUjx/xuoD1xDYCJUH5E/0WGt4tmoKWuu
	ErTSgEoO2/4ByEeXxSV4Dco1kHMKkvfOTzCqab+PPGnEZVvPWzGXwrtaEGqSI2UhdIgZle+j0tT
	dkdNP1/KDTXOBgKcz7y7HU8YLjF7ncKQ46U1EZDyF3spYQ6PGB2arwm9qWTfSm5XSJ/6bJvVTMA
	lRne5oPHyOunmYhZBOWBl2FSCGPjqqZ0XE5Y7stkbugi9A31gSYRGbOgZDGDMHRE64k06FXQdjs
	QYIQOOJ73FOdkARF0gSQ2ms76giBhaRKtEz+4ScN+3PihxVCen/94ye3II3L+asi4809QbuKZtW
	ej+4A7Bl2vUeOROIGzFt9NuSqSHUB9iPp7k+z1XR4BGFT2G091OTcFdv6l/YoKeHlQrhR9
X-Received: by 2002:a05:6a00:1a0b:b0:81d:a1b1:731b with SMTP id d2e1a72fcca58-8274d998763mr4706209b3a.19.1772302117279;
        Sat, 28 Feb 2026 10:08:37 -0800 (PST)
Received: from sean-All-Series.. (1-160-203-78.dynamic-ip.hinet.net. [1.160.203.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm8065154b3a.36.2026.02.28.10.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 10:08:37 -0800 (PST)
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
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v5 1/2] sunrpc: simplify dfprintk macros and fix nfsd build error
Date: Sun,  1 Mar 2026 02:08:20 +0800
Message-Id: <20260228180821.811683-2-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228180821.811683-1-seanwascoding@gmail.com>
References: <20260228180821.811683-1-seanwascoding@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19445-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E1971C908B
X-Rspamd-Action: no action

When CONFIG_SUNRPC_DEBUG is disabled, the dfprintk() macros currently
expand to empty do-while loops. This causes variables used solely
within these calls to appear unused, triggering -Wunused-variable
warnings.

Following David Laight's suggestion, simplify the macro definitions by
removing the unnecessary 'fmt' argument and using no_printk(__VA_ARGS__)
directly. This ensures the compiler performs type checking and "sees"
the variables, silencing the warnings without emitting any code.

Additionally, fix a build error in fs/nfsd/nfsfh.c reported by syzbot.
In nfsd_setuser_and_check_port(), the variable 'buf' is conditionally
defined via RPC_IFDEBUG. Since no_printk() now performs type checking,
it triggers an 'undeclared identifier' error when debug is disabled.
Wrap the dprintk call in an #if block to synchronize its lifecycle
with 'buf', following the pattern in svc_rdma_transport.c.

Link: https://lore.kernel.org/all/69a2e269.050a0220.3a55be.003e.GAE@google.com/
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 fs/nfsd/nfsfh.c              | 2 ++
 include/linux/sunrpc/debug.h | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18..f7386fd483a6 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -106,8 +106,10 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 	/* Check if the request originated from a secure port. */
 	if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
 		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
+#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 		dprintk("nfsd: request from insecure port %s!\n",
 		        svc_print_addr(rqstp, buf, sizeof(buf)));
+#endif
 		return nfserr_perm;
 	}
 
diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index eb4bd62df319..cb33c7e1f370 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -52,8 +52,8 @@ do {									\
 # define RPC_IFDEBUG(x)		x
 #else
 # define ifdebug(fac)		if (0)
-# define dfprintk(fac, fmt, ...)	do {} while (0)
-# define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
+# define dfprintk(fac, ...)		no_printk(__VA_ARGS__)
+# define dfprintk_rcu(fac, ...)	no_printk(__VA_ARGS__)
 # define RPC_IFDEBUG(x)
 #endif
 
-- 
2.34.1


