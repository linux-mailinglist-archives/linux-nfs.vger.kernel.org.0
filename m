Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AFF2A69B2
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgKDQ1V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbgKDQ1T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:19 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC1CC0613D4
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:19 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id t5so4018109qtp.2
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XfoodEipPydo9i+BM5Q0PHWBV4Ukm2TC8rEaUOKmKGU=;
        b=c5LFuR0xu7tnPGhwUhonmGCH48vJeklIv2F+DzJ2Xd/wJU4fO7TCuITsYrd8zEfZYS
         jHFjpcsABRxSyRLkAKGz1FNDCnGmXbQqhv18obkyfKlTcLheBJFq/JeCdkYqsoD/rfyu
         l4inuU+7UYk1bhqaHxNfToFLfXs3htkn7YRcUrU1HeF9T55HZ+zW9aw7crmMd8ZU8n5p
         weAcOyrDLGpi/s0YHcuR4Yzj+cYkliPaXoLb6xGA3XNc3zW5clMiH4xgxMMpFoYwLO7E
         YEatgcRk7rtlzsq0MELwmOEY25m6EVbyjLZr6SsulU4X4lcWMZjKgWVWu2Y2f/CiZYey
         +1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfoodEipPydo9i+BM5Q0PHWBV4Ukm2TC8rEaUOKmKGU=;
        b=cRDJJQBoTuwgRLvlW3SNcZ0i4ugn5xjSxhs8y/OBibvmpcW49n/Oi8JZTrq8hBfErp
         yVN+CT0r0La+soxlTo0JTUkheq+PCHPtycwPyZRnfNWcyGJ6sHrONHtxeLKGL6yhjb8I
         WFaghaIeHp4RorFOBHbPZarinSNyDgOoHmElIVKG48ccEkMzr1Y2RS6d28i9lBajcnFS
         MajaPRUKTYg7r2NBrciESUzmAEh1NXIXvZ56ZTxkGszPeXoOLpng7vWbQYnpG0ddLsrD
         iL3P3iKlxaNNTO5ivGm5mggtNGhf/1yxmqRQ9rWicgrbE++xe5ersCtZodYILFplPgJb
         /x+w==
X-Gm-Message-State: AOAM531hHyyRZu2jM+oAiBTWEGQiGTfg9hK7BQosvyLRL7d3vOwK8t1a
        PrRNCEOBYSkDMfGG2UsljfOPp1RGl76D
X-Google-Smtp-Source: ABdhPJziy6+iYGK07xGAqDo7lQ5ZoETPEKwIoOHhYGAnpE9v8rqpv33yuJDNzg/QkU4eokjTu7NYyw==
X-Received: by 2002:ac8:5942:: with SMTP id 2mr12264676qtz.183.1604507238095;
        Wed, 04 Nov 2020 08:27:18 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.16
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:17 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 15/17] NFS: Handle NFS4ERR_NOT_SAME and NFSERR_BADCOOKIE from readdir calls
Date:   Wed,  4 Nov 2020 11:16:36 -0500
Message-Id: <20201104161638.300324-16-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-15-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com>
 <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com>
 <20201104161638.300324-5-trond.myklebust@hammerspace.com>
 <20201104161638.300324-6-trond.myklebust@hammerspace.com>
 <20201104161638.300324-7-trond.myklebust@hammerspace.com>
 <20201104161638.300324-8-trond.myklebust@hammerspace.com>
 <20201104161638.300324-9-trond.myklebust@hammerspace.com>
 <20201104161638.300324-10-trond.myklebust@hammerspace.com>
 <20201104161638.300324-11-trond.myklebust@hammerspace.com>
 <20201104161638.300324-12-trond.myklebust@hammerspace.com>
 <20201104161638.300324-13-trond.myklebust@hammerspace.com>
 <20201104161638.300324-14-trond.myklebust@hammerspace.com>
 <20201104161638.300324-15-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server returns NFS4ERR_NOT_SAME or tells us that the cookie is
bad in response to a READDIR call, then we should empty the page cache
so that we can fill it from scratch again.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c      | 24 ++++++++++++++++--------
 fs/nfs/nfs4proc.c |  2 ++
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 3ee0668a9719..3b44bef3a1b4 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -861,15 +861,21 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 		return -ENOMEM;
 	if (nfs_readdir_page_needs_filling(desc->page)) {
 		res = nfs_readdir_xdr_to_array(desc, desc->page, inode);
-		if (res < 0)
-			goto error;
+		if (res < 0) {
+			nfs_readdir_page_unlock_and_put_cached(desc);
+			if (res == -EBADCOOKIE || res == -ENOTSYNC) {
+				invalidate_inode_pages2(desc->file->f_mapping);
+				desc->page_index = 0;
+				return -EAGAIN;
+			}
+			return res;
+		}
 	}
 	res = nfs_readdir_search_array(desc);
 	if (res == 0) {
 		nfsi->page_index = desc->page_index;
 		return 0;
 	}
-error:
 	nfs_readdir_page_unlock_and_put_cached(desc);
 	return res;
 }
@@ -879,12 +885,12 @@ static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 {
 	int res;
 
-	if (desc->page_index == 0) {
-		desc->current_index = 0;
-		desc->prev_index = 0;
-		desc->last_cookie = 0;
-	}
 	do {
+		if (desc->page_index == 0) {
+			desc->current_index = 0;
+			desc->prev_index = 0;
+			desc->last_cookie = 0;
+		}
 		res = find_and_lock_cache_page(desc);
 	} while (res == -EAGAIN);
 	return res;
@@ -1030,6 +1036,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 				res = uncached_readdir(desc);
 				if (res == 0)
 					continue;
+				if (res == -EBADCOOKIE || res == -ENOTSYNC)
+					res = 0;
 			}
 			break;
 		}
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 8e82f988a11f..3f1fdb06ba56 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -184,6 +184,8 @@ static int nfs4_map_errors(int err)
 		return -EPROTONOSUPPORT;
 	case -NFS4ERR_FILE_OPEN:
 		return -EBUSY;
+	case -NFS4ERR_NOT_SAME:
+		return -ENOTSYNC;
 	default:
 		dprintk("%s could not handle NFSv4 error %d\n",
 				__func__, -err);
-- 
2.28.0

