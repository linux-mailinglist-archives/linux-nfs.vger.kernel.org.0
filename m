Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B33DF40A86D
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbhINHq4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbhINHqI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:46:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE66C0613A6
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:41:11 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w19so6964152pfn.12
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4T6fbnji2w+O5LBzPcVogdbENpOl+aUZAj36pVasjlI=;
        b=iBv7u24cPtEPUSq433+Xa+dG3Lc2xTpAdIaCPxf4NFQpUIoMOOuO6yeJJrZ0t07NNY
         WQyPjqujIL8pKRWq3AFaOmwgjL6/jcxC+HJKlE/LGHMOz026mWZ/gXP9qP1dX3IPVdTL
         1VTsRC2FR+M2gRiYgJKaQ6F69qpGKWjXouYo72fR3U4H4SIVU/ErAvOyXafFheiBsqZJ
         uuq3xVcdEUoe6tWl43opKGQIlaB2/7sMyU/6HbcikcWolgMF9Poa8jJXSDq4rFqtoMC2
         0deJk112ody2ZouGBhxpf9G/UTlvUX1BQ/BiscDt0L03FRwTE73OthtYVNsKatIwHAkk
         MjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4T6fbnji2w+O5LBzPcVogdbENpOl+aUZAj36pVasjlI=;
        b=43+NCPpC772sCWHqFnfNWVU0ZIu31CawY2N6VQVpCpUQGV3FbJxl6EybLkqXXoK3P0
         1OHmOzTLoUEQU7A3B+QWiRz01v80CgVbr1fnNDTFcV4sEOpmudHyka56Dt5uMAwA4mOy
         c9dsl0biqMDB2/Kc9HLN+xuyy82oAdRPYcIYxc0upTIWT+SXqtxn35a49Zl4DX93nynz
         HFuPCJXs9MfTBW/GZ/4Oqq8091yzirTfPjW+jDHWgQQO/gVuI4zK5yDDq7b/Y0ZcMavp
         7I5Wlox1pFzkrjfaqFYLTKTcYxhp2KzYP/NzX0n/zaoBMDWBmfPFMhfcZXFhFkmhPGEh
         anaw==
X-Gm-Message-State: AOAM531Mc5PESGLnPXIbtsQVD1G2slAKsdCmhbXDCEQCTAITypOaHsvE
        XqrvKg3ZMJvbNHXFQ1RpGg+Zkg==
X-Google-Smtp-Source: ABdhPJyTeptvaUP+2ev79oZqEGP7c6/d9yXSdY08Q82N9/DM1qNzvHM+i0fpNv7p17+zTU3QE2O/2A==
X-Received: by 2002:a63:e516:: with SMTP id r22mr14522315pgh.197.1631605271555;
        Tue, 14 Sep 2021 00:41:11 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.41.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:41:11 -0700 (PDT)
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
Subject: [PATCH v3 69/76] mm: workingset: use xas_set_lru() to pass shadow_nodes
Date:   Tue, 14 Sep 2021 15:29:31 +0800
Message-Id: <20210914072938.6440-70-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The workingset will add the xa_node to shadow_nodes, so we should use
xas_set_lru() to pass the list_lru which we want to insert xa_node
into to set up the xa_node reclaim context correctly.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/swap.h | 5 ++++-
 mm/workingset.c      | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index cdf0957a88a4..629262582eb9 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -334,9 +334,12 @@ void workingset_activation(struct folio *folio);
 
 /* Only track the nodes of mappings with shadow entries */
 void workingset_update_node(struct xa_node *node);
+extern struct list_lru shadow_nodes;
 #define mapping_set_update(xas, mapping) do {				\
-	if (!dax_mapping(mapping) && !shmem_mapping(mapping))		\
+	if (!dax_mapping(mapping) && !shmem_mapping(mapping)) {		\
 		xas_set_update(xas, workingset_update_node);		\
+		xas_set_lru(xas, &shadow_nodes);			\
+	}								\
 } while (0)
 
 /* linux/mm/page_alloc.c */
diff --git a/mm/workingset.c b/mm/workingset.c
index e9cc99ebdec7..5a38c08ca1c4 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -428,7 +428,7 @@ void workingset_activation(struct folio *folio)
  * point where they would still be useful.
  */
 
-static struct list_lru shadow_nodes;
+struct list_lru shadow_nodes;
 
 void workingset_update_node(struct xa_node *node)
 {
-- 
2.11.0

