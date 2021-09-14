Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6774840A7FC
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241184AbhINHlQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbhINHkr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:40:47 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B236DC0613E5
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:37:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id bb10so7607443plb.2
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ug2CfhnpXnTircvAyexMndzlOWvwUpbYkNH+XVMb7RY=;
        b=t+GIzASmHdVakA4h5l+IAozDzezhapoL3sp1pcm/t65BJX3rutl/KWV3Qm2QPbhjYz
         p/rRF+BphO+PrkXJilhr3xhnO2wB5hDhNE6uCCqWfyVH7Ad3pGBSIAHJO4FrLzNTrf5e
         ETmN4X1zqYqSimY9WNapyBUeOuVYn2nimycKQaUbBsdGVsSbuaNK4u+TDxc+R0bX+bnM
         akbw90cRwY9ax0h7jalRVbH4jUogRZITjRvHfLnF4Nqf3lSzi4bs84oRMgVMniknUq9V
         Qfq9QagKXmezJpUEaHacD1HAxC+kQsE5jjYZ8RLPY0/r/TSkhgNd6NK1BBdl5049vaD+
         eZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ug2CfhnpXnTircvAyexMndzlOWvwUpbYkNH+XVMb7RY=;
        b=uODyQAG+AlJulK56zQC9ko67LHtnPYildHVfWwzjuyDquWqyOqJVCsV6tSuPOw5yGw
         aJ2lempp1912FpPLpeVW/M7x2pz3RKmwtHTq8f3odkxRCT5rY4H2Urs9TsEfxx3zOUx3
         Nu8obZbj4M0fIDpUqXOfEUr1ecccD24pXqbvg0utdBijDLXLQbnt6trwbez10KM+M08Q
         ZDJdK0U7Wud6n5F52u0XAG//jf7QofouyrZP5NCP7lK/n+oj6cDrwWINxouYIhDdS3Yl
         ZncbxVFBc+j6lmKCyYGVOgexrwWdliZpdue4BryMwia7RqK+GBJBgfRImg+mbJFEUhJC
         xuJw==
X-Gm-Message-State: AOAM530QZhhIF/wQUjLzA2yOGntNpp4X9fcgbmPmKcvY6jypgg+LG9WO
        0+MqtcpPpQjh1G580P+ZjYMkfQ==
X-Google-Smtp-Source: ABdhPJzoEWc0JweX9N6Ga3zaYNr1bmeJZgLXN1Uyt173hJeXuTknck19EkElbOg2kxH46qCDstqdiQ==
X-Received: by 2002:a17:90a:ab07:: with SMTP id m7mr551052pjq.27.1631605060269;
        Tue, 14 Sep 2021 00:37:40 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.37.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:39 -0700 (PDT)
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
Subject: [PATCH v3 39/76] jfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:01 +0800
Message-Id: <20210914072938.6440-40-songmuchun@bytedance.com>
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
 fs/jfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 9030aeaf0f88..5e77b5769464 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -102,7 +102,7 @@ static struct inode *jfs_alloc_inode(struct super_block *sb)
 {
 	struct jfs_inode_info *jfs_inode;
 
-	jfs_inode = kmem_cache_alloc(jfs_inode_cachep, GFP_NOFS);
+	jfs_inode = alloc_inode_sb(sb, jfs_inode_cachep, GFP_NOFS);
 	if (!jfs_inode)
 		return NULL;
 #ifdef CONFIG_QUOTA
-- 
2.11.0

