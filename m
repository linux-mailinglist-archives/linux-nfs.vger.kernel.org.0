Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAC2203FD9
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jun 2020 21:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgFVTG1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Jun 2020 15:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730098AbgFVTG1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 22 Jun 2020 15:06:27 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0A4220732
        for <linux-nfs@vger.kernel.org>; Mon, 22 Jun 2020 19:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592852786;
        bh=e5wgg5TEvvihEyD66YELmCyucF4vSE1fFeaXjkDmbbo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=I0zJWSAMjt1Hq1uYg8dN9vLCLYjtRNUO2+FRpuExifcQefcHkATXzmX0Csl3fLnoJ
         1lu9zFJ04bT0S1tik5O0NP8PdtazQj1K+0PfIjR3byt2xu6M8AKUlcp/3LqE8QuhWT
         4IVUG9fYfRQffNTjKM9+fMebYKmWiJL0QM8dCY18=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] pNFS/flexfiles: The mirror count could depend on the layout segment range
Date:   Mon, 22 Jun 2020 15:04:17 -0400
Message-Id: <20200622190417.566077-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200622190417.566077-2-trondmy@kernel.org>
References: <20200622190417.566077-1-trondmy@kernel.org>
 <20200622190417.566077-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Make sure we specify the layout segment range when calculating the
mirror count. In theory, that number could depend on the range to
which we're writing.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index b3ec12e5fde1..b26173d72735 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -947,8 +947,8 @@ ff_layout_pg_get_mirror_count_write(struct nfs_pageio_descriptor *pgio,
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
2.26.2

