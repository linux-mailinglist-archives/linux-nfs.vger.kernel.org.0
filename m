Return-Path: <linux-nfs+bounces-16481-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAA9C68F4F
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 12:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 649D836828F
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C8E34B1A8;
	Tue, 18 Nov 2025 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O34uegYP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3077333E377
	for <linux-nfs@vger.kernel.org>; Tue, 18 Nov 2025 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763463490; cv=none; b=cl+sHmmasD6P6a1B1IMSgjJ7+AjZf7uAMVVA0AvBzpz6d+9prP6D+TNKxotzcLGtXJZg09MNon5iX1igY6JCB2jsqzo7HPzRO2UIC/0o0AtnzU2S4CGLRiHt6nyU6P1+VTHhxiQIvrlcuTyMNHPJFBrM8DtP1Lqn+n/Oh5I9vxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763463490; c=relaxed/simple;
	bh=++jiYuE2cckyyET9nhbp9BJovH7GXzdcuWeh/f5gVoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uKqa5gMwkFpn7kTqg0Xz9HgBxvSYufSnI1hyKszigIvr+CZwa9bcdcEAlqgFwmTlACLaEEhGfG6n1KGI9v7/Z1i+SrNMaBA13cAsTcoqkJbYS/eUyY0wj62TCiHB0CCCaSdbsYoVt6/d7mtQfbtiE2FqBn2mD02OYt5sB4Pqg3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O34uegYP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so3458802b3a.2
        for <linux-nfs@vger.kernel.org>; Tue, 18 Nov 2025 02:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763463485; x=1764068285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aJexZKdHMlhPVDflvOcfHNoKatQnjc03y3cuJWU065Y=;
        b=O34uegYP0zxPTIt6w054m4bKeiLz6dakjYuz10/ExNJv0PxY78QR1i2Ny1N/9cG1Ma
         4xE1pb6wxfSEQvp9BiD468Zwr0LUb48k1oKVFN1slA3DCBuqTPRa9EbpGQWsAILJTxIi
         gDBjUesumzySO8ya77a/6lQzgbs3mNknFe2yKKM40nH6p+QhySLau0DM/DVH8PTUNYcN
         qT3qecvc3pm5qAiO1AIByzroVdqRG/PwBWOYa7wbMui44NQ1OSYW8orV7deBwLDXhdUG
         IA2L36QdGbA188U4DPTjkU7sNcuKk6rthF6YIZE/rYxdI5OaNDj9/cpwmvYDFZgkVC9u
         v01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763463485; x=1764068285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJexZKdHMlhPVDflvOcfHNoKatQnjc03y3cuJWU065Y=;
        b=nJsquZgtl0XHL14Jbig7QLLEeOSHMlhicvwF77ITU8DfQi1gVf5ujD0naY12NbhV7n
         bGoJIuW4NwqP4VfVc2tS7twyZYB0azINdfG/DfbxyO1Oc5DrhQIuKEk+B+bVW0dWDUjk
         Rx7aGvMj2vjyy9x+lUqBtG/pYXGDjcpBy23K7aqAiTRPlxC6xLrE2faZKo6pjKw7beB1
         APTB3C81yaoRK5o/kXvD1ChHBLaVkaDWqNiDw+nmXOYFwuAMRmpftQtihdvd7DcuiXnf
         P5kzrXfTOzelKW8A8sDEK/B/if+qOvrngdTOrZKMzBNr+TY0ndCkGB4n0r7k3cB8Yqvp
         mOsQ==
X-Gm-Message-State: AOJu0YzDlBKRDDWPnua+AJxtaOqJv643rhgTYhoxjy6ws6A+vQlrOHur
	mzsV0chrmio+wjmAt35NaOQ2T0NSdSJBt9jDCOYkw8+Ps4t39ah57ySj
X-Gm-Gg: ASbGncsqMckqGU7YZUv2kz8pFs+0WPkWR16RilBhjdfihUw+ApOhx5SWBedM96qEhKB
	2jQ6SDmeItHBkpzlsclwZMaeXRBlie7aT/vSpwKNK3+ZywoCSE2Geb+rCwaC8NenyDybJGFuLG3
	p3w9MaFQ5ilfXYUnutmYf/Y6rjIHdv+1vipr3qDOIWWTjJhUufGhTjY6F4DVor7OcMCXiAfYqpJ
	13yMi4TezTwX9tG5HOIUjedhjstjCTWTNNAqCmRXmP9At5X2ofjJntJY/s0lRfA2E0OvBPFyaQw
	AkEWmdV8eP+LW8IFJRiiPaJTZzvQYAYrkc890m/EwC1EPuiXVXJXIHnWSgsCfQZ47Bfr1JIxjrg
	DX+pDheCS2VV/Ei6VZwcZj7JfuYBR0Fuy7cH/o/Bg7FwVlNBKz+8pVXwD9Kmbu6wqyV8xbbBd3G
	2ySptE9lHE+1McMADBJJSnv2Ht9yxGXw==
X-Google-Smtp-Source: AGHT+IFitO4lNemhC1Wlqq4PWX0kKsgbELolIeLMCVlqY48S9IQT3bOfxojiu3ZbPSMHDgBgWgr8Sw==
X-Received: by 2002:a05:7022:2398:b0:11b:1e43:1c75 with SMTP id a92af1059eb24-11b41211172mr7255535c88.29.1763463485101;
        Tue, 18 Nov 2025 02:58:05 -0800 (PST)
Received: from localhost.localdomain ([192.146.154.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b06088604sm61886920c88.7.2025.11.18.02.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:58:04 -0800 (PST)
From: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
To: trondmy@kernel.org,
	anna@kernel.org,
	tom@talpey.com,
	chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org,
	Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
Subject: [PATCH] nfs: Implement delayed data server destruction with hold cache
Date: Tue, 18 Nov 2025 05:57:52 -0500
Message-ID: <20251118105752.52098-1-gaurav.gangalwar@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a hold cache mechanism for NFS pNFS data servers to avoid
unnecessary connection churn when data servers are temporarily idle.

Key changes:

1. Hold Cache Implementation:
   - Add nfs4_data_server_hold_cache to namespace structure
   - Move data servers to hold cache when refcount reaches zero
   - Always update ds_last_access timestamp on every reference

2. Configurable Module Parameters:
   - nfs4_pnfs_ds_grace_period: Grace period before destroying idle
     data servers (default: 300 seconds)
   - nfs4_pnfs_ds_cleanup_interval: Interval for periodic cleanup
     work (default: 300 seconds)

3. Periodic Cleanup Work:
   - Schedule delayed work on first DS usage (lazy initialization)
   - Check hold cache and destroy data servers that exceed grace period
   - Reschedule work automatically for continuous monitoring

4. Callback Mechanism:
   - Use function pointer callback to avoid circular module dependencies
   - nfsv4.ko registers cleanup callback during initialization
   - nfs.ko calls callback during namespace cleanup (if registered)

5. Timestamp Tracking:
   - Add ds_last_access field to nfs4_pnfs_ds structure
   - Update timestamp on DS allocation, lookup, and reference

Benefits:
- Reduces connection setup/teardown overhead for intermittently used DSs
- Allows DS reuse if accessed again within grace period
- Configurable behavior via module parameters

Signed-off-by: Gaurav Gangalwar <gaurav.gangalwar@gmail.com>
---
 fs/nfs/client.c   |   9 +++
 fs/nfs/netns.h    |   4 ++
 fs/nfs/pnfs.h     |   8 +++
 fs/nfs/pnfs_nfs.c | 174 ++++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 188 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 54699299d5b1..c487a388ea86 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -1253,7 +1253,9 @@ void nfs_clients_init(struct net *net)
 #endif
 #if IS_ENABLED(CONFIG_NFS_V4_1)
 	INIT_LIST_HEAD(&nn->nfs4_data_server_cache);
+	INIT_LIST_HEAD(&nn->nfs4_data_server_hold_cache);
 	spin_lock_init(&nn->nfs4_data_server_lock);
+	/* Cleanup work will be initialized when pNFS is first used */
 #endif
 	spin_lock_init(&nn->nfs_client_lock);
 	nn->boot_time = ktime_get_real();
@@ -1267,12 +1269,19 @@ void nfs_clients_exit(struct net *net)
 {
 	struct nfs_net *nn = net_generic(net, nfs_net_id);
 
+#if IS_ENABLED(CONFIG_NFS_V4_1)
+	/* Clean up DS caches if pnfs was used - call via callback to avoid module dependency */
+	if (nn->nfs4_data_server_cleanup_callback)
+		nn->nfs4_data_server_cleanup_callback(net);
+#endif
+
 	nfs_netns_sysfs_destroy(nn);
 	nfs_cleanup_cb_ident_idr(net);
 	WARN_ON_ONCE(!list_empty(&nn->nfs_client_list));
 	WARN_ON_ONCE(!list_empty(&nn->nfs_volume_list));
 #if IS_ENABLED(CONFIG_NFS_V4_1)
 	WARN_ON_ONCE(!list_empty(&nn->nfs4_data_server_cache));
+	WARN_ON_ONCE(!list_empty(&nn->nfs4_data_server_hold_cache));
 #endif
 }
 
diff --git a/fs/nfs/netns.h b/fs/nfs/netns.h
index 6ba3ea39e928..dc6142bf87e6 100644
--- a/fs/nfs/netns.h
+++ b/fs/nfs/netns.h
@@ -34,7 +34,11 @@ struct nfs_net {
 #endif /* CONFIG_NFS_V4 */
 #if IS_ENABLED(CONFIG_NFS_V4_1)
 	struct list_head nfs4_data_server_cache;
+	struct list_head nfs4_data_server_hold_cache;
 	spinlock_t nfs4_data_server_lock;
+	struct delayed_work nfs4_data_server_cleanup_work;
+	bool nfs4_data_server_cleanup_initialized;
+	void (*nfs4_data_server_cleanup_callback)(struct net *);
 #endif /* CONFIG_NFS_V4_1 */
 	struct nfs_netns_client *nfs_client;
 	spinlock_t nfs_client_lock;
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 91ff877185c8..7fd09100e130 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -65,6 +65,7 @@ struct nfs4_pnfs_ds {
 	refcount_t		ds_count;
 	unsigned long		ds_state;
 #define NFS4DS_CONNECTING	0	/* ds is establishing connection */
+	unsigned long		ds_last_access;	/* timestamp of last reference */
 };
 
 struct pnfs_layout_segment {
@@ -416,6 +417,13 @@ int pnfs_generic_commit_pagelist(struct inode *inode,
 int pnfs_generic_scan_commit_lists(struct nfs_commit_info *cinfo, int max);
 void pnfs_generic_write_commit_done(struct rpc_task *task, void *data);
 void nfs4_pnfs_ds_put(struct nfs4_pnfs_ds *ds);
+void nfs4_pnfs_ds_cleanup_work(struct work_struct *work);
+void destroy_ds(struct nfs4_pnfs_ds *ds);
+
+/* Module parameters for DS cache management */
+extern unsigned int nfs4_pnfs_ds_grace_period;
+extern unsigned int nfs4_pnfs_ds_cleanup_interval;
+
 struct nfs4_pnfs_ds *nfs4_pnfs_ds_add(const struct net *net,
 				      struct list_head *dsaddrs,
 				      gfp_t gfp_flags);
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 9976cc16b689..83ef72017370 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -21,6 +21,17 @@
 
 #define NFSDBG_FACILITY		NFSDBG_PNFS
 
+/* Module parameters */
+unsigned int nfs4_pnfs_ds_grace_period = 300;
+module_param_named(nfs4_pnfs_ds_grace_period, nfs4_pnfs_ds_grace_period, uint, 0644);
+MODULE_PARM_DESC(nfs4_pnfs_ds_grace_period, "Grace period in seconds before destroying idle data servers (default 300)");
+EXPORT_SYMBOL_GPL(nfs4_pnfs_ds_grace_period);
+
+unsigned int nfs4_pnfs_ds_cleanup_interval = 300;
+module_param_named(nfs4_pnfs_ds_cleanup_interval, nfs4_pnfs_ds_cleanup_interval, uint, 0644);
+MODULE_PARM_DESC(nfs4_pnfs_ds_cleanup_interval, "Interval in seconds for data server cleanup work (default 300)");
+EXPORT_SYMBOL_GPL(nfs4_pnfs_ds_cleanup_interval);
+
 void pnfs_generic_rw_release(void *data)
 {
 	struct nfs_pgio_header *hdr = data;
@@ -604,15 +615,33 @@ _same_data_server_addrs_locked(const struct list_head *dsaddrs1,
 
 /*
  * Lookup DS by addresses.  nfs4_ds_cache_lock is held
+ * Check both active cache and hold cache
  */
 static struct nfs4_pnfs_ds *
-_data_server_lookup_locked(const struct nfs_net *nn, const struct list_head *dsaddrs)
+_data_server_lookup_locked(struct nfs_net *nn, const struct list_head *dsaddrs)
 {
 	struct nfs4_pnfs_ds *ds;
 
-	list_for_each_entry(ds, &nn->nfs4_data_server_cache, ds_node)
-		if (_same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs))
+	/* First check active cache */
+	list_for_each_entry(ds, &nn->nfs4_data_server_cache, ds_node) {
+		if (_same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs)) {
+			refcount_inc(&ds->ds_count);
+			ds->ds_last_access = jiffies;
 			return ds;
+		}
+	}
+
+	/* Check hold cache - if found, move back to active cache */
+	list_for_each_entry(ds, &nn->nfs4_data_server_hold_cache, ds_node) {
+		if (_same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs)) {
+			dprintk("NFS: DS %s found in hold cache, moving back to active cache\n",
+				ds->ds_remotestr);
+			list_move(&ds->ds_node, &nn->nfs4_data_server_cache);
+			ds->ds_last_access = jiffies;
+			return ds;
+		}
+	}
+
 	return NULL;
 }
 
@@ -631,7 +660,7 @@ static void nfs4_pnfs_ds_addr_free(struct nfs4_pnfs_ds_addr *da)
 	kfree(da);
 }
 
-static void destroy_ds(struct nfs4_pnfs_ds *ds)
+void destroy_ds(struct nfs4_pnfs_ds *ds)
 {
 	struct nfs4_pnfs_ds_addr *da;
 
@@ -652,15 +681,143 @@ static void destroy_ds(struct nfs4_pnfs_ds *ds)
 	kfree(ds->ds_remotestr);
 	kfree(ds);
 }
+EXPORT_SYMBOL_GPL(destroy_ds);
+
+/* Forward declaration */
+static void nfs4_cleanup_ds_for_namespace(struct net *net);
+
+/*
+ * Initialize DS cleanup work for a namespace (called on first DS add)
+ */
+static void nfs4_init_ds_cleanup_work(struct nfs_net *nn)
+{
+	if (!nn->nfs4_data_server_cleanup_initialized) {
+		INIT_DELAYED_WORK(&nn->nfs4_data_server_cleanup_work,
+				  nfs4_pnfs_ds_cleanup_work);
+		schedule_delayed_work(&nn->nfs4_data_server_cleanup_work,
+				      nfs4_pnfs_ds_cleanup_interval * HZ);
+		/* Register callback so nfs.ko can call us during namespace cleanup */
+		nn->nfs4_data_server_cleanup_callback = nfs4_cleanup_ds_for_namespace;
+		nn->nfs4_data_server_cleanup_initialized = true;
+		dprintk("NFS: Initialized DS cleanup work for namespace (interval=%u seconds)\n",
+			nfs4_pnfs_ds_cleanup_interval);
+	}
+}
+
+/*
+ * Cleanup DS work and destroy all DS entries for a namespace
+ */
+static void nfs4_cleanup_ds_for_namespace(struct net *net)
+{
+	struct nfs_net *nn = net_generic(net, nfs_net_id);
+	struct nfs4_pnfs_ds *ds, *tmp;
+
+	if (!nn->nfs4_data_server_cleanup_initialized)
+		return;
+
+	dprintk("NFS: Cleaning up DS for namespace\n");
+	cancel_delayed_work_sync(&nn->nfs4_data_server_cleanup_work);
+
+	/* Clean up data servers in both caches */
+	spin_lock(&nn->nfs4_data_server_lock);
+	list_for_each_entry_safe(ds, tmp, &nn->nfs4_data_server_cache, ds_node) {
+		list_del_init(&ds->ds_node);
+		spin_unlock(&nn->nfs4_data_server_lock);
+		destroy_ds(ds);
+		spin_lock(&nn->nfs4_data_server_lock);
+	}
+	list_for_each_entry_safe(ds, tmp, &nn->nfs4_data_server_hold_cache, ds_node) {
+		list_del_init(&ds->ds_node);
+		spin_unlock(&nn->nfs4_data_server_lock);
+		destroy_ds(ds);
+		spin_lock(&nn->nfs4_data_server_lock);
+	}
+	spin_unlock(&nn->nfs4_data_server_lock);
+
+	/* Unregister callback */
+	nn->nfs4_data_server_cleanup_callback = NULL;
+	nn->nfs4_data_server_cleanup_initialized = false;
+}
+
+/*
+ * Periodic cleanup task to check hold cache and destroy expired DS entries
+ */
+void nfs4_pnfs_ds_cleanup_work(struct work_struct *work)
+{
+	struct nfs_net *nn = container_of(work, struct nfs_net,
+					  nfs4_data_server_cleanup_work.work);
+	struct nfs4_pnfs_ds *ds, *tmp;
+	LIST_HEAD(destroy_list);
+	unsigned long grace_period = nfs4_pnfs_ds_grace_period * HZ;
+	unsigned long now = jiffies;
+	int active_count = 0, hold_count = 0, expired_count = 0;
+
+	dprintk("NFS: DS cleanup work started for namespace (jiffies=%lu)\n", now);
+
+	spin_lock(&nn->nfs4_data_server_lock);
+
+	/* Count entries in active cache */
+	list_for_each_entry(ds, &nn->nfs4_data_server_cache, ds_node)
+		active_count++;
+
+	/* Process hold cache */
+	list_for_each_entry_safe(ds, tmp, &nn->nfs4_data_server_hold_cache, ds_node) {
+		unsigned long time_since_last_access = now - ds->ds_last_access;
+
+		hold_count++;
+		if (time_since_last_access >= grace_period) {
+			/* Grace period expired, move to destroy list */
+			dprintk("NFS: DS cleanup task destroying expired DS: %s (idle for %lu seconds)\n",
+				ds->ds_remotestr, time_since_last_access / HZ);
+			list_move(&ds->ds_node, &destroy_list);
+			expired_count++;
+		} else {
+			dprintk("NFS: DS %s in hold cache (idle for %lu seconds, %lu seconds remaining)\n",
+				ds->ds_remotestr, time_since_last_access / HZ,
+				(grace_period - time_since_last_access) / HZ);
+		}
+	}
+
+	spin_unlock(&nn->nfs4_data_server_lock);
+
+	dprintk("NFS: DS cleanup work: active_cache=%d, hold_cache=%d, expired=%d\n",
+		active_count, hold_count, expired_count);
+
+	/* Destroy DS entries outside of lock */
+	list_for_each_entry_safe(ds, tmp, &destroy_list, ds_node) {
+		list_del_init(&ds->ds_node);
+		destroy_ds(ds);
+	}
+
+	/* Reschedule cleanup task */
+	dprintk("NFS: DS cleanup work completed, rescheduling in %u seconds\n",
+		nfs4_pnfs_ds_cleanup_interval);
+	schedule_delayed_work(&nn->nfs4_data_server_cleanup_work,
+			      nfs4_pnfs_ds_cleanup_interval * HZ);
+}
+EXPORT_SYMBOL_GPL(nfs4_pnfs_ds_cleanup_work);
 
 void nfs4_pnfs_ds_put(struct nfs4_pnfs_ds *ds)
 {
 	struct nfs_net *nn = net_generic(ds->ds_net, nfs_net_id);
 
 	if (refcount_dec_and_lock(&ds->ds_count, &nn->nfs4_data_server_lock)) {
-		list_del_init(&ds->ds_node);
+		/* Update last access time */
+		ds->ds_last_access = jiffies;
+
+		dprintk("NFS: DS refcount reached 0 for %s, moving to hold cache\n",
+			ds->ds_remotestr);
+
+		/* Move to hold cache - cleanup work will check grace period */
+		refcount_set(&ds->ds_count, 1);
+		list_move(&ds->ds_node, &nn->nfs4_data_server_hold_cache);
+		spin_unlock(&nn->nfs4_data_server_lock);
+		dprintk("NFS: DS %s moved to hold cache\n", ds->ds_remotestr);
+	} else {
+		/* Update last access time even when not moving to hold cache */
+		spin_lock(&nn->nfs4_data_server_lock);
+		ds->ds_last_access = jiffies;
 		spin_unlock(&nn->nfs4_data_server_lock);
-		destroy_ds(ds);
 	}
 }
 EXPORT_SYMBOL_GPL(nfs4_pnfs_ds_put);
@@ -753,13 +910,16 @@ nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp_t gfp_fla
 	} else {
 		kfree(remotestr);
 		kfree(ds);
-		refcount_inc(&tmp_ds->ds_count);
 		dprintk("%s data server %s found, inc'ed ds_count to %d\n",
 			__func__, tmp_ds->ds_remotestr,
 			refcount_read(&tmp_ds->ds_count));
 		ds = tmp_ds;
 	}
 	spin_unlock(&nn->nfs4_data_server_lock);
+
+	/* Initialize cleanup work on first DS add */
+	if (ds)
+		nfs4_init_ds_cleanup_work(nn);
 out:
 	return ds;
 }
-- 
2.43.0


