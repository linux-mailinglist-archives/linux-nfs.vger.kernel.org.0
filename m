Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E54C7339AF
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jun 2023 21:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjFPTVj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Jun 2023 15:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjFPTVW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Jun 2023 15:21:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF32524A;
        Fri, 16 Jun 2023 12:19:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99902634BF;
        Fri, 16 Jun 2023 19:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382D2C433C8;
        Fri, 16 Jun 2023 19:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686943067;
        bh=CAmP+Lx0wzqgHUs9vsC25lJNjq99NNhM1Mo48RueGyc=;
        h=From:To:Cc:Subject:Date:From;
        b=ZETvxHndWQKmZsWWEKvvXIR1NvhG0E+JQ9XMa5/v0HqoF1ZdzNxZ/GXDMO1LaUO4z
         dTo8UADnCGD6UZuvo5lDy70OAvdWz0SEcdnue4m1STiOYVAY/m8pN9g8X7LsAjmFCV
         zok7BR7RRfuq5+ikc05b+FO7Rmn7O0Pbe+upHOn3mYLkVA10AGC4zNbpMXNNioCN16
         1PTOFhDX5zn5YaV8YcoVZgp0uT2FEmQOco1kT6lgBXkuDqdNO3Mnf7uVEjoZB0QGZs
         qujzgPiXMdTyhI6XZL1nnpWuTmGkiAdXp5cymmX88O+lp0TYmei3kIU55NqFC4tDn4
         VeQ7NL4ofgUqw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     stable@vger.kernel.org, Eirik Fuller <efuller@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nfsd: move init of percpu reply_cache_stats counters back to nfsd_init_net
Date:   Fri, 16 Jun 2023 15:17:43 -0400
Message-Id: <20230616191744.202292-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

f5f9d4a314da moved the initialization of the reply cache into the nfsd
startup, but it didn't account for the stats counters which can be
accessed before nfsd is ever started, causing a NULL pointer
dereference.

This is easy to trigger on some arches (like aarch64), but on x86_64,
calling this_cpu_ptr(NULL) evidently returns a pointer to the
fixed_percpu_data, which I guess this looks just enough like a newly
initialized percpu var to allow nfsd_reply_cache_stats_show to access it
without Oopsing.

Move the initialization of the per-net+per-cpu reply-cache counters back
into nfsd_init_net, while leaving the rest of the reply cache
allocations to be done at nfsd startup time.

Kudos to Eirik who did most of the legwork to track this down.

Cc: stable@vger.kernel.org # v6.3+
Fixes: f5f9d4a314da ("nfsd: move reply cache initialization into nfsd startup")
Reported-and-Tested-by: Eirik Fuller <efuller@redhat.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/cache.h    |  2 ++
 fs/nfsd/nfscache.c | 13 +++----------
 fs/nfsd/nfsctl.c   |  8 ++++++++
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
index f21259ead64b..a4b12d6c41d3 100644
--- a/fs/nfsd/cache.h
+++ b/fs/nfsd/cache.h
@@ -80,6 +80,8 @@ enum {
 
 int	nfsd_drc_slab_create(void);
 void	nfsd_drc_slab_free(void);
+int	nfsd_reply_cache_stats_init(struct nfsd_net *nn);
+void	nfsd_reply_cache_stats_destroy(struct nfsd_net *nn);
 int	nfsd_reply_cache_init(struct nfsd_net *);
 void	nfsd_reply_cache_shutdown(struct nfsd_net *);
 int	nfsd_cache_lookup(struct svc_rqst *);
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 041faa13b852..b696dc629c0b 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -148,12 +148,12 @@ void nfsd_drc_slab_free(void)
 	kmem_cache_destroy(drc_slab);
 }
 
-static int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
+int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
 {
 	return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
 }
 
-static void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
+void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
 {
 	nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
 }
@@ -169,17 +169,13 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	hashsize = nfsd_hashsize(nn->max_drc_entries);
 	nn->maskbits = ilog2(hashsize);
 
-	status = nfsd_reply_cache_stats_init(nn);
-	if (status)
-		goto out_nomem;
-
 	nn->nfsd_reply_cache_shrinker.scan_objects = nfsd_reply_cache_scan;
 	nn->nfsd_reply_cache_shrinker.count_objects = nfsd_reply_cache_count;
 	nn->nfsd_reply_cache_shrinker.seeks = 1;
 	status = register_shrinker(&nn->nfsd_reply_cache_shrinker,
 				   "nfsd-reply:%s", nn->nfsd_name);
 	if (status)
-		goto out_stats_destroy;
+		return status;
 
 	nn->drc_hashtbl = kvzalloc(array_size(hashsize,
 				sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
@@ -195,9 +191,6 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 	return 0;
 out_shrinker:
 	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
-out_stats_destroy:
-	nfsd_reply_cache_stats_destroy(nn);
-out_nomem:
 	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
 	return -ENOMEM;
 }
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 1489e0b703b4..7c837afcf615 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1505,6 +1505,9 @@ static __net_init int nfsd_init_net(struct net *net)
 	retval = nfsd_idmap_init(net);
 	if (retval)
 		goto out_idmap_error;
+	retval = nfsd_reply_cache_stats_init(nn);
+	if (retval)
+		goto out_repcache_error;
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
@@ -1513,6 +1516,8 @@ static __net_init int nfsd_init_net(struct net *net)
 
 	return 0;
 
+out_repcache_error:
+	nfsd_idmap_shutdown(net);
 out_idmap_error:
 	nfsd_export_shutdown(net);
 out_export_error:
@@ -1521,6 +1526,9 @@ static __net_init int nfsd_init_net(struct net *net)
 
 static __net_exit void nfsd_exit_net(struct net *net)
 {
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	nfsd_reply_cache_stats_destroy(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
 	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
-- 
2.40.1

