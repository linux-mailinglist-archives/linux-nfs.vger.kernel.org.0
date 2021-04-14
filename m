Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2DF35F52C
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243282AbhDNNog (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351583AbhDNNoQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 743B3611AD
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407835;
        bh=Av2mTAvTPBRR6n/iApvQ7Kz11QtjqJfgvAB+6CQmYVc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TjuBtKfF6UZmeYec22E+IRiwo+tLTZ4bHY1yZU81S/+aCdHSUb5GF3JfUPA4w9eri
         ljX+72EAmyyZpUPfBSn68Vx9Milia8afMA9tRGzOeh77nqYNDNEFYgREu6JThvxnYj
         WTV+3g+v5C3n6j1TbVVX6i+ATSfbM0gurQ6e6fwHcolrzRbS7vVKiNU+obtrL+uGvi
         LD3TIuZ3IukTvrvfh7orRzf/HBet5pECzJdkn+VhjnLMQpv2U12NjcEHS0Sm+4Dyj1
         D1OvtSRxywDeR/pl6C29zfROUj1KbP46QwhXChK8x/nrQVFlK+ByrNMfFC+ro+IHVg
         bg6d9kZB3tYWA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 01/26] NFS: Deal correctly with attribute generation counter overflow
Date:   Wed, 14 Apr 2021 09:43:28 -0400
Message-Id: <20210414134353.11860-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-1-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We need to use unsigned long subtraction and then convert to signed in
order to deal correcly with C overflow rules.

Fixes: f5062003465c ("NFS: Set an attribute barrier on all updates")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index ff737be559dc..8de5b3b9da91 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1662,10 +1662,10 @@ EXPORT_SYMBOL_GPL(_nfs_display_fhandle);
  */
 static int nfs_inode_attrs_need_update(const struct inode *inode, const struct nfs_fattr *fattr)
 {
-	const struct nfs_inode *nfsi = NFS_I(inode);
+	unsigned long attr_gencount = NFS_I(inode)->attr_gencount;
 
-	return ((long)fattr->gencount - (long)nfsi->attr_gencount) > 0 ||
-		((long)nfsi->attr_gencount - (long)nfs_read_attr_generation_counter() > 0);
+	return (long)(fattr->gencount - attr_gencount) > 0 ||
+	       (long)(attr_gencount - nfs_read_attr_generation_counter()) > 0;
 }
 
 static int nfs_refresh_inode_locked(struct inode *inode, struct nfs_fattr *fattr)
@@ -2094,7 +2094,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 			nfsi->attrtimeo_timestamp = now;
 		}
 		/* Set the barrier to be more recent than this fattr */
-		if ((long)fattr->gencount - (long)nfsi->attr_gencount > 0)
+		if ((long)(fattr->gencount - nfsi->attr_gencount) > 0)
 			nfsi->attr_gencount = fattr->gencount;
 	}
 
-- 
2.30.2

