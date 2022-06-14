Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F7D54B458
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jun 2022 17:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356566AbiFNPP0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Jun 2022 11:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356558AbiFNPPW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Jun 2022 11:15:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C7B424BB;
        Tue, 14 Jun 2022 08:15:18 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LMsNZ4vcRzRjQr;
        Tue, 14 Jun 2022 23:11:58 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 14 Jun 2022 23:15:16 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 14 Jun
 2022 23:15:15 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <liuyongqiang13@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH -next,v2] NFS: report and clear ENOSPC/EFBIG/EDQUOT writeback error on close() file
Date:   Tue, 14 Jun 2022 23:28:17 +0800
Message-ID: <20220614152817.271507-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, we report and clear ENOSPC/EFBIG/EDQUOT writeback error on write(),
write() file will report unexpected error if previous writeback error have not
been cleared.

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
                              | # Just write 512B and report unexpected error
                              | dd if=/dev/zero of=/mnt/file count=1 ibs=10K

Fix this by clearing ENOSPC/EFBIG/EDQUOT writeback error on close file,
it will not clear other errors that are not supposed to be reported by close().

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/nfs/file.c     | 16 ++++++++--------
 fs/nfs/internal.h | 10 ++++++++++
 fs/nfs/nfs4file.c |  9 +++++++--
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 2d72b1b7ed74..275d1fdc7f9a 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -138,7 +138,7 @@ static int
 nfs_file_flush(struct file *file, fl_owner_t id)
 {
 	struct inode	*inode = file_inode(file);
-	errseq_t since;
+	errseq_t since, error;
 
 	dprintk("NFS: flush(%pD2)\n", file);
 
@@ -149,7 +149,12 @@ nfs_file_flush(struct file *file, fl_owner_t id)
 	/* Flush writes to the server and return any errors */
 	since = filemap_sample_wb_err(file->f_mapping);
 	nfs_wb_all(inode);
-	return filemap_check_wb_err(file->f_mapping, since);
+	error = filemap_check_wb_err(file->f_mapping, since);
+
+	if (nfs_should_clear_wb_err(error))
+		file_check_and_advance_wb_err(file);
+
+	return error;
 }
 
 ssize_t
@@ -673,12 +678,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 out:
 	/* Return error values */
 	error = filemap_check_wb_err(file->f_mapping, since);
-	switch (error) {
-	default:
-		break;
-	case -EDQUOT:
-	case -EFBIG:
-	case -ENOSPC:
+	if (nfs_should_clear_wb_err(error)) {
 		nfs_wb_all(inode);
 		error = file_check_and_advance_wb_err(file);
 		if (error < 0)
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 8f8cd6e2d4db..e49aad8f7d09 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -859,3 +859,13 @@ static inline void nfs_set_port(struct sockaddr *sap, int *port,
 
 	rpc_set_port(sap, *port);
 }
+
+static inline bool nfs_should_clear_wb_err(int error) {
+	switch (error) {
+	case -EDQUOT:
+	case -EFBIG:
+	case -ENOSPC:
+		return true;
+	}
+	return false;
+}
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 03d3a270eff4..ddf3f0abd55a 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -113,7 +113,7 @@ static int
 nfs4_file_flush(struct file *file, fl_owner_t id)
 {
 	struct inode	*inode = file_inode(file);
-	errseq_t since;
+	errseq_t since, error;
 
 	dprintk("NFS: flush(%pD2)\n", file);
 
@@ -131,7 +131,12 @@ nfs4_file_flush(struct file *file, fl_owner_t id)
 	/* Flush writes to the server and return any errors */
 	since = filemap_sample_wb_err(file->f_mapping);
 	nfs_wb_all(inode);
-	return filemap_check_wb_err(file->f_mapping, since);
+	error = filemap_check_wb_err(file->f_mapping, since);
+
+	if (nfs_should_clear_wb_err(error))
+		file_check_and_advance_wb_err(file);
+
+	return error;
 }
 
 #ifdef CONFIG_NFS_V4_2
-- 
2.31.1

