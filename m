Return-Path: <linux-nfs+bounces-14399-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D13B5583B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 23:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E7D1C258AE
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 21:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326903375CD;
	Fri, 12 Sep 2025 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhrWIxzw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC39337688
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711656; cv=none; b=YpjWepoEQCTGU111BpznC0QwFNwdgohZTBXV1leVkv04Bo/0hGkXyZXv5t1bkSSRYb+Pw2XFx80LtOVyNEWtyEDkMlAPsRDg/7l22RMleYuKr50mchqpI7slRMT7I6NfV/RXcmslMJkqF1WHZRMIoVdq+M6MJJZyHhR4LqF134o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711656; c=relaxed/simple;
	bh=B6032mzFfOnrM0wq6xePd9smBwEhDvJ6aKjMaMwJtZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tQVX2DDRWy6S1A/R5CxydEaOUms5hdGv8Ibgc+MCAIZwlISEMyuRc3LFxJSILHKGyKmiP7O4hdEFSDfMIoCYsrjw1i6aTBJiftHgJoOmJyzzj5hY15mzL6PV3kWfCG6ihXf6T2NdrX27Gm5EYTZTmsOYgSdjlrPOCaDOoptAw9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhrWIxzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEEFC4CEF5;
	Fri, 12 Sep 2025 21:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757711655;
	bh=B6032mzFfOnrM0wq6xePd9smBwEhDvJ6aKjMaMwJtZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HhrWIxzwH+29FApcNWSQyaLAiBgYXsuzUKI1i4JriJLMhyT61qWb4TI9wJsm6yQiL
	 ZOuQYKkP5a2tv/elIN1FRlcZpGW2aP3FepWzE8m+b6yv2WK+1Mor+kx66B3+FMBJZb
	 PEwaJ6J3zy29Y1Ujb9F3suNdgUNUesdWYT+GIye/3JvU9HXsbrfSndhHadD/zbA+4Z
	 qIc8li9sbz4Th8ss9Hwx2hBObOse9J2rGlDKcMYaZkSTFXZOzIEWf+YwfbflIDEwju
	 edoiHLE7p0z+QcMY3/SwisJ9JCjWyhxJ36AQYqykx79zeJTJDarSUJXl9G4fZiMhoY
	 fm4GhSB0FycUQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 7/9] NFS: Update the flexfilelayout driver to use xdr_set_scratch_folio()
Date: Fri, 12 Sep 2025 17:14:08 -0400
Message-ID: <20250912211410.837006-9-anna@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250912211410.837006-1-anna@kernel.org>
References: <20250912211410.837006-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c    |  8 ++++----
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 04a6dded8a13..d29d2a2dfc2a 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -439,7 +439,7 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 	struct nfs4_ff_layout_segment *fls = NULL;
 	struct xdr_stream stream;
 	struct xdr_buf buf;
-	struct page *scratch;
+	struct folio *scratch;
 	u64 stripe_unit;
 	u32 mirror_array_cnt;
 	__be32 *p;
@@ -447,13 +447,13 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 	struct nfs4_ff_layout_ds_stripe *dss_info;
 
 	dprintk("--> %s\n", __func__);
-	scratch = alloc_page(gfp_flags);
+	scratch = folio_alloc(gfp_flags, 0);
 	if (!scratch)
 		return ERR_PTR(-ENOMEM);
 
 	xdr_init_decode_pages(&stream, &buf, lgr->layoutp->pages,
 			      lgr->layoutp->len);
-	xdr_set_scratch_page(&stream, scratch);
+	xdr_set_scratch_folio(&stream, scratch);
 
 	/* stripe unit and mirror_array_cnt */
 	rc = -EIO;
@@ -639,7 +639,7 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 	ret = &fls->generic_hdr;
 	dprintk("<-- %s (success)\n", __func__);
 out_free_page:
-	__free_page(scratch);
+	folio_put(scratch);
 	return ret;
 out_err_free:
 	_ff_layout_free_lseg(fls);
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index 9ab1555b45c8..d06a3f619fa7 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -44,7 +44,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 {
 	struct xdr_stream stream;
 	struct xdr_buf buf;
-	struct page *scratch;
+	struct folio *scratch;
 	struct list_head dsaddrs;
 	struct nfs4_pnfs_ds_addr *da;
 	struct nfs4_ff_layout_ds *new_ds = NULL;
@@ -56,7 +56,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	int i, ret = -ENOMEM;
 
 	/* set up xdr stream */
-	scratch = alloc_page(gfp_flags);
+	scratch = folio_alloc(gfp_flags, 0);
 	if (!scratch)
 		goto out_err;
 
@@ -70,7 +70,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	INIT_LIST_HEAD(&dsaddrs);
 
 	xdr_init_decode_pages(&stream, &buf, pdev->pages, pdev->pglen);
-	xdr_set_scratch_page(&stream, scratch);
+	xdr_set_scratch_folio(&stream, scratch);
 
 	/* multipath count */
 	p = xdr_inline_decode(&stream, 4);
@@ -163,7 +163,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 		kfree(da);
 	}
 
-	__free_page(scratch);
+	folio_put(scratch);
 	return new_ds;
 
 out_err_drain_dsaddrs:
@@ -177,7 +177,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 
 	kfree(ds_versions);
 out_scratch:
-	__free_page(scratch);
+	folio_put(scratch);
 out_err:
 	kfree(new_ds);
 
-- 
2.51.0


