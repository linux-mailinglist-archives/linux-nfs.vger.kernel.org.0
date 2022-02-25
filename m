Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4CE4C4DE7
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbiBYSfS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiBYSfP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417F41A9048
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0B54B8330C
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424EBC340F3
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814077;
        bh=AkViboMthu16I6ccMD5EDxf5c/hBYqowBXD+650a51k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ceUw4d2NfcCE8i42+DVJ0EdK9vygVYdk7PC0VEmOujurlSNFkrRHm0UknAOLyhxKT
         SPnohJ1qh/dwBa5NjaBVo5QX9HfcDNLnm1C2hj9OGU/9XJ4Gv58voB3Y7vuTt/sR5Z
         5rXG3gOWqxrZDYOE8NgPm85PFxmvCRz1Te76YDfi4D6RR8RqSyQm7A/mfJIFuqcvba
         KrC5Ir2QyqQXpsbWMbuw7TjRcGSuF2MPnIKBnTLIlg+Gr+myuTNSoOwhOHfOld+nQH
         PX1EcIdAPhkEZVvWfWRQXiPQhs2RH5XsdeEiZArrfRVkCc82z+K3sj11TqlMbF+1MJ
         9do1sK2UgKy5Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 04/24] NFS: Initialise the readdir verifier as best we can in nfs_opendir()
Date:   Fri, 25 Feb 2022 13:28:09 -0500
Message-Id: <20220225182829.1236093-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-4-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
 <20220225182829.1236093-3-trondmy@kernel.org>
 <20220225182829.1236093-4-trondmy@kernel.org>
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

