Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B124E35EA
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 02:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiCVBXz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 21:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiCVBXy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 21:23:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFD4289BC
        for <linux-nfs@vger.kernel.org>; Mon, 21 Mar 2022 18:22:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50C87615E1
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 01:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A852C340F2;
        Tue, 22 Mar 2022 01:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647912146;
        bh=t/mlxztyxuPpL7atLJv6aKFd6EHiGTobdIHMn4ysQIU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rXH+CbFk4b8dW5ck0H8clQdF80O2umrC77b0xkWZMrgwaU9w6DpgUJklBL+6HmxVM
         LfssBO6kIWQJU4eg5t3BRXXZ9jvQWHABPmvb/DnPsCEpQ4CNjbESwLvHA6h4m5gpzE
         4AxvVg2282nze0SkftB9RzWlT9fe3nkFscFuS2JcoKkvnBP5FYnPPXy/jSFk05zAEH
         dMcPik2A+ChxkJ63mkcqZM4oOOC49yFZx6PUWK8C8GzKtta3/bPoSE396aIHZzCca+
         Irv4w2khkXMsLIRQc2dVKIECA7v2VrCDAjmRJIxrtSsq4C3PP6QP2ZqyT47CiqxLfp
         LYWakWDGkx96Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>
Subject: [PATCH v2 3/9] SUNRPC: Fix unx_lookup_cred() allocation
Date:   Mon, 21 Mar 2022 21:16:12 -0400
Message-Id: <20220322011618.1052288-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322011618.1052288-3-trondmy@kernel.org>
References: <20220322011618.1052288-1-trondmy@kernel.org>
 <20220322011618.1052288-2-trondmy@kernel.org>
 <20220322011618.1052288-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Default to the same mempool allocation strategy as for rpc_malloc().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/auth_unix.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/auth_unix.c b/net/sunrpc/auth_unix.c
index c629d366030e..1e091d3fa607 100644
--- a/net/sunrpc/auth_unix.c
+++ b/net/sunrpc/auth_unix.c
@@ -40,17 +40,19 @@ unx_destroy(struct rpc_auth *auth)
 /*
  * Lookup AUTH_UNIX creds for current process
  */
-static struct rpc_cred *
-unx_lookup_cred(struct rpc_auth *auth, struct auth_cred *acred, int flags)
+static struct rpc_cred *unx_lookup_cred(struct rpc_auth *auth,
+					struct auth_cred *acred, int flags)
 {
-	gfp_t gfp = GFP_KERNEL;
 	struct rpc_cred *ret;
 
-	if (flags & RPCAUTH_LOOKUP_ASYNC)
-		gfp = GFP_NOWAIT | __GFP_NOWARN;
-	ret = mempool_alloc(unix_pool, gfp);
-	if (!ret)
-		return ERR_PTR(-ENOMEM);
+	ret = kmalloc(sizeof(*ret), rpc_task_gfp_mask());
+	if (!ret) {
+		if (!(flags & RPCAUTH_LOOKUP_ASYNC))
+			return ERR_PTR(-ENOMEM);
+		ret = mempool_alloc(unix_pool, GFP_NOWAIT);
+		if (!ret)
+			return ERR_PTR(-ENOMEM);
+	}
 	rpcauth_init_cred(ret, acred, auth, &unix_credops);
 	ret->cr_flags = 1UL << RPCAUTH_CRED_UPTODATE;
 	return ret;
-- 
2.35.1

