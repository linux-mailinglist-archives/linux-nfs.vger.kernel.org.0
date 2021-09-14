Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437A940A853
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbhINHpf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbhINHos (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:44:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC30BC0611FB
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:40:37 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id bb10so7612186plb.2
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fApQjSawapzHDI7Jp4q7DITe6weMtnGEUAy+vh573JU=;
        b=O/YTGwiYTLhGu3zNylBhmY2k93u0Y2lSkjAIbiPoY/8oIBOcqiBADUTbRlE5YvFJwl
         Vlbbl20Xg8XU4SoRDQTXXyoR9HoR/1YQiaUlljHj2RLzCiWbhlzfixlETVxdmSv9NBrY
         Yo+BOXrhCu3/FJDcB/OiPGGNbrtM6fpJZcu+ojHAhgMf86G3l3rVkxTEluvWIaUm7Qf/
         aVn1pueVsj8m9v+lck0AGgSt375rpr4reWCRAzMizfeR3eUH+V+1o2H0krk2tVQ50sfP
         Fl4jk/6dizbKw9AQqRNXVQkGAA1kBRGmXj4ns4KVkB6xx3oyth8aS7GWF1KIvNp+rZO5
         /QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fApQjSawapzHDI7Jp4q7DITe6weMtnGEUAy+vh573JU=;
        b=wssyfYZcHZq4qJeqPcrgF1DVRa+T2QErmFKWCN+uHQJLGhUYV0j89P2v2xqRo7/9UY
         AXrq3Mk8LJMVmRpHMjyeRmbVFSaYxafJQEBkXLYxupPTalZxmqqmcMdEWPg8OrO0gnDc
         ykLSqpYXKEPmmvjeRG6v1VaMbWYSaF0bVOZ5iQ9eojOWh0PHuysoX0LCVDHQBoOX0FRr
         EwZfEsW0+XkpJLtTJ059X7kaI7/6nfyDmk7/91H5fszDAlDayA1XtDU4SWhh4f9UneYO
         xivMDhDoePgLnOBtYFCStWli+h6E44xgarH9Dxg+sbvsCD5ywbksSyb7ZOG0rsl9R3ha
         Y7eQ==
X-Gm-Message-State: AOAM531t+7ztrAOqrXEddalpTuBhdwNul8YCK3sJSHWg8x6NB6gFMYkv
        qZv3JUg+5MUwxp/TqmPHiL/9jQ==
X-Google-Smtp-Source: ABdhPJzrBqnGxY3/79/0LfCVIeBfsglBsnuRJJkJ4usqld2XpSAua+m0amwjSViNbLpMZ/tWvievxw==
X-Received: by 2002:a17:902:7b84:b0:13b:90a7:e270 with SMTP id w4-20020a1709027b8400b0013b90a7e270mr9343944pll.21.1631605237377;
        Tue, 14 Sep 2021 00:40:37 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.40.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:40:37 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 64/76] rpc: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:29:26 +0800
Message-Id: <20210914072938.6440-65-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The inode allocation is supposed to use alloc_inode_sb(), so convert
kmem_cache_alloc() to alloc_inode_sb().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 net/sunrpc/rpc_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index ee5336d73fdd..7ed4accc480d 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -197,7 +197,7 @@ static struct inode *
 rpc_alloc_inode(struct super_block *sb)
 {
 	struct rpc_inode *rpci;
-	rpci = kmem_cache_alloc(rpc_inode_cachep, GFP_KERNEL);
+	rpci = alloc_inode_sb(sb, rpc_inode_cachep, GFP_KERNEL);
 	if (!rpci)
 		return NULL;
 	return &rpci->vfs_inode;
-- 
2.11.0

