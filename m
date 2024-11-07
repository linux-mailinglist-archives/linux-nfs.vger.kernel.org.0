Return-Path: <linux-nfs+bounces-7737-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E6E9BFBFD
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Nov 2024 02:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FA2283C0D
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Nov 2024 01:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88E579F6;
	Thu,  7 Nov 2024 01:50:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE8E2941C;
	Thu,  7 Nov 2024 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944242; cv=none; b=uASPnUtGNMjK6le4cgLfX/7Pwd+8UYlpkU6wdgduNDAazaWkKJUNY/ja6Shn/osLAvjHbOL982Zy4y6SwqeWhSB9F92keNlq4kpnr7oZTvj7c42KjialnlT4413SglOHml+dOF1C4/ad6ozc1EnSAORfVHyQcMlwRD+btM82TT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944242; c=relaxed/simple;
	bh=xR5lZz9NvJ5n45Nxsz8hUbgIeGONq4q8Ynrva3cSZyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Au2JyiHzvN3QF9SaXNfpouFUt6raV+HXBA0WqT3ansE+msr6qeS4uTwTCeQ9RruIucO5BkSx/aILwrbTE7ogAfZEDoJihDb5OtK6zvH5V0sXVqoEwQYMNIj8xGMMmX4EowjXX6frcL38oyBh50puCFj5XzJXxKlQOxFHcERAhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XkQ4n2V4wz4f3lVx;
	Thu,  7 Nov 2024 09:50:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2B8031A0197;
	Thu,  7 Nov 2024 09:50:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCnzoLpHCxntP5FBA--.42261S4;
	Thu, 07 Nov 2024 09:50:35 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	okorniev@redhat.com,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	Trond.Myklebust@netapp.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH] nfsd: set acl_access/acl_default after getting successful
Date: Thu,  7 Nov 2024 09:47:05 +0800
Message-Id: <20241107014705.2509463-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzoLpHCxntP5FBA--.42261S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuryrAr18KF13JF4DJF1DJrb_yoWrCrWrpF
	13ta1UCr48Gr1UXF45Aw18KF1rtF4Fya1UGr93CF1IvFW3uw15Jr1UCry8ZrW7JFWfXa47
	Jr1jqwn2qw1DXaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUOv38UUUUU
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

If getting acl_default fails, acl_access and acl_default will be released
simultaneously. However, acl_access will still retain a pointer pointing
to the released posix_acl, which will trigger a WARNING in
nfs3svc_release_getacl like this:

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 26 PID: 3199 at lib/refcount.c:28
refcount_warn_saturate+0xb5/0x170
Modules linked in:
CPU: 26 UID: 0 PID: 3199 Comm: nfsd Not tainted
6.12.0-rc6-00079-g04ae226af01f-dirty #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.1-2.fc37 04/01/2014
RIP: 0010:refcount_warn_saturate+0xb5/0x170
Code: cc cc 0f b6 1d b3 20 a5 03 80 fb 01 0f 87 65 48 d8 00 83 e3 01 75
e4 48 c7 c7 c0 3b 9b 85 c6 05 97 20 a5 03 01 e8 fb 3e 30 ff <0f> 0b eb
cd 0f b6 1d 8a3
RSP: 0018:ffffc90008637cd8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff83904fde
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: ffff88871ed36380
RBP: ffff888158beeb40 R08: 0000000000000001 R09: fffff520010c6f56
R10: ffffc90008637ab7 R11: 0000000000000001 R12: 0000000000000001
R13: ffff888140e77400 R14: ffff888140e77408 R15: ffffffff858b42c0
FS:  0000000000000000(0000) GS:ffff88871ed00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562384d32158 CR3: 000000055cc6a000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? refcount_warn_saturate+0xb5/0x170
 ? __warn+0xa5/0x140
 ? refcount_warn_saturate+0xb5/0x170
 ? report_bug+0x1b1/0x1e0
 ? handle_bug+0x53/0xa0
 ? exc_invalid_op+0x17/0x40
 ? asm_exc_invalid_op+0x1a/0x20
 ? tick_nohz_tick_stopped+0x1e/0x40
 ? refcount_warn_saturate+0xb5/0x170
 ? refcount_warn_saturate+0xb5/0x170
 nfs3svc_release_getacl+0xc9/0xe0
 svc_process_common+0x5db/0xb60
 ? __pfx_svc_process_common+0x10/0x10
 ? __rcu_read_unlock+0x69/0xa0
 ? __pfx_nfsd_dispatch+0x10/0x10
 ? svc_xprt_received+0xa1/0x120
 ? xdr_init_decode+0x11d/0x190
 svc_process+0x2a7/0x330
 svc_handle_xprt+0x69d/0x940
 svc_recv+0x180/0x2d0
 nfsd+0x168/0x200
 ? __pfx_nfsd+0x10/0x10
 kthread+0x1a2/0x1e0
 ? kthread+0xf4/0x1e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x34/0x60
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>
Kernel panic - not syncing: kernel: panic_on_warn set ...

Clear acl_access/acl_default first and set both of them only when both
ACLs are successfully obtained.

Fixes: a257cdd0e217 ("[PATCH] NFSD: Add server support for NFSv3 ACLs.")
Signed-off-by: Li Lingfeng <lilingfeng@huaweicloud.com>
---
 fs/nfsd/nfs3acl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfs3acl.c b/fs/nfsd/nfs3acl.c
index 5e34e98db969..17579a032a5b 100644
--- a/fs/nfsd/nfs3acl.c
+++ b/fs/nfsd/nfs3acl.c
@@ -29,10 +29,12 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
 {
 	struct nfsd3_getaclargs *argp = rqstp->rq_argp;
 	struct nfsd3_getaclres *resp = rqstp->rq_resp;
-	struct posix_acl *acl;
+	struct posix_acl *acl = NULL, *dacl = NULL;
 	struct inode *inode;
 	svc_fh *fh;
 
+	resp->acl_access = NULL;
+	resp->acl_default = NULL;
 	fh = fh_copy(&resp->fh, &argp->fh);
 	resp->status = fh_verify(rqstp, &resp->fh, 0, NFSD_MAY_NOP);
 	if (resp->status != nfs_ok)
@@ -56,19 +58,19 @@ static __be32 nfsd3_proc_getacl(struct svc_rqst *rqstp)
 			resp->status = nfserrno(PTR_ERR(acl));
 			goto fail;
 		}
-		resp->acl_access = acl;
 	}
 	if (resp->mask & (NFS_DFACL|NFS_DFACLCNT)) {
 		/* Check how Solaris handles requests for the Default ACL
 		   of a non-directory! */
-		acl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
-		if (IS_ERR(acl)) {
-			resp->status = nfserrno(PTR_ERR(acl));
+		dacl = get_inode_acl(inode, ACL_TYPE_DEFAULT);
+		if (IS_ERR(dacl)) {
+			resp->status = nfserrno(PTR_ERR(dacl));
 			goto fail;
 		}
-		resp->acl_default = acl;
 	}
 
+	resp->acl_access = acl;
+	resp->acl_default = dacl;
 	/* resp->acl_{access,default} are released in nfs3svc_release_getacl. */
 out:
 	return rpc_success;
-- 
2.39.2


