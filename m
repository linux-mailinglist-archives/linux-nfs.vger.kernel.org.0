Return-Path: <linux-nfs+bounces-19419-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB3WHyy5oWkYwAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19419-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 16:33:00 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F28991B9D8C
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 16:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3D99305CD10
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F729329E7D;
	Fri, 27 Feb 2026 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBoadKQC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237E2472A6
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206017; cv=none; b=rq5/oaEfaNRzi+a+dkmj1b7NJ9IwWTrmkh8pATj/ztEry6yyaUZdkJXefJCRg9gc8sHn16ln1voo3fBtU6o+BCS4msN9/9uLEAqdOCIzimEcrX1GuaGDVxwqN0h4DpYfhebdtgL2s46Y1gGGjFacXAWej/8+2QF3k1ucy8ooHKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206017; c=relaxed/simple;
	bh=KH38vAbUG91j18z6rOjdMD2fAX3Mmj2nRTot2I1wbL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lpQIi9jw8KxjH2vH3llJbv2bZDvhw+AcF/JZAKrretN5+X08/OpbV7mbM+qYeDRGpoFDyCsv1Vz4RM73DzMNumpeB/tSehvLW6GvpcVTPgyaksDypiWS3fn7pYiVydYfLjVnJ1WmuoNHnEtLnBzWmjlL8hufVHT7PSLkfMp8elQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBoadKQC; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-358f3ef464bso1210397a91.3
        for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 07:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772206016; x=1772810816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0tbDXBeKezMjzIv1CEH1zzav2roQ8v1QT6xHrnaf4M=;
        b=ZBoadKQCHwlbLAEiJjqxPNtgQKLj8iczlHlVZ/Hiadfpe5qW3/VranHjhAW7b+MvSA
         dHaD0XgIBxekREJqlDmgCws08oh2zala6YmnKs+3pfsC607sBtIskXoXTUenv3b9TrRO
         WCWSahn2Yenj5GkrUCY62jkk+hU/sUSXEBKufNvfBll5RBMUm4wZPnd5GsBtorO3N4Xl
         cyCca3Sc79YkRtMCcv63o6epF9VEs/dASl96m+zg7Rn2L/Tp9VZ2qECRis30YBO8tQHA
         jv4J5YL1oDayDq8izT2M+hYmDN21HrG/3q79P3Qfe+rb7rFu4GSb98wDCtT8fIH2Zgv+
         rqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206016; x=1772810816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z0tbDXBeKezMjzIv1CEH1zzav2roQ8v1QT6xHrnaf4M=;
        b=JknxcS7Jyla7TwlHflVt9tWPrBgmueVg9HQEPJ3s7S/NRsQqJSc8nnHWoI/rZiTv1u
         sO32ukOkvR9hHpAIKpKqbA/b0yHKa2e/W0A8bSk9E4dpBdeFBqrzr1yDLhB78JiQ4lgX
         5Au/mXMfpEuwZuk2gz8A6GHvaujSU2XZzgFmZqRXvieJIGBhIZi/vrFMAza2TIIvfz2p
         zYBP2MJosmPG0O3jkeCvrc5FFT7tTA3pGLj62G58OcEVxeTmgXQFrhDwGc4PBsIinDmI
         v+sIKocgymYIm5VrVIKXzXIrsIlOqWuOjloKAmQ6VfT1S1GAOKvBaOUq18RnQGDcnIHz
         v//w==
X-Forwarded-Encrypted: i=1; AJvYcCWcT457HgJI00spPbi63Kl/i4qGSFCL2N8uDbVwZ9Lsfayyk2OSw0zUKWbphII2TM7D7B3JHVDsPuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0EnZar3vJpce9MmQlFp2F0ghc/BzDZrncIhvWZpgGjRlL6rqq
	5G7N5krtQeOHTUIgo/1+kDgwppA+vFUE/2fKNQxZLN6RFJa0PBXnMlbC
X-Gm-Gg: ATEYQzz7JJev408pihc20X7U0tWiZH0AaTdFMDKr2l1w+tWFVeLI4cP7WNQfiHetQhy
	HlT6JmxzOXvBWWJ1rGMSQRZ0QC4ElsUiBwTFRSAovQAbyjxOO6CTHR+tR2hNDrAyKYKBxxCnPbl
	uT78LNs82rU0B2pAWkd8eqV+hsfYF1/8VhpOG9BiA98JC8Gtv8HmwvLhYseTY2HDYWAIsEHLA5H
	F9G/eMwjDH/6h0vCpEL4G+UeaFOIIIBRCi9tRVsk7pBU6bKGutQkpJ5DZXVcKpEQnXj7oI3l7z6
	IjqpPA8aXnpuDtQNea4AwTSKaUdN1enkJ7FVuln9ZtBIoCH/tE3X1LQupoMM1mIT4gLs67kJcbP
	Cn7poscdQvdL5L2wDvjTDAH48S1vzyImWh7OhEQhezs2ihsdkC5og596EqUYhwI4lmNDJ5yWo+n
	88eBUpi+DzxUckL4at+RLBiUWOey962yZf00fcjwxfUV1DEC7WHrOwy/NHsCu/poMdar8J
X-Received: by 2002:a17:90b:4b8f:b0:34c:fe57:2793 with SMTP id 98e67ed59e1d1-35965ccf181mr2879013a91.20.1772206015655;
        Fri, 27 Feb 2026 07:26:55 -0800 (PST)
Received: from sean-All-Series.. (1-160-203-78.dynamic-ip.hinet.net. [1.160.203.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35900700e69sm9053211a91.0.2026.02.27.07.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:26:55 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v4 1/2] sunrpc: fix unused variable warnings by using no_printk
Date: Fri, 27 Feb 2026 23:26:23 +0800
Message-Id: <20260227152624.164964-2-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260227152624.164964-1-seanwascoding@gmail.com>
References: <20260227152624.164964-1-seanwascoding@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-19419-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: F28991B9D8C
X-Rspamd-Action: no action

When CONFIG_SUNRPC_DEBUG is disabled, the dfprintk() macros currently
expand to empty do-while loops. This causes variables used solely
within these calls to appear unused, triggering -Wunused-variable
warnings.

Instead of marking every affected variable with __maybe_unused,
update the dfprintk and dfprintk_rcu stubs to use no_printk().
This allows the compiler to see the variables and perform type
checking without emitting any code, thus silencing the warnings
globally for these macros.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sean Chang <seanwascoding@gmail.com>
---
 include/linux/sunrpc/debug.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/debug.h b/include/linux/sunrpc/debug.h
index eb4bd62df319..55c54df8bc7d 100644
--- a/include/linux/sunrpc/debug.h
+++ b/include/linux/sunrpc/debug.h
@@ -52,8 +52,8 @@ do {									\
 # define RPC_IFDEBUG(x)		x
 #else
 # define ifdebug(fac)		if (0)
-# define dfprintk(fac, fmt, ...)	do {} while (0)
-# define dfprintk_rcu(fac, fmt, ...)	do {} while (0)
+# define dfprintk(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
+# define dfprintk_rcu(fac, fmt, ...)	no_printk(fmt, ##__VA_ARGS__)
 # define RPC_IFDEBUG(x)
 #endif
 
-- 
2.34.1


