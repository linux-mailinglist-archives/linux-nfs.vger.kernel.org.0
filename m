Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E478786615
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Aug 2023 05:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbjHXDrE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Aug 2023 23:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbjHXDqc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Aug 2023 23:46:32 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290551BFF
        for <linux-nfs@vger.kernel.org>; Wed, 23 Aug 2023 20:46:05 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5657ca46a56so832828a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 23 Aug 2023 20:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1692848735; x=1693453535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXa1LVTr7cMGrveLuEzAv2/sv0TRtu2+M0j9hstuDhg=;
        b=lVZZLnG2RsmN3a+zFL72bWnUGygaFgRp6akXzveK4gtMYRg/HADgJCRGx9wFYaUoSg
         pEwNRignomWbz0X2VtgkM5yh9ie22cmsn86JDSYo62UxX8AhnRWbtnxk7vsHU1TuklPr
         KYYlYgONHvsGMaxaPlnlctmdwx2t9FyKc/SGaBRFpkSfmwi4o4a4q0TloaM6lWreTy6+
         dPqCqOkffPtxMYCMP0/9PFQmib97nVH3a2mDDsK9c1A1a3EU6i+rHDrFQYI3QbsVHTke
         t5Tgrl6fQSk6/O0l5wli/mgVVJqfFqz816vNoxt1a6BOYzzKWcqQBOWmo+92YHRVIkpP
         4QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692848735; x=1693453535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXa1LVTr7cMGrveLuEzAv2/sv0TRtu2+M0j9hstuDhg=;
        b=gT4X78kPonoPKEjQEhbrLlW8Kms+waX1mkDJNrHeNEDbj20nC7/MyWAKYnPMCNeqlj
         wfddUcVf+Y36oCGVsqjIrHFzwB39h/ZF19JqU3bT4BCzOyrTpe3uo9emkeA9fXG7hfHU
         1HXf2efv3KGauxJTS9u8BVrbYrvQPjAdZ78XfpEytAzQ1RX/yiTJ/VClTIgB+KZ0O3WB
         lRPQDIHlXSiMqNNwTMASJ1CfYNBzuEFjlPsnNuuM5JWGbYGfebrvIXWb0Zqs6NIUK1nB
         kuaFjuUDaG9T7fR5Xt14OzA+mwJfGIylRWppmOZcyLf7SXFf5i1zHrvTMR6eA2zE+PKx
         P0Zw==
X-Gm-Message-State: AOJu0Yzc7Lcs9wWUK9vkZUDC+12gSFw6Zn9tXWOhJarb8Trtrgp0rbBY
        RohKSlw7V1j+ZABGdBJpyoFlsw==
X-Google-Smtp-Source: AGHT+IFDQmZdqE5+8g4xA8xE/nPvKPpbbUoiPsHTkmpATNJSbjrISgWKtS3Mjf4jrwQTFGPcO7csaQ==
X-Received: by 2002:a05:6a00:1f89:b0:68a:33fc:a091 with SMTP id bg9-20020a056a001f8900b0068a33fca091mr13891213pfb.3.1692848735214;
        Wed, 23 Aug 2023 20:45:35 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b005579f12a238sm10533157pgo.86.2023.08.23.20.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 20:45:34 -0700 (PDT)
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
        Muchun Song <songmuchun@bytedance.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH v5 12/45] nfsd: dynamically allocate the nfsd-filecache shrinker
Date:   Thu, 24 Aug 2023 11:42:31 +0800
Message-Id: <20230824034304.37411-13-zhengqi.arch@bytedance.com>
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

Use new APIs to dynamically allocate the nfsd-filecache shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Jeff Layton <jlayton@kernel.org>
CC: Neil Brown <neilb@suse.de>
CC: Olga Kornievskaia <kolga@netapp.com>
CC: Dai Ngo <Dai.Ngo@oracle.com>
CC: Tom Talpey <tom@talpey.com>
CC: linux-nfs@vger.kernel.org
---
 fs/nfsd/filecache.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ee9c923192e0..9c62b4502539 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -521,11 +521,7 @@ nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
 	return ret;
 }
 
-static struct shrinker	nfsd_file_shrinker = {
-	.scan_objects = nfsd_file_lru_scan,
-	.count_objects = nfsd_file_lru_count,
-	.seeks = 1,
-};
+static struct shrinker *nfsd_file_shrinker;
 
 /**
  * nfsd_file_cond_queue - conditionally unhash and queue a nfsd_file
@@ -746,12 +742,19 @@ nfsd_file_cache_init(void)
 		goto out_err;
 	}
 
-	ret = register_shrinker(&nfsd_file_shrinker, "nfsd-filecache");
-	if (ret) {
-		pr_err("nfsd: failed to register nfsd_file_shrinker: %d\n", ret);
+	nfsd_file_shrinker = shrinker_alloc(0, "nfsd-filecache");
+	if (!nfsd_file_shrinker) {
+		ret = -ENOMEM;
+		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
 		goto out_lru;
 	}
 
+	nfsd_file_shrinker->count_objects = nfsd_file_lru_count;
+	nfsd_file_shrinker->scan_objects = nfsd_file_lru_scan;
+	nfsd_file_shrinker->seeks = 1;
+
+	shrinker_register(nfsd_file_shrinker);
+
 	ret = lease_register_notifier(&nfsd_file_lease_notifier);
 	if (ret) {
 		pr_err("nfsd: unable to register lease notifier: %d\n", ret);
@@ -774,7 +777,7 @@ nfsd_file_cache_init(void)
 out_notifier:
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
 out_shrinker:
-	unregister_shrinker(&nfsd_file_shrinker);
+	shrinker_free(nfsd_file_shrinker);
 out_lru:
 	list_lru_destroy(&nfsd_file_lru);
 out_err:
@@ -891,7 +894,7 @@ nfsd_file_cache_shutdown(void)
 		return;
 
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
-	unregister_shrinker(&nfsd_file_shrinker);
+	shrinker_free(nfsd_file_shrinker);
 	/*
 	 * make sure all callers of nfsd_file_lru_cb are done before
 	 * calling nfsd_file_cache_purge
-- 
2.30.2

