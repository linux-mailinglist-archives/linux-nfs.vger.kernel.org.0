Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8585A194B
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Aug 2022 21:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiHYTGo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Aug 2022 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235785AbiHYTGn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Aug 2022 15:06:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E45FBD09B
        for <linux-nfs@vger.kernel.org>; Thu, 25 Aug 2022 12:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECD5DB82834
        for <linux-nfs@vger.kernel.org>; Thu, 25 Aug 2022 19:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BEAC433C1;
        Thu, 25 Aug 2022 19:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661454399;
        bh=r2gfrpY9yN2pe4++snf36nqrJwrExuBz10HYbox866k=;
        h=From:To:Cc:Subject:Date:From;
        b=JTWSaj8yZDItAULxZTmlHiQfIAFFQZRoSUweF7BKMqz569YHE7bPYsoH73VbA35/l
         o0IjcEHFm4/92DUWjLq8c3yYJSHRNh+sDJS20WcOPvKNifx+2iPUyg4Uz5PyU7yXWb
         +ZJ3xbAZmlP3VpbE0Q5jIfsTW4i23oR3feDxthnJl/X1WTU/SIfQUxN92eD1ZFSJye
         x65AgucRLkFk8gRIQi4GZT8hdPiy4TPiG5qtFf8JxUZKoil38E8Cqs2AO98nkm+IFe
         vaW31ozwQmYs+6HSFao2DjatADaYSi981DDliUOWrJak4v29SeAHnWgPwjy+Q0pAdJ
         yjA3hrYLSSijA==
From:   trondmy@kernel.org
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Turn off open-by-filehandle and NFS re-export for NFSv4.0
Date:   Thu, 25 Aug 2022 15:00:13 -0400
Message-Id: <20220825190013.578922-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.2
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The NFSv4.0 protocol only supports open() by name. It cannot therefore
be used with open_by_handle() and friends, nor can it be re-exported by
knfsd.

Reported-by: Chuck Lever III <chuck.lever@oracle.com>
Fixes: 20fa19027286 ("nfs: add export operations")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/super.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 6ab5eeb000dc..5e4bacb77bfc 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1051,22 +1051,31 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 	if (ctx->bsize)
 		sb->s_blocksize = nfs_block_size(ctx->bsize, &sb->s_blocksize_bits);
 
-	if (server->nfs_client->rpc_ops->version != 2) {
-		/* The VFS shouldn't apply the umask to mode bits. We will do
-		 * so ourselves when necessary.
+	switch (server->nfs_client->rpc_ops->version) {
+	case 2:
+		sb->s_time_gran = 1000;
+		sb->s_time_min = 0;
+		sb->s_time_max = U32_MAX;
+		break;
+	case 3:
+		/*
+		 * The VFS shouldn't apply the umask to mode bits.
+		 * We will do so ourselves when necessary.
 		 */
 		sb->s_flags |= SB_POSIXACL;
 		sb->s_time_gran = 1;
-		sb->s_export_op = &nfs_export_ops;
-	} else
-		sb->s_time_gran = 1000;
-
-	if (server->nfs_client->rpc_ops->version != 4) {
 		sb->s_time_min = 0;
 		sb->s_time_max = U32_MAX;
-	} else {
+		sb->s_export_op = &nfs_export_ops;
+		break;
+	case 4:
+		sb->s_flags |= SB_POSIXACL;
+		sb->s_time_gran = 1;
 		sb->s_time_min = S64_MIN;
 		sb->s_time_max = S64_MAX;
+		if (server->caps & NFS_CAP_ATOMIC_OPEN_V1)
+			sb->s_export_op = &nfs_export_ops;
+		break;
 	}
 
 	sb->s_magic = NFS_SUPER_MAGIC;
-- 
2.37.2

