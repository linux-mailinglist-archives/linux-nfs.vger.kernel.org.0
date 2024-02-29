Return-Path: <linux-nfs+bounces-2120-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0478786C5BF
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 10:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8E91F2599D
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Feb 2024 09:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3193D5D8EA;
	Thu, 29 Feb 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="paQ5zlGJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD87E5E22C
	for <linux-nfs@vger.kernel.org>; Thu, 29 Feb 2024 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199705; cv=none; b=KbYZdMJJ+X2vik+2aLXcYxydjALL8gLws7L6vmeFxDmfXnnij1GZgSS/ygzsgqPrr4J8cVIWilcRrrJu5E3UL4EfSE741tO5oWtyJ/zQTRpgkSjvtP+8GXS0cmA2ZXFNvK9MSVQpA3STSG/HH/tjhEdo+odSmPs/xe4CdKD14qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199705; c=relaxed/simple;
	bh=DQqEJFJ7y8jsUuMKERh72VpYIEhpg3pXaFlWwgkrDLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YVUdpqQdmLgG/8qbpKU8YFMK3hq3PeaMNA7Z2evy3+zyJLbBX6VPtm+Fba2CvVE5In47f+sRXu3UhBXA5b1zke8GJ9RCnPnlYhvyldZPkQz5nc2AK5XM+4NwXmScdTiA2dCWZO+F5jSGMe92TgQPjYdffGsFK3cSwtQEHLDbnn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=paQ5zlGJ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709199700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GegLNLHxIoI8+sAVk+Nsq6tpYyLvBJO09+R/NY+xICI=;
	b=paQ5zlGJwdN9jhx5pltEjtzoSYBlz38SJveNEt3lDPc0DI3qizX4k5Oie1Widz4gpN41H+
	8bWyFHIkxf4hRKv3IHfQSMSNyngkZ5TiiVvmTzM400NDwcfv8ivLQ3UsSOfvvW1MMJ5wMN
	a49mi+7PZM70VuReMkyrFCVU1Fp2qzI=
From: kunwu.chan@linux.dev
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] nfs: use KMEM_CACHE() to create nfs_commit_data cache
Date: Thu, 29 Feb 2024 17:41:12 +0800
Message-Id: <20240229094112.1154644-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

Use the KMEM_CACHE() macro instead of kmem_cache_create() to simplify
the creation of SLAB caches when the default values are used.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/nfs/write.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index bb79d3a886ae..6a75772d447f 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2148,10 +2148,7 @@ int __init nfs_init_writepagecache(void)
 	if (nfs_wdata_mempool == NULL)
 		goto out_destroy_write_cache;
 
-	nfs_cdata_cachep = kmem_cache_create("nfs_commit_data",
-					     sizeof(struct nfs_commit_data),
-					     0, SLAB_HWCACHE_ALIGN,
-					     NULL);
+	nfs_cdata_cachep = KMEM_CACHE(nfs_commit_data, SLAB_HWCACHE_ALIGN);
 	if (nfs_cdata_cachep == NULL)
 		goto out_destroy_write_mempool;
 
-- 
2.39.2


