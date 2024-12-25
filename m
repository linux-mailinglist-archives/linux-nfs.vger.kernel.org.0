Return-Path: <linux-nfs+bounces-8773-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E569FC3DF
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 08:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12E04164514
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 07:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173D214A629;
	Wed, 25 Dec 2024 07:02:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD82D047;
	Wed, 25 Dec 2024 07:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735110175; cv=none; b=SoW5m0QxmmFsaxCpdGZbL8HopQFzcUOmAH2A9m1Mvf2Njs0mcZP5nym0HcwU2+NuGH2LCHHX4YFDVv+e/DX9RTPeQHcgdlj2Wv5DNTYoH1M9YlG6XIr3ws0pSham0wylKk2N6HiTvkEo2mE/7cme/9fwQxerOsvpny+E+ictmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735110175; c=relaxed/simple;
	bh=vidT8T9YlLnxAAHePc0n7zIBnd6lBCoM6Fm5I5wjnQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLQXAts8UXTFQ4cKLcz8m9QackaC+vKKDiwgMS0FvlwpAomgCJaUnLMm0xwwiZqnw5eVZfbhDNaj1BA69auX1JkaFBUfNgPmV5I9FXFFqAPK+QhQ9GY6vmECWKWwyT6q0qKcSN5cLmKKJbkiNYB8BO2wJAnyxIS2IsJ+YxzBFK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YJ2kr1tvxz4f3jY6;
	Wed, 25 Dec 2024 15:02:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EF6471A06D7;
	Wed, 25 Dec 2024 15:02:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4MRrmtnO8dPFg--.38269S5;
	Wed, 25 Dec 2024 15:02:47 +0800 (CST)
From: Yang Erkun <yangerkun@huawei.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com,
	liumingrui@huawei.com
Subject: [PATCH v2 1/4] SUNRPC: introduce cache_check_rcu to help check in rcu context
Date: Wed, 25 Dec 2024 14:59:05 +0800
Message-ID: <20241225065908.1547645-2-yangerkun@huawei.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241225065908.1547645-1-yangerkun@huawei.com>
References: <20241225065908.1547645-1-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHL4MRrmtnO8dPFg--.38269S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyrWFWDJw4xKw13XFyDGFg_yoW5WFy3pa
	s3C34UXrWIgr4xWr43Ar4qvrn3ZrZ3JFy2g34Ik34YywnFkr4rta45WryUCr4UArZxGw4a
	yr15KrWUCF1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCF04k2
	0xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU34SrUUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

This is a prepare patch to add cache_check_rcu, will use it with follow
patch.

Suggested-by: NeilBrown <neilb@suse.de>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 include/linux/sunrpc/cache.h |  2 ++
 net/sunrpc/cache.c           | 41 +++++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index 35766963dd14..e783132e481f 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -222,6 +222,8 @@ static inline bool cache_is_expired(struct cache_detail *detail, struct cache_he
 	return detail->flush_time >= h->last_refresh;
 }
 
+extern int cache_check_rcu(struct cache_detail *detail,
+		       struct cache_head *h, struct cache_req *rqstp);
 extern int cache_check(struct cache_detail *detail,
 		       struct cache_head *h, struct cache_req *rqstp);
 extern void cache_flush(void);
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 059f6ef1ad18..88f42a27c8cc 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -281,21 +281,7 @@ static int try_to_negate_entry(struct cache_detail *detail, struct cache_head *h
 	return rv;
 }
 
-/*
- * This is the generic cache management routine for all
- * the authentication caches.
- * It checks the currency of a cache item and will (later)
- * initiate an upcall to fill it if needed.
- *
- *
- * Returns 0 if the cache_head can be used, or cache_puts it and returns
- * -EAGAIN if upcall is pending and request has been queued
- * -ETIMEDOUT if upcall failed or request could not be queue or
- *           upcall completed but item is still invalid (implying that
- *           the cache item has been replaced with a newer one).
- * -ENOENT if cache entry was negative
- */
-int cache_check(struct cache_detail *detail,
+int cache_check_rcu(struct cache_detail *detail,
 		    struct cache_head *h, struct cache_req *rqstp)
 {
 	int rv;
@@ -336,6 +322,31 @@ int cache_check(struct cache_detail *detail,
 				rv = -ETIMEDOUT;
 		}
 	}
+
+	return rv;
+}
+EXPORT_SYMBOL_GPL(cache_check_rcu);
+
+/*
+ * This is the generic cache management routine for all
+ * the authentication caches.
+ * It checks the currency of a cache item and will (later)
+ * initiate an upcall to fill it if needed.
+ *
+ *
+ * Returns 0 if the cache_head can be used, or cache_puts it and returns
+ * -EAGAIN if upcall is pending and request has been queued
+ * -ETIMEDOUT if upcall failed or request could not be queue or
+ *           upcall completed but item is still invalid (implying that
+ *           the cache item has been replaced with a newer one).
+ * -ENOENT if cache entry was negative
+ */
+int cache_check(struct cache_detail *detail,
+		struct cache_head *h, struct cache_req *rqstp)
+{
+	int rv;
+
+	rv = cache_check_rcu(detail, h, rqstp);
 	if (rv)
 		cache_put(h, detail);
 	return rv;
-- 
2.46.1


