Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2F2A69A2
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgKDQ1G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKDQ1F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:05 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6AAC0613D3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:05 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 12so15909650qkl.8
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uIT7c42oLJhGuQ4MC0Mb1wvuxjVAQj6q8C6vaQFmtk4=;
        b=KY/Ly0Hi6NaqdG30f1semQEZQ+ig0BkfaLHMconNvFHm8QwHjmGUIsYYUVwlbf8Ra7
         RD2FLBArIL446DkXMrTSsA7BucqmcpC8nOGSJKLENLWlEZtebBTF8HrEca+Eyd/OhFzl
         9z2Hd3bgbiHdj3Z4WGSv3aMiJ2APVrgWyE5uKY3ApmB3w+ekwvOrGeQbWTxoagFHPt3Z
         Y2BJTsGc8zGGzMHUvDAv1AkLCwbY8CvWBKL5sxT/Y+ojXP/vpknman0VDsSCN3EFCqk6
         Y4h5Z0dCnscTYxAzE47wcIyVqlByElKRiPB/4VPQUjBTC8peOKuvN6ztrgHnQYpNeJaN
         TdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIT7c42oLJhGuQ4MC0Mb1wvuxjVAQj6q8C6vaQFmtk4=;
        b=JBPnO6URKIrSItUVVz+dmbKwo5FS8WhYHQKCTQrvZTMTw4RcWjDd0i6r4AcsT5X4Uh
         ZeQLplXsR50l/BotxxcoXkbLDk1krLmE/ZrXedZiHM8Pn6W75OTbiTWNQM+voYavJ5p2
         G8vh4t3zQRCP0znTLxv60BJ2m9deyiL//wxVy4HG5IOkXrfHw7pKAjcCsWUtgZVEaih5
         B5kO29ZgFV3qHQnAtXtwjLzlEvlGhyOqZo2kLUMA7K24uuii3oGEGbz2p/9a0bjSin1/
         zGWsQFUhbzBhsdZ+LvXaA1YjSWq/Zy202kacfYJiZhUwieDEaazGkRQIafmzV3Y6Tgma
         XXVA==
X-Gm-Message-State: AOAM533B7odrQGByV4ArTxpEvoZ9QlfhUGKfMN18t9Yghf1zpGJENH+Z
        OzN3v4mTQkwmCTGVKsBCIOLQUj5pzz3u
X-Google-Smtp-Source: ABdhPJyEdl7/rcsu59YeOhubvflZQffn5s/tm5PTqU1BvLeoBPynTWiUFi/H3aLPzogAhigZWTVuEA==
X-Received: by 2002:a37:9acb:: with SMTP id c194mr26297149qke.288.1604507224549;
        Wed, 04 Nov 2020 08:27:04 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.03
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:03 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 03/17] NFS: Clean up nfs_readdir_page_filler()
Date:   Wed,  4 Nov 2020 11:16:24 -0500
Message-Id: <20201104161638.300324-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-3-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com>
 <20201104161638.300324-3-trond.myklebust@hammerspace.com>
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

