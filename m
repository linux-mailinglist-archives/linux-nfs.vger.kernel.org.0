Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B094FC6DD
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Apr 2022 23:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbiDKVmx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Apr 2022 17:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbiDKVmw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Apr 2022 17:42:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A41033A0F
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 14:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA9D61701
        for <linux-nfs@vger.kernel.org>; Mon, 11 Apr 2022 21:40:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E59C385AB;
        Mon, 11 Apr 2022 21:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649713236;
        bh=t0ZdTuVnz8eqy1TWWnBl4rDn04/xaH24HuwOHJeHyjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmfVptnuX3Sb90CY9ASv4XrpNl0lvrEb2jNYjnIPCCYo6RTq5HvTfI1UffkPjoRRO
         dKWTgWJNdz4OqFdrTTLoHZT7isNfYZ9L+Ssxz1GB5tX0cRMB94u7404f9TzYxnl/zG
         rcBst5X05PX6jIgddpnk8yl3488M8Anor3mEdkjXFgmIKKBtatQL8BX1XMSwiBuL0D
         3EGFGXI8z71trdvgr7/3F/QI5FiiMeeUnMwdDj0hSj4nzUXl/1ORb/fSE7vO54raad
         k3RTmmICfneZa0m3IELtwdP0iEiielTsSPjaCqmYTfI8CDB5gnfetqJBjPc1OBeS9w
         xUI8kHh7PbBNw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     ChenXiaoSong <chenxiaosong2@huawei.com>,
        Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH v2 3/5] NFS: Don't report ENOSPC write errors twice
Date:   Mon, 11 Apr 2022 17:33:44 -0400
Message-Id: <20220411213346.762302-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220411213346.762302-3-trondmy@kernel.org>
References: <20220411213346.762302-1-trondmy@kernel.org>
 <20220411213346.762302-2-trondmy@kernel.org>
 <20220411213346.762302-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 fs/nfs/file.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 95e1236d95c5..8211a7aa799c 100644
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
@@ -673,17 +661,22 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 	result = generic_write_sync(iocb, written);
 	if (result < 0)
-		goto out;
-
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
 	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, written);
-out:
 	return result;
 
 out_swapfile:
-- 
2.35.1

