Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3FE131955
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgAFU1b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:31 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35964 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgAFU1b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:31 -0500
Received: by mail-yw1-f67.google.com with SMTP id n184so22431728ywc.3
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eDDBm34n3ZIRRXM4ToxivPkQNAwdYtMrj60iL6y69S0=;
        b=M6WuI1aQ649EJNkM5KvG3uul1wvoRWZm5wBqoNJ1qr2f2kiYpMkoHGY9xlM8/rlBpQ
         MyvKZ1qtNtGz/76NOd5mgkMc2Vqt9UdvSCktdEnDTgoRJv6jJmNT+H+6P5T8VtaKfHX9
         CL+tAiagKyf8qdnX/5I1FkMZ90MNvuwS/m4LgJcbbKBzhNi3oy8+Z11QEvIysaavPcKw
         TJqh3Bln6M9jd8aenphT4nZKBDznNxN+t6pOB7uCsCdN00o7iiVOUp87dCFFJnhnbFvW
         Z9XP97xQgxlGQ4nGHxa6t/M8X3YPo20VNgn4A/EWZd+ne7m+maQMsw73f+9MrBIBE8cV
         eP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDDBm34n3ZIRRXM4ToxivPkQNAwdYtMrj60iL6y69S0=;
        b=Y4Jk12mBHtLtfcEpx3fpxoW2PSDgM30hckFEehAIdLlr+j2yusEw48wcwxS1HeosU/
         chpJZx5vN2lbLXzv6+NDvd77wagPKE/D92ibi5cUiEoahOcUbyFL72zqvAc/nbaaJezW
         yvmjmm4I/0Iw9CqoAAFxSW+44UGW78esv2kRonJqh11fjEYvgEaWPFLgZH9+07NEUbUw
         DsRoBwDfdd1c0EfGdS/HmxlhGGpocNOOXzRvH18Wt9vezu9bdjv5IaER7sg/7XY6Mmlm
         q1U2bze/xI2KkNCjFlcvaxGKkOGZ9buuckQEbNa+1c5Vn771itz5HuwL+uhxBnr6jK8Y
         G33A==
X-Gm-Message-State: APjAAAXuvYHQqq3BUe+HXdOPaBL1qshb0PSt+JO7X4sYgpSprGQ2I1kL
        0NCMEQU4yxmavZf+z01p+1rEwq54Tg==
X-Google-Smtp-Source: APXvYqxppsa59SpQ+kJKXH45KBSFzjjVHr2DPe2XlvztaSVydNav6ExJ361HKv286KMjdO++lB5tHQ==
X-Received: by 2002:a0d:f481:: with SMTP id d123mr73316872ywf.411.1578342450238;
        Mon, 06 Jan 2020 12:27:30 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:29 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 04/15] NFS: Fix up fsync() when the server rebooted
Date:   Mon,  6 Jan 2020 15:25:03 -0500
Message-Id: <20200106202514.785483-5-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-4-trond.myklebust@hammerspace.com>
References: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
 <20200106202514.785483-2-trond.myklebust@hammerspace.com>
 <20200106202514.785483-3-trond.myklebust@hammerspace.com>
 <20200106202514.785483-4-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Don't clear the NFS_CONTEXT_RESEND_WRITES flag until after calling
nfs_commit_inode(). Otherwise, if nfs_commit_inode() returns an
error, we end up with dirty pages in the page cache, but no tag
to tell us that those pages need resending.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 8eb731d9be3e..95a3445c8926 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -204,44 +204,39 @@ EXPORT_SYMBOL_GPL(nfs_file_mmap);
 static int
 nfs_file_fsync_commit(struct file *file, int datasync)
 {
-	struct nfs_open_context *ctx = nfs_file_open_context(file);
 	struct inode *inode = file_inode(file);
-	int do_resend, status;
-	int ret = 0;
+	int ret;
 
 	dprintk("NFS: fsync file(%pD2) datasync %d\n", file, datasync);
 
 	nfs_inc_stats(inode, NFSIOS_VFSFSYNC);
-	do_resend = test_and_clear_bit(NFS_CONTEXT_RESEND_WRITES, &ctx->flags);
-	status = nfs_commit_inode(inode, FLUSH_SYNC);
-	if (status == 0)
-		status = file_check_and_advance_wb_err(file);
-	if (status < 0) {
-		ret = status;
-		goto out;
-	}
-	do_resend |= test_bit(NFS_CONTEXT_RESEND_WRITES, &ctx->flags);
-	if (do_resend)
-		ret = -EAGAIN;
-out:
-	return ret;
+	ret = nfs_commit_inode(inode, FLUSH_SYNC);
+	if (ret < 0)
+		return ret;
+	return file_check_and_advance_wb_err(file);
 }
 
 int
 nfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	int ret;
+	struct nfs_open_context *ctx = nfs_file_open_context(file);
 	struct inode *inode = file_inode(file);
+	int ret;
 
 	trace_nfs_fsync_enter(inode);
 
-	do {
+	for (;;) {
 		ret = file_write_and_wait_range(file, start, end);
 		if (ret != 0)
 			break;
 		ret = nfs_file_fsync_commit(file, datasync);
-		if (!ret)
-			ret = pnfs_sync_inode(inode, !!datasync);
+		if (ret != 0)
+			break;
+		ret = pnfs_sync_inode(inode, !!datasync);
+		if (ret != 0)
+			break;
+		if (!test_and_clear_bit(NFS_CONTEXT_RESEND_WRITES, &ctx->flags))
+			break;
 		/*
 		 * If nfs_file_fsync_commit detected a server reboot, then
 		 * resend all dirty pages that might have been covered by
@@ -249,7 +244,7 @@ nfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 		 */
 		start = 0;
 		end = LLONG_MAX;
-	} while (ret == -EAGAIN);
+	}
 
 	trace_nfs_fsync_exit(inode, ret);
 	return ret;
-- 
2.24.1

