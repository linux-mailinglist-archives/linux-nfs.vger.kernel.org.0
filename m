Return-Path: <linux-nfs+bounces-20303-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCmOFCCovmmKVwMAu9opvQ
	(envelope-from <linux-nfs+bounces-20303-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 15:16:00 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C552C2E5B81
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E32793019B94
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Mar 2026 14:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF4538C2C7;
	Sat, 21 Mar 2026 14:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTfAMkmw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD6F13B7A3
	for <linux-nfs@vger.kernel.org>; Sat, 21 Mar 2026 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774102530; cv=none; b=jdunHXK+jPahS+QT6fEx/C8NWxvlaw0njVRFCbTgSA79p5XM3RsupCEySkCSsJVg2BwlniwZkpYPFIcOjzc8ftW5dv1I00iu7e8o3lF1Cea2Qj05z56PCa6gEYRYI2mcCT9Tvxf7tFNttCulgEdXa0R0KDnFkNVcidYafDEcUVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774102530; c=relaxed/simple;
	bh=3+K/ApuxwjyEMBrtQSSDiQv9ECGp4Y+q1xsZnKf+JrU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jVgSPU5Hwd6m73Iq4ZelBWVjFKZKLxNzi++P8bHZf1l/a9tcwR3ElpWYodZWDYSpIW5e20l199VONrqVO7I0tX3a9FEPdLUUSeDFCUG5OB519ruSEX1Ctwr3IPYrSMenb0pPAR98nG18edVsp99eeaXo5TWL2FiJbgw/IvEYB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTfAMkmw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c74280e3468so605403a12.3
        for <linux-nfs@vger.kernel.org>; Sat, 21 Mar 2026 07:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774102527; x=1774707327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UuapLcFBj9/2tM0hd60ExcnAcuLnRL+SJ5nrXPeI/3k=;
        b=RTfAMkmwC2+H3DbdKJDDZ2ynYzlTPr/6B4yrsKU834f02+kxycSySyQfZ4+q4poT5J
         CqbJ/3vLE8+rwNoUiDgFyIaGt+bku+ViMxdTWjaLlZxDOlOZtYqQGvKZVHcL/BwtMUFE
         PwcZjIwtAj+Ljh/JEb1wh9SUeA4/cs9+xUW/utrhV/82Nn6PDbBC0PR/Ljv9nd/qLCIC
         ew6nLhPCJzpul74+rDufHlg05BtD1JHdYmR3YrKxSnuPDL/C//fCBBbOp+NFAs5CYapI
         4McTQku56GKI2Mcugqji+oAVkGV+ZNr52+FLwhqxcJvaYe8esLFBWZtxcplvZ93cRxee
         /mBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774102527; x=1774707327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuapLcFBj9/2tM0hd60ExcnAcuLnRL+SJ5nrXPeI/3k=;
        b=hGi3P3G9hCAXgGL5qILWDWBoVM8dHEZwHHRNkZiZRiXxEwUvdvXrMpjbg7IVFpYM5o
         Uvy/PJiqxIpCpq7ry3pHxm1tDrf0prCTCn3r21/deUa/bQ2GnXyH6RqHT2dB9coCEQSz
         8slMdvmaViTAvVqGJURWdVwg2YK/rke22ijBx3o2NDOZnSMIODLiN7gfMGncsiTTHoR7
         xsms1HiLHoBOoHts8/miYlxvtVCS+Iph+EPzFwQEemmjjsmmcV7wMvW+yZfwbnSMyU7r
         TbzxErT1dExKVX3C8spONZHpVefJhns8VNLWoEERo23tMZcou4m6DXg+6+GygqifU60D
         hxIg==
X-Forwarded-Encrypted: i=1; AJvYcCU3PAJj+aqhkGCApMKgHlFnB7UIYSeYEl3OqUMgKKbeuX6NpbwijgaIzeL8r6eukiCJ4qTKEpCEbCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnr63At/HzWObVCpyRNroT9G8JK3ajwESoV7zH8gudjkm3cOV4
	91dEjL7q3hiP/NTryGSOiWBhJKDu1ZHhDQ2L7RPznQAWt2m6wokbb+Oy
X-Gm-Gg: ATEYQzxiNhnpk0YWXsyMSglpK4Iu6kI5bsJnFzge2ZhyH8/u2BHyzsTyfTNckOaYYOV
	szFzJtfW0pQlKn6r/0CVbw/woJb3jcNqZzui6KPblAqfczLTWwpG0byNJr80UHb3HeU8RNlljMz
	ThRXesnxoi0USjcYM3fgFUCrY6/K/aesDI6C25xtW++15iFIRWZVKOdFgAwc28g44mZb4dkqtTh
	yrIMr+NmFGCHD6tgUsj1l/uNIuQqEJEHh/6QhNH+DhsUokZ9kJlJ3XnpJHRzTa3mXLe8dhK+OMK
	17XXxqotc0E++OVF9sA0mWQDvWc2/PbPkl+tt5orfyrQ83TKUEXXa8yTza3SW++jzCA3voNzBu7
	lNjlpyhIO3187UyPvWX6KMfIsUsURiQRvyHsRbtwGcs3Z4Scrx6BEqAqiG7R8W4j4y/CWnxhbpU
	EQbcVYTJe8jcuJo5nmOUB7pXDwhclCeTqZpe8hqfIiHmt7GZcILGwCTNR77GjZf67Cx5kvJRWkt
	Z3aVMy6Bw==
X-Received: by 2002:a17:902:e54a:b0:2ae:825b:49a5 with SMTP id d9443c01a7336-2b0825bf592mr63385375ad.0.1774102527511;
        Sat, 21 Mar 2026 07:15:27 -0700 (PDT)
Received: from sean-All-Series.. (1-160-226-215.dynamic-ip.hinet.net. [1.160.226.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08353e94asm52680715ad.25.2026.03.21.07.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 07:15:27 -0700 (PDT)
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
Subject: [PATCH v5 0/5] sunrpc/nfs: cleanup redundant debug checks and refactor macros
Date: Sat, 21 Mar 2026 22:15:05 +0800
Message-Id: <20260321141510.68214-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
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
	TAGGED_FROM(0.00)[bounces-20303-lists,linux-nfs=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C552C2E5B81
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series cleans up redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
across sunrpc, nfsd, and lockd, as these checks are already handled
within the dprintk macros.

Additionally, it refactors the nfs_errorf() macros into a safer
do-while(0) pattern and removes unused nfs_warnf() macros to improve
code maintainability.

v5:
- Reformat the cleanup of __maybe_unused into a formal 'Revert' patch as requested.
- Update the macro refactoring commit message to include historical context
  (commit ce8866f0913f) and use backticks for `git grep`.

v4:
- Add a missing patch to include/linux/sunrpc/debug.h to ensure dprintk()
  properly handles variable referencing via no_printk().
- Remove obsolete __maybe_unused from fs/nfsd/export.c (revert ebae102897e7)
  as suggested by Andy Shevchenko.
- Add Reviewed-by and Tested-by tags from Andy Shevchenko.

v3:
- Added nfs_errorf refactoring and removed unused nfs_warnf macros.
- Split sunrpc and nfsd changes for better clarity.

v2:
 - Follow reversed xmas tree order for variables in svc_rdma_transport.c
   as requested by Andy Shevchenko.
 - Polish commit message: use dprintk() and remove redundant file list.
 - Correct the technical claim about dprintk() type checking.

Sean Chang (5):
  sunrpc: Fix dprintk type mismatch using do-while(0)
  nfsd/lockd: Remove redundant debug checks
  svcrdma: Remove redundant IS_ENABLED(CONFIG_SUNRPC_DEBUG) guards
  nfs: Refactor nfs_errorf macros and remove unused ones
  Revert "nfsd: Mark variable __maybe_unused to avoid W=1 build break"

 fs/lockd/svclock.c                       |  7 ------
 fs/nfs/internal.h                        | 28 +++++++++++-------------
 fs/nfsd/export.c                         |  2 +-
 fs/nfsd/nfsfh.c                          |  8 +++----
 include/linux/sunrpc/debug.h             |  8 ++-----
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 25 ++++++++++-----------
 6 files changed, 30 insertions(+), 48 deletions(-)

-- 
2.34.1


