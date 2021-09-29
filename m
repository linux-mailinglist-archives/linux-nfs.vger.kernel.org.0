Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010F741C610
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Sep 2021 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344328AbhI2Nv3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Sep 2021 09:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344315AbhI2Nv2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Sep 2021 09:51:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 774EB61425
        for <linux-nfs@vger.kernel.org>; Wed, 29 Sep 2021 13:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632923387;
        bh=gDpL6zIS7P+ehHd52+B4B0jAN5ATz/2k1bTUtMjnyOA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZwZUGZpoQaP/Bzhgs2PtMomNe6Q/XvJfLPfFwnWNOFu8Tb35gJ+ixAPn2zKqN8VOA
         HlXG18UhW0J5f4z8iwwQy3qWy31BKBp76glUsKQa4VTkrTM1dRSzqDe7U+7JVYdT1l
         xLvahNRV2IhuQ2eR7k7sKbvB30cvbKdDplQFjOrR0NLVh2PIhODNZONe5dklU9W/7I
         jEclEkQSUZhJ3m/UCoybe1w0Oy2+JuYK6wfEceMZsdpg4nom2MHu2I6Am8C00/LXWa
         uMmUB2MAzTJ3aeXpZf2BN3DohYxOiAjmxUnqOggRVS7IkzzbKBOWmy1i4cI9WAFSJe
         jyKzMaG0fJqpw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] NFS: Fix dentry verifier races
Date:   Wed, 29 Sep 2021 09:49:44 -0400
Message-Id: <20210929134944.632844-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929134944.632844-4-trondmy@kernel.org>
References: <20210929134944.632844-1-trondmy@kernel.org>
 <20210929134944.632844-2-trondmy@kernel.org>
 <20210929134944.632844-3-trondmy@kernel.org>
 <20210929134944.632844-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the directory changed while we were revalidating the dentry, then
don't update the dentry verifier. There is no value in setting the
verifier to an older value, and we could end up overwriting a more up to
date verifier from a parallel revalidation.

Fixes: efeda80da38d ("NFSv4: Fix revalidation of dentries with delegations")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 358033aea235..033e9b145627 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1276,13 +1276,12 @@ static bool nfs_verifier_is_delegated(struct dentry *dentry)
 static void nfs_set_verifier_locked(struct dentry *dentry, unsigned long verf)
 {
 	struct inode *inode = d_inode(dentry);
+	struct inode *dir = d_inode(dentry->d_parent);
 
-	if (!nfs_verifier_is_delegated(dentry) &&
-	    !nfs_verify_change_attribute(d_inode(dentry->d_parent), verf))
-		goto out;
+	if (!nfs_verify_change_attribute(dir, verf))
+		return;
 	if (inode && NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
 		nfs_set_verifier_delegated(&verf);
-out:
 	dentry->d_time = verf;
 }
 
-- 
2.31.1

