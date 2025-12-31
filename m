Return-Path: <linux-nfs+bounces-17383-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59879CEB0BE
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 03:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A30430078BD
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Dec 2025 02:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001711FC0EA;
	Wed, 31 Dec 2025 02:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZNtrTLZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A75E2D7D27
	for <linux-nfs@vger.kernel.org>; Wed, 31 Dec 2025 02:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767147762; cv=none; b=fJEhoAcp7ZCFPWLhSjcL6q855lg9s/Yq6RGEZGT+GxLFWUH+bKP9LucnTelELVyYXTK1424P+id4uuQU2BUMYakC5QiJgY/akdCOwouPQjYDD1m1SJ9Qwf/Vrec3z8AS/vrKgvvoMhF2Oq+wHiewvfLgP5th4zpKX/eW8zQJeWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767147762; c=relaxed/simple;
	bh=0eDS0JzIvNXcHC2LNY4PktxISC4wCwqDe3XZYO+x23I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PHuMxC5BxB+XSDZdstZZZXQYR2eUxEgrCkoUb7gNMyZKrhvBVmS95ZWDJV3qfD61KjPK/Qp9ZlBzUCWb/iHX8R7sR6yYcC8s53+9xPoGnmdQ4o7O+a9BkZX2KfY+wwn82s75I/gK22ApfYxw3YQw1EcxbHCvhNsicVDJPlPY3eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZNtrTLZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo11715463b3a.2
        for <linux-nfs@vger.kernel.org>; Tue, 30 Dec 2025 18:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767147761; x=1767752561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzcQaDraZS5/iYPfxAoaqkEn+KL+XWxR91aZNXPU/2Q=;
        b=aZNtrTLZBvdzamzEWIXiikwC9aI3HvmBvWaTRmgOH03I5As6Yyn0ubqcWuvGqn/E7t
         ktw9VTE1AfqNUQMBLYLBvWKDSMbnTHDorjEybWmmTbNPZSJjMb6vkHBuiTfhCXXoIV+K
         p22jzgGD2bH1xZx2e/aCYiLPigAkeX057vzfxN/pahiL6QBZRfy2q/5luXi6eK6aQbV5
         yxZfACr+iGqDJUJC5AUMNO+fjrU0oB0QsQl2iCDp0WhBT0ydjex4z8Ut4lRwpke0xGyN
         wyqIZ7XHwkoNL3SupaXWcBKL3h4/7QIVsYj980PCV/ILNNKVONDG4kG/tmT7cYre5TFf
         Zv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767147761; x=1767752561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PzcQaDraZS5/iYPfxAoaqkEn+KL+XWxR91aZNXPU/2Q=;
        b=NpAMmyA3CdbxDsGawjV07VcBsabvByzqkLmaRXeNU3sUzpeILWTligO6ZMkX42KiuZ
         KUkPY8+jstfg6VHTSTFgGeS/a4IXR+4W4iWq+vXrE9d87uRRFWCHM3lzS8uEVCj0bsUb
         UXVWuIcCudgasCz8uIOuW4y5ZEaopA3einXEXTwjR2LZYRwr37Y0BgXdBqHKHz9XXzlW
         Oem1wj5gRvSw6oAmYd2FgQKdZIDsPN1wbWU31em+GWCP4/tSxhbFM6UU1OpAf3QNAP+8
         gFkymBQzl8+bk/DaOOvvXaQ0wlDw95o1VwrzUbdVYbAIFlNtoeEgx6wHU5q1cLi2HRHI
         SO7w==
X-Gm-Message-State: AOJu0YyksJkp9VDPcmKEurua6te9mVg79vUfnO94m9x5G2f8E2c5wyiD
	m5CNG10L3SOxo8K4KefPrFjaLKupT28/fvwAYyzP4T68bb43AJUEmUth9dWIfCU=
X-Gm-Gg: AY/fxX5fgjNxL96dQiyvkoaT37LXck9ADo0zh3gPkCu4YmSRRhT6+TnP4O9Jet4T5OB
	jKfxQuUXFQsJ/CirtykCr6MIUzauu89fDowY+KLQv8x0hivXUSuFb4u76w1m9zZVmIJd3VtY7zF
	633B/711cDwEzb1A+XAbSb5K/4f/X54c6zw1efKouJVPONYA0sCZoQ8uXp1fRF/GCuXVw5cr4FR
	2/BAq73qV18vpu9kXP4fSaH+UFhTDjOsDkJD1XoAauIdfFVtFx6KdnlaUP0y2dpvdgnJGDsZ2xr
	oCyUncn/BERxVbDlWyhexvTxrw+Yzti9Z0QYfJ4kFZ7JlifjNfcFF4FLBq3Yd/9RCNX6rugvNpq
	sbgkQS6+er+PRdlk0VkvbnfTH2A9wVmm23xy2a7nC0AQLqBzbPROARxzIE36Db2GKu4/cmY3tAC
	GO/vobSRk06JN5UkD4mCyv/yd24Rfi8664A6qgherclJD6MeV1Mman6JmakjXn72ZTSFg=
X-Google-Smtp-Source: AGHT+IEgdcpnCV7FMzl0THP3tZvUv4IPG6I9yfviCX2qdiz5UHJAv0UdG3xw3eZZyri4A3q6W/7yCA==
X-Received: by 2002:a05:6a00:420a:b0:7e8:4471:ae6f with SMTP id d2e1a72fcca58-7ff67f524d3mr31278928b3a.59.1767147760729;
        Tue, 30 Dec 2025 18:22:40 -0800 (PST)
Received: from nfsv4-laptop2.cgocable.net (d75-157-27-199.bchsia.telus.net. [75.157.27.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm33659267b3a.33.2025.12.30.18.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 18:22:40 -0800 (PST)
From: rick.macklem@gmail.com
To: linux-nfs@vger.kernel.org
Cc: Rick Macklem <rmacklem@uoguelph.ca>
Subject: [PATCH v1 16/17] Set the POSIX ACL attributes supported
Date: Tue, 30 Dec 2025 18:21:18 -0800
Message-ID: <20251231022119.1714-17-rick.macklem@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251231022119.1714-1-rick.macklem@gmail.com>
References: <20251231022119.1714-1-rick.macklem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Macklem <rmacklem@uoguelph.ca>

Signed-off-by: Rick Macklem <rmacklem@uoguelph.ca>
---
 fs/nfsd/nfsd.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index b0283213a8f5..b07a04ae7d6a 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -462,7 +462,11 @@ enum {
 	FATTR4_WORD2_XATTR_SUPPORT | \
 	FATTR4_WORD2_TIME_DELEG_ACCESS | \
 	FATTR4_WORD2_TIME_DELEG_MODIFY | \
-	FATTR4_WORD2_OPEN_ARGUMENTS)
+	FATTR4_WORD2_OPEN_ARGUMENTS | \
+	FATTR4_WORD2_ACL_TRUEFORM | \
+	FATTR4_WORD2_ACL_TRUEFORM_SCOPE | \
+	FATTR4_WORD2_POSIX_DEFAULT_ACL | \
+	FATTR4_WORD2_POSIX_ACCESS_ACL)
 
 extern const u32 nfsd_suppattrs[3][3];
 
@@ -535,6 +539,8 @@ static inline bool nfsd_attrs_supported(u32 minorversion, const u32 *bmval)
 	| MAYBE_FATTR4_WORD2_SECURITY_LABEL \
 	| FATTR4_WORD2_TIME_DELEG_ACCESS \
 	| FATTR4_WORD2_TIME_DELEG_MODIFY \
+	| FATTR4_WORD2_POSIX_DEFAULT_ACL \
+	| FATTR4_WORD2_POSIX_ACCESS_ACL \
 	)
 
 #define NFSD_SUPPATTR_EXCLCREAT_WORD0 \
-- 
2.49.0


