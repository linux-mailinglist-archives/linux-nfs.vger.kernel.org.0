Return-Path: <linux-nfs+bounces-14398-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6BCB5583A
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 23:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DEAE1C25867
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Sep 2025 21:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54D2337684;
	Fri, 12 Sep 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+jqBgl9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B813375CD
	for <linux-nfs@vger.kernel.org>; Fri, 12 Sep 2025 21:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711655; cv=none; b=kFUMmUjm4O+g22Db80ml3u2M3ti68bFOUY8G2IDQNB5wAVx3xvzy903oCHtgltVs2HuUnyZ0IMciFi9Gc88vUV6ktiSbBDvCh+6hzsujO2yBdzSmaevRjn1NEEBljQwhY42H/pYa8awwRanJgHQ89owNPGH8Qn7ozxITAXeccX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711655; c=relaxed/simple;
	bh=p3ma4t45vqwgDqAhaA0PIRNc5dehIiFKWIplBk3Lltg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRhPOAYuxMpdFP8nVDnwbtPIFFbfZptqY0T2Ao/Idztt73Nurj9U+HfaoihZ/ZKO7WImxBHt6IzUo/uWRvu4tBEBsI+Utr8R1OWLxRdHPhJJ5/FoU5T1463G3Bxm5e0xBj4eBHbxhb59+KcF/q6yQSS2AOTRrnOzN8ZXq50PnKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+jqBgl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02A3C4CEF1;
	Fri, 12 Sep 2025 21:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757711655;
	bh=p3ma4t45vqwgDqAhaA0PIRNc5dehIiFKWIplBk3Lltg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T+jqBgl9gKWKaOyUaKeBWrhSt4gOHslrYdGLxS8b3t8S4vssmuzJA0aMYyk3k/7Nb
	 XaWrr8SK9BqXo+LoThcfNWFqe2v5jvuLLrVuMr0tU4+tvEoV6diCJsbWk/4fcjl8Vh
	 /lcrRfuUKErfLh7p0HVKXFAYo86I1syOdajs1GHgTbBVzXH1Nv1HpanYse60/xtFuM
	 XdXY3kk22s2jN0iiMjV33TxtftM7SHO/Hfziof13gf51HrTbWh1o4BrkMgh04OGriL
	 TkATi85IZtOHKbcPFgOf6yCDKCR9T/YiW3iHcr17coGB+GYC+rpTpbEHL341J3WXtk
	 f82Iohdc+DM5g==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH v1 6/9] NFS: Update the filelayout to use xdr_set_scratch_folio()
Date: Fri, 12 Sep 2025 17:14:07 -0400
Message-ID: <20250912211410.837006-8-anna@kernel.org>
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
 fs/nfs/filelayout/filelayout.c    | 10 +++++-----
 fs/nfs/filelayout/filelayoutdev.c | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index d39a1f58e18d..5c4551117c58 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -646,19 +646,19 @@ filelayout_decode_layout(struct pnfs_layout_hdr *flo,
 {
 	struct xdr_stream stream;
 	struct xdr_buf buf;
-	struct page *scratch;
+	struct folio *scratch;
 	__be32 *p;
 	uint32_t nfl_util;
 	int i;
 
 	dprintk("%s: set_layout_map Begin\n", __func__);
 
-	scratch = alloc_page(gfp_flags);
+	scratch = folio_alloc(gfp_flags, 0);
 	if (!scratch)
 		return -ENOMEM;
 
 	xdr_init_decode_pages(&stream, &buf, lgr->layoutp->pages, lgr->layoutp->len);
-	xdr_set_scratch_page(&stream, scratch);
+	xdr_set_scratch_folio(&stream, scratch);
 
 	/* 20 = ufl_util (4), first_stripe_index (4), pattern_offset (8),
 	 * num_fh (4) */
@@ -724,11 +724,11 @@ filelayout_decode_layout(struct pnfs_layout_hdr *flo,
 			fl->fh_array[i]->size);
 	}
 
-	__free_page(scratch);
+	folio_put(scratch);
 	return 0;
 
 out_err:
-	__free_page(scratch);
+	folio_put(scratch);
 	return -EIO;
 }
 
diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index 29d9234d5c08..df79aeb68db4 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -73,18 +73,18 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	struct nfs4_file_layout_dsaddr *dsaddr = NULL;
 	struct xdr_stream stream;
 	struct xdr_buf buf;
-	struct page *scratch;
+	struct folio *scratch;
 	struct list_head dsaddrs;
 	struct nfs4_pnfs_ds_addr *da;
 	struct net *net = server->nfs_client->cl_net;
 
 	/* set up xdr stream */
-	scratch = alloc_page(gfp_flags);
+	scratch = folio_alloc(gfp_flags, 0);
 	if (!scratch)
 		goto out_err;
 
 	xdr_init_decode_pages(&stream, &buf, pdev->pages, pdev->pglen);
-	xdr_set_scratch_page(&stream, scratch);
+	xdr_set_scratch_folio(&stream, scratch);
 
 	/* Get the stripe count (number of stripe index) */
 	p = xdr_inline_decode(&stream, 4);
@@ -186,7 +186,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 		}
 	}
 
-	__free_page(scratch);
+	folio_put(scratch);
 	return dsaddr;
 
 out_err_drain_dsaddrs:
@@ -204,7 +204,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 out_err_free_stripe_indices:
 	kfree(stripe_indices);
 out_err_free_scratch:
-	__free_page(scratch);
+	folio_put(scratch);
 out_err:
 	dprintk("%s ERROR: returning NULL\n", __func__);
 	return NULL;
-- 
2.51.0


