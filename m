Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B5A7DAF21
	for <lists+linux-nfs@lfdr.de>; Sun, 29 Oct 2023 23:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjJ2W4d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 Oct 2023 18:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjJ2Wz7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 Oct 2023 18:55:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFF2170A;
        Sun, 29 Oct 2023 15:55:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A051C433C8;
        Sun, 29 Oct 2023 22:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620115;
        bh=2ML0ItDxpS8Pwcv0Qvcs/7csJFshPgMf0DqbMXXRlxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DYKeDBSzDRf9As/02zl6apvUuzKaWqvLWmOsLWtSf2EmrEvAn8rN+JkeFTjq37kYu
         qjBw3aygqMGBKNq/Tm8YjnRHtWN5XgEXp1aFWopdvW3VgNvXsgIFB2QdLQBse26Fh+
         cYH6cRrbRW2MopiYSrtK4YB2IjpfbaY5mSFCeJwSihjbMCE0FBi6BxYVxtyeYp5YqD
         5Kh+sOQnbYEUXS3gqNJ3qfZi7fftZ4aQHZzkNolNLaHBOu9mVzpN/NKGuFUOLE48kT
         TEj2kdIPYGF97oK6J1GgAeqKNvN01749F3xRSwZZvSgFGFEfkG+DiVwVYFpPQrHLvD
         AYZBJpXgdeJXg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>,
        trond.myklebust@hammerspace.com, anna@kernel.org,
        linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 22/52] nfs42: client needs to strip file mode's suid/sgid bit after ALLOCATE op
Date:   Sun, 29 Oct 2023 18:53:09 -0400
Message-ID: <20231029225441.789781-22-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 063e00aff87ed..28704f924612c 100644
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

