Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B73940A7A9
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbhINHhj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241190AbhINHhL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:37:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F87C06139F
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:34:51 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t1so11935460pgv.3
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjWc96NEUs6s7TrF4a34Zjvbmk/0I5a9KuSsKKY3wE0=;
        b=LSRVxigR9TV6L4sW0giLifD3wXvbbKTZJtKARiLKQQ87hPDTntWnpQWvgk/EDgH1QK
         y11hFiCRcoQ8N9dbJPCY1PcS3wFBxFLm8stjmvNXUERO3mkQZBzZrHBApNEQ+F3kkqqc
         avKHlPNvPyrFe1WTpOQHaSyqBBb1i+h9YSSkR6k4qKLFi8tbW4WNbXGIwGBGdBcpYv0I
         twJ+REaIoFw6hO8SgePsjYrR6ls0q/6l60h2jsGVamrP/M8MkGgdXRq0quiDnnmO0LQd
         O4tyfLiklmavjZgJ21b0VEJP9zZsCF60WQhmn3cxKMdpmoLeGHkCywP0uccxCkGC2hM/
         d9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjWc96NEUs6s7TrF4a34Zjvbmk/0I5a9KuSsKKY3wE0=;
        b=12TJzdxGzdeRj+0CrkTX7crtcBM5z7c+GzjCndwUdrY8Oz25TQgFFXUxSbDowQTYcE
         Ubix0+9bWRUNmzMqy0qQ+uoqjnBCq8zHKud8hnvGioWRlTZDx/sChvSl4dcYeoTYSFlw
         3MY9xNkN6n15kOFi5/V/Rm133L3Q3c0dSwIUFqPmieXtE7HxTzakw1ezF4jr1FFqGKbb
         gl1ltXceyvtuHbUdc0Zu2Xajy6TNWRGXtmFJzy8WR7erMikzA7BMjgbY33KmRuicaotb
         tclFpnM5cFoRJ61zA5u5szwaIyfORabsyZLh5MaqIyvHkESXuWXdPiEFynffBRx7uX/A
         CaTQ==
X-Gm-Message-State: AOAM531zCchvtZasy4guNQ0ATA2zzA2qxMooJnZ1+0NdOPpPqQDCw7bN
        yzKdU3BfQ3XDERm9YGoCQnHgJg==
X-Google-Smtp-Source: ABdhPJxg86ESorqNYMXvCUenUrVaUzZd3b3PjzqVkJtZLoGKUDeAaasbk6Ch1PlreCRMxdscS5OpQQ==
X-Received: by 2002:a05:6a00:1147:b029:3e0:8c37:938e with SMTP id b7-20020a056a001147b02903e08c37938emr3315273pfm.65.1631604891102;
        Tue, 14 Sep 2021 00:34:51 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.34.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:34:50 -0700 (PDT)
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
Subject: [PATCH v3 16/76] bfs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:38 +0800
Message-Id: <20210914072938.6440-17-songmuchun@bytedance.com>
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
 fs/bfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index fd691e4815c5..1926bec2c850 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -239,7 +239,7 @@ static struct kmem_cache *bfs_inode_cachep;
 static struct inode *bfs_alloc_inode(struct super_block *sb)
 {
 	struct bfs_inode_info *bi;
-	bi = kmem_cache_alloc(bfs_inode_cachep, GFP_KERNEL);
+	bi = alloc_inode_sb(sb, bfs_inode_cachep, GFP_KERNEL);
 	if (!bi)
 		return NULL;
 	return &bi->vfs_inode;
-- 
2.11.0

