Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDD472C723
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbjFLON5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbjFLONz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:13:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39A110E5
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 07:13:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 716DE6270D
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 14:13:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B204DC433D2;
        Mon, 12 Jun 2023 14:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579232;
        bh=qWMIzXwYBmGtfY8D74b1zZ4DZ089LMbGuHNchZCMjzM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ul25cIl4ULi34gSrf9mVUQouFlVH3okNRgimxtlIF6Y3crPiNrT8iYmFc6DA80IfS
         LgujarCh37hIY+Hx0oEiCnneK+cMO8wGrWTOxSMkSoYyYArtsXrsqbmV+EO2QUlHfX
         86EXXz8f9SK9IgLMbXswvpfGoddu5X/x48q9QW5tKkDThctu3cH4gPyTf7RabiWUUp
         vj5us7S1EBKpNE6MQrdTks6DxU/G+FFOU8qwF0JNt9aoQZv/BRvpkz1kmWIIHZS1Jv
         9pnOuzFiFnUNx77FXSb5esij9ZcIdtCc0HQmm+2WAlTp640MckjNaOvRac6L3kFqVA
         0VoRnuUIj6tAw==
Subject: [PATCH v1 4/7] svcrdma: trace cc_release calls
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 12 Jun 2023 10:13:51 -0400
Message-ID: <168657923186.5674.5040517820045674722.stgit@manet.1015granger.net>
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

This event brackets the svcrdma_post_* trace points. If this trace
event is enabled but does not appear as expected, that indicates a
chunk_ctxt leak.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h    |    8 ++++++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c |    2 ++
 2 files changed, 10 insertions(+)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 8f461e04e5f0..f8069ef2ee0f 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -2112,6 +2112,14 @@ DEFINE_POST_CHUNK_EVENT(read);
 DEFINE_POST_CHUNK_EVENT(write);
 DEFINE_POST_CHUNK_EVENT(reply);
 
+DEFINE_EVENT(svcrdma_post_chunk_class, svcrdma_cc_release,
+	TP_PROTO(
+		const struct rpc_rdma_cid *cid,
+		int sqecount
+	),
+	TP_ARGS(cid, sqecount)
+);
+
 TRACE_EVENT(svcrdma_wc_read,
 	TP_PROTO(
 		const struct ib_wc *wc,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 59ea87b5f458..9836406cc41e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -191,6 +191,8 @@ static void svc_rdma_cc_release(struct svc_rdma_chunk_ctxt *cc,
 	struct svc_rdma_rw_ctxt *ctxt;
 	LLIST_HEAD(free);
 
+	trace_svcrdma_cc_release(&cc->cc_cid, cc->cc_sqecount);
+
 	first = last = NULL;
 	while ((ctxt = svc_rdma_next_ctxt(&cc->cc_rwctxts)) != NULL) {
 		list_del(&ctxt->rw_list);


