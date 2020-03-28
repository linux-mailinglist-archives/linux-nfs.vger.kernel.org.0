Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A790196708
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgC1Pen (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbgC1Pem (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:42 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0F5820848
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409682;
        bh=SfThXb5sbELLShXdiZVWMn/D+sIxP3vxICn3SobEKq0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=H04n6K2PSYaLjL/htFFW3k1PyFpz7GmZL8OZkVJAHn6sWyrrpYbfNMmTPMlDoeARw
         1Sl1ASISdWkBJYHYEY8lz8+VgO8D0j8P8sdR03IzAsjvNvvz6/yR9K9AIshOtYL/sh
         rPkKBaMsbqwQOQOvywRQi6MnC50UCoRSt/tABrEo=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 20/22] pNFS/flexfiles: Check the layout segment range before doing I/O
Date:   Sat, 28 Mar 2020 11:32:18 -0400
Message-Id: <20200328153220.1352010-21-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-20-trondmy@kernel.org>
References: <20200328153220.1352010-1-trondmy@kernel.org>
 <20200328153220.1352010-2-trondmy@kernel.org>
 <20200328153220.1352010-3-trondmy@kernel.org>
 <20200328153220.1352010-4-trondmy@kernel.org>
 <20200328153220.1352010-5-trondmy@kernel.org>
 <20200328153220.1352010-6-trondmy@kernel.org>
 <20200328153220.1352010-7-trondmy@kernel.org>
 <20200328153220.1352010-8-trondmy@kernel.org>
 <20200328153220.1352010-9-trondmy@kernel.org>
 <20200328153220.1352010-10-trondmy@kernel.org>
 <20200328153220.1352010-11-trondmy@kernel.org>
 <20200328153220.1352010-12-trondmy@kernel.org>
 <20200328153220.1352010-13-trondmy@kernel.org>
 <20200328153220.1352010-14-trondmy@kernel.org>
 <20200328153220.1352010-15-trondmy@kernel.org>
 <20200328153220.1352010-16-trondmy@kernel.org>
 <20200328153220.1352010-17-trondmy@kernel.org>
 <20200328153220.1352010-18-trondmy@kernel.org>
 <20200328153220.1352010-19-trondmy@kernel.org>
 <20200328153220.1352010-20-trondmy@kernel.org>
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
index 3221001f2ea1..2b45807a5221 100644
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
index b32025553f26..8e0ada581b92 100644
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

