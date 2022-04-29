Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E0751527F
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Apr 2022 19:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379769AbiD2RqC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 13:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379762AbiD2RqA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 13:46:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1B9D3710
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 10:42:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84499B8376D
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 17:42:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97E2C385A7;
        Fri, 29 Apr 2022 17:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651254158;
        bh=MBQFP4NqrMN0hqGMiSd3JimixdJBn9XsfqOd1NGTQKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rYfmZsoBkwP750VV0FNDPKWzSHgHgwIr28LPrl5fQW20P8XBlO4ySUx72YW/KHrm8
         Hke44B3gthDeRKA7v7LzPhdBWv+NqKtfUqiD6Hbip36vQv0IYerJZMzurgc9yM8/qT
         ZIZFP+bOzA33RP3B7b9eiL9qH2wWl1VgT1Kskev0jAwhkv3PVSgO6FJQ9MptabGXrU
         qjmBlaCopY3xu/fSkkIy+8uDQYzYdYEfgzA0Zpy/z2eEkoFXhGDhJ1ON4wWdPoEn1S
         t+pHeQ0yBJJWumssZVmsC+fa9MXSkawrDXWNeo1YRoAp3Ehmm0wXrrCXMsjhrL9Oeb
         PeTJTqBYNtkEg==
From:   trondmy@kernel.org
To:     "wanghai (M)" <wanghai38@huawei.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/4] Revert "SUNRPC: attempt AF_LOCAL connect on setup"
Date:   Fri, 29 Apr 2022 13:36:29 -0400
Message-Id: <20220429173629.621418-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429173629.621418-3-trondmy@kernel.org>
References: <20220429173629.621418-1-trondmy@kernel.org>
 <20220429173629.621418-2-trondmy@kernel.org>
 <20220429173629.621418-3-trondmy@kernel.org>
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

This reverts commit 7073ea8799a8cf73db60270986f14e4aae20fa80.

We must not try to connect the socket while the transport is under
construction, because the mechanisms to safely tear it down are not in
place.

Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprtsock.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 25b8a8ead56b..650102a9c86a 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2875,9 +2875,6 @@ static struct rpc_xprt *xs_setup_local(struct xprt_create *args)
 		}
 		xprt_set_bound(xprt);
 		xs_format_peer_addresses(xprt, "local", RPCBIND_NETID_LOCAL);
-		ret = ERR_PTR(xs_local_setup_socket(transport));
-		if (ret)
-			goto out_err;
 		break;
 	default:
 		ret = ERR_PTR(-EAFNOSUPPORT);
-- 
2.35.1

