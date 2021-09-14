Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DCB40A7D4
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240971AbhINHjA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241630AbhINHic (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:38:32 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63205C0617AB
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:36:19 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id w7so11906315pgk.13
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+jHdCSClltB9FI22Ll4F7nlE0cYnSoMAJ/pgRqeUyY=;
        b=Qa1CB41JszknO5iUAFVKP5tnoMJ5zaTdsFCurqvfaQAPp2j+/PIYhmIvkWtZVe0jM+
         mTysdz133i3FgFs75Ssv6HINhWeujFnA53YdMT4O2pr+ZrXb4UFFiJwZOZ4v1eVX/n+/
         P7PDvo/ufosDKLazyo7XH3kXoOm9AODc3zs7szd4sewKkN+ZrA8fgvMWkoK2unm+G5lt
         E/TsooaWK4vn6GXWxGlBcdwaBGzHSFvP7BdG0zcaxaSG/Zd7EqyaCNA4YQjgeiDlFyba
         +RfFyYSpuu6CnzQRPSftWc2TiZ3x5D4o1Pj69L8wB+fbArnp9BfE1BxaDLyyZyITahUr
         s05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+jHdCSClltB9FI22Ll4F7nlE0cYnSoMAJ/pgRqeUyY=;
        b=kWPrZXXEsa1IE+sGBP53M7MkqOprrJCwTJQ7DS9TM4yS/xgCNrgI3Zne6htuAoT6W1
         58JisOW1j0efSRKcGv/dqT7Omtu1ZFErYwpMgBXVHyowLeaoO7LRlfIenh3wy6UysGy7
         DbhfNfycMCjPqJFNLrFn5MFd9O2wiNu2Er7LEIjaqtqDh7MBtXPuwZ2/dvwVIZGIg9ET
         4dBUDhNUL7Izsyf2NfdGL8ZTkqw2+qHOuCgKV2EQXVY+qz+PMo8YLuiNp/+8PxV3c6/a
         AxxGUlxI3sSDU/6s7WF9rvH9IdWRa/VdaA5hBIVjvj62mWdKknN29wo5hf/v76eIHHTg
         4AAQ==
X-Gm-Message-State: AOAM5334NSOPCtvRAXhGKKs36LmVLWvUju8ZdrMPFjNETtxUlWbPstpU
        Oah58r3dBBRtYkDiQefOCV5+kri9hR0ylg==
X-Google-Smtp-Source: ABdhPJwctFphhFhWs/bWkeeC0RdCL1kXqNOlfsHVSrc2XDnpWHndExIIdyOPD0y3DZaVEx7ikQY2tA==
X-Received: by 2002:a05:6a00:21c7:b0:412:bb0b:850d with SMTP id t7-20020a056a0021c700b00412bb0b850dmr3479074pfj.33.1631604978955;
        Tue, 14 Sep 2021 00:36:18 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.36.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:36:18 -0700 (PDT)
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
Subject: [PATCH v3 28/76] fat: allocate inode by using alloc_inode_sb()
Date:   Tue, 14 Sep 2021 15:28:50 +0800
Message-Id: <20210914072938.6440-29-songmuchun@bytedance.com>
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
 fs/fat/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index de0c9b013a85..5439831c725a 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -745,7 +745,7 @@ static struct kmem_cache *fat_inode_cachep;
 static struct inode *fat_alloc_inode(struct super_block *sb)
 {
 	struct msdos_inode_info *ei;
-	ei = kmem_cache_alloc(fat_inode_cachep, GFP_NOFS);
+	ei = alloc_inode_sb(sb, fat_inode_cachep, GFP_NOFS);
 	if (!ei)
 		return NULL;
 
-- 
2.11.0

