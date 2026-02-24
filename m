Return-Path: <linux-nfs+bounces-19180-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGAPNBranWk0SQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19180-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 18:04:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DDF18A43D
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 18:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90EF631E2D63
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 16:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB5B3A9618;
	Tue, 24 Feb 2026 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjbWoA9b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84563A961E
	for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 16:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952103; cv=none; b=UTZV4tCOZ15ygrrUggOzaJ6d9s4WV42v2n8e+LNbipsFqBZJNdj32F8j9HEcI2OAQkoXs47Y3edIZmcoAwUM2/uUJOKoLWepSPFTgGmEtnmiXJbBMDvfzqMmwQcXV/jmQf9ObC/V+CmRo7Yunmzqjq+i8RuMr5H8JL/lxuLWQxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952103; c=relaxed/simple;
	bh=Gev4JxKQDlXRqalOeq8zqK6EMWuJbyxdWEwEhnXRylA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=koq03UAW6Hy/mR5pzDUkFN6i7SYIGxeR37D+TD1mYSHtPNYr0DUNe6ht2uzBRnDL+LCx9laGgD/GzENL6pl4roqaSI73wBcxhRWEPPwB7qbTSTBi8C0ySSBQcZkk8yus1rDZ+2wlZ6b6WCQL3SoHSToWUo56/t132HskR2GOm1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjbWoA9b; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a9296b3926so40506645ad.1
        for <linux-nfs@vger.kernel.org>; Tue, 24 Feb 2026 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771952101; x=1772556901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zkJVNfBlJNbQabv0Sb5iZABOR5GcPOWmUOF0eD8AXjk=;
        b=RjbWoA9bagCIOUeCSdFDM7PY4LPNwuA29AA0oGlrfM2NZCxy292I6aAfwIHAi8wqzL
         O8nsswTCwkOc98n9pnkkv9tt4U5x0sA59tI/1PKAYWifgwDqUoMeEjDGPhUrDTu5zsIb
         F7FnZL8A825+8U16Ixr58afqrR5fJi4I2RUBj67ztvvgNqnIMsZlXdY4iRjQzRfmMGwz
         VlQzKp2EB/Cc4dXtfAsc48Z+/nYQtrmsKmgDsM3pyzURlDdEqwMPqKD5eeVxh5gQLZ53
         KfOslsC0aSB7HQPfzGS43xrJJ4hXmqElML53dl8DAA3Xx+tgUMM8wRWkpRzqfYzOcvei
         /7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771952101; x=1772556901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkJVNfBlJNbQabv0Sb5iZABOR5GcPOWmUOF0eD8AXjk=;
        b=ohYpFu9/f89DPD8WN4qc3cw1HYHGnG6zhg8PTZpMbdjBCjFMkrUiP8n053IpoZOl60
         /+6oPJxdGOaqTWUGRitEJZFxk53pVVLRaPAIhT7wEvIfCLABtFMCdd8q1Kq6dT7Kqa1C
         TW4NytrhMrCfSaDjgwHONstkkdK6Cc+pCT/FiEMxwqq3U4xzZRSJSIojZyyIPQ1OCpL4
         aJIladZkr4I8H7gwhpHCiay3JfRv+CQjMpo5w8mqVTOZE0QlvFCcklw8yeOUCZNoqqiB
         ea9Cr7Dfeu5R8u8mHtqoIPx+cPnw9IS7oryORsElGgUl5KBvmpe7BMbD15y51zuFCJpW
         GUdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOTmP+B+DR6ExN7FfNMcpFjESDQ3iHkCUB7jR6QviilUGmcQocWkTvl8t9r6kCA0vgqjej4FFEWmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnrySUruJw1aSJgoL29JwpMHjLrSHJyYyKMja1L3KZCWDh5Ozd
	XRQJ64sDnLB1ls66IWMgCk0Gv2OIh7L7tm9S8Nv3CIyt8MZWPE7v7fZT
X-Gm-Gg: ATEYQzxAlQrFCSXq6BNJ80kmrut8C19ugmaHZ5Mm41NIZQtFzwdp81JXs4K6eA1+q/H
	zayXcOBg1tPKsRJWJC4+iok5DXvcQr8Vmo69N+HJ+dIEUMd+MpXB5+upxHQ3EhF16YdKwYnX1lu
	6ckv79Wo8Btp7cLlemGQurySFB4ngNWTxEx0roQNr3YjvO/xnd5apfQKvsQYAZRUamgjROWeMcl
	a4JCAJB0fGOtzlWTvhRWIyiWUfDoZbplE/pS0P/GjCDHFlrsD2EY4EL72WYMoxpCzyP/UPIJOip
	RAkpISQ1tHe7ALpwGxrqf/jBpF4oGop9I+Up/YQboTfjfD+FtFUFJ+mW07ehCv3nMVvHX6sHbWj
	Gt94UvFXzUUKNZrmA5oRU/2kIrbe63hI/0fppHlQH0btcgNdUzhaGiK5yqqXcqVkKgPrWUUmaYt
	vbM6xDOZ22Ces5c5ygzhV771q0LNyAqqIshpQdOUGTrmZz50VIWS5NSeSysYSbrjWvBuFAOYcqo
	A==
X-Received: by 2002:a17:902:ce0c:b0:2aa:dee9:dcf4 with SMTP id d9443c01a7336-2ad7447b9a3mr120365845ad.25.1771952101133;
        Tue, 24 Feb 2026 08:55:01 -0800 (PST)
Received: from sean-All-Series.. (59-115-199-112.dynamic-ip.hinet.net. [59.115.199.112])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7256f32sm12364083a12.27.2026.02.24.08.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 08:55:00 -0800 (PST)
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
Subject: [PATCH v3 0/2] Fix warnings for RISC-V builds
Date: Wed, 25 Feb 2026 00:54:33 +0800
Message-Id: <20260224165435.17648-1-seanwascoding@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-19180-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67DDF18A43D
X-Rspamd-Action: no action

This series addresses several compiler warnings found when building the
kernel for RISC-V.

The first patch fixes unused variable warnings in the NFS client (including
nfs4proc and flexfilelayout) that occur in certain build configurations.

The second patch fixes a format-truncation warning in the MACB ethernet
driver by ensuring the snprintf output fits within the destination buffer.

v3:
- Expand commit descriptions to include technical details regarding macro
expansion, as requested by Andrew Lunn.
- Test the different platform, such as ARM, ARM64, X86_64.

v2:
- Split the original treewide patch into subsystem-specific commits.
- Added more detailed commit descriptions to satisfy checkpatch.

Sean Chang (2):
  nfs: fix unused variable warning when CONFIG_SUNRPC_DEBUG is disabled
  net: macb: use ethtool_sprintf to fill ethtool stats strings

 drivers/net/ethernet/cadence/macb_main.c  | 7 ++-----
 fs/nfs/flexfilelayout/flexfilelayout.c    | 2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 3 ++-
 fs/nfs/nfs4proc.c                         | 2 +-
 4 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.34.1


