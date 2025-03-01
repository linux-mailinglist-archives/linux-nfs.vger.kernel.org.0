Return-Path: <linux-nfs+bounces-10392-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E18CA4A953
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 07:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97CF0176038
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 06:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B391BE86E;
	Sat,  1 Mar 2025 06:53:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E85D156861;
	Sat,  1 Mar 2025 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740812008; cv=none; b=e6gOwLB3pkl3iAtS5Zn+dINIa1huDqkc5rpocXY6hz+ipT80L0yPkLd5ZMmIcw9hgkpux7BzUJ3PERPDsRiiY/DkUkdBuSPuQuzRFQWvBySoPZ+JZoob4rqTKursO6DA279hQwv8jQJoG3qnuFSrfwbZHuxAwkLmHanRpb7baNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740812008; c=relaxed/simple;
	bh=avlyAo2mFU+WCusiHxsaoeIzSLp/aBamnyHaP4VgmFQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k+MQUX6XgquHWL+qehdxMhndMKVpREg+Rbj2lwME07OOr14/Xkr6yhBP/rowllDH5nwbGlGqSQFlZwCiD0vuQ1LQOmp8D/OGzDGy2IegPEAqVpBRuCqn9U6IInlEsHMg692laSjtQngegNamqUK2Em0M3exy17LNLr4YnswNRns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Z4bK707KHz2Cpqd;
	Sat,  1 Mar 2025 14:49:15 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 57FF71402E0;
	Sat,  1 Mar 2025 14:53:22 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 1 Mar
 2025 14:53:21 +0800
From: Long Li <leo.lilong@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<trondmy@kernel.org>, <anna@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<leo.lilong@huawei.com>, <yangerkun@huawei.com>, <lonuxli.64@gmail.com>
Subject: [PATCH 1/2] sunrpc: update nextcheck time when adding new cache entries
Date: Sat, 1 Mar 2025 14:48:35 +0800
Message-ID: <20250301064836.3285906-2-leo.lilong@huawei.com>
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

The cache_detail structure uses a "nextcheck" field to control hash table
scanning intervals. When a table scan begins, nextcheck is set to current
time plus 1800 seconds. During scanning, if cache_detail is not empty and
a cache entry's expiry time is earlier than the current nextcheck, the
nextcheck is updated to that expiry time.

This mechanism ensures that:
1) Empty cache_details are scanned every 1800 seconds to avoid unnecessary
   scans
2) Non-empty cache_details are scanned based on the earliest expiry time
   found

However, when adding a new cache entry to an empty cache_detail, the
nextcheck time was not being updated, remaining at 1800 seconds. This
could delay cache cleanup for up to 1800 seconds, potentially blocking
threads(such as nfsd) that are waiting for cache cleanup.

Fix this by updating the nextcheck time whenever a new cache entry is
added.

Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 net/sunrpc/cache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 004cdb59f010..d12ab3175d05 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -135,6 +135,8 @@ static struct cache_head *sunrpc_cache_add_entry(struct cache_detail *detail,
 
 	hlist_add_head_rcu(&new->cache_list, head);
 	detail->entries++;
+	if (detail->nextcheck > new->expiry_time)
+		detail->nextcheck = new->expiry_time + 1;
 	cache_get(new);
 	spin_unlock(&detail->hash_lock);
 
-- 
2.39.2


