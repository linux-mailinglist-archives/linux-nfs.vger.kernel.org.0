Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE70A40A7CB
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240800AbhINHiq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbhINHiT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:38:19 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E197C0613DE
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:35:54 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id j16so11358718pfc.2
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A8uxqiMKUHvgeYQ8P0CzaQokEJZlDPF7mc7vXHBGFco=;
        b=WtscQXkYsvxZnVK2jTa8msfCsrFpBoyEz4ciJVFGQ6E8TMWZF1FSwrvAgQ7ARQBdIn
         NbTEmVeNHebG+gbjwZFqNDxL4WD5KDVWZ3jxnk03vx7gB3D6NLkGpHPbMmcYEQJwcbPH
         MbpVJ/keP9PIby2gW3we45Nn9CsbDo5ajHS7o2NEqtmO2T76UGZuO5G5YVaW9ue/g7P0
         RxuXerlPLVAEXR6scvrJStN3Gq1kgpxm7OReKAl0GwU0PnaPOMRMn+do540czlu79ueM
         RFPpQoWffofEJohRh8OouRBxFt8bZMXzTLqwNXQycKESSOBkBgfdJscHDMUHcLK1cg9C
         Dk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A8uxqiMKUHvgeYQ8P0CzaQokEJZlDPF7mc7vXHBGFco=;
        b=5Lmc5dyb4pjNuFkcto7N0Xjwb2tLYhNOcExRLFuLKRItrSlR4ed6sMHcHFKaeb1v5m
         n2fdQ1+mv8QaLWZIioJhfUI0aI6afzXSfQMqFe6s4NxBPdSgnMXZSb1q9jNTufAByBnO
         UFAsa2hBVFhjggsH8rzKsyrfpI/WS1I6XoWJl7E7xAybGJldrRx3qQlsBZ4gxFT6PDmq
         5anyP24B4cRqjDeqhMk4mMzoc3SA3ktZ7jVqjmlJnCZ7JtFA06fCXgJM51m0OsX+c3no
         iJck++k6HwkLhegWIeqte+zkCXvPUeoS41wZOaTQmIzio3XDduIHuvD7R7P1pNBILYxy
         tMCQ==
X-Gm-Message-State: AOAM530bvCjiuZE5iwGDuCHyJ2ukLwTXyqHT6bEqPcKxj5LjYzRRu54n
        A9+6PUeSLTx0OVt1MhYWDWOI4w==
X-Google-Smtp-Source: ABdhPJxfgZ4TY9n/BWFnWgjWloOD0RZB8Jk7Ek9z+15b8lVPKT0ekWcID8XfPLnd+CWwV07YiajNDw==
X-Received: by 2002:a62:798f:0:b0:438:faa3:5508 with SMTP id u137-20020a62798f000000b00438faa35508mr3352807pfc.75.1631604954081;
        Tue, 14 Sep 2021 00:35:54 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.35.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:35:53 -0700 (PDT)
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
Subject: [PATCH v3 25/76] exfat: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:47 +0800
Message-Id: <20210914072938.6440-26-songmuchun@bytedance.com>
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
 fs/exfat/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 5539ffc20d16..1b24c9f61be1 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -182,7 +182,7 @@ static struct inode *exfat_alloc_inode(struct super_block *sb)
 {
 	struct exfat_inode_info *ei;
 
-	ei = kmem_cache_alloc(exfat_inode_cachep, GFP_NOFS);
+	ei = alloc_inode_sb(sb, exfat_inode_cachep, GFP_NOFS);
 	if (!ei)
 		return NULL;
 
-- 
2.11.0

