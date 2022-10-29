Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830D4611F81
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Oct 2022 05:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiJ2DAL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 23:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiJ2DAK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 23:00:10 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D421F182D
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 19:58:27 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id s9so3884910ilu.1
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 19:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHSK4+puW1giRO3hg1F+7yKFXrBVImrPUiEw439tfWc=;
        b=oNARSNneZutYeT0ch6MSp0tM+3xzdnT0fknuMD8ZejuX3Ra6UiGK7Bhk07lYkKvC8U
         ijLPjERhCFaBPuNsF1UAmC6nJJb2oGKEiXcgb85nHjpUrpfy2gnU2WD9IL4E2qL9te4g
         2LUd/1FrMtxeuMnkw5d90XCVszxjjiXFTYMb+37R6ugezd7p9urE7m7tekT7A/BJ9Koy
         E6yaTt5dE8jDvDfXtUIRuyRKqX8wxmUONI5JcyBHgP2oWe8odgy7QGjpzTLlGqvk/PnL
         zGEZKJrYIacUYaF7jYGhVsZ1kyNhvjNMEbJbssjGTRhEmMYX0QuRMxCkXwhKvmieH73J
         EA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dHSK4+puW1giRO3hg1F+7yKFXrBVImrPUiEw439tfWc=;
        b=7zm3sDUHc46Qzi3MSWyCU0GmBkb/yuG0Oq6e2LjjOkT3ONQDAnUMAew2lN/rUpXsBf
         thd/RpUABRthUxbWaNiqlSBZHW39RynyClwWV7YV1OmGEjLy58l4qOnmdlZbCw30rUNL
         GGVZ7Em8LfB9x5g3JwDkIgQr7aPBvPAw74ycq00xKJQhBIcPksNWh65dxAOCl5JrgmX0
         yhRjAP12xP7ycIvO4mR8nUQHysb/jFPudlmxAJk32ml+B2JVHXXoeXLITic/KawC9K6E
         mJVlFEFy116xm1P8Hp3E/R/fbwLGbQLcKU3OKUS1oGbhA3upU1LKgsS99Aar9JsTw/Aw
         yH1Q==
X-Gm-Message-State: ACrzQf1+LOBuLMFZZYcRKjNHdrzG3AfwvT3It+KSC2LksE7otmMyktyv
        cH0lD40urVtWTtz8Gg8rBVioLiyhDA==
X-Google-Smtp-Source: AMsMyM5FLpPSiW7PzAkPM7lLPyacHHG6eTr+S3jNC4MDy0t3lGxEKI9BZ+84CEHIkIOtWRjEL+/eMQ==
X-Received: by 2002:a05:6e02:1c02:b0:2fa:1594:b7aa with SMTP id l2-20020a056e021c0200b002fa1594b7aamr1145942ilh.263.1667012247021;
        Fri, 28 Oct 2022 19:57:27 -0700 (PDT)
Received: from localhost.localdomain (50-36-85-28.alma.mi.frontiernet.net. [50.36.85.28])
        by smtp.gmail.com with ESMTPSA id q14-20020a02a30e000000b003740de9fb60sm142092jai.132.2022.10.28.19.57.26
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 19:57:26 -0700 (PDT)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFSv4: Fix a credential leak in _nfs4_discover_trunking()
Date:   Fri, 28 Oct 2022 22:51:19 -0400
Message-Id: <20221029025119.10104-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Fixes: 4f40a5b55446 ("NFSv4: Add an fattr allocation to _nfs4_discover_trunking()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 0ae48498c174..69d78d2c1c20 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -4017,7 +4017,7 @@ static int _nfs4_discover_trunking(struct nfs_server *server,
 
 	page = alloc_page(GFP_KERNEL);
 	if (!page)
-		return -ENOMEM;
+		goto out_put_cred;
 	locations = kmalloc(sizeof(struct nfs4_fs_locations), GFP_KERNEL);
 	if (!locations)
 		goto out_free;
@@ -4039,6 +4039,8 @@ static int _nfs4_discover_trunking(struct nfs_server *server,
 	kfree(locations);
 out_free:
 	__free_page(page);
+out_put_cred:
+	put_cred(cred);
 	return status;
 }
 
-- 
2.37.3

