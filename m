Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA511764D88
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jul 2023 10:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234424AbjG0IgJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Jul 2023 04:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbjG0Ifw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Jul 2023 04:35:52 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B699D6E85
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jul 2023 01:19:19 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1a2dd615ddcso157403fac.0
        for <linux-nfs@vger.kernel.org>; Thu, 27 Jul 2023 01:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690445958; x=1691050758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bO4yc6b0222dRNj48HoFyPuU9QjRVolFKKVhhMGpLKw=;
        b=YcIeIH2jVpttruhPboXLE2g2TiXg64jsSv5nDO9Myuw4Dj6q564Uz4+6FPQcC1t8Y2
         LmcM7wMRaovdh5tweBhxInaRMQAGTMB/9T5TbUfCGnW2me2UH+6SAsl6PqsSNirN481W
         VisJnxyzzjIuZEKcqeyW2X19mX3/Jeggy55EGtRt2vjgI3z8Qv67pTk1VfHFIDk838Bw
         OiRjQMQYfmYrKh0az7Ve//f8Xd33j+Snrg/7GA/95e427Xk2ZIipm7SPxpnztycf1GRw
         Ff+6aobpyz0dPimhY8dh7wH6GEi/ovrX2+lugpTenBgDXb4mUlPE5TdQYKKsSs1/4hqe
         9BwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690445958; x=1691050758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bO4yc6b0222dRNj48HoFyPuU9QjRVolFKKVhhMGpLKw=;
        b=EJI7AID+I0Vqh88KKCk2bTv3YsKm7xTxrUeWvGXh3PyYER1wehYlIScqUUWhcypcFq
         EsEKxe8LgyKCDqj9NiKmzYYHnlZfcX+dtCwm3O6+eDaqyqdR0w1pjc5A4wfJKVAir8mu
         gZ2PrC26V6mLNWDWNsDywLg9iQMYi88rk5zPfSsbyJ9gXzmCsn0zyhSXuFK4jn22i9hu
         1VMl18L9M5nJe/+4pZrGQsLNeWB2Wo0XbnCsLcJwzWlHa9gYKaNCV6a5hQJ7yBeW+7j+
         fgpL+NTh0eUz1P6P25LAri6vu7/tC6ZAwSzHw8kLRR02RzsP3s3snL7XFx5gzm8VGeCB
         mOLQ==
X-Gm-Message-State: ABy/qLZXBhaTPfwfB7JFkxg5CNBDVvVvJ2YR+LhG448OKj7QCu1588v9
        9eDpeNk2t2sgXb9oo4/FHr8qZcszM4TDxnSPHi0=
X-Google-Smtp-Source: APBJJlEtjuu7JvMViG/zI1+BRK6QgnXajX34xFKdSMMqB1WswZOW9mIhLIlLvIrLtx031P4ulw5hGg==
X-Received: by 2002:a05:6a20:9381:b0:137:8f19:1de7 with SMTP id x1-20020a056a20938100b001378f191de7mr6160325pzh.0.1690445259706;
        Thu, 27 Jul 2023 01:07:39 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id j8-20020aa78d08000000b006828e49c04csm885872pfe.75.2023.07.27.01.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:07:39 -0700 (PDT)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, gregkh@linuxfoundation.org,
        muchun.song@linux.dev
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
Subject: [PATCH v3 09/49] xenbus/backend: dynamically allocate the xen-backend shrinker
Date:   Thu, 27 Jul 2023 16:04:22 +0800
Message-Id: <20230727080502.77895-10-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
References: <20230727080502.77895-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use new APIs to dynamically allocate the xen-backend shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/xen/xenbus/xenbus_probe_backend.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
index da96c260e26b..929c41a5ccee 100644
--- a/drivers/xen/xenbus/xenbus_probe_backend.c
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -284,13 +284,9 @@ static unsigned long backend_shrink_memory_count(struct shrinker *shrinker,
 	return 0;
 }
 
-static struct shrinker backend_memory_shrinker = {
-	.count_objects = backend_shrink_memory_count,
-	.seeks = DEFAULT_SEEKS,
-};
-
 static int __init xenbus_probe_backend_init(void)
 {
+	struct shrinker *backend_memory_shrinker;
 	static struct notifier_block xenstore_notifier = {
 		.notifier_call = backend_probe_and_watch
 	};
@@ -305,8 +301,16 @@ static int __init xenbus_probe_backend_init(void)
 
 	register_xenstore_notifier(&xenstore_notifier);
 
-	if (register_shrinker(&backend_memory_shrinker, "xen-backend"))
-		pr_warn("shrinker registration failed\n");
+	backend_memory_shrinker = shrinker_alloc(0, "xen-backend");
+	if (!backend_memory_shrinker) {
+		pr_warn("shrinker allocation failed\n");
+		return 0;
+	}
+
+	backend_memory_shrinker->count_objects = backend_shrink_memory_count;
+	backend_memory_shrinker->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(backend_memory_shrinker);
 
 	return 0;
 }
-- 
2.30.2

