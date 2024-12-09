Return-Path: <linux-nfs+bounces-8475-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D809E9D63
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 18:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12631887381
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Dec 2024 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD621B040B;
	Mon,  9 Dec 2024 17:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b="Aa5o4qzN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mxout5.mail.janestreet.com (mxout5.mail.janestreet.com [64.215.233.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FD7154BFC
	for <linux-nfs@vger.kernel.org>; Mon,  9 Dec 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.215.233.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766350; cv=none; b=FW2k0UBY9uSy3hInjjuND1TkpGnA+vrqOSZFOaiWWQoAyqOafVbBH3vLpVqOHtGiB9Quel8MG1gKKEgyHCz305BqXYNk31C7c2G4+Yk5ixxFiiEPWW+VkmI7v9AVDvE5+K0rktNa6oBAsxy/PLN6dITlGCQ/umaof9Cwtbxi9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766350; c=relaxed/simple;
	bh=qzmDRzVwBCe/hFVlH/XWVtNJ+YW9/6Mesc6a2S/JkMw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hxSA1zTlCkoXX6CRAilHgI78JtKAxLKexdmlRE9ai7s02eeNcuzf4vyFl5Xk4rEbFmX2khmob/OOeNR5k69XE9WCw7DZET6g3eDSsdyTG5yPLC9qgTDI50WgHObp8k0Q26Nm5wV0U3XSLFZH+vrjZnxY4LK+uX3LRJGnnC/7g3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com; spf=pass smtp.mailfrom=janestreet.com; dkim=pass (2048-bit key) header.d=janestreet.com header.i=@janestreet.com header.b=Aa5o4qzN; arc=none smtp.client-ip=64.215.233.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=janestreet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=janestreet.com
Date: Mon, 9 Dec 2024 12:39:55 -0500
From: Nikhil Jha <njha@janestreet.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfs: propagate fileid changed errors back to syscall
Message-ID: <Z1cra8/5H5HvJ5Sw@igm-qws-u22929a.delacy.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=janestreet.com;
  s=waixah; t=1733765995;
  bh=6IxyuMfQnp/g35TgnRBn0r/NAk97VUvbhHrdndtkHtA=;
  h=Date:From:To:Cc:Subject;
  b=Aa5o4qzNsT5XUYs2t1Qhec+cColPVaIX8bTwqctOknu4vML+1YRZTYnxsvaAq4/ex
  GZSa+v8H4mRPwXdB342C8pnaAQCQLr0AQnZFyS+Gm0XxrHPNymu+ixy2WpGKrVYgrj
  WRbHY8x8nrTvCSYYXRZgvuBThCFUWrhUfC+CVC0aKSX8iac0ALT6FpcN4qB/c+AvW7
  LXatgBDb+KleeKSZPnjvpL6og7FZ8TfUeo4tjPPp0ecI9/6aTyz4g62f+jbQ8eXluw
  ovCCMGdJIWhwJATfy3lDFofTom8zgeOmXryZUNG/Gp8WPRl/UBFD5/siDi+KxqfiAd
  WFXgMt6UewXoA==

Hello! This is the first kernel patch I have tried to upstream. I'm
following along with the kernel newbies guide but apologies if I got
anything wrong.

Currently, if there is a mismatch in the request and response fileids in
an NFS request, the kernel logs an error and attempts to return ESTALE.
However, this error is currently dropped before it makes it all the way
to userspace. This appears to be a mistake, since as far as I can tell
that ESTALE value is never consumed from anywhere.

Callstack for async NFS write, at time of error:

        nfs_update_inode <- returns -ESTALE
        nfs_refresh_inode_locked
        nfs_writeback_update_inode <- error is dropped here
        nfs3_write_done
        nfs_writeback_done
        nfs_pgio_result <- other errors are collected here
        rpc_exit_task
        __rpc_execute
        rpc_async_schedule
        process_one_work
        worker_thread
        kthread
        ret_from_fork

We ran into this issue ourselves, and seeing the -ESTALE in the kernel
source code but not from userspace was surprising.

I tested a rebased version of this patch on an el8 kernel (v6.1.114),
and it seems to correctly propagate this error.

>8------------------------------------------------------8<

If an NFS server returns a response with a different file id to the
response, the kernel currently prints out an error and attempts to
return -ESTALE. However, this -ESTALE value is never surfaced anywhere.

This patch modifies nfs_writeback_update_inode() to propagate these
errors up the call stack, and modifies nfs_pgio_result() to report
the resulting error.

Signed-off-by: Nikhil Jha <njha@janestreet.com>
---
 fs/nfs/filelayout/filelayout.c         | 2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c | 2 +-
 fs/nfs/internal.h                      | 2 +-
 fs/nfs/nfs3proc.c                      | 2 +-
 fs/nfs/nfs4proc.c                      | 2 +-
 fs/nfs/pagelist.c                      | 5 ++++-
 fs/nfs/proc.c                          | 2 +-
 fs/nfs/write.c                         | 9 ++++++---
 8 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index d39a1f58e18d..4e80a13e9639 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -335,7 +335,7 @@ static int filelayout_write_done_cb(struct rpc_task *task,
 	/* zero out the fattr */
 	hdr->fattr.valid = 0;
 	if (task->tk_status >= 0)
-		nfs_writeback_update_inode(hdr);
+		return nfs_writeback_update_inode(hdr);
 
 	return 0;
 }
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index f78115c6c2c1..d15e3799a351 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1503,7 +1503,7 @@ static int ff_layout_write_done_cb(struct rpc_task *task,
 	/* zero out fattr since we don't care DS attr at all */
 	hdr->fattr.valid = 0;
 	if (task->tk_status >= 0)
-		nfs_writeback_update_inode(hdr);
+		return nfs_writeback_update_inode(hdr);
 
 	return 0;
 }
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index e564bd11ba60..5c4e2fa88324 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -592,7 +592,7 @@ void nfs_mark_request_commit(struct nfs_page *req,
 			     struct nfs_commit_info *cinfo,
 			     u32 ds_commit_idx);
 int nfs_write_need_commit(struct nfs_pgio_header *);
-void nfs_writeback_update_inode(struct nfs_pgio_header *hdr);
+int nfs_writeback_update_inode(struct nfs_pgio_header *hdr);
 int nfs_generic_commit_list(struct inode *inode, struct list_head *head,
 			    int how, struct nfs_commit_info *cinfo);
 void nfs_retry_commit(struct list_head *page_list,
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1566163c6d85..42ddbc21fb05 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -887,7 +887,7 @@ static int nfs3_write_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 	if (nfs3_async_handle_jukebox(task, inode))
 		return -EAGAIN;
 	if (task->tk_status >= 0)
-		nfs_writeback_update_inode(hdr);
+		return nfs_writeback_update_inode(hdr);
 	return 0;
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 405f17e6e0b4..7ec372a1eb98 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5661,7 +5661,7 @@ static int nfs4_write_done_cb(struct rpc_task *task,
 	}
 	if (task->tk_status >= 0) {
 		renew_lease(NFS_SERVER(inode), hdr->timestamp);
-		nfs_writeback_update_inode(hdr);
+		return nfs_writeback_update_inode(hdr);
 	}
 	return 0;
 }
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index e27c07bd8929..19cb080653e3 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -854,9 +854,12 @@ static void nfs_pgio_result(struct rpc_task *task, void *calldata)
 {
 	struct nfs_pgio_header *hdr = calldata;
 	struct inode *inode = hdr->inode;
+	int status = hdr->rw_ops->rw_done(task, hdr, inode);
 
-	if (hdr->rw_ops->rw_done(task, hdr, inode) != 0)
+	if (status != 0) {
+		nfs_set_pgio_error(hdr, status, hdr->args.offset);
 		return;
+	}
 	if (task->tk_status < 0)
 		nfs_set_pgio_error(hdr, task->tk_status, hdr->args.offset);
 	else
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 6c09cd090c34..72ffbdfc7ae6 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -629,7 +629,7 @@ static int nfs_write_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 {
 	if (task->tk_status >= 0) {
 		hdr->res.count = hdr->args.count;
-		nfs_writeback_update_inode(hdr);
+		return nfs_writeback_update_inode(hdr);
 	}
 	return 0;
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 50fa539611f5..151da29175fd 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1507,22 +1507,25 @@ static void nfs_writeback_check_extend(struct nfs_pgio_header *hdr,
 	fattr->valid |= NFS_ATTR_FATTR_SIZE;
 }
 
-void nfs_writeback_update_inode(struct nfs_pgio_header *hdr)
+int nfs_writeback_update_inode(struct nfs_pgio_header *hdr)
 {
 	struct nfs_fattr *fattr = &hdr->fattr;
 	struct inode *inode = hdr->inode;
+	int ret = 0;
 
 	if (nfs_have_delegated_mtime(inode)) {
 		spin_lock(&inode->i_lock);
 		nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
 		spin_unlock(&inode->i_lock);
-		return;
+		return 0;
 	}
 
 	spin_lock(&inode->i_lock);
 	nfs_writeback_check_extend(hdr, fattr);
-	nfs_post_op_update_inode_force_wcc_locked(inode, fattr);
+	ret = nfs_post_op_update_inode_force_wcc_locked(inode, fattr);
 	spin_unlock(&inode->i_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nfs_writeback_update_inode);
 
-- 
2.39.3


