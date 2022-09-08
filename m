Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F285B239F
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Sep 2022 18:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiIHQbM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Sep 2022 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbiIHQbL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 8 Sep 2022 12:31:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7BA3F1CE
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 09:31:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4501C61D3F
        for <linux-nfs@vger.kernel.org>; Thu,  8 Sep 2022 16:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BE9C433C1;
        Thu,  8 Sep 2022 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662654669;
        bh=27EbxXO1DyjpGbYOLnZeUrTV/va+bOPW+sGhXcV/fIY=;
        h=From:To:Cc:Subject:Date:From;
        b=m9BUTccSUcFeryFS9Hnf6i+Djzce2pIrkk7wEL7gLCvtqu6jlcQ/ZzlF1RuZVYyBi
         XelGIFBkGzg0AdWT4ItqIKQZg505StkaouXvuDBrwnMZadginhS07VzKaJbOlXTH5t
         lbo5EKO4zCm4ctA0pWTaI+V4kIFVm5xkX7cKCvLkewGKB76jLv/uCZTI7ulgcaQTAS
         AXIVCsmg9v0Q5Y/mh2arEqr4lpN6jM3CQk/XsjNyqOzexUwwEvOLaQg5N8Bf+xU/Mi
         m91z/zacq1E2vjvIMklZCJ8oNx7C673K/lpPIB3MQDWwoEakL25/RFoC9Unpitl3QQ
         zuxQZ8IdK9S/A==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: clean up mounted_on_fileid handling
Date:   Thu,  8 Sep 2022 12:31:07 -0400
Message-Id: <20220908163107.202597-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We only need the inode number for this, not a full rack of attributes.
Rename this function make it take a pointer to a u64 instead of
struct kstat, and change it to just request STATX_INO.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4xdr.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1e9690a061ec..5980df859c3a 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -2774,9 +2774,10 @@ static __be32 fattr_handle_absent_fs(u32 *bmval0, u32 *bmval1, u32 *bmval2, u32
 }
 
 
-static int get_parent_attributes(struct svc_export *exp, struct kstat *stat)
+static int get_mounted_on_ino(struct svc_export *exp, u64 *pino)
 {
 	struct path path = exp->ex_path;
+	struct kstat stat;
 	int err;
 
 	path_get(&path);
@@ -2784,8 +2785,10 @@ static int get_parent_attributes(struct svc_export *exp, struct kstat *stat)
 		if (path.dentry != path.mnt->mnt_root)
 			break;
 	}
-	err = vfs_getattr(&path, stat, STATX_BASIC_STATS, AT_STATX_SYNC_AS_STAT);
+	err = vfs_getattr(&path, &stat, STATX_INO, AT_STATX_SYNC_AS_STAT);
 	path_put(&path);
+	if (!err)
+		*pino = stat.ino;
 	return err;
 }
 
@@ -3282,22 +3285,21 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		*p++ = cpu_to_be32(stat.btime.tv_nsec);
 	}
 	if (bmval1 & FATTR4_WORD1_MOUNTED_ON_FILEID) {
-		struct kstat parent_stat;
 		u64 ino = stat.ino;
 
 		p = xdr_reserve_space(xdr, 8);
 		if (!p)
                 	goto out_resource;
 		/*
-		 * Get parent's attributes if not ignoring crossmount
-		 * and this is the root of a cross-mounted filesystem.
+		 * Get ino of mountpoint in parent filesystem, if not ignoring
+		 * crossmount and this is the root of a cross-mounted
+		 * filesystem.
 		 */
 		if (ignore_crossmnt == 0 &&
 		    dentry == exp->ex_path.mnt->mnt_root) {
-			err = get_parent_attributes(exp, &parent_stat);
+			err = get_mounted_on_ino(exp, &ino);
 			if (err)
 				goto out_nfserr;
-			ino = parent_stat.ino;
 		}
 		p = xdr_encode_hyper(p, ino);
 	}
-- 
2.37.3

