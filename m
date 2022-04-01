Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B84EE6BD
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Apr 2022 05:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244578AbiDADb2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 23:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244566AbiDADb1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 23:31:27 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7A85A09A;
        Thu, 31 Mar 2022 20:29:35 -0700 (PDT)
Received: from kwepemi500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KV5Fg060KzDqDV;
        Fri,  1 Apr 2022 11:27:18 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 kwepemi500001.china.huawei.com (7.221.188.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 1 Apr 2022 11:29:33 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 1 Apr
 2022 11:29:32 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <trond.myklebust@hammerspace.com>, <anna@kernel.org>,
        <smayhew@redhat.com>
CC:     <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenxiaosong2@huawei.com>, <liuyongqiang13@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH -next,v2 3/3] Revert "nfs: nfs_file_write() should check for writeback errors"
Date:   Fri, 1 Apr 2022 11:44:09 +0800
Message-ID: <20220401034409.256770-4-chenxiaosong2@huawei.com>
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

This reverts commit ce368536dd614452407dc31e2449eb84681a06af.

Second `dd` of the following reproducer will be very very slow.
filemap_sample_wb_err() always return 0 if old wb error have not been consumed.
filemap_check_wb_err() will return the old error even if there is no new
writeback error between filemap_sample_wb_err() and filemap_check_wb_err().
Then nfs_need_check_write() always return true, nfs_wb_all() will be called
every time in nfs_file_write().

Reproducer:
        nfs server            |       nfs client
 -----------------------------|---------------------------------------------
 # No space left on server    |
 fallocate -l 100G /svr/nospc |
                              | mount -t nfs $nfs_server_ip:/ /mnt
                              |
                              | # Expected error: No space left on device
                              | dd if=/dev/zero of=/mnt/file count=1 ibs=1M
                              |
                              | # Release space on mountpoint
                              | rm /mnt/nospc
                              |
                              | # very very slow
                              | dd if=/dev/zero of=/mnt/file count=1 ibs=1M

generic_perform_write() detect wb error by calling filemap_check_errors():
  generic_perform_write
    nfs_write_end
      nfs_wb_all
        filemap_write_and_wait
          filemap_write_and_wait_range
            filemap_check_errors

filemap_fdatawait_range() detect wb error by calling filemap_check_errors():
  filemap_fdatawait_range
    __filemap_fdatawait_range
    filemap_check_errors

generic_write_sync() will also detect wb error by calling nfs_file_fsync():
  generic_write_sync
    vfs_fsync_range
      nfs_file_fsync
        file_write_and_wait_range
          file_check_and_advance_wb_err
            errseq_check_and_advance

When writeback error is detected in nfs_file_write(), we just goto label "out",
will not goto nfs_need_check_write(). So we remove the useless and problematic
checking.

Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/nfs/file.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 353f1f832519..49f1485a30bb 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -597,14 +597,12 @@ static const struct vm_operations_struct nfs_file_vm_ops = {
 	.page_mkwrite = nfs_vm_page_mkwrite,
 };
 
-static int nfs_need_check_write(struct file *filp, struct inode *inode,
-				int error)
+static int nfs_need_check_write(struct file *filp, struct inode *inode)
 {
 	struct nfs_open_context *ctx;
 
 	ctx = nfs_file_open_context(filp);
-	if (nfs_error_is_fatal_on_server(error) ||
-	    nfs_ctx_key_to_expire(ctx, inode))
+	if (nfs_ctx_key_to_expire(ctx, inode))
 		return 1;
 	return 0;
 }
@@ -615,8 +613,6 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(file);
 	unsigned int mntflags = NFS_SERVER(inode)->flags;
 	ssize_t result, written;
-	errseq_t since;
-	int error;
 
 	result = nfs_key_timeout_notify(file, inode);
 	if (result)
@@ -641,7 +637,6 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 
 	nfs_clear_invalid_mapping(file->f_mapping);
 
-	since = filemap_sample_wb_err(file->f_mapping);
 	nfs_start_io_write(inode);
 	result = generic_write_checks(iocb, from);
 	if (result > 0) {
@@ -675,8 +670,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 
 	/* Return error values */
-	error = filemap_check_wb_err(file->f_mapping, since);
-	if (nfs_need_check_write(file, inode, error)) {
+	if (nfs_need_check_write(file, inode)) {
 		int err = nfs_wb_all(inode);
 		if (err < 0)
 			result = err;
-- 
2.31.1

