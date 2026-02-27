Return-Path: <linux-nfs+bounces-19418-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFu6KQS5oWkYwAQAu9opvQ
	(envelope-from <linux-nfs+bounces-19418-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 16:32:20 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 290111B9D56
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 16:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C401731286A4
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88AA41C2FB;
	Fri, 27 Feb 2026 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hihaAwzv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B333E2DA74C
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206004; cv=none; b=bvXGypNeOIw3LxynsuUhyFedvsXFUrLFB3wu4YSufxYCKYvI4Yz8AavafLvV+dqUdXSQ/Q5qtqwDIWBgGKXHUCCdHRpQqqsAyWDo3X0yuhkLGbBIAetd78WdHbGyjyw7lXZs7oySl8qNESURNHolwQStZonZ/Lf4xyShTi4qPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206004; c=relaxed/simple;
	bh=nB4dU5ro4rB0p1psB/tOgNtIOVTU8bVlg3/4Kp9rrRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HYReXvwQAY2BuluAEQTn8BnE/EFhmewsiPPMoFJUgNP6D6ERVVvX3qZzRXo4pY3DW0qFUahC8NmJq8ojwHf5+JHqs7anVZyk6EgXRcK2WinMYKl7qhUF8T4y9p6U1Fl4CoKNHdBG8c9aGkihH9VlgNqZUOq2TVnQiAIMOicGFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hihaAwzv; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3562e98d533so1159055a91.0
        for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 07:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772206003; x=1772810803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UetmJfyt896bziHLm83oQ5Y9tswodav8qMkgJQV6wLA=;
        b=hihaAwzvjQqo3nkDiM3b31Iv3mE5GEJwj5l/yTpAzoFQSbbccHT9cZPBmVuilOKrTR
         hvzhYzNwq8/JdmWkkNKldR2BAiGXp5d7PYZSHNdQNBqr9mUizmtdIefp3JbTq2EwtCDl
         S2lv68D8O5bDb6jnk7upw/9XFglHTn3jdAGgFF4apH0zN0HtE6W+jp3tI70MdsuyEibT
         M51y8m3mCJN1Ky8uL/O/E3vtIptwNfG5d3FJNIUm3O9lJV0SvDji9fX8y/7UX6tGL1md
         KtI8xGQDOPakcuH5qSVEFxATapfYf9KofmkF/Q2ENGtCLmKoHuoKJyKeEoZjNyVT8ZVe
         g2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206003; x=1772810803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UetmJfyt896bziHLm83oQ5Y9tswodav8qMkgJQV6wLA=;
        b=w/GzhFSXGNyqtInujzEEZw9bZuEV8Z8nKIM7KjRkwIO3PLfwZAnKYhifa484pE3WF8
         E0stxaP6di3WvbkxxTc4VZu+RjyIx0fI0k2PDfNoyFeiZ7Wxb3GJ34WF8zaWdgnA4Bi1
         lKz+qY/qsZZgPFKZndqnL/24/HjAEFqiLISREcWrDGj0Ug6euSOiKYrhmMHbV96dNYo+
         ddK3FomG8ZBhOi3cktlju0Ws+rIxH41LILTkQF5FKqmihicecmp2jbZ/ewTNAVTO98vs
         kVciYv8s+s19tUr1uDFkydY86HQ7E2kDU5JwcmXiSYdp/X3HniqddWseBR6OSM2df6mT
         XaAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvtX7RqvOZzKRkaMcx1dNfJ6UukaDzD7bnyh6dusC0Or3sLsIbpTxpjMnQFSfJOq2dfbN+INgFDes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDB24ak3CPS1jetJQbUn14YrmT7XnV/QDFuflBsvL9FzdQYsQL
	nZBQSTQWkTf3sMsGvAQmhOQ6f6Dcs3L0/YoGnMjs7i/o4PF/aCeh9C34
X-Gm-Gg: ATEYQzxv4fkKpq5PEw706ZVzIh+oDosIdQndt38qs/srohXHPn/W4gC1DyV+msn+daA
	fqt6D5E5ZO+G6n2gquOZnCeb+mc4BrEm+0dzBUnpUVa9I+OWaIXwd1BkUgoKqpkgDaWnxpwHVPp
	IyP0ZKAGaDOfpnLmU/YoYWMog+Pd1LyrQqMNoR6PHhPd7zzJHWTohkz4sjYP+3rQqGCAldL9T9a
	Bz3c+ptr5LuBWZuxXNdIv4azqBHn2xCjk97eFqMRSFFNpRaUEEfPOggzeMUGHQx0UpDmZcnLQ2c
	ynCYCy3PndCJWE8hkD8Sw7zg/W2mAV4He7fJ+SS/dG2yEnuymaCNlX4r81UasFmrYitsiWRsLJg
	yj0/YQktQIsYU1LJFM0Ou5aFJotdrkHsCREPaKhy6QlHW4VItkUQkOs0L8KD40YgtAGA/VeklfG
	CU4IkK2CwxcCClFPQxFYv6XaYndvK/02ERyZu+qa3/z0AQSWDKCqTpdDkOc0GD8tWzVjq5RWNlR
	33nEBA=
X-Received: by 2002:a17:90b:3f10:b0:359:5a82:5f98 with SMTP id 98e67ed59e1d1-35965b2fec7mr3609795a91.0.1772206003011;
        Fri, 27 Feb 2026 07:26:43 -0800 (PST)
Received: from sean-All-Series.. (1-160-203-78.dynamic-ip.hinet.net. [1.160.203.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35900700e69sm9053211a91.0.2026.02.27.07.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:26:42 -0800 (PST)
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
Subject: [PATCH v4 0/2] Fix warnings for RISC-V builds
Date: Fri, 27 Feb 2026 23:26:22 +0800
Message-Id: <20260227152624.164964-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-19418-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 290111B9D56
X-Rspamd-Action: no action

This series addresses several compiler warnings found when building the
kernel for RISC-V.

The first patch fixes unused variable warnings in the NFS client (including
nfs4proc and flexfilelayout) that occur in certain build configurations.

The second patch fixes a format-truncation warning in the MACB ethernet
driver by ensuring the snprintf output fits within the destination buffer.

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
  sunrpc: fix unused variable warnings by using no_printk
  net: macb: use ethtool_sprintf to fill ethtool stats strings

 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 include/linux/sunrpc/debug.h             | 4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.34.1


