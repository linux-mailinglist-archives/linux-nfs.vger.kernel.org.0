Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22575701F0
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 14:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiGKMY6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 08:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiGKMY5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 08:24:57 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B14745F5D
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 05:24:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so2913760wmb.3
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 05:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W1g5zhWfP8CsGPm+EzrhExm1EVcUmlgjjj9A2VEkEng=;
        b=BSG9JE6C3u+1Cf+X+wDzCgzg6cRIkNzLCjVFOE814fRyacmuis5IFfwfNBo6QMR8Xm
         7bdFxv1AdwzkwKAjd+AQIC7zo4WvdMp9zpe9aGSle3WIaRqq8gr9mbqC06h7mP/T+yRT
         B6g9x1dARgpvrJfcDRVx4GB7bQZ7TPAMqGMl91pMB9HCfKNkAQUmKy35OOO67tRxWtgI
         kY1AjMH6kMaHTKQ5T967BDDZh9VT23ppddQeTwPdxYbqPWjMCMXMnGCXhv2YETfkmutk
         vjISzxR2lH+bF3W7UzoiwkC2dvh5i+WgOnq4OPEUcRJipV80tt0NmQJNpsieWYqQ/MYP
         p6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W1g5zhWfP8CsGPm+EzrhExm1EVcUmlgjjj9A2VEkEng=;
        b=jhJOucVeZ75yQP0tYV0YKGZzrQL+duzdzuYkBvzmLxwwgvLQVzK8dZa7hbIFvmMvQy
         75JlLbzinMC5gjxAr0GlkEe8EUv+AfyddHRAfRU+EoYG/1kA84Y9ohHsayfS3M+KPinm
         gfYnwHftwjse3vc/QG6J+F4dJiXDDdgT0ExNWa4QKAl34KN0N70lVkTHFFmnqUITd6Zj
         RTE9Iq164yvkHWtfnzNLxcYCn2guWkU7bJ/Y/nTzIfdQ7WiDpFYX5bN6lOo1sI4wzQDs
         PNXvN9r1XAZDCwzkmOxTJaF5oDQzwSv16QABvqrUT/5STsEN6E4U2Nqc+AuYi3noKD0f
         sqrg==
X-Gm-Message-State: AJIora+5rEb+dOrXvm/3SFTiELLmk9F2Cg9CNLkyevzL0r3ZFL2RzPmK
        Uxq/5YVNTpE7thPXo76hARkoSTuOJeqWFw==
X-Google-Smtp-Source: AGRyM1u0ln9J//xmBN8uUvuLMmLkNVkiIeDI/yxsDeiMMcD/lpT87svAIlkuITbVLUEDSPJphUeanA==
X-Received: by 2002:a05:600c:218b:b0:3a1:8e79:df6 with SMTP id e11-20020a05600c218b00b003a18e790df6mr15634437wme.29.1657542294807;
        Mon, 11 Jul 2022 05:24:54 -0700 (PDT)
Received: from jupiter.lan ([2a0d:6fc2:4951:4400:aa5e:45ff:fee1:90a8])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600011c200b0021d68a504cbsm5619076wrx.94.2022.07.11.05.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 05:24:54 -0700 (PDT)
From:   Dan Aloni <dan.aloni@vastdata.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] sunrpc: fix expiry of auth creds
Date:   Mon, 11 Jul 2022 15:24:52 +0300
Message-Id: <20220711122452.2720663-1-dan.aloni@vastdata.com>
X-Mailer: git-send-email 2.23.0
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

Before this commit, with a large enough LRU of expired items (100), the
loop skipped the expired items and was entirely ineffectual in trimming
the LRU list.

Fixes: 95cd623250ad ('SUNRPC: Clean up the AUTH cache code')
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Dan Aloni <dan.aloni@vastdata.com>
---
 net/sunrpc/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 682fcd24bf43..2324d1e58f21 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -445,7 +445,7 @@ rpcauth_prune_expired(struct list_head *free, int nr_to_scan)
 		 * Enforce a 60 second garbage collection moratorium
 		 * Note that the cred_unused list must be time-ordered.
 		 */
-		if (!time_in_range(cred->cr_expire, expired, jiffies))
+		if (time_in_range(cred->cr_expire, expired, jiffies))
 			continue;
 		if (!rpcauth_unhash_cred(cred))
 			continue;
-- 
2.23.0

