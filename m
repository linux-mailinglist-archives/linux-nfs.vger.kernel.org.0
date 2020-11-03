Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5565E2A4A30
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 16:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgKCPnu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 10:43:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbgKCPns (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Nov 2020 10:43:48 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97CB4221FB
        for <linux-nfs@vger.kernel.org>; Tue,  3 Nov 2020 15:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604418227;
        bh=FPtoZCsedxzbjOCAhbIEmF2DkwqPGmtc/E+5lRJnw00=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OMz61cw/RHPoUUSiQBZ8JqWnvN23dzX4rS1gFq2HcHLF+tI5vk2w9BT1NqGt6QnbK
         5qwOJ1NKlyP7wl8UfuFLP4vSl1HAVeTuDU46Idj/FLjOubZqaigd4LqTJGUbtmj7sn
         6Nf9o/R/Sdp8gp7QJKbPN+APDbIkVc3ypwPjtB2Q=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 15/16] NFS: Handle NFS4ERR_NOT_SAME and NFSERR_BADCOOKIE from readdir calls
Date:   Tue,  3 Nov 2020 10:33:28 -0500
Message-Id: <20201103153329.531942-16-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103153329.531942-15-trondmy@kernel.org>
References: <20201103153329.531942-1-trondmy@kernel.org>
 <20201103153329.531942-2-trondmy@kernel.org>
 <20201103153329.531942-3-trondmy@kernel.org>
 <20201103153329.531942-4-trondmy@kernel.org>
 <20201103153329.531942-5-trondmy@kernel.org>
 <20201103153329.531942-6-trondmy@kernel.org>
 <20201103153329.531942-7-trondmy@kernel.org>
 <20201103153329.531942-8-trondmy@kernel.org>
 <20201103153329.531942-9-trondmy@kernel.org>
 <20201103153329.531942-10-trondmy@kernel.org>
 <20201103153329.531942-11-trondmy@kernel.org>
 <20201103153329.531942-12-trondmy@kernel.org>
 <20201103153329.531942-13-trondmy@kernel.org>
 <20201103153329.531942-14-trondmy@kernel.org>
 <20201103153329.531942-15-trondmy@kernel.org>
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
index d467df099c04..1c5a5f9cb228 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -862,15 +862,21 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
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
@@ -880,12 +886,12 @@ static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
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
@@ -1031,6 +1037,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
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

