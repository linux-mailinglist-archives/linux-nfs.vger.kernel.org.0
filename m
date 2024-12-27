Return-Path: <linux-nfs+bounces-8805-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993E89FD1EB
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 09:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45C713A0659
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 08:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E231531C5;
	Fri, 27 Dec 2024 08:21:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918971494BB;
	Fri, 27 Dec 2024 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735287662; cv=none; b=ncka2He4gxh6UpQIy0gy7kplf9M3BWzNAWlYuUS2zy2qK8w2k5nrOT0tJX8qEkjhyuQ0SCGvrAx6e0GOj9MJgSaVIb0UfXTi3yuoo6I5shMXdeIZcZ6j2p/HcA0Vs+Xrm47cxbSPn8NzMNtKIACGKqVXu4aHX4uT/EkqcZWOWPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735287662; c=relaxed/simple;
	bh=05kbuwqOkLanbtrlhrSe908PQnABuXyswDzRRU2cp2Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fAzXKKFfo4plhyMg5bqiiSo24vsP9QzqOz6lgXHgskyk3n/PhH6Ls45qnSeCtm5rYbVFRoDqUT0cJxgr6ADAUmET8zI3+m6WwWE/wwnGVoHAeREhdC5P3DBd9uT0Mv5ilPjfcPIvEldU/I7yamFvcSg//yu/tutTLFpGLqA6jJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YKJJt5M9TzgZRh;
	Fri, 27 Dec 2024 16:17:50 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id D2F9E140156;
	Fri, 27 Dec 2024 16:20:50 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Dec
 2024 16:20:49 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <okorniev@redhat.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <liujian56@huawei.com>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH] sunrpc: clean cache_detail immediately when flush is written frequently
Date: Fri, 27 Dec 2024 16:33:53 +0800
Message-ID: <20241227083353.4125224-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500017.china.huawei.com (7.202.181.81)

We will write /proc/net/rpc/xxx/flush if we want to clean cache_detail.
This updates nextcheck to the current time and calls cache_flush -->
cache_clean to clean cache_detail.
If we write this interface again within one second, it will only increase
flush_time and nextcheck without actually cleaning cache_detail.
Therefore, if we keep writing this interface repeatedly within one second,
flush_time and nextcheck will keep increasing, even far exceeding the
current time, making it impossible to clear cache_detail through the flush
interface or cache_cleaner.
If someone frequently calls the flush interface, we should immediately
clean the corresponding cache_detail instead of continuously accumulating
nextcheck.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 net/sunrpc/cache.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 059f6ef1ad18..73668df0450b 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1531,9 +1531,13 @@ static ssize_t write_flush(struct file *file, const char __user *buf,
 	 * or by one second if it has already reached the current time.
 	 * Newly added cache entries will always have ->last_refresh greater
 	 * that ->flush_time, so they don't get flushed prematurely.
+	 *
+	 * If someone frequently calls the flush interface, we should
+	 * immediately clean the corresponding cache_detail instead of
+	 * continuously accumulating nextcheck.
 	 */
 
-	if (cd->flush_time >= now)
+	if (cd->flush_time >= now && cd->flush_time < (now + 5))
 		now = cd->flush_time + 1;
 
 	cd->flush_time = now;
-- 
2.31.1


