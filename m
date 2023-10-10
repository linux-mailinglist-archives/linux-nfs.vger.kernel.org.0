Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAED37C027D
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Oct 2023 19:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjJJRXr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Oct 2023 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbjJJRXr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Oct 2023 13:23:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7BCDA;
        Tue, 10 Oct 2023 10:23:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23293C433C7;
        Tue, 10 Oct 2023 17:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696958623;
        bh=9CAHu2Mk7utsjo1uVq4x7O3BUPyqg9XzzYVVLuRXWKI=;
        h=Subject:From:To:Cc:Date:From;
        b=svgTujZUqmjlwchBwyEiBzWxzE3mwZwworDwm/zfqHZRBzD4oExXWWm0LlMaTg39o
         b9Ii4LG0FiaiI9w950IjMMly0vKh6oBB0xZQdkGwXtra2s9saunqK3Fv38LhNAHMlp
         eu60hj+UsQXfRQrxy0c50AE94EubLQlRzctUYV0plCp0BO6u6j4iu/eQNtUYWlfJAm
         6mtZACZk8TN2k3xF1yw2vcrxJSugTT5WWNRN2C3XRGC11j/u1L6iw05H6mY8o+u44x
         Cg6HYoLyEY/BzD90CCplnRmfvB1X1ABVkq3nbdqQL6sznQ2LCINXLEiwTJLGyGQbyD
         kk20+ldL2IJPA==
Subject: [PATCH v1] svcrdma: Drop connection after an RDMA Read error
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Date:   Tue, 10 Oct 2023 13:23:41 -0400
Message-ID: <169695862158.5083.6004887085023503434.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

When an RPC Call message cannot be pulled from the client, that
is a message loss, by definition. Close the connection to trigger
the client to resend.

Cc: <stable@vger.kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 85c8bcaebb80..3b05f90a3e50 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -852,7 +852,8 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	if (ret == -EINVAL)
 		svc_rdma_send_error(rdma_xprt, ctxt, ret);
 	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
-	return ret;
+	svc_xprt_deferred_close(xprt);
+	return -ENOTCONN;
 
 out_backchannel:
 	svc_rdma_handle_bc_reply(rqstp, ctxt);


