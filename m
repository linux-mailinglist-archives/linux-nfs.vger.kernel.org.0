Return-Path: <linux-nfs+bounces-20304-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE9EFBaovmmKVwMAu9opvQ
	(envelope-from <linux-nfs+bounces-20304-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 15:15:50 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B03552E5B7A
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 15:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6AB013029C3E
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 14:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EEB38C2C7;
	Sat, 21 Mar 2026 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElvlnFZx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29838C420
	for <linux-nfs@vger.kernel.org>; Sat, 21 Mar 2026 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102532; cv=none; b=WE0bwWK/PI7WPbtaUq5m/yHztCqXSGqQ/r8JcQ7zHdQOX1w8YL+By0IrnPT/KqwaJHf+rbgUHWHyduCJkrmU9f+jxMz3AolnhuTcUkNJDBwskj1QlplVndCiLNT9wMG7xYjMxheyWUkllqrzoTNfIDW2HmYTH+7YY6OycHdniVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102532; c=relaxed/simple;
	bh=su0qCKHnq3PtTnb31b3a9kZUX/DqBj3yiDnEaH4YW+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZC8Nl3cM5k6+anzB9aIPN09zH2YLuW7+n7rIHvw1Iyo0OX/y0N5glcKPXuIxbKfZiZ8qbKBNdml2XS8FxbHPCtUpow2v0vjoP8S7+xNhnAxA/QrcJpKWPh9sCvOEk0xYcTivg5bHW5vZC4OnAExpj9s6rOqmh++JIIXL6+iaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElvlnFZx; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c739561f0d3so1169987a12.3
        for <linux-nfs@vger.kernel.org>; Sat, 21 Mar 2026 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774102530; x=1774707330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md5Ntsc0rRpCFPPT7+6W0Dr1q7JQYEVArLNrJ+0AKc8=;
        b=ElvlnFZxfHz5IsE+NIiieqyp1y4CUanqpL/+VmxRX6OTwgIjWefOg0hW5NAactrtJF
         T8IdcqwpM/8BksWKAkKgyruUo2emVsOxzYlqsJ3DT9r5u2hYhbgqG7nbfFRYMP3NoOtD
         v8rYJxbTDqGhduY0z3pwsBTG5svvZMxjMQ3yOYFp4aDzElyuiKDvnbj2tjOw1XVzj6tJ
         qK4hWYEMQbL49rP81NKLLdgZVoWZHwl4BerJDNxXN1j3cypmiBZro0f+t2XiHHf5Gkh5
         1leArEHlElBEFf0jJNgsnUSqYnLO1IVbQp1QSKiI3vsXK35MJojhQ/aWXocuND4a69Yr
         nsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774102530; x=1774707330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=md5Ntsc0rRpCFPPT7+6W0Dr1q7JQYEVArLNrJ+0AKc8=;
        b=CVgybfzw/1uu9tE/JqXaHBlJ+SudICOzDAmML94VbZIzbiNWFUvYv79UNHN8KsUhwm
         qL68Kr64amfGeaS7+OxYUzF82DjD7fpbENhL3shwvX6JsKuPU4fXKhwimIeDvbxJc10N
         Sb3pseAO19vUkr4tRGw2WW517ulk52/cVEIzYoTJMmCM6SMDW8QplCk66IUeOs+cc5QU
         slZFsZjJXaRxqlQQc6B+uCQ6EMccsq5v+SxKfYiCEWd1b7u97UYGJC+/0Xxw5iUUs0Oy
         IVbPTKo+NNgFjCw8VgJi4VSP3hwcv1EF+vtVb7DX7CQti5O678XZw4Stvhrsua+oDblw
         eDQw==
X-Forwarded-Encrypted: i=1; AJvYcCVzcGhOhor9UMGNzi1U+3a9COx1EpiuSTxx+OxTDHnYpMxn7b4tukJ0DUs1AHWAcX/cimb5MCbVl5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdgpiUNJZs8TnLilRbzQIDiyFsRslBAQjz3H3+fi2XNQ8uGrZF
	NHP7ppFM0kpqmOym+TaNjh384BldFdU+CYM3SLaHR/IO872x/lszJKZm
X-Gm-Gg: ATEYQzx30cv3B1H1OcyuW8kbIc//F94b4St3yxwoewaIfIrl8o56XK61YrxXnJlNspj
	UakZcRbi8Uuyl9d1Bj2q8n6As5uijPp+tu1z0OIe016ZAMn0dh3SN4XNirezOfcnI08/wxiGFv2
	lZJtRQpklh5yk3z4JhtYH3+vg43KAfQO3QwehI422rO4fwj3NhonKCI+HlixLBjQXi5Tu7ZSerE
	7Rbx5SC7/qBVjYEOcyhfidlAjmSIO7X8OtfErRMLQzp+mSkNZCfmINjFowiS3Ad+pRQOw9wGNwl
	nXfM0465uNwJNMaSAWQ7j1jphFJ6Epeum5qiWo6iet97B5tVo7M6foK4ShVj1QWuScWqg+A4Dgh
	PT733v5BbnWOQzwTkPadEnx8afNi5kX2TdTxDtx7Hi7h7k5gk44q+FFBUpfAWH0ZQfBISMX/YSc
	upRD3nE0a8v0Y2m5FmOBx0EP/cDmeDNHvN4LZGjQKO9jXtFL6u2UrsYB3CLohz1PIPzP3gfRs=
X-Received: by 2002:a17:902:d412:b0:2b0:5fbe:130b with SMTP id d9443c01a7336-2b08271d707mr36438375ad.19.1774102530024;
        Sat, 21 Mar 2026 07:15:30 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm52680715ad.25.2026.03.21.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:15:29 -0700 (PDT)
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
Subject: [PATCH v5 1/5] sunrpc: Fix dprintk type mismatch using do-while(0)
Date: Sat, 21 Mar 2026 22:15:06 +0800
Message-Id: <20260321141510.68214-2-seanwascoding@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,kernel.org,intel.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20304-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B03552E5B7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Following David Laight's suggestion, simplify the macro definitions by removing
the unnecessary 'fmt' argument and using no_printk(VA_ARGS) directly.

To resolve a Sparse warning (void vs int mismatch) when dfprintk is used in
conditional statements, wrap the non-debug definition in a do-while(0) block.
This ensures the macro always evaluates to a void expression.

Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 include/linux/sunrpc/debug.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

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
-- 
2.34.1


