Return-Path: <linux-nfs+bounces-6211-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CE496CC33
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 03:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7491C2227B
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 01:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E66E4C76;
	Thu,  5 Sep 2024 01:25:15 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1871C27;
	Thu,  5 Sep 2024 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499515; cv=none; b=WtdIugstoZVBAPaJ5pVk5vVumPMjN+9xLkcA6niQJxw9kAx3W4OdqFghZRMWPJMmzwbuV5tbUXUA5rPGKDqqNb+p5kAAlBCAJ4ErJ6tFFD97FAjPs5oqXOW6jbkyTGMhtVHH5U6c4cq1kGImtYg1WezAa+CzGIVbTdEZxtdeLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499515; c=relaxed/simple;
	bh=t1QocKhnaAKjRjD/CPjy9nrvXqM1+njW/FuouXPbcHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AcWZBp4atoWltn0tBAaR+Gb6PFL0v8OGnTyW10SbO2TMv6M4BJ4cSS0F0TJOrYX57l/FRueoC02pfagJ8rpmh6+rXi8qbuocLpIDkgE5ym04iqp6ruA0cRPdmUQm2UT4I3ed9KQ25q3QpQK06uebJM5uc0bJWYq85PZnbiv1q5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WzhSg57HxzpVJ8;
	Thu,  5 Sep 2024 09:23:15 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 48E8A1400D1;
	Thu,  5 Sep 2024 09:25:09 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemg500017.china.huawei.com (7.202.181.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Sep 2024 09:25:08 +0800
Message-ID: <d95bd8bb-154d-596c-1dff-10722319adad@huawei.com>
Date: Thu, 5 Sep 2024 09:25:07 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH] nfsd: return -EINVAL when namelen is 0
To: Scott Mayhew <smayhew@redhat.com>
CC: <chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>
References: <20240903111446.659884-1-lilingfeng3@huawei.com>
 <ZthzJiKF6TY0Nv32@aion>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <ZthzJiKF6TY0Nv32@aion>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500017.china.huawei.com (7.202.181.81)


在 2024/9/4 22:48, Scott Mayhew 写道:
> On Tue, 03 Sep 2024, Li Lingfeng wrote:
>
>> When we have a corrupted main.sqlite in /var/lib/nfs/nfsdcld/, it may
>> result in namelen being 0, which will cause memdup_user() to return
>> ZERO_SIZE_PTR.
>> When we access the name.data that has been assigned the value of
>> ZERO_SIZE_PTR in nfs4_client_to_reclaim(), null pointer dereference is
>> triggered.
>>
>> [ T1205] ==================================================================
>> [ T1205] BUG: KASAN: null-ptr-deref in nfs4_client_to_reclaim+0xe9/0x260
>> [ T1205] Read of size 1 at addr 0000000000000010 by task nfsdcld/1205
>> [ T1205]
>> [ T1205] CPU: 11 PID: 1205 Comm: nfsdcld Not tainted 5.10.0-00003-g2c1423731b8d #406
>> [ T1205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
>> [ T1205] Call Trace:
>> [ T1205]  dump_stack+0x9a/0xd0
>> [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
>> [ T1205]  __kasan_report.cold+0x34/0x84
>> [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
>> [ T1205]  kasan_report+0x3a/0x50
>> [ T1205]  nfs4_client_to_reclaim+0xe9/0x260
>> [ T1205]  ? nfsd4_release_lockowner+0x410/0x410
>> [ T1205]  cld_pipe_downcall+0x5ca/0x760
>> [ T1205]  ? nfsd4_cld_tracking_exit+0x1d0/0x1d0
>> [ T1205]  ? down_write_killable_nested+0x170/0x170
>> [ T1205]  ? avc_policy_seqno+0x28/0x40
>> [ T1205]  ? selinux_file_permission+0x1b4/0x1e0
>> [ T1205]  rpc_pipe_write+0x84/0xb0
>> [ T1205]  vfs_write+0x143/0x520
>> [ T1205]  ksys_write+0xc9/0x170
>> [ T1205]  ? __ia32_sys_read+0x50/0x50
>> [ T1205]  ? ktime_get_coarse_real_ts64+0xfe/0x110
>> [ T1205]  ? ktime_get_coarse_real_ts64+0xa2/0x110
>> [ T1205]  do_syscall_64+0x33/0x40
>> [ T1205]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
>> [ T1205] RIP: 0033:0x7fdbdb761bc7
>> [ T1205] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 514
>> [ T1205] RSP: 002b:00007fff8c4b7248 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>> [ T1205] RAX: ffffffffffffffda RBX: 000000000000042b RCX: 00007fdbdb761bc7
>> [ T1205] RDX: 000000000000042b RSI: 00007fff8c4b75f0 RDI: 0000000000000008
>> [ T1205] RBP: 00007fdbdb761bb0 R08: 0000000000000000 R09: 0000000000000001
>> [ T1205] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000042b
>> [ T1205] R13: 0000000000000008 R14: 00007fff8c4b75f0 R15: 0000000000000000
>> [ T1205] ==================================================================
>>
>> Fix it by checking namelen.
>>
>> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
>> ---
>>   fs/nfsd/nfs4recover.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
>> index 67d8673a9391..69a3a84e159e 100644
>> --- a/fs/nfsd/nfs4recover.c
>> +++ b/fs/nfsd/nfs4recover.c
>> @@ -809,6 +809,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
>>   			ci = &cmsg->cm_u.cm_clntinfo;
>>   			if (get_user(namelen, &ci->cc_name.cn_len))
>>   				return -EFAULT;
>> +			if (!namelen) {
>> +				dprintk("%s: namelen should not be zero", __func__);
>> +				return -EINVAL;
>> +			}
>>   			name.data = memdup_user(&ci->cc_name.cn_id, namelen);
>>   			if (IS_ERR(name.data))
>>   				return PTR_ERR(name.data);
>> @@ -831,6 +835,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
>>   			cnm = &cmsg->cm_u.cm_name;
>>   			if (get_user(namelen, &cnm->cn_len))
>>   				return -EFAULT;
>> +			if (!namelen) {
>> +				dprintk("%s: namelen should not be zero", __func__);
>> +				return -EINVAL;
>> +			}
>>   			name.data = memdup_user(&cnm->cn_id, namelen);
>>   			if (IS_ERR(name.data))
>>   				return PTR_ERR(name.data);
>> -- 
>> 2.31.1
> Huh, so that would mean sqlite allows null in a primary key.  Any idea
> how the corruption occurs in the first place?
During the test on the VM, the machine was hung. After the VM was powered
off, the corrupted sqlite was obtained. But we don't know how to
theoretically trigger this corruption.
>
> Reviewed-and-tested-by: Scott Mayhew <smayhew@redhat.com>
>
> -Scott
>>
>
>

