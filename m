Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096314D4B25
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Mar 2022 15:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbiCJOeo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Mar 2022 09:34:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244768AbiCJOd6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Mar 2022 09:33:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76116EFFAF
        for <linux-nfs@vger.kernel.org>; Thu, 10 Mar 2022 06:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646922677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wOjxkZfQd7wtZcWfBPHDJfP/G5YFYY+bE6NczbPea9k=;
        b=RqX6eZRzc0u4/VCcdfpDeyqWMkUcOphtQU3tyKcRe7C5dtYxrjV4idTnHWsEzIQ1po9s7T
        AfG4u1InnpxVx2e7CaaaMvakd4hppGY0q1P8O145wc84t6ZPt+5zbOXdiu0NEX9Zb30FYE
        FeNn0FMduKmKAlr7ou4lMIBSUnJxrCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-TqqfuTR0NECo05x0_7UVrg-1; Thu, 10 Mar 2022 09:31:14 -0500
X-MC-Unique: TqqfuTR0NECo05x0_7UVrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14B09100C609;
        Thu, 10 Mar 2022 14:31:13 +0000 (UTC)
Received: from bcodding.csb (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DABB667E7A;
        Thu, 10 Mar 2022 14:31:12 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id 77D3310C30E0; Thu, 10 Mar 2022 09:31:12 -0500 (EST)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     trondmy@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Trigger "ls -l" readdir heuristic sooner
Date:   Thu, 10 Mar 2022 09:31:12 -0500
Message-Id: <88cb6a4d7a074fd4c4c6b59076df766c7de54105.1646922313.git.bcodding@redhat.com>
In-Reply-To: <A7BBBBF2-768E-487C-A890-7E5AF1D40027@redhat.com>
References: <20220227231227.9038-1-trondmy@kernel.org> <20220227231227.9038-2-trondmy@kernel.org> <20220227231227.9038-3-trondmy@kernel.org> <20220227231227.9038-4-trondmy@kernel.org> <20220227231227.9038-5-trondmy@kernel.org> <20220227231227.9038-6-trondmy@kernel.org> <20220227231227.9038-7-trondmy@kernel.org> <20220227231227.9038-8-trondmy@kernel.org> <20220227231227.9038-9-trondmy@kernel.org> <20220227231227.9038-10-trondmy@kernel.org> <20220227231227.9038-11-trondmy@kernel.org> <20220227231227.9038-12-trondmy@kernel.org> <20220227231227.9038-13-trondmy@kernel.org> <20220227231227.9038-14-trondmy@kernel.org> <20220227231227.9038-15-trondmy@kernel.org> <A7BBBBF2-768E-487C-A890-7E5AF1D40027@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

.. Something like this does the trick in my testing, but yes will have an
impact on regular workloads:

8<------------------------------------------------------------------------

Since commit 1a34c8c9a49e ("NFS: Support larger readdir buffers") has
updated dtsize and recent improvements to the READDIRPLUS helper heuristic,
the heuristic may not trigger until many dentries are emitted to userspace,
which may cause many thousands of GETATTR calls for "ls -l" when the
directory's pagecache has already been populated.  This typically manifests
as a much slower total runtime for a _second_ invocation of "ls -l" within
the directory attribute cache timeouts.

Fix this by emitting only 17 entries for any first pass through the NFS
directory's ->iterate_shared(), which will allow userpace to prime the
counters for the heuristic.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 7e12102b29e7..dc5fc9ba2c49 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1060,6 +1060,8 @@ static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 	return res;
 }
 
+#define NFS_READDIR_CACHE_MISS_THRESHOLD (16UL)
+
 /*
  * Once we've found the start of the dirent within a page: fill 'er up...
  */
@@ -1069,6 +1071,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
 	struct file	*file = desc->file;
 	struct nfs_cache_array *array;
 	unsigned int i;
+	bool first_emit = !desc->dir_cookie;
 
 	array = kmap(desc->page);
 	for (i = desc->cache_entry_index; i < array->size; i++) {
@@ -1092,6 +1095,10 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
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
@@ -1173,8 +1180,6 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	return status;
 }
 
-#define NFS_READDIR_CACHE_MISS_THRESHOLD (16UL)
-
 static bool nfs_readdir_handle_cache_misses(struct inode *inode,
 					    struct nfs_readdir_descriptor *desc,
 					    unsigned int cache_misses,
-- 
2.31.1

