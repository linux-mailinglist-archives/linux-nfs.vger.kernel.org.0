Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAFA7DB10A
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 00:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjJ2X3I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 Oct 2023 19:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjJ2X2c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 Oct 2023 19:28:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BD349C2;
        Sun, 29 Oct 2023 15:58:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E830C43142;
        Sun, 29 Oct 2023 22:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620283;
        bh=JzhV2baKjYJKCG7HB3w3U5IgTexqNb1Lzeevsg8VPaw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kQRcw+uso8/gLDYFWEHYhj6oI1KqZTM2nNluKqubiQY40yuyJH1Rn/vpsfgxM4zwY
         h3mEjDwM5SK61eZvejGEwJmRdWPBNav+6S+vh6YG4A//3MtX3lcBkg/J0O2HSkF6aX
         hv43Ibx+aGGcccj7KhBM2Gt8DVVKDVqHnRZ7VcxWG8zhAl0xyQxNQA6UJhgF8sW4za
         6mdonCfM/PoLiEWEhWdkyst+PB3cuMWEXNLUPrpAKwu+DMho6RMjM+l2bwA29iwSoX
         iA42OmI/G9UaxgEoarH8Gk8p9u6FwPcnabUMdFTpRSX5H3Z1Umgvis60aGjD42b8kt
         WKG4N9t0pQ6Sw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/39] nfs42: client needs to strip file mode's suid/sgid bit after ALLOCATE op
Date:   Sun, 29 Oct 2023 18:56:48 -0400
Message-ID: <20231029225740.790936-16-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225740.790936-1-sashal@kernel.org>
References: <20231029225740.790936-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Dai Ngo <dai.ngo@oracle.com>

[ Upstream commit f588d72bd95f748849685412b1f0c7959ca228cf ]

The Linux NFS server strips the SUID and SGID from the file mode
on ALLOCATE op.

Modify _nfs42_proc_fallocate to add NFS_INO_REVAL_FORCED to
nfs_set_cache_invalid's argument to force update of the file
mode suid/sgid bit.

Suggested-by: Trond Myklebust <trondmy@hammerspace.com>
Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs42proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index d903ea10410c2..5a8fe0e57a3d3 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -81,7 +81,8 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 	if (status == 0) {
 		if (nfs_should_remove_suid(inode)) {
 			spin_lock(&inode->i_lock);
-			nfs_set_cache_invalid(inode, NFS_INO_INVALID_MODE);
+			nfs_set_cache_invalid(inode,
+				NFS_INO_REVAL_FORCED | NFS_INO_INVALID_MODE);
 			spin_unlock(&inode->i_lock);
 		}
 		status = nfs_post_op_update_inode_force_wcc(inode,
-- 
2.42.0

