Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B427A3ED1
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Sep 2023 01:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjIQXd7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 17 Sep 2023 19:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjIQXdj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 17 Sep 2023 19:33:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B3122
        for <linux-nfs@vger.kernel.org>; Sun, 17 Sep 2023 16:33:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C7BC433C8;
        Sun, 17 Sep 2023 23:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694993614;
        bh=9ZW/1zUqL4NYZxB0sxs6I1ioG0W8uf6Z8Kd2Zt0K4gA=;
        h=From:To:Cc:Subject:Date:From;
        b=JRksyBGYlVS+QigMIYvhnmtKW7fWAMHxNj6nv8WrqPxZiCoZbDkhZtglsqGCYyybM
         msvkrlUUOCiZeOVLADqXmRs71yfwQECwFyerOqD6Ff+bD3E1RTDVRQCJ3gmIaN+b7I
         4PHEK8lpgOVr1QQ3dUsdoDTZalYkHqLWR7AREzYjPkFpvSq8ngWfghRZe0sx8WAx86
         tQslonGJks1venugYXow4NbnEzVoRWyNrbLo5JmmUbDF3SVFmuknWlYdp28GyzXLl0
         fFB5RBgBRTP9Ynv78Emwxdl2thmC7rkRMY/mw41vTplVUFe70RXsuWPmpLdGAkqtiB
         pJl7gZ6qbR9wQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>
Subject: [PATCH] Revert "SUNRPC dont update timeout value on connection reset"
Date:   Sun, 17 Sep 2023 19:26:46 -0400
Message-ID: <20230917232646.30810-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

This reverts commit 88428cc4ae7abcc879295fbb19373dd76aad2bdd.

The problem this commit is intended to fix was comprehensively fixed
in commit 7de62bc09fe6 ("SUNRPC dont update timeout value on connection
reset").
Since then, this commit has been preventing the correct timeout of soft
mounted requests.

Cc: stable@vger.kernel.org # 5.9.x: 09252177d5f9: SUNRPC: Handle major timeout in xprt_adjust_timeout()
Cc: stable@vger.kernel.org # 5.9.x: 7de62bc09fe6: SUNRPC dont update timeout value on connection
reset
Cc: stable@vger.kernel.org # 5.9.x
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 5a7de7e55548..7f533c1041a4 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2476,8 +2476,7 @@ call_status(struct rpc_task *task)
 		goto out_exit;
 	}
 	task->tk_action = call_encode;
-	if (status != -ECONNRESET && status != -ECONNABORTED)
-		rpc_check_timeout(task);
+	rpc_check_timeout(task);
 	return;
 out_exit:
 	rpc_call_rpcerror(task, status);
-- 
2.41.0

