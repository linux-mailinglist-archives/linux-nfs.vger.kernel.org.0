Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93D69191DC1
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgCXXtt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbgCXXts (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:48 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD6462073C
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093787;
        bh=ar0wkMwCe6ZGIRTs9sssTCqmlezrmEtiKGCGz+0IHWM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uIb37uBCmB9bWUx6rR1njArMLp0EfY37Ifa2x81z6M6MsjEcD5Sqx3+4a3R32M6S8
         H6+xJVuE/4xQl7qZrL+N+DGwBsiQ0C4CdIzoXHLRJ01U0qc6v8sdiOUiVeCeqwr5Ac
         B1EXC/b8cmUosmoigZMs4/xthoJOuD8xe/Ac9NK0=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 22/22] pNFS/flexfiles: Specify the layout segment range in LAYOUTGET
Date:   Tue, 24 Mar 2020 19:47:28 -0400
Message-Id: <20200324234728.8997-23-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-22-trondmy@kernel.org>
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
 <20200324234728.8997-21-trondmy@kernel.org>
 <20200324234728.8997-22-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Move from requesting only full file layout segments, to requesting
layout segments that match our I/O size. This means the server is
still free to return a full file layout, but we will no longer
error out if it does not.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 8ad26cf786de..b2a7c711e911 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -798,8 +798,8 @@ ff_layout_pg_get_read(struct nfs_pageio_descriptor *pgio,
 	pnfs_put_lseg(pgio->pg_lseg);
 	pgio->pg_lseg = pnfs_update_layout(pgio->pg_inode,
 					   nfs_req_openctx(req),
-					   0,
-					   NFS4_MAX_UINT64,
+					   req_offset(req),
+					   req->wb_bytes,
 					   IOMODE_READ,
 					   strict_iomode,
 					   GFP_KERNEL);
@@ -891,8 +891,8 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 	if (!pgio->pg_lseg) {
 		pgio->pg_lseg = pnfs_update_layout(pgio->pg_inode,
 						   nfs_req_openctx(req),
-						   0,
-						   NFS4_MAX_UINT64,
+						   req_offset(req),
+						   req->wb_bytes,
 						   IOMODE_RW,
 						   false,
 						   GFP_NOFS);
-- 
2.25.1

