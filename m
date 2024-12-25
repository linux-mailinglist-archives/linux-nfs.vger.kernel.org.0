Return-Path: <linux-nfs+bounces-8774-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCE19FC3E1
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 08:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11491646A4
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 07:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859E214F123;
	Wed, 25 Dec 2024 07:02:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE2133991;
	Wed, 25 Dec 2024 07:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735110175; cv=none; b=JD/8UlbpHgt6Y3lnt846Gpoo9mLEocMZsNdf+KE1AKDnx88CwE3tfWlC1khtzVRDTvszs3xo/gBYmpVsL0dxFPJSflLZSCDgAO0yz1dj0Gri86PfIrk2O8MrY/jWbeGRpLu4a3lXPvOgHbkMyKHu3F+nLdSAvERMFK5f9yaSlZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735110175; c=relaxed/simple;
	bh=h8FvtbMGFey6DC4Q+xIfqL4HxGkYXSDYxKfTrOdBfcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/BdWmuoU6nb9Kk4ZIf1V5IFyUtTOAeGxwg5O6FJPjRA1ALqHIlO9550mVlDqn2HrzOc94ylQjhxUIWUsBu3OAE+JKgLkTeRmkcmezw5kx2HeEuqail7Du6D2PpqJtMV/vm/2uzRy7e5z00k8KnhXiOJtozj+tB29ZyLsJXLEF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YJ2ky5cD4z4f3jqs;
	Wed, 25 Dec 2024 15:02:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 679F61A06DA;
	Wed, 25 Dec 2024 15:02:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4MRrmtnO8dPFg--.38269S7;
	Wed, 25 Dec 2024 15:02:49 +0800 (CST)
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
Subject: [PATCH v2 3/4] SUNRPC: no need get cache ref when protected by rcu
Date: Wed, 25 Dec 2024 14:59:07 +0800
Message-ID: <20241225065908.1547645-4-yangerkun@huawei.com>
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
X-CM-TRANSID:gCh0CgAHL4MRrmtnO8dPFg--.38269S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryfXFWktF13JFW3Cr1UAwb_yoW8GF4Dpa
	9xCrWxtrW0qry7Xr42yr48Zrn5Cr9xta4Iq3ykCw4rAw15Xr13tFyjgFy29F4DZrs7tr4a
	vF1UtFW5GryDZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7Iv64x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YV
	CY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCF04k2
	0xvEw4C26cxK6c8Ij28IcwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr
	0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU04v35UUUU
	U==
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

rcu_read_lock/rcu_read_unlock has already provide protection for the
pointer we will reference when we call c_show. Therefore, there is no
need to obtain a cache reference to help protect cache_head.
Additionally, the .put such as expkey_put/svc_export_put will invoke
dput, which can sleep and break rcu. Stop get cache reference to fix
them all.

Fixes: ae74136b4bb6 ("SUNRPC: Allow cache lookups to use RCU protection rather than the r/w spinlock")
Suggested-by: NeilBrown <neilb@suse.de>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 net/sunrpc/cache.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 88f42a27c8cc..cb279eb9ac4b 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1438,17 +1438,11 @@ static int c_show(struct seq_file *m, void *p)
 		seq_printf(m, "# expiry=%lld refcnt=%d flags=%lx\n",
 			   convert_to_wallclock(cp->expiry_time),
 			   kref_read(&cp->ref), cp->flags);
-	if (!cache_get_rcu(cp))
-		return 0;
 
-	if (cache_check(cd, cp, NULL))
-		/* cache_check does a cache_put on failure */
+	if (cache_check_rcu(cd, cp, NULL))
+		seq_puts(m, "# ");
+	else if (cache_is_expired(cd, cp))
 		seq_puts(m, "# ");
-	else {
-		if (cache_is_expired(cd, cp))
-			seq_puts(m, "# ");
-		cache_put(cp, cd);
-	}
 
 	return cd->cache_show(m, cd, cp);
 }
-- 
2.46.1


