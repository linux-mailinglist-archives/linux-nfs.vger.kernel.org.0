Return-Path: <linux-nfs+bounces-11047-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 414E5A823B0
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 13:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A197B02E6
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 11:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E01725E461;
	Wed,  9 Apr 2025 11:39:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAFC25E448;
	Wed,  9 Apr 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198757; cv=none; b=WHNLiCRqyYKvgOjg4pJwukufZeGU6A5+E7Ch4WP0W99JvzZ3jKJ//GDBIFoODvBBs8cR6VYkRkxpnbxCUT3ePxg2w0XX4nRbGWQo8IAPVN8RLBSYwgS/TL78FTbM6VQO6DgegPnqERlc46Ibq+4OJPyP+vYBcyxGLrZM2Pu1C8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198757; c=relaxed/simple;
	bh=EcQzu22hBKBt+jCYu3t0+mpap4FiLnEOlNd3ykYef78=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QUqndW5/Zo102InR1uGu9/Br4DoId3/wrMec9oa2E7ZOa91f9dcH50tRVNv60tgtkvkWHhexqc4cxBPY9DgKHwPJkFGSG0LCE3OsHEaOkVyweg3feQbGoXyk1x9YHXwbvzNDqhUmOVoWBx+ZHi+6sbKNpGxDVOqCeXc1bWIg2XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZXgtn2w6Cz13LHm;
	Wed,  9 Apr 2025 19:38:25 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C68F180472;
	Wed,  9 Apr 2025 19:39:06 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Apr 2025 19:39:05 +0800
Message-ID: <c49a0e08-7184-4e74-b28e-8543dd9f570f@huawei.com>
Date: Wed, 9 Apr 2025 19:39:04 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH 0/2] Ignore SB_RDONLY when mounting and remounting nfs
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ehagberg@janestreet.com>, <linux-nfs@dimebar.com>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>
References: <20250304130533.549840-1-lilingfeng3@huawei.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <20250304130533.549840-1-lilingfeng3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500017.china.huawei.com (7.202.181.81)

Friendly ping..

Thanks

在 2025/3/4 21:05, Li Lingfeng 写道:
> When NFS_MOUNT_UNSHARED is not set, NFS forces the sharing of a
> superblock among each filesystem that mounts sub-directories elonging to
> a single exported root path.
>
> To prevent interference between different filesystems, ignore SB_RDONLY
> when mounting and remounting nfs.
>
> Li Lingfeng (2):
>    nfs: clear SB_RDONLY before getting superblock
>    nfs: ignore SB_RDONLY when remounting nfs
>
>   fs/nfs/super.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>

