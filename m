Return-Path: <linux-nfs+bounces-8580-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5D19F3330
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 15:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9BB166065
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2024 14:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD30D2063F2;
	Mon, 16 Dec 2024 14:25:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DCF206262;
	Mon, 16 Dec 2024 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734359140; cv=none; b=d2cikFOtDfcsd3ly+NfpSmvDPZbdfdv//ptFtoifGd8O2dPJLo6PoXrzVlWo425WFD9tCC7DnuzHW3Uha+4rKb/3Vtr4Pij5r6s1KQX3juUoYOap3qjPxafqk7lo/D9YERC8dhFPC1f8vD9t38bxqTrevsEfFSqcZRtC6yXVkr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734359140; c=relaxed/simple;
	bh=cfVUAignU+1ynTpbAgg+5yw8IE0/TZsz9snTLeLHuPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIPqB/Y9jbFK5O8Yj157FcapKUHq/L8EifDLcbyEnXvCvUyNUmHRckERRrMv2Wwej3zJZyVDLlSaS7W/nMarKJ53P8x3dsovWLQG4zPpupOXYFc6ixsm2c6ri+mmS/3Jaf8z2+fGaOTc58VVlSL3W9WsR+2iw24XcC85sW5iIGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YBhzs68B9z4f3lWF;
	Mon, 16 Dec 2024 22:25:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5546B1A0568;
	Mon, 16 Dec 2024 22:25:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgBHIoZXOGBnSTcXEw--.14700S6;
	Mon, 16 Dec 2024 22:25:34 +0800 (CST)
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
Subject: [RFC PATCH 2/5] SUNRPC: move cache_put out from cache_check
Date: Mon, 16 Dec 2024 22:21:53 +0800
Message-Id: <20241216142156.4133267-3-yangerkun@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBHIoZXOGBnSTcXEw--.14700S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuFWfWrWkCF4rXw4rXr1kZrb_yoW7XF48pF
	Z3A348Xr40grs7Xw4fAr4DZw1rAr93K3ZFgw4Fka13Aw43Xw15GF1ruFyjvr1avrWrWw4a
	kF1UtF4Y9w1DuaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIev
	Ja73UjIFyTuYvjTRJ-BMUUUUU
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: Yang Erkun <yangerkun@huawei.com>

Only do check in cache_check, this is a prepare patch.

Signed-off-by: Yang Erkun <yangerkun@huawei.com>
---
 fs/nfs/dns_resolve.c              |  4 +++-
 fs/nfsd/export.c                  |  6 +++++-
 fs/nfsd/nfs4idmap.c               |  2 ++
 net/sunrpc/auth_gss/svcauth_gss.c |  9 +++++++--
 net/sunrpc/cache.c                |  7 +++----
 net/sunrpc/svcauth_unix.c         | 12 +++++++++++-
 6 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/dns_resolve.c b/fs/nfs/dns_resolve.c
index 714975e5c0db..733163b01795 100644
--- a/fs/nfs/dns_resolve.c
+++ b/fs/nfs/dns_resolve.c
@@ -287,8 +287,10 @@ static int do_cache_lookup(struct cache_detail *cd,
 	*item = nfs_dns_lookup(cd, key);
 	if (*item) {
 		ret = cache_check(cd, &(*item)->h, &dreq->req);
-		if (ret)
+		if (ret) {
+			cache_put(&(*item)->h, cd);
 			*item = NULL;
+		}
 	}
 	return ret;
 }
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index aa4712362b3b..56002d9ef66b 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -953,6 +953,7 @@ exp_find_key(struct cache_detail *cd, struct auth_domain *clp, int fsid_type,
 		return ERR_PTR(-ENOMEM);
 	err = cache_check(cd, &ek->h, reqp);
 	if (err) {
+		cache_put(&ek->h, cd);
 		trace_nfsd_exp_find_key(&key, err);
 		return ERR_PTR(err);
 	}
@@ -978,6 +979,7 @@ exp_get_by_name(struct cache_detail *cd, struct auth_domain *clp,
 		return ERR_PTR(-ENOMEM);
 	err = cache_check(cd, &exp->h, reqp);
 	if (err) {
+		cache_put(&exp->h, cd);
 		trace_nfsd_exp_get_by_name(&key, err);
 		return ERR_PTR(err);
 	}
@@ -1428,8 +1430,10 @@ static int e_show(struct seq_file *m, void *p)
 	if (!cache_get_rcu(&exp->h))
 		return 0;
 
-	if (cache_check(cd, &exp->h, NULL))
+	if (cache_check(cd, &exp->h, NULL)) {
+		cache_put(&exp->h, cd);
 		return 0;
+	}
 
 	exp_put(exp);
 	return svc_export_show(m, cd, cp);
diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index 8cca1329f348..8861e34b5126 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -515,6 +515,8 @@ idmap_lookup(struct svc_rqst *rqstp,
 		return -ENOMEM;
  retry:
 	ret = cache_check(detail, &(*item)->h, &rqstp->rq_chandle);
+	if (ret)
+		cache_put(&(*item)->h, detail);
 
 	if (ret == -ETIMEDOUT) {
 		struct ent *prev_item = *item;
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 73a90ad873fb..c0846adcb65e 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -634,8 +634,11 @@ gss_svc_searchbyctx(struct cache_detail *cd, struct xdr_netobj *handle)
 	rsc_free(&rsci);
 	if (!found)
 		return NULL;
-	if (cache_check(cd, &found->h, NULL))
+	if (cache_check(cd, &found->h, NULL)) {
+		cache_put(&found->h, cd);
 		return NULL;
+	}
+
 	return found;
 }
 
@@ -1194,9 +1197,11 @@ svcauth_gss_legacy_init(struct svc_rqst *rqstp,
 	rsi_free(&rsikey);
 	if (!rsip)
 		return SVC_CLOSE;
-	if (cache_check(sn->rsi_cache, &rsip->h, &rqstp->rq_chandle) < 0)
+	if (cache_check(sn->rsi_cache, &rsip->h, &rqstp->rq_chandle) < 0) {
 		/* No upcall result: */
+		cache_put(&rsip->h, sn->rsi_cache);
 		return SVC_CLOSE;
+	}
 
 	ret = SVC_CLOSE;
 	if (!svcauth_gss_proc_init_verf(sn->rsc_cache, rqstp, &rsip->out_handle,
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 059f6ef1ad18..eaf4defd1fcf 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -336,8 +336,6 @@ int cache_check(struct cache_detail *detail,
 				rv = -ETIMEDOUT;
 		}
 	}
-	if (rv)
-		cache_put(h, detail);
 	return rv;
 }
 EXPORT_SYMBOL_GPL(cache_check);
@@ -1430,10 +1428,11 @@ static int c_show(struct seq_file *m, void *p)
 	if (!cache_get_rcu(cp))
 		return 0;
 
-	if (cache_check(cd, cp, NULL))
+	if (cache_check(cd, cp, NULL)) {
+		cache_put(cp, cd);
 		/* cache_check does a cache_put on failure */
 		seq_puts(m, "# ");
-	else {
+	} else {
 		if (cache_is_expired(cd, cp))
 			seq_puts(m, "# ");
 		cache_put(cp, cd);
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 8ca98b146ec8..df014463c054 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -651,6 +651,10 @@ static struct group_info *unix_gid_find(kuid_t uid, struct svc_rqst *rqstp)
 	if (!ug)
 		return ERR_PTR(-EAGAIN);
 	ret = cache_check(sn->unix_gid_cache, &ug->h, &rqstp->rq_chandle);
+
+	if (ret)
+		cache_put(&ug->h, sn->unix_gid_cache);
+
 	switch (ret) {
 	case -ENOENT:
 		return ERR_PTR(-ENOENT);
@@ -676,6 +680,7 @@ svcauth_unix_set_client(struct svc_rqst *rqstp)
 	struct svc_xprt *xprt = rqstp->rq_xprt;
 	struct net *net = xprt->xpt_net;
 	struct sunrpc_net *sn = net_generic(net, sunrpc_net_id);
+	int check_res;
 
 	switch (rqstp->rq_addr.ss_family) {
 	case AF_INET:
@@ -704,7 +709,12 @@ svcauth_unix_set_client(struct svc_rqst *rqstp)
 	if (ipm == NULL)
 		return SVC_DENIED;
 
-	switch (cache_check(sn->ip_map_cache, &ipm->h, &rqstp->rq_chandle)) {
+	check_res = cache_check(sn->ip_map_cache, &ipm->h, &rqstp->rq_chandle);
+
+	if (check_res)
+		cache_put(&ipm->h, sn->ip_map_cache);
+
+	switch (check_res) {
 		default:
 			BUG();
 		case -ETIMEDOUT:
-- 
2.39.2


