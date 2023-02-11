Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C630693118
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Feb 2023 13:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjBKMuQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 11 Feb 2023 07:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjBKMuP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 11 Feb 2023 07:50:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118FE6EB2
        for <linux-nfs@vger.kernel.org>; Sat, 11 Feb 2023 04:50:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC59DB80968
        for <linux-nfs@vger.kernel.org>; Sat, 11 Feb 2023 12:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DC5C433EF;
        Sat, 11 Feb 2023 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676119810;
        bh=WQqmAK7ebWAR+nzkvUbmG99mnF0Gkf1Oddk5mPaGEY0=;
        h=From:To:Cc:Subject:Date:From;
        b=oZMPmy4anCLODgfMJkvs5jagJc9Yqg9NbGe84utuF3BKOmnm2c3tmjVWu3fTFo7jH
         EMS/e3yQvchDG3ItGCwYkE0ALBw0lJW3aLimUBGKh3znw0rwszcmoeBe8WGHga0S9z
         Pyqe+nXzBpQ1TYpzfw1n02zCy01Yb40QpFO6D4HM5Sn4p/3wowzWGIPi3HthkbKaRn
         AEFiLrDVCDUgj9yBQfPS74y+nSCNdPl2QF7unNJF/M1EvHeC9qWj5R/j7U5I4SzYwq
         Iq8mXj6SAsyO/xgc143qfIW3ouCMUc/UdyjVM0BtWK2AYk1TUR9e4LNLhHS5LgBt3D
         P3eq4PqcxGLpg==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, JianHong Yin <jiyin@redhat.com>
Subject: [PATCH] nfsd: don't destroy global nfs4_file table in per-net shutdown
Date:   Sat, 11 Feb 2023 07:50:08 -0500
Message-Id: <20230211125008.21145-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.1
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

The nfs4_file table is global, so shutting it down when a containerized
nfsd is shut down is wrong and can lead to double-frees. Tear down the
nfs4_file_rhltable in nfs4_state_shutdown instead of
nfs4_state_shutdown_net.

Fixes: d47b295e8d76 (NFSD: Use rhashtable for managing nfs4_file objects)
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2169017
Reported-by: JianHong Yin <jiyin@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index af22dfdc6fcc..a202be19f26f 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8218,7 +8218,6 @@ nfs4_state_shutdown_net(struct net *net)
 
 	nfsd4_client_tracking_exit(net);
 	nfs4_state_destroy_net(net);
-	rhltable_destroy(&nfs4_file_rhltable);
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	nfsd4_ssc_shutdown_umount(nn);
 #endif
@@ -8228,6 +8227,7 @@ void
 nfs4_state_shutdown(void)
 {
 	nfsd4_destroy_callback_queue();
+	rhltable_destroy(&nfs4_file_rhltable);
 }
 
 static void
-- 
2.39.1

