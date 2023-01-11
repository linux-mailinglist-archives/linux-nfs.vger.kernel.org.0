Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134ED666053
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 17:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239217AbjAKQYH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 11:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239578AbjAKQXj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 11:23:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C7BC46
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 08:20:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A762CB81C65
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 16:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B53C433D2;
        Wed, 11 Jan 2023 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673454001;
        bh=bcBxRUM+9vXfPZmlXC4TozlRy45S2JNqEJfkCx++vGk=;
        h=From:To:Cc:Subject:Date:From;
        b=EquC6vLSjxAyy3Cf6x9sOpIcGdEGHIdAeLVci3VF6r9dL0ZBcfhig0pwrs2A8BmHo
         JoA1Fwn+/7TN0H/h1+hBMq226ov0YHh/WQAEZDkHhypoC1KoXPzxLmV944S9GshN0o
         Nu2K+5Ehn0TGKS/iijYL6kslObpNS77VEBizQG9d63OaZuEjXIc9kK8+eEVsly0l/q
         KFt4EyA3PRb5g+rCaPtOOCfwfzNFwGy2E2l/laNdMFgl2hAh0G0eoQMD9Z2oJFUhS+
         9us/c5y+zCIj4OIHSvvsxtS1fKSB+M/MzUA+M5xF2FBXcZvMlYreOIqJzmMcI7vRmW
         rinTgrJv+tO6w==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, Dai Ngo <dai.ngo@oracle.com>
Subject: [PATCH] nfsd: move reply cache initialization into nfsd startup
Date:   Wed, 11 Jan 2023 11:19:59 -0500
Message-Id: <20230111161959.178472-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.0
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

There's no need to start the reply cache before nfsd is up and running,
and doing so means that we register a shrinker for every net namespace
instead of just the ones where nfsd is running.

Move it to the per-net nfsd startup instead.

Reported-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c |  8 --------
 fs/nfsd/nfssvc.c | 10 +++++++++-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index c2577ee7ffb2..f2a0d6ac88df 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1458,16 +1458,11 @@ static __net_init int nfsd_init_net(struct net *net)
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
-	retval = nfsd_reply_cache_init(nn);
-	if (retval)
-		goto out_cache_error;
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
 
 	return 0;
 
-out_cache_error:
-	nfsd_idmap_shutdown(net);
 out_idmap_error:
 	nfsd_export_shutdown(net);
 out_export_error:
@@ -1476,9 +1471,6 @@ static __net_init int nfsd_init_net(struct net *net)
 
 static __net_exit void nfsd_exit_net(struct net *net)
 {
-	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-
-	nfsd_reply_cache_shutdown(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index ff10c46b62d3..fe5e4f73bb98 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -427,16 +427,23 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	ret = nfsd_file_cache_start_net(net);
 	if (ret)
 		goto out_lockd;
-	ret = nfs4_state_start_net(net);
+
+	ret = nfsd_reply_cache_init(nn);
 	if (ret)
 		goto out_filecache;
 
+	ret = nfs4_state_start_net(net);
+	if (ret)
+		goto out_reply_cache;
+
 #ifdef CONFIG_NFSD_V4_2_INTER_SSC
 	nfsd4_ssc_init_umount_work(nn);
 #endif
 	nn->nfsd_net_up = true;
 	return 0;
 
+out_reply_cache:
+	nfsd_reply_cache_shutdown(nn);
 out_filecache:
 	nfsd_file_cache_shutdown_net(net);
 out_lockd:
@@ -454,6 +461,7 @@ static void nfsd_shutdown_net(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
 	nfs4_state_shutdown_net(net);
+	nfsd_reply_cache_shutdown(nn);
 	nfsd_file_cache_shutdown_net(net);
 	if (nn->lockd_up) {
 		lockd_down(net);
-- 
2.39.0

