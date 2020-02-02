Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2487514FFDD
	for <lists+linux-nfs@lfdr.de>; Sun,  2 Feb 2020 23:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgBBW4K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 2 Feb 2020 17:56:10 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37121 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgBBW4J (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 2 Feb 2020 17:56:09 -0500
Received: by mail-yw1-f66.google.com with SMTP id l5so11952351ywd.4
        for <linux-nfs@vger.kernel.org>; Sun, 02 Feb 2020 14:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1hQ1NtRCTr1DhJGTY9effkGJ/kVi7dUZ88IQ4Kn0kjk=;
        b=g1zaao/C//JNnDwfYCGtb0D0mKafnVOcqQJCv1FLym+U9UaRKkkq+M1Qyq9rLcKyY4
         2qL/tk4y8lhvwn/PM3yRhLWLWNhhZRPUMSwz4K7kpyqcOZl4KUWEtYULVe2qFU6i5pP1
         B7lowD8TxFslto3uw8MWOM6tY5nvvlb01PQYCjmxLwXldKBNTUNemfBY09SYHtDISB8S
         c+Susd+d7wKU6bF6grFD4Qp6hjUKlu8/HoO4QupkceMZCc6RJQXR8eDoc6DR2CdBUjdU
         lWDQscRLtGOFWlN79HLWKqTYyuJ6SX3e6Zr8mvkcrrXjRLq177siTakhh/rFUv6oHdXN
         oHkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1hQ1NtRCTr1DhJGTY9effkGJ/kVi7dUZ88IQ4Kn0kjk=;
        b=pgR33DQQ4NJUYVDD6v+xl2hX++RIlKfzqsUOnDFvJ5dGzVoe9238yaZMUl8iJY6Nhi
         4tO3/WB1klGpMXJj3H1PZ4Wdi0M4Nsi6aG4Ew3YOYN78IhQ4loHgjNNfoXK0oioFTmwu
         /8X7y7AuNg8xrkIN9YeQzBEm1vZ9Uw/Jx3VsrOk7NKmxiGC+IeraQf1xeq7PFDTSW50h
         H1d5dvSw8ufza/gOrKFiAiLuxKBgJU16/ABKRDB9Nhsxa6XhRu0EX5kBpi1CyfeiISY+
         RmASaAzRaFQfWjMl5HeZACUFQmUUU+uZgeCVLgLSTxl/CD4UMsykFTfrUClIVevCYnHE
         tRoQ==
X-Gm-Message-State: APjAAAXKT6yoWv4I97aJiabbB/m6TssNdBzPDwRKXNiyde8evsh/zItb
        dl4uIHOdBbqE7HWfRau57g==
X-Google-Smtp-Source: APXvYqwUpcdmTnrD2dku+D+Qk4tg3JlqTSQWfw0xDq7xZWMkVvXPPirIAHsqfKP6rJs/X6uVbXoqCQ==
X-Received: by 2002:a25:c0cf:: with SMTP id c198mr16605284ybf.135.1580684168905;
        Sun, 02 Feb 2020 14:56:08 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id u136sm7185529ywf.101.2020.02.02.14.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 14:56:08 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Benjamin Coddington <bcodding@redhat.com>,
        Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] NFS: Directory page cache pages need to be locked when read
Date:   Sun,  2 Feb 2020 17:53:54 -0500
Message-Id: <20200202225356.995080-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200202225356.995080-2-trond.myklebust@hammerspace.com>
References: <20200202225356.995080-1-trond.myklebust@hammerspace.com>
 <20200202225356.995080-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When a NFS directory page cache page is removed from the page cache,
its contents are freed through a call to nfs_readdir_clear_array().
To prevent the removal of the page cache entry until after we've
finished reading it, we must take the page lock.

Fixes: 11de3b11e08c ("NFS: Fix a memory leak in nfs_readdir")
Cc: stable@vger.kernel.org # v2.6.37+
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ba0d55930e8a..90467b44ec13 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -705,8 +705,6 @@ int nfs_readdir_filler(void *data, struct page* page)
 static
 void cache_page_release(nfs_readdir_descriptor_t *desc)
 {
-	if (!desc->page->mapping)
-		nfs_readdir_clear_array(desc->page);
 	put_page(desc->page);
 	desc->page = NULL;
 }
@@ -720,19 +718,28 @@ struct page *get_cache_page(nfs_readdir_descriptor_t *desc)
 
 /*
  * Returns 0 if desc->dir_cookie was found on page desc->page_index
+ * and locks the page to prevent removal from the page cache.
  */
 static
-int find_cache_page(nfs_readdir_descriptor_t *desc)
+int find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
 {
 	int res;
 
 	desc->page = get_cache_page(desc);
 	if (IS_ERR(desc->page))
 		return PTR_ERR(desc->page);
-
-	res = nfs_readdir_search_array(desc);
+	res = lock_page_killable(desc->page);
 	if (res != 0)
-		cache_page_release(desc);
+		goto error;
+	res = -EAGAIN;
+	if (desc->page->mapping != NULL) {
+		res = nfs_readdir_search_array(desc);
+		if (res == 0)
+			return 0;
+	}
+	unlock_page(desc->page);
+error:
+	cache_page_release(desc);
 	return res;
 }
 
@@ -747,7 +754,7 @@ int readdir_search_pagecache(nfs_readdir_descriptor_t *desc)
 		desc->last_cookie = 0;
 	}
 	do {
-		res = find_cache_page(desc);
+		res = find_and_lock_cache_page(desc);
 	} while (res == -EAGAIN);
 	return res;
 }
@@ -786,7 +793,6 @@ int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
 		desc->eof = true;
 
 	kunmap(desc->page);
-	cache_page_release(desc);
 	dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @ cookie %Lu; returning = %d\n",
 			(unsigned long long)*desc->dir_cookie, res);
 	return res;
@@ -832,13 +838,13 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
 
 	status = nfs_do_filldir(desc);
 
+ out_release:
+	nfs_readdir_clear_array(desc->page);
+	cache_page_release(desc);
  out:
 	dfprintk(DIRCACHE, "NFS: %s: returns %d\n",
 			__func__, status);
 	return status;
- out_release:
-	cache_page_release(desc);
-	goto out;
 }
 
 /* The file offset position represents the dirent entry number.  A
@@ -903,6 +909,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 			break;
 
 		res = nfs_do_filldir(desc);
+		unlock_page(desc->page);
+		cache_page_release(desc);
 		if (res < 0)
 			break;
 	} while (!desc->eof);
-- 
2.24.1

