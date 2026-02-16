Return-Path: <linux-nfs+bounces-18947-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNuVF/1Yk2k73wEAu9opvQ
	(envelope-from <linux-nfs+bounces-18947-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 18:50:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A86146CBA
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 18:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D8DF300638D
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Feb 2026 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6112D2D7DE1;
	Mon, 16 Feb 2026 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHIM+zS5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E829AAF7
	for <linux-nfs@vger.kernel.org>; Mon, 16 Feb 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771264218; cv=none; b=soSUIOy8N2iSpzVKPVtt/aV0GG5gPHXaoeO3cxZ0aAGFsI4+4Cl320rKo9XdcodPgqnLZ4Gm/wNOg+LgvtELujp+LC90DQIrpY0m+N5ThFccLuLyUjkYLipWu/MNc4JN0m9jnTdEslZMMXf/uaMHPqBNY9uatrT7H6rJOiQyiv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771264218; c=relaxed/simple;
	bh=rG/47OfKUebe4WZWFUbfl2bEO8x/XP6C0M6dGxqt6jU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gIBmIxFVpo1dcPY4QIYq1PsEG+UYKqlKGRapJfZiddFN6Yed41qEcZ7hS8S4T81/g6s8wncTzzAX6Ak0dqGb0caoESwb3tn6pPFA9qAfaDIsPIB2xzQ3x6UgUf8ctusf45bR48bCM3vYnaS/SS523yfmBaeNQpml6qMQ/15xFEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHIM+zS5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a7d98c1879so17860605ad.3
        for <linux-nfs@vger.kernel.org>; Mon, 16 Feb 2026 09:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771264217; x=1771869017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4v1fAIra7fT95ebg+6JoHH+N4Or/PJb9vOIc+JmSiXE=;
        b=aHIM+zS5vkzL+OPP+msc43lFmD+dALVOk6Zvg6FgnMwc5CffAa2rbzOMIDtrmAVTxj
         vdAHZsSOHXqlWxVkTcLRsD48tO147fmmmldv4erK7sQvCH/obDg0EJP/yTHYcL+2O9Nq
         nul8tnI8FTqiV7TJil1Ji7YhTF/RejzyG28S6cFr/uFiOQK3YeoIwPpj0CFf2wEj4btF
         ZKiO2/8uiZpzdtFlBoHn/vuaN3/wT1vJbkAHpXUdFajFEk38jDvOqvP1UqCNtvM68Tw3
         KRAONHCVtZNoKWJ6nKDEVw3YzJo6DMobUxwVfCfd6CrD8vhXi4RAHBjvucVJGdJj/ld/
         vhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771264217; x=1771869017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v1fAIra7fT95ebg+6JoHH+N4Or/PJb9vOIc+JmSiXE=;
        b=Zr+Q6MDXI1t1XabZNtEyIA42L+WkprfiZEC8iQajUG9z9vU3fUqf3RCK5oD62Q/YbV
         JNcFNv8LSwFntovxkJ+2N9vNhLk547m04wG8r/uCg3iQzk2OJQasO9aFTBGwT8AMsp7s
         YZHiSe+R5CReD2MPAQyAoe+rrpp34bnbKjzXDCFxPK8aSbcSEHBAlickjw56UEUon4Zo
         KfjHfG5pk+7RyTnBlUl65ssqUur6NBu0uAeBYQYN5e/S4O80cAx/lSWKdWzCqd8ULZoQ
         jdUB5Mvsrm63mrYizWJiQD//Z02xc8c9ziZP/nwxBWEt7nVARIyr8AVIGKZUNRnAIZrn
         aReg==
X-Forwarded-Encrypted: i=1; AJvYcCWqxDWaA5WsDQy8rmQaMEAZyJaMYKCBVyucNDEKXw8Pi3YMtSJ/Uqaweq1s6z0OWA2SVGU1x2DY3kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTI0J6EL6rA+Hu61cIjtkvkJyp2W6Uhs9D3wl94TFvInDk0ltp
	9Lx+Phe6wM13+0ZVQShSOHsw5YzomJyCWkfa9mxhBt9R/XpzsBgQHD3w
X-Gm-Gg: AZuq6aK6lvoGVC2MdBKCGXXZXEV/8NSrrr+H0UnKsXRKVc1O5UBaKlp+9mtn2iwd4bd
	n1BpQJhQI9CGxbcWFEki/jfN4tVq65mEb8e3MMM+Nnh0zEBB5lrUaeAfwBU3uIlSxFaxYT3HGIH
	fHZxlwsxtbZx/gdWYntQqBdHsnfspTzzQuK1sUeVt81B/lHeRxLVlxC17fkHzvUtP6b5sYQdyt1
	pNEsQU9lA+qxIYRGSxKxvdLOb4SqgVpjPvVv24NvutCjDzpBWvRpdSg6N2dwZp3uXvqan/BtXmh
	qJAK6WJIduu44u1TVLw1ZCBR0CmRO5w5NKydwFHDiGm9Z8l7/XxEwYjSGXYJYwlV2tMeGAuvw03
	U57ovrALgI1G7Z/Ew4yhNGopmR+pSCCW5GhJeaw6fWyVcDMojjMQtz0zvrP919dhYk3R4C+Kccz
	9FzJNyt7xPIwNSe5bH0Mf4j8xfjOPdFWlvSecTWV+vwsViuiq0qzw160zcQ57z3S3DeBIj
X-Received: by 2002:a17:902:cccd:b0:2a7:80bf:3131 with SMTP id d9443c01a7336-2ab5062d628mr94522245ad.58.1771264216721;
        Mon, 16 Feb 2026 09:50:16 -0800 (PST)
Received: from sean-All-Series.. (1-160-221-65.dynamic-ip.hinet.net. [1.160.221.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5c58sm80759155ad.59.2026.02.16.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 09:50:16 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v2 0/2] Fix warnings for RISC-V builds
Date: Tue, 17 Feb 2026 01:49:48 +0800
Message-Id: <20260216174950.455244-1-seanwascoding@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-18947-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanwascoding@gmail.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B7A86146CBA
X-Rspamd-Action: no action

This series addresses several compiler warnings found when building the
kernel for RISC-V.

The first patch fixes unused variable warnings in the NFS client (including
nfs4proc and flexfilelayout) that occur in certain build configurations.

The second patch fixes a format-truncation warning in the MACB ethernet
driver by ensuring the snprintf output fits within the destination buffer.

v2:
- Split the original treewide patch into subsystem-specific commits.
- Added more detailed commit descriptions to satisfy checkpatch.

Sean Chang (2):
  nfs: fix unused variable warnings
  net: macb: fix format-truncation warning

 drivers/net/ethernet/cadence/macb_main.c  | 4 ++--
 fs/nfs/flexfilelayout/flexfilelayout.c    | 2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 3 ++-
 fs/nfs/nfs4proc.c                         | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.34.1


