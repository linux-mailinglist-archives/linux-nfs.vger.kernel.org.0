Return-Path: <linux-nfs+bounces-5608-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C062295C5D6
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 08:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CB8A1F2350D
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 06:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D713CF9E;
	Fri, 23 Aug 2024 06:50:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616D13BC0C;
	Fri, 23 Aug 2024 06:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395855; cv=none; b=fOJfa9mUENQ7OfoLTqkbDl5nt82PCjy5sydZJpoyJ78eaz/kn3BOQ6s+zImzPg/VkeBfKdpxsSHgmreOv4zCPvCG3ZVe2Au4Gwq5ibJhEPnknZvZItvYZUuLWeuxELAa19M932mXMMicKZFIXx7U421un4IuR3dfTk7rH+UcSTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395855; c=relaxed/simple;
	bh=P8ofQWwvbmIBj7URDzUe93HadsqjXVJpPxv/wn3f9Xw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cPO6LJwRPRxtlyvvCSPPUwNCAUyZEoKrhmkh4HbUbUTB+EjDBmM4T1uAppBMgO5mHpt08WJc6NDXo6a6DKutmhZeda7WQrfIZxQeT/Nmz5tNWJGOItGSPCTMtysSLentUOayWJvFzlIjU0t0AfdzF32n2sEEi3eEwEdITb7Cse0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WqrJR6SgRz1xvpr;
	Fri, 23 Aug 2024 14:48:55 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 3CB9318001B;
	Fri, 23 Aug 2024 14:50:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 14:50:49 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <kolga@netapp.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH 4/4] nfsd: remove unused parameter of nfsd_file_mark_find_or_create
Date: Fri, 23 Aug 2024 15:00:49 +0800
Message-ID: <20240823070049.3499625-5-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240823070049.3499625-1-lilingfeng3@huawei.com>
References: <20240823070049.3499625-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Commit 427f5f83a319 ("NFSD: Ensure nf_inode is never dereferenced") passes
inode directly to nfsd_file_mark_find_or_create instead of getting it from
nf, so there is no need to pass nf.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfsd/filecache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index f4704f5d4086..376ec62e7794 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -151,7 +151,7 @@ nfsd_file_mark_put(struct nfsd_file_mark *nfm)
 }
 
 static struct nfsd_file_mark *
-nfsd_file_mark_find_or_create(struct nfsd_file *nf, struct inode *inode)
+nfsd_file_mark_find_or_create(struct inode *inode)
 {
 	int			err;
 	struct fsnotify_mark	*mark;
@@ -1074,7 +1074,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 open_file:
 	trace_nfsd_file_alloc(nf);
-	nf->nf_mark = nfsd_file_mark_find_or_create(nf, inode);
+	nf->nf_mark = nfsd_file_mark_find_or_create(inode);
 	if (nf->nf_mark) {
 		if (file) {
 			get_file(file);
-- 
2.31.1


