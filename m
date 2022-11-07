Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180E761F702
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Nov 2022 16:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiKGPCn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Nov 2022 10:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiKGPCT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Nov 2022 10:02:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E1B1E73A
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 07:01:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE5966115C
        for <linux-nfs@vger.kernel.org>; Mon,  7 Nov 2022 15:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07A5C433D7;
        Mon,  7 Nov 2022 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667833290;
        bh=aSvWFZv8KSTCg6JwZXDrYglWdtO3jW/gkVoabDC1zzc=;
        h=From:To:Cc:Subject:Date:From;
        b=BSGGvVTLCyT7zi3cpk/+dTyhmxvqbO1TJJpMGpZN8FY2wo23UxiJzAqUwl/Dgzx1g
         EyRfzq4yY7QsDbqkcJr27Y6ZwJOl1+/RcW0ksJJm6kC+l7ajz3Sb5pk8GQDKCskoCI
         UuCdZq6c3k3Ek6tYHklwORNMCnY3+HDERimNOffSPZEdDrCjtJPYAEUBWrCqpJyjTK
         /TEiNQL07oJSG3sp+ScygvLB/ZrAGPr7YGJCTVCDiQRTWSh9QZbGWyM+txS/uM9xz+
         LdRXX18PP8Ig1jQLLMb/vgErtgGA1aFjlAGWKMVqWMnLplSlP1QUMTY0Xkmk+vmMlP
         0xPi2TNgUDU3w==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: queue laundrette to filecache_wq instead of system_wq
Date:   Mon,  7 Nov 2022 10:01:28 -0500
Message-Id: <20221107150128.46951-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
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

nfsd has grown a dedicated workqueue for the filecache, but this job is
still queued to the system_wq. Change it to use the filecache_wq.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 1e76b0d3b83a..018fd1565193 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -212,7 +212,7 @@ static void
 nfsd_file_schedule_laundrette(void)
 {
 	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
-		queue_delayed_work(system_wq, &nfsd_filecache_laundrette,
+		queue_delayed_work(nfsd_filecache_wq, &nfsd_filecache_laundrette,
 				   NFSD_LAUNDRETTE_DELAY);
 }
 
-- 
2.38.1

