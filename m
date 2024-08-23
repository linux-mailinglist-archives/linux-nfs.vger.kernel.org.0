Return-Path: <linux-nfs+bounces-5604-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9FD95C5CF
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 08:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D602FB22B8F
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 06:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460F57323;
	Fri, 23 Aug 2024 06:50:51 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D048BEF;
	Fri, 23 Aug 2024 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395851; cv=none; b=ALNy5l7GpKKQiXP1tQ8Mbc3LSlKMqmiMPeZ4sWyp86JO9/VlkuYvlScmHjXS/UQ4aRj9t7dfxR4W94fb5kVHqqhoI90lZy8huESfkTD1Eko3WBVYQcYg6GtWlGP4h3xv/CxkLLFE2nXEiUl2nHJocaRg9y7M1RwwapYVScGqsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395851; c=relaxed/simple;
	bh=E38JP+SWMEts5f3pP/4TpKMWgLfL9/pCj/LfiR9z8B8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sLKAYIuW3bRlKvuGPM3k+qbvnXU40weVATkOUIC6fcWLGXZMPs8/ZC8BgBkHHVwBVM4sKaCmxVOQWqq9tS1M2Lk2gSzI4/GPRUvxqfZTxBJDHzJ3ayGXl4RPKMC0OiCM+eiW4WNfiTINixkz6htCxMnDxevo7qzD+LgtWu7XrfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WqrJF2574zhY5r;
	Fri, 23 Aug 2024 14:48:45 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id B288B14011F;
	Fri, 23 Aug 2024 14:50:46 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 14:50:45 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <kolga@netapp.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH 0/4] nfsd: fix some comments and code cleanup
Date: Fri, 23 Aug 2024 15:00:45 +0800
Message-ID: <20240823070049.3499625-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
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

Li Lingfeng (4):
  nfsd: fix the comment of nfs_get_root
  nfsd: fix some spelling errors in comments
  nfsd: remove the redundant blank line
  nfsd: remove unused parameter of nfsd_file_mark_find_or_create

 fs/nfs/getroot.c    | 2 +-
 fs/nfsd/filecache.c | 4 ++--
 fs/nfsd/nfs4proc.c  | 1 -
 fs/nfsd/nfs4state.c | 4 ++--
 4 files changed, 5 insertions(+), 6 deletions(-)

-- 
2.31.1


