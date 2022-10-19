Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129F6604F17
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Oct 2022 19:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiJSRnp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Oct 2022 13:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiJSRno (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Oct 2022 13:43:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4351C5A63
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 10:43:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A652961978
        for <linux-nfs@vger.kernel.org>; Wed, 19 Oct 2022 17:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3EFC43470;
        Wed, 19 Oct 2022 17:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666201420;
        bh=7lDpbBXJKkNTE1Dc1QHMNBNj9/EJ8YDwHvd2BCTRqwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=auqUq2ojBx3uZi70dV5FTNx0Dq8wJQ8t89Z8LDatq/MTvijpgXqlJRVyYABHk6tRs
         Rfgq+ey8eCOFnqhr1Ti3UAZAi5yMwomxQw/ANJ9IsJ908k2g+0FFJZeFRR6SG3aT0I
         YKCFiqbQ6aBW6pL+rp/x1N1qc0B2NhRq15zVOGXuCQaieQieNK6yJsfSRLVq661hoG
         FdQXBBq2tRn+/pGBvcxnj2/89vOsEHHTpGC1Ie6oU9RdsIVkKhHFHuBUGDAnPTMOsL
         C88Y2SuprAPPNkvsrA4W+YrQGRnEVaakexPjfo4G8mtV/KH8YcJnSTtAh31gPHRCTV
         bi9pqRb+DPeYw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/4] NFSv4.2: Fix initialisation of struct nfs4_label
Date:   Wed, 19 Oct 2022 13:36:51 -0400
Message-Id: <20221019173651.32096-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019173651.32096-3-trondmy@kernel.org>
References: <20221019173651.32096-1-trondmy@kernel.org>
 <20221019173651.32096-2-trondmy@kernel.org>
 <20221019173651.32096-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The call to nfs4_label_init_security() should return a fully initialised
label.

Fixes: aa9c2669626c ("NFS: Client implementation of Labeled-NFS")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3ed14a2a84a4..0ae48498c174 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -122,6 +122,11 @@ nfs4_label_init_security(struct inode *dir, struct dentry *dentry,
 	if (nfs_server_capable(dir, NFS_CAP_SECURITY_LABEL) == 0)
 		return NULL;
 
+	label->lfs = 0;
+	label->pi = 0;
+	label->len = 0;
+	label->label = NULL;
+
 	err = security_dentry_init_security(dentry, sattr->ia_mode,
 				&dentry->d_name, NULL,
 				(void **)&label->label, &label->len);
@@ -3795,7 +3800,7 @@ nfs4_atomic_open(struct inode *dir, struct nfs_open_context *ctx,
 		int open_flags, struct iattr *attr, int *opened)
 {
 	struct nfs4_state *state;
-	struct nfs4_label l = {0, 0, 0, NULL}, *label = NULL;
+	struct nfs4_label l, *label;
 
 	label = nfs4_label_init_security(dir, ctx->dentry, attr, &l);
 
@@ -4681,7 +4686,7 @@ nfs4_proc_create(struct inode *dir, struct dentry *dentry, struct iattr *sattr,
 		 int flags)
 {
 	struct nfs_server *server = NFS_SERVER(dir);
-	struct nfs4_label l, *ilabel = NULL;
+	struct nfs4_label l, *ilabel;
 	struct nfs_open_context *ctx;
 	struct nfs4_state *state;
 	int status = 0;
@@ -5032,7 +5037,7 @@ static int nfs4_proc_symlink(struct inode *dir, struct dentry *dentry,
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
-	struct nfs4_label l, *label = NULL;
+	struct nfs4_label l, *label;
 	int err;
 
 	label = nfs4_label_init_security(dir, dentry, sattr, &l);
@@ -5073,7 +5078,7 @@ static int nfs4_proc_mkdir(struct inode *dir, struct dentry *dentry,
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
-	struct nfs4_label l, *label = NULL;
+	struct nfs4_label l, *label;
 	int err;
 
 	label = nfs4_label_init_security(dir, dentry, sattr, &l);
@@ -5192,7 +5197,7 @@ static int nfs4_proc_mknod(struct inode *dir, struct dentry *dentry,
 	struct nfs4_exception exception = {
 		.interruptible = true,
 	};
-	struct nfs4_label l, *label = NULL;
+	struct nfs4_label l, *label;
 	int err;
 
 	label = nfs4_label_init_security(dir, dentry, sattr, &l);
-- 
2.37.3

