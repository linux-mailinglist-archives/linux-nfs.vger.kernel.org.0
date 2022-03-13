Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2864D7716
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiCMRNN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbiCMRNM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187C6139CDC
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8E4C60FDD
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61ABC340EE
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191524;
        bh=Dr9xlbTR3BiwO3ozfsjH4snNedaCB0dVmtVOhk+82ME=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LFIr5RjVqFkHL5p6q19k6NGIQxg4CiXzkBre1hCWt2kDRWD4T38VFZf68TOpjLY6x
         gQLnzzm6MdZqWrH1yLuhE1L1pIxdlvuWh074C1lVc5iEAPP+4sXEdRAGxly+M0IF6P
         kHDJ7O1aRWC6usa4QWl5JGOg4dZ2ENF2wEREmuWe20BAC4tEjyfvC5p3FLJisBoPZe
         eLAaWTcUKPumuYyXmJeAXrJZS+0AGbM5wup7HIcyxnhYPgm5S5c1Ok2HXg1hK27U3Z
         gAuzTjrESM6wEHhB4b+U1FUM1cgKr5wZUYr3RBQB7rJuhQeueLVAsBumlBjYigsrfW
         /sv2CxJo6Zwzg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 01/26] NFS: Return valid errors from nfs2/3_decode_dirent()
Date:   Sun, 13 Mar 2022 13:05:32 -0400
Message-Id: <20220313170557.5940-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-1-trondmy@kernel.org>
References: <20220313170557.5940-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Valid return values for decode_dirent() callback functions are:
 0: Success
 -EBADCOOKIE: End of directory
 -EAGAIN: End of xdr_stream

All errors need to map into one of those three values.

Fixes: 573c4e1ef53a ("NFS: Simplify ->decode_dirent() calling sequence")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs2xdr.c |  2 +-
 fs/nfs/nfs3xdr.c | 21 ++++++---------------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 7fba7711e6b3..3d5ba43f44bb 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -949,7 +949,7 @@ int nfs2_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 	error = decode_filename_inline(xdr, &entry->name, &entry->len);
 	if (unlikely(error))
-		return error;
+		return -EAGAIN;
 
 	/*
 	 * The type (size and byte order) of nfscookie isn't defined in
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 54a1d21cbcc6..7ab60ad98776 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -1967,7 +1967,6 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 		       bool plus)
 {
 	struct user_namespace *userns = rpc_userns(entry->server->client);
-	struct nfs_entry old = *entry;
 	__be32 *p;
 	int error;
 	u64 new_cookie;
@@ -1987,15 +1986,15 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 
 	error = decode_fileid3(xdr, &entry->ino);
 	if (unlikely(error))
-		return error;
+		return -EAGAIN;
 
 	error = decode_inline_filename3(xdr, &entry->name, &entry->len);
 	if (unlikely(error))
-		return error;
+		return -EAGAIN;
 
 	error = decode_cookie3(xdr, &new_cookie);
 	if (unlikely(error))
-		return error;
+		return -EAGAIN;
 
 	entry->d_type = DT_UNKNOWN;
 
@@ -2003,7 +2002,7 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 		entry->fattr->valid = 0;
 		error = decode_post_op_attr(xdr, entry->fattr, userns);
 		if (unlikely(error))
-			return error;
+			return -EAGAIN;
 		if (entry->fattr->valid & NFS_ATTR_FATTR_V3)
 			entry->d_type = nfs_umode_to_dtype(entry->fattr->mode);
 
@@ -2018,11 +2017,8 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 			return -EAGAIN;
 		if (*p != xdr_zero) {
 			error = decode_nfs_fh3(xdr, entry->fh);
-			if (unlikely(error)) {
-				if (error == -E2BIG)
-					goto out_truncated;
-				return error;
-			}
+			if (unlikely(error))
+				return -EAGAIN;
 		} else
 			zero_nfs_fh3(entry->fh);
 	}
@@ -2031,11 +2027,6 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	entry->cookie = new_cookie;
 
 	return 0;
-
-out_truncated:
-	dprintk("NFS: directory entry contains invalid file handle\n");
-	*entry = old;
-	return -EAGAIN;
 }
 
 /*
-- 
2.35.1

