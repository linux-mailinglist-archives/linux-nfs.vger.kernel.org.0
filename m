Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8924EE6BA
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Apr 2022 05:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244570AbiDADb1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 23:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244557AbiDADbZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 23:31:25 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743AC58E63;
        Thu, 31 Mar 2022 20:29:34 -0700 (PDT)
Received: from kwepemi100008.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KV5CW4DSYzBrc8;
        Fri,  1 Apr 2022 11:25:27 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 11:29:32 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 1 Apr
 2022 11:29:31 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <smayhew@redhat.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <liuyongqiang13@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH -next,v2 2/3] NFS: nfs{,4}_file_flush() return correct writeback errors
Date:   Fri, 1 Apr 2022 11:44:08 +0800
Message-ID: <20220401034409.256770-3-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220401034409.256770-1-chenxiaosong2@huawei.com>
References: <20220401034409.256770-1-chenxiaosong2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

filemap_sample_wb_err() will return 0 if old wb error have not been consumed,
then filemap_check_wb_err() will return the unchanged old wb error.

Reproducer:
        nfs server            |       nfs client
 -----------------------------|---------------------------------------------
 # No space left on server    |
 fallocate -l 100G /svr/nospc |
                              | mount -t nfs $nfs_server_ip:/ /mnt
                              |
                              | # Expected error: No space left on device
                              | dd if=/dev/zero of=/mnt/file count=1 ibs=10K
                              |
                              | # Release space on mountpoint
                              | rm /mnt/nospc
                              |
                              | # Unexpected error: No space left on device
                              | dd if=/dev/zero of=/mnt/file count=1 ibs=10K

Fix this by detecting writeback error from return value of nfs_wb_all(),
and return the more nuanced error -(file->f_mapping->wb_err & MAX_ERRNO) if
there is new wb error while nfs_wb_all().

Fixes: 67dd23f9e6fb ("nfs: ensure correct writeback errors are returned on close()")
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/nfs/file.c     | 8 ++++----
 fs/nfs/nfs4file.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 5513ab63c108..353f1f832519 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -136,7 +136,7 @@ static int
 nfs_file_flush(struct file *file, fl_owner_t id)
 {
 	struct inode	*inode = file_inode(file);
-	errseq_t since;
+	errseq_t error = 0;
 
 	dprintk("NFS: flush(%pD2)\n", file);
 
@@ -145,9 +145,9 @@ nfs_file_flush(struct file *file, fl_owner_t id)
 		return 0;
 
 	/* Flush writes to the server and return any errors */
-	since = filemap_sample_wb_err(file->f_mapping);
-	nfs_wb_all(inode);
-	return filemap_check_wb_err(file->f_mapping, since);
+	if (nfs_wb_all(inode))
+		error = filemap_check_wb_err(file->f_mapping, 0);
+	return error;
 }
 
 ssize_t
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index d258933cf8c8..cbbe66b54417 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -111,7 +111,7 @@ static int
 nfs4_file_flush(struct file *file, fl_owner_t id)
 {
 	struct inode	*inode = file_inode(file);
-	errseq_t since;
+	errseq_t error = 0;
 
 	dprintk("NFS: flush(%pD2)\n", file);
 
@@ -127,9 +127,9 @@ nfs4_file_flush(struct file *file, fl_owner_t id)
 		return filemap_fdatawrite(file->f_mapping);
 
 	/* Flush writes to the server and return any errors */
-	since = filemap_sample_wb_err(file->f_mapping);
-	nfs_wb_all(inode);
-	return filemap_check_wb_err(file->f_mapping, since);
+	if (nfs_wb_all(inode))
+		error = filemap_check_wb_err(file->f_mapping, 0);
+	return error;
 }
 
 #ifdef CONFIG_NFS_V4_2
-- 
2.31.1

