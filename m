Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717602AE213
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 22:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbgKJVsF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 16:48:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731962AbgKJVsC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 16:48:02 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8F720825
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 21:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605044882;
        bh=LoSez91B6QR/DgdC0A3cinB8W7A94Up1OO2zXI61d8U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nn0Rw9+AGg61GlHwfsM3oeFLvJweLZmencuW+15diPBSLUY8Fn2YXlyZyVKd4ns16
         wQaQXmz/rs3gaXrIqMzrLJi1amOBAc0akgzmvLta/pF7VF69Fwc5OPMcif7dvZ55eZ
         A0/ldY7QATfXTZP5oxV+wEnDzryO0iqM8xoZf7oo=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 18/22] NFS: Handle NFS4ERR_NOT_SAME and NFSERR_BADCOOKIE from readdir calls
Date:   Tue, 10 Nov 2020 16:37:37 -0500
Message-Id: <20201110213741.860745-19-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110213741.860745-18-trondmy@kernel.org>
References: <20201110213741.860745-1-trondmy@kernel.org>
 <20201110213741.860745-2-trondmy@kernel.org>
 <20201110213741.860745-3-trondmy@kernel.org>
 <20201110213741.860745-4-trondmy@kernel.org>
 <20201110213741.860745-5-trondmy@kernel.org>
 <20201110213741.860745-6-trondmy@kernel.org>
 <20201110213741.860745-7-trondmy@kernel.org>
 <20201110213741.860745-8-trondmy@kernel.org>
 <20201110213741.860745-9-trondmy@kernel.org>
 <20201110213741.860745-10-trondmy@kernel.org>
 <20201110213741.860745-11-trondmy@kernel.org>
 <20201110213741.860745-12-trondmy@kernel.org>
 <20201110213741.860745-13-trondmy@kernel.org>
 <20201110213741.860745-14-trondmy@kernel.org>
 <20201110213741.860745-15-trondmy@kernel.org>
 <20201110213741.860745-16-trondmy@kernel.org>
 <20201110213741.860745-17-trondmy@kernel.org>
 <20201110213741.860745-18-trondmy@kernel.org>
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
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Tested-by: Benjamin Coddington <bcodding@redhat.com>
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
index adcaba68eaed..7ab40d0e6a74 100644
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

