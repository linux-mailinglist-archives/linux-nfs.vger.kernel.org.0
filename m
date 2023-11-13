Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7E37E9D7B
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 14:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjKMNnm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 08:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjKMNnm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 08:43:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3DCD44;
        Mon, 13 Nov 2023 05:43:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4ACC433C7;
        Mon, 13 Nov 2023 13:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699883018;
        bh=2ZhG0ZJ8kqHHCB5v6QnlLHzsHUixPCVM1jU13pFdT98=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gSFuiPDCvbiAPNfG8y3+rRx454VNoLaQcxCvablygH1cCuuWcul33lSVrtCyvu8fW
         yplcCQofdjyzTkS9rEsnf7hGRYFb+h4dFNV5Sb6fZXFT5IAM0O+f6ec6zwjFskFkWl
         19q005TLCh+m/sZn8V/41HGA+2I2JwawGjtISvb0FudYjaa8zW56TEc8zJAefyqlTh
         n5dyLulzUrkqdE6AOL2+NGoHJYbM1H+RE1+Hlcn/p+y0VCZbMm/j6XlAskLig/ZIOD
         c2r8vrBEN8Z26f4lE/lKEYicOnANa/tKetGJthHFi8cAd3MxUyao2MotQyiMspw8Ln
         DL9cHfoUuGGfA==
Subject: [PATCH v1 6/7] svcrdma: Move the svcxprt_rdma::sc_pd field
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     tom@talpey.com
Date:   Mon, 13 Nov 2023 08:43:37 -0500
Message-ID: <169988301765.6417.18396957653055937794.stgit@bazille.1015granger.net>
In-Reply-To: <169988267843.6417.17927133323277523958.stgit@bazille.1015granger.net>
References: <169988267843.6417.17927133323277523958.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

It's now used only during transport construction and tear down, so
move it out of the hotter cache lines in struct svcxprt_rdma.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 4ac32895a058..2a22629b6fd0 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -87,8 +87,6 @@ struct svcxprt_rdma {
 	int                  sc_max_req_size;	/* Size of each RQ WR buf */
 	u8		     sc_port_num;
 
-	struct ib_pd         *sc_pd;
-
 	spinlock_t	     sc_send_lock;
 	struct llist_head    sc_send_ctxts;
 	spinlock_t	     sc_rw_ctxt_lock;
@@ -101,6 +99,7 @@ struct svcxprt_rdma {
 	struct ib_qp         *sc_qp;
 	struct ib_cq         *sc_rq_cq;
 	struct ib_cq         *sc_sq_cq;
+	struct ib_pd         *sc_pd;
 
 	spinlock_t	     sc_lock;		/* transport lock */
 


