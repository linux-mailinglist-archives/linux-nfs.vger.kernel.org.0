Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CCD72C779
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237329AbjFLOO2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbjFLOOC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:14:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286F810E5
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 07:14:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B66B162218
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 14:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEC3C433A0;
        Mon, 12 Jun 2023 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579239;
        bh=/YH35t8xUhMRFWicEnRfAlCdNTPpL2IxiTw+ukxgcOY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DoUHub86N2U6d37JC7s0nkKu6ztsCWDX6n8V+HtCtmcO2RWjlu+Mul4ULdvnt82Ps
         NnhgessgnLX8to68uApB82JMQbzQxDzJgRx8M49xUqvM2hcVYXCTbSPeW5KPY1Gnsh
         oQeuDmMN4bmLhGTiBxFKlB/Z6Yl2Nwth36TQvRmERRIz22Jg+AmTTgIG5uoKd5C7Ga
         Z91svhJves0SA0vfVwg7siqdF7lLcKtiI/tPAGIuAZ93fzz1lJUBfZIR+kFCVhcD6Q
         t4sdgA86GEJgT0j62p0zzEc7cNjM4tZ2NSHEjpG+GGhVIS7aj7ZfJLFwUL+QELSDlB
         te1ptRuub7liw==
Subject: [PATCH v1 5/7] svcrdma: Remove an unused argument from
 __svc_rdma_put_rw_ctxt()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 12 Jun 2023 10:13:58 -0400
Message-ID: <168657923806.5674.8002278565811410253.stgit@manet.1015granger.net>
In-Reply-To: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
References: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Clean up.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 9836406cc41e..e460e25a1d6d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -84,8 +84,7 @@ svc_rdma_get_rw_ctxt(struct svcxprt_rdma *rdma, unsigned int sges)
 	return NULL;
 }
 
-static void __svc_rdma_put_rw_ctxt(struct svcxprt_rdma *rdma,
-				   struct svc_rdma_rw_ctxt *ctxt,
+static void __svc_rdma_put_rw_ctxt(struct svc_rdma_rw_ctxt *ctxt,
 				   struct llist_head *list)
 {
 	sg_free_table_chained(&ctxt->rw_sg_table, SG_CHUNK_SIZE);
@@ -95,7 +94,7 @@ static void __svc_rdma_put_rw_ctxt(struct svcxprt_rdma *rdma,
 static void svc_rdma_put_rw_ctxt(struct svcxprt_rdma *rdma,
 				 struct svc_rdma_rw_ctxt *ctxt)
 {
-	__svc_rdma_put_rw_ctxt(rdma, ctxt, &rdma->sc_rw_ctxts);
+	__svc_rdma_put_rw_ctxt(ctxt, &rdma->sc_rw_ctxts);
 }
 
 /**
@@ -200,7 +199,7 @@ static void svc_rdma_cc_release(struct svc_rdma_chunk_ctxt *cc,
 		rdma_rw_ctx_destroy(&ctxt->rw_ctx, rdma->sc_qp,
 				    rdma->sc_port_num, ctxt->rw_sg_table.sgl,
 				    ctxt->rw_nents, dir);
-		__svc_rdma_put_rw_ctxt(rdma, ctxt, &free);
+		__svc_rdma_put_rw_ctxt(ctxt, &free);
 
 		ctxt->rw_node.next = first;
 		first = &ctxt->rw_node;


