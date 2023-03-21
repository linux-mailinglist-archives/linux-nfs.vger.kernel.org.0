Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDE46C291B
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 05:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjCUEYJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 00:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCUEYH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 00:24:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DD41E1DB
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 21:24:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69D096195C
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 04:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DA4C433EF
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 04:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679372642;
        bh=RZHxzMFk3EtMnXpRGT1NVWDjq3WF3r290yTVx5kX+Ck=;
        h=From:To:Subject:Date:From;
        b=EHPliABQexT+EyoA4Ui1tU+EmYYj2c7lLxNndPASx0J0eBlZqa3Duonb8lZJwfkiM
         wxV57FndQTkBumSoE63H3VoffpV9hu96sVndhvfxywfxW5Yp06KCx10n4BF5+CpiyL
         tPJhwZjq3rrMZoIhUSTzmviVz1KL8f0qA5aQmxnIN3c8E2S0TW6LXz33eL1kEZn9JR
         ht0gySUhRKz2wZLWRigpciN1ECI4PRxUwKlk+wwgREXzUpTBhTLgv01GgwnNwPXGwR
         +0k1xPDh91R0L0oiE2XSE1wlRSdDxVQg0qo+xZkmMflkFhydNqQOM2cyBxS6fTTjUT
         QgXphf74RmLHQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFSv4.1: Always send a RECLAIM_COMPLETE after establishing lease
Date:   Tue, 21 Mar 2023 00:17:35 -0400
Message-Id: <20230321041736.664907-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The spec requires that we always at least send a RECLAIM_COMPLETE when
we're done establishing the lease and recovering any state.

Fixes: fce5c838e133 ("nfs41: RECLAIM_COMPLETE functionality")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4state.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 2a0ca5c7f082..660ccfaf463e 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -67,6 +67,8 @@
 
 #define OPENOWNER_POOL_SIZE	8
 
+static void nfs4_state_start_reclaim_reboot(struct nfs_client *clp);
+
 const nfs4_stateid zero_stateid = {
 	{ .data = { 0 } },
 	.type = NFS4_SPECIAL_STATEID_TYPE,
@@ -330,6 +332,8 @@ int nfs41_init_clientid(struct nfs_client *clp, const struct cred *cred)
 	status = nfs4_proc_create_session(clp, cred);
 	if (status != 0)
 		goto out;
+	if (!(clp->cl_exchange_flags & EXCHGID4_FLAG_CONFIRMED_R))
+		nfs4_state_start_reclaim_reboot(clp);
 	nfs41_finish_session_reset(clp);
 	nfs_mark_client_ready(clp, NFS_CS_READY);
 out:
-- 
2.39.2

