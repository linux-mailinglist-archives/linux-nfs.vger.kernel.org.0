Return-Path: <linux-nfs+bounces-5602-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FE495C3C5
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 05:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3520284735
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Aug 2024 03:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C3726AF6;
	Fri, 23 Aug 2024 03:35:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BB11EF1D
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 03:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724384144; cv=none; b=J3xojKOEf5AOVUsimBoB263R5LmQ+m1cCVH7FvoD+2Y+pYeymxMHLcsdcIFZIF0IPc+s06vkDd1QmLLfuSLNWhs6lY1WXsRxoYQcsR7YjufzeVX23bMfM6jmQnxGDDxI9ed2pwNzKpkLx/LSTs5+8J4mHUpwbuu6Zw6vshRHMqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724384144; c=relaxed/simple;
	bh=FrSVxbdcVQsVEHwj/Z12sJzEyBJhpsEkcijFCJINopA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFznc9Bce+8/O9i85wrnXospu4DP/3up4ZXwzVFv5Kegby753yfvklWfN0NOhiNP6voDfAciP/sDGRqG0Ag/HOIr9wYs30BIi5Jul7tYJIZujnpwdOch+Mr0ITRrH5lCwnGJtTypYwcgjDisSzSHsEYW4mqOCRREbOrUydYD+1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wqm103481z4f3jcs
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 11:35:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AD37F1A058E
	for <linux-nfs@vger.kernel.org>; Fri, 23 Aug 2024 11:35:30 +0800 (CST)
Received: from [10.174.179.155] (unknown [10.174.179.155])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4WAA8hmajzWCQ--.16580S3;
	Fri, 23 Aug 2024 11:35:30 +0800 (CST)
Message-ID: <65ee9c0d-e89e-b3e5-f542-103a0ee4745c@huaweicloud.com>
Date: Fri, 23 Aug 2024 11:35:28 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:104.0) Gecko/20100101
 Thunderbird/104.0
Subject: Re: [PATCH v1] SUNRPC: Remove BUG_ON call sites
To: Donald Buczek <buczek@molgen.mpg.de>, NeilBrown <neilb@suse.de>,
 Chuck Lever <cel@kernel.org>
Cc: brauner@kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org, it+linux@molgen.mpg.de,
 Hou Tao <houtao1@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
 yangerkun <yangerkun@huawei.com>, chengzhihao1@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>, lilingfeng3@huawei.com,
 Li Lingfeng <lilingfeng@huaweicloud.com>
References: <169513768769.145733.5037542987990908432.stgit@manet.1015granger.net>
 <169516146143.19404.11284116898963519832@noble.neil.brown.name>
 <793386f6-65bc-48ef-9d7c-71314ddd4c86@molgen.mpg.de>
From: Li Lingfeng <lilingfeng@huaweicloud.com>
In-Reply-To: <793386f6-65bc-48ef-9d7c-71314ddd4c86@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXv4WAA8hmajzWCQ--.16580S3
X-Coremail-Antispam: 1UD129KBjvAXoWfuF48WFy8Kw45tFy3AFy5urg_yoWrJFyUGo
	W7Zr1IkF48Gr1DKry5W3WxJr4UJw4IkFsrAryIkr1DGasrXr4qqryUt34xJ3y3Xr4kGa45
	A3Wqq34kWw18Grn7n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYW7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
	x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
	Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: polox0xjih0w46kxt4xhlfz01xgou0bp/


在 2024/6/27 20:53, Donald Buczek 写道:
> On 9/20/23 00:11, NeilBrown wrote:
>> On Wed, 20 Sep 2023, Chuck Lever wrote:
>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>
>>> There is no need to take down the whole system for these assertions.
>>>
>>> I'd rather not attempt a heroic save here, as some bug has occurred
>>> that has left the transport data structures in an unknown state.
>>> Just warn and then leak the left-over resources.
>>>
>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>> Acked-by: Christian Brauner <brauner@kernel.org>
>>> ---
>>>   net/sunrpc/svc.c |    9 +++++----
>>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> Changes since v1:
>>> - Use WARN_ONCE() instead of pr_warn()
>>>
>>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>>> index 587811a002c9..3237f7dfde1e 100644
>>> --- a/net/sunrpc/svc.c
>>> +++ b/net/sunrpc/svc.c
>>> @@ -575,11 +575,12 @@ svc_destroy(struct kref *ref)
>>>   	timer_shutdown_sync(&serv->sv_temptimer);
>>>   
>>>   	/*
>>> -	 * The last user is gone and thus all sockets have to be destroyed to
>>> -	 * the point. Check this.
>>> +	 * Remaining transports at this point are not expected.
>>>   	 */
>>> -	BUG_ON(!list_empty(&serv->sv_permsocks));
>>> -	BUG_ON(!list_empty(&serv->sv_tempsocks));
>>> +	WARN_ONCE(!list_empty(&serv->sv_permsocks),
>>> +		  "SVC: permsocks remain for %s\n", serv->sv_program->pg_name);
>>> +	WARN_ONCE(!list_empty(&serv->sv_tempsocks),
>>> +		  "SVC: tempsocks remain for %s\n", serv->sv_program->pg_name);
>>>   
>>>   	cache_clean_deferred(serv);
>>>   
>>>
>> Reviewed-by: NeilBrown <neilb@suse.de>
>>
>> The stack trace might not be helpful, but this circumstance really
>> really shouldn't happen so if it ever does, I think we really want as
>> much context as practicable.
> I've just wanted to leave a small note, that we've hit this recently (with 6.6.12, so BUG_ON).
>
> Before we've hit the BUG_ON, we've run some performance tests, which involved changing the number of nfsd threads multiple times. After a period without problems, these changes started to fail:
>
> 2024-06-19T15:52:22+02:00 wayofthedodo  rpc.nfsd[4145]: error starting threads: errno 12 (Cannot allocate memory)
> 2024-06-19T15:54:05+02:00 wayofthedodo  rpc.nfsd[4393]: error starting threads: errno 12 (Cannot allocate memory)
> 2024-06-19T15:54:19+02:00 wayofthedodo  rpc.nfsd[4424]: error starting threads: errno 12 (Cannot allocate memory)
> 2024-06-19T15:54:40+02:00 wayofthedodo  rpc.nfsd[4476]: error starting threads: errno 12 (Cannot allocate memory)
> 2024-06-19T15:55:18+02:00 wayofthedodo  rpc.nfsd[4558]: error starting threads: errno 12 (Cannot allocate memory)
>
> Which is - looking at nfs-utils source - ENOMEM from the open or write of /proc/fs/nfsd/threads. ( Or a truncated write to that file, which nfs-utils would report with a random (unset) errno value, but I don't think this can happen with the nfsd filesystem )
>
> Anyway. then 'systemctl restart nfsd' was attempted, which in our setting stops and starts mountd as the service process with Pre and Post commands to stop and start the nfsd:
>
> ExecStartPre=/usr/sbin/exportfs -ra
> ExecStart=/usr/sbin/rpc.mountd --foreground --manage-gids
> ExecStartPost=/usr/sbin/rpc.nfsd --lease-time 90 --grace-time 90 --no-nfs-version 3 8
> ExecStartPost=bash -c "(sleep 10;exportfs -r;sleep 20;exportfs -r;sleep 30;exportfs -r)&"
> ExecReload=/usr/sbin/exportfs -ra
> ExecStopPost=/usr/sbin/rpc.nfsd 0 ; /usr/sbin/exportfs -ua
> Restart=always
>
> This resulted in:
>
> 2024-06-19T15:55:34+02:00 wayofthedodo  rpc.mountd[807]: Caught signal 15, un-registering and exiting.
> 2024-06-19T15:55:34.561970+02:00 wayofthedodo kernel: [2502367.958818] nfsd: last server has exited, flushing export cache
> 2024-06-19T15:55:34+02:00 wayofthedodo  rpc.mountd[4578]: Version 2.5.4 starting
> 2024-06-19T15:55:35.870933+02:00 wayofthedodo kernel: [2502369.261987] NFSD: Using UMH upcall client tracking operations.
> 2024-06-19T15:55:35.870949+02:00 wayofthedodo kernel: [2502369.268678] NFSD: starting 90-second grace period (net f0000000)
> 2024-06-19T15:55:35.887646+02:00 wayofthedodo kernel: [2502369.285013] ------------[ cut here ]------------
> 2024-06-19T15:55:35.887662+02:00 wayofthedodo kernel: [2502369.291230] kernel BUG at net/sunrpc/svc.c:581!
> 2024-06-19T15:55:36.268015+02:00 wayofthedodo kernel: [2502369.297008] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> 2024-06-19T15:55:36.268028+02:00 wayofthedodo kernel: [2502369.303548] CPU: 9 PID: 4579 Comm: rpc.nfsd Not tainted 6.6.12.mx64.461 #1
> 2024-06-19T15:55:36.268031+02:00 wayofthedodo kernel: [2502369.311741] Hardware name: Dell Inc. PowerEdge T440/021KCD, BIOS 2.12.2 07/09/2021
> 2024-06-19T15:55:36.268034+02:00 wayofthedodo kernel: [2502369.320696] RIP: 0010:svc_destroy+0xc9/0xf0 [sunrpc]
> 2024-06-19T15:55:36.268037+02:00 wayofthedodo kernel: [2502369.327474] Code: 00 00 00 be 01 00 00 00 e8 d4 f2 54 e1 41 3b 6d 74 72 bc 49 8b 7d 7c e8 95 40 1c e1 4c 89 e7 5b 5d 41 5c 41 5d e9 87 40 1c e1 <0f> 0b 48 8b 47 ec 48 c7 c7 f9 5a 15 a0 48 8b 70 20 e8 c1 87 01 e1
> 2024-06-19T15:55:36.268040+02:00 wayofthedodo kernel: [2502369.349863] RSP: 0018:ffffc9000e26bd60 EFLAGS: 00010206
> 2024-06-19T15:55:36.268043+02:00 wayofthedodo kernel: [2502369.356573] RAX: ffff88886064e130 RBX: ffff88886064e114 RCX: 0000000000000010
> 2024-06-19T15:55:36.268048+02:00 wayofthedodo kernel: [2502369.365173] RDX: ffff889092d73018 RSI: 0000000000000246 RDI: ffff88a03fc1cfc0
> 2024-06-19T15:55:36.268050+02:00 wayofthedodo kernel: [2502369.373879] RBP: 0000000000000040 R08: 000000000000000f R09: 0000000000000001
> 2024-06-19T15:55:36.268053+02:00 wayofthedodo kernel: [2502369.382474] R10: ffff889092d71000 R11: 0000000000000000 R12: ffff88886064e100
> 2024-06-19T15:55:36.268055+02:00 wayofthedodo kernel: [2502369.391115] R13: ffff88886064e114 R14: ffff88886064e100 R15: ffff8881061d6000
> 2024-06-19T15:55:36.268058+02:00 wayofthedodo kernel: [2502369.399730] FS:  00007f610ac30740(0000) GS:ffff88a03fd00000(0000) knlGS:0000000000000000
> 2024-06-19T15:55:36.268059+02:00 wayofthedodo kernel: [2502369.409410] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2024-06-19T15:55:36.268062+02:00 wayofthedodo kernel: [2502369.416667] CR2: 000000000069adf8 CR3: 00000004ba14a002 CR4: 00000000007706e0
> 2024-06-19T15:55:36.268064+02:00 wayofthedodo kernel: [2502369.425524] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 2024-06-19T15:55:36.268066+02:00 wayofthedodo kernel: [2502369.434240] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 2024-06-19T15:55:36.268068+02:00 wayofthedodo kernel: [2502369.442880] PKRU: 55555554
> 2024-06-19T15:55:36.268070+02:00 wayofthedodo kernel: [2502369.447193] Call Trace:
> 2024-06-19T15:55:36.268071+02:00 wayofthedodo kernel: [2502369.451211]  <TASK>
> 2024-06-19T15:55:36.268073+02:00 wayofthedodo kernel: [2502369.454982]  ? die+0x36/0x90
> 2024-06-19T15:55:36.268075+02:00 wayofthedodo kernel: [2502369.459421]  ? do_trap+0xda/0x100
> 2024-06-19T15:55:36.268077+02:00 wayofthedodo kernel: [2502369.464337]  ? svc_destroy+0xc9/0xf0 [sunrpc]
> 2024-06-19T15:55:36.268079+02:00 wayofthedodo kernel: [2502369.470479]  ? do_error_trap+0x65/0x80
> 2024-06-19T15:55:36.268080+02:00 wayofthedodo kernel: [2502369.475857]  ? svc_destroy+0xc9/0xf0 [sunrpc]
> 2024-06-19T15:55:36.268082+02:00 wayofthedodo kernel: [2502369.481924]  ? exc_invalid_op+0x50/0x70
> 2024-06-19T15:55:36.268084+02:00 wayofthedodo kernel: [2502369.487390]  ? svc_destroy+0xc9/0xf0 [sunrpc]
> 2024-06-19T15:55:36.268099+02:00 wayofthedodo kernel: [2502369.493402]  ? asm_exc_invalid_op+0x1a/0x20
> 2024-06-19T15:55:36.268131+02:00 wayofthedodo kernel: [2502369.498494]  ? svc_destroy+0xc9/0xf0 [sunrpc]
> 2024-06-19T15:55:36.268134+02:00 wayofthedodo kernel: [2502369.504826]  nfsd_svc+0x28c/0x3d0 [nfsd]
> 2024-06-19T15:55:36.268136+02:00 wayofthedodo kernel: [2502369.510836]  write_threads+0xe4/0x190 [nfsd]
> 2024-06-19T15:55:36.268138+02:00 wayofthedodo kernel: [2502369.517184]  ? __pfx_write_threads+0x10/0x10 [nfsd]
> 2024-06-19T15:55:36.268140+02:00 wayofthedodo kernel: [2502369.524580]  nfsctl_transaction_write+0x4a/0x80 [nfsd]
> 2024-06-19T15:55:36.268141+02:00 wayofthedodo kernel: [2502369.531495]  vfs_write+0xcf/0x450
> 2024-06-19T15:55:36.268143+02:00 wayofthedodo kernel: [2502369.535578]  ksys_write+0x6f/0xf0
> 2024-06-19T15:55:36.268145+02:00 wayofthedodo kernel: [2502369.540415]  do_syscall_64+0x43/0x90
> 2024-06-19T15:55:36.268146+02:00 wayofthedodo kernel: [2502369.545455]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> 2024-06-19T15:55:36.268148+02:00 wayofthedodo kernel: [2502369.551988] RIP: 0033:0x7f610ad3aa20
> 2024-06-19T15:55:36.268151+02:00 wayofthedodo kernel: [2502369.557030] Code: 40 00 48 8b 15 e1 b3 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d c1 3b 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
> 2024-06-19T15:55:36.268153+02:00 wayofthedodo kernel: [2502369.578504] RSP: 002b:00007fff4d8deaf8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> 2024-06-19T15:55:36.268155+02:00 wayofthedodo kernel: [2502369.587720] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f610ad3aa20
> 2024-06-19T15:55:36.268157+02:00 wayofthedodo kernel: [2502369.596419] RDX: 0000000000000003 RSI: 000000000040d540 RDI: 0000000000000003
> 2024-06-19T15:55:36.268160+02:00 wayofthedodo kernel: [2502369.604613] RBP: 0000000000000003 R08: 0000000000000000 R09: 00007fff4d8de990
> 2024-06-19T15:55:36.268163+02:00 wayofthedodo kernel: [2502369.613258] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000040
> 2024-06-19T15:55:36.268165+02:00 wayofthedodo kernel: [2502369.621276] R13: 0000000000000001 R14: 000000000040e2a0 R15: 000000000040910e
> 2024-06-19T15:55:36.268166+02:00 wayofthedodo kernel: [2502369.629927]  </TASK>
> 2024-06-19T15:55:36.268171+02:00 wayofthedodo kernel: [2502369.632849] Modules linked in: rpcsec_gss_krb5 nfsv4 nfs i915 iosf_mbi drm_buddy drm_display_helper ttm intel_gtt video 8021q garp stp mrp llc x86_pkg_temp_thermal coretemp kvm_intel tg3 kvm irqbypass crc32c_intel wmi_bmof mgag200 i2c_algo_bit libphy iTCO_wdt i40e iTCO_vendor_support wmi ipmi_si nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc ip_tables x_tables ipv6 autofs4
> 2024-06-19T15:55:36.268181+02:00 wayofthedodo kernel: [2502369.672534] ---[ end trace 0000000000000000 ]---
> 2024-06-19T15:55:36.278358+02:00 wayofthedodo kernel: [2502369.677557] RIP: 0010:svc_destroy+0xc9/0xf0 [sunrpc]
> 2024-06-19T15:55:36.278372+02:00 wayofthedodo kernel: [2502369.682931] Code: 00 00 00 be 01 00 00 00 e8 d4 f2 54 e1 41 3b 6d 74 72 bc 49 8b 7d 7c e8 95 40 1c e1 4c 89 e7 5b 5d 41 5c 41 5d e9 87 40 1c e1 <0f> 0b 48 8b 47 ec 48 c7 c7 f9 5a 15 a0 48 8b 70 20 e8 c1 87 01 e1
> 2024-06-19T15:55:36.297705+02:00 wayofthedodo kernel: [2502369.702288] RSP: 0018:ffffc9000e26bd60 EFLAGS: 00010206
> 2024-06-19T15:55:36.303328+02:00 wayofthedodo kernel: [2502369.707906] RAX: ffff88886064e130 RBX: ffff88886064e114 RCX: 0000000000000010
> 2024-06-19T15:55:36.310851+02:00 wayofthedodo kernel: [2502369.715430] RDX: ffff889092d73018 RSI: 0000000000000246 RDI: ffff88a03fc1cfc0
> 2024-06-19T15:55:36.325920+02:00 wayofthedodo kernel: [2502369.722960] RBP: 0000000000000040 R08: 000000000000000f R09: 0000000000000001
> 2024-06-19T15:55:36.325933+02:00 wayofthedodo kernel: [2502369.730483] R10: ffff889092d71000 R11: 0000000000000000 R12: ffff88886064e100
> 2024-06-19T15:55:36.340957+02:00 wayofthedodo kernel: [2502369.738015] R13: ffff88886064e114 R14: ffff88886064e100 R15: ffff8881061d6000
> 2024-06-19T15:55:36.340970+02:00 wayofthedodo kernel: [2502369.745537] FS:  00007f610ac30740(0000) GS:ffff88a03fd00000(0000) knlGS:0000000000000000
> 2024-06-19T15:55:36.349441+02:00 wayofthedodo kernel: [2502369.754015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 2024-06-19T15:55:36.355576+02:00 wayofthedodo kernel: [2502369.760149] CR2: 000000000069adf8 CR3: 00000004ba14a002 CR4: 00000000007706e0
> 2024-06-19T15:55:36.363069+02:00 wayofthedodo kernel: [2502369.767681] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 2024-06-19T15:55:36.370634+02:00 wayofthedodo kernel: [2502369.775210] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 2024-06-19T15:55:36.378121+02:00 wayofthedodo kernel: [2502369.782735] PKRU: 55555554
> 2024-06-19T15:55:36+02:00 wayofthedodo  rpc.mountd[4578]: Caught signal 15, un-registering and exiting.
>
> Best
>
>    Donald
Hi
I noticed that this problem still exists in 6.6 now and I also found it 
in 5.10.
What's more, I found another UAF problem.

They can be reproduced in the following way:

1) BUG_ON in svc_destroy
mount /dev/sda /mnt/sda
echo "/mnt *(rw,no_root_squash,fsid=0)" > /etc/exports
echo "/mnt/sda *(rw,no_root_squash,fsid=1)" >> /etc/exports
mount -t nfsd nfsd /proc/fs/nfsd
systemctl restart nfs-server
cd test/
sh threads_test.sh &
ps aux | grep thread
kill -9 2779

[root@localhost ~]# mount /dev/sda /mnt/sda
[root@localhost ~]# echo "/mnt *(rw,no_root_squash,fsid=0)" > /etc/exports
[root@localhost ~]# echo "/mnt/sda *(rw,no_root_squash,fsid=1)" >> 
/etc/exports
[root@localhost ~]# mount -t nfsd nfsd /proc/fs/nfsd
[root@localhost ~]# systemctl restart nfs-server
[root@localhost ~]# cd test/
[root@localhost test]# sh threads_test.sh &
[1] 2779
[root@localhost test]# ps aux | grep thread
root         2  0.0  0.0      0     0 ?        S    10:59   0:00 [kthreadd]
root      2779  0.8  0.0 120052  1068 ttyS0    D    11:08   0:00 sh 
threads_test.sh
root      2808  0.0  0.0 119468   884 ttyS0    S+   11:08   0:00 grep 
--color=auto thread
[root@localhost test]# kill -9 2779
[root@localhost test]# [  521.533252] ------------[ cut here ]------------
[  521.534078] kernel BUG at net/sunrpc/svc.c:570!
[  521.534786] invalid opcode: 0000 [#1] SMP KASAN
[  521.535492] CPU: 1 PID: 2779 Comm: sh Not tainted 
5.10.0-00140-g606211a2593d-dirty #371
[  521.536845] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 
04/01/2014
[  521.538988] RIP: 0010:svc_destroy+0x118/0x160
[  521.539677] Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 
41 48 8b bb 9c 00 00 00 e8 a4 9e 47 fe 4c 89 e7 5b 5d 41 5c e9 98 9e 47 
fe <0f> 0b 0f 0b 48 c7 c7 c0 1e c1 88
[  521.542643] RSP: 0018:ffffc90003d67ca8 EFLAGS: 00010297
[  521.543544] RAX: ffff88810db3c018 RBX: ffff888105457514 RCX: 
1ffff11020a8aeac
[  521.544714] RDX: 1ffff11020a8aea6 RSI: 0000000000000246 RDI: 
ffff88813632c100
[  521.545841] RBP: ffff888105457530 R08: 0000000000000001 R09: 
fffff520007acf6a
[  521.546956] R10: 0000000000000003 R11: fffff520007acf69 R12: 
ffff888105457500
[  521.548098] R13: ffff8882418c05c9 R14: ffff888105457500 R15: 
ffff8882418c05f0
[  521.549234] FS:  00007fea0bba3700(0000) GS:ffff888136280000(0000) 
knlGS:0000000000000000
[  521.550486] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  521.551405] CR2: 00007efd6ca85000 CR3: 0000000450f80000 CR4: 
00000000000006e0
[  521.552509] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  521.553654] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  521.554666] Call Trace:
[  521.555031]  ? __die_body+0x1b/0x60
[  521.555534]  ? die+0x2b/0x50
[  521.555958]  ? do_trap+0x1a1/0x260
[  521.556460]  ? svc_destroy+0x118/0x160
[  521.556985]  ? do_error_trap+0x8a/0xe0
[  521.557512]  ? svc_destroy+0x118/0x160
[  521.558044]  ? exc_invalid_op+0x4e/0x70
[  521.558580]  ? svc_destroy+0x118/0x160
[  521.559116]  ? asm_exc_invalid_op+0x12/0x20
[  521.559701]  ? svc_destroy+0x118/0x160
[  521.560230]  ? svc_destroy+0x58/0x160
[  521.560744]  nfsd_svc+0x601/0x950
[  521.561219]  ? _raw_spin_lock+0x7a/0xd0
[  521.561754]  write_threads+0x1ad/0x280
[  521.562282]  ? write_pool_threads+0x430/0x430
[  521.562893]  ? acpi_idle_enter_bm.isra.0+0x181/0x3e0
[  521.563593]  ? _raw_spin_lock_irq+0xd0/0xd0
[  521.564191]  ? _copy_from_user+0x4f/0x90
[  521.564743]  ? write_pool_threads+0x430/0x430
[  521.565360]  nfsctl_transaction_write+0xac/0x110
[  521.566020]  vfs_write+0x174/0x780
[  521.566502]  ksys_write+0xed/0x1c0
[  521.567002]  ? __ia32_sys_read+0xb0/0xb0
[  521.567558]  ? exit_to_user_mode_prepare+0x17/0x140
[  521.568234]  do_syscall_64+0x2d/0x40
[  521.568736]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[  521.569447] RIP: 0033:0x7fea0b292130
[  521.569955] Code: 73 01 c3 48 8b 0d 58 ed 2c 00 f7 d8 64 89 01 48 83 
c8 ff c3 66 0f 1f 44 00 00 83 3d b9 45 2d 00 00 75 10 b8 01 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 31 c3 48 84
[  521.572520] RSP: 002b:00007ffc31276548 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[  521.573562] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
00007fea0b292130
[  521.574551] RDX: 0000000000000002 RSI: 000055e8e1398240 RDI: 
0000000000000001
[  521.575545] RBP: 000055e8e1398240 R08: 000000000000000a R09: 
00007fea0bba3700
[  521.576534] R10: 000055e8e1397c20 R11: 0000000000000246 R12: 
0000000000000002
[  521.577549] R13: 0000000000000001 R14: 00007fea0b5625e0 R15: 
00007fea0b55d8c0
[  521.578567] Modules linked in:
[  521.579065] ---[ end trace 7e90504bd46025c7 ]---
[  521.579727] RIP: 0010:svc_destroy+0x118/0x160
[  521.580367] Code: 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 
41 48 8b bb 9c 00 00 00 e8 a4 9e 47 fe 4c 89 e7 5b 5d 41 5c e9 98 9e 47 
fe <0f> 0b 0f 0b 48 c7 c7 c0 1e c1 88
[  521.582990] RSP: 0018:ffffc90003d67ca8 EFLAGS: 00010297
[  521.583717] RAX: ffff88810db3c018 RBX: ffff888105457514 RCX: 
1ffff11020a8aeac
[  521.584728] RDX: 1ffff11020a8aea6 RSI: 0000000000000246 RDI: 
ffff88813632c100
[  521.585717] RBP: ffff888105457530 R08: 0000000000000001 R09: 
fffff520007acf6a
[  521.586736] R10: 0000000000000003 R11: fffff520007acf69 R12: 
ffff888105457500
[  521.587727] R13: ffff8882418c05c9 R14: ffff888105457500 R15: 
ffff8882418c05f0
[  521.588728] FS:  00007fea0bba3700(0000) GS:ffff888136280000(0000) 
knlGS:0000000000000000
[  521.589863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  521.590673] CR2: 00007efd6ca85000 CR3: 0000000450f80000 CR4: 
00000000000006e0
[  521.591673] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[  521.592670] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[  521.593665] Kernel panic - not syncing: Fatal exception
[  521.594692] Kernel Offset: disabled
[  521.595234] ---[ end Kernel panic - not syncing: Fatal exception ]---

threads_test.sh:
[root@localhost ~]# cat test/threads_test.sh
#!/bin/bash
while true
do
         echo 1 > /proc/fs/nfsd/threads
         echo 0 > /proc/fs/nfsd/threads
done
[root@localhost ~]#

2) UAF in nfsd_create_serv
mount -t nfsd nfsd /proc/fs/nfsd
echo 1 > /proc/fs/nfsd/threads
echo 0 > /proc/fs/nfsd/threads

[root@localhost ~]# mount -t nfsd nfsd /proc/fs/nfsd
[root@localhost ~]# echo 1 > /proc/fs/nfsd/threads
[   87.131454] svc: failed to register nfsdv3 RPC service (errno 111).
[   87.133288] svc: failed to register nfsaclv3 RPC service (errno 111).
-bash: echo: write error: Connection refused
[root@localhost ~]# echo 0 > /proc/fs/nfsd/threads
[   91.144429] 
==================================================================
[   91.147024] BUG: KASAN: use-after-free in nfsd_create_serv+0x318/0x470
[   91.149130] Write of size 4 at addr ffff888240817914 by task bash/2603
[   91.151204]
[   91.151719] CPU: 6 PID: 2603 Comm: bash Not tainted 
5.10.0-00140-g606211a2593d-dirty #371
[   91.153868] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 
04/01/2014
[   91.155806] Call Trace:
[   91.156184]  dump_stack+0x7d/0xa3
[   91.156676]  print_address_description.constprop.0+0x1e/0x280
[   91.157521]  ? _raw_spin_lock_irqsave+0x80/0xe0
[   91.158179]  ? _raw_write_unlock_irqrestore+0x50/0x50
[   91.158921]  ? nfsd_create_serv+0x318/0x470
[   91.159528]  ? nfsd_create_serv+0x318/0x470
[   91.160181]  kasan_report.cold+0x67/0x7f
[   91.160755]  ? nfsd_create_serv+0x318/0x470
[   91.161391]  check_memory_region+0x14d/0x1d0
[   91.162024]  nfsd_create_serv+0x318/0x470
[   91.162609]  nfsd_svc+0x198/0x950
[   91.163109]  ? _raw_spin_lock+0x7a/0xd0
[   91.163670]  write_threads+0x1ad/0x280
[   91.164222]  ? write_pool_threads+0x430/0x430
[   91.164866]  ? acpi_idle_enter_bm.isra.0+0x180/0x3e0
[   91.165595]  ? _raw_spin_lock_irq+0xd0/0xd0
[   91.166210]  ? _copy_from_user+0x4f/0x90
[   91.166784]  ? write_pool_threads+0x430/0x430
[   91.167429]  nfsctl_transaction_write+0xac/0x110
[   91.168096]  vfs_write+0x174/0x780
[   91.168587]  ksys_write+0xed/0x1c0
[   91.169083]  ? __ia32_sys_read+0xb0/0xb0
[   91.169658]  ? exit_to_user_mode_prepare+0x17/0x140
[   91.170376]  do_syscall_64+0x2d/0x40
[   91.170899]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[   91.171625] RIP: 0033:0x7f61f7394130
[   91.172144] Code: 73 01 c3 48 8b 0d 58 ed 2c 00 f7 d8 64 89 01 48 83 
c8 ff c3 66 0f 1f 44 00 00 83 3d b9 45 2d 00 00 75 10 b8 01 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 31 c3 48 84
[   91.174775] RSP: 002b:00007ffc3ae06ae8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[   91.175865] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
00007f61f7394130
[   91.176886] RDX: 0000000000000002 RSI: 000055720b66bc80 RDI: 
0000000000000001
[   91.177908] RBP: 000055720b66bc80 R08: 000000000000000a R09: 
00007f61f7ca5700
[   91.178904] R10: 000055720ba6b7c0 R11: 0000000000000246 R12: 
0000000000000002
[   91.179901] R13: 0000000000000001 R14: 00007f61f76645e0 R15: 
00007f61f765f8c0
[   91.180906]
[   91.181129] Allocated by task 2603:
[   91.181637]  kasan_save_stack+0x1b/0x40
[   91.182184]  __kasan_kmalloc.constprop.0+0xb5/0xe0
[   91.182863]  __svc_create+0x53/0xab0
[   91.183391]  svc_create_pooled+0xa0/0x610
[   91.183969]  nfsd_create_serv+0x16b/0x470
[   91.184546]  nfsd_svc+0x198/0x950
[   91.185033]  write_threads+0x1ad/0x280
[   91.185566]  nfsctl_transaction_write+0xac/0x110
[   91.186226]  vfs_write+0x174/0x780
[   91.186718]  ksys_write+0xed/0x1c0
[   91.187225]  do_syscall_64+0x2d/0x40
[   91.187730]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[   91.188451]
[   91.188673] Freed by task 2603:
[   91.189131]  kasan_save_stack+0x1b/0x40
[   91.189673]  kasan_set_track+0x1c/0x30
[   91.190204]  kasan_set_free_info+0x20/0x30
[   91.190779]  __kasan_slab_free+0x14a/0x180
[   91.191364]  kfree+0xac/0x6c0
[   91.191784]  nfsd_svc+0x601/0x950
[   91.192252]  write_threads+0x1ad/0x280
[   91.192776]  nfsctl_transaction_write+0xac/0x110
[   91.193422]  vfs_write+0x174/0x780
[   91.193915]  ksys_write+0xed/0x1c0
[   91.194394]  do_syscall_64+0x2d/0x40
[   91.194904]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[   91.195605]
[   91.195825] The buggy address belongs to the object at ffff888240817900
[   91.195825]  which belongs to the cache kmalloc-256 of size 256
[   91.197579] The buggy address is located 20 bytes inside of
[   91.197579]  256-byte region [ffff888240817900, ffff888240817a00)
[   91.199189] The buggy address belongs to the page:
[   91.199860] page:ffffea0009020400 refcount:1 mapcount:0 
mapping:0000000000000000 index:0x0 pfn:0x240810
[   91.201165] head:ffffea0009020400 order:3 compound_mapcount:0 
compound_pincount:0
[   91.202207] flags: 
0x6fffff80010200(slab|head|node=1|zone=2|lastcpupid=0x1fffff)
[   91.203237] raw: 006fffff80010200 ffffea000903ae08 ffff888240001270 
ffff888100051900
[   91.204300] raw: 0000000000000000 0000000000200020 00000001ffffffff 
0000000000000000
[   91.205367] page dumped because: kasan: bad access detected
[   91.206136]
[   91.206359] Memory state around the buggy address:
[   91.207045]  ffff888240817800: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   91.208025]  ffff888240817880: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   91.209012] >ffff888240817900: fa fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   91.210015]                          ^
[   91.210538]  ffff888240817980: fb fb fb fb fb fb fb fb fb fb fb fb fb 
fb fb fb
[   91.211520]  ffff888240817a00: fc fc fc fc fc fc fc fc fc fc fc fc fc 
fc fc fc
[   91.212503] 
==================================================================
[   91.213497] Disabling lock debugging due to kernel taint
[   91.215200] ------------[ cut here ]------------
[   91.215854] refcount_t: addition on 0; use-after-free.
[   91.216635] WARNING: CPU: 6 PID: 2603 at lib/refcount.c:25 
refcount_warn_saturate+0xdd/0x140
[   91.217808] Modules linked in:
[   91.218254] CPU: 6 PID: 2603 Comm: bash Tainted: G B             
5.10.0-00140-g606211a2593d-dirty #371
[   91.219607] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 
04/01/2014
[   91.221432] RIP: 0010:refcount_warn_saturate+0xdd/0x140
[   91.222154] Code: 08 25 7d 09 01 e8 01 33 f2 00 0f 0b eb 9d 80 3d f7 
24 7d 09 00 75 94 48 c7 c7 40 56 f2 83 c6 05 e7 24 7d 09 01 e8 e1 32 f2 
00 <0f> 0b e9 7a ff ff ff 80 3d d1 27
[   91.224696] RSP: 0018:ffffc90007ca7c78 EFLAGS: 00010282
[   91.225425] RAX: 0000000000000000 RBX: ffff888240817914 RCX: 
0000000000000000
[   91.226407] RDX: 0000000000000004 RSI: 0000000000000008 RDI: 
fffff52000f94f81
[   91.227397] RBP: 0000000000000002 R08: 0000000000000001 R09: 
ffffed1086fa700d
[   91.228383] R10: ffff888437d38067 R11: ffffed1086fa700c R12: 
0000000000000000
[   91.229381] R13: ffffffff8bd91c80 R14: ffff8881061ee5f0 R15: 
ffffffff8bd92280
[   91.230391] FS:  00007f61f7ca5700(0000) GS:ffff888437d00000(0000) 
knlGS:0000000000000000
[   91.231487] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   91.232275] CR2: 000055720b6efe20 CR3: 0000000247283000 CR4: 
00000000000006e0
[   91.233268] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   91.234271] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   91.235208] Call Trace:
[   91.235542]  ? __warn+0xc9/0x180
[   91.235967]  ? refcount_warn_saturate+0xdd/0x140
[   91.236561]  ? report_bug+0x1e5/0x270
[   91.237045]  ? handle_bug+0x41/0x80
[   91.237504]  ? exc_invalid_op+0x14/0x70
[   91.238001]  ? asm_exc_invalid_op+0x12/0x20
[   91.238557]  ? refcount_warn_saturate+0xdd/0x140
[   91.239168]  ? refcount_warn_saturate+0xdd/0x140
[   91.239785]  nfsd_create_serv+0x407/0x470
[   91.240331]  nfsd_svc+0x198/0x950
[   91.240775]  ? _raw_spin_lock+0x7a/0xd0
[   91.241279]  write_threads+0x1ad/0x280
[   91.241784]  ? write_pool_threads+0x430/0x430
[   91.242394]  ? acpi_idle_enter_bm.isra.0+0x180/0x3e0
[   91.243042]  ? _raw_spin_lock_irq+0xd0/0xd0
[   91.243603]  ? _copy_from_user+0x4f/0x90
[   91.244130]  ? write_pool_threads+0x430/0x430
[   91.244700]  nfsctl_transaction_write+0xac/0x110
[   91.245319]  vfs_write+0x174/0x780
[   91.245772]  ksys_write+0xed/0x1c0
[   91.246230]  ? __ia32_sys_read+0xb0/0xb0
[   91.246761]  ? exit_to_user_mode_prepare+0x17/0x140
[   91.247428]  do_syscall_64+0x2d/0x40
[   91.247920]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[   91.248600] RIP: 0033:0x7f61f7394130
[   91.249083] Code: 73 01 c3 48 8b 0d 58 ed 2c 00 f7 d8 64 89 01 48 83 
c8 ff c3 66 0f 1f 44 00 00 83 3d b9 45 2d 00 00 75 10 b8 01 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 31 c3 48 84
[   91.251532] RSP: 002b:00007ffc3ae06ae8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[   91.252554] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
00007f61f7394130
[   91.253498] RDX: 0000000000000002 RSI: 000055720b66bc80 RDI: 
0000000000000001
[   91.254434] RBP: 000055720b66bc80 R08: 000000000000000a R09: 
00007f61f7ca5700
[   91.255361] R10: 000055720ba6b7c0 R11: 0000000000000246 R12: 
0000000000000002
[   91.256269] R13: 0000000000000001 R14: 00007f61f76645e0 R15: 
00007f61f765f8c0
[   91.257180] ---[ end trace b515c6670aea0e34 ]---
[   91.259080] general protection fault, maybe for address 
0xffff88824f5ec740: 0000 [#1] SMP KASAN
[   91.260223] CPU: 6 PID: 2603 Comm: bash Tainted: G    B W         
5.10.0-00140-g606211a2593d-dirty #371
[   91.261454] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 
04/01/2014
[   91.263159] RIP: 0010:svc_register+0x108/0x1e0
[   91.263732] Code: 89 e0 41 89 dc 44 89 eb 41 89 c5 48 8b 44 24 08 80 
38 00 0f 85 83 00 00 00 45 89 e9 45 89 e0 44 89 f9 89 da 48 89 ee 4c 89 
f7 <ff> 55 48 85 c0 0f 88 2a 40 19 03
[   91.266112] RSP: 0018:ffffc90007ca79c0 EFLAGS: 00010286
[   91.266771] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000002
[   91.267667] RDX: 0000000000000000 RSI: ffff88824f5ec740 RDI: 
ffffffff8bd91c80
[   91.268574] RBP: ffff88824f5ec740 R08: 0000000000000011 R09: 
0000000000000801
[   91.269507] R10: ffffc90007ca7f50 R11: fffff52000f94ee0 R12: 
0000000000000011
[   91.270441] R13: 0000000000000801 R14: ffffffff8bd91c80 R15: 
0000000000000002
[   91.271381] FS:  00007f61f7ca5700(0000) GS:ffff888437d00000(0000) 
knlGS:0000000000000000
[   91.272451] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   91.273192] CR2: 000055720b6efe20 CR3: 0000000247283000 CR4: 
00000000000006e0
[   91.274107] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   91.274996] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   91.275910] Call Trace:
[   91.276228]  ? __die_body+0x1b/0x60
[   91.276687]  ? die_addr+0x43/0x70
[   91.277112]  ? exc_general_protection+0x198/0x2e0
[   91.277710]  ? asm_exc_general_protection+0x1e/0x30
[   91.278345]  ? svc_register+0x108/0x1e0
[   91.278841]  svc_setup_socket+0x6e6/0xcb0
[   91.279377]  ? memset+0x20/0x40
[   91.279806]  svc_create_socket+0x220/0x3f0
[   91.280359]  ? svc_setup_socket+0xcb0/0xcb0
[   91.280934]  ? kasan_set_track+0x1c/0x30
[   91.281471]  ? mutex_lock+0x8e/0xe0
[   91.281946]  ? __mutex_lock_slowpath+0x10/0x10
[   91.282563]  ? _raw_spin_lock+0x7a/0xd0
[   91.283092]  ? _raw_spin_lock_irq+0xd0/0xd0
[   91.283665]  ? alloc_workqueue+0x857/0xeb0
[   91.284204]  _svc_xprt_create+0x1f0/0x570
[   91.284739]  ? svc_add_new_perm_xprt+0x140/0x140
[   91.285369]  ? bucket_table_alloc.isra.0+0xf6/0x3f0
[   91.285997]  svc_xprt_create+0x36/0x90
[   91.286481]  nfsd_svc+0x792/0x950
[   91.286922]  write_threads+0x1ad/0x280
[   91.287397]  ? write_pool_threads+0x430/0x430
[   91.287946]  ? acpi_idle_enter_bm.isra.0+0x180/0x3e0
[   91.288575]  ? _raw_spin_lock_irq+0xd0/0xd0
[   91.289110]  ? _copy_from_user+0x4f/0x90
[   91.289603]  ? write_pool_threads+0x430/0x430
[   91.290152]  nfsctl_transaction_write+0xac/0x110
[   91.290731]  vfs_write+0x174/0x780
[   91.291172]  ksys_write+0xed/0x1c0
[   91.291608]  ? __ia32_sys_read+0xb0/0xb0
[   91.292112]  ? exit_to_user_mode_prepare+0x17/0x140
[   91.292746]  do_syscall_64+0x2d/0x40
[   91.293208]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
[   91.293852] RIP: 0033:0x7f61f7394130
[   91.294302] Code: 73 01 c3 48 8b 0d 58 ed 2c 00 f7 d8 64 89 01 48 83 
c8 ff c3 66 0f 1f 44 00 00 83 3d b9 45 2d 00 00 75 10 b8 01 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 73 31 c3 48 84
[   91.296652] RSP: 002b:00007ffc3ae06ae8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[   91.297622] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
00007f61f7394130
[   91.298546] RDX: 0000000000000002 RSI: 000055720b66bc80 RDI: 
0000000000000001
[   91.299465] RBP: 000055720b66bc80 R08: 000000000000000a R09: 
00007f61f7ca5700
[   91.300392] R10: 000055720ba6b7c0 R11: 0000000000000246 R12: 
0000000000000002
[   91.301301] R13: 0000000000000001 R14: 00007f61f76645e0 R15: 
00007f61f765f8c0
[   91.302207] Modules linked in:
[   91.302674] ---[ end trace b515c6670aea0e35 ]---
[   91.303281] RIP: 0010:svc_register+0x108/0x1e0
[   91.303850] Code: 89 e0 41 89 dc 44 89 eb 41 89 c5 48 8b 44 24 08 80 
38 00 0f 85 83 00 00 00 45 89 e9 45 89 e0 44 89 f9 89 da 48 89 ee 4c 89 
f7 <ff> 55 48 85 c0 0f 88 2a 40 19 03
[   91.306245] RSP: 0018:ffffc90007ca79c0 EFLAGS: 00010286
[   91.306919] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 
0000000000000002
[   91.307798] RDX: 0000000000000000 RSI: ffff88824f5ec740 RDI: 
ffffffff8bd91c80
[   91.308732] RBP: ffff88824f5ec740 R08: 0000000000000011 R09: 
0000000000000801
[   91.309658] R10: ffffc90007ca7f50 R11: fffff52000f94ee0 R12: 
0000000000000011
[   91.310564] R13: 0000000000000801 R14: ffffffff8bd91c80 R15: 
0000000000000002
[   91.311472] FS:  00007f61f7ca5700(0000) GS:ffff888437d00000(0000) 
knlGS:0000000000000000
[   91.312483] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   91.313207] CR2: 000055720b6efe20 CR3: 0000000247283000 CR4: 
00000000000006e0
[   91.314121] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[   91.315028] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[   91.319328] Kernel panic - not syncing: Fatal exception
[   91.320712] Kernel Offset: disabled
[   91.321189] ---[ end Kernel panic - not syncing: Fatal exception ]---

Both of them were introduced by commit 9f28a971ee9f ("nfsd: separate 
nfsd_last_thread() from nfsd_put()") since this patch changes the 
behavior of the error path.

I confirmed this by fixing both issues with the following changes:
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index ee5713fca187..05d4b463c16b 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -811,6 +811,8 @@ nfsd_svc(int nrservs, struct net *net, const struct 
cred *cred)
         if (error < 0 && !nfsd_up_before)
                 nfsd_shutdown_net(net);
  out_put:
+       if (error < 0)
+               nfsd_last_thread(net);
         /* Threads now hold service active */
         if (xchg(&nn->keep_active, 0))
                 svc_put(serv);

They have been fixed by commit bf32075256e9 ("NFSD: simplify error paths 
in nfsd_svc()") in mainline.

Maybe it would be a good idea to push it to the LTS branches.

Thanks.

>> Thanks,
>> NeilBrown
>>


