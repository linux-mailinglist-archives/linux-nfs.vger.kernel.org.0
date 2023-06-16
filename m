Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D20733BA8
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jun 2023 23:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjFPVvl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Jun 2023 17:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjFPVvk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Jun 2023 17:51:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596E2195;
        Fri, 16 Jun 2023 14:51:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA29160B6C;
        Fri, 16 Jun 2023 21:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA82C433C8;
        Fri, 16 Jun 2023 21:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686952298;
        bh=X6Tyl8npNW2BvMT/du++yO66g9Ogapsy3IijkJ5r2dA=;
        h=From:To:Cc:Subject:Date:From;
        b=S2amo9atQcujUd1/72ehaZMgewtPSKZ+JZa62csrZkyyetkiNxM2ynY8KDtT2VCWs
         ULT49eqMsZLYRuGYBTay49qRaVIczjasNa7Xx41/y3mM02VNs+ETjff4b/ZzEwW/8s
         Oe6ELvHSASRxC5ieB5uVXVRLxC96Q1OA+bEhA894oe+OyB+7dN679Vwc5ba6eZUeT6
         f7v//RLUaYmnuHJ+lo2bYhQ9Y/H3ToqwfqloN3vr7+O1A+oypaXU0oiq5zO/yL5hVq
         bSXdTYCh27JgTqMVL8bZqDTL4jnNLaAjkZyIlNWptzPG3oHZtX3bBjMkfai022MiqQ
         xD1NYLSIjK+PA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     Eirik Fuller <efuller@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] nfsd: move init of percpu reply_cache_stats counters back to nfsd_init_net
Date:   Fri, 16 Jun 2023 17:51:34 -0400
Message-Id: <20230616215136.230801-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.40.1
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

f5f9d4a314da moved the initialization of the reply cache into the nfsd
startup, but didn't account for the stats counters, which can be
accessed before nfsd is ever started. The result can be a NULL pointer
dereference when someone accesses /proc/fs/nfsd/reply_cache_stats while
nfsd is still shut down.

This is easy to trigger on some arches (like aarch64), but on x86_64,
calling this_cpu_ptr(NULL) evidently returns a pointer to the
fixed_percpu_data. That struct looks just enough like a newly
initialized percpu var to allow nfsd_reply_cache_stats_show to access it
without Oopsing.

Move the initialization of the per-net+per-cpu reply-cache counters back
into nfsd_init_net, while leaving the rest of the reply cache
allocations to be done at nfsd startup time. Also, add kerneldoc
comments over some of the confusingly-named functions involved with
per-net initialization and server startup.

Kudos to Eirik who did most of the legwork to track this down.

Fixes: f5f9d4a314da ("nfsd: move reply cache initialization into nfsd startup")
Reported-and-tested-by: Eirik Fuller <efuller@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2215429
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/cache.h    |  2 ++
 fs/nfsd/nfscache.c | 27 +++++++++++++++++----------
 fs/nfsd/nfsctl.c   | 18 +++++++++++++++++-
 fs/nfsd/nfssvc.c   | 10 ++++++++++
 4 files changed, 46 insertions(+), 11 deletions(-)

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
index 041faa13b852..5b86e5b495fc 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -148,12 +148,26 @@ void nfsd_drc_slab_free(void)
 	kmem_cache_destroy(drc_slab);
 }
 
-static int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
+/**
+ * nfsd_reply_cache_stats_init - initialize the reply cache stats
+ * @nn: nfsd_net to initialize
+ *
+ * Initialize the fields in the nfsd_net that are used for reply cache
+ * stats tracking.
+ */
+int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
 {
 	return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
 }
 
-static void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
+/**
+ * nfsd_reply_cache_stats_destroy - destroy the reply cache stats
+ * @nn: nfsd_net to initialize
+ *
+ * Free the fields in the nfsd_net that are used for reply cache
+ * stats tracking.
+ */
+void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
 {
 	nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
 }
@@ -169,17 +183,13 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
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
@@ -195,9 +205,6 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
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
index 1489e0b703b4..a21a3f24c567 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1494,6 +1494,14 @@ static int create_proc_exports_entry(void)
 
 unsigned int nfsd_net_id;
 
+/**
+ * nfsd_init_net - initialize the nfsd_net struct
+ * @net: net namespace to be initialized
+ *
+ * Initialize the nfsd_net struct that is associated with @net. This
+ * is called whenever nfsd.ko is plugged in, or when a new net
+ * namespace is created.
+ */
 static __net_init int nfsd_init_net(struct net *net)
 {
 	int retval;
@@ -1505,6 +1513,9 @@ static __net_init int nfsd_init_net(struct net *net)
 	retval = nfsd_idmap_init(net);
 	if (retval)
 		goto out_idmap_error;
+	retval = nfsd_reply_cache_stats_init(nn);
+	if (retval)
+		goto out_repcache_error;
 	nn->nfsd_versions = NULL;
 	nn->nfsd4_minorversions = NULL;
 	nfsd4_init_leases_net(nn);
@@ -1513,6 +1524,8 @@ static __net_init int nfsd_init_net(struct net *net)
 
 	return 0;
 
+out_repcache_error:
+	nfsd_idmap_shutdown(net);
 out_idmap_error:
 	nfsd_export_shutdown(net);
 out_export_error:
@@ -1521,9 +1534,12 @@ static __net_init int nfsd_init_net(struct net *net)
 
 static __net_exit void nfsd_exit_net(struct net *net)
 {
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+
+	nfsd_reply_cache_stats_destroy(nn);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
-	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
+	nfsd_netns_free_versions(nn);
 }
 
 static struct pernet_operations nfsd_net_ops = {
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 9c7b1ef5be40..77f686180891 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -402,6 +402,16 @@ void nfsd_reset_write_verifier(struct nfsd_net *nn)
 	write_sequnlock(&nn->writeverf_lock);
 }
 
+/**
+ * nfsd_startup_net - per-net specific nfsd startup
+ * @net: net namespace
+ * @cred: task credential
+ *
+ * Given @net, do the necessary work to start up nfsd in the namespace. This
+ * is invoked when a task writes to the "threads" file for the first time. The
+ * credential used for socket creation, etc. is inherited from the task that
+ * is writing to "threads".
+ */
 static int nfsd_startup_net(struct net *net, const struct cred *cred)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
-- 
2.40.1

