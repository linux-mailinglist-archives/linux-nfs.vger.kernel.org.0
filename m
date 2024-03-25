Return-Path: <linux-nfs+bounces-2459-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED3888A15C
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 14:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB852C6BAB
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1810B1591F0;
	Mon, 25 Mar 2024 09:37:08 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455AA29C6A3
	for <linux-nfs@vger.kernel.org>; Mon, 25 Mar 2024 03:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338134; cv=none; b=p9QxHjNJbnul/7RAHci1rbYM3YqGfPKRctHBqDSNeR6Ilv8OAUTyosm26aEL8zgCBpeLxQrqYCL3mTlnzQ079fSOr7w4onZs989cLX8GLo1bHmr9q6Tpe6P9Ae6fuSRN1ZP/WEUj4KGuPDLLTqRGN7cNyU316YVIZd9J89z4iFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338134; c=relaxed/simple;
	bh=rMJExkdxcao5LP8nFgzB/jutp0C0aJ7kBMQv5hcs844=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ux27hzIl66ygUGzIOUT+33I106pd+Fjkcx4J/Co7CUMsV4wYhuv05crbtG8w6wSG/UVZ0ocqbgn8hf25ckwb8jW5U67hunWCVyzX5AFHPmY/g1NAc+6imZ44ljkJuY4MJUis/G1ACJ3XRVy5C7e65Zz2fg1YTJZgKx3iMXvP9TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V2zFb0SlYz1R89h;
	Mon, 25 Mar 2024 11:39:31 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id E886B140412;
	Mon, 25 Mar 2024 11:42:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 11:42:08 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Dennis Zhou
	<dennis@kernel.org>
CC: <linux-nfs@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] fs: nfsd: use group allocation/free of per-cpu counters API
Date: Mon, 25 Mar 2024 12:10:19 +0800
Message-ID: <20240325041019.52998-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Use group allocation/free of per-cpu counters api to accelerate
nfsd_percpu_counters_init/destroy() and simplify code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 fs/nfsd/stats.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index be52fb1e928e..c7f481d180f8 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -75,18 +75,7 @@ DEFINE_PROC_SHOW_ATTRIBUTE(nfsd);
 
 int nfsd_percpu_counters_init(struct percpu_counter *counters, int num)
 {
-	int i, err = 0;
-
-	for (i = 0; !err && i < num; i++)
-		err = percpu_counter_init(&counters[i], 0, GFP_KERNEL);
-
-	if (!err)
-		return 0;
-
-	for (; i > 0; i--)
-		percpu_counter_destroy(&counters[i-1]);
-
-	return err;
+	return percpu_counter_init_many(counters, 0, GFP_KERNEL, num);
 }
 
 void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num)
@@ -99,10 +88,7 @@ void nfsd_percpu_counters_reset(struct percpu_counter counters[], int num)
 
 void nfsd_percpu_counters_destroy(struct percpu_counter counters[], int num)
 {
-	int i;
-
-	for (i = 0; i < num; i++)
-		percpu_counter_destroy(&counters[i]);
+	percpu_counter_destroy_many(counters, num);
 }
 
 int nfsd_stat_counters_init(struct nfsd_net *nn)
-- 
2.41.0


