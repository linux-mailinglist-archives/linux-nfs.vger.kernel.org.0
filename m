Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDDB40A80C
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241770AbhINHmF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241507AbhINHla (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:41:30 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D189C0617AF
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:38:00 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id s11so11924439pgr.11
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ve9NmyEqViIV//dT1LdQKGfIMDinAsMmZ30wI0oWs1c=;
        b=EK1/Er6hRnVX2fZvCHsw8jkFa2Ov0/UEkz1sfPKz4MtyYRIdqAmwWsSyxtzaII34Nz
         9e83C/WbK0FuFRdNf91dfjq7dgGwtSNhk8uyhUMCzUu80LykfTTolGOAZVBRRERE/kYI
         3rYNpkJXSsaVMbdOfjreRbbNjkfn+/koajYsJ9jNXdQZ4O33b/pzTWEC3+bG+sjaJ7SX
         VWDLjdaBoB9i2RiWWJdxJdwSucyjxxkAx2LLpJhF7/Zq9fyIE2WQI5evsxwxJfVZegsK
         89iWFS2Mf9N0+v5ulDPu020wnvrnVNS5QcIsoELSBgldNohXdvu4JkCxEdF+FV7U8lTF
         Q5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ve9NmyEqViIV//dT1LdQKGfIMDinAsMmZ30wI0oWs1c=;
        b=l3GE5vkTLe8yCoHo760S1ynTw8aCycp6IsrBwUICSKYYo4sy05BQ2so2zLpRl55Tev
         zPQ8TXuhkeoui+EECITKR+EvjUvFt/NQ/89n1JO9bSXpsNXgeJrkLFcNXxWXlxXNKRbP
         6PCI/jP6ePn+YzQM9QUYsariNQ1wTGppSPVWvAVnaQ/O7qQUrMmhDfiOv9zjjuMEaI7r
         9Z/lESE0JDqaSC2L2MVZYC359OjXy/S/qpunSj4IaFp1kmOywvstXmUZbvutVnYFbm2H
         euTrDZ3JEh5BJl40zuLAW0uy4auc0qkC7ahAAYPgRr5HQwxzvxW2hwaf/iUR4jYrP61u
         p3wg==
X-Gm-Message-State: AOAM5332+VDCe5vEpSUtDaNKZlh32ezXLIOfZi0ZAWoizXYb9TSqU0xx
        JqlgtzN0qu2b4GEDXmgjEg8VLw==
X-Google-Smtp-Source: ABdhPJzeNhtU+sPaFsnWmu7S41gs1Nsar9HXfmTanwRyM0Ad3KnBzwvJjy1sI44y8s95uozfMgdnWw==
X-Received: by 2002:a63:da49:: with SMTP id l9mr14258029pgj.277.1631605080003;
        Tue, 14 Sep 2021 00:38:00 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.37.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:37:59 -0700 (PDT)
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
Subject: [PATCH v3 42/76] nilfs2: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:04 +0800
Message-Id: <20210914072938.6440-43-songmuchun@bytedance.com>
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
 fs/nilfs2/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index f6b2d280aab5..cf1de3ed9f8b 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -151,7 +151,7 @@ struct inode *nilfs_alloc_inode(struct super_block *sb)
 {
 	struct nilfs_inode_info *ii;
 
-	ii = kmem_cache_alloc(nilfs_inode_cachep, GFP_NOFS);
+	ii = alloc_inode_sb(sb, nilfs_inode_cachep, GFP_NOFS);
 	if (!ii)
 		return NULL;
 	ii->i_bh = NULL;
-- 
2.11.0

