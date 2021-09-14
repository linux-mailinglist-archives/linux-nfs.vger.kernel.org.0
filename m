Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8477B40A81E
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhINHnU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbhINHml (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:42:41 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C03AC0612A5
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:38:59 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id w7so11912421pgk.13
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tfJW48CdajlpEr//bxTkoQM7dMrKW0BR9obc+XDZx8=;
        b=CzL8a0WJBmY6SwGPNmLPx/k5vpDf+8VMg88jAVRQqxI8uyOwWeyOnsuhUhU/l4kER4
         aeCe0udAbcUb4GAWt+t4EiUTZISaqaxp9peXfdvPVoL6noWYo8M4tGGheg9uOHYG6eNH
         669wezAhWuJ+BeY+qERd2h0dSfMNu3A1VXQpepM5IxdgJP3GPE/NYVV1mt8MRnYwIHy3
         96nb+luBrrhhMhM1BKpvpW6D9q1HKlWm2VlXh6nCJ2Vwkboqw/4eP7WwyPFXaMcNBbPs
         3oFL4FKE29we0HsXSFnG/rI4aRI31n5M7t6jKM0YMjHXybZF1bwIBf/zRktmC3vze/+Y
         Xwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tfJW48CdajlpEr//bxTkoQM7dMrKW0BR9obc+XDZx8=;
        b=bojxdc1eFfqtUW6c8r6IzrbWZL7IukdDJpWux4PkrI/RcnlYwW7eIfInAgzFBqAcYB
         CX/wm2qxZOHhcAiofiSA0BAaxJoMGON/8cKo9OAw6Y85X7BYIhBXVrbLT7qiR8J/1fvi
         v6EMZHJOhu3K7cAnC7kQitu1WmdRlOisMa/O3H3+4pHtrLqmjCz7GgO85jGOxIeDMHJN
         fW7KkdTzdOv9Y0vZHqQYtaRt1ADQRQVbUzshkVXH0kqvmxfGmybRxlHBzaA2iHf6+5dH
         m4i1+bkjrrKszEmSQThgbimYOhwh5k1tQohVq1NVmn/OgI9P5ddUk9rwvH6AEnvgii+z
         pSyA==
X-Gm-Message-State: AOAM532ZK98lwASM53WtCSTlDmTDRMGh/IJQKdsGjBZn4AYduVomYM26
        hzAb0HK2JwjFQWK8Lwa2OjfCtA==
X-Google-Smtp-Source: ABdhPJx7F/RW3Hj4k+6kLMVkWPhpu4fKdKubdGsytH2FezipocHXumP+ARuMMHC88pPtbi/407OOxQ==
X-Received: by 2002:a63:cf41:: with SMTP id b1mr14330436pgj.407.1631605138942;
        Tue, 14 Sep 2021 00:38:58 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.38.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:38:58 -0700 (PDT)
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
Subject: [PATCH v3 50/76] qnx6: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:12 +0800
Message-Id: <20210914072938.6440-51-songmuchun@bytedance.com>
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
 fs/qnx6/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 61191f7bdf62..9d8e7e9788a1 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -597,7 +597,7 @@ static struct kmem_cache *qnx6_inode_cachep;
 static struct inode *qnx6_alloc_inode(struct super_block *sb)
 {
 	struct qnx6_inode_info *ei;
-	ei = kmem_cache_alloc(qnx6_inode_cachep, GFP_KERNEL);
+	ei = alloc_inode_sb(sb, qnx6_inode_cachep, GFP_KERNEL);
 	if (!ei)
 		return NULL;
 	return &ei->vfs_inode;
-- 
2.11.0

