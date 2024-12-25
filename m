Return-Path: <linux-nfs+bounces-8771-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B06F99FC3DB
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 08:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E7637A1120
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Dec 2024 07:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E66313CA9C;
	Wed, 25 Dec 2024 07:02:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20144315A;
	Wed, 25 Dec 2024 07:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735110174; cv=none; b=c3o9MPoOJFDdDYl0HhGjrLC9gaktmQzhloa+lzO0qiuaX5Kcyv+65U6xrbffNL+n4ILAd3uKBZF+lweKRde5pclLNU0agcTSkeSjCpd6WjU/hFsZt8cXwokAtmV5OJRlmrY/QDsSiUV9trP39V+1lkkx8Toe0qijCV7vpGW2Cv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735110174; c=relaxed/simple;
	bh=aeL9mbeypXdTxExMFMbyDFB2uk41TANLulFVz5be+jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHMO5ozPhNxMfRisC11jNs5pOi67MJcfKIHKH3ZfZN6XONox87ltqYDDlBUNMYAu7Wc8SKGR7ifgwEShUeUZWMeXf060qB3eAwB5GcUNO0kSDfD1GNGpDNvkvZJhK90nGeCVxHxQ4wgwK3CsqyRUeO+TSyiKODDxjYlypOe85G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YJ2ks07z4z4f3jR1;
	Wed, 25 Dec 2024 15:02:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B42D11A018D;
	Wed, 25 Dec 2024 15:02:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgAHL4MRrmtnO8dPFg--.38269S6;
	Wed, 25 Dec 2024 15:02:48 +0800 (CST)
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
Subject: [PATCH v2 2/4] nfsd: no need get cache ref when protected by rcu
Date: Wed, 25 Dec 2024 14:59:06 +0800
Message-ID: <20241225065908.1547645-3-yangerkun@huawei.com>
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
X-CM-TRANSID:gCh0CgAHL4MRrmtnO8dPFg--.38269S6
X-Coremail-Antispam: 1UD129KBjvdXoW7JFy5WrWfWF13Xr1xGw13CFg_yoWDKFcE9a
	18Wa4Duws8ZFsxJF1akw45tFy7uayqyF45Kr4rKrZxKry5tFyktrykt3s5Ar9xCw4j9F93
	Ar1DCw1fWw4a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbl8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
	8IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACjsIEF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6x
	kF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxAIw28I
	cVAKzI0EY4vE52x082I5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJV
	W8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIsqWUUUUU
Sender: yangerkun@huaweicloud.com
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

rcu_read_lock/rcu_read_unlock has already provide protection for the
pointer we will reference when we call e_show. Therefore, there is no
need to obtain a cache reference to help protect cache_head.
Additionally, the .put such as expkey_put/svc_export_put will invoke
dput, which can sleep and break rcu. Stop get cache reference to fix
them all.

Fixes: ae74136b4bb6 ("SUNRPC: Allow cache lookups to use RCU protection rather than the r/w spinlock")
Suggested-by: NeilBrown <neilb@suse.de>
Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/nfsd/export.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index aa4712362b3b..c6168bccfb6c 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1425,13 +1425,9 @@ static int e_show(struct seq_file *m, void *p)
 		return 0;
 	}
 
-	if (!cache_get_rcu(&exp->h))
+	if (cache_check_rcu(cd, &exp->h, NULL))
 		return 0;
 
-	if (cache_check(cd, &exp->h, NULL))
-		return 0;
-
-	exp_put(exp);
 	return svc_export_show(m, cd, cp);
 }
 
-- 
2.46.1


