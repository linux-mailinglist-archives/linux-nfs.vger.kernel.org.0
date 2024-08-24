Return-Path: <linux-nfs+bounces-5677-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6270E95DA62
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 03:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D99DFB22C15
	for <lists+linux-nfs@lfdr.de>; Sat, 24 Aug 2024 01:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACF63D7A;
	Sat, 24 Aug 2024 01:33:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BA96FC3;
	Sat, 24 Aug 2024 01:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724463220; cv=none; b=b4QtuoQoPirtJJ9fxaUBL+e/Z4k6yG+r8LcpUCRjWfa1UzdRpgWiEVeSSZgnYG5z5Iy3mfin9pCvfOBP8qdvKya4Wp8ecoBMlXf4vwxfZVuk9EYX0efbQevMod6tBcs8P6fKuQFPRjtO4KT0h/YrhFFivAH6fqbCGcz5CwGjdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724463220; c=relaxed/simple;
	bh=K/trKbCCZ1ml1Cu8v4d6qTqwZuqMYsv5ue7sGf5wkbc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q/SXlN5Tmn+VpUubWwUGKXDXHgSgywwCrm9Yw6hFuVPdXV+XMxIQNFGUCh64Pdh0gTW3NwTT96GPyu7Z040RdjEYCteYFfmJH5EhVQ+04i2M/3cttZjrPaoH/BYGn1hS8bs2jShq6VYAD+K5NzQolGMETDJzca+MmQvgSQ6zHuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WrKFH5xVPz13wP4;
	Sat, 24 Aug 2024 09:32:51 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 38C571800D2;
	Sat, 24 Aug 2024 09:33:34 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 24 Aug
 2024 09:33:32 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <chuck.lever@oracle.com>,
	<jlayton@kernel.org>, <neilb@suse.de>, <kolga@netapp.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH v2 0/2] nfs/nfsd: fix some comments
Date: Sat, 24 Aug 2024 09:43:34 +0800
Message-ID: <20240824014336.537937-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
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

v1->v2:
  Change the title of [PATCH 1/4] since it is a NFS client patch, not a
  nfsd patch;
  Made a small change of [PATCH 2/4] to make the comments more
  syntactically;
  Remove [PATCH 3/4] since it's meaningless;
  Remove [PATCH 4/4] since it has been applied to nfsd-next for v6.12.

v1:
https://lore.kernel.org/all/20240823070049.3499625-1-lilingfeng3@huawei.com/

Li Lingfeng (2):
  nfs: fix the comment of nfs_get_root
  nfsd: fix some spelling errors in comments

 fs/nfs/getroot.c    | 2 +-
 fs/nfsd/nfs4state.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.31.1


