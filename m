Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8654040A87C
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Sep 2021 09:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237842AbhINHr5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 14 Sep 2021 03:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236095AbhINHrO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 14 Sep 2021 03:47:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0416C061A28
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:41:47 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso1457048pji.4
        for <linux-nfs@vger.kernel.org>; Tue, 14 Sep 2021 00:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NN0gBfeiXzYvb6Jp1Xsxd7yBUqMa7ADBolLYHobpZVA=;
        b=PK4VMjGvbH67oZYwUFRv0aAB52OL26OeD5aAWPYin+UtbhnEsqDqPB/EaOguwtEC31
         +H+QEkDREFkUgugOadzHu6DvQ1BzJ/vqhb/+RWLh/+RYyQ8LgKEnWgtfmYOvBJ51exeO
         MZgiFfKhKQnddBedK9WWyA0jmVYyXMDWB0GdLs3Q1eafPpFgDlESnFvNCg/Sy3ThEvhK
         10G0Ha8bAyXS8XFbO1IiOFq2kDgJu71/0l9Y5QP4jAlQFBblZy3Ldk/w59Uu9dAQ/fA+
         2TZgnJVhPh3fHVxylqst68t0JaN8QaVp+O9+z95FKOUk8Ajnp+TT5hDTuCf9KRba1/cO
         xUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NN0gBfeiXzYvb6Jp1Xsxd7yBUqMa7ADBolLYHobpZVA=;
        b=SaGn+rwMaG2nukD6XxKeJ3VHM0nKX5GYQjBN+VO+3GvNMQHOXhwoG95e9ZEiWVITlE
         H9RYkgETgeaXpRPe8UjWVtrrgQ81AOe9e5lO1yW4QtxVFHoa7PuZ/P/SxUjLVwxOcp5F
         GnG4sZ+fNXrMz/N+aVKPDkqU5KhVkg5dCk4rtElUplEZ8ZGvY85a9MOpz4JN06Od/BHw
         tkmMW+qXrgks7Qs6+Lct/+7/HZZAPMZpcdnTftadCwLaQSBML9fA+6agx0MKBf2gr4Hf
         EmBIKFk85GVRHmCMX42A1WSiG0svDU/7AIPOzLNDtAAwYe/qPPzhIp2l4jm7/FBYmxVV
         zZVg==
X-Gm-Message-State: AOAM533eJQwJpMBWcee3eRCi6PbNvKbwui/i4KnhnUmSB5QgYxg3n8DC
        D0amzR1k0RSabef9Q9C3sPQk1Q==
X-Google-Smtp-Source: ABdhPJxeJOzJq9uyWwvOof6i8p5oYTy6e+2JuWR77baYHWZ6FfxGZ4+UTXzFXoerYhN4HhSwEh2Hqg==
X-Received: by 2002:a17:90a:ab07:: with SMTP id m7mr567445pjq.27.1631605307523;
        Tue, 14 Sep 2021 00:41:47 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id s3sm9377839pfd.188.2021.09.14.00.41.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:41:47 -0700 (PDT)
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
Subject: [PATCH v3 74/76] mm: memcontrol: fix cannot alloc the maximum memcg ID
Date:   Tue, 14 Sep 2021 15:29:36 +0800
Message-Id: <20210914072938.6440-75-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210914072938.6440-1-songmuchun@bytedance.com>
References: <20210914072938.6440-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The idr_alloc() does not include @max ID. So in the current implementation,
the maximum memcg ID is 65534 instead of 65535. It seems a bug. So fix this.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e3a2e4d65cc5..28f0aa0a2ce5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5011,7 +5011,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 		return ERR_PTR(error);
 
 	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 MEM_CGROUP_ID_MIN, MEM_CGROUP_ID_MAX,
+				 MEM_CGROUP_ID_MIN, MEM_CGROUP_ID_MAX + 1,
 				 GFP_KERNEL);
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
-- 
2.11.0

