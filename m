Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3054B40A7B3
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbhINHhz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240926AbhINHh1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:37:27 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D969BC0613A9
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:35:12 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 17so11941053pgp.4
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xmWs76ejJuWUw+NjSJEHDOglMzK6H3Rus8uSh5Y2LOI=;
        b=JDksD2X5hYyqveT44345REs/WzN6DpsF4haKOhQxw+stDMw1hW9W15EKVpprv4NkjO
         bGMz0nu4jvtK0ts1snJJN6W6+XK/9N9FHCz6ox/vwNR2JhGWnzGn0P0LYYSElIxQBFPz
         51MvliAcWVYcS+9YzCLetuAbutjav05WDWsS3qx852Ph1em7cIZj71+SCJfHKulx+z1U
         hVO+SdaZo9H80GydN6uL2xOToXA0yj9bNcHXqEs3qQdN696bPkmizb/XpTdgsur4623a
         t2Vj6nvM/q9BQz4JtMNGsNdm0GNNA30aRJTIpdfUYghZjJjOFgMkGQ7n/p1iBqJoHzSW
         VWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xmWs76ejJuWUw+NjSJEHDOglMzK6H3Rus8uSh5Y2LOI=;
        b=pcG2ccCzw/NP/EkQl40GZ0aWkBEAQ14Vt+BpQqaunUj7aNX9DxUHCLHkBGA3+B4ozi
         UXLysvHadq/Dmd6GYdZgLQSOijv1Aa9O8V3Smmc3HHmaVy2xHuIrRIti/y5dBCU1eoIB
         UPIKpFSTH3j90KkBr6kM76WkggRY6kRoN/XbEuLLSZkIaYHSOEJoSKGzqT96FSLXu79k
         k22gX8IWi2snelhAmraqnzR7hdGKgaSsVvwhErisdy/ONdufMHsdVIYJB1vEKkzTtWEc
         itD5t9iLhuml0L8vSDBQd4o1ljtEKI+pFshQ+pvc+H3yNuAmG5dZTvoi8jksRbekYOsP
         EU0w==
X-Gm-Message-State: AOAM533mFcjmOtCG56EEomAjejZNF+V5oxB4+8QpIhnVXy1lrnSlYm+s
        L3oVH3ruXzadyGvd6KKCC7eUdw==
X-Google-Smtp-Source: ABdhPJzTOnQngqhMuN6LTM4la+nLf6iQUU7SFedtJ54Vh2B0sOh1eoF37FRLMSQs2nF2EZ3GfRKUQQ==
X-Received: by 2002:a62:6103:0:b0:405:2c7a:9ee9 with SMTP id v3-20020a626103000000b004052c7a9ee9mr3457664pfb.71.1631604912429;
        Tue, 14 Sep 2021 00:35:12 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.35.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:35:12 -0700 (PDT)
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
Subject: [PATCH v3 19/76] ceph: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:41 +0800
Message-Id: <20210914072938.6440-20-songmuchun@bytedance.com>
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
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 2df1e1284451..96239d209bec 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -447,7 +447,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 	struct ceph_inode_info *ci;
 	int i;
 
-	ci = kmem_cache_alloc(ceph_inode_cachep, GFP_NOFS);
+	ci = alloc_inode_sb(sb, ceph_inode_cachep, GFP_NOFS);
 	if (!ci)
 		return NULL;
 
-- 
2.11.0

