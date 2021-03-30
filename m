Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4733334DCE7
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 02:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhC3ATO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 20:19:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhC3ASq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:18:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03DCB60C41
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 00:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617063526;
        bh=ASkvzzUzy0Zf2PWTjOBspbGyEGYU1xCptK2jhysUhRQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eMmOCF97mjLl9RmIEhwK0+dWi5EiDZlSTT5VKEcpxFjJtk0ApwhRiiANbJXNTScu1
         Lzg9CI8Iz+upURGdVu/PzZQUKS+O6Wk2WGgAzjIffNdThK3sF9pObWDGkktoP4wJ6g
         7YHBCddBBX4J6p7ekTByuEkGfzPRGsGp8Ho6/8CvE8u2nbZbE9LTKFsSS99DXDFEkq
         VBhBPKzoUdFa2SywxIonDSsUb76atp6oc7Vt6Q1dwhn/n2/a6quVCvdBu3dsHTMxY7
         9hItBqtF09wPS6jEue+KRlEJlVxjmLDzP66OLJA6xrsO2ArP8ZcYZCkKtwRSpyQtf0
         owadfq7kQdEfQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 13/17] NFS: Remove a line of code that has no effect in nfs_update_inode()
Date:   Mon, 29 Mar 2021 20:18:31 -0400
Message-Id: <20210330001835.41914-14-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330001835.41914-13-trondmy@kernel.org>
References: <20210330001835.41914-1-trondmy@kernel.org>
 <20210330001835.41914-2-trondmy@kernel.org>
 <20210330001835.41914-3-trondmy@kernel.org>
 <20210330001835.41914-4-trondmy@kernel.org>
 <20210330001835.41914-5-trondmy@kernel.org>
 <20210330001835.41914-6-trondmy@kernel.org>
 <20210330001835.41914-7-trondmy@kernel.org>
 <20210330001835.41914-8-trondmy@kernel.org>
 <20210330001835.41914-9-trondmy@kernel.org>
 <20210330001835.41914-10-trondmy@kernel.org>
 <20210330001835.41914-11-trondmy@kernel.org>
 <20210330001835.41914-12-trondmy@kernel.org>
 <20210330001835.41914-13-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Commit 0b467264d0db ("NFS: Fix attribute revalidation") changed the way
we populate the 'invalid' attribute, and made the line that strips away
the NFS_INO_INVALID_ATTR bits redundant.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index e57cd490bc4d..f60dc562e84b 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2115,7 +2115,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 
 	/* Update attrtimeo value if we're out of the unstable period */
 	if (attr_changed) {
-		invalid &= ~NFS_INO_INVALID_ATTR;
 		nfs_inc_stats(inode, NFSIOS_ATTRINVALIDATE);
 		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 		nfsi->attrtimeo_timestamp = now;
-- 
2.30.2

