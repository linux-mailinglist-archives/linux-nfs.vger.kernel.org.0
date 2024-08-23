Return-Path: <linux-nfs+bounces-5606-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D8C95C5D3
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 08:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3031284A3D
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 06:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B78C13C810;
	Fri, 23 Aug 2024 06:50:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9426713A40C;
	Fri, 23 Aug 2024 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395854; cv=none; b=dZnE1s7kEvDAsKlo/yCvAifqcb7CyJM+cSaoYC1N5xtG6s0GeN4HVQEplQWenG6M9p6JNeZKgb9zolWx7OMFcgNQJwPOcIvLubc3Rpu6lXD1izPAsXi0JhDEejCfZ5ic3cSHE9Rwrkz1z2cygR7d+iME1wiDbiOjBBOJf6+/PqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395854; c=relaxed/simple;
	bh=D5U6d4XLeFjw4drDmx1nzg2Fdt0+FMRUrHdqGVDbiMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rQkHHvPX5yJ6qD1Dv8ccccbz3Kg/QxaOobyLf2gKzBEWSWVmpdR6ZV0qC0m5+1zh+9VuQm5S1dxRiOEB9d2McTxndOEA5FFaBcHyyk1SI4h7ptpBFhxBUs4o/0oyaL5vGdLpDuE2tOuepZsKTaInAO6QeBnhD8lo/iAvKVVN0tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WqrLX6Btbz1S8Xh;
	Fri, 23 Aug 2024 14:50:44 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 1DA0214013B;
	Fri, 23 Aug 2024 14:50:50 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 14:50:48 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <kolga@netapp.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH 3/4] nfsd: remove the redundant blank line
Date: Fri, 23 Aug 2024 15:00:48 +0800
Message-ID: <20240823070049.3499625-4-lilingfeng3@huawei.com>
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

Just remove the redundant blank line in do_open_permission. No function
change.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfsd/nfs4proc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 2e39cf2e502a..0068db924060 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -141,7 +141,6 @@ fh_dup2(struct svc_fh *dst, struct svc_fh *src)
 static __be32
 do_open_permission(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nfsd4_open *open, int accmode)
 {
-
 	if (open->op_truncate &&
 		!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
 		return nfserr_inval;
-- 
2.31.1


