Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5356F5E72FA
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Sep 2022 06:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIWEf2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Sep 2022 00:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIWEf1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Sep 2022 00:35:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12ED1181C4;
        Thu, 22 Sep 2022 21:35:26 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MYfNg4KXszlXT7;
        Fri, 23 Sep 2022 12:31:15 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 12:35:25 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 12:35:24 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
Subject: [PATCH v2 1/2] NFS: make sure open context mode have FMODE_EXEC when file open for exec
Date:   Fri, 23 Sep 2022 13:36:04 +0800
Message-ID: <20220923053605.2723395-2-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220923053605.2723395-1-chenxiaosong2@huawei.com>
References: <20220923053605.2723395-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Because file f_mode never have FMODE_EXEC, open context mode won't get
FMODE_EXEC from file f_mode. Open context mode only care about FMODE_READ/
FMODE_WRITE/FMODE_EXEC, and all info about open context mode can be convert
from file f_flags, so convert file f_flags to open context mode by
flags_to_mode().

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/nfs/inode.c    |  3 ++-
 fs/nfs/nfs4file.c | 12 ++++--------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index bea7c005119c..bafa808823db 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1173,7 +1173,8 @@ int nfs_open(struct inode *inode, struct file *filp)
 {
 	struct nfs_open_context *ctx;
 
-	ctx = alloc_nfs_open_context(file_dentry(filp), filp->f_mode, filp);
+	ctx = alloc_nfs_open_context(file_dentry(filp),
+				     flags_to_mode(filp->f_flags), filp);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 	nfs_file_set_open_context(filp, ctx);
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 9eb181287879..2563ed8580f3 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -32,7 +32,6 @@ nfs4_file_open(struct inode *inode, struct file *filp)
 	struct dentry *parent = NULL;
 	struct inode *dir;
 	unsigned openflags = filp->f_flags;
-	fmode_t f_mode;
 	struct iattr attr;
 	int err;
 
@@ -51,17 +50,14 @@ nfs4_file_open(struct inode *inode, struct file *filp)
 	if (err)
 		return err;
 
-	f_mode = filp->f_mode;
-	if ((openflags & O_ACCMODE) == 3)
-		f_mode |= flags_to_mode(openflags);
-
 	/* We can't create new files here */
 	openflags &= ~(O_CREAT|O_EXCL);
 
 	parent = dget_parent(dentry);
 	dir = d_inode(parent);
 
-	ctx = alloc_nfs_open_context(file_dentry(filp), f_mode, filp);
+	ctx = alloc_nfs_open_context(file_dentry(filp),
+				     flags_to_mode(openflags), filp);
 	err = PTR_ERR(ctx);
 	if (IS_ERR(ctx))
 		goto out;
@@ -366,8 +362,8 @@ static struct file *__nfs42_ssc_open(struct vfsmount *ss_mnt,
 		goto out_free_name;
 	}
 
-	ctx = alloc_nfs_open_context(filep->f_path.dentry, filep->f_mode,
-					filep);
+	ctx = alloc_nfs_open_context(filep->f_path.dentry,
+				     flags_to_mode(filep->f_flags), filep);
 	if (IS_ERR(ctx)) {
 		res = ERR_CAST(ctx);
 		goto out_filep;
-- 
2.31.1

