Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6665392793
	for <lists+linux-nfs@lfdr.de>; Thu, 27 May 2021 08:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbhE0G2c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 May 2021 02:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbhE0G2T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 May 2021 02:28:19 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90BFC061342
        for <linux-nfs@vger.kernel.org>; Wed, 26 May 2021 23:26:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e15so1839450plh.1
        for <linux-nfs@vger.kernel.org>; Wed, 26 May 2021 23:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UxSxre2wDGLXpYpNahDKZAu3VAo2pfHZzOxhvD0wk18=;
        b=ZKubg9WZzxZUy30dowed69brRlvqEItapcPwLPgZswfpMdJ3cT/WDnRIkB4sOtsBvJ
         RF7PS1NNnnnkDwfJ3P+IMjR8tD0QZW8/88ZGllOgEBMnS1fbZYKJHaulTBoU99agPnhZ
         b7VcpA0nZy7pOhH05kUxqa4Rmfkw/fB2ALHIUiAxdfA17MOhOPuYft4X6x8pVDer+vG4
         ojkmOtmZTMf9QhdmT0rqC8Xtx0DA1msBALyhiqnWNwMWBSYkuIsziIMZ80EwhJkKlu6T
         mAHy106uSOoAlzLgtccHS2Nfo2XjJSHM4jMD4f+S9fyOqzocjIqw4YphBEEcJT8RrEJu
         cyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UxSxre2wDGLXpYpNahDKZAu3VAo2pfHZzOxhvD0wk18=;
        b=rVbCVq6bDzV1zxNC+43djaNUfOKgBkK/r2esjsO5MGqZ3AHlii6nOzYO6W+01mE/o1
         H4UWghTjqLWrYj6fod1D4ZsZKlFYfWstPQez2on4uMGBxlZlYCjcilnKP8NRseubS6LF
         1OSraHEI9GhSwr7TEpafBaQlq77B6PJaf2DDMDYZ6FvXrRoO0Sk7siJB+6cV+ypT62HU
         vQcDjCVE43oSCsMYOtdfmL71/jnc5sM7+yeop/GfQ8yunpTuRF9qtLo1yYlywI8BbGWw
         gIW4Xma/pxyt/CFYP+P2xuX7ZjWEMK5mwFUN4dBbSapl5QBo4Zfm+DzATO/KKrHLwz0O
         pGTQ==
X-Gm-Message-State: AOAM531rZkxLJrwGZOC3yhfqQMa0lt2tfMsOeGxESF65aS0N2CccHVsT
        DlSj1c7DUX9GlKE/S6EiVfsXrw==
X-Google-Smtp-Source: ABdhPJyLAUuIAkmyYhUp7SVzVwB+y2sVQYdILO46NBcSQ91Ugrj375USQf1NBRX88v2oz8WRagoiDA==
X-Received: by 2002:a17:90a:4a89:: with SMTP id f9mr7889513pjh.50.1622096796281;
        Wed, 26 May 2021 23:26:36 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id m5sm882971pgl.75.2021.05.26.23.26.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 May 2021 23:26:35 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     willy@infradead.org, akpm@linux-foundation.org, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, shakeelb@google.com,
        guro@fb.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, david@fromorbit.com,
        trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        zhengqi.arch@bytedance.com, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 19/21] mm: memcontrol: fix cannot alloc the maximum memcg ID
Date:   Thu, 27 May 2021 14:21:46 +0800
Message-Id: <20210527062148.9361-20-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210527062148.9361-1-songmuchun@bytedance.com>
References: <20210527062148.9361-1-songmuchun@bytedance.com>
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
index ae3ad1001824..a1c8ec858593 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5044,7 +5044,7 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 		return ERR_PTR(error);
 
 	memcg->id.id = idr_alloc(&mem_cgroup_idr, NULL,
-				 1, MEM_CGROUP_ID_MAX,
+				 1, MEM_CGROUP_ID_MAX + 1,
 				 GFP_KERNEL);
 	if (memcg->id.id < 0) {
 		error = memcg->id.id;
-- 
2.11.0

