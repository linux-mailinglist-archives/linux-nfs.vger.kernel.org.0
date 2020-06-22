Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FA2203FDA
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2020 21:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgFVTG1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jun 2020 15:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730020AbgFVTG0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 22 Jun 2020 15:06:26 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31FC820767
        for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2020 19:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592852786;
        bh=GljAy3mLCsFPWL2lr7wi9dQFipF3molBevQqJYVU3RE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CptDIwEj34l57qkVeNeLgZxNKOsxzuS7zr9i7/GhkNc9DG9mu6gtZ4ipEx+YNLKgn
         opkK7xVOI0K1KTLWoLc8MmpBBE1p+RAJsFKyuj8BnPjhN2tLJ5PX8SBZmhI9fM0eyf
         uZlrLxoHOxwRhgyI7HlSQSV6KnuDhdQiWqzRZb5A=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] pNFS/flexfiles: Clean up redundant calls to pnfs_put_lseg()
Date:   Mon, 22 Jun 2020 15:04:16 -0400
Message-Id: <20200622190417.566077-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622190417.566077-1-trondmy@kernel.org>
References: <20200622190417.566077-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Both nfs_pageio_reset_read_mds() and nfs_pageio_reset_write_mds()
do call pnfs_generic_pg_cleanup() for us.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index de03e440b7ee..b3ec12e5fde1 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -844,8 +844,7 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	if (!ds) {
 		if (!ff_layout_no_fallback_to_mds(pgio->pg_lseg))
 			goto out_mds;
-		pnfs_put_lseg(pgio->pg_lseg);
-		pgio->pg_lseg = NULL;
+		pnfs_generic_pg_cleanup(pgio);
 		/* Sleep for 1 second before retrying */
 		ssleep(1);
 		goto retry;
@@ -871,8 +870,6 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 			0, NFS4_MAX_UINT64, IOMODE_READ,
 			NFS_I(pgio->pg_inode)->layout,
 			pgio->pg_lseg);
-	pnfs_put_lseg(pgio->pg_lseg);
-	pgio->pg_lseg = NULL;
 	pgio->pg_maxretrans = 0;
 	nfs_pageio_reset_read_mds(pgio);
 }
@@ -916,8 +913,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 		if (!ds) {
 			if (!ff_layout_no_fallback_to_mds(pgio->pg_lseg))
 				goto out_mds;
-			pnfs_put_lseg(pgio->pg_lseg);
-			pgio->pg_lseg = NULL;
+			pnfs_generic_pg_cleanup(pgio);
 			/* Sleep for 1 second before retrying */
 			ssleep(1);
 			goto retry;
@@ -939,8 +935,6 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 			0, NFS4_MAX_UINT64, IOMODE_RW,
 			NFS_I(pgio->pg_inode)->layout,
 			pgio->pg_lseg);
-	pnfs_put_lseg(pgio->pg_lseg);
-	pgio->pg_lseg = NULL;
 	pgio->pg_maxretrans = 0;
 	nfs_pageio_reset_write_mds(pgio);
 	pgio->pg_error = -EAGAIN;
-- 
2.26.2

