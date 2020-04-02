Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8287419CDA0
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2020 01:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390172AbgDBXvr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Apr 2020 19:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390284AbgDBXvr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 Apr 2020 19:51:47 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA91820787
        for <linux-nfs@vger.kernel.org>; Thu,  2 Apr 2020 23:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585871506;
        bh=l/wGRNS/vSCMELgEzHQalUFD30siAXDLsFwhUT/pO+0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KpjaZ0Zh4/9GQuhFoTwodwiGBgGKR6jsF7rF7rRugfgSBEq1yDozkddUGiEgV1YKS
         dV8jTa5/y94sNWy6y8wXbPx84SMI4MeG2+8IKkylocs5OymfRXkKIyb/+HBZuKCbUR
         ZtPjsrhxcHUArFp4wm5sCXC0+6w/cQDCJdT45v88=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS/pnfs: Fix dereference of layout cred in pnfs_layoutcommit_inode()
Date:   Thu,  2 Apr 2020 19:49:16 -0400
Message-Id: <20200402234917.797185-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200402234917.797185-1-trondmy@kernel.org>
References: <20200402234917.797185-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that the dereference of the layout cred is atomic with the
stateid.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 6fcf26b16816..84029c9b2b1b 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -3137,10 +3137,10 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 	end_pos = nfsi->layout->plh_lwb;
 
 	nfs4_stateid_copy(&data->args.stateid, &nfsi->layout->plh_stateid);
+	data->cred = get_cred(nfsi->layout->plh_lc_cred);
 	spin_unlock(&inode->i_lock);
 
 	data->args.inode = inode;
-	data->cred = get_cred(nfsi->layout->plh_lc_cred);
 	nfs_fattr_init(&data->fattr);
 	data->args.bitmask = NFS_SERVER(inode)->cache_consistency_bitmask;
 	data->res.fattr = &data->fattr;
-- 
2.25.1

