Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B2B4D771A
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiCMRNP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbiCMRNN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C834E139CDA
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4D06121F
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15340C340E8
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191525;
        bh=AkViboMthu16I6ccMD5EDxf5c/hBYqowBXD+650a51k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YpWpw36zEyfmFpg0aVRJR8E6TpLX9LwJn7ZkI+rccs1Fa12vMAJvd0fWg01/iOqGu
         S0GbEYa3EUJ7chH9RkkPCmvyf7BvDdUgLHrOS6yb9xWHwdlxbVM4q3037vLcIfTAT5
         mh+msWtfHHXjRF2tmMlm+RX9Xxx/snqSKNYBTjMGt+I9+7ms69R3jelllqDv1Dgixz
         J36SsNU+mCR5MYg5cYwnJXRUVEBRo0zzwz3TLfLEObtDvO+0NGIY23tcBhqgT33WOV
         L3oagvzbKv6RrN1LFb4LvPQtReFxhT6eLDpb7Vt07fmv+FNXYFRIbPeepIu145jmI7
         47GzY0yCvUu/Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 04/26] NFS: Initialise the readdir verifier as best we can in nfs_opendir()
Date:   Sun, 13 Mar 2022 13:05:35 -0400
Message-Id: <20220313170557.5940-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-4-trondmy@kernel.org>
References: <20220313170557.5940-1-trondmy@kernel.org>
 <20220313170557.5940-2-trondmy@kernel.org>
 <20220313170557.5940-3-trondmy@kernel.org>
 <20220313170557.5940-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

