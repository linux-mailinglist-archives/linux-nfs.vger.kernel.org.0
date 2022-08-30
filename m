Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3802F5A6EC7
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Aug 2022 22:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiH3U6Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 16:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiH3U6Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 16:58:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49867C755
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 13:58:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 537BF61523
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 20:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F57C433D6;
        Tue, 30 Aug 2022 20:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661893102;
        bh=UKrvKMfofneiORtraDARu8lpHfW10MSnibydaLV64TM=;
        h=From:To:Cc:Subject:Date:From;
        b=sosZDhfJhOpZwmIINNR/SOgH5/lUE/T3VSuqHXoCf0CiOvVz6Q5VibqGueQVeymaK
         Ap8q6OlWgfEv6ZOzhPs1tl4EPSqgBB+/8dzX5bCzGnI3EmfVKd/DKcu1SL7aaAvLCL
         +2fHBp0sn+HuHxNUE3Ut1Z4Oed66wQC6zo2BGXtxLYXtyMrv0tgvSa6t/SCj+JFzCV
         ItH31heXQjGgFyTdtc1eZYYKtqfMYz/rjKMVVE6D8lDdffSMuua/AmKOCKoyn8MJOD
         bmQZsov4fHhbA2btD/n3P/pVIkZWW8+LfmSwWroBuP68y/O7jOmJnFMCokTm1U+3uD
         LCbarSUd3v+KQ==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org, cuiyue-fnst@fujitsu.com
Subject: [PATCH] NFSv4.2: Update mode bits after ALLOCATE and DEALLOCATE
Date:   Tue, 30 Aug 2022 16:58:21 -0400
Message-Id: <20220830205821.641180-1-anna@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

The fallocate call invalidates suid and sgid bits as part of normal
operation. We need to mark the mode bits as invalid when using fallocate
so these will be updated the next time the user looks at them.

This fixes xfstests generic/683 and generic/684.

Reported-by: Yue Cui <cuiyue-fnst@fujitsu.com>
Fixes: 913eca1aea87 ("NFS: Fallocate should use the nfs4_fattr_bitmap")
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 068c45b3bc1a..a1b264b1a09f 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -70,7 +70,7 @@ static int _nfs42_proc_fallocate(struct rpc_message *msg, struct file *filep,
 	}
 
 	nfs4_bitmask_set(bitmask, server->cache_consistency_bitmask, inode,
-			 NFS_INO_INVALID_BLOCKS);
+			 NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_MODE);
 
 	res.falloc_fattr = nfs_alloc_fattr();
 	if (!res.falloc_fattr)
-- 
2.37.2

