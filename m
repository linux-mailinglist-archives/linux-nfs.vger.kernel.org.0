Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E439240A7B5
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbhINHh5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241021AbhINHhb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:37:31 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348A6C0613AA
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:35:20 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id t1so11936355pgv.3
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EeEIfsET3veEFyKZGMdqrIC7SmUJrf9uv2HTbxew7HM=;
        b=SV6JN5iimQBXUfCre6VlL7Lj4UTOZ7hKT3qLd58hiOph3ZbO9ARv9uURoQiK3OcGgB
         yOc8X2dDszH+dDEB5L+utQ8J22OjjM+CxD43vuPjMUSjhRUYCs/UVHUDRMLX0TKxkXTV
         wRffWVFQMVrkCpgaY2u6OSSNmvVc1VzQ1yr7ETOJ7dnQRYYK1ptqu+icFkFqkKSSazWN
         9oMcAcxrlXngjdZNFb/NncCXBi1ofb+fhVOFqxYxbzEBkoFsxX+Q0Cka16YxapTti6g6
         iC0MQdrk9x7ZbQNKn1GL6k1TfYNbvGn9YGclVnI5ZSqRnX+SMjwZv7WqqRVZsyoDNEdK
         I9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EeEIfsET3veEFyKZGMdqrIC7SmUJrf9uv2HTbxew7HM=;
        b=hd/Pp29dOtdhKjhkHfVpI7/HuhA+uMWqaUrPaU4vKAZ1LciS7xxTp0V+y1jBXcxUQJ
         vqDWS08w0wU64XH249RoUmJ5h2XjUuatLsCS50XvHVTp8jUHCRf6IowpADZs0K8X37tt
         7tb+hu3B8Qa0MmVKmP5mOKyPjCqPr66FaZdDUb3y+gZrKu6qW71XWKeUyINME3ot5eNs
         l6MWMt+7Lo6jx+ZZO/xQD6OUZpmIEs3DorvZSIOQD2GKFJTjpiLn3R6JCCjl6FO8CmiB
         uT+Y4yFPuyM97ygpPVtyA9hb11Z06LKRRY63tUSYb/lZ1m0HzBGuzoDLbS3ZuP9/HE/w
         mCIg==
X-Gm-Message-State: AOAM532E+5LI0nZusbfB9WwaeCAQ1OnLkHZs1RjWIE/7U73nePaU/cla
        MDmPYg2jGA++fqc+yEBgWzil5w==
X-Google-Smtp-Source: ABdhPJzJ3stl+34/hU2kXHce6y3rv3WtN0uv6gcgVBj8T8YLnolCz18rqWf5mghFAUOHHszaMxmR9A==
X-Received: by 2002:a05:6a00:a23:b0:43d:e856:a3d4 with SMTP id p35-20020a056a000a2300b0043de856a3d4mr3381701pfh.17.1631604919762;
        Tue, 14 Sep 2021 00:35:19 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.35.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:35:19 -0700 (PDT)
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
Subject: [PATCH v3 20/76] cifs: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:42 +0800
Message-Id: <20210914072938.6440-21-songmuchun@bytedance.com>
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
 fs/cifs/cifsfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 8c20bfa187ac..7c239ba551b9 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -355,7 +355,7 @@ static struct inode *
 cifs_alloc_inode(struct super_block *sb)
 {
 	struct cifsInodeInfo *cifs_inode;
-	cifs_inode = kmem_cache_alloc(cifs_inode_cachep, GFP_KERNEL);
+	cifs_inode = alloc_inode_sb(sb, cifs_inode_cachep, GFP_KERNEL);
 	if (!cifs_inode)
 		return NULL;
 	cifs_inode->cifsAttrs = 0x20;	/* default */
-- 
2.11.0

