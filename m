Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982442A4A23
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 16:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgKCPnn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 10:43:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbgKCPnm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Nov 2020 10:43:42 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D857B221FB
        for <linux-nfs@vger.kernel.org>; Tue,  3 Nov 2020 15:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604418222;
        bh=3wr7BivWD8kq0r12G3AOEQsS0qQNPXTmf8wMwj8LqFE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I/bEFSSNNG15l+P5ZuwR2SjVPNX/ApelE6izKapFpRe2PsrMcZBheTlpqDopKpVy1
         RIQLujywNMpVURlJcX4vF3tbmgo1WEM/uKKC1HHZbvv9Y59G13s86NziyrsuiG9T+u
         sgyeqHaszsUrFJND4UpyCjFVN9kTMYjc/AJTMGXE=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 03/16] NFS: Clean up nfs_readdir_page_filler()
Date:   Tue,  3 Nov 2020 10:33:16 -0500
Message-Id: <20201103153329.531942-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103153329.531942-3-trondmy@kernel.org>
References: <20201103153329.531942-1-trondmy@kernel.org>
 <20201103153329.531942-2-trondmy@kernel.org>
 <20201103153329.531942-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Clean up handling of the case where there are no entries in the readdir
reply.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
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

