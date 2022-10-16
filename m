Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB916000DA
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Oct 2022 17:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJPPrC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Oct 2022 11:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJPPq7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Oct 2022 11:46:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBEA33863
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 08:46:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4E3B60BA8
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 15:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28357C433D6
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 15:46:57 +0000 (UTC)
Subject: [PATCH 1 1/3] SUNRPC: Remove unused svc_rqst::rq_lock field
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 16 Oct 2022 11:46:56 -0400
Message-ID: <166593521604.1710.10648202421284171508.stgit@klimt.1015granger.net>
User-Agent: StGit/1.5.dev3+g9561319
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

Clean up after commit 22700f3c6df5 ("SUNRPC: Improve ordering of
transport processing").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h |    1 -
 net/sunrpc/svc.c           |    1 -
 2 files changed, 2 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index daecb009c05b..3b59eb9cf884 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -311,7 +311,6 @@ struct svc_rqst {
 	struct auth_domain *	rq_gssclient;	/* "gss/"-style peer info */
 	struct svc_cacherep *	rq_cacherep;	/* cache info */
 	struct task_struct	*rq_task;	/* service thread */
-	spinlock_t		rq_lock;	/* per-request lock */
 	struct net		*rq_bc_net;	/* pointer to backchannel's
 						 * net namespace
 						 */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 7c9a0d0b1230..d2bb1d04c524 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -638,7 +638,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 		return rqstp;
 
 	__set_bit(RQ_BUSY, &rqstp->rq_flags);
-	spin_lock_init(&rqstp->rq_lock);
 	rqstp->rq_server = serv;
 	rqstp->rq_pool = pool;
 


