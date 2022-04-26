Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED86150FE63
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Apr 2022 15:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350674AbiDZNNI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Apr 2022 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350673AbiDZNNI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Apr 2022 09:13:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCDF296
        for <linux-nfs@vger.kernel.org>; Tue, 26 Apr 2022 06:09:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8F379B81F0D
        for <linux-nfs@vger.kernel.org>; Tue, 26 Apr 2022 13:09:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2199EC385A0
        for <linux-nfs@vger.kernel.org>; Tue, 26 Apr 2022 13:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650978596;
        bh=2r6zvhCDrZ8Zog4jMam9FXrTCEQI6bSlvxR/FiostsM=;
        h=From:To:Subject:Date:From;
        b=tZAacEcdH0pOYrx2jDYxI10L9uMwdTmZ/+g/wNrZsGFd2FJtbdwrlabAooG3e1+6Q
         JRRol56zJWKHW6t3fgbNDYR1UaqsRlEJLZPP94QXRXIr3xaIpygaj5gntR4HGQi9jr
         nNqSuqUgRPgeL6qyRTgs+kI5t2lXgD24uzZ7bOsxkqyrGkQW388fTNngkq2JodyY8C
         Xhww5icZoMSrxLD0VOuSfVpV800ei47to6fmJ5oLGzvweXPnlZCA8SZ1ZVQLwlBSCc
         eeroNvhoWtfjq37c5ezk/Y3oqjjJD0HI3/CT0v3Z7UlGYdjnPGUD+Rh7/Lf4usVhe9
         OgsgvhYV75d9A==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Don't invalidate inode attributes on delegation return
Date:   Tue, 26 Apr 2022 09:03:30 -0400
Message-Id: <20220426130330.10640-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

There is no need to declare attributes such as the ctime, mtime and
block size invalid when we're just returning a delegation, so it is
inappropriate to call nfs_post_op_update_inode_force_wcc().
Instead, just call nfs_refresh_inode() after faking up the change
attribute. We know that the GETATTR op occurs before the DELEGRETURN, so
we are safe when doing this.

Fixes: 0bc2c9b4dca9 ("NFSv4: Don't discard the attributes returned by asynchronous DELEGRETURN")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 16106f805ffa..a79f66432bd3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -363,6 +363,14 @@ static void nfs4_setup_readdir(u64 cookie, __be32 *verifier, struct dentry *dent
 	kunmap_atomic(start);
 }
 
+static void nfs4_fattr_set_prechange(struct nfs_fattr *fattr, u64 version)
+{
+	if (!(fattr->valid & NFS_ATTR_FATTR_PRECHANGE)) {
+		fattr->pre_change_attr = version;
+		fattr->valid |= NFS_ATTR_FATTR_PRECHANGE;
+	}
+}
+
 static void nfs4_test_and_free_stateid(struct nfs_server *server,
 		nfs4_stateid *stateid,
 		const struct cred *cred)
@@ -6553,7 +6561,9 @@ static void nfs4_delegreturn_release(void *calldata)
 		pnfs_roc_release(&data->lr.arg, &data->lr.res,
 				 data->res.lr_ret);
 	if (inode) {
-		nfs_post_op_update_inode_force_wcc(inode, &data->fattr);
+		nfs4_fattr_set_prechange(&data->fattr,
+					 inode_peek_iversion_raw(inode));
+		nfs_refresh_inode(inode, &data->fattr);
 		nfs_iput_and_deactive(inode);
 	}
 	kfree(calldata);
-- 
2.35.1

