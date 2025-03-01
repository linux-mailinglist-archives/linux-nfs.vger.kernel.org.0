Return-Path: <linux-nfs+bounces-10394-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3820A4A959
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 07:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0E63BC450
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Mar 2025 06:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B181CD215;
	Sat,  1 Mar 2025 06:53:29 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01BC1B85F8;
	Sat,  1 Mar 2025 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740812009; cv=none; b=unkUFtRNhsuY8cta5IqWWRvTsWaVQpv/D3m35mPC+07kcohx6tdmdZUYPLbxaV9ELLRqgIBs7yMaqyUpO1n7pgwTQVFNP7D58rDdaa74fj12KkS8dLOWGLFUXowbWsvuqfAqrTr95KS6EugfCsxW1tQzr+uO+ZD4UY07QudEK6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740812009; c=relaxed/simple;
	bh=tn3WgZ9c8UT2Ty6/FVSCF6nD2AnTFoHgEVsIBtrRykA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UkPwK8S/gatHluhR7H/xLs8b//XKkAkn5BZRrnX/nNSLuFggQnr9DVun91hwFQ8nsRt1U+YL0xKDwichnGv3ykHR4Tgv2F+siaMXJCmWPts+fYzW5am2nERQXhktf4+5wcGfkgmJAkElx3mdsiyQq3tl74KcPMAbvS1OYXXVfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Z4bQR5blGznl3D;
	Sat,  1 Mar 2025 14:53:51 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id 000BB140135;
	Sat,  1 Mar 2025 14:53:18 +0800 (CST)
Received: from huawei.com (10.175.104.67) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 1 Mar
 2025 14:53:18 +0800
From: Long Li <leo.lilong@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<trondmy@kernel.org>, <anna@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>
CC: <linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<leo.lilong@huawei.com>, <yangerkun@huawei.com>, <lonuxli.64@gmail.com>
Subject: [PATCH 0/2] sunrpc: Fix issues with cache_detail nextcheck updates
Date: Sat, 1 Mar 2025 14:48:34 +0800
Message-ID: <20250301064836.3285906-1-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500017.china.huawei.com (7.185.36.126)

During memory fault injection testing with nfsd restart, I encountered an
issue where NFS client threads would hang for around 1800 seconds. Analysis
showed that nfsd threads were blocked for approximately 1800 seconds with
the following scenario:

  PID: 3941444  TASK: ffff0000cf170040  CPU: 0    COMMAND: "nfsd"
   #0 [ffff80008d387120] __switch_to at ffffc4ef3c7a6af0
   #1 [ffff80008d387170] __schedule at ffffc4ef3c7a73a4
   #2 [ffff80008d3872c0] schedule at ffffc4ef3c7a8074
   #3 [ffff80008d387300] schedule_timeout at ffffc4ef3c7b7b60
   #4 [ffff80008d387470] wait_for_common at ffffc4ef3c7a944c
   #5 [ffff80008d387560] wait_for_completion_interruptible_timeout at ffffc4ef3c7a9630
   #6 [ffff80008d387570] cache_wait_req at ffffc4ef3c6804dc
   #7 [ffff80008d3876f0] cache_check at ffffc4ef3c680740
   #8 [ffff80008d3877d0] exp_find_key at ffffc4ef3b6e293c
   #9 [ffff80008d387910] exp_find at ffffc4ef3b6e2ccc
  #10 [ffff80008d387980] rqst_exp_find at ffffc4ef3b6e445c
  #11 [ffff80008d3879e0] exp_pseudoroot at ffffc4ef3b6e4984
  #12 [ffff80008d387a90] nfsd4_putrootfh at ffffc4ef3b6f8720
  #13 [ffff80008d387ab0] nfsd4_proc_compound at ffffc4ef3b6fe4cc
  #14 [ffff80008d387b70] nfsd_dispatch at ffffc4ef3b6cf428
  #15 [ffff80008d387c30] svc_process_common at ffffc4ef3c66235c
  #16 [ffff80008d387d20] svc_process at ffffc4ef3c6652f8
  #17 [ffff80008d387d90] svc_recv at ffffc4ef3c68c5d0
  #18 [ffff80008d387e10] nfsd at ffffc4ef3b6cb968
  #19 [ffff80008d387e60] kthread at ffffc4ef3ad4aca4
  
An nfsd thread sent an upcall and set the cache to CACHE_PENDING state,
waiting for the downcall to complete. However, due to memory fault
injection, this downcall failed and the userspace daemon did not retry.
The nfsd thread could only wait for cache cleanup to clear the
CACHE_PENDING state and resend the upcall.

Under certain edge cases, the cache_detail scanning interval could be set
to a large value like 1800 seconds, causing cache cleanup to be delayed
well beyond the cache's expiry time. This behavior seems unreasonable.

This patch series fix two issues related to the cache_detail nextcheck
time updates in the sunrpc subsystem. The first patch ensures nextcheck
time is properly updated when adding new cache entries to an cache_detail.
The second  patch fixes a race condition between cache cleanup and entry
removal that can result in stale nextcheck times. 

Long Li (2):
  sunrpc: update nextcheck time when adding new cache entries
  sunrpc: fix race in cache cleanup causing stale nextcheck time

 net/sunrpc/cache.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

-- 
2.39.2


