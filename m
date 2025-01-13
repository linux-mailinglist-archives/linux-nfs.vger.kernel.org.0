Return-Path: <linux-nfs+bounces-9150-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB83A0AD83
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 03:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91151164EBD
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 02:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EA52B2DA;
	Mon, 13 Jan 2025 02:47:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052B63EA83;
	Mon, 13 Jan 2025 02:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736736445; cv=none; b=CH43/IdBOCYLugD++BISN/g4//nYCC1shT4ML4jMsjY981MexphdHmnaTev4hIiMczqzlKCcVAEa43fvAhIR0lJSc2Ru3kkVrJKt4cxL1s3hbNeKzFW+XyCrkO+yJI0X1SeJYv+Z7sMPgMRVynnzzS6oVcMXNBpQlZ2OCoQaonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736736445; c=relaxed/simple;
	bh=4vL2v4bVo2CAOe4JEoQixQXttht238I+31WaVFEDbQk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uuRpBAY4CT3fWC+St00UgcuWv7OAhWM/e9vDrdF24v3tXHAZyf7aYRTweHekrHSiRlYrlrKpZdc8I1I2ogFGspEWS52Z7rYs44L5uW0uRFyX4/LwOQjdYS4c1D7wwJVcy/hhcJn5bdwL6X9GHzOoMkc8EdZ4cJ+pSAlXlBIFSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YWc6562csz11SPf;
	Mon, 13 Jan 2025 10:44:13 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id B0BE7140390;
	Mon, 13 Jan 2025 10:47:13 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 13 Jan
 2025 10:47:12 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH] nfsd: free nfsd_file by gc after adding it to lru list
Date: Mon, 13 Jan 2025 10:59:57 +0800
Message-ID: <20250113025957.1253214-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500017.china.huawei.com (7.202.181.81)

In nfsd_file_put, after inserting the nfsd_file into the nfsd_file_lru
list, gc may be triggered in another thread and immediately release this
nfsd_file, which will lead to a UAF when accessing this nfsd_file again.

All the places where unhash is done will also perform lru_remove, so there
is no need to do lru_remove separately here. After inserting the nfsd_file
into the nfsd_file_lru list, it can be released by relying on gc.

Fixes: 4a0e73e635e3 ("NFSD: Leave open files out of the filecache LRU")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfsd/filecache.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a1cdba42c4fa..37b65cb1579a 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -372,18 +372,10 @@ nfsd_file_put(struct nfsd_file *nf)
 		/* Try to add it to the LRU.  If that fails, decrement. */
 		if (nfsd_file_lru_add(nf)) {
 			/* If it's still hashed, we're done */
-			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
+			if (list_lru_count(&nfsd_file_lru))
 				nfsd_file_schedule_laundrette();
-				return;
-			}
 
-			/*
-			 * We're racing with unhashing, so try to remove it from
-			 * the LRU. If removal fails, then someone else already
-			 * has our reference.
-			 */
-			if (!nfsd_file_lru_remove(nf))
-				return;
+			return;
 		}
 	}
 	if (refcount_dec_and_test(&nf->nf_ref))
-- 
2.31.1


