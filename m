Return-Path: <linux-nfs+bounces-4366-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E7691A700
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 14:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFC99B23538
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jun 2024 12:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF5D17837F;
	Thu, 27 Jun 2024 12:54:22 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34863178373
	for <linux-nfs@vger.kernel.org>; Thu, 27 Jun 2024 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492862; cv=none; b=JmfE8MrwqW4ikXEaQuQDAib/rGjO2guv+tmnKWd/sJTWvtg0iJbKdLVlKsjjbC6KxrkNq64qfE6ehkAqV/8MJl4/QzU5w1yLQU1orWChHNhcDakyoMghVTYGMJ6cda3ORjwT6h5DrsZ+g8EXS1ZA7rWZCdRExUd8c6E4uRz7CkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492862; c=relaxed/simple;
	bh=0YyQh702eFg4tQmhNwZEm4VKcVi5YAGYlZvy2QjL2pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WNsqRYPvpDZhmt1dIpbvOPPtT+gcEWkCjxKs6x3qgS/uJEC3OZOgQb3Qz2ANrXDOlgHdEbwZ/lSkjIym2/IXVjcVX91irUJ4lF8kY4QrdVVUcGn6aKT8xeAHakl4hnrKk4WTdI2IeG5IqdvFjc6MLJEsyGBEJuWrmlTHrea2EVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.31.7] (theinternet.molgen.mpg.de [141.14.31.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: buczek)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3891B61E5FE01;
	Thu, 27 Jun 2024 14:53:47 +0200 (CEST)
Message-ID: <793386f6-65bc-48ef-9d7c-71314ddd4c86@molgen.mpg.de>
Date: Thu, 27 Jun 2024 14:53:46 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] SUNRPC: Remove BUG_ON call sites
To: NeilBrown <neilb@suse.de>, Chuck Lever <cel@kernel.org>
Cc: brauner@kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org, it+linux@molgen.mpg.de
References: <169513768769.145733.5037542987990908432.stgit@manet.1015granger.net>
 <169516146143.19404.11284116898963519832@noble.neil.brown.name>
Content-Language: en-US
From: Donald Buczek <buczek@molgen.mpg.de>
In-Reply-To: <169516146143.19404.11284116898963519832@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/20/23 00:11, NeilBrown wrote:
> On Wed, 20 Sep 2023, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> There is no need to take down the whole system for these assertions.
>>
>> I'd rather not attempt a heroic save here, as some bug has occurred
>> that has left the transport data structures in an unknown state.
>> Just warn and then leak the left-over resources.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> Acked-by: Christian Brauner <brauner@kernel.org>
>> ---
>>  net/sunrpc/svc.c |    9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> Changes since v1:
>> - Use WARN_ONCE() instead of pr_warn()
>>
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index 587811a002c9..3237f7dfde1e 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -575,11 +575,12 @@ svc_destroy(struct kref *ref)
>>  	timer_shutdown_sync(&serv->sv_temptimer);
>>  
>>  	/*
>> -	 * The last user is gone and thus all sockets have to be destroyed to
>> -	 * the point. Check this.
>> +	 * Remaining transports at this point are not expected.
>>  	 */
>> -	BUG_ON(!list_empty(&serv->sv_permsocks));
>> -	BUG_ON(!list_empty(&serv->sv_tempsocks));
>> +	WARN_ONCE(!list_empty(&serv->sv_permsocks),
>> +		  "SVC: permsocks remain for %s\n", serv->sv_program->pg_name);
>> +	WARN_ONCE(!list_empty(&serv->sv_tempsocks),
>> +		  "SVC: tempsocks remain for %s\n", serv->sv_program->pg_name);
>>  
>>  	cache_clean_deferred(serv);
>>  
>>
> 
> Reviewed-by: NeilBrown <neilb@suse.de>
> 
> The stack trace might not be helpful, but this circumstance really
> really shouldn't happen so if it ever does, I think we really want as
> much context as practicable.

I've just wanted to leave a small note, that we've hit this recently (with 6.6.12, so BUG_ON).

Before we've hit the BUG_ON, we've run some performance tests, which involved changing the number of nfsd threads multiple times. After a period without problems, these changes started to fail:

2024-06-19T15:52:22+02:00 wayofthedodo  rpc.nfsd[4145]: error starting threads: errno 12 (Cannot allocate memory)
2024-06-19T15:54:05+02:00 wayofthedodo  rpc.nfsd[4393]: error starting threads: errno 12 (Cannot allocate memory)
2024-06-19T15:54:19+02:00 wayofthedodo  rpc.nfsd[4424]: error starting threads: errno 12 (Cannot allocate memory)
2024-06-19T15:54:40+02:00 wayofthedodo  rpc.nfsd[4476]: error starting threads: errno 12 (Cannot allocate memory)
2024-06-19T15:55:18+02:00 wayofthedodo  rpc.nfsd[4558]: error starting threads: errno 12 (Cannot allocate memory)

Which is - looking at nfs-utils source - ENOMEM from the open or write of /proc/fs/nfsd/threads. ( Or a truncated write to that file, which nfs-utils would report with a random (unset) errno value, but I don't think this can happen with the nfsd filesystem )

Anyway. then 'systemctl restart nfsd' was attempted, which in our setting stops and starts mountd as the service process with Pre and Post commands to stop and start the nfsd:

ExecStartPre=/usr/sbin/exportfs -ra
ExecStart=/usr/sbin/rpc.mountd --foreground --manage-gids
ExecStartPost=/usr/sbin/rpc.nfsd --lease-time 90 --grace-time 90 --no-nfs-version 3 8
ExecStartPost=bash -c "(sleep 10;exportfs -r;sleep 20;exportfs -r;sleep 30;exportfs -r)&"
ExecReload=/usr/sbin/exportfs -ra
ExecStopPost=/usr/sbin/rpc.nfsd 0 ; /usr/sbin/exportfs -ua
Restart=always

This resulted in:

2024-06-19T15:55:34+02:00 wayofthedodo  rpc.mountd[807]: Caught signal 15, un-registering and exiting.
2024-06-19T15:55:34.561970+02:00 wayofthedodo kernel: [2502367.958818] nfsd: last server has exited, flushing export cache
2024-06-19T15:55:34+02:00 wayofthedodo  rpc.mountd[4578]: Version 2.5.4 starting
2024-06-19T15:55:35.870933+02:00 wayofthedodo kernel: [2502369.261987] NFSD: Using UMH upcall client tracking operations.
2024-06-19T15:55:35.870949+02:00 wayofthedodo kernel: [2502369.268678] NFSD: starting 90-second grace period (net f0000000)
2024-06-19T15:55:35.887646+02:00 wayofthedodo kernel: [2502369.285013] ------------[ cut here ]------------
2024-06-19T15:55:35.887662+02:00 wayofthedodo kernel: [2502369.291230] kernel BUG at net/sunrpc/svc.c:581!
2024-06-19T15:55:36.268015+02:00 wayofthedodo kernel: [2502369.297008] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
2024-06-19T15:55:36.268028+02:00 wayofthedodo kernel: [2502369.303548] CPU: 9 PID: 4579 Comm: rpc.nfsd Not tainted 6.6.12.mx64.461 #1
2024-06-19T15:55:36.268031+02:00 wayofthedodo kernel: [2502369.311741] Hardware name: Dell Inc. PowerEdge T440/021KCD, BIOS 2.12.2 07/09/2021
2024-06-19T15:55:36.268034+02:00 wayofthedodo kernel: [2502369.320696] RIP: 0010:svc_destroy+0xc9/0xf0 [sunrpc]
2024-06-19T15:55:36.268037+02:00 wayofthedodo kernel: [2502369.327474] Code: 00 00 00 be 01 00 00 00 e8 d4 f2 54 e1 41 3b 6d 74 72 bc 49 8b 7d 7c e8 95 40 1c e1 4c 89 e7 5b 5d 41 5c 41 5d e9 87 40 1c e1 <0f> 0b 48 8b 47 ec 48 c7 c7 f9 5a 15 a0 48 8b 70 20 e8 c1 87 01 e1
2024-06-19T15:55:36.268040+02:00 wayofthedodo kernel: [2502369.349863] RSP: 0018:ffffc9000e26bd60 EFLAGS: 00010206
2024-06-19T15:55:36.268043+02:00 wayofthedodo kernel: [2502369.356573] RAX: ffff88886064e130 RBX: ffff88886064e114 RCX: 0000000000000010
2024-06-19T15:55:36.268048+02:00 wayofthedodo kernel: [2502369.365173] RDX: ffff889092d73018 RSI: 0000000000000246 RDI: ffff88a03fc1cfc0
2024-06-19T15:55:36.268050+02:00 wayofthedodo kernel: [2502369.373879] RBP: 0000000000000040 R08: 000000000000000f R09: 0000000000000001
2024-06-19T15:55:36.268053+02:00 wayofthedodo kernel: [2502369.382474] R10: ffff889092d71000 R11: 0000000000000000 R12: ffff88886064e100
2024-06-19T15:55:36.268055+02:00 wayofthedodo kernel: [2502369.391115] R13: ffff88886064e114 R14: ffff88886064e100 R15: ffff8881061d6000
2024-06-19T15:55:36.268058+02:00 wayofthedodo kernel: [2502369.399730] FS:  00007f610ac30740(0000) GS:ffff88a03fd00000(0000) knlGS:0000000000000000
2024-06-19T15:55:36.268059+02:00 wayofthedodo kernel: [2502369.409410] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2024-06-19T15:55:36.268062+02:00 wayofthedodo kernel: [2502369.416667] CR2: 000000000069adf8 CR3: 00000004ba14a002 CR4: 00000000007706e0
2024-06-19T15:55:36.268064+02:00 wayofthedodo kernel: [2502369.425524] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
2024-06-19T15:55:36.268066+02:00 wayofthedodo kernel: [2502369.434240] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
2024-06-19T15:55:36.268068+02:00 wayofthedodo kernel: [2502369.442880] PKRU: 55555554
2024-06-19T15:55:36.268070+02:00 wayofthedodo kernel: [2502369.447193] Call Trace:
2024-06-19T15:55:36.268071+02:00 wayofthedodo kernel: [2502369.451211]  <TASK>
2024-06-19T15:55:36.268073+02:00 wayofthedodo kernel: [2502369.454982]  ? die+0x36/0x90
2024-06-19T15:55:36.268075+02:00 wayofthedodo kernel: [2502369.459421]  ? do_trap+0xda/0x100
2024-06-19T15:55:36.268077+02:00 wayofthedodo kernel: [2502369.464337]  ? svc_destroy+0xc9/0xf0 [sunrpc]
2024-06-19T15:55:36.268079+02:00 wayofthedodo kernel: [2502369.470479]  ? do_error_trap+0x65/0x80
2024-06-19T15:55:36.268080+02:00 wayofthedodo kernel: [2502369.475857]  ? svc_destroy+0xc9/0xf0 [sunrpc]
2024-06-19T15:55:36.268082+02:00 wayofthedodo kernel: [2502369.481924]  ? exc_invalid_op+0x50/0x70
2024-06-19T15:55:36.268084+02:00 wayofthedodo kernel: [2502369.487390]  ? svc_destroy+0xc9/0xf0 [sunrpc]
2024-06-19T15:55:36.268099+02:00 wayofthedodo kernel: [2502369.493402]  ? asm_exc_invalid_op+0x1a/0x20
2024-06-19T15:55:36.268131+02:00 wayofthedodo kernel: [2502369.498494]  ? svc_destroy+0xc9/0xf0 [sunrpc]
2024-06-19T15:55:36.268134+02:00 wayofthedodo kernel: [2502369.504826]  nfsd_svc+0x28c/0x3d0 [nfsd]
2024-06-19T15:55:36.268136+02:00 wayofthedodo kernel: [2502369.510836]  write_threads+0xe4/0x190 [nfsd]
2024-06-19T15:55:36.268138+02:00 wayofthedodo kernel: [2502369.517184]  ? __pfx_write_threads+0x10/0x10 [nfsd]
2024-06-19T15:55:36.268140+02:00 wayofthedodo kernel: [2502369.524580]  nfsctl_transaction_write+0x4a/0x80 [nfsd]
2024-06-19T15:55:36.268141+02:00 wayofthedodo kernel: [2502369.531495]  vfs_write+0xcf/0x450
2024-06-19T15:55:36.268143+02:00 wayofthedodo kernel: [2502369.535578]  ksys_write+0x6f/0xf0
2024-06-19T15:55:36.268145+02:00 wayofthedodo kernel: [2502369.540415]  do_syscall_64+0x43/0x90
2024-06-19T15:55:36.268146+02:00 wayofthedodo kernel: [2502369.545455]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
2024-06-19T15:55:36.268148+02:00 wayofthedodo kernel: [2502369.551988] RIP: 0033:0x7f610ad3aa20
2024-06-19T15:55:36.268151+02:00 wayofthedodo kernel: [2502369.557030] Code: 40 00 48 8b 15 e1 b3 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d c1 3b 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
2024-06-19T15:55:36.268153+02:00 wayofthedodo kernel: [2502369.578504] RSP: 002b:00007fff4d8deaf8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
2024-06-19T15:55:36.268155+02:00 wayofthedodo kernel: [2502369.587720] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f610ad3aa20
2024-06-19T15:55:36.268157+02:00 wayofthedodo kernel: [2502369.596419] RDX: 0000000000000003 RSI: 000000000040d540 RDI: 0000000000000003
2024-06-19T15:55:36.268160+02:00 wayofthedodo kernel: [2502369.604613] RBP: 0000000000000003 R08: 0000000000000000 R09: 00007fff4d8de990
2024-06-19T15:55:36.268163+02:00 wayofthedodo kernel: [2502369.613258] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000040
2024-06-19T15:55:36.268165+02:00 wayofthedodo kernel: [2502369.621276] R13: 0000000000000001 R14: 000000000040e2a0 R15: 000000000040910e
2024-06-19T15:55:36.268166+02:00 wayofthedodo kernel: [2502369.629927]  </TASK>
2024-06-19T15:55:36.268171+02:00 wayofthedodo kernel: [2502369.632849] Modules linked in: rpcsec_gss_krb5 nfsv4 nfs i915 iosf_mbi drm_buddy drm_display_helper ttm intel_gtt video 8021q garp stp mrp llc x86_pkg_temp_thermal coretemp kvm_intel tg3 kvm irqbypass crc32c_intel wmi_bmof mgag200 i2c_algo_bit libphy iTCO_wdt i40e iTCO_vendor_support wmi ipmi_si nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc ip_tables x_tables ipv6 autofs4
2024-06-19T15:55:36.268181+02:00 wayofthedodo kernel: [2502369.672534] ---[ end trace 0000000000000000 ]---
2024-06-19T15:55:36.278358+02:00 wayofthedodo kernel: [2502369.677557] RIP: 0010:svc_destroy+0xc9/0xf0 [sunrpc]
2024-06-19T15:55:36.278372+02:00 wayofthedodo kernel: [2502369.682931] Code: 00 00 00 be 01 00 00 00 e8 d4 f2 54 e1 41 3b 6d 74 72 bc 49 8b 7d 7c e8 95 40 1c e1 4c 89 e7 5b 5d 41 5c 41 5d e9 87 40 1c e1 <0f> 0b 48 8b 47 ec 48 c7 c7 f9 5a 15 a0 48 8b 70 20 e8 c1 87 01 e1
2024-06-19T15:55:36.297705+02:00 wayofthedodo kernel: [2502369.702288] RSP: 0018:ffffc9000e26bd60 EFLAGS: 00010206
2024-06-19T15:55:36.303328+02:00 wayofthedodo kernel: [2502369.707906] RAX: ffff88886064e130 RBX: ffff88886064e114 RCX: 0000000000000010
2024-06-19T15:55:36.310851+02:00 wayofthedodo kernel: [2502369.715430] RDX: ffff889092d73018 RSI: 0000000000000246 RDI: ffff88a03fc1cfc0
2024-06-19T15:55:36.325920+02:00 wayofthedodo kernel: [2502369.722960] RBP: 0000000000000040 R08: 000000000000000f R09: 0000000000000001
2024-06-19T15:55:36.325933+02:00 wayofthedodo kernel: [2502369.730483] R10: ffff889092d71000 R11: 0000000000000000 R12: ffff88886064e100
2024-06-19T15:55:36.340957+02:00 wayofthedodo kernel: [2502369.738015] R13: ffff88886064e114 R14: ffff88886064e100 R15: ffff8881061d6000
2024-06-19T15:55:36.340970+02:00 wayofthedodo kernel: [2502369.745537] FS:  00007f610ac30740(0000) GS:ffff88a03fd00000(0000) knlGS:0000000000000000
2024-06-19T15:55:36.349441+02:00 wayofthedodo kernel: [2502369.754015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
2024-06-19T15:55:36.355576+02:00 wayofthedodo kernel: [2502369.760149] CR2: 000000000069adf8 CR3: 00000004ba14a002 CR4: 00000000007706e0
2024-06-19T15:55:36.363069+02:00 wayofthedodo kernel: [2502369.767681] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
2024-06-19T15:55:36.370634+02:00 wayofthedodo kernel: [2502369.775210] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
2024-06-19T15:55:36.378121+02:00 wayofthedodo kernel: [2502369.782735] PKRU: 55555554
2024-06-19T15:55:36+02:00 wayofthedodo  rpc.mountd[4578]: Caught signal 15, un-registering and exiting.

Best

  Donald

> 
> Thanks,
> NeilBrown
> 

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433


