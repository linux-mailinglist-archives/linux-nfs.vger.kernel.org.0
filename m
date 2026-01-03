Return-Path: <linux-nfs+bounces-17427-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C12ECF0720
	for <lists+linux-nfs@lfdr.de>; Sun, 04 Jan 2026 00:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A68A53009546
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 23:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51EB1A9F87;
	Sat,  3 Jan 2026 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yhzd2Kks"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C5820322
	for <linux-nfs@vger.kernel.org>; Sat,  3 Jan 2026 23:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767483689; cv=none; b=i4XNgzaKeWyKwXgw4G/PvrxT69h5PMmTmH+lbxwt6OJFM2Vlaqofw6z6ntTodM33bgg4K/qH1LCzD2qqpNTw6NL0UWFaH4NCo2poGBgUXLgOCgYLR4YbZEzReiYzu1J9/mIQ9B3LFfbVCa9+OLTdncguG2cVyN4a5UrLLyRydXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767483689; c=relaxed/simple;
	bh=B6QpSVGPSgD99WFuEwdiW261a/1D8TJvKNb6V23sGec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwCGpnq4SdHOMtZsAve92Y23zZF6RyK/uUOfUktAROAB1Bg0BjbAqEnBykATHwQ/reAzpttNT4sH9mQ3p3C+uQVeFb4BE2z6aYvQVvlcHwVFOrsLFeU9nqVy6KcOAaympVlLHnLyuI+rS9NGXu1yVFZ+CGoomAupdzooXfsoN+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yhzd2Kks; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7e1651ae0d5so10028345b3a.1
        for <linux-nfs@vger.kernel.org>; Sat, 03 Jan 2026 15:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767483688; x=1768088488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mo42MFi5fiUQy/do/oVCUt2XC83J1ozAsIdaxKEr5x4=;
        b=Yhzd2KksqCP2KEHtXJvufz3PFnJctLn60uV4AE8ibK4sUPMrBrVT5wDvyW4KeaGpd3
         epyWyw54DtMNqyXYywFBRsJmQ3++Qk5LnNTGAaM1nSH3eaYWTcVXKSZecZxdXW1UF5yh
         3T06juV55xw7+dnygnFQuAaYD8koz4V887pJkb1G7QIl+pTfUfZTwmVpwdbx4wxs5Zq6
         erJn3kdNhDZb/ov0CwZVWUuE0vJ/rSR3w3N91vx/oJhdepYhBiF0rfZRB/M4sWjkDHBe
         u2MS9IKcVwsXV12jX0lSY/dWVQSeH4f3QpQzPslEBZBRIpBi+5ZPMIyRahjMwDWSA2By
         y6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767483688; x=1768088488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mo42MFi5fiUQy/do/oVCUt2XC83J1ozAsIdaxKEr5x4=;
        b=pVMhkO86lutgGWEq9b7xbQUvqu5LVpB5zN7yTxXJff2Mr7/Ty5f7lA/WTuME6OunJ2
         ndINqbKrPTCEaAvtRjHwaC6Bnwh24eU0dp0QaNam6SkMRKQNhLiD8p6cy6Is6IGfgaiq
         4uHzsj3fN4en1SQ3OWOnSMFxSedC52hlXwYrvUd2J7kSuKgwN4XjKqFu1Zw7+z6J9qE3
         Wtc0nl0hhK05jZoVJxDVk9AE+ktNAbEjEtDTrAuQwFVxisKgNR5FkpvJ6xrcH//v4ucm
         61EuUSuxjqHJrLMdso050rzCBdZGxHVSTwQDWPyly7JG+eItpvneBHXz+ovpRA+9HluD
         gozA==
X-Gm-Message-State: AOJu0Yx9XI3Xh0vZ16Dr5R7BNkU6Z2aUV5PC7bednYUq065dOEPG3eo/
	6z+LoJagkcC/qK3Xjw9x7V2LMLuGVJnUvYiUuuQwbawP+JnRS6VygWBOJ3IDGnE=
X-Gm-Gg: AY/fxX6dYv1QqaapDRQYXJ439t5zEpUrimhYf/49TZq6GbTPqBQUFgfkA0uNxpSiDLC
	7vV7vGiAsDQcJkigypxy/q2jjLbuO1trSO41W333iVz3OknqujZMjrhkYUu8iiuyQjwHrm5w5cX
	KBrOpJsd49KbeuHA9zjNWYwIZgTXyNENFO5tj6I6eyWmCXXhNwdxvdOEanqnCUc/n4eyxpLpfoP
	D5RzXqSAKkEAiqIdUVxO0kiJN6/u2WqpNXWUc25DAfDuu7NBMbSHcT/kp5gbY738Jge1sgopIyo
	kX9a/PxghSWqHHM0r10ubrTWPXXPaytxQcKHBwhT7KFwoN0FanuHIVFipm6bSjkvec5/7amzvEx
	PU/mImYrwFSLq2MYJncJtozI8ITIcfuf06gtGwCy6VALeKjs0rgLgS1Ey7rOE3Q1ePcH/zNw2CF
	ESk/JS/tg1AlcA84AAo+qm81g5aQX36MVlwKWxMudmMbOooFYLItoU7xa26Y/eBBHeZRc=
X-Google-Smtp-Source: AGHT+IEtcYKl3IeYNBG4T4JpxbT3XY20kqW7A2wDTYMwHKLZTP9Rnxd0ET8G4kkAeaOuXeepdmxTVA==
X-Received: by 2002:a05:6a20:3c90:b0:361:4f83:10f5 with SMTP id adf61e73a8af0-376a96b9ea8mr42443521637.48.1767483687606;
        Sat, 03 Jan 2026 15:41:27 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7c5307c7sm38472577a12.28.2026.01.03.15.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 15:41:27 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v2 4/8] Make posix_acl_from_nfsacl() global
Date: Sat,  3 Jan 2026 15:40:28 -0800
Message-ID: <20260103234033.1256-5-rick.macklem@gmail.com>
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

The function posix_acl_from_nfsacl() needs to be called
from the NFSv4.2 client code handling the POSIX draft
ACL extensions.

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfs_common/nfsacl.c | 3 ++-
 include/linux/nfsacl.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/nfs_common/nfsacl.c b/fs/nfs_common/nfsacl.c
index e2eaac14fd8e..2ef7038b8d69 100644
--- a/fs/nfs_common/nfsacl.c
+++ b/fs/nfs_common/nfsacl.c
@@ -289,7 +289,7 @@ cmp_acl_entry(const void *x, const void *y)
 /*
  * Convert from a Solaris ACL to a POSIX 1003.1e draft 17 ACL.
  */
-static int
+int
 posix_acl_from_nfsacl(struct posix_acl *acl)
 {
 	struct posix_acl_entry *pa, *pe,
@@ -325,6 +325,7 @@ posix_acl_from_nfsacl(struct posix_acl *acl)
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(posix_acl_from_nfsacl);
 
 /**
  * nfsacl_decode - Decode an NFSv3 ACL
diff --git a/include/linux/nfsacl.h b/include/linux/nfsacl.h
index 8e76a79cdc6a..f068160bfdc5 100644
--- a/include/linux/nfsacl.h
+++ b/include/linux/nfsacl.h
@@ -44,5 +44,7 @@ nfs_stream_decode_acl(struct xdr_stream *xdr, unsigned int *aclcnt,
 extern bool
 nfs_stream_encode_acl(struct xdr_stream *xdr, struct inode *inode,
 		      struct posix_acl *acl, int encode_entries, int typeflag);
+extern int
+posix_acl_from_nfsacl(struct posix_acl *acl);
 
 #endif  /* __LINUX_NFSACL_H */
-- 
2.49.0


