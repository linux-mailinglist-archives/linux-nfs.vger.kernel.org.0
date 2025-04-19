Return-Path: <linux-nfs+bounces-11172-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B8FA94247
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 10:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C1E19E25E9
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 08:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F72D194080;
	Sat, 19 Apr 2025 08:34:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED6145A03;
	Sat, 19 Apr 2025 08:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745051682; cv=none; b=I74tW/O0IAo0fYctPgokcjcntHyvNF0pEsTaJuucC0Me8v9dzML2wgS8qJIv/NpoKcskreWiXLuHQaLjb35yQVhvS64E0oCnl9/z0VX8e66DCHhBzkUodJjgibN9+b+YQxRy8dDrNo3O+VqYHcf/7+V7yucxu2/RxN04U/Wpnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745051682; c=relaxed/simple;
	bh=I8oldR7k47/FquUCWortxWzdbtiB+IwnboLP550BaCE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JP41X2BCqhhT8MdL5m6KoM5IqtSlTiY0CDJzpbHVIsbxpcZQwO+ach/bksZAZ1w3VBJOPYRDUT1WB3mWLZmeZGV9/iUD0G6EODtQVR7pef1vzxsFLYZSVZDeVR/PNZoyjtLG7VEWzPzmLF7h15FdtvmDsvhLApfvWdSyjqLi4ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ZflFK2nJszvWpQ;
	Sat, 19 Apr 2025 16:30:29 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id B9AE01800B1;
	Sat, 19 Apr 2025 16:34:36 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 19 Apr
 2025 16:34:35 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <jlayton@kernel.org>,
	<bcodding@redhat.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH 0/2] nfs: handle failure during allocing lock/unlock data
Date: Sat, 19 Apr 2025 16:53:53 +0800
Message-ID: <20250419085355.1451457-1-lilingfeng3@huawei.com>
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

Lack of memory can cause nfs_lock_context allocation failures in unlock
paths, triggering NULL pointer dereference upon unlock completion.
Additionally, failed nfs_open_context acquisition may lead to similar
vulnerabilities. Proper error handling during lock/unlock data
initialization prevents critical faults.

Li Lingfeng (2):
  nfs: handle failure of nfs_get_lock_context in unlock path
  nfs: handle failure of get_nfs_open_context

 fs/nfs/nfs4proc.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

-- 
2.31.1


