Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B41E9B558
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2019 19:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbfHWRRj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Aug 2019 13:17:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43360 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388289AbfHWRRj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Aug 2019 13:17:39 -0400
Received: by mail-io1-f68.google.com with SMTP id 18so21696450ioe.10
        for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2019 10:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6qu2JMiVyUB2EtxYu6ES9OS6Sm06LS03IelBGki24No=;
        b=Lxag0YCEV2hzK9LbvlT2nnFfKN5N5gvgv7VNGIiKR51pwmMdy2J+ESPTR2RnTS8cgt
         Bl3PKDlCNzqYbOVOA3BkbG+zhn6GHQg9VmVmcs4bxTqJUqIdNq8VTIvMVqatt56bV92m
         mnkz0eUdP2fuavtAkSJlcY3iuNR1rZoptbNvRJ9kbHh1/tnu5f7mOYVW4ih1mo2jlrDx
         H6VTcm55622fldg8IRGBZ6LmsDNAOui9wwpzlPBqmz78Mg55Kx9o+vPJnZQ86tS4NJp4
         qVFhhTQPOPSrrDnVJcMLF7pAiCPWnrilX79ditWyrZVKsisaNBRBUcNuKhryOlxGr4yF
         FX1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6qu2JMiVyUB2EtxYu6ES9OS6Sm06LS03IelBGki24No=;
        b=DoSh2jxMBYbf0AfvutsjVWsGt+i1xNFh+YTHtrUUOVDe7nv+QqJLN9PRV27wKLANZ2
         UWnwlvNAxV1xu8Xc859N1ySu8AQ9fBOQ4pNnMAArQlQ7PmcPXJWU8c6q4SsZdmtU8vov
         yuBl3WjTkS5nX0xJo8I8UuGEYvdKGD4xRD8G7GJ5da54jI04qqBWC7mPKslgUiUKmUJX
         JSzI4B7H3gPDU+Uc4hJCIJ8Ffap1la1MJulE6W6WUKaDp/5le/3kikRZggD30FOC7Qzp
         jmyTTSqRB/ipqFwqm9RZY3wX3rBNB6U7/5Af5jrfzSJjcB83Ql3Fcfxo0tau7IBESpC+
         TzgA==
X-Gm-Message-State: APjAAAUDtitKS4YTTItHAmK4lseJHSVRCKzK4MB+jXKUAIFVxSrU+IWJ
        HW/rFggZOb5TNf3ErmIRzYJkxFwQug==
X-Google-Smtp-Source: APXvYqyVwxLKRnhP4i2CXc7chnbThQy1vr5D0l87ThIiBxglBUdDlz1q6DbthFvcXevsZUMzS5qC5A==
X-Received: by 2002:a5e:d611:: with SMTP id w17mr7708594iom.34.1566580657543;
        Fri, 23 Aug 2019 10:17:37 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id 199sm4456288iob.44.2019.08.23.10.17.36
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 10:17:36 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFS: Fix spurious EIO read errors
Date:   Fri, 23 Aug 2019 13:15:29 -0400
Message-Id: <20190823171529.27726-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If the client attempts to read a page, but the read fails due to some
spurious error (e.g. an ACCESS error or a timeout, ...) then we need
to allow other processes to retry.
Also try to report errors correctly when doing a synchronous readpage.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
- v2: Do allow fatal errors on the server to return EIO errors to the
      application.

 fs/nfs/internal.h | 10 ++++++++++
 fs/nfs/read.c     | 35 ++++++++++++++++++++++++++---------
 fs/nfs/write.c    | 12 ------------
 3 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a2346a2f8361..e64f810223be 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -775,3 +775,13 @@ static inline bool nfs_error_is_fatal(int err)
 	}
 }
 
+static inline bool nfs_error_is_fatal_on_server(int err)
+{
+	switch (err) {
+	case 0:
+	case -ERESTARTSYS:
+	case -EINTR:
+		return false;
+	}
+	return nfs_error_is_fatal(err);
+}
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index c19841c82b6a..cfe0b586eadd 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -91,19 +91,25 @@ void nfs_pageio_reset_read_mds(struct nfs_pageio_descriptor *pgio)
 }
 EXPORT_SYMBOL_GPL(nfs_pageio_reset_read_mds);
 
-static void nfs_readpage_release(struct nfs_page *req)
+static void nfs_readpage_release(struct nfs_page *req, int error)
 {
 	struct inode *inode = d_inode(nfs_req_openctx(req)->dentry);
+	struct page *page = req->wb_page;
 
 	dprintk("NFS: read done (%s/%llu %d@%lld)\n", inode->i_sb->s_id,
 		(unsigned long long)NFS_FILEID(inode), req->wb_bytes,
 		(long long)req_offset(req));
 
+	if (nfs_error_is_fatal_on_server(error) && error != -ETIMEDOUT)
+		SetPageError(page);
 	if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE)) {
-		if (PageUptodate(req->wb_page))
-			nfs_readpage_to_fscache(inode, req->wb_page, 0);
+		struct address_space *mapping = page_file_mapping(page);
 
-		unlock_page(req->wb_page);
+		if (PageUptodate(page))
+			nfs_readpage_to_fscache(inode, page, 0);
+		else if (!PageError(page) && !PagePrivate(page))
+			generic_error_remove_page(mapping, page);
+		unlock_page(page);
 	}
 	nfs_release_request(req);
 }
@@ -131,7 +137,7 @@ int nfs_readpage_async(struct nfs_open_context *ctx, struct inode *inode,
 			     &nfs_async_read_completion_ops);
 	if (!nfs_pageio_add_request(&pgio, new)) {
 		nfs_list_remove_request(new);
-		nfs_readpage_release(new);
+		nfs_readpage_release(new, pgio.pg_error);
 	}
 	nfs_pageio_complete(&pgio);
 
@@ -153,6 +159,7 @@ static void nfs_page_group_set_uptodate(struct nfs_page *req)
 static void nfs_read_completion(struct nfs_pgio_header *hdr)
 {
 	unsigned long bytes = 0;
+	int error;
 
 	if (test_bit(NFS_IOHDR_REDO, &hdr->flags))
 		goto out;
@@ -179,14 +186,19 @@ static void nfs_read_completion(struct nfs_pgio_header *hdr)
 				zero_user_segment(page, start, end);
 			}
 		}
+		error = 0;
 		bytes += req->wb_bytes;
 		if (test_bit(NFS_IOHDR_ERROR, &hdr->flags)) {
 			if (bytes <= hdr->good_bytes)
 				nfs_page_group_set_uptodate(req);
+			else {
+				error = hdr->error;
+				xchg(&nfs_req_openctx(req)->error, error);
+			}
 		} else
 			nfs_page_group_set_uptodate(req);
 		nfs_list_remove_request(req);
-		nfs_readpage_release(req);
+		nfs_readpage_release(req, error);
 	}
 out:
 	hdr->release(hdr);
@@ -213,7 +225,7 @@ nfs_async_read_error(struct list_head *head, int error)
 	while (!list_empty(head)) {
 		req = nfs_list_entry(head->next);
 		nfs_list_remove_request(req);
-		nfs_readpage_release(req);
+		nfs_readpage_release(req, error);
 	}
 }
 
@@ -337,8 +349,13 @@ int nfs_readpage(struct file *file, struct page *page)
 			goto out;
 	}
 
+	xchg(&ctx->error, 0);
 	error = nfs_readpage_async(ctx, inode, page);
-
+	if (!error) {
+		error = wait_on_page_locked_killable(page);
+		if (!PageUptodate(page) && !error)
+			error = xchg(&ctx->error, 0);
+	}
 out:
 	put_nfs_open_context(ctx);
 	return error;
@@ -372,8 +389,8 @@ readpage_async_filler(void *data, struct page *page)
 		zero_user_segment(page, len, PAGE_SIZE);
 	if (!nfs_pageio_add_request(desc->pgio, new)) {
 		nfs_list_remove_request(new);
-		nfs_readpage_release(new);
 		error = desc->pgio->pg_error;
+		nfs_readpage_release(new, error);
 		goto out;
 	}
 	return 0;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 3399149435ce..cee9905e419c 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -599,18 +599,6 @@ static void nfs_write_error(struct nfs_page *req, int error)
 	nfs_release_request(req);
 }
 
-static bool
-nfs_error_is_fatal_on_server(int err)
-{
-	switch (err) {
-	case 0:
-	case -ERESTARTSYS:
-	case -EINTR:
-		return false;
-	}
-	return nfs_error_is_fatal(err);
-}
-
 /*
  * Find an associated nfs write request, and prepare to flush it out
  * May return an error if the user signalled nfs_wait_on_request().
-- 
2.21.0

