Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00AA6002F0
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Oct 2022 20:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJPSvF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 16 Oct 2022 14:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiJPSvE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 16 Oct 2022 14:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6DA30558
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 11:51:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6719160DDA
        for <linux-nfs@vger.kernel.org>; Sun, 16 Oct 2022 18:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4F3C433D7;
        Sun, 16 Oct 2022 18:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665946260;
        bh=FTwWdeomchW2unazJbYEhesPI8PTu6bcrsyOv/lR+hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVaV01NEjUHV5VZzMqUQmELNZvxKyHfvIQeOGgIh5sYpZCVSHImZpqRIXrglFBmd3
         ltlSkLhV4H6woosqmt2LrSnwcwHiV675F5Own8rSbKDLQQpFH5Bc7MQVOnHknW6nZy
         HkHuExzren4oQpYhe8HQyoIAV8cofogR26UO9hYgio+G+r6YWaY4u+FIphzrqlL5pt
         hLS3d+HcSaxuKqOUTzSh5kv/4njLOh43ZD1Ai5xQpSTvGT2BXiz6rq/Zf+EOgMOrfO
         xkR3CD0Av/xzbjmXFtam4nD9wzmN6jSm1q9+DLb+MMt65c/BTA7i9ELnqc2GvnauKc
         k/dLy4+fv7cdA==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFSv4.1: Handle RECLAIM_COMPLETE trunking errors
Date:   Sun, 16 Oct 2022 14:44:32 -0400
Message-Id: <20221016184433.31213-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221016184433.31213-1-trondmy@kernel.org>
References: <20221016184433.31213-1-trondmy@kernel.org>
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

If RECLAIM_COMPLETE sets the NFS4CLNT_BIND_CONN_TO_SESSION flag, then we
need to loop back in order to handle it.

Fixes: 0048fdd06614 ("NFSv4.1: RECLAIM_COMPLETE must handle NFS4ERR_CONN_NOT_BOUND_TO_SESSION")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4state.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 9bab3e9c702a..0b6bd6336c98 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -2671,6 +2671,7 @@ static void nfs4_state_manager(struct nfs_client *clp)
 			if (status < 0)
 				goto out_error;
 			nfs4_state_end_reclaim_reboot(clp);
+			continue;
 		}
 
 		/* Detect expired delegations... */
-- 
2.37.3

