Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B321178664F
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 05:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbjHXDwX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Aug 2023 23:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239938AbjHXDu3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Aug 2023 23:50:29 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5392D78
        for <linux-nfs@vger.kernel.org>; Wed, 23 Aug 2023 20:49:16 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68824a0e747so1238313b3a.1
        for <linux-nfs@vger.kernel.org>; Wed, 23 Aug 2023 20:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848922; x=1693453722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZYFEziqHKQTs36ii9IxaHzQyRy7+HnptX1eUkyxsok=;
        b=lO1BdOc8IC76LRNZfOyYy9eMSIbqStBvooSiHRS3AafY74HoA5BqZ6t+3TGAl0AtpZ
         rev6hFOx+kyDkPHvZWJq9q0vP81aFRlb10Zk0Fn/fmFGc2gfXltX3ouoNMCO0npH2OYh
         mHzGaYb9GR0YpvYgV0F7nGHXI+2qAfWk7jBdjnrbHQ7ZoXsBAkbTq8I4pxbSsEHVsDz8
         ZP9W981GjOmUSABfVm6ksphZLc3U0h1/AMUeOlX2AabLS3bbzoyM3q214L12qJTAcaI8
         AuxZhADwW/QQM1sMR7rpIuhO83gYxeJqrQlI0CxOm2IAMzWUOcDbXFo7LC97q86bZmDo
         i6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848922; x=1693453722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZYFEziqHKQTs36ii9IxaHzQyRy7+HnptX1eUkyxsok=;
        b=XfC0X1V5+VrKRBML4ESi9zzoyDfIxZoAxmV/RjL3Q6KG25uRiBpmYBP+iwYEsuV2I/
         oV8B/AkrGpFmtlR/8IYChmtgan8s10DGaTA16nYJ172qJGBCkTXjZd7EJbuVMsnzXpZQ
         z/s9VWvte9EsMvRVqqK0BP5CvcKrZw/wJq1sbRoQsk2vHbgtSMPmBIgxan4TLoZ3D23m
         PZfPAANCQ0qDN/0aTLKJxGbr61hsZWlV3jJ7MLnAlJfXwY4jHCP7ZOi4AXwGXy8e5mUp
         Bg858QEgiH3MtKNin781U9v0S5lu60K7Dow2uOTgSVm1dz8GjdmDhtEdnYHgJIduD3xN
         8PVw==
X-Gm-Message-State: AOJu0Yyc0CkZ07QxYp52KiSYlmZjnEloJk0m6QADGmWGcgrsgSLGt5Pu
        a/g4bUU6BQBRjTJYcwQW9c+hAw==
X-Google-Smtp-Source: AGHT+IGiDI02Gkdoww8eG0IG14i0OeHJi8Gmt0fnAr81rlF4DRqTG1oQfD1+mqVI4jvLZxUezjNelw==
X-Received: by 2002:a05:6a21:6da5:b0:133:6e3d:68cd with SMTP id wl37-20020a056a216da500b001336e3d68cdmr17945492pzb.3.1692848922018;
        Wed, 23 Aug 2023 20:48:42 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:48:41 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH v5 33/45] nfsd: dynamically allocate the nfsd-reply shrinker
Date:   Thu, 24 Aug 2023 11:42:52 +0800
Message-Id: <20230824034304.37411-34-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In preparation for implementing lockless slab shrink, use new APIs to
dynamically allocate the nfsd-reply shrinker, so that it can be freed
asynchronously via RCU. Then it doesn't need to wait for RCU read-side
critical section when releasing the struct nfsd_net.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Chuck Lever <chuck.lever@oracle.com>
Acked-by: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>
CC: Olga Kornievskaia <kolga@netapp.com>
CC: Dai Ngo <Dai.Ngo@oracle.com>
CC: Tom Talpey <tom@talpey.com>
CC: linux-nfs@vger.kernel.org
---
 fs/nfsd/netns.h    |  2 +-
 fs/nfsd/nfscache.c | 31 ++++++++++++++++---------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index f669444d5336..ab303a8b77d5 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -177,7 +177,7 @@ struct nfsd_net {
 	/* size of cache when we saw the longest hash chain */
 	unsigned int             longest_chain_cachesize;
 
-	struct shrinker		nfsd_reply_cache_shrinker;
+	struct shrinker		*nfsd_reply_cache_shrinker;
 
 	/* tracking server-to-server copy mounts */
 	spinlock_t              nfsd_ssc_lock;
diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 80621a709510..fd56a52aa5fb 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -201,26 +201,29 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 {
 	unsigned int hashsize;
 	unsigned int i;
-	int status = 0;
 
 	nn->max_drc_entries = nfsd_cache_size_limit();
 	atomic_set(&nn->num_drc_entries, 0);
 	hashsize = nfsd_hashsize(nn->max_drc_entries);
 	nn->maskbits = ilog2(hashsize);
 
-	nn->nfsd_reply_cache_shrinker.scan_objects = nfsd_reply_cache_scan;
-	nn->nfsd_reply_cache_shrinker.count_objects = nfsd_reply_cache_count;
-	nn->nfsd_reply_cache_shrinker.seeks = 1;
-	status = register_shrinker(&nn->nfsd_reply_cache_shrinker,
-				   "nfsd-reply:%s", nn->nfsd_name);
-	if (status)
-		return status;
-
 	nn->drc_hashtbl = kvzalloc(array_size(hashsize,
 				sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
 	if (!nn->drc_hashtbl)
+		return -ENOMEM;
+
+	nn->nfsd_reply_cache_shrinker = shrinker_alloc(0, "nfsd-reply:%s",
+						       nn->nfsd_name);
+	if (!nn->nfsd_reply_cache_shrinker)
 		goto out_shrinker;
 
+	nn->nfsd_reply_cache_shrinker->scan_objects = nfsd_reply_cache_scan;
+	nn->nfsd_reply_cache_shrinker->count_objects = nfsd_reply_cache_count;
+	nn->nfsd_reply_cache_shrinker->seeks = 1;
+	nn->nfsd_reply_cache_shrinker->private_data = nn;
+
+	shrinker_register(nn->nfsd_reply_cache_shrinker);
+
 	for (i = 0; i < hashsize; i++) {
 		INIT_LIST_HEAD(&nn->drc_hashtbl[i].lru_head);
 		spin_lock_init(&nn->drc_hashtbl[i].cache_lock);
@@ -229,7 +232,7 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
 
 	return 0;
 out_shrinker:
-	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
+	kvfree(nn->drc_hashtbl);
 	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
 	return -ENOMEM;
 }
@@ -239,7 +242,7 @@ void nfsd_reply_cache_shutdown(struct nfsd_net *nn)
 	struct nfsd_cacherep *rp;
 	unsigned int i;
 
-	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
+	shrinker_free(nn->nfsd_reply_cache_shrinker);
 
 	for (i = 0; i < nn->drc_hashsize; i++) {
 		struct list_head *head = &nn->drc_hashtbl[i].lru_head;
@@ -323,8 +326,7 @@ nfsd_prune_bucket_locked(struct nfsd_net *nn, struct nfsd_drc_bucket *b,
 static unsigned long
 nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 {
-	struct nfsd_net *nn = container_of(shrink,
-				struct nfsd_net, nfsd_reply_cache_shrinker);
+	struct nfsd_net *nn = shrink->private_data;
 
 	return atomic_read(&nn->num_drc_entries);
 }
@@ -343,8 +345,7 @@ nfsd_reply_cache_count(struct shrinker *shrink, struct shrink_control *sc)
 static unsigned long
 nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 {
-	struct nfsd_net *nn = container_of(shrink,
-				struct nfsd_net, nfsd_reply_cache_shrinker);
+	struct nfsd_net *nn = shrink->private_data;
 	unsigned long freed = 0;
 	LIST_HEAD(dispose);
 	unsigned int i;
-- 
2.30.2

