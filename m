Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0CF191DBC
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgCXXts (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbgCXXtr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:47 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C70462072E
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093787;
        bh=gtNIgmXlu2AIGfLM52JvOCgTcrhxeBVuK7HZPWsafRc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HbAFa1a/1coXfrp84cOAnRH5wH8H6JiF0E9dp8YWVUVUgjNI1rIht3HHGVvwJAD+7
         1N94piLOLwQH+f9P7VU11lZRh8tIAmO2QcMwfAvjySLmiih6MD8rrVd/X92pU2uhfu
         4cgJO2QP19AigwY5viRg/HpGND6VS31L/N7kkAk4=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 20/22] pNFS/flexfiles: Check the layout segment range before doing I/O
Date:   Tue, 24 Mar 2020 19:47:26 -0400
Message-Id: <20200324234728.8997-21-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-20-trondmy@kernel.org>
References: <20200324234728.8997-1-trondmy@kernel.org>
 <20200324234728.8997-2-trondmy@kernel.org>
 <20200324234728.8997-3-trondmy@kernel.org>
 <20200324234728.8997-4-trondmy@kernel.org>
 <20200324234728.8997-5-trondmy@kernel.org>
 <20200324234728.8997-6-trondmy@kernel.org>
 <20200324234728.8997-7-trondmy@kernel.org>
 <20200324234728.8997-8-trondmy@kernel.org>
 <20200324234728.8997-9-trondmy@kernel.org>
 <20200324234728.8997-10-trondmy@kernel.org>
 <20200324234728.8997-11-trondmy@kernel.org>
 <20200324234728.8997-12-trondmy@kernel.org>
 <20200324234728.8997-13-trondmy@kernel.org>
 <20200324234728.8997-14-trondmy@kernel.org>
 <20200324234728.8997-15-trondmy@kernel.org>
 <20200324234728.8997-16-trondmy@kernel.org>
 <20200324234728.8997-17-trondmy@kernel.org>
 <20200324234728.8997-18-trondmy@kernel.org>
 <20200324234728.8997-19-trondmy@kernel.org>
 <20200324234728.8997-20-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When starting to read or write with a layout segment, check that the
range matches our request.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 12 ++++++++++--
 fs/nfs/pnfs.c                          |  3 ++-
 fs/nfs/pnfs.h                          |  1 +
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 3cc2d3165a11..a816e304e876 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -830,6 +830,14 @@ ff_layout_pg_get_read(struct nfs_pageio_descriptor *pgio,
 	}
 }
 
+static void
+ff_layout_pg_check_layout(struct nfs_pageio_descriptor *pgio,
+			  struct nfs_page *req)
+{
+	pnfs_generic_pg_check_layout(pgio);
+	pnfs_generic_pg_check_range(pgio, req);
+}
+
 static void
 ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 			struct nfs_page *req)
@@ -840,7 +848,7 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	int ds_idx;
 
 retry:
-	pnfs_generic_pg_check_layout(pgio);
+	ff_layout_pg_check_layout(pgio, req);
 	/* Use full layout for now */
 	if (!pgio->pg_lseg) {
 		ff_layout_pg_get_read(pgio, req, false);
@@ -900,7 +908,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 	int i;
 
 retry:
-	pnfs_generic_pg_check_layout(pgio);
+	ff_layout_pg_check_layout(pgio, req);
 	if (!pgio->pg_lseg) {
 		pgio->pg_lseg = pnfs_update_layout(pgio->pg_inode,
 						   nfs_req_openctx(req),
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index eba18f137fb0..6fcf26b16816 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2611,7 +2611,7 @@ EXPORT_SYMBOL_GPL(pnfs_generic_pg_check_layout);
  * Check for any intersection between the request and the pgio->pg_lseg,
  * and if none, put this pgio->pg_lseg away.
  */
-static void
+void
 pnfs_generic_pg_check_range(struct nfs_pageio_descriptor *pgio, struct nfs_page *req)
 {
 	if (pgio->pg_lseg && !pnfs_lseg_request_intersecting(pgio->pg_lseg, req)) {
@@ -2619,6 +2619,7 @@ pnfs_generic_pg_check_range(struct nfs_pageio_descriptor *pgio, struct nfs_page
 		pgio->pg_lseg = NULL;
 	}
 }
+EXPORT_SYMBOL_GPL(pnfs_generic_pg_check_range);
 
 void
 pnfs_generic_pg_init_read(struct nfs_pageio_descriptor *pgio, struct nfs_page *req)
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 52a5d8aaaf46..ff2a0c53e05f 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -252,6 +252,7 @@ void pnfs_put_lseg(struct pnfs_layout_segment *lseg);
 void set_pnfs_layoutdriver(struct nfs_server *, const struct nfs_fh *, struct nfs_fsinfo *);
 void unset_pnfs_layoutdriver(struct nfs_server *);
 void pnfs_generic_pg_check_layout(struct nfs_pageio_descriptor *pgio);
+void pnfs_generic_pg_check_range(struct nfs_pageio_descriptor *pgio, struct nfs_page *req);
 void pnfs_generic_pg_init_read(struct nfs_pageio_descriptor *, struct nfs_page *);
 int pnfs_generic_pg_readpages(struct nfs_pageio_descriptor *desc);
 void pnfs_generic_pg_init_write(struct nfs_pageio_descriptor *pgio,
-- 
2.25.1

