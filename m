Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3274966109B
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 18:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjAGRmO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 12:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGRmM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 12:42:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746DA2DF
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 09:42:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 34EDEB80139
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DECC433EF
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673113328;
        bh=L51uHlHaVrN1b1t8SUxgrgIyjgeK9s+5dguU3zDag7U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PSz3vdZLLTP+Rhb9zf0uAhFvFP6wxiYzNgMFi1OkDiW2NWWQ30l+YEEnjJcUnt26U
         +p1m0i6U+3qin7oWO+EudzBNyaGtvwbclb+HFK3llXYEvjwSbOvJE91apsFtnZtxRf
         qWHc3qZtcN3RlE+ZrY5pauS2ufA1GwTibormhu7Tms9ivVgRbYLPr8lhlNMC0p3KgP
         PubNf6uPUWgoU5f/wbUzAvrmUQz1eSMR3a6+41d9Sh/iBVBBEI72gAIBxVw9WCzMIh
         IqvU5004U6TeKPiWv8wkSVh+YxHt8U1Nya9spqwYvOOI4fX/HJaJqFcjbbOWjJb8pz
         Gx6PKB6xiYQBA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 03/17] NFS: Support folios in nfs_generic_pgio()
Date:   Sat,  7 Jan 2023 12:36:21 -0500
Message-Id: <20230107173635.2025233-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107173635.2025233-3-trondmy@kernel.org>
References: <20230107173635.2025233-1-trondmy@kernel.org>
 <20230107173635.2025233-2-trondmy@kernel.org>
 <20230107173635.2025233-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add support for multi-page folios in the generic NFS i/o engine.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/internal.h |  7 +++--
 fs/nfs/pagelist.c | 68 +++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index ae7d4a8c728c..6197b165c8c8 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -807,11 +807,10 @@ unsigned char nfs_umode_to_dtype(umode_t mode)
  * Determine the number of pages in an array of length 'len' and
  * with a base offset of 'base'
  */
-static inline
-unsigned int nfs_page_array_len(unsigned int base, size_t len)
+static inline unsigned int nfs_page_array_len(unsigned int base, size_t len)
 {
-	return ((unsigned long)len + (unsigned long)base +
-		PAGE_SIZE - 1) >> PAGE_SHIFT;
+	return ((unsigned long)len + (unsigned long)base + PAGE_SIZE - 1) >>
+	       PAGE_SHIFT;
 }
 
 /*
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index f496774d9d97..33b8d636dd78 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -31,6 +31,42 @@
 static struct kmem_cache *nfs_page_cachep;
 static const struct rpc_call_ops nfs_pgio_common_ops;
 
+struct nfs_page_iter_page {
+	const struct nfs_page *req;
+	size_t count;
+};
+
+static void nfs_page_iter_page_init(struct nfs_page_iter_page *i,
+				    const struct nfs_page *req)
+{
+	i->req = req;
+	i->count = 0;
+}
+
+static void nfs_page_iter_page_advance(struct nfs_page_iter_page *i, size_t sz)
+{
+	const struct nfs_page *req = i->req;
+	size_t tmp = i->count + sz;
+
+	i->count = (tmp < req->wb_bytes) ? tmp : req->wb_bytes;
+}
+
+static struct page *nfs_page_iter_page_get(struct nfs_page_iter_page *i)
+{
+	const struct nfs_page *req = i->req;
+	struct page *page;
+
+	if (i->count != req->wb_bytes) {
+		size_t base = i->count + req->wb_pgbase;
+		size_t len = PAGE_SIZE - offset_in_page(base);
+
+		page = nfs_page_to_page(req, base);
+		nfs_page_iter_page_advance(i, len);
+		return page;
+	}
+	return NULL;
+}
+
 static struct nfs_pgio_mirror *
 nfs_pgio_get_mirror(struct nfs_pageio_descriptor *desc, u32 idx)
 {
@@ -693,13 +729,14 @@ EXPORT_SYMBOL_GPL(nfs_pgio_header_free);
 /**
  * nfs_pgio_rpcsetup - Set up arguments for a pageio call
  * @hdr: The pageio hdr
+ * @pgbase: base
  * @count: Number of bytes to read
  * @how: How to commit data (writes only)
  * @cinfo: Commit information for the call (writes only)
  */
-static void nfs_pgio_rpcsetup(struct nfs_pgio_header *hdr,
-			      unsigned int count,
-			      int how, struct nfs_commit_info *cinfo)
+static void nfs_pgio_rpcsetup(struct nfs_pgio_header *hdr, unsigned int pgbase,
+			      unsigned int count, int how,
+			      struct nfs_commit_info *cinfo)
 {
 	struct nfs_page *req = hdr->req;
 
@@ -710,7 +747,7 @@ static void nfs_pgio_rpcsetup(struct nfs_pgio_header *hdr,
 	hdr->args.offset = req_offset(req);
 	/* pnfs_set_layoutcommit needs this */
 	hdr->mds_offset = hdr->args.offset;
-	hdr->args.pgbase = req->wb_pgbase;
+	hdr->args.pgbase = pgbase;
 	hdr->args.pages  = hdr->page_array.pagevec;
 	hdr->args.count  = count;
 	hdr->args.context = get_nfs_open_context(nfs_req_openctx(req));
@@ -896,9 +933,10 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *desc,
 	struct nfs_commit_info cinfo;
 	struct nfs_page_array *pg_array = &hdr->page_array;
 	unsigned int pagecount, pageused;
+	unsigned int pg_base = offset_in_page(mirror->pg_base);
 	gfp_t gfp_flags = nfs_io_gfp_mask();
 
-	pagecount = nfs_page_array_len(mirror->pg_base, mirror->pg_count);
+	pagecount = nfs_page_array_len(pg_base, mirror->pg_count);
 	pg_array->npages = pagecount;
 
 	if (pagecount <= ARRAY_SIZE(pg_array->page_array))
@@ -918,19 +956,26 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *desc,
 	last_page = NULL;
 	pageused = 0;
 	while (!list_empty(head)) {
+		struct nfs_page_iter_page i;
+		struct page *page;
+
 		req = nfs_list_entry(head->next);
 		nfs_list_move_request(req, &hdr->pages);
 
 		if (req->wb_pgbase == 0)
 			last_page = NULL;
 
-		if (!last_page || last_page != req->wb_page) {
-			pageused++;
-			if (pageused > pagecount)
-				break;
-			*pages++ = last_page = req->wb_page;
+		nfs_page_iter_page_init(&i, req);
+		while ((page = nfs_page_iter_page_get(&i)) != NULL) {
+			if (last_page != page) {
+				pageused++;
+				if (pageused > pagecount)
+					goto full;
+				*pages++ = last_page = page;
+			}
 		}
 	}
+full:
 	if (WARN_ON_ONCE(pageused != pagecount)) {
 		nfs_pgio_error(hdr);
 		desc->pg_error = -EINVAL;
@@ -942,7 +987,8 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *desc,
 		desc->pg_ioflags &= ~FLUSH_COND_STABLE;
 
 	/* Set up the argument struct */
-	nfs_pgio_rpcsetup(hdr, mirror->pg_count, desc->pg_ioflags, &cinfo);
+	nfs_pgio_rpcsetup(hdr, pg_base, mirror->pg_count, desc->pg_ioflags,
+			  &cinfo);
 	desc->pg_rpc_callops = &nfs_pgio_common_ops;
 	return 0;
 }
-- 
2.39.0

