Return-Path: <linux-nfs+bounces-12746-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90201AE7ABE
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 10:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C200D189F7A0
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Jun 2025 08:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CE628E607;
	Wed, 25 Jun 2025 08:47:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D920288CBD;
	Wed, 25 Jun 2025 08:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750841231; cv=none; b=ddlHHDnNBcDiMS7XLkjx275XREBZA7MozWnUfWw9NsmjNek7+i541UATGn+pCM95/mujHaPQeWQFKEy+uLBRPwLSLJaFPBXnoU/qHLe4x7557ytHLVSJiPbs80ul+CHsHpMgdWpWpAVSa0uOxQLJuAT+bw43JKCFCxXJDe+nVe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750841231; c=relaxed/simple;
	bh=xDezQu8rUpcvHFAGt+r8ic9Do8WqjCafJJfUU47daxg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KwhOwmzTUgkXJLbjZlfRJcBUeYutFyuFDyk9AbZNIoHWNe1GPC35b9kJc7acpbXmfEQ9WFaaT9OM7IfnLKWvZZZxnfsVAiNbiUZRRjxQDzg8OSosmvWBJODVrj9nj3f9spAa1OzwAjWMLsVlnddJaM6JzGg3d+ALgNYMzmq6FCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bRwPf47x6z1QBp1;
	Wed, 25 Jun 2025 16:45:26 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id 7B6B01A016C;
	Wed, 25 Jun 2025 16:47:04 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemp200004.china.huawei.com
 (7.202.195.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Jun
 2025 16:47:03 +0800
From: zhangjian <zhangjian496@huawei.com>
To: <gregkh@linuxfoundation.org>, <darrick.wong@oracle.com>,
	<dhowells@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] [5.10-LTS NFS] fix assert failure in __fscache_disable_cookie
Date: Thu, 26 Jun 2025 10:00:35 +0800
Message-ID: <20250626020035.1043638-1-zhangjian496@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemp200004.china.huawei.com (7.202.195.99)

Multi write opens will go into __fscache_disable_cookie and cookie->n_active
may be zero for a short window. Move this assertion under locking to avoid
assert failure for ASSERTCMP(atomic_read(&cookie->n_active), >, 0).

stack is as following:

 fscache_disable_cookie include/linux/fscache.h:854 [inline]
 nfs_fscache_open_file+0x3ba/0x430 fs/nfs/fscache.c:319
 nfs4_file_open+0x4ff/0x780 fs/nfs/nfs4file.c:90
 do_dentry_open+0x6ea/0x1170 fs/open.c:826
 do_open.isra.0+0x9dc/0xf50 fs/namei.c:3316
 path_openat+0x336/0x810 fs/namei.c:3434
 do_filp_open+0x1b9/0x290 fs/namei.c:3461
 do_sys_openat2+0x5be/0x9b0 fs/open.c:1231
 do_sys_open+0xc8/0x150 fs/open.c:1248
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x67/0xd1

Signed-off-by: zhangjian <zhangjian496@huawei.com>
---
 fs/fscache/cookie.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 6104f627c..30f0e2b41 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -703,6 +703,9 @@ void __fscache_disable_cookie(struct fscache_cookie *cookie,
 
 	_enter("%p,%u", cookie, invalidate);
 
+	wait_on_bit_lock(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK,
+			 TASK_UNINTERRUPTIBLE);
+
 	trace_fscache_disable(cookie);
 
 	ASSERTCMP(atomic_read(&cookie->n_active), >, 0);
@@ -713,9 +716,6 @@ void __fscache_disable_cookie(struct fscache_cookie *cookie,
 		BUG();
 	}
 
-	wait_on_bit_lock(&cookie->flags, FSCACHE_COOKIE_ENABLEMENT_LOCK,
-			 TASK_UNINTERRUPTIBLE);
-
 	fscache_update_aux(cookie, aux_data);
 
 	if (!test_and_clear_bit(FSCACHE_COOKIE_ENABLED, &cookie->flags))
-- 
2.33.0


