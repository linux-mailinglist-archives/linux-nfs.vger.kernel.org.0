Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA43440A821
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhINHnd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhINHm7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:42:59 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB1CC061762
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:39:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j6so11045289pfa.4
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KLwSLItUUbxEPpVEnwv3KG1SZ3tGwAvn5sD4ZvAasTc=;
        b=nAekrZ8SZV3otNsv32xt5cXXTDRyz4rT+/2mGlHPWBZbfrdUVcKCVDBgu8lz9OFr6Q
         eefiAutrNR4OdBSiICnIdWzqTRfYHRW6CswBOzvni1kLgkveu7Khy9o1IC/yvwDPujPS
         ZbxDI8uDhYmPVAd+UYaKviTFfTiXARERhu+zHzKgMBHWWL9CFU9ADUYjrMvuQxN6w0gx
         Z8Qydwqs05G8IC/KolxN6Co9nr/vCbAxYUyXFQi39XcZ5/lGoawvabIkbyECvq6+5ij7
         Cc/D2RObnncaivMpGinm1j17jyADvl/BDxd+Lh4/3v2709eHMswvJCUQ0eVloEbvF9hY
         JAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KLwSLItUUbxEPpVEnwv3KG1SZ3tGwAvn5sD4ZvAasTc=;
        b=p6poRQVY5KnH7+gfwKYr1I2srq6zHHG1s276FWqumb/MWW97za9sjnboswVDzWD8qi
         xI9S2K8n1stOKl1nLnlNJ45UhCp3pO1Mij9gXh5bKTbKwnSj+qXLJOt0yDuinS+L+QYE
         D46+vyvvNUs2qR2Z+x3vVUaO5wqaJXeL1lruwT3Q3N+/xK8CclQHC5aXRSc/Nr6FuxzM
         VqR55vCrU9a4BchZoVg4p/1rgW8qu1HU1cM+Jmulbip7I9V2d1hAsTSsBS4fBkuGuJDe
         CTPbuyP76mm565F8V5swuEvjiZYC3ipp0YRF/pxOmb2E78x0ZhbIHyZwc7xYc/XytFWb
         MubQ==
X-Gm-Message-State: AOAM532QcqkbxhsPotEuXXrR6zPQOOyxErDek6Ups2oFMFwju+3byWr/
        vBn5kGrKaPhYDlL/bf3bN81C4A==
X-Google-Smtp-Source: ABdhPJxyAZ06R6AcjWqBJbE24Y8W52oJPZDJl4pJ/f0ZzGzzDT6XNSmTMLkWlGAnZpRhNGK7SmMRKw==
X-Received: by 2002:a62:1d10:0:b0:408:9989:3c88 with SMTP id d16-20020a621d10000000b0040899893c88mr3374356pfd.22.1631605152160;
        Tue, 14 Sep 2021 00:39:12 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.39.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:39:11 -0700 (PDT)
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
Subject: [PATCH v3 52/76] romfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:14 +0800
Message-Id: <20210914072938.6440-53-songmuchun@bytedance.com>
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
 fs/romfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index 259f684d9236..9e6bbb4219de 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -375,7 +375,7 @@ static struct inode *romfs_alloc_inode(struct super_block *sb)
 {
 	struct romfs_inode_info *inode;
 
-	inode = kmem_cache_alloc(romfs_inode_cachep, GFP_KERNEL);
+	inode = alloc_inode_sb(sb, romfs_inode_cachep, GFP_KERNEL);
 	return inode ? &inode->vfs_inode : NULL;
 }
 
-- 
2.11.0

