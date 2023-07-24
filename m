Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E844B75EFE2
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jul 2023 11:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjGXJsI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 24 Jul 2023 05:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjGXJrd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 24 Jul 2023 05:47:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112351720
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 02:46:42 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bba9539a23so640745ad.1
        for <linux-nfs@vger.kernel.org>; Mon, 24 Jul 2023 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690192002; x=1690796802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zTxasxXedNYwr5HiD+ktCpinG7wwpmHx5iR9IBn5EM=;
        b=JQ+VYszNneWq9LnVTeEUNZ2bA9JmZI8LOFjK9svc9H4hl8hRyG271LpHarvUCKIyZI
         5Vn1CBHP/6AH5rHqtPGE6/hWSk0SIy6RYK161aZhDGhYtCkOSsB2o0ayijs8INBvePS+
         ybYmPnwAbLpRLtFyM0o4EOx/Hrne48NbEWwKs3diUJ/coEGr8/xoETACnBW25DeyyWC2
         ybnkMyVu7T3nx0cFgEz9x8FtixitWLVj99q7wd/aAYhgB/uAk5tIASLlagkcZ5eA/CFb
         vVvRndH0r/gASWIjyvLt8jh52cZF67TvvoceATQn3UiM+oNvT8rjkWmY1oM8XcntVr02
         2LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690192002; x=1690796802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zTxasxXedNYwr5HiD+ktCpinG7wwpmHx5iR9IBn5EM=;
        b=NINoJQKb84J2CiP6Y1tW2ocmOy/P3WMXHNaCi5YhF/SHcOdkwVHR7PkJA3/YBXVrV+
         vxSnq5cYlmTG9l8VujHSkn7Q0+jqo2Jsa5LvZsrAYh91pX2D8Cxdq65sumZWxsQWUMNM
         qIiqvqZMqJDdarwENCgDhXe0BUzzost+r9bPKu/IqckPhT7yNVg6ZkMbrLZxO6nt/Na7
         15ezTHijiW+tX85J96W53CYgNdOBWqwbYZXf2PHuq+OdetIdiNc0Y8Zq6YJUsoxlBJE5
         wal3UDZejPiUjcPBfKfw5QCc9UY+zG9nnRfjdyt6gqGW95kKWFcdSPcFJkLnWYRHSt0m
         pIJA==
X-Gm-Message-State: ABy/qLak/7YQ5MgZFvzWj1CsmprBEuCjYXzX0WMuP/WH8vgrTAMFhm9c
        KMaajfPXJxI7z0TZAbovIhamUw==
X-Google-Smtp-Source: APBJJlEIhnQwoFDHuweIAHt2tJcWGI0d+r3I5wbhweuAT0TQly4d+VEILSYdnjVlMqhcbUSPWrZO+w==
X-Received: by 2002:a17:903:41c9:b0:1b8:17e8:547e with SMTP id u9-20020a17090341c900b001b817e8547emr12196517ple.1.1690192002389;
        Mon, 24 Jul 2023 02:46:42 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001bb20380bf2sm8467233pld.13.2023.07.24.02.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:46:42 -0700 (PDT)
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
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 08/47] erofs: dynamically allocate the erofs-shrinker
Date:   Mon, 24 Jul 2023 17:43:15 +0800
Message-Id: <20230724094354.90817-9-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
References: <20230724094354.90817-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Use new APIs to dynamically allocate the erofs-shrinker.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 fs/erofs/utils.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index cc6fb9e98899..389de06e1065 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -270,19 +270,25 @@ static unsigned long erofs_shrink_scan(struct shrinker *shrink,
 	return freed;
 }
 
-static struct shrinker erofs_shrinker_info = {
-	.scan_objects = erofs_shrink_scan,
-	.count_objects = erofs_shrink_count,
-	.seeks = DEFAULT_SEEKS,
-};
+static struct shrinker *erofs_shrinker_info;
 
 int __init erofs_init_shrinker(void)
 {
-	return register_shrinker(&erofs_shrinker_info, "erofs-shrinker");
+	erofs_shrinker_info = shrinker_alloc(0, "erofs-shrinker");
+	if (!erofs_shrinker_info)
+		return -ENOMEM;
+
+	erofs_shrinker_info->count_objects = erofs_shrink_count;
+	erofs_shrinker_info->scan_objects = erofs_shrink_scan;
+	erofs_shrinker_info->seeks = DEFAULT_SEEKS;
+
+	shrinker_register(erofs_shrinker_info);
+
+	return 0;
 }
 
 void erofs_exit_shrinker(void)
 {
-	unregister_shrinker(&erofs_shrinker_info);
+	shrinker_unregister(erofs_shrinker_info);
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
-- 
2.30.2

