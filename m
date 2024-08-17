Return-Path: <linux-nfs+bounces-5425-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F519555C6
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 08:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8E62856EE
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2024 06:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E910F824AF;
	Sat, 17 Aug 2024 06:31:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9002C1AC8BE;
	Sat, 17 Aug 2024 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723876302; cv=none; b=RE/xTPFifNKMFoWbqE5SNEDMGEeMIiNh0Fg1SQS74OcoZXRn0JAp5U2MbKxs2SMFWlBbJIrrLexiIjsqX4S0tMIOe2BR6ZChXm6rvtFGugJJSPbwbojUBGGWRmnz9rdpXxa6SLdAqxQ9n6xbFVJt/zCaPv1ON85AY8B5P8eqCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723876302; c=relaxed/simple;
	bh=08UN52u5dsg84PgzEIOFzSIgpPTvTdicMxc+x7dncLY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N90rvcTUwlVdYxjEu54bkIpB63cGFkf+G73nsz2g5N/88eV5dToSyzQLOtiCjr/1PW2Ew3mVUMbM83Jln+EV9QDxAq1ZUv9EkxmaAKJ3KzZR9b9H9OswHx+Fj4dCsZdOAD58fM0rTar3AhZlCZNdhUOBUgKYUNN4CC2wccuIqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wm8By2ZXnz4f3jdT;
	Sat, 17 Aug 2024 14:31:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4979F1A06D7;
	Sat, 17 Aug 2024 14:31:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4XHQ8BmtjKxBw--.35139S4;
	Sat, 17 Aug 2024 14:31:36 +0800 (CST)
From: Li Lingfeng <lilingfeng@huaweicloud.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yukuai1@huaweicloud.com,
	houtao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	lilingfeng@huaweicloud.com,
	lilingfeng3@huawei.com
Subject: [PATCH] nfsd: map the EBADMSG to nfserr_io to avoid warning
Date: Sat, 17 Aug 2024 14:27:13 +0800
Message-Id: <20240817062713.1819908-1-lilingfeng@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4XHQ8BmtjKxBw--.35139S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZFy5Ww4xAw18KF4DJr4Utwb_yoWrZFyDpF
	4rXa48Gr48Jr1kAF4DtF13Kr17tr4DCF47Xr1fWF1xAF15Jw1DXry7Jr4jgryYgrWjv3Z7
	tFykXw4Utw1kJaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/

From: Li Lingfeng <lilingfeng3@huawei.com>

Ext4 will throw -EBADMSG through ext4_readdir when a checksum error
occurs, resulting in the following WARNING.

Fix it by mapping EBADMSG to nfserr_io.

nfsd_buffered_readdir
 iterate_dir // -EBADMSG -74
  ext4_readdir // .iterate_shared
   ext4_dx_readdir
    ext4_htree_fill_tree
     htree_dirblock_to_tree
      ext4_read_dirblock
       __ext4_read_dirblock
        ext4_dirblock_csum_verify
         warn_no_space_for_csum
          __warn_no_space_for_csum
        return ERR_PTR(-EFSBADCRC) // -EBADMSG -74
 nfserrno // WARNING

[  161.115610] ------------[ cut here ]------------
[  161.116465] nfsd: non-standard errno: -74
[  161.117315] WARNING: CPU: 1 PID: 780 at fs/nfsd/nfsproc.c:878 nfserrno+0x9d/0xd0
[  161.118596] Modules linked in:
[  161.119243] CPU: 1 PID: 780 Comm: nfsd Not tainted 5.10.0-00014-g79679361fd5d #138
[  161.120684] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qe
mu.org 04/01/2014
[  161.123601] RIP: 0010:nfserrno+0x9d/0xd0
[  161.124676] Code: 0f 87 da 30 dd 00 83 e3 01 b8 00 00 00 05 75 d7 44 89 ee 48 c7 c7 c0 57 24 98 89 44 24 04 c6
 05 ce 2b 61 03 01 e8 99 20 d8 00 <0f> 0b 8b 44 24 04 eb b5 4c 89 e6 48 c7 c7 a0 6d a4 99 e8 cc 15 33
[  161.127797] RSP: 0018:ffffc90000e2f9c0 EFLAGS: 00010286
[  161.128794] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  161.130089] RDX: 1ffff1103ee16f6d RSI: 0000000000000008 RDI: fffff520001c5f2a
[  161.131379] RBP: 0000000000000022 R08: 0000000000000001 R09: ffff8881f70c1827
[  161.132664] R10: ffffed103ee18304 R11: 0000000000000001 R12: 0000000000000021
[  161.133949] R13: 00000000ffffffb6 R14: ffff8881317c0000 R15: ffffc90000e2fbd8
[  161.135244] FS:  0000000000000000(0000) GS:ffff8881f7080000(0000) knlGS:0000000000000000
[  161.136695] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  161.137761] CR2: 00007fcaad70b348 CR3: 0000000144256006 CR4: 0000000000770ee0
[  161.139041] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  161.140291] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  161.141519] PKRU: 55555554
[  161.142076] Call Trace:
[  161.142575]  ? __warn+0x9b/0x140
[  161.143229]  ? nfserrno+0x9d/0xd0
[  161.143872]  ? report_bug+0x125/0x150
[  161.144595]  ? handle_bug+0x41/0x90
[  161.145284]  ? exc_invalid_op+0x14/0x70
[  161.146009]  ? asm_exc_invalid_op+0x12/0x20
[  161.146816]  ? nfserrno+0x9d/0xd0
[  161.147487]  nfsd_buffered_readdir+0x28b/0x2b0
[  161.148333]  ? nfsd4_encode_dirent_fattr+0x380/0x380
[  161.149258]  ? nfsd_buffered_filldir+0xf0/0xf0
[  161.150093]  ? wait_for_concurrent_writes+0x170/0x170
[  161.151004]  ? generic_file_llseek_size+0x48/0x160
[  161.151895]  nfsd_readdir+0x132/0x190
[  161.152606]  ? nfsd4_encode_dirent_fattr+0x380/0x380
[  161.153516]  ? nfsd_unlink+0x380/0x380
[  161.154256]  ? override_creds+0x45/0x60
[  161.155006]  nfsd4_encode_readdir+0x21a/0x3d0
[  161.155850]  ? nfsd4_encode_readlink+0x210/0x210
[  161.156731]  ? write_bytes_to_xdr_buf+0x97/0xe0
[  161.157598]  ? __write_bytes_to_xdr_buf+0xd0/0xd0
[  161.158494]  ? lock_downgrade+0x90/0x90
[  161.159232]  ? nfs4svc_decode_voidarg+0x10/0x10
[  161.160092]  nfsd4_encode_operation+0x15a/0x440
[  161.160959]  nfsd4_proc_compound+0x718/0xe90
[  161.161818]  nfsd_dispatch+0x18e/0x2c0
[  161.162586]  svc_process_common+0x786/0xc50
[  161.163403]  ? nfsd_svc+0x380/0x380
[  161.164137]  ? svc_printk+0x160/0x160
[  161.164846]  ? svc_xprt_do_enqueue.part.0+0x365/0x380
[  161.165808]  ? nfsd_svc+0x380/0x380
[  161.166523]  ? rcu_is_watching+0x23/0x40
[  161.167309]  svc_process+0x1a5/0x200
[  161.168019]  nfsd+0x1f5/0x380
[  161.168663]  ? nfsd_shutdown_threads+0x260/0x260
[  161.169554]  kthread+0x1c4/0x210
[  161.170224]  ? kthread_insert_work_sanity_check+0x80/0x80
[  161.171246]  ret_from_fork+0x1f/0x30

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfsd/vfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29b1f3613800..911e5e0a17af 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -100,6 +100,7 @@ nfserrno (int errno)
 		{ nfserr_io, -EUCLEAN },
 		{ nfserr_perm, -ENOKEY },
 		{ nfserr_no_grace, -ENOGRACE},
+		{ nfserr_io, -EBADMSG },
 	};
 	int	i;
 
-- 
2.31.1


