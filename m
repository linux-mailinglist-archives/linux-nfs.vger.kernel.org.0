Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8511C221090
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2020 17:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGOPL5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jul 2020 11:11:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40562 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725770AbgGOPL4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jul 2020 11:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594825914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=c5b3XQ9WjR0YBaYTlAJ491KTgAyJMkpeFCX7YgY/5tk=;
        b=KveFdQsA/UQF/8iUKauhKuPpnFb5CaM/O8Xr2IysocT9C/VCG80B7RsdqbDySJrbCS6fVW
        Rdi4UN3CGT2vgUWTDmpUaWvbdk4kjIiK1xHvTlCM9Es88ikE2pKWhS38QerjynVA4yGJ6s
        /cAWCcis5SamR9TRLQMELTQsTPC9MRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-z31x22EtMi-5Bi24tbluvA-1; Wed, 15 Jul 2020 11:11:52 -0400
X-MC-Unique: z31x22EtMi-5Bi24tbluvA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE33F803E4A;
        Wed, 15 Jul 2020 15:10:54 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-118-79.rdu2.redhat.com [10.10.118.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8234460BF1;
        Wed, 15 Jul 2020 15:10:54 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v1 06/13] NFS: Rename readpage_async_filler() to nfs_pageio_add_page_read()
Date:   Wed, 15 Jul 2020 11:10:42 -0400
Message-Id: <1594825849-24991-7-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1594825849-24991-1-git-send-email-dwysocha@redhat.com>
References: <1594825849-24991-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rename the function that handles adding a page to an existing
nfs_pageio_descriptor and export for future use.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/internal.h |  3 +++
 fs/nfs/read.c     | 13 ++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6673a77884d9..df4ffe9afb6a 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -446,6 +446,9 @@ extern char *nfs_path(char **p, struct dentry *dentry,
 extern void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 			struct inode *inode, bool force_mds,
 			const struct nfs_pgio_completion_ops *compl_ops);
+extern int nfs_pageio_add_page_read(void *data, struct page *page);
+extern void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
+				     struct inode *inode);
 extern void nfs_read_prepare(struct rpc_task *task, void *calldata);
 extern void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio);
 
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 32d359604220..de57bb692a4b 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -74,8 +74,8 @@ void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 }
 EXPORT_SYMBOL_GPL(nfs_pageio_init_read);
 
-static void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
-				     struct inode *inode)
+void nfs_pageio_complete_read(struct nfs_pageio_descriptor *pgio,
+			      struct inode *inode)
 {
 	struct nfs_pgio_mirror *pgm;
 	unsigned long npages;
@@ -158,7 +158,7 @@ static void nfs_read_completion(struct nfs_pgio_header *hdr)
 
 		if (test_bit(NFS_IOHDR_EOF, &hdr->flags)) {
 			/* note: regions of the page not covered by a
-			 * request are zeroed in readpage_async_filler */
+			 * request are zeroed in nfs_pageio_add_page_read */
 			if (bytes > hdr->good_bytes) {
 				/* nothing in this request was good, so zero
 				 * the full extent of the request */
@@ -290,8 +290,7 @@ static void nfs_readpage_result(struct rpc_task *task,
 		nfs_readpage_retry(task, hdr);
 }
 
-static int
-readpage_async_filler(void *data, struct page *page)
+int nfs_pageio_add_page_read(void *data, struct page *page)
 {
 	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
 	struct nfs_page *new;
@@ -375,7 +374,7 @@ int nfs_readpage(struct file *filp, struct page *page)
 	nfs_pageio_init_read(desc.pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
-	ret = readpage_async_filler(desc.pgio, page);
+	ret = nfs_pageio_add_page_read(desc.pgio, page);
 
 	if (!ret)
 		nfs_pageio_complete_read(desc.pgio, inode);
@@ -432,7 +431,7 @@ int nfs_readpages(struct file *filp, struct address_space *mapping,
 	nfs_pageio_init_read(&pgio, inode, false,
 			     &nfs_async_read_completion_ops);
 
-	ret = read_cache_pages(mapping, pages, readpage_async_filler, &desc);
+	ret = read_cache_pages(mapping, pages, nfs_pageio_add_page_read, &desc);
 
 	nfs_pageio_complete_read(desc.pgio, inode);
 
-- 
1.8.3.1

