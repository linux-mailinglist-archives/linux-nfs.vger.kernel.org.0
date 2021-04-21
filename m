Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA5D366F8B
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Apr 2021 17:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhDUP4l (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Apr 2021 11:56:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234894AbhDUP4k (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 21 Apr 2021 11:56:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F183B6144A;
        Wed, 21 Apr 2021 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619020567;
        bh=h4ycg7tPvAV4rChpkWI+ZqgNAiIdzxlW9glZog3vL3M=;
        h=From:To:Cc:Subject:Date:From;
        b=Zr4634N91XAYwOVh8VaF//ANZqFSi+c80iRWwmsPQOiA8O1Hsv40dpM8FssZQqqum
         HYBO7kcl/W44bicj8zvAIg/lrTwviIm4rv9C5b0KseoKE+zYkOngsviPxMcqmBszb5
         WHTIr4oKig9OPQNpNrWS7QMyyVxHIG2hip+QlxRdLsCHv0uv3OEscRcUEXbrgD/Lq5
         Q+u3FT6P0xd54EnC0dFaiORH7Sx9LFl8ozHaZlazeLDZWiAnBaF5wlQubFPS6KrRZr
         3dPx6L8UeLX04Cy0KbsFGSFr87JhmfIlXY+Sduh8KeaIQOe+8uO7NU4QGSjaKuMjlG
         FfRO6iHziPtqA==
From:   trondmy@kernel.org
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: The 'fattr_valid' field in struct nfs_server should be unsigned int
Date:   Wed, 21 Apr 2021 11:56:05 -0400
Message-Id: <20210421155605.225693-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Fix up a static compiler warning:
"fs/nfs/nfs4proc.c:3882 _nfs4_server_capabilities() warn: was expecting
a 64 bit value instead of '(1 << 11)'"

The fix is to convert the fattr_valid field to match the type of the
'valid' field in struct nfs_fattr.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/nfs_fs_sb.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index d28d7a62864f..70057b2e606e 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -156,6 +156,7 @@ struct nfs_server {
 #define NFS_MOUNT_WRITE_EAGER		0x01000000
 #define NFS_MOUNT_WRITE_WAIT		0x02000000
 
+	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
 	unsigned int		rsize;		/* read size */
 	unsigned int		rpages;		/* read size (in pages) */
@@ -191,8 +192,6 @@ struct nfs_server {
 	dev_t			s_dev;		/* superblock dev numbers */
 	struct nfs_auth_info	auth_info;	/* parsed auth flavors */
 
-	__u64			fattr_valid;	/* Valid attributes */
-
 #ifdef CONFIG_NFS_FSCACHE
 	struct nfs_fscache_key	*fscache_key;	/* unique key for superblock */
 	struct fscache_cookie	*fscache;	/* superblock cookie */
-- 
2.31.1

