Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B18772212
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Aug 2023 13:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjHGL2v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Aug 2023 07:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbjHGL2A (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Aug 2023 07:28:00 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423705256
        for <linux-nfs@vger.kernel.org>; Mon,  7 Aug 2023 04:24:39 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6873f64a290so1248538b3a.0
        for <linux-nfs@vger.kernel.org>; Mon, 07 Aug 2023 04:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691407123; x=1692011923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnO+VrCD4LojLy+8kmnCjGg0ZRt7Zy9NIxA02Cs4pZw=;
        b=PfEVKvTzBWRKzDZcOs/Fep65btb/5j6s3WDHceANi3UdyfyE1ZYJjj/ojCsgHi3Vd1
         UnyiA9UJ+WO0skTyzkklbevZFVt0QM5P026zpV9irULg/dt9elBIaT9aO85mKj85kzSK
         8BL7WAzqEgJCUSOrld3eSg+Xi6Bj/nVLlSU4qlnz3r3ovJoXr2T2o0DtWh8ePmCGKfhu
         8HAbYH+dcq7rqiPTVsEp3knKk+0ZUdZ34RURzik4J4PgZDJhHLpdrzH5JSXxHECtRx3a
         erZSmwbY1m1zt8qE5RzbmfCM7KzyvNBKjG86UwibulZ8+wpz72tXfP+ENX4A3BoRP40M
         UhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407123; x=1692011923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnO+VrCD4LojLy+8kmnCjGg0ZRt7Zy9NIxA02Cs4pZw=;
        b=CwuZGoHRAqABdAinYtKQxgkEMJwT/nO/KXgVVCzLSIGOGFpCOnZNODyYMLx2lrBfCJ
         KWwG1HapJ9TnJ4Le/R74rlpM4ZDlcUHyGuUTrYQNi3QcaBWbTaodGnWP9LQc0a2WoWM3
         LP4dRLAc901D+IDiCa/EJjsdEGHo0lMGfp0fiXjgYBNOtD1ptShn7PbzmTSF3nekW3Br
         xcOReo8kJxzi3V0/Z2FRwrruvZc72WRLw02Von9pkOKHAhjfI+zyVZniAuWMtWkOIh1I
         ljChnWClF56MFYq922f7Ygfuy8uSsHqnKwRNu1F3FBYQjUF7f/JaX2I7bwGQe+jfFMCL
         kayQ==
X-Gm-Message-State: ABy/qLZpyiNlNWmmxYG/yC3FNtgUIKLB4r1WQubGkBpinKQMwp4acSeN
        t9Fu6Vrwy79v+O9rXLPZQS1Nkg==
X-Google-Smtp-Source: APBJJlGN7o+mPwW+D250kL/E75whSiIFGnI9vIACxkViJa+uI/EkAzzWgkZZOw/GfOlqJQ+tGCA4bg==
X-Received: by 2002:a17:90a:3f08:b0:268:1e3b:14c9 with SMTP id l8-20020a17090a3f0800b002681e3b14c9mr23489214pjc.2.1691407122942;
        Mon, 07 Aug 2023 04:18:42 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0025be7b69d73sm5861191pjt.12.2023.08.07.04.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 04:18:42 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev, simon.horman@corigine.com,
        dlemoal@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-erofs@lists.ozlabs.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        rcu@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dm-devel@redhat.com, linux-raid@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 41/48] fs: super: dynamically allocate the s_shrink
Date:   Mon,  7 Aug 2023 19:09:29 +0800
Message-Id: <20230807110936.21819-42-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
References: <20230807110936.21819-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the s_shrink, so that it can be freed asynchronously
using kfree_rcu(). Then it doesn't need to wait for RCU read-side critical
section when releasing the struct super_block.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/btrfs/super.c   |  2 +-
 fs/kernfs/mount.c  |  2 +-
 fs/proc/root.c     |  2 +-
 fs/super.c         | 34 +++++++++++++++++++---------------
 include/linux/fs.h |  2 +-
 5 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 5ca07b41b4cd..c6980fc6fe02 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1514,7 +1514,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 
 		snprintf(s->s_id, sizeof(s->s_id), "%pg",
 			 fs_devices->latest_dev->bdev);
-		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
+		shrinker_debugfs_rename(s->s_shrink, "sb-%s:%s", fs_type->name,
 					s->s_id);
 		fs_info->bdev_holder = s;
 		error = btrfs_fill_super(s, fs_devices, data);
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index c4bf26142eec..79b96e74a8a0 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -265,7 +265,7 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_time_gran = 1;
 
 	/* sysfs dentries and inodes don't require IO to create */
-	sb->s_shrink.seeks = 0;
+	sb->s_shrink->seeks = 0;
 
 	/* get root inode, initialize and unlock it */
 	down_read(&kf_root->kernfs_rwsem);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 9191248f2dac..b55dbc70287b 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -188,7 +188,7 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_stack_depth = FILESYSTEM_MAX_STACK_DEPTH;
 
 	/* procfs dentries and inodes don't require IO to create */
-	s->s_shrink.seeks = 0;
+	s->s_shrink->seeks = 0;
 
 	pde_get(&proc_root);
 	root_inode = proc_get_inode(s, &proc_root);
diff --git a/fs/super.c b/fs/super.c
index 2354bcab6fff..a28193045345 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -67,7 +67,7 @@ static unsigned long super_cache_scan(struct shrinker *shrink,
 	long	dentries;
 	long	inodes;
 
-	sb = container_of(shrink, struct super_block, s_shrink);
+	sb = shrink->private_data;
 
 	/*
 	 * Deadlock avoidance.  We may hold various FS locks, and we don't want
@@ -120,7 +120,7 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	struct super_block *sb;
 	long	total_objects = 0;
 
-	sb = container_of(shrink, struct super_block, s_shrink);
+	sb = shrink->private_data;
 
 	/*
 	 * We don't call trylock_super() here as it is a scalability bottleneck,
@@ -182,7 +182,7 @@ static void destroy_unused_super(struct super_block *s)
 	security_sb_free(s);
 	put_user_ns(s->s_user_ns);
 	kfree(s->s_subtype);
-	free_prealloced_shrinker(&s->s_shrink);
+	shrinker_free(s->s_shrink);
 	/* no delays needed */
 	destroy_super_work(&s->destroy_work);
 }
@@ -259,16 +259,20 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_time_min = TIME64_MIN;
 	s->s_time_max = TIME64_MAX;
 
-	s->s_shrink.seeks = DEFAULT_SEEKS;
-	s->s_shrink.scan_objects = super_cache_scan;
-	s->s_shrink.count_objects = super_cache_count;
-	s->s_shrink.batch = 1024;
-	s->s_shrink.flags = SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE;
-	if (prealloc_shrinker(&s->s_shrink, "sb-%s", type->name))
+	s->s_shrink = shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
+				     "sb-%s", type->name);
+	if (!s->s_shrink)
 		goto fail;
-	if (list_lru_init_memcg(&s->s_dentry_lru, &s->s_shrink))
+
+	s->s_shrink->seeks = DEFAULT_SEEKS;
+	s->s_shrink->scan_objects = super_cache_scan;
+	s->s_shrink->count_objects = super_cache_count;
+	s->s_shrink->batch = 1024;
+	s->s_shrink->private_data = s;
+
+	if (list_lru_init_memcg(&s->s_dentry_lru, s->s_shrink))
 		goto fail;
-	if (list_lru_init_memcg(&s->s_inode_lru, &s->s_shrink))
+	if (list_lru_init_memcg(&s->s_inode_lru, s->s_shrink))
 		goto fail;
 	return s;
 
@@ -326,7 +330,7 @@ void deactivate_locked_super(struct super_block *s)
 {
 	struct file_system_type *fs = s->s_type;
 	if (atomic_dec_and_test(&s->s_active)) {
-		unregister_shrinker(&s->s_shrink);
+		shrinker_free(s->s_shrink);
 		fs->kill_sb(s);
 
 		/*
@@ -610,7 +614,7 @@ struct super_block *sget_fc(struct fs_context *fc,
 	hlist_add_head(&s->s_instances, &s->s_type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(s->s_type);
-	register_shrinker_prepared(&s->s_shrink);
+	shrinker_register(s->s_shrink);
 	return s;
 
 share_extant_sb:
@@ -693,7 +697,7 @@ struct super_block *sget(struct file_system_type *type,
 	hlist_add_head(&s->s_instances, &type->fs_supers);
 	spin_unlock(&sb_lock);
 	get_filesystem(type);
-	register_shrinker_prepared(&s->s_shrink);
+	shrinker_register(s->s_shrink);
 	return s;
 }
 EXPORT_SYMBOL(sget);
@@ -1312,7 +1316,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	mutex_unlock(&bdev->bd_fsfreeze_mutex);
 
 	snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
-	shrinker_debugfs_rename(&sb->s_shrink, "sb-%s:%s", sb->s_type->name,
+	shrinker_debugfs_rename(sb->s_shrink, "sb-%s:%s", sb->s_type->name,
 				sb->s_id);
 	sb_set_blocksize(sb, block_size(bdev));
 	return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9515d3688f71..1464afd41164 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1263,7 +1263,7 @@ struct super_block {
 
 	const struct dentry_operations *s_d_op; /* default d_op for dentries */
 
-	struct shrinker s_shrink;	/* per-sb shrinker handle */
+	struct shrinker *s_shrink;	/* per-sb shrinker handle */
 
 	/* Number of inodes with nlink == 0 but still referenced */
 	atomic_long_t s_remove_count;
-- 
2.30.2

