Return-Path: <linux-nfs+bounces-4192-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA859114B9
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 23:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9B21C2176C
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jun 2024 21:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F0F74BF0;
	Thu, 20 Jun 2024 21:35:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B0C7602B
	for <linux-nfs@vger.kernel.org>; Thu, 20 Jun 2024 21:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718919302; cv=none; b=Ee3pTMtZqv4NBJguutCcLJCBFSITMaHpkVQ2wlOgQ8i0nqPfDznLndJMeAclTw9qT2LGstPp/15ZbeOenuoUfBkxHP8wYnBUmmqMGCc1U2vvPRuXwBnlZI2RrhZpAibohfgsBMZbhi57FFQ+tCeQV1EwbgYrUqjJC2rSKB6VyE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718919302; c=relaxed/simple;
	bh=m0nILwih6ROARcftbmXVI8BbWEEA9EyTwXutUZN532M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ifxz5bqxHj26AI05laC3s73z5s8+ZoMb+iGahs6FeZkGckqp2ObEm4zmOmPE8nL/sHlthdaWylXhnaUosTld4feLY4VtLSRdTDSjJaK7iicASynZ/RpPa98CPe6OcNv+ORSUQsqZOww0t9UHsdWmu+YMFBXi71qsQDfKFhxfVYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af233.dynamic.kabel-deutschland.de [95.90.242.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5B53261E5FE01;
	Thu, 20 Jun 2024 23:34:14 +0200 (CEST)
Message-ID: <7f7a45a2-1134-4cef-be5a-ce50667cf1d1@molgen.mpg.de>
Date: Thu, 20 Jun 2024 23:34:13 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Linux 6.6.12: kernel BUG at net/sunrpc/svc.c:581!: invalid opcode:
 0000 [#1] PREEMPT SMP NOPTI, svc_destroy
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
References: <3179936e-71eb-cb0a-8a8f-362607150771@molgen.mpg.de>
Content-Language: en-US
Cc: linux-nfs@vger.kernel.org, it+linux-nfs@molgen.mpg.de
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <3179936e-71eb-cb0a-8a8f-362607150771@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Linux folks,


On Linux 6.6.12 copying several large files (5–80 GB) in parallel, and 
trying to change the number of server threads with `rpc.nfsd nproc` 
afterward, `systemctl restart nfsd` resulted in:

```
[2502367.958818] nfsd: last server has exited, flushing export cache
[2502369.261987] NFSD: Using UMH upcall client tracking operations.
[2502369.268678] NFSD: starting 90-second grace period (net f0000000)

[2502369.285013] ------------[ cut here ]------------
[2502369.291230] kernel BUG at net/sunrpc/svc.c:581!
[2502369.297008] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[2502369.303548] CPU: 9 PID: 4579 Comm: rpc.nfsd Not tainted 
6.6.12.mx64.461 #1
[2502369.311741] Hardware name: Dell Inc. PowerEdge T440/021KCD, BIOS 
2.12.2 07/09/2021
[2502369.320696] RIP: 0010:svc_destroy+0xc9/0xf0 [sunrpc]
[2502369.327474] Code: 00 00 00 be 01 00 00 00 e8 d4 f2 54 e1 41 3b 6d 
74 72 bc 49 8b 7d 7c e8 95 40 1c e1 4c 89 e7 5b 5d 41 5c 41 5d e9 87 40 
1c e1 <0f> 0b 48 8b 47 ec 48 c7 c7 f9 5a 15 a0 48 8b 70 20 e8 c1 87 01 e1
[2502369.349863] RSP: 0018:ffffc9000e26bd60 EFLAGS: 00010206
[2502369.356573] RAX: ffff88886064e130 RBX: ffff88886064e114 RCX: 
0000000000000010
[2502369.365173] RDX: ffff889092d73018 RSI: 0000000000000246 RDI: 
ffff88a03fc1cfc0
[2502369.373879] RBP: 0000000000000040 R08: 000000000000000f R09: 
0000000000000001
[2502369.382474] R10: ffff889092d71000 R11: 0000000000000000 R12: 
ffff88886064e100
[2502369.391115] R13: ffff88886064e114 R14: ffff88886064e100 R15: 
ffff8881061d6000
[2502369.399730] FS:  00007f610ac30740(0000) GS:ffff88a03fd00000(0000) 
knlGS:0000000000000000
[2502369.409410] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[2502369.416667] CR2: 000000000069adf8 CR3: 00000004ba14a002 CR4: 
00000000007706e0
[2502369.425524] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[2502369.434240] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[2502369.442880] PKRU: 55555554
[2502369.447193] Call Trace:
[2502369.451211]  <TASK>
[2502369.454982]  ? die+0x36/0x90
[2502369.459421]  ? do_trap+0xda/0x100
[2502369.464337]  ? svc_destroy+0xc9/0xf0 [sunrpc]
[2502369.470479]  ? do_error_trap+0x65/0x80
[2502369.475857]  ? svc_destroy+0xc9/0xf0 [sunrpc]
[2502369.481924]  ? exc_invalid_op+0x50/0x70
[2502369.487390]  ? svc_destroy+0xc9/0xf0 [sunrpc]
[2502369.493402]  ? asm_exc_invalid_op+0x1a/0x20
[2502369.498494]  ? svc_destroy+0xc9/0xf0 [sunrpc]
[2502369.504826]  nfsd_svc+0x28c/0x3d0 [nfsd]
[2502369.510836]  write_threads+0xe4/0x190 [nfsd]
[2502369.517184]  ? __pfx_write_threads+0x10/0x10 [nfsd]
[2502369.524580]  nfsctl_transaction_write+0x4a/0x80 [nfsd]
[2502369.531495]  vfs_write+0xcf/0x450
[2502369.535578]  ksys_write+0x6f/0xf0
[2502369.540415]  do_syscall_64+0x43/0x90
[2502369.545455]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[2502369.551988] RIP: 0033:0x7f610ad3aa20
[2502369.557030] Code: 40 00 48 8b 15 e1 b3 0d 00 f7 d8 64 89 02 48 c7 
c0 ff ff ff ff eb b7 0f 1f 00 80 3d c1 3b 0e 00 00 74 17 b8 01 00 00 00 
0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
[2502369.578504] RSP: 002b:00007fff4d8deaf8 EFLAGS: 00000202 ORIG_RAX: 
0000000000000001
[2502369.587720] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 
00007f610ad3aa20
[2502369.596419] RDX: 0000000000000003 RSI: 000000000040d540 RDI: 
0000000000000003
[2502369.604613] RBP: 0000000000000003 R08: 0000000000000000 R09: 
00007fff4d8de990
[2502369.613258] R10: 0000000000000000 R11: 0000000000000202 R12: 
0000000000000040
[2502369.621276] R13: 0000000000000001 R14: 000000000040e2a0 R15: 
000000000040910e
[2502369.629927]  </TASK>
[2502369.632849] Modules linked in: rpcsec_gss_krb5 nfsv4 nfs i915 
iosf_mbi drm_buddy drm_display_helper ttm intel_gtt video 8021q garp stp 
mrp llc x86_pkg_temp_thermal coretemp kvm_intel tg3 kvm irqbypass 
crc32c_intel wmi_bmof mgag200 i2c_algo_bit libphy iTCO_wdt i40e 
iTCO_vendor_support wmi ipmi_si nfsd auth_rpcgss oid_registry nfs_acl 
lockd grace sunrpc ip_tables x_tables ipv6 autofs4
[2502369.672534] ---[ end trace 0000000000000000 ]---
[2502369.677557] RIP: 0010:svc_destroy+0xc9/0xf0 [sunrpc]
[2502369.682931] Code: 00 00 00 be 01 00 00 00 e8 d4 f2 54 e1 41 3b 6d 
74 72 bc 49 8b 7d 7c e8 95 40 1c e1 4c 89 e7 5b 5d 41 5c 41 5d e9 87 40 
1c e1 <0f> 0b 48 8b 47 ec 48 c7 c7 f9 5a 15 a0 48 8b 70 20 e8 c1 87 01 e1
[2502369.702288] RSP: 0018:ffffc9000e26bd60 EFLAGS: 00010206
[2502369.707906] RAX: ffff88886064e130 RBX: ffff88886064e114 RCX: 
0000000000000010
[2502369.715430] RDX: ffff889092d73018 RSI: 0000000000000246 RDI: 
ffff88a03fc1cfc0
[2502369.722960] RBP: 0000000000000040 R08: 000000000000000f R09: 
0000000000000001
[2502369.730483] R10: ffff889092d71000 R11: 0000000000000000 R12: 
ffff88886064e100
[2502369.738015] R13: ffff88886064e114 R14: ffff88886064e100 R15: 
ffff8881061d6000
[2502369.745537] FS:  00007f610ac30740(0000) GS:ffff88a03fd00000(0000) 
knlGS:0000000000000000
[2502369.754015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[2502369.760149] CR2: 000000000069adf8 CR3: 00000004ba14a002 CR4: 
00000000007706e0
[2502369.767681] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 
0000000000000000
[2502369.775210] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 
0000000000000400
[2502369.782735] PKRU: 55555554
```

We have not experienced this with either 5.15.112 nor 5.15.160, though 
the later one has not been tested that much yet.

I found similar reports in the list archive [1], but the have a hard 
time following through as the commit hashes differ between the different 
Linux series and no commit message explicitly contains the trace. I 
assume it’s fixed in 6.6.34, but just wanted to report it anyway, so 
it’s documented, and maybe the maintainers can confirm.


Kind regards,

Paul

