Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098134C5FDF
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiB0XTX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiB0XTW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE2222522
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4759611D7
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBC7C340F2
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003924;
        bh=IwSqCNtU40FHYvmhv/NI0rbeBhAwSUUFKE40h9/XXvY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CsX0B8x/0MBWFXPboPk24KEsGJcTcklD6ZPW4uX1Okn19SBcE6L56BIb/1HAdidfE
         uJvMgpJIjSEZem5hOvBEnkNTSfDNMQBcK7BAgMPp8Pa1vHy78kVZAOGKtvk+k2EyKz
         TPWn54onLATltMa4CVbVLaDyPB23CinCXXKG3UUS/DO8nS6dU00qZwqnBcmnQvj6eC
         yIL7ETsNIMUhWuRWO2FqHgtS5B5Ak8y+RBnn472fWzblV+Kv5Y4OUNZ9b7g4t5rYCe
         8uQRUDKheAjX9jEo61bv5uwpby5hcLaUrDgmBScs+yeoJcYkXSpHrV5q7BvQDGcJqu
         DbKSv2JwdZymw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 27/27] NFS: Cache all entries in the readdirplus reply
Date:   Sun, 27 Feb 2022 18:12:27 -0500
Message-Id: <20220227231227.9038-28-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-27-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org>
 <20220227231227.9038-10-trondmy@kernel.org>
 <20220227231227.9038-11-trondmy@kernel.org>
 <20220227231227.9038-12-trondmy@kernel.org>
 <20220227231227.9038-13-trondmy@kernel.org>
 <20220227231227.9038-14-trondmy@kernel.org>
 <20220227231227.9038-15-trondmy@kernel.org>
 <20220227231227.9038-16-trondmy@kernel.org>
 <20220227231227.9038-17-trondmy@kernel.org>
 <20220227231227.9038-18-trondmy@kernel.org>
 <20220227231227.9038-19-trondmy@kernel.org>
 <20220227231227.9038-20-trondmy@kernel.org>
 <20220227231227.9038-21-trondmy@kernel.org>
 <20220227231227.9038-22-trondmy@kernel.org>
 <20220227231227.9038-23-trondmy@kernel.org>
 <20220227231227.9038-24-trondmy@kernel.org>
 <20220227231227.9038-25-trondmy@kernel.org>
 <20220227231227.9038-26-trondmy@kernel.org>
 <20220227231227.9038-27-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Even if we're not able to cache all the entries in the readdir buffer,
let's ensure that we do prime the dcache.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c2c847845464..4cd77bc5022d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -782,6 +782,21 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 	dput(dentry);
 }
 
+static int nfs_readdir_entry_decode(struct nfs_readdir_descriptor *desc,
+				    struct nfs_entry *entry,
+				    struct xdr_stream *stream)
+{
+	int ret;
+
+	if (entry->fattr->label)
+		entry->fattr->label->len = NFS4_MAXLABELLEN;
+	ret = xdr_decode(desc, entry, stream);
+	if (ret || !desc->plus)
+		return ret;
+	nfs_prime_dcache(file_dentry(desc->file), entry, desc->dir_verifier);
+	return 0;
+}
+
 /* Perform conversion from xdr to cache array */
 static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 				   struct nfs_entry *entry,
@@ -804,17 +819,10 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 	xdr_set_scratch_page(&stream, scratch);
 
 	do {
-		if (entry->fattr->label)
-			entry->fattr->label->len = NFS4_MAXLABELLEN;
-
-		status = xdr_decode(desc, entry, &stream);
+		status = nfs_readdir_entry_decode(desc, entry, &stream);
 		if (status != 0)
 			break;
 
-		if (desc->plus)
-			nfs_prime_dcache(file_dentry(desc->file), entry,
-					desc->dir_verifier);
-
 		status = nfs_readdir_page_array_append(page, entry, &cookie);
 		if (status != -ENOSPC)
 			continue;
@@ -842,15 +850,19 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 
 	switch (status) {
 	case -EBADCOOKIE:
-		if (entry->eof) {
-			nfs_readdir_page_set_eof(page);
-			status = 0;
-		}
-		break;
-	case -ENOSPC:
+		if (!entry->eof)
+			break;
+		nfs_readdir_page_set_eof(page);
+		fallthrough;
 	case -EAGAIN:
 		status = 0;
 		break;
+	case -ENOSPC:
+		status = 0;
+		if (!desc->plus)
+			break;
+		while (!nfs_readdir_entry_decode(desc, entry, &stream))
+			;
 	}
 
 	if (page != *arrays)
-- 
2.35.1

