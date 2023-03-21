Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C275D6C291C
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Mar 2023 05:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjCUEYM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Mar 2023 00:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCUEYH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Mar 2023 00:24:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A83422DC4
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 21:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB5F261950
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 04:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07874C433D2
        for <linux-nfs@vger.kernel.org>; Tue, 21 Mar 2023 04:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679372643;
        bh=pRV7AebUAEwZbkAWCqwVb+hw31Gu0Dyj/Y4KWr1GG48=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=r6Q3vCX1n3Hfvol2ag7crdHpOKiLmk1lzTF4E4vIBXK+vNtIMrxIrQUfEVz3qPRCg
         OkOTsC8Of2KuhSQSqCHF4QQR8Pvki2dqU957Q0ZPCUSCbfd12YVqIejcnWtMQwT1Dp
         6SVccn++Ed1JlYHLgcHcJAioU/NqPXkxAVFg8GaQagGx5CroIN/lehfEul7HvsoRMy
         K3/21TtWGqyWGpAk+DdfNRifyKThWX2XEqCDlOe+fiLbchHy1MSRskxcx8XZ9hyn8R
         0yUQrIYgTesxZmftVIE5fqkmTsVvUQuA01xlcuudHoYBXCP/tXR+Ru24zEKwerhMgW
         cO6sFRhckJi3Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFSv4: Fix hangs when recovering open state after a server reboot
Date:   Tue, 21 Mar 2023 00:17:36 -0400
Message-Id: <20230321041736.664907-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321041736.664907-1-trondmy@kernel.org>
References: <20230321041736.664907-1-trondmy@kernel.org>
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

When we're using a cached open stateid or a delegation in order to avoid
sending a CLAIM_PREVIOUS open RPC call to the server, we don't have a
new open stateid to present to update_open_stateid().
Instead rely on nfs4_try_open_cached(), just as if we were doing a
normal open.

Fixes: d2bfda2e7aa0 ("NFSv4: don't reprocess cached open CLAIM_PREVIOUS")
Cc: stable@vger.kernel.org
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 22a93ae46cd7..5607b1e2b821 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1980,8 +1980,7 @@ _nfs4_opendata_reclaim_to_nfs4_state(struct nfs4_opendata *data)
 	if (!data->rpc_done) {
 		if (data->rpc_status)
 			return ERR_PTR(data->rpc_status);
-		/* cached opens have already been processed */
-		goto update;
+		return nfs4_try_open_cached(data);
 	}
 
 	ret = nfs_refresh_inode(inode, &data->f_attr);
@@ -1990,7 +1989,7 @@ _nfs4_opendata_reclaim_to_nfs4_state(struct nfs4_opendata *data)
 
 	if (data->o_res.delegation_type != 0)
 		nfs4_opendata_check_deleg(data, state);
-update:
+
 	if (!update_open_stateid(state, &data->o_res.stateid,
 				NULL, data->o_arg.fmode))
 		return ERR_PTR(-EAGAIN);
-- 
2.39.2

