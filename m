Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA09791BCD
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Sep 2023 18:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbjIDQ4j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Sep 2023 12:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjIDQ4j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Sep 2023 12:56:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9A9ED
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 09:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF2B56147A
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 16:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B851DC433C8;
        Mon,  4 Sep 2023 16:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693846595;
        bh=xod9DnlEXPQJRk4FQ7h3LSZU7mxwWHPTwfH0vzmYDxI=;
        h=From:To:Cc:Subject:Date:From;
        b=Gm6La8usgb1MpznYxQrcx20Z/kCWDxjbJpmKdgLyTZoPGzcvBmhh1EzEPguVZua2o
         77KaxvwoVkYYdGdYlSZu9JnHMIhTlvaqXaWnybePv8zNr+oZYsZCwUfkX3YnxXD+/f
         APwUmIQoPYBhbMdOUILypZPBFPYbzPy/BgCD8fWF6c4mnWUkrcl0SVH0CIG1aQDvJZ
         udcaAjzciTSNfjVBMM4FlHfPRxxmAV7fZ4QFcXl+sW/NWUX6/YrS5XagLlrzlF6j9U
         H/R58kuU0HLQOoyi1Z4AndBnYRYRDcbvqeWKJ7r1+mjEdQ3xCfE6UcTHqTji6xLzEQ
         IVdoRGtNu2XIA==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Mark the cred for revalidation if the server rejects it
Date:   Mon,  4 Sep 2023 12:50:09 -0400
Message-ID: <20230904165009.12284-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server rejects the credential as being stale, or bad, then we
should mark it for revalidation before retransmitting.

Fixes: 7f5667a5f8c4 ("SUNRPC: Clean up rpc_verify_header()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 943dc3897378..12c46e129db8 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2750,6 +2750,7 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 	case rpc_autherr_rejectedverf:
 	case rpcsec_gsserr_credproblem:
 	case rpcsec_gsserr_ctxproblem:
+		rpcauth_invalcred(task);
 		if (!task->tk_cred_retry)
 			break;
 		task->tk_cred_retry--;
-- 
2.41.0

