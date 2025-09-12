Return-Path: <linux-nfs+bounces-14397-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AA5B55839
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 23:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECEB53BC95D
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 21:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CCE335BAF;
	Fri, 12 Sep 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkxR8lRf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211033375B3
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711655; cv=none; b=oTnaWfhyA5cUUAWyYTk5KUy0s5ddpcmftvxZc2+qMIrjrIhdeKDrrVlmoYYns7HbzjavVXzzJJahV7jrnMbojwe7qWdyUPoaTrC2s/TH+ugDsUxdWflhnYtaupsVJP+OtYB4tiknfy3R42p10sti0DD7+mea73mLnmY23luasFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711655; c=relaxed/simple;
	bh=yU6RCjz5b/oF82OHWvc+wHWJGDTRcsNMj86DrEsns5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0+AVPFESo9XmO1yNdrYK9rVw3mclQTO6fnp0hmwHrJQ6M/hHVVT1CKx5+jZCplOG3Ca501+aWMFgb6faKV2d60iroBKwg6laCGGYg1SqYDd6OUlm1Z0FZwm3vFyIINmqitS5MhWWQlFlJJ2H5P4anz3pgViBQxvoIcjty3T+5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkxR8lRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B600C4CEF5;
	Fri, 12 Sep 2025 21:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757711654;
	bh=yU6RCjz5b/oF82OHWvc+wHWJGDTRcsNMj86DrEsns5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BkxR8lRfIuDmLHlbOCIcTqIJ9OQ16FY3n0E9z7EVfMkLtRu3RHYQmPO3wrzuSogsk
	 DsMd1KcSWxyCgLDvODprPCZvBOTPgjLsOetRrnEpEccqeqjIZdFaQOMw7Dcgp0uZee
	 A9oq9+7JsEBdAQ0Q4eM1IzJRZoozTGQZ1GvmjqyZmKIi2rpxUSeeSAldPGoPBymfyh
	 AVPRVap1Qr1AiXtvZ0UKueQe8AcjNJoJ9W8qDIchpjFu/KJaAOSziYVCSkPh+dY/MZ
	 bXQWXf/TiQu4pbdRRbnqyb+G7IXr+3dvg+8N37G8Fe8GvVTf3BsocxFGRoXVSj7c1g
	 OHeY1wsXgxFlw==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 5/9] NFS: Update the blocklayout to use xdr_set_scratch_folio()
Date: Fri, 12 Sep 2025 17:14:06 -0400
Message-ID: <20250912211410.837006-7-anna@kernel.org>
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
 fs/nfs/blocklayout/blocklayout.c | 8 ++++----
 fs/nfs/blocklayout/dev.c         | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 5d6edafbed20..0e4c67373e4f 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -676,7 +676,7 @@ bl_alloc_lseg(struct pnfs_layout_hdr *lo, struct nfs4_layoutget_res *lgr,
 	struct pnfs_layout_segment *lseg;
 	struct xdr_buf buf;
 	struct xdr_stream xdr;
-	struct page *scratch;
+	struct folio *scratch;
 	int status, i;
 	uint32_t count;
 	__be32 *p;
@@ -689,13 +689,13 @@ bl_alloc_lseg(struct pnfs_layout_hdr *lo, struct nfs4_layoutget_res *lgr,
 		return ERR_PTR(-ENOMEM);
 
 	status = -ENOMEM;
-	scratch = alloc_page(gfp_mask);
+	scratch = folio_alloc(gfp_mask, 0);
 	if (!scratch)
 		goto out;
 
 	xdr_init_decode_pages(&xdr, &buf,
 			lgr->layoutp->pages, lgr->layoutp->len);
-	xdr_set_scratch_page(&xdr, scratch);
+	xdr_set_scratch_folio(&xdr, scratch);
 
 	status = -EIO;
 	p = xdr_inline_decode(&xdr, 4);
@@ -744,7 +744,7 @@ bl_alloc_lseg(struct pnfs_layout_hdr *lo, struct nfs4_layoutget_res *lgr,
 	}
 
 out_free_scratch:
-	__free_page(scratch);
+	folio_put(scratch);
 out:
 	dprintk("%s returns %d\n", __func__, status);
 	switch (status) {
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 44306ac22353..ab76120705e2 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -541,16 +541,16 @@ bl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	struct pnfs_block_dev *top;
 	struct xdr_stream xdr;
 	struct xdr_buf buf;
-	struct page *scratch;
+	struct folio *scratch;
 	int nr_volumes, ret, i;
 	__be32 *p;
 
-	scratch = alloc_page(gfp_mask);
+	scratch = folio_alloc(gfp_mask, 0);
 	if (!scratch)
 		goto out;
 
 	xdr_init_decode_pages(&xdr, &buf, pdev->pages, pdev->pglen);
-	xdr_set_scratch_page(&xdr, scratch);
+	xdr_set_scratch_folio(&xdr, scratch);
 
 	p = xdr_inline_decode(&xdr, sizeof(__be32));
 	if (!p)
@@ -582,7 +582,7 @@ bl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 out_free_volumes:
 	kfree(volumes);
 out_free_scratch:
-	__free_page(scratch);
+	folio_put(scratch);
 out:
 	return node;
 }
-- 
2.51.0


