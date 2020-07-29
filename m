Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16511232000
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jul 2020 16:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgG2OMu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jul 2020 10:12:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47660 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726588AbgG2OMt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jul 2020 10:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596031967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ZO51AlEVjRDpbdyzlwxBpFZPFwttovNgkZLStrTVS8s=;
        b=PFHhYMUL1aUaVsmPIVrxSs/Ju/l6CxE2SCgnAag6qkVd0ZdKGxZl/6gNZOLcZSzk6nqbyj
        Nn+GpbNtmVHVUjYMWrw3ZvYpJTCx8leLhW0XLv4/1xGAGcSbFkp8UD7wOt07aIOwEHeAQP
        ijReH543Ilv2VE1WPNeCZS29maVrxQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-oCj-73irMN-laPHOn1xB2w-1; Wed, 29 Jul 2020 10:12:46 -0400
X-MC-Unique: oCj-73irMN-laPHOn1xB2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 068C718C63CA;
        Wed, 29 Jul 2020 14:12:45 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-23.rdu2.redhat.com [10.10.113.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 833C771906;
        Wed, 29 Jul 2020 14:12:44 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v2 06/14] NFS: Allow internal use of read structs and functions
Date:   Wed, 29 Jul 2020 10:12:21 -0400
Message-Id: <1596031949-26793-7-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
References: <1596031949-26793-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The conversion of the NFS read paths to the new fscache API
will require use of a few read structs and functions,
so move these declarations as required.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/internal.h |  9 +++++++++
 fs/nfs/read.c     | 13 ++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6673a77884d9..cfa848de5742 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -443,12 +443,21 @@ extern char *nfs_path(char **p, struct dentry *dentry,
 
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
+extern void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
+				     struct inode *inode);
 extern void nfs_read_prepare(struct rpc_task *task, void *calldata);
 extern void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio);
 
+
 /* super.c */
 void nfs_umount_begin(struct super_block *);
 int  nfs_statfs(struct dentry *, struct kstatfs *);
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index c2df4040f26c..13266eda8f60 100644
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
 
-static void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
+void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
 				     struct inode *inode)
 {
 	struct nfs_pgio_mirror *pgm;
@@ -132,11 +132,6 @@ static void nfs_readpage_release(struct nfs_page *req, int error)
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
@@ -215,7 +210,7 @@ static void nfs_initiate_read(struct nfs_pgio_header *hdr,
 	}
 }
 
-static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
+const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
 	.error_cleanup = nfs_async_read_error,
 	.completion = nfs_read_completion,
 };
@@ -290,7 +285,7 @@ static void nfs_readpage_result(struct rpc_task *task,
 		nfs_readpage_retry(task, hdr);
 }
 
-static int
+int
 readpage_async_filler(void *data, struct page *page)
 {
 	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
-- 
1.8.3.1

