Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B83781BA9
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Aug 2023 02:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjHTAWQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Aug 2023 20:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjHTAVk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Aug 2023 20:21:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19D7E1C08
        for <linux-nfs@vger.kernel.org>; Sat, 19 Aug 2023 14:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43F35619E1
        for <linux-nfs@vger.kernel.org>; Sat, 19 Aug 2023 21:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1A7C433C9;
        Sat, 19 Aug 2023 21:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692481155;
        bh=8Vg7YLpqSpUemOlkTUZSjO5s6OVfvObnyW4C4J4K9zM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wuw+BC7BBBAJaaoeryuAPOFxnYPHMcQNUorGda//lmGkV8sD+Hp91iiM6c2/d5Ysl
         S71RRjTNZ8mieEyzGb7D2aeU7SvH+/Q+YVJo18kMNBEbQNikt0LE5wFZQ1xFE8j2MS
         9p5fyEKCPL2J1AH9pSWBL7WcCcmICbzJEm8Dmo60WuTg7bSyS5xTFD5nGag5ZRcSIu
         TQKQ1XKRvbVou/DmBoQPViUJpM1VKc81qO9fh+HmCzh5akSdu3CxfAAepA0kXFMyEW
         qFxnFbYLIgcamPJ4X87fm/TH+UAB1qNdkg8epdRCCXpZMW8V78C/VbmxerZVgdrcTZ
         1jD8JSw68Mgeg==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/5] SUNRPC: Don't override connect timeouts in rpc_clnt_add_xprt()
Date:   Sat, 19 Aug 2023 17:32:24 -0400
Message-ID: <20230819213225.731214-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230819213225.731214-4-trondmy@kernel.org>
References: <20230819213225.731214-1-trondmy@kernel.org>
 <20230819213225.731214-2-trondmy@kernel.org>
 <20230819213225.731214-3-trondmy@kernel.org>
 <20230819213225.731214-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the caller specifies the connect timeouts in the arguments to
rpc_clnt_add_xprt(), then we shouldn't override them.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 9edebfdb5ce1..943dc3897378 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -3071,6 +3071,11 @@ int rpc_clnt_add_xprt(struct rpc_clnt *clnt,
 	}
 	xprt->resvport = resvport;
 	xprt->reuseport = reuseport;
+
+	if (xprtargs->connect_timeout)
+		connect_timeout = xprtargs->connect_timeout;
+	if (xprtargs->reconnect_timeout)
+		reconnect_timeout = xprtargs->reconnect_timeout;
 	if (xprt->ops->set_connect_timeout != NULL)
 		xprt->ops->set_connect_timeout(xprt,
 				connect_timeout,
-- 
2.41.0

