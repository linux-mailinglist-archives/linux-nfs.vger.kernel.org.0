Return-Path: <linux-nfs+bounces-1381-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D71AE83C5DA
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 15:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15BC81C213F6
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 14:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059E56EB5C;
	Thu, 25 Jan 2024 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRDpdT4x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848AB6E2C0
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194295; cv=none; b=p14Izbj+JTMAW+t9kq0eLS8kCHrZN7TItwTWj9F4G1/LtrVL2te9iOTNldzCORFbUXJhICm6MpcS8KtFEe7sqCusB0GJIX0dnjCveuw7KgCnKn9w66KJpJ2esr+r2X20Mfqn7fw55ZP72c3aoFbFSOHFlUpfH6hGU56IQyib9g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194295; c=relaxed/simple;
	bh=6hD4mBU+VXDWboXSOnxVYGSm5c1UpXc1FGR23FXUUMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sKCDglXxvlo/Z3OoGhjhPaDmCvym0XjYbk0WTBRNwsR2NitDEczGsEzxuqWvI1x5vm4CJtk1nXJfraFcTKgV5aePJEe7r8NnFBMUV13+AGSJr5QxA5KRrgWAnWo7outUKC9PwHVV01FyrBc4bTVkM0OJ3EZTISKkwmyvbTSL1BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRDpdT4x; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6ddf388ca74so3772648a34.0
        for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 06:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706194293; x=1706799093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+HlZwykM2JXulPjDp5OrXj057mKh1WqUYo+g6qoFNM=;
        b=LRDpdT4xSshjicUe1HkEq1TjC1wX1r/TgjRR/vMNfwdJ7GEwNjq6hSje9VugkE9Isr
         eNNW2R8V3RpMQotfXOgPmSccdDyk4VzXQgqjFibJ2AVrtHb/c0cwxd/VEb+e/Bru7XU/
         OX8ufXyfCKSEYHygyZKbuX/6UYuahrniSiXXSaqIcHpZe8ev2SJbx1cw9WS+6yOcNeLG
         o6GdO+v/mTKgqE4vo6vuo4E0N3O0VU4+IoqXaN5dVvJkBls2VkVqeWWQykrw/DuBPK3x
         hCaZ1E7RrEZLo5VfgrqdikgRnyyNWNZGE9fMDPH4V1AHmI3cFUAhTxlSLYvX8eew1PsZ
         bgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706194293; x=1706799093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+HlZwykM2JXulPjDp5OrXj057mKh1WqUYo+g6qoFNM=;
        b=YHt2FyaviQcmyBlprdq3pd3s809ZLVe7qX+hWnAYiwbQpHbI4/REm3fbRnDguf7r3J
         1g3N17K3TjTvxjl+Ut5t8VyZFf7x9XmuNdz+tU8oB0vhEGqcetiU0d/MiTFIaVimM5cF
         qVB6n9uPvkKV8mbpYY1O3janwh74zPx+XE5TLKCrENsXBoijvuv4l3sjoZOnOlKSIXRM
         OR8WKMtqgG+Grzijgux/JljLerwLI6fTJJikiesAQSI6Kj2vlWMrdaL2znul9YGafSJl
         uVmlwPmGuopx9khCmTUA0aaYr0x7olBO9sC0W39DqAVuuTelnPQGKuHQRbt8d/A8jju8
         rJSg==
X-Gm-Message-State: AOJu0Ywn/9fvzHUtl2xO9cmo63SaWns+/jjdNtdrFdEED+7t5GMVF6Ec
	G2tXsa5tmE8j1zF8x+jdDMfmgn/j+bqsE12d/62YaOMmrLUcnhxo301NQH+t
X-Google-Smtp-Source: AGHT+IEHVH9RGrqNk7iAGDpOy8bxqMb7MWYYdcrWW9/oJgdhBOCD45UX+Jto6FdImaW4EBzcErsBrA==
X-Received: by 2002:a9d:7b4f:0:b0:6e0:cce9:833f with SMTP id f15-20020a9d7b4f000000b006e0cce9833fmr1049409oto.53.1706194293017;
        Thu, 25 Jan 2024 06:51:33 -0800 (PST)
Received: from netapp-31.linux.fake (024-028-172-218.inf.spectrum.com. [24.28.172.218])
        by smtp.gmail.com with ESMTPSA id b1-20020a9d5d01000000b006e0f30de288sm1419659oti.65.2024.01.25.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:51:32 -0800 (PST)
From: Jorge Mora <jmora1300@gmail.com>
X-Google-Original-From: Jorge Mora <mora@netapp.com>
To: linux-nfs@vger.kernel.org
Cc: trond.myklebust@hammerspace.com,
	anna@kernel.org
Subject: [PATCH] NFSv4.2: fix listxattr maximum XDR buffer size
Date: Thu, 25 Jan 2024 07:51:28 -0700
Message-ID: <20240125145128.12945-1-mora@netapp.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch order of operations to avoid creating a short XDR buffer:
e.g., buflen = 12, old xdrlen = 12, new xdrlen = 20.

Having a short XDR buffer leads to lxa_maxcount be a few bytes
less than what is needed to retrieve the whole list when using
a buflen as returned by a call with size = 0:
    buflen = listxattr(path, NULL, 0);
    buf = malloc(buflen);
    buflen = listxattr(path, buf, buflen);

For a file with one attribute (name = '123456'), the first call
with size = 0 will return buflen = 12 ('user.123456\x00').
The second call with size = 12, sends LISTXATTRS with
lxa_maxcount = 12 + 8 (cookie) + 4 (array count) = 24. The
XDR buffer needs 8 (cookie) + 4 (array count) + 4 (name count)
+ 6 (name len) + 2 (padding) + 4 (eof) = 28 which is 4 bytes
shorter than the lxa_maxcount provided in the call.

Fixes: 04a5da690e8f ("NFSv4.2: define limits and sizes for user xattr handling")
Signed-off-by: Jorge Mora <mora@netapp.com>
---
 fs/nfs/nfs42.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index b59876b01a1e..32ee9ad6a560 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -55,11 +55,14 @@ int nfs42_proc_removexattr(struct inode *inode, const char *name);
  * They would be 7 bytes long in the eventual buffer ("user.x\0"), and
  * 8 bytes long XDR-encoded.
  *
- * Include the trailing eof word as well.
+ * Include the trailing eof word as well and make the result a multiple
+ * of 4 bytes.
  */
 static inline u32 nfs42_listxattr_xdrsize(u32 buflen)
 {
-	return ((buflen / (XATTR_USER_PREFIX_LEN + 2)) * 8) + 4;
+	u32 size = 8 * buflen / (XATTR_USER_PREFIX_LEN + 2) + 4;
+
+	return (size + 3) & ~3;
 }
 #endif /* CONFIG_NFS_V4_2 */
 #endif /* __LINUX_FS_NFS_NFS4_2_H */
-- 
2.43.0


