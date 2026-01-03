Return-Path: <linux-nfs+bounces-17424-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E76CF0714
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 00:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 899F2300A341
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 23:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297581A9F87;
	Sat,  3 Jan 2026 23:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Soq5H3u8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C1120322
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767483683; cv=none; b=HGJgifn7ePXn50ue9d2k0xPlWZGwVmez4sFa/ebABxVKqziWLYY3s/Q1wKL8sk2IZ82wcdZ7905VYXb2/ggsNbhf7KdhOFphnsQC3bIJTVREijC97g9RBiqA1xyFFIGUjurgQ7WjLIxxG288dwQc7r/e6MpW5tL/DA/tmgOPltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767483683; c=relaxed/simple;
	bh=3TELmKXp+6mzO5IZ+x1kxbw5oju6mJNXo6IrMg5s5mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7XvuscRrV0n2Ky3KGkFshQl2wXYOzm0wU/EEUrLJt94GPHZ6zAhkgydKWYUirbqWao8vu3/lj4ntX/yY1Qz7WSugycdgoF1tG6WyXsZn+rcmhhTmkCXMOUT8x65ybjT05ahNE1979Dme936Rytit1VPgis1aTI5MUyBZzEE2xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Soq5H3u8; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso15216942b3a.0
        for <linux-nfs@vger.kernel.org>; Sat, 03 Jan 2026 15:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767483681; x=1768088481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGLavR+Yls31YsdKgrd98dRWsjnFMIxFLKanzIJo7Yw=;
        b=Soq5H3u8fRMD75ok8rEiJqwpi3z9+WITo3PnlLosM9yvV4zIVTU1axW1FlN+axpDXA
         go/MCmZ5JOFO+LakEIoBHJDyzYsTd8B/rPU4F5i0k7fnvk4k+33DvLbAD3fsvK6LhuoJ
         Y541smrzPgOlKBQBe3sEYZtGm/LN9tAoz1dG9x7jEM+hojjfSSrPmXCrlCD09BDWYyr/
         KwbuPiumWqSugFw7JJtWZKu3JtG3NPtMEAxDMyGQxta5dQLVvRzk6dtiJWstC//Dm0gT
         GvEnEqpDUpAfdZdGmhyMChIhj7GP+012MlXkvzzWUkC9TjAiZilSUd274oDP7gVERK28
         7apw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767483681; x=1768088481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kGLavR+Yls31YsdKgrd98dRWsjnFMIxFLKanzIJo7Yw=;
        b=hmlLAjJoczwxs9P3eUY9BuBw2YcSLY/fTuZWx4oqEEttPUuUaA1/2OFpOwHY/PDrNo
         wFrQZt6q8qXstvc9kcpXjDWwyisy21q7s1LqKlFblnbcCrMiA5NNRqq16zdJZL0rpZBB
         N4tdmSNOad228qR2/53R/E+XxwL1kBKw/n/f5IPCKgcztPX801vwW4L4e2SzZhUyvkxY
         9/VJKGLKkU+bflp91Z950Qv5GjiI/BUqMxN8MJIazZeb+atqfd9xI7sNQ4nBRl7nQHCg
         FMMBRyHkGnenu6n+ZsWG2Ia1xaISxMLag3whlItk5G931XuWLysRCZYq7WoFv4LcT1MD
         uKaA==
X-Gm-Message-State: AOJu0YzZJxpIJUNy90X82E7H1tAJb6idaMYp8iVF8rICCE+oIPVc/k0o
	2p7fuxW7BRlhNsskXB583OFqgdKebWoTiHtnbht6Yrm3Tc5f+aT9Yued05fHjq0=
X-Gm-Gg: AY/fxX4rInLiQXEifJFHffLkTcKRgY30pQao6UjqGS0W0Ii999s9LG55a6sYkBKIl0I
	a+pZ1reY8g04FvCCaMfYMxFh6kXmiQEw7HkKkPfQPlXFClXedSjCep5IjqPJisdZYzvnPTS8dYr
	Be7jNAqdWPRcHjncCPVSV0W1JPFjdhVtS2DmNJqG219Ikzr35FxgZCt35Y8AuWOlX5pyZpwuSHm
	5vbPguY8GBbdwhkLEoU3k6HNCqcqzth4YbmP9sgHzwAE1Nqm/woGFB5uU79h57/gvLGps7ggak6
	404JHs1WmvgARDEFhHldjT8mLiyEi3prl6ECwGH1FIYB8qkp0OkaNhDv6nODp9lwQ+wrUEu2bg9
	fs7fFqmincpqNQs7xpqRBMdUy/z5VZw7q3yM47B6r08K9Q4QOglRuOXUxsezp2F0RhA4Sw0TRo3
	HJZF1OkO/JmJutcOA6Ri1rg8ammAizZIq4YLMd/x41tWpboIBNyXCk/gai
X-Google-Smtp-Source: AGHT+IFA6bvLFvr3xH7cqDA21CbM63Gy6GZlEi2DvbRZwl5T/dd6nSmWSsdODrH+OUunCx4d2EmYOw==
X-Received: by 2002:a05:6a20:748a:b0:340:cc06:94ee with SMTP id adf61e73a8af0-376aacfe565mr41008523637.60.1767483680624;
        Sat, 03 Jan 2026 15:41:20 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c5307c7sm38472577a12.28.2026.01.03.15.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 15:41:20 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/8] Add definitions for the POSIX draft ACL attributes
Date: Sat,  3 Jan 2026 15:40:25 -0800
Message-ID: <20260103234033.1256-2-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260103234033.1256-1-rick.macklem@gmail.com>
References: <20260103234033.1256-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

The Internet draft "POSIX Draft ACL support for
Network File System Version 4, Minor Version2"
https://datatracker.ietf.org/doc/draft-ietf-nfsv4-posix-acls/
describes an extension to NFSv4.2 so that POSIX
draft ACLs can get acquired and set directly,
without using the loosey NFSv4->POSIX draft mapping
algorith.  It extends the protocol with four new
attributes.

This patch adds definitions of these four attributes
to the nfs4.h file.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601031506.MX594pma-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202601031639.zIQYLs4h-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202601031746.QiLqxADW-lkp@intel.com/
Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 include/linux/nfs4.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index e947af6a3684..9d70a5e6a8d0 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -516,6 +516,39 @@ enum {
 	FATTR4_XATTR_SUPPORT		= 82,
 };
 
+/*
+ * Symbol names and values are from draft-rmacklem-nfsv4-posix-acls
+ * "POSIX Draft ACL support for Network File System Version 4, Minor version 2"
+ * Section 10.
+ */
+enum {
+	ACL_MODEL_NFS4			= 1,
+	ACL_MODEL_POSIX_DRAFT		= 2,
+	ACL_MODEL_NONE			= 3,
+};
+
+enum {
+	ACL_SCOPE_FILE_OBJECT		= 1,
+	ACL_SCOPE_FILE_SYSTEM		= 2,
+	ACL_SCOPE_SERVER		= 3,
+};
+
+enum {
+	POSIXACE4_TAG_USER_OBJ		= 1,
+	POSIXACE4_TAG_USER		= 2,
+	POSIXACE4_TAG_GROUP_OBJ		= 3,
+	POSIXACE4_TAG_GROUP		= 4,
+	POSIXACE4_TAG_MASK		= 5,
+	POSIXACE4_TAG_OTHER		= 6,
+};
+
+enum {
+	FATTR4_ACL_TRUEFORM		= 89,
+	FATTR4_ACL_TRUEFORM_SCOPE	= 90,
+	FATTR4_POSIX_DEFAULT_ACL	= 91,
+	FATTR4_POSIX_ACCESS_ACL		= 92,
+};
+
 /*
  * The following internal definitions enable processing the above
  * attribute bits within 32-bit word boundaries.
@@ -598,6 +631,10 @@ enum {
 #define FATTR4_WORD2_TIME_DELEG_ACCESS	BIT(FATTR4_TIME_DELEG_ACCESS - 64)
 #define FATTR4_WORD2_TIME_DELEG_MODIFY	BIT(FATTR4_TIME_DELEG_MODIFY - 64)
 #define FATTR4_WORD2_OPEN_ARGUMENTS	BIT(FATTR4_OPEN_ARGUMENTS - 64)
+#define FATTR4_WORD2_ACL_TRUEFORM	BIT(FATTR4_ACL_TRUEFORM - 64)
+#define FATTR4_WORD2_ACL_TRUEFORM_SCOPE	BIT(FATTR4_ACL_TRUEFORM_SCOPE - 64)
+#define FATTR4_WORD2_POSIX_DEFAULT_ACL	BIT(FATTR4_POSIX_DEFAULT_ACL - 64)
+#define FATTR4_WORD2_POSIX_ACCESS_ACL	BIT(FATTR4_POSIX_ACCESS_ACL - 64)
 
 /* MDS threshold bitmap bits */
 #define THRESHOLD_RD                    (1UL << 0)
-- 
2.49.0


