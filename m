Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A89203FD8
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2020 21:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgFVTG0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jun 2020 15:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730020AbgFVTG0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 22 Jun 2020 15:06:26 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B731E20732
        for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2020 19:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592852785;
        bh=YeUXTOlHiKko8EoRKaSI/3kgM3MOAo28FPKRikE8vDc=;
        h=From:To:Subject:Date:From;
        b=gaTw5St7SVpH5upqYOzByLiSSzcw6ZZ/dxJ7gar6GSTFQSJUTNg39mmkl9HUFafDR
         u8AeaKlEa33pzLUKRfj31m+5WAUK3WRhdR+RTL+ErjRfs6L/ULPR/FTKBGeYy56Z08
         GExOkRbuNIQFcYhdr69B7+6t2X24OkJmjdMBdWoc=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] pNFS/flexfiles: Fix list corruption if the mirror count changes
Date:   Mon, 22 Jun 2020 15:04:15 -0400
Message-Id: <20200622190417.566077-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the mirror count changes in the new layout we pick up inside
ff_layout_pg_init_write(), then we can end up adding the
request to the wrong mirror and corrupting the mirror->pg_list.

Fixes: d600ad1f2bdb ("NFS41: pop some layoutget errors to application")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 7d399f72ebbb..de03e440b7ee 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -907,9 +907,8 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 		goto out_mds;
 
 	/* Use a direct mapping of ds_idx to pgio mirror_idx */
-	if (WARN_ON_ONCE(pgio->pg_mirror_count !=
-	    FF_LAYOUT_MIRROR_COUNT(pgio->pg_lseg)))
-		goto out_mds;
+	if (pgio->pg_mirror_count != FF_LAYOUT_MIRROR_COUNT(pgio->pg_lseg))
+		goto out_eagain;
 
 	for (i = 0; i < pgio->pg_mirror_count; i++) {
 		mirror = FF_LAYOUT_COMP(pgio->pg_lseg, i);
@@ -931,7 +930,10 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 			(NFS_MOUNT_SOFT|NFS_MOUNT_SOFTERR))
 		pgio->pg_maxretrans = io_maxretrans;
 	return;
-
+out_eagain:
+	pnfs_generic_pg_cleanup(pgio);
+	pgio->pg_error = -EAGAIN;
+	return;
 out_mds:
 	trace_pnfs_mds_fallback_pg_init_write(pgio->pg_inode,
 			0, NFS4_MAX_UINT64, IOMODE_RW,
@@ -941,6 +943,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 	pgio->pg_lseg = NULL;
 	pgio->pg_maxretrans = 0;
 	nfs_pageio_reset_write_mds(pgio);
+	pgio->pg_error = -EAGAIN;
 }
 
 static unsigned int
-- 
2.26.2

