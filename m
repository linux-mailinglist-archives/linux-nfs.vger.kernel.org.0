Return-Path: <linux-nfs+bounces-10393-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3193DA4A955
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 07:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1604417629D
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 06:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867A31CAA71;
	Sat,  1 Mar 2025 06:53:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3586C156C62;
	Sat,  1 Mar 2025 06:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740812009; cv=none; b=X/U7jvhHLHjxRBchHxe6bVcSGHO6MfpIT7AdB6Mh5DVQQf0Akow+TDbKO66HWgdNlg6HQmO1iMcaQ6CktLFlAKtDnZutBApbbUx2/SLLSVNMnmzUW37M32Sn1yq3jgVVeuPM4/OJifCJkT/72nC06papTxaY+H6FbieG6thJYKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740812009; c=relaxed/simple;
	bh=dibP0T9npb1XSSP1DoTgysZkzWFTRHeVFeqHkNLyq8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFQ4Jbjiq7qZF4GvxfL6X/a3OIXndqUvmzFPw/QNpuJSlJK4x+b+15J40pggGuxDgjfb6pIQ7gax+xxDWwRMcvtIm4NPNQieicqjP5MChw3FBdmKL8sJxs8FcVuKgN6YZT0AaIBpVjHVnfBBUEp3F0ffg+pxY2KUmPBy6Z25aC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z4bN42Mmqz1R5vD;
	Sat,  1 Mar 2025 14:51:48 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 891201A0188;
	Sat,  1 Mar 2025 14:53:24 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 1 Mar
 2025 14:53:23 +0800
From: Long Li <leo.lilong@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<trondmy@kernel.org>, <anna@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<leo.lilong@huawei.com>, <yangerkun@huawei.com>, <lonuxli.64@gmail.com>
Subject: [PATCH 2/2] sunrpc: fix race in cache cleanup causing stale nextcheck time
Date: Sat, 1 Mar 2025 14:48:36 +0800
Message-ID: <20250301064836.3285906-3-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250301064836.3285906-1-leo.lilong@huawei.com>
References: <20250301064836.3285906-1-leo.lilong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500017.china.huawei.com (7.185.36.126)

When cache cleanup runs concurrently with cache entry removal, a race
condition can occur that leads to incorrect nextcheck times. This can
delay cache cleanup for the cache_detail by up to 1800 seconds:

1. cache_clean() sets nextcheck to current time plus 1800 seconds
2. While scanning a non-empty bucket, concurrent cache entry removal can
   empty that bucket
3. cache_clean() finds no cache entries in the now-empty bucket to update
   the nextcheck time
4. This maybe delays the next scan of the cache_detail by up to 1800
   seconds even when it should be scanned earlier based on remaining
   entries

Fix this by moving the hash_lock acquisition earlier in cache_clean().
This ensures bucket emptiness checks and nextcheck updates happen
atomically, preventing the race between cleanup and entry removal.

Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 net/sunrpc/cache.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index d12ab3175d05..b2db0dee3622 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -464,24 +464,21 @@ static int cache_clean(void)
 		}
 	}
 
+	spin_lock(&current_detail->hash_lock);
+
 	/* find a non-empty bucket in the table */
-	while (current_detail &&
-	       current_index < current_detail->hash_size &&
+	while (current_index < current_detail->hash_size &&
 	       hlist_empty(&current_detail->hash_table[current_index]))
 		current_index++;
 
 	/* find a cleanable entry in the bucket and clean it, or set to next bucket */
-
-	if (current_detail && current_index < current_detail->hash_size) {
+	if (current_index < current_detail->hash_size) {
 		struct cache_head *ch = NULL;
 		struct cache_detail *d;
 		struct hlist_head *head;
 		struct hlist_node *tmp;
 
-		spin_lock(&current_detail->hash_lock);
-
 		/* Ok, now to clean this strand */
-
 		head = &current_detail->hash_table[current_index];
 		hlist_for_each_entry_safe(ch, tmp, head, cache_list) {
 			if (current_detail->nextcheck > ch->expiry_time)
@@ -502,8 +499,10 @@ static int cache_clean(void)
 		spin_unlock(&cache_list_lock);
 		if (ch)
 			sunrpc_end_cache_remove_entry(ch, d);
-	} else
+	} else {
+		spin_unlock(&current_detail->hash_lock);
 		spin_unlock(&cache_list_lock);
+	}
 
 	return rv;
 }
-- 
2.39.2


