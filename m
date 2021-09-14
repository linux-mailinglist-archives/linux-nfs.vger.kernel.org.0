Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A0F40A82F
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhINHou (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241725AbhINHli (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:41:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516C5C0613A2
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:38:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f21so5369052plb.4
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8hlIcDfk0mow6llnUEv9/58AX1omPaJoCkY30fcKWY=;
        b=fGvI7crPN7y2wB7zugMSVMD934Rpx18owGNJqX667ywd7wjVyIEVf68TUocK6k8Biq
         0qxPe5D1SShPrdfucXUFLWGS3ekJaSpwv32maWMZRKeiCb8roNmC00EUhRyPN6kyCs6h
         eMrUxk+YqESaxDXnJRE5Ojjd7g/Y7cnlqzM5KVuGCmweYIh6v065qQ1YlyZsFq3bdjRF
         hh3i2wJdIoIPvB6++RUiegYh9oxErKNxyyw50T1L+zev55HJf0ChPw7lfmILcARbqI+Y
         itOpA48+irtTc+zZzxHwFQty9pb1lM6NTEzw+TiwKNAgMmrH05j0JRZllHytGgz30WYl
         1yHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8hlIcDfk0mow6llnUEv9/58AX1omPaJoCkY30fcKWY=;
        b=DxrQW1NtHjZx7LPgb6AILh3QV705M+hvTzcNc/FRUpQ8LgyjY4Wtt8EHq4Re4xfIxT
         VNyDJ6X6mUDdy2UZR/MPvoF4xu8IS9QWSnnMVT549eajRSpFZGUR8kC1S93gLWjYDVyb
         iHN5MTAS9p6D2rr6Mm5+nr/AUa6EBRdN7Nd6DuhXIeSao9TmCH75FAPD2wxa2vMwzOo7
         na2iRRfxeE5576wwEjEf4nPWC+4YSP5CnGERsYuNIndGlqO1HRwFBS5GareXJJJOWFRe
         1UdMIsjm4Uq02R9rS7cDYZJwY27c3S5xVDsqTbUwnF4s0T6hdDXcafbjDoceMOcs4gF/
         8Lug==
X-Gm-Message-State: AOAM5312JTDZ+WA5eow7u9Pfyy8acLejZJGFH9mq35Om1gevKI2Xxhwx
        73NuccUYJdPmaaB11ge1a7Cg5Q==
X-Google-Smtp-Source: ABdhPJwdMtQMYVXYBSOM8G6vlPmp0Zlhj0YG5SwPDq2spUGsssa5kLTHoX9Qr5rBUcowcrrjr8bl1A==
X-Received: by 2002:a17:902:dac6:b0:138:85a7:ef80 with SMTP id q6-20020a170902dac600b0013885a7ef80mr13793050plx.45.1631605086892;
        Tue, 14 Sep 2021 00:38:06 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.38.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:38:06 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 43/76] ntfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:05 +0800
Message-Id: <20210914072938.6440-44-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The inode allocation is supposed to use alloc_inode_sb(), so convert
kmem_cache_alloc() to alloc_inode_sb().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/ntfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 4474adb393ca..fca18ac72b4f 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -310,7 +310,7 @@ struct inode *ntfs_alloc_big_inode(struct super_block *sb)
 	ntfs_inode *ni;
 
 	ntfs_debug("Entering.");
-	ni = kmem_cache_alloc(ntfs_big_inode_cache, GFP_NOFS);
+	ni = alloc_inode_sb(sb, ntfs_big_inode_cache, GFP_NOFS);
 	if (likely(ni != NULL)) {
 		ni->state = 0;
 		return VFS_I(ni);
-- 
2.11.0

