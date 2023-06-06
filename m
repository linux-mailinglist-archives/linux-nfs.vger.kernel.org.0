Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD9F724A55
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jun 2023 19:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbjFFRdt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Jun 2023 13:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238712AbjFFRd1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Jun 2023 13:33:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317381707;
        Tue,  6 Jun 2023 10:33:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AABBD6305C;
        Tue,  6 Jun 2023 17:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C336BC433EF;
        Tue,  6 Jun 2023 17:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686072805;
        bh=yXFi2/2FH/2B0iC3mHMSuEHuBGVTQgXcjPnxZDOEOI4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o3t/keUmgg9/Le8Csud8E9LxyZljh0FqYRYc2wXPAuC4ejS5u/HeG47Q+EiZzqWvN
         H8CFHi75H0eSSojaNPZGSCO/fh2bwmaqbVIysvr0zUwnlACwoQ8e+Jl+Te/y11Z6/V
         vBC27MsOUgsj6FFKYsu+Z1ljI96MTJzloNFMW7QUB199UgThGl4gkJn0xLSzqt7qQs
         nGNDZbL0KQ6pwIQI8rAgYhovP8/bKyVenWBiY1jWIVgBzNnC1quFiTqHNR0K0ihfy3
         uCRf9sw1JZUDdR5LMe//y/xJiCYxkhEZAmVRTFbytaaBu9ogYAE183HbTxPCa2O7DA
         3+q6r2dQbmihA==
Subject: [PATCH v1 1/4] SUNRPC: Revert cc93ce9529a6
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        tom@talpey.com
Date:   Tue, 06 Jun 2023 13:33:23 -0400
Message-ID: <168607280379.2076.16904085572327572955.stgit@manet.1015granger.net>
In-Reply-To: <168607259937.2076.15447551371235387735.stgit@manet.1015granger.net>
References: <168607259937.2076.15447551371235387735.stgit@manet.1015granger.net>
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

Pre-requisite for releasing pages in the send completion handler.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index a35d1e055b1a..8e7ccef74207 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -975,11 +975,6 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)
 		goto put_ctxt;
-
-	/* Prevent svc_xprt_release() from releasing the page backing
-	 * rq_res.head[0].iov_base. It's no longer being accessed by
-	 * the I/O device. */
-	rqstp->rq_respages++;
 	return 0;
 
 reply_chunk:


