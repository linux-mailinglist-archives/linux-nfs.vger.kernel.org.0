Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9843270597
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Sep 2020 21:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIRTcI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Sep 2020 15:32:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgIRTcI (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 18 Sep 2020 15:32:08 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D2D121734
        for <linux-nfs@vger.kernel.org>; Fri, 18 Sep 2020 19:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600457527;
        bh=sYAusMtH0+K8xt8xTSvEfpOziA5PCCZ/peniVhC0/S8=;
        h=From:To:Subject:Date:From;
        b=cgd/KdnmaGkRovuIjzrQRiZsWxemrH3eb7vGiKfdVcoKLEMyZr0LgbC6LdBft5afS
         yjaBzFJ+KS/nliX8PMBaxdaGjkZxK+kAPC98SrIFQPDxaV6GTalkT19NKKjllOj/jY
         Au+fM5jHwuPbhkJ/htZTgtY79cYsJ0L/dkRQ8BHQ=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] pNFS/flexfiles: Ensure we initialise the mirror bsizes correctly on read
Date:   Fri, 18 Sep 2020 15:29:58 -0400
Message-Id: <20200918192959.14270-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

While it is true that reading from an unmirrored source always uses
index 0, that is no longer true for mirrored sources when we fail over.

Fixes: 563c53e73b8b ("NFS: Fix flexfiles read failover")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index ff8965d1a4d4..1edeebd51937 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -838,6 +838,7 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	struct nfs4_ff_layout_mirror *mirror;
 	struct nfs4_pnfs_ds *ds;
 	int ds_idx;
+	u32 i;
 
 retry:
 	ff_layout_pg_check_layout(pgio, req);
@@ -863,14 +864,14 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 		goto retry;
 	}
 
-	mirror = FF_LAYOUT_COMP(pgio->pg_lseg, ds_idx);
+	for (i = 0; i < pgio->pg_mirror_count; i++) {
+		mirror = FF_LAYOUT_COMP(pgio->pg_lseg, i);
+		pgm = &pgio->pg_mirrors[i];
+		pgm->pg_bsize = mirror->mirror_ds->ds_versions[0].rsize;
+	}
 
 	pgio->pg_mirror_idx = ds_idx;
 
-	/* read always uses only one mirror - idx 0 for pgio layer */
-	pgm = &pgio->pg_mirrors[0];
-	pgm->pg_bsize = mirror->mirror_ds->ds_versions[0].rsize;
-
 	if (NFS_SERVER(pgio->pg_inode)->flags &
 			(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR))
 		pgio->pg_maxretrans = io_maxretrans;
-- 
2.26.2

