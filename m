Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2A335F53C
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351579AbhDNNok (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351608AbhDNNoX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15973611AD
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407842;
        bh=OWPmJrsTKWRdUD8G+7Nml5alyTR4bp8YbG1DHJ0N5Nk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tNJU3TSrk4BOu15U6AHlkhhIyJ/BqEui+ZHTMMJCW/kGEgxl08v9gqjEFUeUPbjlw
         j0jh7Ozx0XIjwp3lFTQT0BbgzJFdOuSElcslBNWSouGlOszmHo7mliKRQ1wwuykIO4
         IHol3JSiXhYncI7rzG7o5EIFVxlUkGBNce4vpJpaC4GpE+1R2unjXqW5MjE7gY+D+N
         2Hkj+uSwr7yAZRC+WpeD50/X9fXi0+IQAL/Xds634kN/nTLXU+wIUuYqmtKgTWRDrN
         LuBjfcnJropq0eOo/Yuo8A/cx69kdsN1NKCULlxao7yhhqx0Bx2IEaQiTGfGBN2rw4
         WrvVXpMRCrVBw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 16/26] NFS: Remove a line of code that has no effect in nfs_update_inode()
Date:   Wed, 14 Apr 2021 09:43:43 -0400
Message-Id: <20210414134353.11860-17-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-16-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
 <20210414134353.11860-6-trondmy@kernel.org>
 <20210414134353.11860-7-trondmy@kernel.org>
 <20210414134353.11860-8-trondmy@kernel.org>
 <20210414134353.11860-9-trondmy@kernel.org>
 <20210414134353.11860-10-trondmy@kernel.org>
 <20210414134353.11860-11-trondmy@kernel.org>
 <20210414134353.11860-12-trondmy@kernel.org>
 <20210414134353.11860-13-trondmy@kernel.org>
 <20210414134353.11860-14-trondmy@kernel.org>
 <20210414134353.11860-15-trondmy@kernel.org>
 <20210414134353.11860-16-trondmy@kernel.org>
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
index 18c7277d17a8..e4333b6ab2d4 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2110,7 +2110,6 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 
 	/* Update attrtimeo value if we're out of the unstable period */
 	if (attr_changed) {
-		invalid &= ~NFS_INO_INVALID_ATTR;
 		nfs_inc_stats(inode, NFSIOS_ATTRINVALIDATE);
 		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 		nfsi->attrtimeo_timestamp = now;
-- 
2.30.2

