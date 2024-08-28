Return-Path: <linux-nfs+bounces-5891-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C32963414
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 23:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAB51C216C2
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 21:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E971ABEC3;
	Wed, 28 Aug 2024 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="vfWXKgX+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AE1A76B5
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 21:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724881428; cv=none; b=IyeAOJ7WiU+F3Mmz//meCJlxKdJdYiXlvIrH86bnL6TTgMHfHeseH5GXw0xo9XNkKD0ve0LJGmtwDf1aH2H+ysUy9ilpnBHRVHxM05coJq7L1Gv5xtZwRmeGzevXSRVaOcW2b5mqYTw5HQFjpZk0JEKnF3VL8ecoj0yfqmeiL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724881428; c=relaxed/simple;
	bh=Ow2Oa4aH4/GHsxj85ciXs/uy/FkW9Ju27sF6MW2bpcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gu+EQli3mVUd/WokgJ0vcJZ3ANhLc9eN/QcIDVfa89jL7sYVBHu0fie03IeZeD+R6g+cDlt/BPC91fyn+MDSRbfczA6C4kUjw5ckoepjUOdWcv4AUQ7pSKhhI2hWIvl5vdNrkau05dxoh2VlLJrUaWOnU/MOqa9V//A1lnex5vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=vfWXKgX+; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5bec67709easo1062588a12.1
        for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 14:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724881425; x=1725486225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BgIVeN+hwaa3Zj0bf1QjMz6FtGwxuk1uApKAVTuU21M=;
        b=vfWXKgX+2K5KPbnS608WoYeqWciqY8iHwgd8Xu7QlXUmoIOt0jH294T7jtaxn19/NO
         x59rv06Pzh6QwE7b5ZvxOqjBiuRRksNMUucoSO4OqkTTrBv5CfHmE8cnJ6MoWUk/4VN3
         5PXgQxxw30aT8rD1mAi7t4sRmPgElGmjqL5DHe7NE1iBzYikRCxG0NKq4DY+IyaMXlmW
         68VWITSE/RglbUljesTD3Eo+G8/UMpxGSNjXAhLZdwrKUMc9r6xhVWMhO8GH3kLfbnn/
         RoaQ5mXXyn3CgucplE5wvRHngmen+AMjH0rw11wbjy5XxUYpTd+/UK7smVh2dWLrYwtF
         m6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724881425; x=1725486225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BgIVeN+hwaa3Zj0bf1QjMz6FtGwxuk1uApKAVTuU21M=;
        b=VaSW9Wn0odq94W56dcGFPTE6xb/sU2zwVyy2qlVRNgfWfuUMZxjz8kXp7EHtRYlPdN
         5qx00vUWRcaUbYCgzHq74dq30VU+6BgbKnYmeZ4uDS+k4mn8C/Stl4JHaAfF6CflAQXL
         5RmdzVvotT7R6oDNvUcCtEBbXNT+Ped4OdeCn/HniFts7kti3smXaknAxTXwf1bL1vsA
         yhLTIJp84QIqy9s5K9BnHRh5e3GWYELBOcIO0d6TW8xf9pR7HQ8wJXJcduO7zWW8V52f
         B/Kc4fQG6OO1XvqBS+lcBHhX/+ul4fG4as5wB42cq0i4r6Ooxnjw8OGjQUmHdFvsBQN5
         1H8w==
X-Gm-Message-State: AOJu0Yz9pbk5wA0ShJSEDCqYEjaLBnHpejVqh0u+XnXA9RfkumCNsVlh
	31FSbrerpKlCXv0Vj3WeZmk6O8yhtXHxz2QvjtX00MqbvJP3x6NBIbVZvyPluRg=
X-Google-Smtp-Source: AGHT+IGDaFnNlopk9OtBsTjpt60u8SdH1IppPU/d0oIAgCIrSzY8jx0IxHyYFQ2PotXqk9B0nC9M4g==
X-Received: by 2002:a05:6402:4314:b0:5be:9bc5:f698 with SMTP id 4fb4d7f45d1cf-5c21ec639e9mr406264a12.0.1724881425416;
        Wed, 28 Aug 2024 14:43:45 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb21399bsm2739670a12.50.2024.08.28.14.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:43:45 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] NFSD: Annotate struct pnfs_block_deviceaddr with __counted_by()
Date: Wed, 28 Aug 2024 23:42:55 +0200
Message-ID: <20240828214254.2407-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
volumes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Use struct_size() instead of manually calculating the number of bytes to
allocate for a pnfs_block_deviceaddr with a single volume.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/nfsd/blocklayout.c    | 6 ++----
 fs/nfsd/blocklayoutxdr.h | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 3c040c81c77d..08a20e5bcf7f 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -147,8 +147,7 @@ nfsd4_block_get_device_info_simple(struct super_block *sb,
 	struct pnfs_block_deviceaddr *dev;
 	struct pnfs_block_volume *b;
 
-	dev = kzalloc(sizeof(struct pnfs_block_deviceaddr) +
-		      sizeof(struct pnfs_block_volume), GFP_KERNEL);
+	dev = kzalloc(struct_size(dev, volumes, 1), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 	gdp->gd_device = dev;
@@ -255,8 +254,7 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 	const struct pr_ops *ops;
 	int ret;
 
-	dev = kzalloc(sizeof(struct pnfs_block_deviceaddr) +
-		      sizeof(struct pnfs_block_volume), GFP_KERNEL);
+	dev = kzalloc(struct_size(dev, volumes, 1), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 	gdp->gd_device = dev;
diff --git a/fs/nfsd/blocklayoutxdr.h b/fs/nfsd/blocklayoutxdr.h
index b0361e8aa9a7..4e28ac8f1127 100644
--- a/fs/nfsd/blocklayoutxdr.h
+++ b/fs/nfsd/blocklayoutxdr.h
@@ -47,7 +47,7 @@ struct pnfs_block_volume {
 
 struct pnfs_block_deviceaddr {
 	u32				nr_volumes;
-	struct pnfs_block_volume	volumes[];
+	struct pnfs_block_volume	volumes[] __counted_by(nr_volumes);
 };
 
 __be32 nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
-- 
2.46.0


