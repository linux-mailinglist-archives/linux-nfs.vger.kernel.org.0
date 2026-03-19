Return-Path: <linux-nfs+bounces-20273-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGSLBAEIvGkArgIAu9opvQ
	(envelope-from <linux-nfs+bounces-20273-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 15:28:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6392D2CCCD4
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 15:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3B8C3288E6B
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2026 14:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D77F356A3E;
	Thu, 19 Mar 2026 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoyyoVzv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0421D35DA4B
	for <linux-nfs@vger.kernel.org>; Thu, 19 Mar 2026 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929942; cv=none; b=M0kyH1V0uwuQu4/I47AnZx/AVkLlS3pjp9wDNLM3HMOFJH/TTxh3lR8BnattZgCyv9UVWBgmWPfw32OJaJS+rWdmlFpn6ysVgAGrxeOxcvSBcWFcICMYepNG7FS/oALOYq26W3QofG3I5+WgfpvI3yKKjmcHmL+HtWV3OLZxsiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929942; c=relaxed/simple;
	bh=CZYrSzJxOTHz3y2+Yn1YrwZjKF3A8fsmk9txEkZG5Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q48ZBUA8Ti2s/LTO3KFv7UTKa/h4sibFR81tLf2b7YiPceCEVsgkiaqjNGAHjWDFXqDVremsWBWtEvyQbTIaDQp87LhXzX0/GEOIYBSlofpQXRwkqWSwM884CCeMVk3vkBVPq0j0qOtOAyM0DpY9xGFUKRM/8lu1B3OfupPNK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoyyoVzv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so693904a91.0
        for <linux-nfs@vger.kernel.org>; Thu, 19 Mar 2026 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773929939; x=1774534739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=capsefnRJybIkJWvu7BICDZ5yODeSG4sK/v0sJ/qwmE=;
        b=IoyyoVzvsECxsP3yv/jixu1xEUc/cgocezdoKmVWuXp0Z5rRzv3o/JxdFV4Xq4m266
         prQFtBludIfcXysyglZ8iVOoBZorKAtZoCRwi2Z23hljNc+Otx1X+ylZCvCjNCtqy3Fk
         43fNNyX0gI7suCp4B/C+YwEMuApLmBnC69qjNTCBELC+2GY8l/nxUuW73Ikub1faFbEN
         nzQOAjYlJ0Oc+XzXaVegPy3Bf7KTWMzqfuI15pgql2/lymvShhG5pBTs9vmzPwJh0EIG
         rsghQiht5C9TziQNoIcuUk/9RAxk/h+PCgTUsFW1P8OIolNs2jjv6wRLcyTafp56uMWx
         HfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773929939; x=1774534739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=capsefnRJybIkJWvu7BICDZ5yODeSG4sK/v0sJ/qwmE=;
        b=Q2x1sa/2LGuxX1bgN7R6Tm1f1Yshz5qG0EqPgyKWki9tQSrP65VXeg8Ris9yyoLgwP
         Zb9eJimVpLB3T+Iw8Zpax/RfLeIyQeAndDnqLbmKN3F94avM19D5FNwr8B4r3O302yVG
         C6BSleIa7YjafQSwy6kDiDZppTYrta1kQHHlnEUzGVy/OXl7CoS0XLNtESCHUVoYZYgH
         zAG20YunnRJ5qZtoTYmwF/nfCZixNVuDDidHipHUyQ2Wt02GtTvN2ieKtDpcfVGWjUue
         yV4C2dkyuq0PMoP0MHYcRuxZpQ6jU1WeGQ2S8LTMC35a01Cv7cUXmhHvOnnKYF+dsFLN
         5u8w==
X-Forwarded-Encrypted: i=1; AJvYcCWqA0G+AVjSwC3DrjrAb6dfECsByAEEet9+4eXeMHwNmiekiXdGeqvgnrinI4xAze8IwmIMtJwrg+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8wve0Mk0BjjNNHyVeLU1lsRMEHaTEvpb1rxhDKYaq4s5+ZonB
	blFAR88oXv/fVJJpsjLqgYVGWng533FjpVhoJBXBnz77n4GDEQv7qU8A
X-Gm-Gg: ATEYQzymdLJHO6lMACVLDHt4cr8LqWWZ7GE3an+/7nXPm276ZKe63/7415dTd18tGqJ
	j4EH0FoQWV1XXl+eVyiqHmtkIoU+Bz5DjChwv58wzIXIMvwmkwHj0bL3W0KJWRDhY8ASPxmdoCh
	aESr3vAkOsKklxyCZ76L3bGdy/WObNPIkbMDbvkxF8B9VtM58goL/HtKr+IOq/Gd4VOH6nCBczV
	TNuqqjiZHj+qL4DPTnlWgLt9LhECBec4evnX5ulSC3DyK/coOAvgDINvxfLgoIFTJBbNGk3potX
	PL0gnZF+xDbELiuuALPy9C0o2wQgIs/tLyzHVqWvOgFJo/yW7Lhf61jd94ohobKOdrI3CSsN8bS
	smoi4yoVUVT7mNraiHULim0f0Gc7lc/lU6rUV2IqkaiwFmqav3jGhK+/9IK5OtMuMRzSsIs9V9k
	AeUnC9K9ue5D8AvaiNL13RYVvkboossG4RnYSyrLpvrbQhdqW9qwV8HmhOO3fLJEJ7++j+nvuDj
	cVB0eGVvw==
X-Received: by 2002:a17:90b:35c2:b0:35a:3e2:7cbb with SMTP id 98e67ed59e1d1-35bb9f2bf01mr6280190a91.29.1773929939183;
        Thu, 19 Mar 2026 07:18:59 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc63286ebsm2695321a91.17.2026.03.19.07.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 07:18:58 -0700 (PDT)
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
Subject: [PATCH v3 1/3] nfsd/lockd: Remove redundant debug checks
Date: Thu, 19 Mar 2026 22:18:44 +0800
Message-Id: <20260319141846.78222-2-seanwascoding@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20273-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.835];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 6392D2CCCD4
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


