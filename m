Return-Path: <linux-nfs+bounces-10454-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59BDA4DE3C
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 13:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E3C3ABCB2
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Mar 2025 12:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2F31FFC68;
	Tue,  4 Mar 2025 12:48:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EB026ACD;
	Tue,  4 Mar 2025 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092516; cv=none; b=I+0MIT6r/E6LaCaBxMkAzp7yMjxga+pJh3Mrewuc+R8QXoLA67Wc35c4czF9BAtzCvYbsSvXKXDMAfkkIoy4otvIpmNkiihkvaxpM3AZyhJy1p1WN9iAruXGlpVVt57HqkJMueXa0TvZow7S5baDjU1yeJk63o2UHXOzKr/CKR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092516; c=relaxed/simple;
	bh=M1RC0c8Lm4NIyyJY/aAgHNkXEayMLHduAvUH/c7VGcM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EkCU5km6P/5jcj7QccUptPJ5FT1tUvh84AgV7XPTnZyCx5qB8DdjyKOxXv6Yeo0SOVGx4Eb8HU8XWGp5hfLy2mY+gZZFGsFte2f8u0SJVnpHQ8XqRICujQMmVzotPIV9SfGQbNWICoKRyhEx4ejjzKW2yy56erscVvlj1lnslqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Z6b6W5j6zzpbTn;
	Tue,  4 Mar 2025 20:46:59 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B6F01800EB;
	Tue,  4 Mar 2025 20:48:30 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Mar
 2025 20:48:29 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ehagberg@janestreet.com>, <linux-nfs@dimebar.com>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH 0/2] Ignore SB_RDONLY when mounting and remounting nfs
Date: Tue, 4 Mar 2025 21:05:31 +0800
Message-ID: <20250304130533.549840-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg500017.china.huawei.com (7.202.181.81)

When NFS_MOUNT_UNSHARED is not set, NFS forces the sharing of a
superblock among each filesystem that mounts sub-directories elonging to
a single exported root path.

To prevent interference between different filesystems, ignore SB_RDONLY
when mounting and remounting nfs.

Li Lingfeng (2):
  nfs: clear SB_RDONLY before getting superblock
  nfs: ignore SB_RDONLY when remounting nfs

 fs/nfs/super.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.31.1


