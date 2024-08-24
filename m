Return-Path: <linux-nfs+bounces-5679-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD4695DA66
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 03:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4606F2833AC
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 01:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207D9C147;
	Sat, 24 Aug 2024 01:33:41 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AB679FE;
	Sat, 24 Aug 2024 01:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724463221; cv=none; b=iEAqA7I5O6/0v/l4biTEaiTvlFtAjOUecvPd/v0RCITyH+/5UUnwiAv8BRiThe2fyUU4m3VCD+Ms1rxOhx8A5aQ25SGCXuZcUQB+roP38Fq6lxCvYlYV9xzHYn/JVJuNX0H6LsRtHzaXSvU30rSv7yGPG6KpvIfOlmOn7OeEekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724463221; c=relaxed/simple;
	bh=9Z/fi0ACiI6Q33KnOMIK0VGK0TkARxagMAFzs5ttqgY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OywdJRMvnEM+FyEPcLbygzTPC195BadbrzqUZeqCX/WPcbBV/7kytQ1MNdvs4g6Yvi0oMtuqIG0ouZolVAKq/BG3KWMU6swmMTxUBTWk6bPWadNS/rKTF933tPkGhTFx2H0+DshlCqqROIw3o9uRGApA1AnUUXdb5LPGRf5hKok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WrKG264Hfz2CnL7;
	Sat, 24 Aug 2024 09:33:30 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FE981401F2;
	Sat, 24 Aug 2024 09:33:36 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 24 Aug
 2024 09:33:35 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <kolga@netapp.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH v2 2/2] nfsd: fix some spelling errors in comments
Date: Sat, 24 Aug 2024 09:43:36 +0800
Message-ID: <20240824014336.537937-3-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240824014336.537937-1-lilingfeng3@huawei.com>
References: <20240824014336.537937-1-lilingfeng3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Fix spelling errors in comments of nfsd4_release_lockowner and
nfs4_set_delegation.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfsd/nfs4state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..9046e39b0e5c 100644
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
+ * Check if there are any locks still held and if not, free the lockowner
  * and any lock state that is owned.
  *
  * Return values:
-- 
2.31.1


