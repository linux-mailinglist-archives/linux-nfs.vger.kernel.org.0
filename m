Return-Path: <linux-nfs+bounces-9621-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF15DA1C72F
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 10:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7A53A7740
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 09:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7FE481A3;
	Sun, 26 Jan 2025 09:33:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7DCAD5E;
	Sun, 26 Jan 2025 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737883986; cv=none; b=N8D6t1KvwGVQ6YgBsPzNqF9o5l4TQzpRx9F9awfM8s+C4DFq7O6wPmLA41/UehgLsd0zuVz7nGJX9DpwY9lqOrxMcoN5LNj9PWcZP2qUGAgq7Bl9oT7wzw13vgViJBHPEqVxJI/x2evbb4v4Vu/l4/amsLlJ6Xye1QSwgxWmu78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737883986; c=relaxed/simple;
	bh=Je1B0jgNEdTaeKdXvsepuSLU1/BNxnfvUSaCxopgxNg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SYYtmL2oJkkFT9Q/T4Rx7EQFoQjq37YB643sX+0asgt6tkp2xIYJ0e/Ablmoua2+j4U4CmwG8NOzyDTxBXDLBBuXUEH9HG/i7STx1HhKivxKUsw4NPVv5uaTi1JDqnaPT+cHWyGEXvyM2ZQUb6dqnraXwPkyAl8hE0QNUNWo49E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YgmTr4z2Tz1l00h;
	Sun, 26 Jan 2025 17:29:36 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id B93A114010C;
	Sun, 26 Jan 2025 17:33:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 26 Jan
 2025 17:32:59 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <kolga@netapp.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <trondmy@hammerspace.com>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH 0/2] nfsd: add a new mapping and remove the redundant one
Date: Sun, 26 Jan 2025 17:50:43 +0800
Message-ID: <20250126095045.738902-1-lilingfeng3@huawei.com>
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

Add a new mapping and delete a redundant one.

Li Lingfeng (2):
  nfsd: map the ELOOP to nfserr_symlink to avoid warning
  nfsd: remove the redundant mapping of nfserr_mlink

 fs/nfsd/vfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.31.1


