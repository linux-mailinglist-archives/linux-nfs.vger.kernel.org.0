Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82823527207
	for <lists+linux-nfs@lfdr.de>; Sat, 14 May 2022 16:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiENOdS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 14 May 2022 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiENOdQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 14 May 2022 10:33:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD471CFC9
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 07:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E722CB808D2
        for <linux-nfs@vger.kernel.org>; Sat, 14 May 2022 14:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542B0C34116;
        Sat, 14 May 2022 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652538792;
        bh=zKmbQrO0dGT4kPWfRXQOJRxWwZShgqPqnlD75es0YCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNzMKTQx/H12/GR9GxPLyhUE3RvCWSS1YlF8RapFKERb1QiZe6yat8kb7QXo6tHnK
         IblqGPl56vN+QW+mDxbE25jveDYoCTwd4r9D9uW8gG6vb86pV9SoAPRoTkOcwoG0fj
         I7fbEljt6pu2yYFjQe/YIMKbqgGWtHPJcsHQupP9nhgBdPFy0imuqh27Rp6zQjqOp4
         f6K7ukhwI6eCfxBLhPdGzo73Q0xhZvoxIMe24agcEWz1QnIz0vlrDpLH4Ze4fPCui1
         afgTzFmAVTWRRURJNyvFEhkVk0sB/KNEp2lekgM/kG7Q3rSbJkWG33vFiy9GdFGGXF
         1DR2hB678GENw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/5] NFS: Don't report ENOSPC write errors twice
Date:   Sat, 14 May 2022 10:27:02 -0400
Message-Id: <20220514142704.4149-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514142704.4149-3-trondmy@kernel.org>
References: <20220514142704.4149-1-trondmy@kernel.org>
 <20220514142704.4149-2-trondmy@kernel.org>
 <20220514142704.4149-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Any errors reported by the write() system call need to be cleared from
the file descriptor's error tracking. The current call to nfs_wb_all()
causes the error to be reported, but since it doesn't call
file_check_and_advance_wb_err(), we can end up reporting the same error
a second time when the application calls fsync().

Note that since Linux 4.13, the rule is that EIO may be reported for
write(), but it must be reported by a subsequent fsync(), so let's just
drop reporting it in write.

The check for nfs_ctx_key_to_expire() is just a duplicate to the one
already in nfs_write_end(), so let's drop that too.

Reported-by: ChenXiaoSong <chenxiaosong2@huawei.com>
Fixes: ce368536dd61 ("nfs: nfs_file_write() should check for writeback errors")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 7c380e555224..87e4cd5e8fe2 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -598,18 +598,6 @@ static const struct vm_operations_struct nfs_file_vm_ops = {
 	.page_mkwrite = nfs_vm_page_mkwrite,
 };
 
-static int nfs_need_check_write(struct file *filp, struct inode *inode,
-				int error)
-{
-	struct nfs_open_context *ctx;
-
-	ctx = nfs_file_open_context(filp);
-	if (nfs_error_is_fatal_on_server(error) ||
-	    nfs_ctx_key_to_expire(ctx, inode))
-		return 1;
-	return 0;
-}
-
 ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
@@ -637,7 +625,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_APPEND || iocb->ki_pos > i_size_read(inode)) {
 		result = nfs_revalidate_file_size(inode, file);
 		if (result)
-			goto out;
+			return result;
 	}
 
 	nfs_clear_invalid_mapping(file->f_mapping);
@@ -656,6 +644,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 
 	written = result;
 	iocb->ki_pos += written;
+	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, written);
 
 	if (mntflags & NFS_MOUNT_WRITE_EAGER) {
 		result = filemap_fdatawrite_range(file->f_mapping,
@@ -673,17 +662,22 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 	result = generic_write_sync(iocb, written);
 	if (result < 0)
-		goto out;
+		return result;
 
+out:
 	/* Return error values */
 	error = filemap_check_wb_err(file->f_mapping, since);
-	if (nfs_need_check_write(file, inode, error)) {
-		int err = nfs_wb_all(inode);
-		if (err < 0)
-			result = err;
+	switch (error) {
+	default:
+		break;
+	case -EDQUOT:
+	case -EFBIG:
+	case -ENOSPC:
+		nfs_wb_all(inode);
+		error = file_check_and_advance_wb_err(file);
+		if (error < 0)
+			result = error;
 	}
-	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, written);
-out:
 	return result;
 
 out_swapfile:
-- 
2.36.1

