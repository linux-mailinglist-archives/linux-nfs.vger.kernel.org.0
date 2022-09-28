Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BC45EDD5F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Sep 2022 15:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiI1NBS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Sep 2022 09:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiI1NBH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Sep 2022 09:01:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E73356D7
        for <linux-nfs@vger.kernel.org>; Wed, 28 Sep 2022 06:00:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9E52B8205C
        for <linux-nfs@vger.kernel.org>; Wed, 28 Sep 2022 13:00:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89303C433D6;
        Wed, 28 Sep 2022 13:00:49 +0000 (UTC)
Subject: [PATCH] xprtrdma: Fix uninitialized variable
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 28 Sep 2022 09:00:48 -0400
Message-ID: <166436994381.1453345.6373331467114683829.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

net/sunrpc/xprtrdma/frwr_ops.c:151:32: warning: variable 'rc' is uninitialized when used here [-Wuninitialized]
          trace_xprtrdma_frwr_alloc(mr, rc);
                                        ^~
  net/sunrpc/xprtrdma/frwr_ops.c:127:8: note: initialize the variable 'rc' to silence this warning
          int rc;
                ^
                 = 0
  1 warning generated.

The tracepoint is intended to record the error returned from
ib_alloc_mr(). In the current code there is no other purpose for
@rc, so simply replace it.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 6919549677909c ('xprtrdma: MR-related memory allocation should be allowed to fail')
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Hi Anna-

This is compile-tested only, but should be enough to address the
static checker's complaint properly. Feel free to squash it or
apply it as a separate patch.


diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index ce55361a822f..ffbf99894970 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -124,7 +124,6 @@ int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 	unsigned int depth = ep->re_max_fr_depth;
 	struct scatterlist *sg;
 	struct ib_mr *frmr;
-	int rc;
 
 	sg = kcalloc_node(depth, sizeof(*sg), XPRTRDMA_GFP_FLAGS,
 			  ibdev_to_node(ep->re_id->device));
@@ -148,7 +147,7 @@ int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 
 out_mr_err:
 	kfree(sg);
-	trace_xprtrdma_frwr_alloc(mr, rc);
+	trace_xprtrdma_frwr_alloc(mr, PTR_ERR(frmr));
 	return PTR_ERR(frmr);
 }
 


