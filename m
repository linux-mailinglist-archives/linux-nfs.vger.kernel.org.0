Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51CD654361
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Dec 2022 15:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLVOvh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 22 Dec 2022 09:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbiLVOvf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 22 Dec 2022 09:51:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7B018B06
        for <linux-nfs@vger.kernel.org>; Thu, 22 Dec 2022 06:51:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D33A761BDC
        for <linux-nfs@vger.kernel.org>; Thu, 22 Dec 2022 14:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD486C433D2;
        Thu, 22 Dec 2022 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671720692;
        bh=5UKePlQ28zK0k4fEWX/DaO1pYgsfFwUpHMYTw+XsNd0=;
        h=From:To:Cc:Subject:Date:From;
        b=U31NrShaKe9GMFMpIVb5Ylj9adrGCx8hXzg4tMP6RvkrFzSq1NEYDe2gp3FNT7mxU
         3U4ft9OuEpQqkoRK7hj9yWzwkS3mILnVM7CDgCNglSowN7V6Qa9WpSLNJqv3CjWwYk
         avYNdHJ3ljFh5hjlbaiLn1mAPN/YMQYUlGazSgQqICCUfuFFiSEvvDde2hMbGaALsi
         S91NAR4dRLLHPOh02TMb/v4lkDlLliw/ARHvioBHNRVnSpHSK3R39cW46+XociRKzH
         j3tiRax9TdhqrbnFyyQ0GTic4GX+WhTa6SHaU6Mis4PWfFOof/uYuHEzmSTUNTrxVx
         BgdB3n8aEyUsA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] nfsd: shut down the NFSv4 state objects before the filecache
Date:   Thu, 22 Dec 2022 09:51:30 -0500
Message-Id: <20221222145130.162341-1-jlayton@kernel.org>
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

Currently, we shut down the filecache before trying to clean up the
stateids that depend on it. This leads to the kernel trying to free an
nfsd_file twice, and a refcount overput on the nf_mark.

Change the shutdown procedure to tear down all of the stateids prior
to shutting down the filecache.

Reported-and-Tested-by: Wang Yugui <wangyugui@e16-tech.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfssvc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 56fba1cba3af..325d3d3f1211 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -453,8 +453,8 @@ static void nfsd_shutdown_net(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	nfsd_file_cache_shutdown_net(net);
 	nfs4_state_shutdown_net(net);
+	nfsd_file_cache_shutdown_net(net);
 	if (nn->lockd_up) {
 		lockd_down(net);
 		nn->lockd_up = false;
-- 
2.38.1

