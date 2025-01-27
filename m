Return-Path: <linux-nfs+bounces-9654-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28346A1CF8C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 03:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075B51883889
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 02:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99126EAD0;
	Mon, 27 Jan 2025 02:33:52 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F925A64A;
	Mon, 27 Jan 2025 02:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737945232; cv=none; b=YRnqlkc/R685R9T0XdaZljG/KH8Ykj3zo6dmXUGalsR4IX0QQXobdUrcHnQAhi0WEVB5g9fL2V2NMeBwjHbIT1m/J4DYZlh71JoCv7IdoRJMUiW1vKLK3dvaRP9L9FPxWNKWhWeahvfug+UH43beg7tt1VpAELkVqHINDpFCQ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737945232; c=relaxed/simple;
	bh=x4MsbGJXRaiPWB5hBeACmDeRrAHNxANf/Crp74IebHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DPYt+DiX32XcDDz1ICZcG7+5UsjYeDDumBIPjVdpTR8mgkOvhT2YKXaWLATsjykRjAwkbauM3Eg8Xu6BtRWzoYodKdLHGMZLPXjAw4YJqxEoHOVdeh0OpRYpubq64Z/5X/DMtSAd9JuG0w+S1VWp/ilGXvVbUnxSm4BZ9Wki8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4YhC7V2g5wz1V5bY;
	Mon, 27 Jan 2025 10:30:14 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 15F131400E8;
	Mon, 27 Jan 2025 10:33:40 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 27 Jan 2025 10:33:38 +0800
Message-ID: <7edd3481-df5a-4d22-87f5-367263b19ea8@huawei.com>
Date: Mon, 27 Jan 2025 10:33:37 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH 1/2] nfsd: map the ELOOP to nfserr_symlink to avoid
 warning
To: Chuck Lever <chuck.lever@oracle.com>, <jlayton@kernel.org>,
	<neilb@suse.de>, <okorniev@redhat.com>, <kolga@netapp.com>,
	<Dai.Ngo@oracle.com>, <tom@talpey.com>, <trondmy@hammerspace.com>,
	<linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>
References: <20250126095045.738902-1-lilingfeng3@huawei.com>
 <20250126095045.738902-2-lilingfeng3@huawei.com>
 <e9a10562-5c8e-4bc1-a767-20ee1b07e4b6@oracle.com>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <e9a10562-5c8e-4bc1-a767-20ee1b07e4b6@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2025/1/27 1:27, Chuck Lever 写道:
> On 1/26/25 4:50 AM, Li Lingfeng wrote:
>> We got -ELOOP from ext4, resulting in the following WARNING:
>>
>> VFS: Lookup of 'dc' in ext4 sdd would have caused loop
>> ------------[ cut here ]------------
>> nfsd: non-standard errno: -40
>> WARNING: CPU: 1 PID: 297024 at fs/nfsd/vfs.c:113 nfserrno+0xc8/0x128
>> Modules linked in:
>> CPU: 1 PID: 297024 Comm: nfsd Not tainted 6.6.0-gfa4c2159cd0d-dirty #21
>> Hardware name: linux,dummy-virt (DT)
>> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : nfserrno+0xc8/0x128
>> lr : nfserrno+0xc8/0x128
>> sp : ffff8000846475a0
>> x29: ffff8000846475a0 x28: 0000000000000130 x27: ffff0000d65a24e8
>> x26: ffff0000c7319134 x25: ffff0000d6de4240 x24: 0000000000000002
>> x23: ffffcda9eaac3080 x22: 00000000ffffffd8 x21: 0000000000000026
>> x20: ffffcda9ee055000 x19: 0000000000000000 x18: 0000000000000000
>> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
>> x14: 0000000000000000 x13: 0000000000000001 x12: ffff60001b5ca39b
>> x11: 1fffe0001b5ca39a x10: ffff60001b5ca39a x9 : dfff800000000000
>> x8 : 00009fffe4a35c66 x7 : ffff0000dae51cd3 x6 : 0000000000000001
>> x5 : ffff0000dae51cd0 x4 : ffff60001b5ca39b x3 : dfff800000000000
>> x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000ca5d8040
>> Call trace:
>>   nfserrno+0xc8/0x128
>>   nfsd4_encode_dirent_fattr+0x358/0x380
>>   nfsd4_encode_dirent+0x164/0x3a8
>>   nfsd_buffered_readdir+0x1a8/0x3a0
>>   nfsd_readdir+0x14c/0x188
>>   nfsd4_encode_readdir+0x1d4/0x370
>>   nfsd4_encode_operation+0x130/0x518
>>   nfsd4_proc_compound+0x394/0xec0
>>   nfsd_dispatch+0x264/0x418
>>   svc_process_common+0x584/0xc78
>>   svc_process+0x1e8/0x2c0
>>   svc_recv+0x194/0x2d0
>>   nfsd+0x198/0x378
>>   kthread+0x1d8/0x1f0
>>   ret_from_fork+0x10/0x20
>> Kernel panic - not syncing: kernel: panic_on_warn set ...
>>
>> The ELOOP error in Linux indicates that too many symbolic links were
>> encountered in resolving a path name. Mapping it to nfserr_symlink 
>> may be
>> fine.
>>
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   fs/nfsd/vfs.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 29cb7b812d71..0f727010b8cb 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -100,6 +100,7 @@ nfserrno (int errno)
>>           { nfserr_perm, -ENOKEY },
>>           { nfserr_no_grace, -ENOGRACE},
>>           { nfserr_io, -EBADMSG },
>> +        { nfserr_symlink, -ELOOP },
>>       };
>>       int    i;
>
> Adding ELOOP -> SYMLINK as a generic mapping could be a problem.
>
> RFC 8881 Section 15.2 does not list NFS4ERR_SYMLINK as a permissible
> status code for NFSv4 READDIR. Further, Section 15.4 lists only the
> following operations for NFS4ERR_SYMLINK:
>
> COMMIT, LAYOUTCOMMIT, LINK, LOCK, LOCKT, LOOKUP, LOOKUPP, OPEN, READ, 
> WRITE
>
>
> Which of lookup_positive_unlocked() or nfsd_cross_mnt() returned
> ELOOP, and why? What were the export options? What was in the file
> system that caused this? Can this scenario be reproduced on v6.13?
>
Hi,
I got a more detailed log with line numbers from our test team.

VFS: Lookup of 'dc' in ext4 sdd would have caused loop
------------[ cut here ]------------
nfsd: non-standard errno: -40
WARNING: CPU: 1 PID: 297024 at fs/nfsd/vfs.c:113 nfserrno 
fs/nfsd/vfs.c:113 [inline]
WARNING: CPU: 1 PID: 297024 at fs/nfsd/vfs.c:113 nfserrno+0xc8/0x128 
fs/nfsd/vfs.c:61
Modules linked in:
CPU: 1 PID: 297024 Comm: nfsd Not tainted 6.6.0-gfa4c2159cd0d-dirty #21
Hardware name: linux,dummy-virt (DT)
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : nfserrno fs/nfsd/vfs.c:113 [inline]
pc : nfserrno+0xc8/0x128 fs/nfsd/vfs.c:61
lr : nfserrno fs/nfsd/vfs.c:113 [inline]
lr : nfserrno+0xc8/0x128 fs/nfsd/vfs.c:61
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
  nfserrno fs/nfsd/vfs.c:113 [inline]
  nfserrno+0xc8/0x128 fs/nfsd/vfs.c:61
  nfsd4_encode_dirent_fattr+0x358/0x380 fs/nfsd/nfs4xdr.c:3536
  nfsd4_encode_dirent+0x164/0x3a8 fs/nfsd/nfs4xdr.c:3633
  nfsd_buffered_readdir+0x1a8/0x3a0 fs/nfsd/vfs.c:2067
  nfsd_readdir+0x14c/0x188 fs/nfsd/vfs.c:2123
  nfsd4_encode_readdir+0x1d4/0x370 fs/nfsd/nfs4xdr.c:4273
  nfsd4_encode_operation+0x130/0x518 fs/nfsd/nfs4xdr.c:5399
  nfsd4_proc_compound+0x394/0xec0 fs/nfsd/nfs4proc.c:2753
  nfsd_dispatch+0x264/0x418 fs/nfsd/nfssvc.c:1011
  svc_process_common+0x584/0xc78 net/sunrpc/svc.c:1396
  svc_process+0x1e8/0x2c0 net/sunrpc/svc.c:1542
  svc_recv+0x194/0x2d0 net/sunrpc/svc_xprt.c:877
  nfsd+0x198/0x378 fs/nfsd/nfssvc.c:955
  kthread+0x1d8/0x1f0 kernel/kthread.c:388
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:861

Although I don't have a reproducer to reproduce this problem, I think
ELOOP should be returned by the following path:

v6.6
nfsd4_encode_readdir
  nfsd_readdir
   nfsd_buffered_readdir
    nfsd4_encode_dirent // func
     nfsd4_encode_dirent_fattr
      nfsd4_encode_dirent_fattr
       lookup_positive_unlocked
        lookup_one_positive_unlocked
         lookup_one_unlocked // ELOOP
          lookup_slow
           __lookup_slow
            ext4_lookup // inode->i_op->lookup
             d_splice_alias
              // VFS: Lookup of 'dc' in ext4 sdd would have caused loop

This scenario may be reproduced on v6.13 like this:
nfsd4_encode_readdir
  nfsd4_encode_dirlist4
   nfsd_readdir
    nfsd_buffered_readdir
     nfsd4_encode_entry4 // func
      nfsd4_encode_entry4_fattr
       lookup_positive_unlocked
        lookup_one_positive_unlocked
         lookup_one_unlocked
          lookup_slow
           __lookup_slow
            ext4_lookup // inode->i_op->lookup
             d_splice_alias

According to the information provided by the test team, the export option
is "rw,no_root_squash", and I'll try to reproduce the problem.

By the way, could you suggest which NFS error code would be most
appropriate to map ELOOP to?

Thanks.

