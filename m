Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2142AE208
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 22:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbgKJVr5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 16:47:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:43114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731862AbgKJVr4 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 16:47:56 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CF8D20797
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 21:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605044875;
        bh=E0VIik7LfVLhWf0tuRnHp1yCpl001ZDxu+aBcs0HtLU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QLenGX9xamU9Q4mpfpT4IPdMAZagdv9JTSJzhKkimph67rU2wenQkx62oZasoMQna
         7gYitUHgxDR2NT/RlMpAutMDpmrUfq//DDAa5NVuL/L4YUfwS9jBvfqPONNMemqU5q
         kiZAZxHsTorOgIM9hkDoW0OOgzmTTMc/DpKHXewM=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 06/22] NFS: Clean up nfs_readdir_page_filler()
Date:   Tue, 10 Nov 2020 16:37:25 -0500
Message-Id: <20201110213741.860745-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110213741.860745-6-trondmy@kernel.org>
References: <20201110213741.860745-1-trondmy@kernel.org>
 <20201110213741.860745-2-trondmy@kernel.org>
 <20201110213741.860745-3-trondmy@kernel.org>
 <20201110213741.860745-4-trondmy@kernel.org>
 <20201110213741.860745-5-trondmy@kernel.org>
 <20201110213741.860745-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Clean up handling of the case where there are no entries in the readdir
reply.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 39 ++++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 604ebe015387..68acbde3f914 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -601,16 +601,12 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 	struct xdr_stream stream;
 	struct xdr_buf buf;
 	struct page *scratch;
-	unsigned int count = 0;
 	int status;
 
 	scratch = alloc_page(GFP_KERNEL);
 	if (scratch == NULL)
 		return -ENOMEM;
 
-	if (buflen == 0)
-		goto out_nopages;
-
 	xdr_init_decode_pages(&stream, &buf, xdr_pages, buflen);
 	xdr_set_scratch_buffer(&stream, page_address(scratch), PAGE_SIZE);
 
@@ -619,27 +615,27 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 			entry->label->len = NFS4_MAXLABELLEN;
 
 		status = xdr_decode(desc, entry, &stream);
-		if (status != 0) {
-			if (status == -EAGAIN)
-				status = 0;
+		if (status != 0)
 			break;
-		}
-
-		count++;
 
 		if (desc->plus)
 			nfs_prime_dcache(file_dentry(desc->file), entry,
 					desc->dir_verifier);
 
 		status = nfs_readdir_add_to_array(entry, page);
-		if (status != 0)
-			break;
-	} while (!entry->eof);
+	} while (!status && !entry->eof);
 
-out_nopages:
-	if (count == 0 || (status == -EBADCOOKIE && entry->eof != 0)) {
-		nfs_readdir_page_set_eof(page);
+	switch (status) {
+	case -EBADCOOKIE:
+		if (entry->eof) {
+			nfs_readdir_page_set_eof(page);
+			status = 0;
+		}
+		break;
+	case -ENOSPC:
+	case -EAGAIN:
 		status = 0;
+		break;
 	}
 
 	put_page(scratch);
@@ -714,14 +710,15 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 
 		if (status < 0)
 			break;
+
 		pglen = status;
-		status = nfs_readdir_page_filler(desc, &entry, pages, page, pglen);
-		if (status < 0) {
-			if (status == -ENOSPC)
-				status = 0;
+		if (pglen == 0) {
+			nfs_readdir_page_set_eof(page);
 			break;
 		}
-	} while (!nfs_readdir_array_is_full(array));
+
+		status = nfs_readdir_page_filler(desc, &entry, pages, page, pglen);
+	} while (!status && !nfs_readdir_array_is_full(array));
 
 	nfs_readdir_free_pages(pages, array_size);
 out_release_array:
-- 
2.28.0

