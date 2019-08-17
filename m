Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4669A9132F
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2019 23:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfHQVYs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Aug 2019 17:24:48 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38412 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfHQVYr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Aug 2019 17:24:47 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so13240471ioa.5
        for <linux-nfs@vger.kernel.org>; Sat, 17 Aug 2019 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MDS0tZNKxie2TCRV1Ss/PJz91xkx1JaH1CgyasQ4Tto=;
        b=BiyvP1G1F+3eTdzSDGG5VJfpTFkK/BmOrDy7acqEzMZv0qoXrWq2xZzvFceyiEcvN2
         3XaYiGWodpH99o9TP3X+HCrH5/33lXj/t3hcUhJBdjYJFvlJF1icLurhmtEBnhpAnJhg
         j8hK1VAD4zV/B/SwdN6Wd+FW/ETELZawsCE3BqQ3m70N88o01fWtvO0zQZLcGQM5l266
         Kv+VO67wHfeYk4BXW67djekA7FUMKZaj3JWK0zB0jWl1J7yf8NGr201VBw0PY2xgnXKc
         7RlUabYFUiiTiRzWhQncwYHNezsUJcfkrdW+RoGPzzV1L5eYFYSuK7UnmKCHZm+XBj8w
         NmIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MDS0tZNKxie2TCRV1Ss/PJz91xkx1JaH1CgyasQ4Tto=;
        b=nX5gCJyEAwTWkcdoj3WU4+Mfry7GLru5INt4GjD8U6QnxRF9BBiuvh5N4jgkyIhn+G
         RXSJeTxhJGPKRrsdoAeVJQ+lcWh+eKmYpCCXVIyBRpMGeJEn3IL2mejtTmWaOs+Ch43c
         FQt8FhoyCuqfd9TnalmFMNIKF+y6na+MdRs+OyPrtKxhd7z3eAcl8CzCMthkrPZF5U2R
         Zrjc5tO2RUbZWo7m10Jabunbpvx4klOAbknycq3zccQBOA7zX0viakf0YZ2tbMF08DRY
         DVqZw+8f6BcEG+1bRruyjjgqYHUpmPXbPRuzOLbp4wVxxU6/wP/iWbLFW9OC+qAh36RQ
         7d7w==
X-Gm-Message-State: APjAAAW4u1IODISSqA7orkGdZgAD0fCb4D340TGW64JAPTdU3cNsgXsw
        uRvnQMzKh5lAOW0gqLjdalKb4Yg=
X-Google-Smtp-Source: APXvYqz9Ze++52gOOTWabdQsA4LkvZ5sO/Nh4T2/M+UWgi76yVpFbUf/MDggNGGChP/qrevbpdPA9g==
X-Received: by 2002:a02:5105:: with SMTP id s5mr18294029jaa.42.1566077086587;
        Sat, 17 Aug 2019 14:24:46 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q3sm4609806ios.70.2019.08.17.14.24.45
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 14:24:46 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/8] NFS: Fix spurious EIO read errors
Date:   Sat, 17 Aug 2019 17:22:12 -0400
Message-Id: <20190817212217.22766-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190817212217.22766-2-trond.myklebust@hammerspace.com>
References: <20190817212217.22766-1-trond.myklebust@hammerspace.com>
 <20190817212217.22766-2-trond.myklebust@hammerspace.com>
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
 fs/nfs/read.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index c19841c82b6a..252f31bfd497 100644
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
 
+	if (error < 0)
+		SetPageError(page);
 	if (nfs_page_group_sync_on_bit(req, PG_UNLOCKPAGE)) {
-		if (PageUptodate(req->wb_page))
-			nfs_readpage_to_fscache(inode, req->wb_page, 0);
+		struct address_space *mapping = page_file_mapping(page);
 
-		unlock_page(req->wb_page);
+		if (PageUptodate(page))
+			nfs_readpage_to_fscache(inode, page, 0);
+		else if (PageError(page) && !PagePrivate(page))
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
-- 
2.21.0

