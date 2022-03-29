Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24884EAC12
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Mar 2022 13:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbiC2LTU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 07:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiC2LTS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 07:19:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CAB4DF45;
        Tue, 29 Mar 2022 04:17:34 -0700 (PDT)
Received: from kwepemi100022.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KSRn41g4CzCrBv;
        Tue, 29 Mar 2022 19:15:20 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100022.china.huawei.com (7.221.188.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 29 Mar 2022 19:17:32 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 29 Mar
 2022 19:17:31 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <bjschuma@netapp.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <liuyongqiang13@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>, <tao.lyu@epfl.ch>
Subject: [PATCH -next 2/2] NFSv4: fix open failure with O_ACCMODE flag
Date:   Tue, 29 Mar 2022 19:32:08 +0800
Message-ID: <20220329113208.2466000-3-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220329113208.2466000-1-chenxiaosong2@huawei.com>
References: <20220329113208.2466000-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

open() with O_ACCMODE|O_DIRECT flags secondly will fail.

Reproducer:
  1. mount -t nfs -o vers=4.2 $server_ip:/ /mnt/
  2. fd = open("/mnt/file", O_ACCMODE|O_DIRECT|O_CREAT)
  3. close(fd)
  4. fd = open("/mnt/file", O_ACCMODE|O_DIRECT)

Server nfsd4_decode_share_access() will fail with error nfserr_bad_xdr when
client use incorrect share access mode of 0.

Fix this by using NFS4_SHARE_ACCESS_BOTH share access mode in client,
just like firstly opening.

Fixes: ce4ef7c0a8a05 ("NFS: Split out NFS v4 file operations")
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/nfs/dir.c      | 10 ----------
 fs/nfs/internal.h | 10 ++++++++++
 fs/nfs/nfs4file.c |  6 ++++--
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 75cb1cbe4cde..911bdb35eb08 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1853,16 +1853,6 @@ const struct dentry_operations nfs4_dentry_operations = {
 };
 EXPORT_SYMBOL_GPL(nfs4_dentry_operations);
 
-static fmode_t flags_to_mode(int flags)
-{
-	fmode_t res = (__force fmode_t)flags & FMODE_EXEC;
-	if ((flags & O_ACCMODE) != O_WRONLY)
-		res |= FMODE_READ;
-	if ((flags & O_ACCMODE) != O_RDONLY)
-		res |= FMODE_WRITE;
-	return res;
-}
-
 static struct nfs_open_context *create_nfs_open_context(struct dentry *dentry, int open_flags, struct file *filp)
 {
 	return alloc_nfs_open_context(dentry, flags_to_mode(open_flags), filp);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 2de7c56a1fbe..58e618a5d88e 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -42,6 +42,16 @@ static inline bool nfs_lookup_is_soft_revalidate(const struct dentry *dentry)
 	return true;
 }
 
+static inline fmode_t flags_to_mode(int flags)
+{
+	fmode_t res = (__force fmode_t)flags & FMODE_EXEC;
+	if ((flags & O_ACCMODE) != O_WRONLY)
+		res |= FMODE_READ;
+	if ((flags & O_ACCMODE) != O_RDONLY)
+		res |= FMODE_WRITE;
+	return res;
+}
+
 /*
  * Note: RFC 1813 doesn't limit the number of auth flavors that
  * a server can return, so make something up.
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index c178db86a6e8..e34af48fb4f4 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -32,6 +32,7 @@ nfs4_file_open(struct inode *inode, struct file *filp)
 	struct dentry *parent = NULL;
 	struct inode *dir;
 	unsigned openflags = filp->f_flags;
+	fmode_t f_mode;
 	struct iattr attr;
 	int err;
 
@@ -50,8 +51,9 @@ nfs4_file_open(struct inode *inode, struct file *filp)
 	if (err)
 		return err;
 
+	f_mode = filp->f_mode;
 	if ((openflags & O_ACCMODE) == 3)
-		openflags--;
+		f_mode |= flags_to_mode(openflags);
 
 	/* We can't create new files here */
 	openflags &= ~(O_CREAT|O_EXCL);
@@ -59,7 +61,7 @@ nfs4_file_open(struct inode *inode, struct file *filp)
 	parent = dget_parent(dentry);
 	dir = d_inode(parent);
 
-	ctx = alloc_nfs_open_context(file_dentry(filp), filp->f_mode, filp);
+	ctx = alloc_nfs_open_context(file_dentry(filp), f_mode, filp);
 	err = PTR_ERR(ctx);
 	if (IS_ERR(ctx))
 		goto out;
-- 
2.31.1

