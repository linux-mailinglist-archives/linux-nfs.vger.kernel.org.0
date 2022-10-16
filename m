Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5576002F2
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Oct 2022 20:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiJPSvG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Oct 2022 14:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiJPSvF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Oct 2022 14:51:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074FD31369
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 11:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB8BEB80D2F
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 18:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D1AC433C1;
        Sun, 16 Oct 2022 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665946261;
        bh=R+pbfQYQg9KAfOO2B8frGp5NhKlHbUIMaSxfrz1yx0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDhDOp6b7PLwVOCweC+A4/GyPe5HMGpwCiHt66lNlIhO3RZczlWzx1byXbZLUaGMP
         pwUtmtAcgbfO/p9hotTa8MYS7/GGiodTH4imaxnJs6OCkRZd1dx0U4glOtxFT3oxuK
         3IPgn5XCCpyLX6iqOLPuEpNPBxa7lquyiUCqpo4/czAUalz7uqF2DfCcu7p8362ixs
         ZMzEFSYl0a1HzPQvFoakSkjd2WC2NGOxNITCvb7QGDm71LVhurCqVLaLlPG1ddY+y/
         C5O17luLIXbzI1hkFINHd6Ol12NZPH4Fdbz8ETH7bkWD5gl/kxa/MOlMezcyi/6TxK
         U/LAEPDezmRag==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] NFSv4.1: We must always send RECLAIM_COMPLETE after a reboot
Date:   Sun, 16 Oct 2022 14:44:33 -0400
Message-Id: <20221016184433.31213-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221016184433.31213-2-trondmy@kernel.org>
References: <20221016184433.31213-1-trondmy@kernel.org>
 <20221016184433.31213-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Currently, we are only guaranteed to send RECLAIM_COMPLETE if we have
open state to recover. Fix the client to always send RECLAIM_COMPLETE
after setting up the lease.

Fixes: fce5c838e133 ("nfs41: RECLAIM_COMPLETE functionality")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 0b6bd6336c98..a629d7db9420 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -1787,6 +1787,7 @@ static void nfs4_state_mark_reclaim_helper(struct nfs_client *clp,
 
 static void nfs4_state_start_reclaim_reboot(struct nfs_client *clp)
 {
+	set_bit(NFS4CLNT_RECLAIM_REBOOT, &clp->cl_state);
 	/* Mark all delegations for reclaim */
 	nfs_delegation_mark_reclaim(clp);
 	nfs4_state_mark_reclaim_helper(clp, nfs4_state_mark_reclaim_reboot);
-- 
2.37.3

