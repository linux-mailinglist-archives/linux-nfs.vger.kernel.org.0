Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136AB79332B
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Sep 2023 03:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjIFBJ7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Sep 2023 21:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjIFBJ6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Sep 2023 21:09:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8807412E
        for <linux-nfs@vger.kernel.org>; Tue,  5 Sep 2023 18:09:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BABC433C8;
        Wed,  6 Sep 2023 01:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693962595;
        bh=wKw6gQKK9jlo9S30mFPrVmy5fk4N7CSE5004vF0J8p8=;
        h=From:To:Cc:Subject:Date:From;
        b=TtVYtHCztZI0NskV43jJvvJ6X98/UoPc4j9ObHSFcGLMWFNx06nO6zGyGbYnMMHPM
         M9FUTMssgSduzsSc6UsZhIoyWVVm+Oo8J2OO5tstWe/M47wrtdMcQhurjQxWpw8sfJ
         rBg65fjgpv+RoPhd3oObxja+2C+NdKRpvJ9pumKmQjxF8IFa21pMrZEk1bI3dTG0TM
         G2dj8rcN5jf26I0ynZJafmeeSZDZyT/X5/KjF0uuQZI6BVnE10t6aY8/WvGqC+sXZ4
         ejKoigJz1h4IN8f9TY7sJ9p+uiCYHIK9okoDCHQa33Uizdi4ju+TSnii5QOM2WSBoF
         tpc5LzFODUjAA==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Russell Cattelan <cattelan@thebarn.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH] Revert "SUNRPC: Fail faster on bad verifier"
Date:   Tue,  5 Sep 2023 21:03:28 -0400
Message-ID: <20230906010328.54634-1-trondmy@kernel.org>
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

This reverts commit 0701214cd6e66585a999b132eb72ae0489beb724.

The premise of this commit was incorrect. There are exactly 2 cases
where rpcauth_checkverf() will return an error:

1) If there was an XDR decode problem (i.e. garbage data).
2) If gss_validate() had a problem verifying the RPCSEC_GSS MIC.

In the second case, there are again 2 subcases:

a) The GSS context expires, in which case gss_validate() will force a
   new context negotiation on retry by invalidating the cred.
b) The sequence number check failed because an RPC call timed out, and
   the client retransmitted the request using a new sequence number,
   as required by RFC2203.

In neither subcase is this a fatal error.

Reported-by: Russell Cattelan <cattelan@thebarn.com>
Fixes: 0701214cd6e6 ("SUNRPC: Fail faster on bad verifier")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 12c46e129db8..5a7de7e55548 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2724,7 +2724,7 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 
 out_verifier:
 	trace_rpc_bad_verifier(task);
-	goto out_err;
+	goto out_garbage;
 
 out_msg_denied:
 	error = -EACCES;
-- 
2.41.0

