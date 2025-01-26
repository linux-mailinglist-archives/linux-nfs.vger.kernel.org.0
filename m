Return-Path: <linux-nfs+bounces-9622-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08026A1C731
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 10:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F7E3A77EF
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 09:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829C586330;
	Sun, 26 Jan 2025 09:33:06 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B26BBA53;
	Sun, 26 Jan 2025 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737883986; cv=none; b=VGcIacI6LfewtjzemT2Ud/fGoRX/hPbCmPVDekbV1pFeT9fhTk/4heHkRgwRCQoCuIlhsSAW2M5N/EFYWP0LMbccUzjxwx5rwLqrhFdW2inOnbf+YQZWhcTgEOc3Zyc9gmS1dlfO/SAUsf/8r8UX1INRznOLNsUXmkuwVDz0pIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737883986; c=relaxed/simple;
	bh=XXQvxfgHQo3ciLstw41Pp0vBNDWNnvTOKqqyyQhep10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJYTn/0XAUOdcebwUOIVhgd7r1uU996NqTNKh9jg8u5J78NfH0SEZj9v9TDFxUzKlXbxsd8Db732JpHLkdte7LNeXDbhW0qdYQstPTCNTfCsbagjQmRUEfDNiJzczxgE/zuLY7ue4b3fw5UA9dYSttq57K5gErPA+HBvZbcGBpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YgmXY1Tytz1JJ72;
	Sun, 26 Jan 2025 17:31:57 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id DDEB31A0188;
	Sun, 26 Jan 2025 17:33:01 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sun, 26 Jan
 2025 17:33:00 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <kolga@netapp.com>, <Dai.Ngo@oracle.com>,
	<tom@talpey.com>, <trondmy@hammerspace.com>, <linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH 1/2] nfsd: map the ELOOP to nfserr_symlink to avoid warning
Date: Sun, 26 Jan 2025 17:50:44 +0800
Message-ID: <20250126095045.738902-2-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250126095045.738902-1-lilingfeng3@huawei.com>
References: <20250126095045.738902-1-lilingfeng3@huawei.com>
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

We got -ELOOP from ext4, resulting in the following WARNING:

VFS: Lookup of 'dc' in ext4 sdd would have caused loop
------------[ cut here ]------------
nfsd: non-standard errno: -40
WARNING: CPU: 1 PID: 297024 at fs/nfsd/vfs.c:113 nfserrno+0xc8/0x128
Modules linked in:
CPU: 1 PID: 297024 Comm: nfsd Not tainted 6.6.0-gfa4c2159cd0d-dirty #21
Hardware name: linux,dummy-virt (DT)
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : nfserrno+0xc8/0x128
lr : nfserrno+0xc8/0x128
sp : ffff8000846475a0
x29: ffff8000846475a0 x28: 0000000000000130 x27: ffff0000d65a24e8
x26: ffff0000c7319134 x25: ffff0000d6de4240 x24: 0000000000000002
x23: ffffcda9eaac3080 x22: 00000000ffffffd8 x21: 0000000000000026
x20: ffffcda9ee055000 x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000001 x12: ffff60001b5ca39b
x11: 1fffe0001b5ca39a x10: ffff60001b5ca39a x9 : dfff800000000000
x8 : 00009fffe4a35c66 x7 : ffff0000dae51cd3 x6 : 0000000000000001
x5 : ffff0000dae51cd0 x4 : ffff60001b5ca39b x3 : dfff800000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000ca5d8040
Call trace:
 nfserrno+0xc8/0x128
 nfsd4_encode_dirent_fattr+0x358/0x380
 nfsd4_encode_dirent+0x164/0x3a8
 nfsd_buffered_readdir+0x1a8/0x3a0
 nfsd_readdir+0x14c/0x188
 nfsd4_encode_readdir+0x1d4/0x370
 nfsd4_encode_operation+0x130/0x518
 nfsd4_proc_compound+0x394/0xec0
 nfsd_dispatch+0x264/0x418
 svc_process_common+0x584/0xc78
 svc_process+0x1e8/0x2c0
 svc_recv+0x194/0x2d0
 nfsd+0x198/0x378
 kthread+0x1d8/0x1f0
 ret_from_fork+0x10/0x20
Kernel panic - not syncing: kernel: panic_on_warn set ...

The ELOOP error in Linux indicates that too many symbolic links were
encountered in resolving a path name. Mapping it to nfserr_symlink may be
fine.

Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfsd/vfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 29cb7b812d71..0f727010b8cb 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -100,6 +100,7 @@ nfserrno (int errno)
 		{ nfserr_perm, -ENOKEY },
 		{ nfserr_no_grace, -ENOGRACE},
 		{ nfserr_io, -EBADMSG },
+		{ nfserr_symlink, -ELOOP },
 	};
 	int	i;
 
-- 
2.31.1


