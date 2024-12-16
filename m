Return-Path: <linux-nfs+bounces-8577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCC19F3323
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 15:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916BE1883D62
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 14:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A824020627A;
	Mon, 16 Dec 2024 14:25:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F1A204583;
	Mon, 16 Dec 2024 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359139; cv=none; b=j1w8DJ7hIyTfHv1iRP4SHZzzCJIrCcXxs/b8ELVdnCWKBXK3VlXENZ+2U3kagJBXwRABVDXIVEz8ORYkP9BQtr2Eq/tw/VFxQmAsew7VHqiRuLj692SFtu5Kuk75fhOECHG/vogh3heQ6cQenaBmK5SdBL7eu30rtsG65Wbu49g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359139; c=relaxed/simple;
	bh=PgAUwPqDUvWiFFVRFwNvM76ngEm+LroSmjmmk0sndrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NK51yT9L0VnuHEHCRCBNcyirGeqM1D84ac4mM0Trh1tiCXVuwIhcDUKvTyPziWkYWSlcFeoHUanMR//KDT5oz/eSSNWvUIjGvi1D1uTr6QcwFmnRjiMk+caIB9h6BXUFdAEIngPvMLsHkybXAeX2OAQLuItjbG028zVIo6aRPcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YBj006xbLz4f3jqP;
	Mon, 16 Dec 2024 22:25:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 622A91A0359;
	Mon, 16 Dec 2024 22:25:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHIoZXOGBnSTcXEw--.14700S8;
	Mon, 16 Dec 2024 22:25:35 +0800 (CST)
From: Yang Erkun <yangerkun@huaweicloud.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org
Cc: yangerkun@huawei.com,
	yangerkun@huaweicloud.com,
	yi.zhang@huawei.com
Subject: [RFC PATCH 4/5] SUNRPC: no need get cache ref when protected by rcu
Date: Mon, 16 Dec 2024 22:21:55 +0800
Message-Id: <20241216142156.4133267-5-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241216142156.4133267-1-yangerkun@huaweicloud.com>
References: <20241216142156.4133267-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHIoZXOGBnSTcXEw--.14700S8
X-Coremail-Antispam: 1UD129KBjvJXoW7tr43ZF4ktFyrXrW8Xw4DCFg_yoW8Gr4rpa
	9xCFWIqw4I9r47Xr42yr40qrn5Cr9xtas2qw40kw4Fyw1rXr15Kay0ga4I9rs0qrs3tr4a
	9F1Utr98G34DZaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7sR_b18JUUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: Yang Erkun <yangerkun@huawei.com>

rcu_read_lock/rcu_read_unlock has already protect any ptr we will
when we call c_show. No need get cache ref. Besides, cache_put may drop
the last ref for cache_head, and the .put like expkey_put/svc_export_put
will call dput, which may sleep, and this will break rcu protection.

Fixes: ae74136b4bb6 ("SUNRPC: Allow cache lookups to use RCU protection rather than the r/w spinlock")
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 net/sunrpc/cache.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index eaf4defd1fcf..01745a6f595d 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1425,18 +1425,12 @@ static int c_show(struct seq_file *m, void *p)
 		seq_printf(m, "# expiry=%lld refcnt=%d flags=%lx\n",
 			   convert_to_wallclock(cp->expiry_time),
 			   kref_read(&cp->ref), cp->flags);
-	if (!cache_get_rcu(cp))
-		return 0;
 
-	if (cache_check(cd, cp, NULL)) {
-		cache_put(cp, cd);
+	if (cache_check(cd, cp, NULL))
 		/* cache_check does a cache_put on failure */
 		seq_puts(m, "# ");
-	} else {
-		if (cache_is_expired(cd, cp))
-			seq_puts(m, "# ");
-		cache_put(cp, cd);
-	}
+	else if (cache_is_expired(cd, cp))
+		seq_puts(m, "# ");
 
 	return cd->cache_show(m, cd, cp);
 }
-- 
2.39.2


