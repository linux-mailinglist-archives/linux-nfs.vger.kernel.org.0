Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5804911540A
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2019 16:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLFPQ4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Dec 2019 10:16:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40508 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFPQz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Dec 2019 10:16:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so3447916pgt.7;
        Fri, 06 Dec 2019 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6GWdj6y1nIV1eqL/pgj2JGP5rsvKIeTR5YWuhE4vOTY=;
        b=PVlSO2YVN3FeJTHTFmDpe1abRzd3fIG/Wb/SlhKPEvqxWzPRmvzhmwRWJ2DroUirAe
         R68I9pxVWm0rDrRh3snMBO/mf3UKsVQ7YbfY38rS1+BUogpEjp49LFzgc0p3dB1sGIkp
         oL3oZpD48wqhyfh+gIvqhPUJ3BKi03PwX/BQRZLGt2K6o1UxgUfPKNJhx/yPHa6zF7Dw
         xf6W1sQazT+ip4sj92f+SOnfPFsEy0VL2FApQVupSSrB8RREvhBpEWBtxj8Xaktef4qA
         iwCeHBVsofPrSR64f4sg698v5gs8DmlY+41jQs9YubNvqfRjiLtqUgb7sNcBH9Gtju0e
         IeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6GWdj6y1nIV1eqL/pgj2JGP5rsvKIeTR5YWuhE4vOTY=;
        b=uGzadxNB3O1V0HonD6kjpTlh6Y2dajeKDOmchfzI+mc8qPFKq8VAdQudm44T7X6Wl6
         nuo3QtnEz1ogAnMF51vcjETbkhhr3FSuNNRzJCZZbPD8kf0T68kdE5Lp7a9uY6KV2zNi
         5TXwraKVb1S4PsZjEPX9z9N99yA7PqIINPkWazOJICT39Umhe5sMWwMhkJ+NVk/6jKhM
         RpT+SH0K572c6VdxHEGFx+4qtpykaslxfA/EThLoKxhbEZ6RxMnl24y7K9qPlwAhc7ap
         N1dgHc4C4n1lX+vlwdundgm+3hOXnQ/tc5KUZf+V4nUEEKLvo0WHd1qzHjz1Pj6aVGCf
         22bQ==
X-Gm-Message-State: APjAAAWp6G+gb1mXJYjjwY5bpyjfnPIO40ucdxFh2MTVoHd29F45j9iz
        BXeNHLAECTcoepT7NrpuRYj9vbWbzf4=
X-Google-Smtp-Source: APXvYqzZ9KMg19p5ONeiAHEBTca+aoW7E5AL7NEeTSr5C0MAtK8IEDbyN5RDrBKtODwXj+GbqhyXUQ==
X-Received: by 2002:a65:49ca:: with SMTP id t10mr4109186pgs.37.1575645414671;
        Fri, 06 Dec 2019 07:16:54 -0800 (PST)
Received: from localhost.localdomain ([2402:3a80:13a2:f129:b905:c312:4008:2416])
        by smtp.gmail.com with ESMTPSA id o19sm5859347pjr.2.2019.12.06.07.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 07:16:54 -0800 (PST)
From:   madhuparnabhowmik04@gmail.com
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        joel@joelfernandes.org
Cc:     linux-nfs@vger.kernel.org, rcu@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
Subject: [PATCH 2/2] fs: nfs: dir.c: Fix sparse error
Date:   Fri,  6 Dec 2019 20:46:40 +0530
Message-Id: <20191206151640.10966-1-madhuparnabhowmik04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch fixes the following errors:
fs/nfs/dir.c:2353:14: error: incompatible types in comparison expression (different address spaces):
fs/nfs/dir.c:2353:14:    struct list_head [noderef] <asn:4> *
fs/nfs/dir.c:2353:14:    struct list_head *

caused due to directly accessing the prev pointer of
a RCU protected list.
Accessing the pointer using the macro list_prev_rcu() fixes this error.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
---
 fs/nfs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e180033e35cf..2035254cc283 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2350,7 +2350,7 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	rcu_read_lock();
 	if (nfsi->cache_validity & NFS_INO_INVALID_ACCESS)
 		goto out;
-	lh = rcu_dereference(nfsi->access_cache_entry_lru.prev);
+	lh = rcu_dereference(list_prev_rcu(&nfsi->access_cache_entry_lru));
 	cache = list_entry(lh, struct nfs_access_entry, lru);
 	if (lh == &nfsi->access_cache_entry_lru ||
 	    cred != cache->cred)
-- 
2.17.1

