Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E6641C60E
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Sep 2021 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344324AbhI2Nv2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Sep 2021 09:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344316AbhI2Nv1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Sep 2021 09:51:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 993D7613A9
        for <linux-nfs@vger.kernel.org>; Wed, 29 Sep 2021 13:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632923386;
        bh=lrG1yBbZRwVXxufLVRSbNcJ+4CEV1WmtB1NMXQ4VLbU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KWMTi3MnRIRc3X/pl4ABNAnYcy7RkrLHATF06Dx8tMSXey5MY5X4PayxR5uwtNlts
         nghP9lW5hGodEEEbqeqcJ1FXt6vZWbwZxojREe8tmWeUTei94dio3Rz0vUoOcHXekc
         LwECM8IVkNl7vRpCjIEcoha5z1wf1egGHdiDOayybeklceRre7ekifwzsGXYUpgyFX
         XzFa1GL3E3sU9L/kHCQW3xxE4ADvOJd0/JaX2xtpLSz/SoF92SCIatZ9ZD/uwRNrex
         SdiDQvatj0ZnU+SKcXDaZbeP3/xYq3nJMKdQUUWWgDJC5eje0B0IFHpuZPclzh/aRd
         k49DyEQfU2y+g==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/5] NFS: Fix up nfs_readdir_inode_mapping_valid()
Date:   Wed, 29 Sep 2021 09:49:42 -0400
Message-Id: <20210929134944.632844-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929134944.632844-2-trondmy@kernel.org>
References: <20210929134944.632844-1-trondmy@kernel.org>
 <20210929134944.632844-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The check for duplicate readdir cookies should only care if the change
attribute is invalid or the data cache is invalid.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f2df664db020..fa4d33687d2b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -411,7 +411,8 @@ static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
 static bool
 nfs_readdir_inode_mapping_valid(struct nfs_inode *nfsi)
 {
-	if (nfsi->cache_validity & (NFS_INO_INVALID_ATTR|NFS_INO_INVALID_DATA))
+	if (nfsi->cache_validity & (NFS_INO_INVALID_CHANGE |
+				    NFS_INO_INVALID_DATA))
 		return false;
 	smp_rmb();
 	return !test_bit(NFS_INO_INVALIDATING, &nfsi->flags);
-- 
2.31.1

