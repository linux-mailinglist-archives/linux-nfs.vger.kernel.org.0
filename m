Return-Path: <linux-nfs+bounces-19481-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNvsAppmpGlcfgUAu9opvQ
	(envelope-from <linux-nfs+bounces-19481-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 17:17:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0511D0905
	for <lists+linux-nfs@lfdr.de>; Sun, 01 Mar 2026 17:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D77993005D20
	for <lists+linux-nfs@lfdr.de>; Sun,  1 Mar 2026 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF5030C602;
	Sun,  1 Mar 2026 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyZC87rE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1540F1E7C12
	for <linux-nfs@vger.kernel.org>; Sun,  1 Mar 2026 16:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772381847; cv=none; b=Ltecko60rcKFJ9TO/7VIv2JK+uIWZ6CY5rnWTkuwan0wdOp4NFxOrh3gQscpM20TcU1FrZinbrc28/+Jhyk2IC5Xx8NNDS/WWGP0qF1nPGTqb9aj0fuHcxxINN9evmXX8PAf722cTrfogCMu0m98AUOsLf69VA3REcBzAum5ti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772381847; c=relaxed/simple;
	bh=QfrtzPBTQgtN7q9STXng21AoBcTIYcmlUXaobTZcOIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ggH9aBiFSq8wSyZEc2tLo9/aK3TDRxaF4EuKWwz4nPRQVsjY4frqpvlK4a7N6Zmslruvqq79ticaAAEWGfErxLaBoYjVN5EorU3XqzhINedK0+0XJhp2Z+X814hIxjzdnH3KjPjqlSKNLSgpb54npeK5hIUdC/8r9Qi8l1ytZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyZC87rE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-824ba8f0acaso1857518b3a.1
        for <linux-nfs@vger.kernel.org>; Sun, 01 Mar 2026 08:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772381845; x=1772986645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Os/820D5KUwvVqZOLIPxhxLinek0g8TJ2GUPXHxbYBg=;
        b=LyZC87rEguhRUNISDEuez7TmCfn3ENSNUAXPibV6FvEPGdbTp+rThaqh1MkOmv1mVo
         CR+DSRkGOYGMIaknOCqX6J7M1efzYAJ7JvyXq8N2OfBcVm1unUJBieNxoIWHvM5SVgXY
         9UHgONz6jjiVMGaHyjnb2KMpv5hmAR2vx1ijDFaqjY6JCdXMJG2DY/Sk12tiYmczji1Y
         54uBXyUGAfvWxgLhTROcPqMa0MPyHPcEZd5qR+4c1GxzwQ4r5CP+DGVnCcENcwTISd0I
         LwEC5Prmgh0nx3nqHWVPZKPKoAlkZwm1PGOVU4TZNDmjJ475jyGzA9ECAfSgvhJEe60n
         O2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772381845; x=1772986645;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Os/820D5KUwvVqZOLIPxhxLinek0g8TJ2GUPXHxbYBg=;
        b=cLtL2WJsxaHx4+NwU3Pw4dV+Vc4PTAIWtFdnhjbGyozYCtJrJFrvJRT0zx21Zm70Qa
         heEJFymMQW9WhbuaJ4X17K0a+rxkZkn86wepT8ILBXQKwW4+oL1sZnaEn83+Q7LF1eun
         8myVgT3cBhxGKju7NN6sluI3fy03DgEA7MWntnrqir1XTtAbKodGroZaMX1LbEJOnp1a
         AeSZOWkcTySx+S7Rhd3kvkNuT+8vqsHQA8a1g2XicTmhuxqwA7lxUJ61vvfqlW1QHj1h
         wDUuxKb4OntVePWzgO5etP93f/A78VwGOLxlfBGHsD8A3M4w8QCJGhu4qCa0+ITyA0PD
         /mzA==
X-Forwarded-Encrypted: i=1; AJvYcCVy9P/OUZy9Zj0yLlKFZaIlz9+gZYDFQ699bcXmyy+Im476IxyBREqBYu8P74M68DgtWmKqHUvt5fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLxrNP5ZZodLEu0qT1z4b9v60jnoa5rP1+sQ02x4L5Pf0Qqidr
	xPA5q8pxb7o2OHDUkD6EOrfdKSGfGkmu8AOIHiT+OpUP8kvBuGV/Bfsh
X-Gm-Gg: ATEYQzxmWs3hAEFJFXUF40xKLJPB65lKCVqxqZ8YQ3amw3p+0h9VWqtGzS9yQKjX06a
	bOX2OrlJ0++HQq4X4SZjO6dfjriqu+w7pLNnFUkKpOcmmlkm8vq3nryVZIXaSatabQdBf46nmBE
	nTjqX3HhyqE0icwkgGhfcknKJBJQPGBIg6UawKZNpVVBP2hUGxNc9iSkSsdNva3k0Ziua+NBWEa
	u/UehpSTFqhpmcXqHfAJpryKs8MrQBrmZTdlAsPlOk3TvcEOaPzhACZJug3tMmpRpHGSD+hinVw
	fZTzoDNxA954fc41hrDpz7NkhHUptMK+/xwxxQNFjTUPgkcBVrt5I9qb3qcxCTT0avxnFiEOhm/
	DyD0B2ZD96VEM3/lRCs4fMUQy14tAdHqkxjtpUaYqzGi2IDz/716G477ARV6Gq1Ew7BogiyzXgp
	NnqjYfFbUARhCPOywv8qtxw+G9TdJnqDLJR4HDZaRYT68Yxz+tIJ6aBOX09v3AjJoMU8B5
X-Received: by 2002:a05:6a20:cc0b:b0:38b:de3d:d542 with SMTP id adf61e73a8af0-395c3af081fmr7302665637.51.1772381845303;
        Sun, 01 Mar 2026 08:17:25 -0800 (PST)
Received: from sean-All-Series.. (1-160-230-14.dynamic-ip.hinet.net. [1.160.230.14])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa61fcdesm8651456a12.11.2026.03.01.08.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 08:17:25 -0800 (PST)
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
Subject: [PATCH v6 0/2] Fix compiler warnings/errors in SUNRPC and MACB
Date: Mon,  2 Mar 2026 00:17:07 +0800
Message-Id: <20260301161709.1365975-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19481-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E0511D0905
X-Rspamd-Action: no action

This series addresses compiler warnings and a build error identified across 
different architectures and configurations.

The first patch refactors the dfprintk macros in the SUNRPC subsystem. This 
global fix silences unused variable warnings and, by incorporating 
no_printk(), ensures continued compiler type checking. It also includes 
a specific fix for a build error in nfsd (nfsfh.c) uncovered by syzbot 
in non-debug configurations.

The second patch fixes a format-truncation warning in the MACB ethernet
driver by ensuring the snprintf output fits within the destination buffer.

v6:
- Instead of wrapping dprintk in #if blocks, completely remove the 
  redundant RPC_IFDEBUG() macro and associated #if guards in nfsfh.c and 
  svc_rdma_transport.c.
- Remove the #if guard around the static helper nlmdbg_cookie2a() in 
  svclock.c.
- Verified via .lst and nm that both variables (buf) and helper functions 
  (nlmdbg_cookie2a) are fully optimized out by the compiler when 
  CONFIG_SUNRPC_DEBUG is disabled.

v5:
- Simplify dfprintk and dfprintk_rcu macros by removing the redundant 'fmt' 
  argument and calling no_printk(__VA_ARGS__) directly, as suggested by 
  David Laight.
- Fix a build error in fs/nfsd/nfsfh.c reported by syzbot. The error was 
  caused by a mismatch between the variable's lifecycle (defined via 
  RPC_IFDEBUG) and its usage in dprintk.
- Add Link tag to the syzbot build failure report.
- Update series title to reflect the general nature of the fixes.

v4:
- Refactor patch 1 to use no_printk() in sunrpc headers instead of marking
  variables as __maybe_unused. This provides a cleaner, global fix and
  enables compiler type checking.

v3:
- Expand commit descriptions to include technical details regarding macro
  expansion, as requested by Andrew Lunn.
- Test the different platform, such as ARM, ARM64, X86_64.

v2:
- Split the original treewide patch into subsystem-specific commits.
- Added more detailed commit descriptions to satisfy checkpatch.

Sean Chang (2):
  sunrpc: simplify dprintk macros and cleanup redundant debug guards
  net: macb: use ethtool_sprintf to fill ethtool stats strings

 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 fs/lockd/svclock.c                       | 2 --
 fs/nfsd/nfsfh.c                          | 2 +-
 include/linux/sunrpc/debug.h             | 6 ++----
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 4 +---
 5 files changed, 6 insertions(+), 15 deletions(-)

-- 
2.34.1


