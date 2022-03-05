Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA65E4CE4C3
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Mar 2022 13:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbiCEMc3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Mar 2022 07:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbiCEMcZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Mar 2022 07:32:25 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDFD240049;
        Sat,  5 Mar 2022 04:31:35 -0800 (PST)
Received: from kwepemi100012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K9kZY5S57zdgJQ;
        Sat,  5 Mar 2022 20:30:13 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi100012.china.huawei.com (7.221.188.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 5 Mar 2022 20:31:33 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 20:31:32 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <smayhew@redhat.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <liuyongqiang13@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH -next 1/2] nfs: nfs{,4}_file_flush should consume writeback error
Date:   Sat, 5 Mar 2022 20:46:35 +0800
Message-ID: <20220305124636.2002383-2-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220305124636.2002383-1-chenxiaosong2@huawei.com>
References: <20220305124636.2002383-1-chenxiaosong2@huawei.com>
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

filemap_sample_wb_err() will return 0 if nobody has seen the error yet,
then filemap_check_wb_err() will return the unchanged writeback error.

Reproducer:
        nfs server               |       nfs client
 --------------------------------|-----------------------------------------------
 # No space left on server       |
 fallocate -l 100G /server/file1 |
                                 | mount -t nfs $nfs_server_ip:/ /mnt
                                 | # Expected error: No space left on device
                                 | dd if=/dev/zero of=/mnt/file2 count=1 ibs=100K
 # Release space on server       |
 rm /server/file1                |
                                 | # Unexpected error: No space left on device
                                 | dd if=/dev/zero of=/mnt/file2 count=1 ibs=100K

Fix this by using file_check_and_advance_wb_err(). If there is an error during
the writeback process, it should be returned when user space calls close() or fsync(),
flush() is called when user space calls close().

Note that fsync() will not be called after close().

Fixes: 67dd23f9e6fb ("nfs: ensure correct writeback errors are returned on close()")
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/nfs/file.c     | 4 +---
 fs/nfs/nfs4file.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 76d76acbc594..83d63bce9596 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -141,7 +141,6 @@ static int
 nfs_file_flush(struct file *file, fl_owner_t id)
 {
 	struct inode	*inode = file_inode(file);
-	errseq_t since;
 
 	dprintk("NFS: flush(%pD2)\n", file);
 
@@ -150,9 +149,8 @@ nfs_file_flush(struct file *file, fl_owner_t id)
 		return 0;
 
 	/* Flush writes to the server and return any errors */
-	since = filemap_sample_wb_err(file->f_mapping);
 	nfs_wb_all(inode);
-	return filemap_check_wb_err(file->f_mapping, since);
+	return file_check_and_advance_wb_err(file);
 }
 
 ssize_t
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index e79ae4cbc395..63a57e5b6db7 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -111,7 +111,6 @@ static int
 nfs4_file_flush(struct file *file, fl_owner_t id)
 {
 	struct inode	*inode = file_inode(file);
-	errseq_t since;
 
 	dprintk("NFS: flush(%pD2)\n", file);
 
@@ -127,9 +126,8 @@ nfs4_file_flush(struct file *file, fl_owner_t id)
 		return filemap_fdatawrite(file->f_mapping);
 
 	/* Flush writes to the server and return any errors */
-	since = filemap_sample_wb_err(file->f_mapping);
 	nfs_wb_all(inode);
-	return filemap_check_wb_err(file->f_mapping, since);
+	return file_check_and_advance_wb_err(file);
 }
 
 #ifdef CONFIG_NFS_V4_2
-- 
2.31.1

