Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62C0219B61C
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2020 20:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbgDAS7G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Apr 2020 14:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732264AbgDAS7G (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Apr 2020 14:59:06 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C55C20784
        for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2020 18:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585767545;
        bh=b+6vClENyKhhY8Nu1njz14RCxd5nXpTz0AXUXoOIV2I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Q1BEBMWYDUkKjL8CFLq500WgdiaD3SaiPh0bPsSUECAMFpluCZ5pGjR5O9cNUNHOr
         DxtVHyxkkPnuD7OparLox1oa+QrI8DAjbz0XmMeVlyloFVzGfOhNsBNKyggSROr2T8
         7FQutLA6DUhp6weuXUpN9bwGQvkUnn3IQw6j6Fzg=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 10/10] NFS: Try to join page groups before an O_DIRECT retransmission
Date:   Wed,  1 Apr 2020 14:56:52 -0400
Message-Id: <20200401185652.1904777-11-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401185652.1904777-10-trondmy@kernel.org>
References: <20200401185652.1904777-1-trondmy@kernel.org>
 <20200401185652.1904777-2-trondmy@kernel.org>
 <20200401185652.1904777-3-trondmy@kernel.org>
 <20200401185652.1904777-4-trondmy@kernel.org>
 <20200401185652.1904777-5-trondmy@kernel.org>
 <20200401185652.1904777-6-trondmy@kernel.org>
 <20200401185652.1904777-7-trondmy@kernel.org>
 <20200401185652.1904777-8-trondmy@kernel.org>
 <20200401185652.1904777-9-trondmy@kernel.org>
 <20200401185652.1904777-10-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we have to retransmit requests, try to join their page groups
first.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c          | 20 ++++++++++++++++++++
 fs/nfs/write.c           |  2 +-
 include/linux/nfs_page.h |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 8074304fd5b4..a57e7c72c7f4 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -505,6 +505,24 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter)
 	return result;
 }
 
+static void
+nfs_direct_join_group(struct list_head *list, struct inode *inode)
+{
+	struct nfs_page *req, *next;
+
+	list_for_each_entry(req, list, wb_list) {
+		if (req->wb_head != req || req->wb_this_page == req)
+			continue;
+		for (next = req->wb_this_page;
+				next != req->wb_head;
+				next = next->wb_this_page) {
+			nfs_list_remove_request(next);
+			nfs_release_request(next);
+		}
+		nfs_join_page_group(req, inode);
+	}
+}
+
 static void
 nfs_direct_write_scan_commit_list(struct inode *inode,
 				  struct list_head *list,
@@ -527,6 +545,8 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 	nfs_direct_write_scan_commit_list(dreq->inode, &reqs, &cinfo);
 
+	nfs_direct_join_group(&reqs, dreq->inode);
+
 	dreq->count = 0;
 	dreq->max_count = 0;
 	list_for_each_entry(req, &reqs, wb_list)
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 63b64333c3ea..df4b87c30ac9 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -501,7 +501,7 @@ nfs_destroy_unlinked_subrequests(struct nfs_page *destroy_list,
  * the (former) group.  All subrequests are removed from any write or commit
  * lists, unlinked from the group and destroyed.
  */
-static void
+void
 nfs_join_page_group(struct nfs_page *head, struct inode *inode)
 {
 	struct nfs_page *subreq;
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 99198c039bd6..c32c15216da3 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -141,6 +141,7 @@ extern	void nfs_unlock_request(struct nfs_page *req);
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
 extern	struct nfs_page *nfs_page_group_lock_head(struct nfs_page *req);
 extern	int nfs_page_group_lock_subrequests(struct nfs_page *head);
+extern	void nfs_join_page_group(struct nfs_page *head, struct inode *inode);
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
 extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
-- 
2.25.1

