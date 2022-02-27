Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5934C5FCB
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbiB0XTQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbiB0XTP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C869E22522
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED221611CE
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCC1C340F0
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003915;
        bh=AkViboMthu16I6ccMD5EDxf5c/hBYqowBXD+650a51k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MiU+lmXq40EdFkrczqnmW3Wv+MJg/IkMYZpPOY9UoYFTC96XXrvyinQCB0BS5nyRn
         eHn+2WSDWgAJB/cv8fkJKoGloNgJDHeDfmwdLtBkNRSnUxTHfoq0Jz1LK+XauQc3L1
         +g4F7HciG0tQaR59hH+are44JBlQNnUIVIvcX+juyyzxkXUnmJZbObSsnSM3vQTd3M
         BsFAXYpzD6FG+sMrjuMRrNR8aRGncJz+cMYOnnnDVuZYdrxXj5hyG8Mh+Wd9mXqHqE
         m6qp6Qj/memDyeW7NeKNjdSQXSKnCnm9jzh+okBe3M+u0pz9RbNKGMF9vNpt93WvD7
         ur9wpDOk2Zhlw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 04/27] NFS: Initialise the readdir verifier as best we can in nfs_opendir()
Date:   Sun, 27 Feb 2022 18:12:04 -0500
Message-Id: <20220227231227.9038-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-4-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

For the purpose of ensuring that opendir() followed by seekdir() work as
correctly as possible, try to initialise the readdir verifier in
nfs_opendir().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 1aa55cac9d9a..1dfbd05081ad 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -89,6 +89,7 @@ static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir
 						      NFS_INO_REVAL_FORCED);
 		list_add(&ctx->list, &nfsi->open_files);
 		clear_bit(NFS_INO_FORCE_READDIR, &nfsi->flags);
+		memcpy(ctx->verf, nfsi->cookieverf, sizeof(ctx->verf));
 		spin_unlock(&dir->i_lock);
 		return ctx;
 	}
-- 
2.35.1

