Return-Path: <linux-nfs+bounces-12809-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2FDAEC4D0
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Jun 2025 06:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2B514A5B99
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Jun 2025 04:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A301CEAB2;
	Sat, 28 Jun 2025 04:17:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DB01DA5F
	for <linux-nfs@vger.kernel.org>; Sat, 28 Jun 2025 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751084269; cv=none; b=Z4T1mtkqyW+Fjx3nBwULiQopC2F1Us3kIxp2BrLV33zfQjJiG7c/DkQ1hhV850TjGewoCY91nelDUm0clomD1d3vuwYYZ7giirckBAOhrwbKUbhZRK56gUWN9yi2AkYP9BPRhG1mkITdDhR7aLjEyG50dTgLNUC2Imud5slGTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751084269; c=relaxed/simple;
	bh=ux8qX3IPfPXXnlLSY//+ZKObFWX9eVVOV3/woEl1G5A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qR1dQaykvXHW1E/Utf2jXfDjIevBUP5pDAYwxU0zPy41zqKiHLAXtWTyG5N0jxounpg9y3of+7h8dDuG4chsWISw6NfibpcsLeJvnhJ69df3UORrGZ5Upicg7mIdyAqpjN1I+OqwuYT71eGJeihQWsfH/RKYeTe6Anxv8oR4gK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bTfGN3SyGz1W3RM;
	Sat, 28 Jun 2025 12:15:08 +0800 (CST)
Received: from kwepemp200004.china.huawei.com (unknown [7.202.195.99])
	by mail.maildlp.com (Postfix) with ESMTPS id 95F2F140109;
	Sat, 28 Jun 2025 12:17:37 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemp200004.china.huawei.com
 (7.202.195.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 28 Jun
 2025 12:17:36 +0800
From: zhangjian <zhangjian496@huawei.com>
To: <steved@redhat.com>, <joannelkoong@gmail.com>, <chuck.lever@oracle.com>,
	<djwong@kernel.org>, <jlayton@kernel.org>, <okorniev@redhat.com>,
	<lilingfeng3@huawei.com>
CC: <linux-nfs@vger.kernel.org>
Subject: [PATCH V2] nfs:check for user input filehandle size
Date: Sun, 29 Jun 2025 05:31:07 +0800
Message-ID: <20250628213107.2765337-1-zhangjian496@huawei.com>
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

Syzkaller found an slab-out-of-bounds in nfs_fh_to_dentry when the memory
of server_fh is not passed from user space. So I add a check for input size.

Log is snipped as following:

==================================================================
BUG: KASAN: slab-out-of-bounds in nfs_fh_to_dentry+0x4ad/0x6d0 fs/nfs/
export.c:70
Read of size 2 at addr ffff888100b9ffd4 by task syz-executor301/755

CPU: 1 PID: 755 Comm: syz-executor301 Tainted: G        W
5.10.0 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
  __dump_stack lib/dump_stack.c:82 [inline]
  dump_stack+0x107/0x167 lib/dump_stack.c:123
  print_address_description.constprop.0+0x1e/0x280 mm/kasan/report.c:400
  __kasan_report.cold+0x6c/0x84 mm/kasan/report.c:560
  kasan_report+0x3a/0x50 mm/kasan/report.c:585
  nfs_fh_to_dentry+0x4ad/0x6d0 fs/nfs/export.c:70
  exportfs_decode_fh_raw+0x128/0x680 fs/exportfs/expfs.c:436
  exportfs_decode_fh+0x3d/0x90 fs/exportfs/expfs.c:575
  do_handle_to_path fs/fhandle.c:152 [inline]
  handle_to_path fs/fhandle.c:207 [inline]
  do_handle_open+0x2c3/0x8d0 fs/fhandle.c:223
  do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
  entry_SYSCALL_64_after_hwframe+0x67/0xd1
==================================================================

V2:
- Fix mistake: add back server_fh initialization and move len initialization
  bellow user input size checking.

Signed-off-by: zhangjian <zhangjian496@huawei.com>
---
 fs/nfs/export.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index e9c233b6f..565e01788 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -66,14 +66,21 @@ nfs_fh_to_dentry(struct super_block *sb, struct fid *fid,
 {
 	struct nfs_fattr *fattr = NULL;
 	struct nfs_fh *server_fh = nfs_exp_embedfh(fid->raw);
-	size_t fh_size = offsetof(struct nfs_fh, data) + server_fh->size;
+	size_t fh_size;
 	const struct nfs_rpc_ops *rpc_ops;
 	struct dentry *dentry;
 	struct inode *inode;
-	int len = EMBED_FH_OFF + XDR_QUADLEN(fh_size);
+	int len;
 	u32 *p = fid->raw;
 	int ret;
 
+	/* check for user input size */
+	if ((char*)server_fh <= (char*)p || (int)((u32*)server_fh - (u32*)p + 1) < fh_len)
+		return ERR_PTR(-EINVAL);
+
+	fh_size = offsetof(struct nfs_fh, data) + server_fh->size;
+	len = EMBED_FH_OFF + XDR_QUADLEN(fh_size);
+
 	/* NULL translates to ESTALE */
 	if (fh_len < len || fh_type != len)
 		return NULL;
-- 
2.33.0


