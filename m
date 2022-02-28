Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E41A4C6C28
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 13:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiB1MXo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Feb 2022 07:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiB1MXg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Feb 2022 07:23:36 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7803070339
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 04:22:40 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z15so10992523pfe.7
        for <linux-nfs@vger.kernel.org>; Mon, 28 Feb 2022 04:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U9UWVHk9T3adw1sq6yWmWHY1AtUm3NeB5gtAS4YuIjA=;
        b=Cn/oKj8L8a2dI0vhpvOfrqdYlnnnQMWKP0fdx6Ho/fmH8C0d7VvKvifAir3lgu3LVj
         zz9QL/xaZlkDC2s5B5rU/4uGZNT98wniOY72Lt3Ow33/E6S2XahmvKMN6USM/WhsvF1+
         YBroEYTZLzHYU0HIeNU5hxk33UZ88dgj9h2q14okLwJw3JekYIXdt2XBuBLOhhJaAtHO
         gaxo3vFnwodKb6yAgxJtK4M2WPFQ4TLm9uOBoAvZEw3JSKk72pi9ybJTRN05IQ1smpzO
         x9PC6t9Xz50iGUX/p/xv2TGVNV6UgqRLl/8qFl0xmBvqEuFEj0c1s8eJk+Qls9DQt3Qj
         QwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U9UWVHk9T3adw1sq6yWmWHY1AtUm3NeB5gtAS4YuIjA=;
        b=fPmJbPFptcwM0uSjRvjNd21a0sIly7568IJEHTJT8qWz+XHp7djks+vuxti9u328F8
         ambNv4kXS6Jqzq5PClgBUwGmZDjmq5Eg41EzZlWtM+78253gFOQKxQAw0cbkurITT64k
         6sOn2/ujGXuAZ04HGuG8eyZGTCgMyBqAXFEKzQHWOd3VMWYYWUUpuHpCddUFpdvpEYXr
         tqNQUiWhdXaveDM+wd+5eErO1krV8Dzo8IQhgHFnuAdkgJ6l3Cly1/dn5lQ+MZUc0koA
         Xbb0CivCQxXeVAOSjbrSDCHNoX6Lsi6yhrOrWlTUJVoRlpgi8InkBrmQz1joEYanSauF
         2O4Q==
X-Gm-Message-State: AOAM531QC2NQYsanm/rjbApzWCiSDRsGuIv7Tax5w5X7ejplJ409eg5/
        XJCb+GlNtJv0UILTUqgZYQ3tOw==
X-Google-Smtp-Source: ABdhPJyHMGIpgjsEIefHIQeJS8Q4+ZmcMcAzf58DyeCmeti88YHU6keHhHtsuwJ2/dY8kE2J7Pgp1A==
X-Received: by 2002:a63:a545:0:b0:34c:9ba5:6125 with SMTP id r5-20020a63a545000000b0034c9ba56125mr16895096pgu.392.1646050959745;
        Mon, 28 Feb 2022 04:22:39 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id ep22-20020a17090ae65600b001b92477db10sm10466753pjb.29.2022.02.28.04.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 04:22:39 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        roman.gushchin@linux.dev, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com,
        vbabka@suse.cz
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 03/16] fs: introduce alloc_inode_sb() to allocate filesystems specific inode
Date:   Mon, 28 Feb 2022 20:21:13 +0800
Message-Id: <20220228122126.37293-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220228122126.37293-1-songmuchun@bytedance.com>
References: <20220228122126.37293-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The allocated inode cache is supposed to be added to its memcg list_lru
which should be allocated as well in advance. That can be done by
kmem_cache_alloc_lru() which allocates object and list_lru. The file
systems is main user of it. So introduce alloc_inode_sb() to allocate
file system specific inodes and set up the inode reclaim context
properly. The file system is supposed to use alloc_inode_sb() to
allocate inodes. In the later patches, we will convert all users to the
new API.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 Documentation/filesystems/porting.rst |  6 ++++++
 fs/inode.c                            |  2 +-
 include/linux/fs.h                    | 11 +++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index bf19fd6b86e7..7c1583dbeb59 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -45,6 +45,12 @@ typically between calling iget_locked() and unlocking the inode.
 
 At some point that will become mandatory.
 
+**mandatory**
+
+The foo_inode_info should always be allocated through alloc_inode_sb() rather
+than kmem_cache_alloc() or kmalloc() related to set up the inode reclaim context
+correctly.
+
 ---
 
 **mandatory**
diff --git a/fs/inode.c b/fs/inode.c
index 63324df6fa27..9d9b422504d1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -259,7 +259,7 @@ static struct inode *alloc_inode(struct super_block *sb)
 	if (ops->alloc_inode)
 		inode = ops->alloc_inode(sb);
 	else
-		inode = kmem_cache_alloc(inode_cachep, GFP_KERNEL);
+		inode = alloc_inode_sb(sb, inode_cachep, GFP_KERNEL);
 
 	if (!inode)
 		return NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..3d56b02667f4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -42,6 +42,7 @@
 #include <linux/mount.h>
 #include <linux/cred.h>
 #include <linux/mnt_idmapping.h>
+#include <linux/slab.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -3108,6 +3109,16 @@ extern void free_inode_nonrcu(struct inode *inode);
 extern int should_remove_suid(struct dentry *);
 extern int file_remove_privs(struct file *);
 
+/*
+ * This must be used for allocating filesystems specific inodes to set
+ * up the inode reclaim context correctly.
+ */
+static inline void *
+alloc_inode_sb(struct super_block *sb, struct kmem_cache *cache, gfp_t gfp)
+{
+	return kmem_cache_alloc_lru(cache, &sb->s_inode_lru, gfp);
+}
+
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 static inline void insert_inode_hash(struct inode *inode)
 {
-- 
2.11.0

