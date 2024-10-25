Return-Path: <linux-nfs+bounces-7468-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 468C89B04F2
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 16:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09CD62839DF
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2024 14:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EC470820;
	Fri, 25 Oct 2024 14:03:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A429E212189;
	Fri, 25 Oct 2024 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865028; cv=none; b=TeuYlzwnHKN0Xh63y48Y4bDHGJaGFSdMuRwMoL0EmP8RosvMxYYgHSDj1vo10F6zve/WB1x7oNwOnlj5aemrleqoRroZs6pCmtbUi8CrNScKq5KWeMVUBTtr+NhjgIPPeGaxQyCxsU9V1axGzy+aXNDePga3gxEN3OlQpbPTwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865028; c=relaxed/simple;
	bh=Nl+3bOnR2Unji8mkIuA4GaO14wA+JZUVRZbEaFWBh+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+dE8tDfthtvwctbgVclnT/MEMTxE6g/Q3DtBFrGGklOCAxQJz49ldq5udeZdvQejAgx7NTBWMnDm78ai2eR7Un+kDzmPKIltLXfzV1HmaUAgVJZU746ik1HoXjQ2EzyZFgHqJ/oAbOKmOHodIvem751X9UeQouzce13+Tiw248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XZkWY4ht0z9v7JC;
	Fri, 25 Oct 2024 21:43:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 9F98614035F;
	Fri, 25 Oct 2024 22:03:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCH+Tk0pRtnjsZpAA--.22140S2;
	Fri, 25 Oct 2024 15:03:37 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	stable@vger.kernel.org
Subject: [PATCH] nfs: Fix KMSAN warning in decode_getfattr_attrs()
Date: Fri, 25 Oct 2024 16:03:27 +0200
Message-ID: <20241025140327.2666623-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.47.0.118.gfd3785337b
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCH+Tk0pRtnjsZpAA--.22140S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF1xXw48Jw4DWw4fuw4xtFb_yoW8uw45pr
	Wqk34fCr15Ary8JF4Fva13X34UXay8trW7Wrs7tr1xZ3WrJrnxKa48tr4agrnrCr4UAFyF
	g3WUJr4rJ3yDAFDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4NB_UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBGcbAm8JvAABsk

From: Roberto Sassu <roberto.sassu@huawei.com>

Fix the following KMSAN warning:

CPU: 1 UID: 0 PID: 7651 Comm: cp Tainted: G    B
Tainted: [B]=BAD_PAGE
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)
=====================================================
=====================================================
BUG: KMSAN: uninit-value in decode_getfattr_attrs+0x2d6d/0x2f90
 decode_getfattr_attrs+0x2d6d/0x2f90
 decode_getfattr_generic+0x806/0xb00
 nfs4_xdr_dec_getattr+0x1de/0x240
 rpcauth_unwrap_resp_decode+0xab/0x100
 rpcauth_unwrap_resp+0x95/0xc0
 call_decode+0x4ff/0xb50
 __rpc_execute+0x57b/0x19d0
 rpc_execute+0x368/0x5e0
 rpc_run_task+0xcfe/0xee0
 nfs4_proc_getattr+0x5b5/0x990
 __nfs_revalidate_inode+0x477/0xd00
 nfs_access_get_cached+0x1021/0x1cc0
 nfs_do_access+0x9f/0xae0
 nfs_permission+0x1e4/0x8c0
 inode_permission+0x356/0x6c0
 link_path_walk+0x958/0x1330
 path_lookupat+0xce/0x6b0
 filename_lookup+0x23e/0x770
 vfs_statx+0xe7/0x970
 vfs_fstatat+0x1f2/0x2c0
 __se_sys_newfstatat+0x67/0x880
 __x64_sys_newfstatat+0xbd/0x120
 x64_sys_call+0x1826/0x3cf0
 do_syscall_64+0xd0/0x1b0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The KMSAN warning is triggered in decode_getfattr_attrs(), when calling
decode_attr_mdsthreshold(). It appears that fattr->mdsthreshold is not
initialized.

Fix the issue by initializing fattr->mdsthreshold to NULL in
nfs_fattr_init().

Cc: stable@vger.kernel.org # v3.5.x
Fixes: 88034c3d88c2 ("NFSv4.1 mdsthreshold attribute xdr")
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 fs/nfs/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 542c7d97b235..1e71b029da58 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1633,6 +1633,7 @@ void nfs_fattr_init(struct nfs_fattr *fattr)
 	fattr->gencount = nfs_inc_attr_generation_counter();
 	fattr->owner_name = NULL;
 	fattr->group_name = NULL;
+	fattr->mdsthreshold = NULL;
 }
 EXPORT_SYMBOL_GPL(nfs_fattr_init);
 
-- 
2.47.0.118.gfd3785337b


