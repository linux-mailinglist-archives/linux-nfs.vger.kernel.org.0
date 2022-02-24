Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3514C30D0
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Feb 2022 17:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiBXQCI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Feb 2022 11:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiBXQCH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Feb 2022 11:02:07 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097F916F941
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:01:28 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m13-20020a7bca4d000000b00380e379bae2so66254wml.3
        for <linux-nfs@vger.kernel.org>; Thu, 24 Feb 2022 08:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+FAmlnfoEU3iGAMqqc0W5/DtwyEAItLWfu/s+LfAkhY=;
        b=OV/1Pcv3W38uWvAGgldeIw9Zcx6zc+naVdoVuMXofRXtsrfvVv26aJJOc4mWc9hAY6
         0ex+RFd0ZYFg+mqwZnb/Pj39/9aji/yuMtHSX9oz+JoMgYE5H0Rgn1iXxdv8vggNm+3r
         yeiREWDwgMxD7Ris93AuoumBXaGpqIvOh/2Kc5vE2EUSqkrU2qzPg5TsWiwKXw1HyDfK
         QYjoHFtjfjZVw89IbkjvSL3L/UkiIR/XZBH9AY4vn2lxm8vurFi7zfBvCNso1XzCGvy3
         j8rFccWuWAJzdpCJ7HG1q4PLIr2aZjxVo1mV96LKnSI5mDmCPNkJytioEQcDr63qw0gi
         xN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+FAmlnfoEU3iGAMqqc0W5/DtwyEAItLWfu/s+LfAkhY=;
        b=KXb929Nvyai3k51G/bqmhrfinJ0dbKr4cLV8J20nc38OvmbW+d59WUD/J915no4d4R
         JDhUW0a8qMcu/Kxjo3XrFSYGYlttnIX+1YMuKl7VPYpARUNENO3iY+69EhUZ9XIcXn1C
         xygwKX+O5CEREoDk0PW/gfakuL1i9HdQhG0MjvXoktwkq0gtn3EfK1jASGVdEJtfnceM
         v5whlGXWlcDweICCLYKKdA2NqlQ0Df8Akodt8emopGTeE3zMHjHv7rlKPKU/sq0PRpV1
         BNjgtGv4gNEJw9GqiAesscTH2/VHpzaLZrMAL8O3YKHIMT5hzFb9DyQgmoYDZL8/4aC1
         3pIw==
X-Gm-Message-State: AOAM532jYR6jPzcmirXKo4yz+UAi82KJM1MJx9U2RHoQjuaMM3BtMCk8
        XPoX6o9/On5jCt1T1XhJMas=
X-Google-Smtp-Source: ABdhPJw+6xF7dDYC6U4mjAeMbAusgXhoyWegkH+4a47WOAoLK4PiGtAfEY8QJAY64xziuW0FUDSRjQ==
X-Received: by 2002:a05:600c:22d1:b0:381:1008:f861 with SMTP id 17-20020a05600c22d100b003811008f861mr2946577wmg.120.1645718485968;
        Thu, 24 Feb 2022 08:01:25 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.153])
        by smtp.gmail.com with ESMTPSA id f14sm3310804wmq.3.2022.02.24.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 08:01:25 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: more robust allocation failure handling in nfsd_file_cache_init
Date:   Thu, 24 Feb 2022 18:01:19 +0200
Message-Id: <20220224160119.1034749-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The nfsd file cache table can be pretty large and its allocation
may require as many as 80 contigious pages.

Employ the same fix that was employed for similar issue that was
reported for the reply cache hash table allocation several years ago
by commit 8f97514b423a ("nfsd: more robust allocation failure handling
in nfsd_reply_cache_init").

Fixes: 65294c1f2c5e ("nfsd: add a new struct file caching facility to nfsd")
Link: https://lore.kernel.org/linux-nfs/e3cdaeec85a6cfec980e87fc294327c0381c1778.camel@kernel.org/
Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/filecache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 8bc807c5fea4..b75cd6d1e331 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -60,6 +60,9 @@ static struct fsnotify_group		*nfsd_file_fsnotify_group;
 static atomic_long_t			nfsd_filecache_count;
 static struct delayed_work		nfsd_filecache_laundrette;
 
+#define NFSD_FILE_HASHTBL_SIZE \
+	array_size(NFSD_FILE_HASH_SIZE, sizeof(*nfsd_file_hashtbl))
+
 static void nfsd_file_gc(void);
 
 static void
@@ -632,8 +635,7 @@ nfsd_file_cache_init(void)
 	if (!nfsd_filecache_wq)
 		goto out;
 
-	nfsd_file_hashtbl = kcalloc(NFSD_FILE_HASH_SIZE,
-				sizeof(*nfsd_file_hashtbl), GFP_KERNEL);
+	nfsd_file_hashtbl = kvzalloc(NFSD_FILE_HASHTBL_SIZE, GFP_KERNEL);
 	if (!nfsd_file_hashtbl) {
 		pr_err("nfsd: unable to allocate nfsd_file_hashtbl\n");
 		goto out_err;
-- 
2.25.1

