Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDF619670A
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgC1Pen (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbgC1Pen (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:43 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68A862073B
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409682;
        bh=KLX0w9B6a2wfY6DBgUd9oIry6zclDL0IGW+QbOQtxCo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=F7GxnTVMtIThRrT7EAehovr+DQsgMUd/C091wf5xKB/zCdJMhGunUFaSe2wHFFlzJ
         oYiNvx8IQTchfm2KYfTY5iMwOZ0CUPPDgvkj7xhlnP6EnFZFiZsXnY7IXD3Vq2yS3U
         3XWBtIVj+4ff/alAixebn3N46a0nk77Wts6TIc8w=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 21/22] pNFS/flexfiles: remove requirement for whole file layouts
Date:   Sat, 28 Mar 2020 11:32:19 -0400
Message-Id: <20200328153220.1352010-22-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-21-trondmy@kernel.org>
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
 <20200328153220.1352010-21-trondmy@kernel.org>
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
index 2b45807a5221..42f581e213cc 100644
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

