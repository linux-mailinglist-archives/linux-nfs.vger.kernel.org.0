Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD3335F537
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351574AbhDNNoi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351607AbhDNNoX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FF34611CC
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407841;
        bh=XA96E3yetjCfwmoZqOjRxO7wvK+Th6Drpffd8XFm6sc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fb+s38p3Y0n6X433oLULMzkrV+D8sM3IQ6d82v0WvmT29gOTvkpZ+vJNAIg5MkttH
         kG2UD5t7HuzA3BCH1ALPv6sQ/VQwpGBK0kjLoYPzABJDT+r0wX8czfJ7uxKreNtJgR
         JTaW4YH/mgZM2XMoFZeXs7M5+9ulzvrpdvlY0RrMnP6/obvpPdNQSu63TnDT38j590
         p/Rf4K3mXD4Dsu6gpl5M3aQ1khiEVWDxy7oK3D8MnlqWGHImwAI2j5oDeBScVtl2cO
         CRJd8WoS6yWaBe60/H2YkWjmw1XCZMRYMP0yJOcjHldD4Do9RpMSuJOnILpwa4vniX
         G3HxhBMy9LViw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 15/26] NFS: Fix up handling of outstanding layoutcommit in nfs_update_inode()
Date:   Wed, 14 Apr 2021 09:43:42 -0400
Message-Id: <20210414134353.11860-16-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-15-trondmy@kernel.org>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If there is an outstanding layoutcommit, then the list of attributes
whose values are expected to change is not the full set. So let's
be explicit about the full list.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 81e3e140e923..18c7277d17a8 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1933,7 +1933,11 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	nfs_wcc_update_inode(inode, fattr);
 
 	if (pnfs_layoutcommit_outstanding(inode)) {
-		nfsi->cache_validity |= save_cache_validity & NFS_INO_INVALID_ATTR;
+		nfsi->cache_validity |=
+			save_cache_validity &
+			(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
+			 NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
+			 NFS_INO_REVAL_FORCED);
 		cache_revalidated = false;
 	}
 
-- 
2.30.2

