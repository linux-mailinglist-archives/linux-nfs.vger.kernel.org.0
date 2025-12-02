Return-Path: <linux-nfs+bounces-16845-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E31E7C9B7F7
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Dec 2025 13:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5B78834751E
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Dec 2025 12:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9161622AE5D;
	Tue,  2 Dec 2025 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="lEQpFpdJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E581469D
	for <linux-nfs@vger.kernel.org>; Tue,  2 Dec 2025 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764678900; cv=none; b=FjW2JNAzkY6w4fG3JDfE9LP2nnDhUKCMRDmX6AsGbnerNOI+d0LgRM+OpBu4ZTaIS3bmgAQKSHACdHhi0lple3G6kjtN9BeLuhUpDx+Th/PgNzLkRApGG3wgXAvfI2A6oD4oV+WqwQQb6BBJa6DJlJM+VTNsrSFgDDB10FuyXp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764678900; c=relaxed/simple;
	bh=KewI07/tO6DkhL0E9vl9p0ShUT1JVaoA3EzJN1L1SS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HD7yHbjqxg4Xzw2nz45GrkfRt8aJRklYRwcXUbTN+ipZsdVjYYkwBKY0xzvQ/v4aXRYhtAdO9RP+Aq9orAgkfc0bSkKhvkAwhQCjOnXpzhbX7CXJfiqgPdgGRMYdsX4DQI+ZQN5YW7xDEo/a56MS3r0bgXmdM/TFMspIyRkyLWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=lEQpFpdJ; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tQgewgBvp7uWAdBsDoX1KsgLFt+yJy02TqjWuiTYsXk=;
	b=lEQpFpdJxiEBqufJJWiM4/Z3POC/PcLyLg3DcYtTTMSuDSMADWq6iLnSPKc2Hp0m8MOYNoqXy
	CHey+X9Hjg8AEkusLC0/qu6qx7kF5vx7b9aQf0LTqGdPLQ+IYE+YsVjH1F48sReodyDGVX80WG5
	p7N3ymmWb6ZD/BonFpCACV4=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4dLKtR2mNnz1K96F;
	Tue,  2 Dec 2025 20:33:03 +0800 (CST)
Received: from kwepemj200013.china.huawei.com (unknown [7.202.194.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 5EF2D1401E9;
	Tue,  2 Dec 2025 20:34:53 +0800 (CST)
Received: from [10.174.179.155] (10.174.179.155) by
 kwepemj200013.china.huawei.com (7.202.194.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 2 Dec 2025 20:34:52 +0800
Message-ID: <90e58dc8-77e2-42dd-972a-44408f2de24e@huawei.com>
Date: Tue, 2 Dec 2025 20:34:52 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH RFT v2] nfsd: provide locking for v4_end_grace
To: NeilBrown <neil@brown.name>, Chuck Lever <chuck.lever@oracle.com>
CC: <linux-nfs@vger.kernel.org>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Jeff Layton
	<jlayton@kernel.org>, yangerkun <yangerkun@huawei.com>, "zhangjian (CG)"
	<zhangjian496@huawei.com>
References: <175136659151.565058.6474755472267609432@noble.neil.brown.name>
 <2ed77c1d-787c-4abf-96c2-72821e73d565@oracle.com>
 <175149132125.565058.15666202434202898775@noble.neil.brown.name>
From: Li Lingfeng <lilingfeng3@huawei.com>
In-Reply-To: <175149132125.565058.15666202434202898775@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj200013.china.huawei.com (7.202.194.25)

Hi Neil,

在 2025/7/3 5:22, NeilBrown 写道:
> On Wed, 02 Jul 2025, Chuck Lever wrote:
>> Hi Neil, handful of nits below.
>>
>>> [[
>>>   v2 - disable laundromat_work while _init is running as well as while
>>>   _exit is running.  Don't depend on ->nfsd_serv, test
>>>   ->client_tracking_ops instead.
>>> ]]
>> Do you want the patch change history to appear in the commit log?
>> Asking because that is not usual practice.
> Not really.  I'll send something new, likely tomorrow morning.
> What do you think is the best way to handle backporting?  Should I
> submit the version that doesn't use disable_delayed_work(), then add a
> patch which changes to use that instead of a flag ?
>
> Thanks,
> NeilBrown
It seems that this issue has not been fixed in the mainline yet. I was
able to reproduce it again based on e7c375b18160:
[  508.295384][ T1056] BUG: KASAN: slab-use-after-free in 
nfs4_release_reclaim+0x346/0x360
[  508.298229][ T1056] Read of size 8 at addr ffff888400718a00 by task 
bash/1056
[  508.300679][ T1056]
[  508.301368][ T1056] CPU: 3 UID: 0 PID: 1056 Comm: bash Not tainted 
6.18.0-rc6+ #166 PREEMPT(none)
[  508.301380][ T1056] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.16.3-2.fc40 04/01/2014
[  508.301386][ T1056] Call Trace:
[  508.301393][ T1056]  <TASK>
[  508.301401][ T1056]  dump_stack_lvl+0x4b/0x70
[  508.301417][ T1056] print_address_description.constprop.0+0x88/0x320
[  508.301430][ T1056]  ? nfs4_release_reclaim+0x346/0x360
[  508.301439][ T1056]  print_report+0x106/0x1f4
[  508.301448][ T1056]  ? nfs4_release_reclaim+0x346/0x360
[  508.301457][ T1056]  ? nfs4_release_reclaim+0x346/0x360
[  508.301466][ T1056]  kasan_report+0xb9/0xf0
[  508.301478][ T1056]  ? nfs4_release_reclaim+0x346/0x360
[  508.301489][ T1056]  nfs4_release_reclaim+0x346/0x360
[  508.301501][ T1056]  nfsd4_cld_grace_done+0x171/0x198
[  508.301514][ T1056]  nfsd4_end_grace+0x160/0x176
[  508.301523][ T1056]  write_v4_end_grace+0x165/0x390
[  508.301534][ T1056]  ? __pfx_write_v4_end_grace+0x10/0x10
[  508.301542][ T1056]  nfsctl_transaction_write+0xd1/0x150
[  508.301551][ T1056]  vfs_write+0x1d3/0xcc0
[  508.301563][ T1056]  ? __pfx___handle_mm_fault+0x10/0x10
[  508.301571][ T1056]  ? lock_vma_under_rcu+0x2ac/0x640
[  508.301584][ T1056]  ? __pfx_vfs_write+0x10/0x10
[  508.301595][ T1056]  ? count_memcg_events+0x257/0x400
[  508.301606][ T1056]  ? fdget_pos+0x1cf/0x4c0
[  508.301617][ T1056]  ksys_write+0xf3/0x1c0
[  508.301626][ T1056]  ? __pfx_ksys_write+0x10/0x10
[  508.301636][ T1056]  ? do_user_addr_fault+0x830/0xd70
[  508.301648][ T1056]  do_syscall_64+0x61/0x9d0
[  508.301662][ T1056]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  508.301672][ T1056] RIP: 0033:0x7f14257018b7
[  508.301682][ T1056] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff 
eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 
00 00 0f 05 <48> 3d 00 f0 ff ff 77 514
[  508.301691][ T1056] RSP: 002b:00007ffd28c8b1a8 EFLAGS: 00000246 
ORIG_RAX: 0000000000000001
[  508.301703][ T1056] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
00007f14257018b7
[  508.301709][ T1056] RDX: 0000000000000002 RSI: 00005569b744ced0 RDI: 
0000000000000001
[  508.301715][ T1056] RBP: 00005569b744ced0 R08: 0000000000000000 R09: 
00007f14257b64e0
[  508.301720][ T1056] R10: 00007f14257b63e0 R11: 0000000000000246 R12: 
0000000000000002
[  508.301725][ T1056] R13: 00007f14257fb5a0 R14: 0000000000000002 R15: 
00007f14257fb7a0

Do you have plans to submit an updated patch?

Thanks,
Lingfeng


