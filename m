Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B244599CD
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 02:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhKWBfp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 20:35:45 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:57964 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBfp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 20:35:45 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 80BAB212B6;
        Tue, 23 Nov 2021 01:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637631157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKChihadRa55rawMFndXyV+xBWffxIzAzR7tfUS6g9M=;
        b=WH64G2E96S+lQ2N7KuqS5OZQKYoufL052sbN/HcaH+k58y17mMqSMRAM5H+ZkkpgrctBiA
        Gs1xy5PstjvMf44Lxm5WNzY808H5Qs6R/n/gZxXBWM+hRltUmKs3ifT4JbyF81c1B13J5a
        jyn9qgVx7qL/OZqT9vY9WomvPI2/6Yo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637631157;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EKChihadRa55rawMFndXyV+xBWffxIzAzR7tfUS6g9M=;
        b=hfl/piZB7/CNsgv+jHKLxRmsWg8vBrb3ZXQl8NQjiPGRv4K5VMsVatnLzDKyvhjCKbr1Gk
        zSWygr9rwukEHNBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D0F513BD4;
        Tue, 23 Nov 2021 01:32:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hxQSBrREnGEudAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 01:32:36 +0000
Subject: [PATCH 17/19] SUNRPC: always treat sv_nrpools==1 as "not pooled"
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Nov 2021 12:29:35 +1100
Message-ID: <163763097550.7284.8119486795641356296.stgit@noble.brown>
In-Reply-To: <163763078330.7284.10141477742275086758.stgit@noble.brown>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently 'pooled' services hold a reference on the pool_map, and
'unpooled' services do not.
svc_destroy() uses the presence of ->svo_function (via
svc_serv_is_pooled()) to determine if the reference should be dropped.
There is no direct correlation between being pooled and the use of
svo_function, though in practice, lockd is the only non-pooled service,
and the only one not to use svc_function.

This is untidy and would cause problems if we changed lockd to use
svc_set_num_threads(), which requires the use of ->svo_function.

So change the test for "is the service pooled" to "is sv_nrpools > 1".

This means that when svc_pool_map_get() returns 1, it must NOT take a
reference to the pool.

We discard svc_serv_is_pooled(), and test sv_nrpools directly.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc.c |   54 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f0dd9ef7e0cd..5fbe7f55289e 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -37,8 +37,6 @@
 
 static void svc_unregister(const struct svc_serv *serv, struct net *net);
 
-#define svc_serv_is_pooled(serv)    ((serv)->sv_ops->svo_function)
-
 #define SVC_POOL_DEFAULT	SVC_POOL_GLOBAL
 
 /*
@@ -240,8 +238,10 @@ svc_pool_map_init_pernode(struct svc_pool_map *m)
 
 /*
  * Add a reference to the global map of cpus to pools (and
- * vice versa).  Initialise the map if we're the first user.
- * Returns the number of pools.
+ * vice versa) if pools are in use.
+ * Initialise the map if we're the first user.
+ * Returns the number of pools. If this is '1', no reference
+ * was taken.
  */
 static unsigned int
 svc_pool_map_get(void)
@@ -253,6 +253,7 @@ svc_pool_map_get(void)
 
 	if (m->count++) {
 		mutex_unlock(&svc_pool_map_mutex);
+		WARN_ON_ONCE(m->npools <= 1);
 		return m->npools;
 	}
 
@@ -268,29 +269,36 @@ svc_pool_map_get(void)
 		break;
 	}
 
-	if (npools < 0) {
+	if (npools <= 0) {
 		/* default, or memory allocation failure */
 		npools = 1;
 		m->mode = SVC_POOL_GLOBAL;
 	}
 	m->npools = npools;
 
+	if (npools == 1)
+		/* service is unpooled, so doesn't hold a reference */
+		m->count--;
+
 	mutex_unlock(&svc_pool_map_mutex);
-	return m->npools;
+	return npools;
 }
 
 /*
- * Drop a reference to the global map of cpus to pools.
+ * Drop a reference to the global map of cpus to pools, if
+ * pools were in use, i.e. if npools > 1.
  * When the last reference is dropped, the map data is
  * freed; this allows the sysadmin to change the pool
  * mode using the pool_mode module option without
  * rebooting or re-loading sunrpc.ko.
  */
 static void
-svc_pool_map_put(void)
+svc_pool_map_put(int npools)
 {
 	struct svc_pool_map *m = &svc_pool_map;
 
+	if (npools <= 1)
+		return;
 	mutex_lock(&svc_pool_map_mutex);
 
 	if (!--m->count) {
@@ -359,21 +367,18 @@ svc_pool_for_cpu(struct svc_serv *serv, int cpu)
 	struct svc_pool_map *m = &svc_pool_map;
 	unsigned int pidx = 0;
 
-	/*
-	 * An uninitialised map happens in a pure client when
-	 * lockd is brought up, so silently treat it the
-	 * same as SVC_POOL_GLOBAL.
-	 */
-	if (svc_serv_is_pooled(serv)) {
-		switch (m->mode) {
-		case SVC_POOL_PERCPU:
-			pidx = m->to_pool[cpu];
-			break;
-		case SVC_POOL_PERNODE:
-			pidx = m->to_pool[cpu_to_node(cpu)];
-			break;
-		}
+	if (serv->sv_nrpools <= 1)
+		return serv->sv_pools;
+
+	switch (m->mode) {
+	case SVC_POOL_PERCPU:
+		pidx = m->to_pool[cpu];
+		break;
+	case SVC_POOL_PERNODE:
+		pidx = m->to_pool[cpu_to_node(cpu)];
+		break;
 	}
+
 	return &serv->sv_pools[pidx % serv->sv_nrpools];
 }
 
@@ -526,7 +531,7 @@ svc_create_pooled(struct svc_program *prog, unsigned int bufsize,
 		goto out_err;
 	return serv;
 out_err:
-	svc_pool_map_put();
+	svc_pool_map_put(npools);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(svc_create_pooled);
@@ -561,8 +566,7 @@ svc_destroy(struct kref *ref)
 
 	cache_clean_deferred(serv);
 
-	if (svc_serv_is_pooled(serv))
-		svc_pool_map_put();
+	svc_pool_map_put(serv->sv_nrpools);
 
 	kfree(serv->sv_pools);
 	kfree(serv);


