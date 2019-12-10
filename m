Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 320CB1191F0
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Dec 2019 21:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbfLJU3s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Dec 2019 15:29:48 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:35434 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbfLJU3s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Dec 2019 15:29:48 -0500
Received: by mail-yw1-f68.google.com with SMTP id i190so7855513ywc.2
        for <linux-nfs@vger.kernel.org>; Tue, 10 Dec 2019 12:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N/nhr9SYe3Lf1NBGV+k83w8+Y7/b7c+eVtxtCi3KLLE=;
        b=CcQ+xP2Duo20BVtLTsVYwzYBHY1rT2iGmZ+MzpvThV8XLGTQvuaplAf9G8XoaZm6NU
         foXvX60VsQGuBjJDToSjEsEFu6neG2LhzKmy8OIVEQxtRez8NFDBS8iYNMNHvQefQJIE
         izU9UsbNlQeHA6CCMB6sisQORAoLW2QqOhz6/qJAVgIqso90k1yP9w3w5MjGpTFIMVLs
         Mj9H6iDFktxlGzs5nHgGwy9MVQdABhJ5kJkj3pzKz1qajNIH6IftIp0/gaqtmIrM3UES
         3/vNkHIqNk12Vx7umyHWSGBIM2QbGK4Eg9gtLR/ywyUIf+1EgpDKVp9y7iP7xCSYZsV3
         8/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/nhr9SYe3Lf1NBGV+k83w8+Y7/b7c+eVtxtCi3KLLE=;
        b=lLui7wB8Nf14qJDxRDniKjRWSDTZyfU+tIC8X0u3rCfx7EsQv+6T6xSb2o1E4M0mS6
         6W5Qdken7+kfUl53UbL9Seuot4T2SO/kXtugZ+zYvjEiVY7yhsJ4gGKjD5f1P/IVURJy
         oN4dCWHd+wH4oWRupMoPshzbor5CIRGs+7k82e/CFT7BitvFpjaU0hnducsnKS4xbH1x
         1g6qVaxXj6J9sSxJxD0C3Eprea/x/cZ7LQCQp4GsXeBzrIQuxK5548pMyx4eZ8ARkbSY
         vQOjQtFsZPvHi181i0Id9sofaMbwq85qLtrBNaVgbHad4Rxl9kkO3LhRa3TtUqTHPZF1
         H6aQ==
X-Gm-Message-State: APjAAAXRRua9Lg08YUfvEybjGNWROit6VfrcttDN9XTog4up3EIpXABB
        Z6WnOOWxAaPF3Gl5PyJD7sVnGiY=
X-Google-Smtp-Source: APXvYqwcwvyt94dehcqmXngDlCkUHE1nmvZBzfmPKeAj1UzJlZM5wHEoqjELlO5UpRaRnM8NBVPiQw==
X-Received: by 2002:a0d:cd44:: with SMTP id p65mr27126217ywd.118.1576009786856;
        Tue, 10 Dec 2019 12:29:46 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id x84sm1947508ywg.47.2019.12.10.12.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 12:29:46 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH 2/6] nfsd: cleanup nfsd_file_lru_dispose()
Date:   Tue, 10 Dec 2019 15:27:31 -0500
Message-Id: <20191210202735.304477-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191210202735.304477-2-trond.myklebust@hammerspace.com>
References: <20191210202735.304477-1-trond.myklebust@hammerspace.com>
 <20191210202735.304477-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 0a3e5c2aac4b..c048e3071db7 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -256,8 +256,6 @@ nfsd_file_do_unhash(struct nfsd_file *nf)
 		nfsd_reset_boot_verifier(net_generic(nf->nf_net, nfsd_net_id));
 	--nfsd_file_hashtbl[nf->nf_hashval].nfb_count;
 	hlist_del_rcu(&nf->nf_node);
-	if (!list_empty(&nf->nf_lru))
-		list_lru_del(&nfsd_file_lru, &nf->nf_lru);
 	atomic_long_dec(&nfsd_filecache_count);
 }
 
@@ -266,6 +264,8 @@ nfsd_file_unhash(struct nfsd_file *nf)
 {
 	if (test_and_clear_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
 		nfsd_file_do_unhash(nf);
+		if (!list_empty(&nf->nf_lru))
+			list_lru_del(&nfsd_file_lru, &nf->nf_lru);
 		return true;
 	}
 	return false;
@@ -402,15 +402,14 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 static void
 nfsd_file_lru_dispose(struct list_head *head)
 {
-	while(!list_empty(head)) {
-		struct nfsd_file *nf = list_first_entry(head,
-				struct nfsd_file, nf_lru);
-		list_del_init(&nf->nf_lru);
+	struct nfsd_file *nf;
+
+	list_for_each_entry(nf, head, nf_lru) {
 		spin_lock(&nfsd_file_hashtbl[nf->nf_hashval].nfb_lock);
 		nfsd_file_do_unhash(nf);
 		spin_unlock(&nfsd_file_hashtbl[nf->nf_hashval].nfb_lock);
-		nfsd_file_put_noref(nf);
 	}
+	nfsd_file_dispose_list(head);
 }
 
 static unsigned long
-- 
2.23.0

