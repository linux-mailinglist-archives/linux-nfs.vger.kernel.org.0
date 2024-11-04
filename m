Return-Path: <linux-nfs+bounces-7635-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6A59BAB27
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 04:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1596D281171
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 03:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCE181727;
	Mon,  4 Nov 2024 03:21:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C541F949
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730690479; cv=none; b=KCk77Xf8xpz2dV7gIZGT0Bzot2ZXV9X/DdLadCBKWoaAZ/gzHMivxE0R/+0BjXjsq79Qv/1e15MMhxeDcUE2Tl3bLrazoUKGCQUY1XAQUI7wSWMFWwsI0KzNN5LG8U+gMNUBYiI1cytTV7IiKEiwXGXLBzJiClI/A+BsEwgzaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730690479; c=relaxed/simple;
	bh=vTDRIfyHPU9YUy5WVr7JRzxVEYyKJhWG+ZSFjk6cZ0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BeTEmXWQ4LYHyM8PyzszKN4QUGKS17g9Yxv0+RmQrchvhaCBCPOWbdSSvAKVEQKgyvTleDxHkZsMykdTIo95+ev31VjMrgq0P6la6XAzBI6Mk5pn69U/HoAqSBFXyL0qvnpDmpCUBdZutggpBtGtQ2wRUGDZOAFh6Uy9c7u502U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7206304f93aso3582400b3a.0
        for <linux-nfs@vger.kernel.org>; Sun, 03 Nov 2024 19:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730690476; x=1731295276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VT4PPt4DkBeBszjsoQGsT/L7hFgV+mX33QS+xu4gkHM=;
        b=GsEubWrK+reoyE8pT6Q34DlpYaVgDYnT02lYIXN9UCTatb9nkqmcmMqFY0d+VQ4y93
         xplcmiFFsio7VP1IHPaMH0mCCv0TMtuuB3I0P1+eWsuYTo9TkFIajrzjSaoQwtZGsQ/0
         MQAAgQKMO0bWGbZduFKmugKR1YwZCs1oLkgDbJ1hrDchE/nVGH9ZLaGfoQ58oU/jmHO5
         OJGpmIKgRtIouoUUi++kjox+dUZYjC0Ecpa87BYd1s2owiez8atPWKf87SeM10H6/YVT
         Z8IhsX7n86Wru6VbySeDPUv9M7h3eZpOZ3qTxUmpnS45MdLuDtaRHS7ehH+JX4g6HLtQ
         E2xA==
X-Gm-Message-State: AOJu0Yzax5bQWGRQj+h4PmW5nnigJYhBNc2AAueuWasMNawh6Z6NTCKq
	tb8595/CriOqRoi1vCW5hqGKKlaIfjx7TifubGcmyYTBdXzvXY4WXZgFAgIeQxU=
X-Google-Smtp-Source: AGHT+IEmaUx6z2XmjAhSHZorNdzikYHOfY+HN/9jD5OZ++3LN231H6M9YlkqfXwRwwC8vVMChU4lZw==
X-Received: by 2002:a05:6a00:3d42:b0:71e:4930:1620 with SMTP id d2e1a72fcca58-720c98a1baemr15912967b3a.3.1730690476318;
        Sun, 03 Nov 2024 19:21:16 -0800 (PST)
Received: from localhost.localdomain (144.34.241.68.16clouds.com. [144.34.241.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2f0c02sm6668583b3a.179.2024.11.03.19.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 19:21:15 -0800 (PST)
From: Ke Sun <sunke@kylinos.cn>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Ke Sun <sunke@kylinos.cn>
Subject: [PATCH] nfs: use KMEM_CACHE() to create nfs_page caches
Date: Mon,  4 Nov 2024 11:21:07 +0800
Message-Id: <20241104032107.196045-1-sunke@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the KMEM_CACHE() macro instead of kmem_cache_create() to simplify
the creation of SLAB caches.

Signed-off-by: Ke Sun <sunke@kylinos.cn>
---
 fs/nfs/pagelist.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index e27c07bd8929..4b84dd437dfe 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -1463,10 +1463,7 @@ void nfs_pageio_stop_mirroring(struct nfs_pageio_descriptor *pgio)
 
 int __init nfs_init_nfspagecache(void)
 {
-	nfs_page_cachep = kmem_cache_create("nfs_page",
-					    sizeof(struct nfs_page),
-					    0, SLAB_HWCACHE_ALIGN,
-					    NULL);
+	nfs_page_cachep = KMEM_CACHE(nfs_page, SLAB_HWCACHE_ALIGN);
 	if (nfs_page_cachep == NULL)
 		return -ENOMEM;
 
-- 
2.34.1


