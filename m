Return-Path: <linux-nfs+bounces-5607-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877EE95C5D5
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 08:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E956B22C1F
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 06:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EBB13C9D3;
	Fri, 23 Aug 2024 06:50:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F4313A409;
	Fri, 23 Aug 2024 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395855; cv=none; b=depy78MYWQTVJoQRcU+CHwv2LG9H+Th1iijGrdHdYN/SX191ikHH9WhLGez68ToicwPOl4m968nTjPbEvoshYEdLxenigfzSvdaQkT7AYBU6QU77p+M1kXxTWk2F4wVoGgqxD39LBMfE2wjwlTXBjful/qU3Ofgzq1UhT811nSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395855; c=relaxed/simple;
	bh=SZ5yX0eRiHE+dktGG5I5u6Ld2P09IJD02hKGmK1MVLw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VlZihmhWrbEVnN2Ax3U6huFPv5GvS4GtSwpeTx9vD5fqeFFlCFOIHCZerqYtwYLxZyXIc3+SO1Abe7kasOR8PCkQuiPPqPCVV4jimUVYl5ZnkEJFRuoYsYXuSekrNUkF4zUVmcxEftZqqDmClnFdMcmZMzK2HbPBykREbpfakek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WqrL82LnyzyR58;
	Fri, 23 Aug 2024 14:50:24 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id F056E140137;
	Fri, 23 Aug 2024 14:50:48 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 14:50:47 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <kolga@netapp.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH 2/4] nfsd: fix some spelling errors in comments
Date: Fri, 23 Aug 2024 15:00:47 +0800
Message-ID: <20240823070049.3499625-3-lilingfeng3@huawei.com>
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

Fix spelling errors in comments of nfsd4_release_lockowner and
nfs4_set_delegation.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfsd/nfs4state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..66a0c76850f3 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5856,7 +5856,7 @@ nfs4_set_delegation(struct nfsd4_open *open, struct nfs4_ol_stateid *stp,
 
 	/*
 	 * Now that the deleg is set, check again to ensure that nothing
-	 * raced in and changed the mode while we weren't lookng.
+	 * raced in and changed the mode while we weren't looking.
 	 */
 	status = nfsd4_verify_setuid_write(open, fp->fi_deleg_file);
 	if (status)
@@ -8335,7 +8335,7 @@ check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner)
  * @cstate: NFSv4 COMPOUND state
  * @u: RELEASE_LOCKOWNER arguments
  *
- * Check if theree are any locks still held and if not - free the lockowner
+ * Check if there are any locks still held and if not - free the lockowner
  * and any lock state that is owned.
  *
  * Return values:
-- 
2.31.1


