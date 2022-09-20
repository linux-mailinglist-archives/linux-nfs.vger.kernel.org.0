Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35915BEB83
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Sep 2022 19:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiITRAb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Sep 2022 13:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiITRAa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Sep 2022 13:00:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D474DB05
        for <linux-nfs@vger.kernel.org>; Tue, 20 Sep 2022 10:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663693226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=g+/yRMgtdtHYjI2N/8I2BEQngezJzE7+UcGrmpWM4wE=;
        b=cMMeQYq0yGzG1aM5nCgPte8J7iOXQ7TkiqZ+bRxS+Z9vzzjJyFJ0/UDBCkdWZaouhVKHDe
        E8OQML2GalwxRo8+8HpzUa0yiDoXBpMFG0tIoq/I3VLclf72cOXHeDBIhs3SW2ZZ1a/k34
        WbKzYT2S4CDynGlj1kpDz5zHQsnm8Fo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-bbEYNG7_PEmzz5TLKMDbEQ-1; Tue, 20 Sep 2022 13:00:22 -0400
X-MC-Unique: bbEYNG7_PEmzz5TLKMDbEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 287AB3C23561;
        Tue, 20 Sep 2022 17:00:22 +0000 (UTC)
Received: from bcodding.csb (unknown [10.22.48.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0592040C2064;
        Tue, 20 Sep 2022 17:00:22 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 5D38510C30E0; Tue, 20 Sep 2022 13:00:21 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Trigger the "ls -l" readdir heuristic sooner
Date:   Tue, 20 Sep 2022 13:00:21 -0400
Message-Id: <20220920170021.1391560-1-bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Since commit 1a34c8c9a49e ("NFS: Support larger readdir buffers") has
updated dtsize, and with recent improvements to the READDIRPLUS helper
heuristic, the heuristic may not trigger until many dentries are emitted
to userspace.   This will cause many thousands of GETATTR calls for "ls
-l" when the directory's pagecache has already been populated.  This
manifests as poor performance for long directory listings after an
initially fast "ls -l".

Fix this by emitting only 17 entries for any first pass through the NFS
directory's ->iterate_shared(), which allows userpace to prime the
counters for the heuristic.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5d6c2ddc7ea6..3b24b8af5514 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1074,6 +1074,8 @@ static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 	return res;
 }
 
+#define NFS_READDIR_CACHE_MISS_THRESHOLD (16UL)
+
 /*
  * Once we've found the start of the dirent within a page: fill 'er up...
  */
@@ -1083,6 +1085,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 	struct file	*file = desc->file;
 	struct nfs_cache_array *array;
 	unsigned int i;
+	bool first_emit = !desc->dir_cookie;
 
 	array = kmap_local_page(desc->page);
 	for (i = desc->cache_entry_index; i < array->size; i++) {
@@ -1106,6 +1109,10 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 			desc->ctx->pos = desc->dir_cookie;
 		else
 			desc->ctx->pos++;
+		if (first_emit && i > NFS_READDIR_CACHE_MISS_THRESHOLD + 1) {
+			desc->eob = true;
+			break;
+		}
 	}
 	if (array->page_is_eof)
 		desc->eof = !desc->eob;
@@ -1187,8 +1194,6 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	return status;
 }
 
-#define NFS_READDIR_CACHE_MISS_THRESHOLD (16UL)
-
 static bool nfs_readdir_handle_cache_misses(struct inode *inode,
 					    struct nfs_readdir_descriptor *desc,
 					    unsigned int cache_misses,
-- 
2.37.2

