Return-Path: <linux-nfs+bounces-13983-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F46B40D02
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 20:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52A41B636FA
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Sep 2025 18:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E8A2D6E57;
	Tue,  2 Sep 2025 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRtOxCNn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8177332F77E
	for <linux-nfs@vger.kernel.org>; Tue,  2 Sep 2025 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837196; cv=none; b=TdL6SQ9rUPLPGbZMTP4GdfcsI0BYmxzlEw9vbjyrVMiUbyrc2M76vcWmJ3EaU8WwZc64Z7c6tiT8jdUHAQbjdKQuJW91t/sPBsYPKvSzDSuhMlC5YeOiHQ6NsjvHIMuY72ZSl/ItyTUgeccP9hPi7H121+w3EoyXd7EYI8TQPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837196; c=relaxed/simple;
	bh=GVCp4+JmmoirrDa8PWZaihzkSLSCtTQSaEXnMf0raBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pfTvL/PNVc4IJJtIvwiWzWODAeXUo6GKuw9gixt4a/iBg4X4aFKg1AEpaTY9FMPZrWm+yQiHXonXT8P1U4jZE6yBYvsvLVRmJObRV2wSzORQJT5tUmNx3DMQfbjD0E+SGqZwt75BV3awPqVdHZ6426mUbpaCFseiXinUhRkcFok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRtOxCNn; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so149204b3a.0
        for <linux-nfs@vger.kernel.org>; Tue, 02 Sep 2025 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756837194; x=1757441994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9rLwYhOaA4LfqAji5jlUOfeuxHlmy1k1ToZ/5LFSsII=;
        b=nRtOxCNnXK3/OHWoqMUjKl1NFhvKrLR+khBnwYxPWw1LjorzGPf6tZVoXAhRgu4VE2
         0j8a2LCJnJdNoHADZuPuSO/aWWxyRyXMHmP2vnO8L94lY4w8AAtq1JTjQQgn5snNwbDZ
         CEEFGpQcF4wVsroY20gwn+GK46zRqtj20hO8TCNnMkhorljvfpiGJvNJKwbCzyvbYbii
         QGo10XSlL7m1lmWIVkEZzwz/Cj0l1XElefCaru1Zj7mATEqKswOkbw2EJ3BIeAf+QLRF
         A7UwjdfaiwzpfP6RmOrH96iCikmliybq5SyRxAirbUgUmbhR6uhhz/z3d0GfMkOaICUi
         9vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837194; x=1757441994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rLwYhOaA4LfqAji5jlUOfeuxHlmy1k1ToZ/5LFSsII=;
        b=vurHLScy7OVXhM6vb40dyQNX7C/f59A6LB9kn2s/r/xaYuXxLh2IzbWawj+2b0chBK
         oFYRiRByWbrUT0PDkLAaNqb7M5N1ao+dkWr8VTbj8+6MLRobCX7NNxotrXKX+4NDJx0V
         xORg8WcPbXz//tmHyfmu+zbCS88WJEVc+8BkenfqwW7A0uV9gOzAzM8JeCK5bg0IMAXq
         y73pW22koy17LN3O9q7TZa3Kv9yAQJQ9MvD2v3IYk+vH3hsl4Kt26WAj5vlqQV1lLWEJ
         q6UrPOIieqnwKCUPRUNkVJYg3vTkOp6CeKftWeB0hMeHGeGNfJZQZWtHtSjv5Rxd3kDj
         lk8w==
X-Gm-Message-State: AOJu0YwIKo2eYpBAWnIoVOFrmM4XmeKItRq2VFYMV8VA6G4vL7gkShnE
	Ogsh7bBAHQy3DXzBmn2UvxpLGgiPvkXguslYIm3Tcy37W+Q1ISFwNDNSpfPb2Q==
X-Gm-Gg: ASbGnctsraGByKoTfrFdvNcmSuy9iEiRoMxV/nzdXUa2qfgnyc//27fFBS9gJkKTuYl
	I3gW8TWyL6It4o97vsgameuhjrpCMxyHeseqfj38j45HbWMEQWRlL+oWhP67ahLcvGs8d4wx7Dz
	olo4m777CpJsM5IxvmwXY0kA2jEyOvwcPNbRX1WBEBFzOIBAWe1641pNqi6vtRNXQuc+r9uf4I2
	aeDKLBziK/W9fC1M7GhWZM8qppbX4B6ln8T68ozBylU/ZRl2ej7FoLAU1eZOcf4Yufo8CNogjay
	K1vGRLo3LkA4xG7Ulbjt1l7umZZc4G/Id/H1eXzJLS7N73k74P9oOWVziatB73LqxW1vIv6fS+y
	5nFpWSaHKW5ofXiDsJZH7C3jTgghktMTHVDW/rLJK9zLDdTbvaHqYwfh1eTs7pX2IQj4=
X-Google-Smtp-Source: AGHT+IGYbfNUqo/RbTUPYmPXAfE94xBhFWQyj+B1QFpDTcqK/CRFZZ8YU6M97ZFcwUd8k9A5+x3y7Q==
X-Received: by 2002:a17:903:1cd:b0:249:1828:f4cf with SMTP id d9443c01a7336-2493ef5020amr173073545ad.18.1756837194450;
        Tue, 02 Sep 2025 11:19:54 -0700 (PDT)
Received: from haihua-yang.r8.ubvm.nutanix.com ([192.146.154.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065a3b67sm138899235ad.120.2025.09.02.11.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 11:19:53 -0700 (PDT)
From: Haihua Yang <yanghh@gmail.com>
To: linux-nfs@vger.kernel.org
Cc: Haihua Yang <yanghh@gmail.com>
Subject: [PATCH] add force_layoutcommit param
Date: Tue,  2 Sep 2025 18:19:43 +0000
Message-ID: <20250902181950.2057363-1-yanghh@gmail.com>
X-Mailer: git-send-email 2.51.0.87.g1fa68948c3.dirty
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 fs/nfs/filelayout/filelayout.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index d39a1f58e18d..1cb8f413a665 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -48,6 +48,8 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Dean Hildebrand <dhildebz@umich.edu>");
 MODULE_DESCRIPTION("The NFSv4 file layout driver");
 
+static bool force_layoutcommit = false;
+
 #define FILELAYOUT_POLL_RETRY_MAX     (15*HZ)
 static const struct pnfs_commit_ops filelayout_commit_ops;
 
@@ -233,10 +235,11 @@ filelayout_set_layoutcommit(struct nfs_pgio_header *hdr)
 {
 	loff_t end_offs = 0;
 
-	if (FILELAYOUT_LSEG(hdr->lseg)->commit_through_mds ||
-	    hdr->res.verf->committed == NFS_FILE_SYNC)
+	if (!force_layoutcommit && (FILELAYOUT_LSEG(hdr->lseg)->commit_through_mds ||
+	    hdr->res.verf->committed == NFS_FILE_SYNC))
 		return;
-	if (hdr->res.verf->committed == NFS_DATA_SYNC)
+	if (hdr->res.verf->committed == NFS_DATA_SYNC ||
+	    (force_layoutcommit && hdr->res.verf->committed == NFS_FILE_SYNC))
 		end_offs = hdr->mds_offset + (loff_t)hdr->res.count;
 
 	/* Note: if the write is unstable, don't set end_offs until commit */
@@ -1149,5 +1152,8 @@ static void __exit nfs4filelayout_exit(void)
 
 MODULE_ALIAS("nfs-layouttype4-1");
 
+module_param(force_layoutcommit, bool, 0644);
+MODULE_PARM_DESC(force_layoutcommit, "Force LAYOUTCOMMIT after data was written (default: false)");
+
 module_init(nfs4filelayout_init);
 module_exit(nfs4filelayout_exit);
-- 
2.51.0.87.g1fa68948c3.dirty


