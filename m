Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470BB4E3644
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 02:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbiCVB4I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 21:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbiCVB4E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 21:56:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5101EC7C
        for <linux-nfs@vger.kernel.org>; Mon, 21 Mar 2022 18:54:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9816660B0E
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 01:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18996C340F2;
        Tue, 22 Mar 2022 01:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647914076;
        bh=cMhxDfxaL3CMXtievitinje637wKuEu08nEHHZec6MA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjR6MRRZ3PAxs71bbCE7PKTUCkiMaM9ZVgI7guqemUyQR30934jP1JTLh6u9wtxri
         q7qc9Hh/TDyOXs1EdZfXTM8gAr+Oo2q0ui8lIUdcVVc8oLyLNyRbUuQVbXmg61x49G
         m+Htc4xZo6mFnkIA+bu5wqB3CulFhQnDVyJaqVdXhkgprfU6tr856DFZyoi9Qimyq4
         1WRHbW+hGi0axv6gy5GsJDR7IMtLj08xLLu8Oy9VStPg4EVGDatMyw/RVQf28FOm3P
         S274u4S9Q5V5PW/t7MPUjDZc3JGPIX1Jny4HhdSR5+GUajBoWfUXOvYfznk3XPN05O
         tJCHuVZJr9CKw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH v2 6/9] NFS: Avoid writeback threads getting stuck in mempool_alloc()
Date:   Mon, 21 Mar 2022 21:47:43 -0400
Message-Id: <20220322014746.1052984-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322014746.1052984-6-trondmy@kernel.org>
References: <20220322014746.1052984-1-trondmy@kernel.org>
 <20220322014746.1052984-2-trondmy@kernel.org>
 <20220322014746.1052984-3-trondmy@kernel.org>
 <20220322014746.1052984-4-trondmy@kernel.org>
 <20220322014746.1052984-5-trondmy@kernel.org>
 <20220322014746.1052984-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

In a low memory situation, allow the NFS writeback code to fail without
getting stuck in infinite loops in mempool_alloc().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 10 +++++-----
 fs/nfs/write.c    | 10 ++++++++--
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index ad7f83dc9a2d..3156db526cc4 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -90,10 +90,10 @@ void nfs_set_pgio_error(struct nfs_pgio_header *hdr, int error, loff_t pos)
 	}
 }
 
-static inline struct nfs_page *
-nfs_page_alloc(void)
+static inline struct nfs_page *nfs_page_alloc(void)
 {
-	struct nfs_page	*p = kmem_cache_zalloc(nfs_page_cachep, GFP_KERNEL);
+	struct nfs_page *p =
+		kmem_cache_zalloc(nfs_page_cachep, nfs_io_gfp_mask());
 	if (p)
 		INIT_LIST_HEAD(&p->wb_list);
 	return p;
@@ -892,7 +892,7 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *desc,
 	struct nfs_commit_info cinfo;
 	struct nfs_page_array *pg_array = &hdr->page_array;
 	unsigned int pagecount, pageused;
-	gfp_t gfp_flags = GFP_KERNEL;
+	gfp_t gfp_flags = nfs_io_gfp_mask();
 
 	pagecount = nfs_page_array_len(mirror->pg_base, mirror->pg_count);
 	pg_array->npages = pagecount;
@@ -979,7 +979,7 @@ nfs_pageio_alloc_mirrors(struct nfs_pageio_descriptor *desc,
 	desc->pg_mirrors_dynamic = NULL;
 	if (mirror_count == 1)
 		return desc->pg_mirrors_static;
-	ret = kmalloc_array(mirror_count, sizeof(*ret), GFP_KERNEL);
+	ret = kmalloc_array(mirror_count, sizeof(*ret), nfs_io_gfp_mask());
 	if (ret != NULL) {
 		for (i = 0; i < mirror_count; i++)
 			nfs_pageio_mirror_init(&ret[i], desc->pg_bsize);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index ef47e3700e4b..e864ac836237 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -94,9 +94,15 @@ EXPORT_SYMBOL_GPL(nfs_commit_free);
 
 static struct nfs_pgio_header *nfs_writehdr_alloc(void)
 {
-	struct nfs_pgio_header *p = mempool_alloc(nfs_wdata_mempool, GFP_KERNEL);
+	struct nfs_pgio_header *p;
 
-	memset(p, 0, sizeof(*p));
+	p = kmem_cache_zalloc(nfs_wdata_cachep, nfs_io_gfp_mask());
+	if (!p) {
+		p = mempool_alloc(nfs_wdata_mempool, GFP_NOWAIT);
+		if (!p)
+			return NULL;
+		memset(p, 0, sizeof(*p));
+	}
 	p->rw_mode = FMODE_WRITE;
 	return p;
 }
-- 
2.35.1

