Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4087305546
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jan 2021 09:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhA0II7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jan 2021 03:08:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234489AbhA0IFA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jan 2021 03:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611734614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=gHJF4jk8KhLzZHekQ9mnv2EKCBiL8OEfeMhNYWKWB0U=;
        b=B/orre4vy5nCx0eIerkfmaNuuNFqREDhIZ3cnFclWB10jQ1PlOqdnWIZi9IFR0Uk6h7bqU
        HIRKE/8MDfvWf31NzzrlyqQyw0cV4XWed+Src7Lke2ReSmUYXOHgWzyiX6ZOryFui3mAo2
        LHMxATiVpuP3jPrJcA1pIRhJTSo/Nq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-YO0ZBW8kMEOirYUzyhTSqA-1; Wed, 27 Jan 2021 03:03:33 -0500
X-MC-Unique: YO0ZBW8kMEOirYUzyhTSqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E040C801AA7;
        Wed, 27 Jan 2021 08:03:31 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-112-111.rdu2.redhat.com [10.10.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 706ED1F0;
        Wed, 27 Jan 2021 08:03:31 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/8] NFS: Allow internal use of read structs and functions
Date:   Wed, 27 Jan 2021 03:03:15 -0500
Message-Id: <1611734597-14754-7-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1611734597-14754-2-git-send-email-dwysocha@redhat.com>
References: <1611734597-14754-2-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The conversion of the NFS read paths to the new fscache API
will require use of a few read structs and functions,
so move these declarations as required.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/internal.h |  8 ++++++++
 fs/nfs/read.c     | 13 ++++---------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 62d3189745cd..8514d002c922 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -457,9 +457,17 @@ extern char *nfs_path(char **p, struct dentry *dentry,
 
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
 
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index d2b6dce1f99f..9618abf01136 100644
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
 	struct nfs_readdesc *desc = data;
-- 
1.8.3.1

