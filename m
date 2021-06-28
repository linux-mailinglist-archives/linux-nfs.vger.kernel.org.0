Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A623B67CA
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 19:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhF1Rli (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 13:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39330 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233194AbhF1Rlh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Jun 2021 13:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624901951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=QOSwNMw98klLDhYhs9jeciNp8ljVmV8Bz++RuxnwhJE=;
        b=AL4E0eQA4iP+H7UKYdH+HaVVj8k5CVV0+/enHqkY61mhysDmH/7pTsXZCSlgPs/uzE61sK
        jNDOKxeHscUPohRX/olAXsKhMqIxCwM0A39O5Hd52opektfchNNFBf3cgluTkTJy+tFZW1
        NLikphAJ1bksrSwQtqFqLcG4bG0RmQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-ZyootCfMOeGCBmQZFuC0dA-1; Mon, 28 Jun 2021 13:39:09 -0400
X-MC-Unique: ZyootCfMOeGCBmQZFuC0dA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99AE119251A6;
        Mon, 28 Jun 2021 17:39:08 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.151])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 37AF65E26F;
        Mon, 28 Jun 2021 17:39:08 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/4] NFS: Allow internal use of read structs and functions
Date:   Mon, 28 Jun 2021 13:39:02 -0400
Message-Id: <1624901943-20027-4-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
References: <1624901943-20027-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The conversion of the NFS read paths to the new fscache API
will require use of a few read structs and functions,
so move these declarations as required.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/internal.h |  7 +++++++
 fs/nfs/read.c     | 13 ++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a36af04188c2..f9f6c6a6370f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -463,9 +463,16 @@ extern char *nfs_path(char **p, struct dentry *dentry,
 
 struct nfs_pgio_completion_ops;
 /* read.c */
+extern const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
 extern void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 			struct inode *inode, bool force_mds,
 			const struct nfs_pgio_completion_ops *compl_ops);
+struct nfs_readdesc {
+	struct nfs_pageio_descriptor pgio;
+	struct nfs_open_context *ctx;
+};
+extern int readpage_async_filler(void *data, struct page *page);
+extern int nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio);
 extern void nfs_read_prepare(struct rpc_task *task, void *calldata);
 extern void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio);
 
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index b0680351df23..a0b4ce6893a8 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -30,7 +30,7 @@
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
-static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
+const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
 static const struct nfs_rw_ops nfs_rw_read_ops;
 
 static struct kmem_cache *nfs_rdata_cachep;
@@ -74,7 +74,7 @@ void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 }
 EXPORT_SYMBOL_GPL(nfs_pageio_init_read);
 
-static int nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio)
+int nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio)
 {
 	struct nfs_pgio_mirror *pgm;
 	unsigned long npages;
@@ -133,11 +133,6 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
 	nfs_release_request(req);
 }
 
-struct nfs_readdesc {
-	struct nfs_pageio_descriptor pgio;
-	struct nfs_open_context *ctx;
-};
-
 static void nfs_page_group_set_uptodate(struct nfs_page *req)
 {
 	if (nfs_page_group_sync_on_bit(req, PG_UPTODATE))
@@ -216,7 +211,7 @@ static void nfs_initiate_read(struct nfs_pgio_header *hdr,
 	}
 }
 
-static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
+const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
 	.error_cleanup = nfs_async_read_error,
 	.completion = nfs_read_completion,
 };
@@ -291,7 +286,7 @@ static void nfs_readpage_result(struct rpc_task *task,
 		nfs_readpage_retry(task, hdr);
 }
 
-static int
+int
 readpage_async_filler(void *data, struct page *page)
 {
 	struct nfs_readdesc *desc = data;
-- 
1.8.3.1

