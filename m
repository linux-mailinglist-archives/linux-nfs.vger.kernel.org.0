Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8F5473255
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Dec 2021 17:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbhLMQyr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Dec 2021 11:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241055AbhLMQyp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Dec 2021 11:54:45 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24004C061751
        for <linux-nfs@vger.kernel.org>; Mon, 13 Dec 2021 08:54:44 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so13809035pjb.5
        for <linux-nfs@vger.kernel.org>; Mon, 13 Dec 2021 08:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s8LWBVAbOYqYnLKDnLn1dN7nJhLJCQoGJHk1oKVhcUk=;
        b=WuKsQo0fw2nn9BpUCQz206FIeOWFQMpeF0G5UdA1t7Q5pGN7VbJDbm7T/R9CZj9pi+
         Sz9odTrwdfIJ80CznxuK/YFdkpYEdt8LOF4cOR14HY8EFLUQXxcFFI9U0AxRnT2afYXo
         I6szIUiAjGx5u7H8/L5WJB5PYOA5ybcVz5vWf+Dmfk0CgxXrwfFcO1nJbq1i4Wd/IccD
         VpwX+8B1JcBEifkyZ3MmM4T2YmbbvmTyx2/2z2T7rMG/AiMuCvugTpIuUrwmHg/9pHYG
         9doLoiij89Pkx5FgNBGJ7apViE3ggVsaBATjuNPIOt5hUWhwqyIlx0zjqiZTi/PaVAME
         VWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s8LWBVAbOYqYnLKDnLn1dN7nJhLJCQoGJHk1oKVhcUk=;
        b=ZWY0oY8eF5+CY5WrKXlrOYlXAoPs9QdFqp/4Xsy+MQDFQk+olKrnIUBQiAUywlukTZ
         Wc3PegtlTIWtSQFKdsxJwi705OqW0yFj7k8uuFdkKtBU3SvdkBGFxMpY3lQZz+UTpfez
         7ghTO/grHqVHvCmgBm2YuB9EpWxmnngvTXf0MLuTbqU2CwY/5IRADn/08tLXexeBob50
         REPOmrmTHXWDP/wy00uC/WUcKk3hPQQov3RoNXnM34i6kasP6h8iK7+1YUHj6zWPAjNI
         OgziFlYNbU84jPAbO71NB8kztsDPKD4uMUyhZll2UJHHE79mwnEeKAttnrP5HQutLFAy
         Gnhw==
X-Gm-Message-State: AOAM530sQ4AFvTxahBm25aHS5t9qq72YsrVyl/53Lm40W9cPRgCuZ1NH
        Fs60R/2R23b9IMLY1X9UXjuLbQ==
X-Google-Smtp-Source: ABdhPJzlwwd3Pb8MV6v72upJ2o2fdPkYT+fNXXX8YM2811k/Lrx9lD1CZuM1rvE7Pey/8yEm7Tzwig==
X-Received: by 2002:a17:90a:6487:: with SMTP id h7mr45336487pjj.40.1639414483641;
        Mon, 13 Dec 2021 08:54:43 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n11sm10430992pgp.15.2021.12.13.08.54.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Dec 2021 08:54:43 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        jaegeuk@kernel.org, chao@kernel.org, kari.argillander@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 03/17] fs: introduce alloc_inode_sb() to allocate filesystems specific inode
Date:   Tue, 14 Dec 2021 00:53:28 +0800
Message-Id: <20211213165342.74704-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211213165342.74704-1-songmuchun@bytedance.com>
References: <20211213165342.74704-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
---
 Documentation/filesystems/porting.rst |  5 +++++
 fs/inode.c                            |  2 +-
 include/linux/fs.h                    | 11 +++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index bf19fd6b86e7..c9c157d7b7bb 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -45,6 +45,11 @@ typically between calling iget_locked() and unlocking the inode.
 
 At some point that will become mandatory.
 
+**mandatory**
+
+The foo_inode_info should always be allocated through alloc_inode_sb() rather
+than kmem_cache_alloc() or kmalloc() related.
+
 ---
 
 **mandatory**
diff --git a/fs/inode.c b/fs/inode.c
index 6b80a51129d5..dcb1e6cad201 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -234,7 +234,7 @@ static struct inode *alloc_inode(struct super_block *sb)
 	if (ops->alloc_inode)
 		inode = ops->alloc_inode(sb);
 	else
-		inode = kmem_cache_alloc(inode_cachep, GFP_KERNEL);
+		inode = alloc_inode_sb(sb, inode_cachep, GFP_KERNEL);
 
 	if (!inode)
 		return NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbf812ce89a8..4592f00ec5e7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -41,6 +41,7 @@
 #include <linux/stddef.h>
 #include <linux/mount.h>
 #include <linux/cred.h>
+#include <linux/slab.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -3178,6 +3179,16 @@ extern void free_inode_nonrcu(struct inode *inode);
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

