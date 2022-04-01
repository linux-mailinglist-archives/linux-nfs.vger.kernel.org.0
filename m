Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE2E4EE659
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Apr 2022 05:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbiDADBJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Mar 2022 23:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244294AbiDADBI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Mar 2022 23:01:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED65150406
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 19:59:20 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n18so1312589plg.5
        for <linux-nfs@vger.kernel.org>; Thu, 31 Mar 2022 19:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jpgRpHXdOgwFJs3Rr/mje+m8UWm4Vip9nY8eSHdbgSU=;
        b=YE8E18tDAxZzfQ3y/87fqDtCVg3M4Hfk1iGsoXYME+FfcsD/HPIKQDPI1wvT8TGMr7
         oTyM9sDo0laBVHOUzFczMe7lNEAPtkMz4JfD2RTCng5Lo6UzPaz2mz/fNWXvY+LuPg3L
         c0d9JDYw1m5/M2FSptRnBYi6jdqXuu/Ds/sy2aC5AlTQpvJR0oXLZbQ3PI8fSIFRJ+m+
         MkCnUcOfaYwtwDmOZsUhwGNSOxbCU4rAwYyyp9ZOENRLaSKP4m/CCTMEa5V3QGlPyPL9
         yZv/NLBoCePdnO1a8/rSX8RLne8t3OJSkAMN0dDI1pV9YXEX5UX+JbmtYpRXV+pGJvUg
         IyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jpgRpHXdOgwFJs3Rr/mje+m8UWm4Vip9nY8eSHdbgSU=;
        b=J44eJM6OdQaGVBARibQNw/zZbvdVS30pNtwPauTiRd3wjbo8rPpVXBGUK5WiJdmCae
         1TD4dZsoR9UnSo8eIEqvfpWsxGCPK//y3+0cV1nquns7pFA55jiOnqun3xU8HTT2Q0GU
         h6tg/46w5Wk4NMQJ/Txqcct247LBb0pWbxHzXF0AiLwTCeDuJ0PEnxUS6f1Gc6Lmjr1o
         kJZoO35ajRm75LYaSbMiItpG/ExDPKA9HQ442yupvFg6NQrlS1lCm+5j68MQupL0kWqL
         R+2XqwPUJN7ztXPLf8nzs2NvtyYTuWlOpg59NtLVPTMWIT8sSBtJfj7cSagZfJx/NHR5
         Cmew==
X-Gm-Message-State: AOAM533DEC0lW+loX9FO8gsg+cGvhtJCF3nFYTGiCHq4kMURBmmpPTcA
        eY8wi5DLEQykbtiZw8yiNyuexA==
X-Google-Smtp-Source: ABdhPJwmDpT9N4vRu2KbCmzEQRAdDtOMFlcUnp8fyMwkCkz+OLqLDKgoNSCYJ3sa7xBZVWLoobIsjg==
X-Received: by 2002:a17:903:1252:b0:154:ca85:59a0 with SMTP id u18-20020a170903125200b00154ca8559a0mr8537629plh.169.1648781959884;
        Thu, 31 Mar 2022 19:59:19 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id oo17-20020a17090b1c9100b001bf0ccc59c2sm11566475pjb.16.2022.03.31.19.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 19:59:19 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>,
        NeilBrown <neilb@suse.de>
Subject: [PATCH] NFSv4.2: Fix missing removal of SLAB_ACCOUNT on kmem_cache allocation
Date:   Fri,  1 Apr 2022 10:59:05 +0800
Message-Id: <20220401025905.49771-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The commit 5c60e89e71f8 ("NFSv4.2: Fix up an invalid combination of memory
allocation flags") has stripped GFP_KERNEL_ACCOUNT down to GFP_KERNEL,
however, it forgot to remove SLAB_ACCOUNT from kmem_cache allocation.
It means that memory is still limited by kmemcg.  This patch also fix a
NULL pointer reference issue [1] reported by NeilBrown.

Link: https://lore.kernel.org/all/164870069595.25542.17292003658915487357@noble.neil.brown.name/ [1]
Fixes: 5c60e89e71f8 ("NFSv4.2: Fix up an invalid combination of memory allocation flags")
Fixes: 5abc1e37afa0 ("mm: list_lru: allocate list_lru_one only when needed")
Reported-by: NeilBrown <neilb@suse.de>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/nfs/nfs42xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs42xattr.c b/fs/nfs/nfs42xattr.c
index ad3405c64b9e..e7b34f7e0614 100644
--- a/fs/nfs/nfs42xattr.c
+++ b/fs/nfs/nfs42xattr.c
@@ -997,7 +997,7 @@ int __init nfs4_xattr_cache_init(void)
 
 	nfs4_xattr_cache_cachep = kmem_cache_create("nfs4_xattr_cache_cache",
 	    sizeof(struct nfs4_xattr_cache), 0,
-	    (SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|SLAB_ACCOUNT),
+	    (SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD),
 	    nfs4_xattr_cache_init_once);
 	if (nfs4_xattr_cache_cachep == NULL)
 		return -ENOMEM;
-- 
2.11.0

