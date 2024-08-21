Return-Path: <linux-nfs+bounces-5490-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21B29594F2
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 08:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F50C28967E
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Aug 2024 06:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417721D4167;
	Wed, 21 Aug 2024 06:46:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1C1D4149
	for <linux-nfs@vger.kernel.org>; Wed, 21 Aug 2024 06:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222762; cv=none; b=aXy+YNJtzgKtuFm4Brqpyo9poSiNGkbmdzP6BJP83cI/bsa0IzDFJlwKP1hGudP+XvQeod6TowIs5xKZXrFDFZ5bnLrPeFm+u7U3Gr4kyfr6dXEZckKskiNdy9vY+JNPC/FPCIkJeqZ1S6Cmc+s8rcI/u4xnU/SpTNftpDnRA5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222762; c=relaxed/simple;
	bh=u+fZMPqUbGga5gwaYZr9ARoeoukbCXw0BPleZd/6X7U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VIOXyfzsJhrmoXfFTgeIm9ybirBZernNdSJcACoaKAxjW5Z/3figd5hZWomOipkg6WXctDRS7+tcYPTQBZE4ma0up6AmoRFeAQSrsakZgtfxS2Pl/B4iMtgyXQqHNCplhzt7abTSUzbz/MSC8K7lsDEDKfIugRy8VppQ1Zok3Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WpcKv3jZSz2CmwZ;
	Wed, 21 Aug 2024 14:45:55 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BC3A1A0188;
	Wed, 21 Aug 2024 14:45:57 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 14:45:57 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<kolga@netapp.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>
CC: <lihongbo22@huawei.com>, <linux-nfs@vger.kernel.org>
Subject: [PATCH -next] nfsd: use LIST_HEAD() to simplify code
Date: Wed, 21 Aug 2024 14:53:26 +0800
Message-ID: <20240821065326.2293988-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500022.china.huawei.com (7.185.36.66)

list_head can be initialized automatically with LIST_HEAD()
instead of calling INIT_LIST_HEAD().

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/nfsd/nfs4state.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..ee852719d07d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1663,9 +1663,7 @@ static void release_openowner(struct nfs4_openowner *oo)
 {
 	struct nfs4_ol_stateid *stp;
 	struct nfs4_client *clp = oo->oo_owner.so_client;
-	struct list_head reaplist;
-
-	INIT_LIST_HEAD(&reaplist);
+	LIST_HEAD(reaplist);
 
 	spin_lock(&clp->cl_lock);
 	unhash_openowner_locked(oo);
@@ -2369,9 +2367,8 @@ __destroy_client(struct nfs4_client *clp)
 	int i;
 	struct nfs4_openowner *oo;
 	struct nfs4_delegation *dp;
-	struct list_head reaplist;
+	LIST_HEAD(reaplist);
 
-	INIT_LIST_HEAD(&reaplist);
 	spin_lock(&state_lock);
 	while (!list_empty(&clp->cl_delegations)) {
 		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
@@ -6616,9 +6613,8 @@ deleg_reaper(struct nfsd_net *nn)
 {
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
-	struct list_head cblist;
+	LIST_HEAD(cblist);
 
-	INIT_LIST_HEAD(&cblist);
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
 		clp = list_entry(pos, struct nfs4_client, cl_lru);
-- 
2.34.1


