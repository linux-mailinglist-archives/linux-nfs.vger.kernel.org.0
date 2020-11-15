Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAEE2B39EF
	for <lists+linux-nfs@lfdr.de>; Sun, 15 Nov 2020 23:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgKOWho (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Nov 2020 17:37:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727302AbgKOWho (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 15 Nov 2020 17:37:44 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A01E522314
        for <linux-nfs@vger.kernel.org>; Sun, 15 Nov 2020 22:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605479858;
        bh=et4KJHX3H+UCEDfuJpFTHFlKdurY2qf7SKRfFpPvojQ=;
        h=From:To:Subject:Date:From;
        b=pi/S1Vr1qoSaw/nhyGbvwQzXEVLYUhotDqaZrY/RJHF7nfFbJ/TuzSMkYy01O+U+7
         PyV70EOlfEgZrglFxViyfNvzI+jpmk+YzfaRkSmk+6yc0OrpTKf1ISDFuuwd0/Vx1c
         1busaQwn2/0n/BcJsChYG5tlEoVNn54wLH9y7gEU=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] pNFS/flexfiles: Fix array overflow when flexfiles mirroring is enabled
Date:   Sun, 15 Nov 2020 17:37:37 -0500
Message-Id: <20201115223737.56968-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the flexfiles mirroring is enabled, then the read code expects to be
able to set pgio->pg_mirror_idx to point to the data server that is
being used for this particular read. However it does not change the
pg_mirror_count because we only need to send a single read.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 27 ++++++++++++++-----
 fs/nfs/pagelist.c                      | 36 +++++++++++++++++++-------
 include/linux/nfs_page.h               |  4 +++
 3 files changed, 52 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 59ae36bf5cc0..b7c26836b2cb 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -838,7 +838,7 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	struct nfs_pgio_mirror *pgm;
 	struct nfs4_ff_layout_mirror *mirror;
 	struct nfs4_pnfs_ds *ds;
-	u32 ds_idx, i;
+	u32 ds_idx;
 
 retry:
 	ff_layout_pg_check_layout(pgio, req);
@@ -864,11 +864,9 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 		goto retry;
 	}
 
-	for (i = 0; i < pgio->pg_mirror_count; i++) {
-		mirror = FF_LAYOUT_COMP(pgio->pg_lseg, i);
-		pgm = &pgio->pg_mirrors[i];
-		pgm->pg_bsize = mirror->mirror_ds->ds_versions[0].rsize;
-	}
+	mirror = FF_LAYOUT_COMP(pgio->pg_lseg, ds_idx);
+	pgm = &pgio->pg_mirrors[0];
+	pgm->pg_bsize = mirror->mirror_ds->ds_versions[0].rsize;
 
 	pgio->pg_mirror_idx = ds_idx;
 
@@ -985,6 +983,21 @@ ff_layout_pg_get_mirror_count_write(struct nfs_pageio_descriptor *pgio,
 	return 1;
 }
 
+static u32
+ff_layout_pg_set_mirror_write(struct nfs_pageio_descriptor *desc, u32 idx)
+{
+	u32 old = desc->pg_mirror_idx;
+
+	desc->pg_mirror_idx = idx;
+	return old;
+}
+
+static struct nfs_pgio_mirror *
+ff_layout_pg_get_mirror_write(struct nfs_pageio_descriptor *desc, u32 idx)
+{
+	return &desc->pg_mirrors[idx];
+}
+
 static const struct nfs_pageio_ops ff_layout_pg_read_ops = {
 	.pg_init = ff_layout_pg_init_read,
 	.pg_test = pnfs_generic_pg_test,
@@ -998,6 +1011,8 @@ static const struct nfs_pageio_ops ff_layout_pg_write_ops = {
 	.pg_doio = pnfs_generic_pg_writepages,
 	.pg_get_mirror_count = ff_layout_pg_get_mirror_count_write,
 	.pg_cleanup = pnfs_generic_pg_cleanup,
+	.pg_get_mirror = ff_layout_pg_get_mirror_write,
+	.pg_set_mirror = ff_layout_pg_set_mirror_write,
 };
 
 static void ff_layout_reset_write(struct nfs_pgio_header *hdr, bool retry_pnfs)
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 6985cacf4700..78c9c4bdef2b 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -31,13 +31,29 @@
 static struct kmem_cache *nfs_page_cachep;
 static const struct rpc_call_ops nfs_pgio_common_ops;
 
+static struct nfs_pgio_mirror *
+nfs_pgio_get_mirror(struct nfs_pageio_descriptor *desc, u32 idx)
+{
+	if (desc->pg_ops->pg_get_mirror)
+		return desc->pg_ops->pg_get_mirror(desc, idx);
+	return &desc->pg_mirrors[0];
+}
+
 struct nfs_pgio_mirror *
 nfs_pgio_current_mirror(struct nfs_pageio_descriptor *desc)
 {
-	return &desc->pg_mirrors[desc->pg_mirror_idx];
+	return nfs_pgio_get_mirror(desc, desc->pg_mirror_idx);
 }
 EXPORT_SYMBOL_GPL(nfs_pgio_current_mirror);
 
+static u32
+nfs_pgio_set_current_mirror(struct nfs_pageio_descriptor *desc, u32 idx)
+{
+	if (desc->pg_ops->pg_set_mirror)
+		return desc->pg_ops->pg_set_mirror(desc, idx);
+	return desc->pg_mirror_idx;
+}
+
 void nfs_pgheader_init(struct nfs_pageio_descriptor *desc,
 		       struct nfs_pgio_header *hdr,
 		       void (*release)(struct nfs_pgio_header *hdr))
@@ -1259,7 +1275,7 @@ static void nfs_pageio_error_cleanup(struct nfs_pageio_descriptor *desc)
 		return;
 
 	for (midx = 0; midx < desc->pg_mirror_count; midx++) {
-		mirror = &desc->pg_mirrors[midx];
+		mirror = nfs_pgio_get_mirror(desc, midx);
 		desc->pg_completion_ops->error_cleanup(&mirror->pg_list,
 				desc->pg_error);
 	}
@@ -1293,12 +1309,12 @@ int nfs_pageio_add_request(struct nfs_pageio_descriptor *desc,
 			goto out_failed;
 		}
 
-		desc->pg_mirror_idx = midx;
+		nfs_pgio_set_current_mirror(desc, midx);
 		if (!nfs_pageio_add_request_mirror(desc, dupreq))
 			goto out_cleanup_subreq;
 	}
 
-	desc->pg_mirror_idx = 0;
+	nfs_pgio_set_current_mirror(desc, 0);
 	if (!nfs_pageio_add_request_mirror(desc, req))
 		goto out_failed;
 
@@ -1320,10 +1336,12 @@ int nfs_pageio_add_request(struct nfs_pageio_descriptor *desc,
 static void nfs_pageio_complete_mirror(struct nfs_pageio_descriptor *desc,
 				       u32 mirror_idx)
 {
-	struct nfs_pgio_mirror *mirror = &desc->pg_mirrors[mirror_idx];
-	u32 restore_idx = desc->pg_mirror_idx;
+	struct nfs_pgio_mirror *mirror;
+	u32 restore_idx;
+
+	restore_idx = nfs_pgio_set_current_mirror(desc, mirror_idx);
+	mirror = nfs_pgio_current_mirror(desc);
 
-	desc->pg_mirror_idx = mirror_idx;
 	for (;;) {
 		nfs_pageio_doio(desc);
 		if (desc->pg_error < 0 || !mirror->pg_recoalesce)
@@ -1331,7 +1349,7 @@ static void nfs_pageio_complete_mirror(struct nfs_pageio_descriptor *desc,
 		if (!nfs_do_recoalesce(desc))
 			break;
 	}
-	desc->pg_mirror_idx = restore_idx;
+	nfs_pgio_set_current_mirror(desc, restore_idx);
 }
 
 /*
@@ -1405,7 +1423,7 @@ void nfs_pageio_cond_complete(struct nfs_pageio_descriptor *desc, pgoff_t index)
 	u32 midx;
 
 	for (midx = 0; midx < desc->pg_mirror_count; midx++) {
-		mirror = &desc->pg_mirrors[midx];
+		mirror = nfs_pgio_get_mirror(desc, midx);
 		if (!list_empty(&mirror->pg_list)) {
 			prev = nfs_list_entry(mirror->pg_list.prev);
 			if (index != prev->wb_index + 1) {
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index c32c15216da3..f0373a6cb5fb 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -55,6 +55,7 @@ struct nfs_page {
 	unsigned short		wb_nio;		/* Number of I/O attempts */
 };
 
+struct nfs_pgio_mirror;
 struct nfs_pageio_descriptor;
 struct nfs_pageio_ops {
 	void	(*pg_init)(struct nfs_pageio_descriptor *, struct nfs_page *);
@@ -64,6 +65,9 @@ struct nfs_pageio_ops {
 	unsigned int	(*pg_get_mirror_count)(struct nfs_pageio_descriptor *,
 				       struct nfs_page *);
 	void	(*pg_cleanup)(struct nfs_pageio_descriptor *);
+	struct nfs_pgio_mirror *
+		(*pg_get_mirror)(struct nfs_pageio_descriptor *, u32);
+	u32	(*pg_set_mirror)(struct nfs_pageio_descriptor *, u32);
 };
 
 struct nfs_rw_ops {
-- 
2.28.0

