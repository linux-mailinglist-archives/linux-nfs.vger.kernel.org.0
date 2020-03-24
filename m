Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E00DE191DBF
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgCXXts (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727183AbgCXXts (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:48 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40A3F20719
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093787;
        bh=+JUSw23D99QxkWO2AZ4kTb67ZenkEhA5XM7/9tnCej4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=0FRLWQudMHiFefssvIl9lJlZgZVLay0buRs9jv9hK1lD8sJYj+cF3Hz8b6jHqXHgz
         Nz/Uq89PDsjIhEzMMtziEglaAJrPgTNovbjL9rZINHymgasHjOTWGi3VE7zCLYlim2
         5wdujgh/ECVtWMmTay+xBfyMQ9G+IOYaPKgczFFU=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 21/22] pNFS/flexfiles: remove requirement for whole file layouts
Date:   Tue, 24 Mar 2020 19:47:27 -0400
Message-Id: <20200324234728.8997-22-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-21-trondmy@kernel.org>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Remove the requirement that the server always sends whole file
layouts.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a816e304e876..8ad26cf786de 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -257,24 +257,6 @@ static void ff_layout_free_mirror_array(struct nfs4_ff_layout_segment *fls)
 		ff_layout_put_mirror(fls->mirror_array[i]);
 }
 
-static int ff_layout_check_layout(struct nfs4_layoutget_res *lgr)
-{
-	int ret = 0;
-
-	dprintk("--> %s\n", __func__);
-
-	/* FIXME: remove this check when layout segment support is added */
-	if (lgr->range.offset != 0 ||
-	    lgr->range.length != NFS4_MAX_UINT64) {
-		dprintk("%s Only whole file layouts supported. Use MDS i/o\n",
-			__func__);
-		ret = -EINVAL;
-	}
-
-	dprintk("--> %s returns %d\n", __func__, ret);
-	return ret;
-}
-
 static void _ff_layout_free_lseg(struct nfs4_ff_layout_segment *fls)
 {
 	if (fls) {
@@ -556,9 +538,6 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 
 out_sort_mirrors:
 	ff_layout_sort_mirrors(fls);
-	rc = ff_layout_check_layout(lgr);
-	if (rc)
-		goto out_err_free;
 	ret = &fls->generic_hdr;
 	dprintk("<-- %s (success)\n", __func__);
 out_free_page:
-- 
2.25.1

