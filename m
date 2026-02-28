Return-Path: <linux-nfs+bounces-19444-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KKoDyVeo2myBQUAu9opvQ
	(envelope-from <linux-nfs+bounces-19444-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 22:29:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9721D1C91BB
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 22:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55EF4337847A
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Feb 2026 19:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21327383C78;
	Sat, 28 Feb 2026 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qh9cuxdC"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF66346AD3
	for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772302116; cv=none; b=KXXjImVxcueR0tHT5y3Ko3xRAzStEanyaPkYuGvdxZOS3hpspr0P9SextaKRhHUAf9Dt0iMBgi60exmhGXOThALgc03m44Y1ReofoYLJERvJA5PhOC2Hn7uk6MmCToW3q758g9MNn+GXM9B5LEiN9NakzpIP+4U2ATN9x8cSIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772302116; c=relaxed/simple;
	bh=T8MKheElYMCrERWIN1kNw9bUZSTVWnvnyWPev6Vi2q4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lZfBWe9KFzJytKV7fROUwqciwtsmiZgI5d3wZObimD27qp/3L95J5E/NCPF3wzLbDFRULTvp5FKLGouV5Pjp6RQQKP0HpaQBc+8m5oZE8oDsIlPmDF7UHMJMtkzI6Euv2wORYdSQ8T2K+JDSfLvwFJSH30zPS/REc6/yvEttQLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qh9cuxdC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-826c49b7628so2028548b3a.0
        for <linux-nfs@vger.kernel.org>; Sat, 28 Feb 2026 10:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772302114; x=1772906914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YwAc3eqfbsDFXKOI/9IkPHAT12S5GKUgm1F1AhZ+6RA=;
        b=Qh9cuxdCQH3S62ZI9AB4FAacbmVPclHt8fLDNJDIG4n2PdkGE8YH5vNuMUFGzQJa0O
         Zip3umfmYiM34ZAI7vb4qilbKtnQcTD4VSzn6jQxXbXtw1iEfg9Z9+dckmm36usFTQdt
         5SA+Bdf6DfFjFykaP+27+LS7lrvNkDzMbbxV581Ch+SRzjmTtxxZupvvN8Y98+50pixy
         S5+kppVM3R27o/gOQYMdRvqJqD667t4L/EpOwqsyBCc2MhFOJb3qkdJrL+E9gaxRUaKf
         kSuvwPGzgnS3eWPthJ/SP5bufqDcBl3WO6NN+Yr+GWM3kTmCQxOvtmPfMqgtPV1JX7/J
         dsoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772302114; x=1772906914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YwAc3eqfbsDFXKOI/9IkPHAT12S5GKUgm1F1AhZ+6RA=;
        b=fn44Bxhq1Gc65he+J26Ele9KXcPxya1gDv0XUfUEkXGvMdZeXiZfaensSJaDVd5+dx
         9HbDDTwd88MSMX53gC7pzm52S0jLDI3ws/QMYF/AnyJ/6BypztB2tAZD1GiKEkgyiOcw
         TAtTluMwEKTTzd5vfgrnVl07qu6eahdDnpxp6jfgyA2b0J1pfBOkP1Q9FiO7YUsT5HEe
         bcqEeuwgWaZgbZv7aL1PoqPZvB9TVIRDkOL56hiCoOPeUM3tXJWEqioetIWj4BwgYNoY
         R+npcpo0EA9xJpRS3fE3i0WM2oHWAEt0vXKuvK8X2P7HGIKAk/JHBLHUyifE038yvXOD
         mxAw==
X-Forwarded-Encrypted: i=1; AJvYcCXpvzX4y+SE0tg7Jme/2svl7f6znAa+wFGnsm1nK/ErLmNFyozs0lZtUQr3MArWNqVZ7mLKmsLGDsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcG9pGPpMtre8lfsD6/7NrPhhxi2AyogXUKzfSjwDayJm0hT9u
	Glkrw8kI1lb8U08WCiiljlNf66hr1a4ZIJ77ESZqcdbdeH54FoWV+Eu/
X-Gm-Gg: ATEYQzz5taIEAaGiz5qXOVsg9PobeEgMi+CLdmV75dPJk+izsleMf5QJD+xPa2flJL+
	e9tfCRlRT6gIfFvViqcJZ9R7Fkc9S9Y/Y/Wu2+XLQKTf/+nEFDZCq3OaAY4XLaR7dxkpNMJMTqq
	WoEow1HTdSkcMmFCR7Fp+v2IOgGhhWoxZ5h1WkGf94xaXp5FECbXM7Ujrr3lchK6mDEwzcSBt9t
	XGglFL5TGuzX/YBkAD2lJ7ET3VG8ey866HxrSobvkZpRwIDnvl529NbcihGnUFs7pYVpuIk2J0y
	Od7i2fmca5bKVe9saJKNxXWb3QLsISgDhAkpQETfIDmyjxlvM1uV5zYzv0OHdi0Hup5F+9rsqq0
	ovrIqPc8P3UzpVZ4K2hFoo8XdJR70MieQgTzR30hRW5AgQn+Ir2KUPd8QH45qa+68GRlXG5xQ6n
	Qfqa5fmVy6CHZkcKqQyNSOcpU3YZO5NT+uYm8UYAyHFcTYREWVWXEcJ49JpogxkIE+93D8
X-Received: by 2002:a05:6a00:2e89:b0:823:786:1990 with SMTP id d2e1a72fcca58-8274d99c2d7mr5907758b3a.21.1772302114190;
        Sat, 28 Feb 2026 10:08:34 -0800 (PST)
Received: from sean-All-Series.. (1-160-203-78.dynamic-ip.hinet.net. [1.160.203.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1ca9sm8065154b3a.36.2026.02.28.10.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 10:08:33 -0800 (PST)
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
Subject: [PATCH v5 0/2] Fix compiler warnings/errors in SUNRPC and MACB
Date: Sun,  1 Mar 2026 02:08:19 +0800
Message-Id: <20260228180821.811683-1-seanwascoding@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,oracle.com,gmail.com,microchip.com,tuxon.dev,hammerspace.com,kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19444-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 9721D1C91BB
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
  sunrpc: simplify dfprintk macros and fix nfsd build error
  net: macb: use ethtool_sprintf to fill ethtool stats strings

 drivers/net/ethernet/cadence/macb_main.c | 7 ++-----
 fs/nfsd/nfsfh.c                          | 2 ++
 include/linux/sunrpc/debug.h             | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

-- 
2.34.1


