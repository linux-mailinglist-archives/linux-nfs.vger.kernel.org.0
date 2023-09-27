Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AC47AF925
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 06:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjI0ER0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 00:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjI0EQV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 00:16:21 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799365245;
        Tue, 26 Sep 2023 17:16:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c47309a8ccso81804735ad.1;
        Tue, 26 Sep 2023 17:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695773795; x=1696378595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HNJwTTZACq9yLQWS8t+PsblAtdyQNZRiQBfSWneDTAI=;
        b=HOyYLZvZsgGR7Yhfk2SJTVilR1RVXrnU0UrAnyOi6tmSaWCsv0I3m6YiW0uxBkPCUW
         gnzR4iDuK+vuTflEjZtpRpJyrCQZqkhtD5IIPP+6apTQwiyj79REQjq/U0baFiyoIyOG
         8mkUBOht6cqvxtTFaZUH3uDKQ2Qq64OU8NGd4IrMWXrE4JrgwJIvV/rgZXq4RsTvt6hl
         oKmjJDRBtVenNaXffQJ44XQBebex7pnbwfeP+VKXvHkTQ/og/IEBNnDWHc1l0cPKaHkd
         7DTwpgZIxm05ByD/nILLwjSzIaITsKmwJAnpyQCP9OfBGRcPgDQvkrW78Eh1SYLEH1y2
         EnQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695773795; x=1696378595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNJwTTZACq9yLQWS8t+PsblAtdyQNZRiQBfSWneDTAI=;
        b=CwwxR7t29v3HCP/awQUmXFiMx7CU9KpzOZXDfspGTHUNkkk6fR2Yw4DFI8sg7xD894
         Im37PH2zVU9k4WahGoKteozhQMj20ubm3onVV/Iqe7mxSIF01BrXzYEJJXkEv3H5zolk
         R47q8pS+k6gzCVyPLw9MPHwV0d0sqtB0pfhr9DsfswH++fYO6LMku7KnUa1d5ngeJ8BO
         3Pg1z1bSZEdtW8htX57Tr5Hu1FJqnmR7ST5K6jM9oH3S9hln+BSqRkta+A7B6n/9PEJm
         zNIt5jAtFJ0IHcfIVQrnYE0KAjETUjo8TW7UPehqxRwhnyZBn/uG0prg/TQf7ZUvcEnF
         YxYg==
X-Gm-Message-State: AOJu0Ywyt9DJXRAbIdj6GGQw+4U18lk//Kc2AfimotQeVbFbaCjA00HK
        mBFz6ZEqwi6kmi1Myfrkswyw/NBs0o4=
X-Google-Smtp-Source: AGHT+IGEoQ7+A0JA5z0kXlfyTZItPmnp0nZi0UEkm75KmkCl9l0iN9IZ6VcHDazRrrnAKZjflc6YYw==
X-Received: by 2002:a17:902:d2c7:b0:1b7:f64b:379b with SMTP id n7-20020a170902d2c700b001b7f64b379bmr758925plc.17.1695773794758;
        Tue, 26 Sep 2023 17:16:34 -0700 (PDT)
Received: from wheely.local0.net ([203.63.110.121])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902e54500b001b8c6890623sm11703754plf.7.2023.09.26.17.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 17:16:34 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-nfs@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] nfs: reduce stack usage of nfs_get_root
Date:   Wed, 27 Sep 2023 10:16:23 +1000
Message-Id: <20230927001624.750031-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Move fsinfo allocation off stack, reducing stack overhead of
nfs_get_root from 304 to 192 bytes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Hi,

This is motivated by a stack overflow described here:
https://lore.kernel.org/netdev/20230927001308.749910-1-npiggin@gmail.com/

NFS is not really a major culprit but it seems not too hard to
shrink the stack a little.

Thanks,
Nick

 fs/nfs/getroot.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 11ff2b2e060f..6e4188c09639 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -68,7 +68,7 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 {
 	struct nfs_fs_context *ctx = nfs_fc2context(fc);
 	struct nfs_server *server = NFS_SB(s), *clone_server;
-	struct nfs_fsinfo fsinfo;
+	struct nfs_fsinfo *fsinfo;
 	struct dentry *root;
 	struct inode *inode;
 	char *name;
@@ -79,19 +79,23 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 	if (!name)
 		goto out;
 
-	/* get the actual root for this mount */
-	fsinfo.fattr = nfs_alloc_fattr_with_label(server);
-	if (fsinfo.fattr == NULL)
+	fsinfo = kmalloc(sizeof(*fsinfo), GFP_KERNEL);
+	if (!fsinfo)
 		goto out_name;
 
-	error = server->nfs_client->rpc_ops->getroot(server, ctx->mntfh, &fsinfo);
+	/* get the actual root for this mount */
+	fsinfo->fattr = nfs_alloc_fattr_with_label(server);
+	if (fsinfo->fattr == NULL)
+		goto out_fsinfo;
+
+	error = server->nfs_client->rpc_ops->getroot(server, ctx->mntfh, fsinfo);
 	if (error < 0) {
 		dprintk("nfs_get_root: getattr error = %d\n", -error);
 		nfs_errorf(fc, "NFS: Couldn't getattr on root");
 		goto out_fattr;
 	}
 
-	inode = nfs_fhget(s, ctx->mntfh, fsinfo.fattr);
+	inode = nfs_fhget(s, ctx->mntfh, fsinfo->fattr);
 	if (IS_ERR(inode)) {
 		dprintk("nfs_get_root: get root inode failed\n");
 		error = PTR_ERR(inode);
@@ -148,11 +152,13 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		!(kflags_out & SECURITY_LSM_NATIVE_LABELS))
 		server->caps &= ~NFS_CAP_SECURITY_LABEL;
 
-	nfs_setsecurity(inode, fsinfo.fattr);
+	nfs_setsecurity(inode, fsinfo->fattr);
 	error = 0;
 
 out_fattr:
-	nfs_free_fattr(fsinfo.fattr);
+	nfs_free_fattr(fsinfo->fattr);
+out_fsinfo:
+	kfree(fsinfo);
 out_name:
 	kfree(name);
 out:
-- 
2.40.1

