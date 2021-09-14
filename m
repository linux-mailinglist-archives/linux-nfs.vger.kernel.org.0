Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375FB40A840
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhINHo5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbhINHog (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:44:36 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BC4C0611C1
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:40:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j6so11047972pfa.4
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d7/YayZrshcF7Mwrc2QA6L3YOuEA3tYMHuJ8BscQyJk=;
        b=z9t/5nzUvwFyULnC4TA8PMncxhfHbGYcOY/JnfGiZPat2l+jPZ76aJb9o+Sh412CZs
         zU2QysWuiqUVdhHU/4IuVhePtFuR7J8aMaiYFfC2uaZWt8p4ebDXUN7RoRb2cGXSGxtL
         wwd5vXhsOZ3GtuIFOdYDLierUO4oVjKlJIxua8wx0ZImVGGAAI4uUQSMC1LFZccKiOpL
         jAeCcr2gT9ChitIj1NoDoqSOAP/47HG7xwFeRdD7oyqGLV4QV/4rWwWfI04JpFm59kyx
         1gUr7iPKr9SQ9o3cB4B0URKzG5HTMDVr7mhm0cyuD6V7Ch6oqD+qhpzCl16b0Y7TROUX
         4tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d7/YayZrshcF7Mwrc2QA6L3YOuEA3tYMHuJ8BscQyJk=;
        b=McaNMKmdPGWs2xHHXj3HMOvpqKq2WitJ9w+fqT+RLHcsDXd6TM6hwTwJzUjMeV2+zw
         uw9zyjoGKwTw6GMg49v3b5BItcpMe0EE/j911IUG6LX21MNNVqjM/Dp2+OcKPZeVljHm
         UY+85EDWg/1+4vVZWEAE6JIHyP2JLJJE8lpVVgW4v0nMV4DzSSPjijmsYhytbQ2t540S
         52kn2X+9pSo1PKB2Eu00a/nehJKnQkGfTsn9u6leZQ7j93lncHrmusighawZVlNJX4x1
         ubpuws3uYyq4vGOuEghdU5IrX2N1IPnf09fGFOiTak79kRGEOQzS9Gs/X6svCUPv2tTu
         vcJA==
X-Gm-Message-State: AOAM531VNO9h/gWXTdUe7A1fVeZRg/cCQHmMmVZfaGuLe3X9vJqqF/aX
        Ae6Wj5ljpX12EGYUpAslcXdRhw==
X-Google-Smtp-Source: ABdhPJx4WMylrbowlkfveFjBUl4wg3+euB+A0opiDR8fYsKryJNGlR8lQaUcijHeFf/jEbbrdD28TA==
X-Received: by 2002:a62:6103:0:b0:405:2c7a:9ee9 with SMTP id v3-20020a626103000000b004052c7a9ee9mr3475258pfb.71.1631605223847;
        Tue, 14 Sep 2021 00:40:23 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.40.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:40:23 -0700 (PDT)
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
Subject: [PATCH v3 62/76] shmem: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:24 +0800
Message-Id: <20210914072938.6440-63-songmuchun@bytedance.com>
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
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index a5ae8266891d..541bdf61113e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3738,7 +3738,7 @@ static struct kmem_cache *shmem_inode_cachep;
 static struct inode *shmem_alloc_inode(struct super_block *sb)
 {
 	struct shmem_inode_info *info;
-	info = kmem_cache_alloc(shmem_inode_cachep, GFP_KERNEL);
+	info = alloc_inode_sb(sb, shmem_inode_cachep, GFP_KERNEL);
 	if (!info)
 		return NULL;
 	return &info->vfs_inode;
-- 
2.11.0

