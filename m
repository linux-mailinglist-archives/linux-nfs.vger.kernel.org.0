Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39F3E3133B2
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Feb 2021 14:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhBHNuR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Feb 2021 08:50:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231147AbhBHNuP (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Feb 2021 08:50:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E30B64E54;
        Mon,  8 Feb 2021 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612792173;
        bh=PEzZAudDaaZSQyojLUqDwEImyR9e/f21kZJ6eedZirw=;
        h=From:To:Cc:Subject:Date:From;
        b=PyUXtl1q+HANBxP0G1s9pGTb5dI6JVM3ugZZv6cgE0FHH5tM7CiRCOPap3d2P3pz2
         Ei+Xgy+JyySM9+Y+Jb0p2M8Gk8Lrc8H7DFnKvx8C5UP1O9qRS4MENKupH0RaoRnMpK
         457505334RL2UvAbpkYUEmgm67kKrgdEGzdiO8qrYh9bkuYOPUlDNiwK86SpuNCuRq
         SLsJ5N9Ba1tgAa0IEttxiDHGkKps2dKS3ZqY/RJ56orgGd0Ul9f9rqkulTS43DPlEr
         iGKGhKs/NzL7rnsNRLN5TicOV+trSGt1Ot6GKR1uWBK1aNLM/DuxToRt1JhN7B/wqC
         ff/x41YQ7MBgw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Fixes for nfs4_bitmask_adjust()
Date:   Mon,  8 Feb 2021 08:49:32 -0500
Message-Id: <20210208134932.27070-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We don't want to ask for the ACL in a WRITE reply, since we don't have
a preallocated buffer.

Instead of checking NFS_INO_INVALID_ACCESS, which is really about
managing the access cache, we should look at the value of
NFS_INO_INVALID_OTHER. Also ensure we assign the mode, owner and
owner_group flags to the correct bit mask.

Finally, fix up the check for NFS_INO_INVALID_CTIME to retrieve the
ctime, and add a check for NFS_INO_INVALID_CHANGE.

Fixes: 76bd5c016ef4 ("NFSv4: make cache consistency bitmask dynamic")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 2f4679a62712..fc8bbfd9beb3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5438,15 +5438,16 @@ static void nfs4_bitmask_adjust(__u32 *bitmask, struct inode *inode,
 
 	if (cache_validity & NFS_INO_INVALID_ATIME)
 		bitmask[1] |= FATTR4_WORD1_TIME_ACCESS;
-	if (cache_validity & NFS_INO_INVALID_ACCESS)
-		bitmask[0] |= FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER |
-				FATTR4_WORD1_OWNER_GROUP;
-	if (cache_validity & NFS_INO_INVALID_ACL)
-		bitmask[0] |= FATTR4_WORD0_ACL;
-	if (cache_validity & NFS_INO_INVALID_LABEL)
+	if (cache_validity & NFS_INO_INVALID_OTHER)
+		bitmask[1] |= FATTR4_WORD1_MODE | FATTR4_WORD1_OWNER |
+				FATTR4_WORD1_OWNER_GROUP |
+				FATTR4_WORD1_NUMLINKS;
+	if (label && label->len && cache_validity & NFS_INO_INVALID_LABEL)
 		bitmask[2] |= FATTR4_WORD2_SECURITY_LABEL;
-	if (cache_validity & NFS_INO_INVALID_CTIME)
+	if (cache_validity & NFS_INO_INVALID_CHANGE)
 		bitmask[0] |= FATTR4_WORD0_CHANGE;
+	if (cache_validity & NFS_INO_INVALID_CTIME)
+		bitmask[1] |= FATTR4_WORD1_TIME_METADATA;
 	if (cache_validity & NFS_INO_INVALID_MTIME)
 		bitmask[1] |= FATTR4_WORD1_TIME_MODIFY;
 	if (cache_validity & NFS_INO_INVALID_SIZE)
-- 
2.29.2

