Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865B440A7F1
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241695AbhINHkk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbhINHkX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:40:23 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B37C0613B1
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:37:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso2057934pjq.4
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5iPQxmNGx8c9eY92mOopijUPDhnAgGjqRDHLpg8cWBc=;
        b=KnZSj8IleHoM8Qx7qtmx3jQgoCMLpLoyaVdHTTemIHbLy0HrzLLLGL2+x8Wvaaut2w
         GfGAmMnE/WY1PQtlqD4lXmGKfLluDTSogGWQ5fTa2VSkpA2bbn+SHjpxleHUPRe2fXOA
         VuZgEkG6inLqa8VANrweOCbrTdb0r5FWN5luXOcT4540XcPRSjY6SYPCfHYDggNXT9di
         lS0LbesxwPuQlNRDJfWT6a1UIBefry9JgwLo4oLwVtYP/U8c8QUPcgBj4tqShi7FJDd9
         nyEh0jfTQFRcSbHb86SJ9ndHBs7qHNa9KKuGp3NcGROL/MUGCqcfvr1I+hyyoV/G/mUu
         NqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5iPQxmNGx8c9eY92mOopijUPDhnAgGjqRDHLpg8cWBc=;
        b=0iJ2gnnxeQJAW2WlWxlgNh0EnxZBW5Iet9MNlWqjt1qy61sLfbGUNG0s/xJLofvo9e
         zQPbzA9ViLjZwISdQHV3Om+DCzhwjheY4jT2z9dNseLzLSPN0VKYgmP8SG2GAdMmGN2s
         8xJTdxsfy1Uu+C7TS4ljosWYV1TZGfFjJp/ZpfTxdco3JUVTRVkj0WKaOL1ky9lBRgXi
         eA5cwhMuXmsynCHVUsrRLm+rpxJAAkEOeIhF8XJi36cRK6/budn5SDrLp6C9k0edNlfL
         kaCVw93WtrNUtXfpJ6Ut8yacMx0+Sx1f4gkk5lnTn5uhVn5n3RBJ7KOkU3Dc9eFIlyMj
         pkgw==
X-Gm-Message-State: AOAM5305Zlh24sMxPBj879lBadMDAko6fE9V0lKF1vtDZI7M5nFUPtJk
        yI9aRYAlb5zIldwayN6BtmzEng==
X-Google-Smtp-Source: ABdhPJxSG/kZh9LKDmkEuJyth73ipjaHCl1rtnOHTh4Hm2UylXX9XWCMskyVYqB8MJ5g19LpZwHl9Q==
X-Received: by 2002:a17:90a:d516:: with SMTP id t22mr558209pju.208.1631605031038;
        Tue, 14 Sep 2021 00:37:11 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.37.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:10 -0700 (PDT)
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
Subject: [PATCH v3 35/76] hpfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:57 +0800
Message-Id: <20210914072938.6440-36-songmuchun@bytedance.com>
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
 fs/hpfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index a7dbfc892022..1cb89595b875 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -232,7 +232,7 @@ static struct kmem_cache * hpfs_inode_cachep;
 static struct inode *hpfs_alloc_inode(struct super_block *sb)
 {
 	struct hpfs_inode_info *ei;
-	ei = kmem_cache_alloc(hpfs_inode_cachep, GFP_NOFS);
+	ei = alloc_inode_sb(sb, hpfs_inode_cachep, GFP_NOFS);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
-- 
2.11.0

