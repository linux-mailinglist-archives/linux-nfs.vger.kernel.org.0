Return-Path: <linux-nfs+bounces-315-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9228040CD
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 22:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36FB1B207E7
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 21:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F4B35F1E;
	Mon,  4 Dec 2023 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="Hb0haoRs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from email.studentenwerk.mhn.de (dresden.studentenwerk.mhn.de [141.84.225.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF377B9
	for <linux-nfs@vger.kernel.org>; Mon,  4 Dec 2023 13:10:28 -0800 (PST)
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4Skbsv1bbDzRhTk;
	Mon,  4 Dec 2023 22:10:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1701724227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cC4fkyNab02Y/ZLElysGs7dSjkDmj1QtV91bSyCirE8=;
	b=Hb0haoRs4L3Xwa1L8YHsymjBtI48OhyqpPZrY4ePgXCEWiYaQnKYdGNViEA9JJNpDtVulG
	Y5TQMrM+9xv1NK1IN7WQQgX8+2JQZ+Wl6u2VL9jB+MRxNqOhhrJBxdr8iXnIkYF+zDNO0f
	4lRTGK+qwCjuxvLYsSS1MkSZ4dd90UYmJr73psH3oSn7vE5w2uXs1Ohcidx0dhe9oQc67f
	8aE2oBF9tr8w1n27CLeNa4am5dtrs9cSEhQdX/U+X9PTKqRDG61DoVX481FbwQy00yPYrc
	+8axevTDlppvJRt0xTph8oh7GE/EjlCPmjG2t0YbzTL2wH/obVY1tnIGb19VoQ==
Received: from roundcube.studentenwerk.mhn.de (roundcube.studentenwerk.mhn.de [10.148.7.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhub.studentenwerk.mhn.de (Postfix) with ESMTPS id 4Skbsv1BYmzHnGf;
	Mon,  4 Dec 2023 22:10:27 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 Dec 2023 22:10:27 +0100
From: Wolfgang Walter <linux-nfs@stwm.de>
To: dai.ngo@oracle.com
Cc: Chuck Lever <chuck.lever@oracle.com>, Linux Nfs
 <linux-nfs@vger.kernel.org>
Subject: Re: kernel v6.6.3: nfsd hangs in nfsd_break_deleg_cb
In-Reply-To: <537b96d3-1d8a-4eaa-b271-e103f73e980d@oracle.com>
References: <e3d43ecdad554fbdcaa7181833834f78@stwm.de>
 <ZW37M7DOavddVpFd@tissot.1015granger.net>
 <537b96d3-1d8a-4eaa-b271-e103f73e980d@oracle.com>
Message-ID: <1d2ee7fb2014d837ba056e66e36c0e10@stwm.de>
X-Sender: linux-nfs@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Am 2023-12-04 20:12, schrieb dai.ngo@oracle.com:
> On 12/4/23 8:15 AM, Chuck Lever wrote:
>> On Mon, Dec 04, 2023 at 04:34:00PM +0100, Wolfgang Walter wrote:
>>> Hello,
>>> 
>>> after upgrading from stable 6.1.63 to stable 6.6.3 our nfs-server 
>>> logged a
>>> WARNING and then more and more clients hanged:
>>> 
>>> 
>>> Dec 04 14:59:25 engel kernel: ------------[ cut here ]------------
>>> Dec 04 14:59:25 engel kernel: WARNING: CPU: 17 PID: 8431 at
>>> fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x174/0x190 [nfsd]
>>> Dec 04 14:59:25 engel kernel: Modules linked in: cts rpcsec_gss_krb5 
>>> msr
>>> 8021q garp stp mrp llc binfmt_misc intel_rapl_msr intel_rapl_common 
>>> sb_edac
>>> x86_pkg_temp_thermal intel_powerclamp coretemp kv>
>>> Dec 04 14:59:25 engel kernel:  enclosure sd_mod usbhid t10_pi hid
>>> crc64_rocksoft crc64 crc_t10dif crct10dif_generic ixgbe ahci 
>>> xfrm_algo
>>> xhci_pci libahci dca mdio_devres mpt3sas ehci_pci crct10dif_p>
>>> Dec 04 14:59:25 engel kernel: CPU: 17 PID: 8431 Comm: nfsd Not 
>>> tainted
>>> 6.6.3-debian64.all+1.2 #1
>>> Dec 04 14:59:25 engel kernel: Hardware name: Supermicro 
>>> X10DRi/X10DRI-T,
>>> BIOS 1.1a 10/16/2015
>>> Dec 04 14:59:25 engel kernel: RIP: 
>>> 0010:nfsd_break_deleg_cb+0x174/0x190
>>> [nfsd]
>>> Dec 04 14:59:25 engel kernel: Code: 02 8c a4 c2 e9 ff fe ff ff 48 89 
>>> df be
>>> 01 00 00 00 e8 70 7c ed c2 48 8d bb 98 00 00 00 e8 b4 0e 01 00 84 c0 
>>> 0f 85
>>> 2e ff ff ff <0f> 0b e9 27 ff ff ff be 02 00 00 0>
>>> Dec 04 14:59:25 engel kernel: RSP: 0018:ffffbd57227c7a98 EFLAGS: 
>>> 00010246
>>> Dec 04 14:59:25 engel kernel: RAX: 0000000000000000 RBX: 
>>> ffff94a77356e200
>>> RCX: 0000000000000000
>>> Dec 04 14:59:25 engel kernel: RDX: ffff94a77356e2c8 RSI: 
>>> ffff94b78cf58000
>>> RDI: 0000000000002000
>>> Dec 04 14:59:25 engel kernel: RBP: ffff94a0392b3a34 R08: 
>>> ffffbd57227c7a80
>>> R09: 0000000000000000
>>> Dec 04 14:59:25 engel kernel: R10: ffff94a05f4a9440 R11: 
>>> 0000000000000000
>>> R12: ffff94b8e3995b00
>>> Dec 04 14:59:25 engel kernel: R13: ffff94a0392b3a20 R14: 
>>> ffff94b8e3995b00
>>> R15: 000000010eb733cd
>>> Dec 04 14:59:25 engel kernel: FS:  0000000000000000(0000)
>>> GS:ffff94b71fcc0000(0000) knlGS:0000000000000000
>>> Dec 04 14:59:25 engel kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
>>> 0000000080050033
>>> Dec 04 14:59:25 engel kernel: CR2: 00007f9ef8554000 CR3: 
>>> 000000295e020003
>>> CR4: 00000000001706e0
>>> Dec 04 14:59:25 engel kernel: Call Trace:
>>> Dec 04 14:59:25 engel kernel:  <TASK>
>>> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 
>>> [nfsd]
>>> Dec 04 14:59:25 engel kernel:  ? __warn+0x81/0x130
>>> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 
>>> [nfsd]
>>> Dec 04 14:59:25 engel kernel:  ? report_bug+0x171/0x1a0
>>> Dec 04 14:59:25 engel kernel:  ? handle_bug+0x3c/0x80
>>> Dec 04 14:59:25 engel kernel:  ? exc_invalid_op+0x17/0x70
>>> Dec 04 14:59:25 engel kernel:  ? asm_exc_invalid_op+0x1a/0x20
>>> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 
>>> [nfsd]
>>> Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x9a/0x190 
>>> [nfsd]
>>> Dec 04 14:59:25 engel kernel:  __break_lease+0x25c/0x720
>>> Dec 04 14:59:25 engel kernel:  __nfsd_open.isra.0+0xa9/0x1a0 [nfsd]
>>> Dec 04 14:59:25 engel kernel:  nfsd_file_do_acquire+0x4ca/0xc50 
>>> [nfsd]
>>> Dec 04 14:59:25 engel kernel:  nfs4_get_vfs_file+0x34c/0x3b0 [nfsd]
>>> Dec 04 14:59:25 engel kernel:  nfsd4_process_open2+0x42c/0x15d0 
>>> [nfsd]
>>> Dec 04 14:59:25 engel kernel:  ? nfsd_permission+0x63/0x100 [nfsd]
>>> Dec 04 14:59:25 engel kernel:  ? fh_verify+0x42e/0x720 [nfsd]
>>> Dec 04 14:59:25 engel kernel:  nfsd4_open+0x64a/0xc40 [nfsd]
>>> Dec 04 14:59:25 engel kernel:  ? nfsd4_encode_operation+0xa7/0x2b0 
>>> [nfsd]
>>> Dec 04 14:59:25 engel kernel:  nfsd4_proc_compound+0x351/0x670 [nfsd]
>>> Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>> Dec 04 14:59:25 engel kernel:  nfsd_dispatch+0x7c/0x1b0 [nfsd]
>>> Dec 04 14:59:25 engel kernel:  svc_process_common+0x431/0x6e0 
>>> [sunrpc]
>>> Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>> Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
>>> Dec 04 14:59:25 engel kernel:  svc_process+0x131/0x180 [sunrpc]
>>> Dec 04 14:59:25 engel kernel:  nfsd+0x84/0xd0 [nfsd]
>>> Dec 04 14:59:25 engel kernel:  kthread+0xe5/0x120
>>> Dec 04 14:59:25 engel kernel:  ? __pfx_kthread+0x10/0x10
>>> Dec 04 14:59:25 engel kernel:  ret_from_fork+0x31/0x50
>>> Dec 04 14:59:25 engel kernel:  ? __pfx_kthread+0x10/0x10
>>> Dec 04 14:59:25 engel kernel:  ret_from_fork_asm+0x1b/0x30
>>> Dec 04 14:59:25 engel kernel:  </TASK>
>>> Dec 04 14:59:25 engel kernel: ---[ end trace 0000000000000000 ]---
>>> 
>>> 
>>> 6.1. did not show such a problem.
>>> 
>>> Both are vanilla stable kernels (self-built).
>> Thank you for your report.
>> 
>> If you are able to bisect your server between v6.1 and v6.6, that
>> would help us narrow down the cause.
>> 
>> Dai, can you have a look at this?
> 
> The warning message indicates the callback work was not queued since
> it was already queued. In this case we'll have taken an extra reference
> to the stid that will never be put (see b95239ca4954a0), we should fix
> this but I don't think this extra reference causing the client to hang.
> 
> It's hard to say what the root cause is without a core dump and/or some
> network trace or a way to reproduce the problem. As Chuck mentioned, 
> it's
> best to bisect the server to help us narrow down the cause.
> 
> Wolfgang, could you provide some additional info such as how often this
> problem happens, under load?, problem reproducible?, number of clients
> involved, type of NFS activities, etc.

I cannot reproduce it on our test server. Our fileserver run the new 
kernel since friday, 2023-12-01. The problem occurred today.

* number of clients: about 300 to 400.
* we use kerberos krb5p
* only nfs4

I only saw it once (today), but we used 6.1 till friday. I downgraded 
the server to 6.1. I think I cannot bisect the problem as I cannot 
reproduce it on the testserver. I think load and a lot of clients are 
needed - which means I there are a lot of our employees are affected.

One symptom was that new clients couldn't connect and more and more 
clients seem to hang.

The server did not crash, you could still login. When rebooting nfsd 
could not be stopped, though.


I overlooked earlier log entries:

Dec  4 11:42:27 engel kernel: [235320.039490] receive_cb_reply: Got 
unrecognized reply: calldir 0x1 xpt_bc_xprt 000000005d610da5 xid 
752a73b9
Dec  4 11:43:23 engel kernel: [235376.870705] receive_cb_reply: Got 
unrecognized reply: calldir 0x1 xpt_bc_xprt 000000005d610da5 xid 
7d2a73b9
Dec  4 13:55:15 engel kernel: [243288.670210] receive_cb_reply: Got 
unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ca358149 xid 
f1cc71b6
Dec  4 13:55:15 engel kernel: [243288.670788] receive_cb_reply: Got 
unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ca358149 xid 
f2cc71b6

Dec  4 13:57:29 engel kernel: [243421.785082] INFO: task nfsd:8491 
blocked for more than 122 seconds.
Dec  4 13:57:29 engel kernel: [243421.785104]       Not tainted 
6.6.3-debian64.all+1.2 #1
Dec  4 13:57:29 engel kernel: [243421.785113] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  4 13:57:29 engel kernel: [243421.785125] task:nfsd            
state:D stack:0     pid:8491  ppid:2      flags:0x00004000
Dec  4 13:57:29 engel kernel: [243421.785130] Call Trace:
Dec  4 13:57:29 engel kernel: [243421.785132]  <TASK>
Dec  4 13:57:29 engel kernel: [243421.785136]  __schedule+0x3b8/0xb00
Dec  4 13:57:29 engel kernel: [243421.785146]  schedule+0x5e/0xd0
Dec  4 13:57:29 engel kernel: [243421.785148]  
schedule_timeout+0x147/0x160
Dec  4 13:57:29 engel kernel: [243421.785155]  ? 
__pfx_sha512_transform_rorx+0x10/0x10 [sha512_ssse3]
Dec  4 13:57:29 engel kernel: [243421.785162]  
wait_for_completion+0x8a/0x160
Dec  4 13:57:29 engel kernel: [243421.785166]  
__flush_workqueue+0x140/0x410
Dec  4 13:57:29 engel kernel: [243421.785174]  
nfsd4_create_session+0x847/0xd30 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.785288]  
nfsd4_proc_compound+0x351/0x670 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.785334]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.785373]  nfsd_dispatch+0x7c/0x1b0 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.785415]  
svc_process_common+0x431/0x6e0 [sunrpc]
Dec  4 13:57:29 engel kernel: [243421.785492]  ? 
__pfx_nfsd_dispatch+0x10/0x10 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.785534]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.785572]  svc_process+0x131/0x180 
[sunrpc]
Dec  4 13:57:29 engel kernel: [243421.785630]  nfsd+0x84/0xd0 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.785672]  kthread+0xe5/0x120
Dec  4 13:57:29 engel kernel: [243421.785675]  ? __pfx_kthread+0x10/0x10
Dec  4 13:57:29 engel kernel: [243421.785677]  ret_from_fork+0x31/0x50
Dec  4 13:57:29 engel kernel: [243421.785682]  ? __pfx_kthread+0x10/0x10
Dec  4 13:57:29 engel kernel: [243421.785683]  
ret_from_fork_asm+0x1b/0x30
Dec  4 13:57:29 engel kernel: [243421.785689]  </TASK>
Dec  4 13:57:29 engel kernel: [243421.785690] INFO: task nfsd:8493 
blocked for more than 122 seconds.
Dec  4 13:57:29 engel kernel: [243421.785699]       Not tainted 
6.6.3-debian64.all+1.2 #1
Dec  4 13:57:29 engel kernel: [243421.785708] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  4 13:57:29 engel kernel: [243421.785718] task:nfsd            
state:D stack:0     pid:8493  ppid:2      flags:0x00004000
Dec  4 13:57:29 engel kernel: [243421.785720] Call Trace:
Dec  4 13:57:29 engel kernel: [243421.785721]  <TASK>
Dec  4 13:57:29 engel kernel: [243421.785722]  __schedule+0x3b8/0xb00
Dec  4 13:57:29 engel kernel: [243421.785726]  schedule+0x5e/0xd0
Dec  4 13:57:29 engel kernel: [243421.785727]  
schedule_timeout+0x147/0x160
Dec  4 13:57:29 engel kernel: [243421.785729]  
wait_for_completion+0x8a/0x160
Dec  4 13:57:29 engel kernel: [243421.785732]  
__flush_workqueue+0x140/0x410
Dec  4 13:57:29 engel kernel: [243421.785735]  
nfsd4_create_session+0x847/0xd30 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.785801]  
nfsd4_proc_compound+0x351/0x670 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.785848]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.785889]  nfsd_dispatch+0x7c/0x1b0 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.785934]  
svc_process_common+0x431/0x6e0 [sunrpc]
Dec  4 13:57:29 engel kernel: [243421.785998]  ? 
__pfx_nfsd_dispatch+0x10/0x10 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.786045]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.786089]  svc_process+0x131/0x180 
[sunrpc]
Dec  4 13:57:29 engel kernel: [243421.786152]  nfsd+0x84/0xd0 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.786198]  kthread+0xe5/0x120
Dec  4 13:57:29 engel kernel: [243421.786200]  ? __pfx_kthread+0x10/0x10
Dec  4 13:57:29 engel kernel: [243421.786202]  ret_from_fork+0x31/0x50
Dec  4 13:57:29 engel kernel: [243421.786217]  ? __pfx_kthread+0x10/0x10
Dec  4 13:57:29 engel kernel: [243421.786219]  
ret_from_fork_asm+0x1b/0x30
Dec  4 13:57:29 engel kernel: [243421.786223]  </TASK>
Dec  4 13:57:29 engel kernel: [243421.786224] INFO: task nfsd:8494 
blocked for more than 122 seconds.
Dec  4 13:57:29 engel kernel: [243421.786234]       Not tainted 
6.6.3-debian64.all+1.2 #1
Dec  4 13:57:29 engel kernel: [243421.786242] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  4 13:57:29 engel kernel: [243421.786252] task:nfsd            
state:D stack:0     pid:8494  ppid:2      flags:0x00004000
Dec  4 13:57:29 engel kernel: [243421.786255] Call Trace:
Dec  4 13:57:29 engel kernel: [243421.786256]  <TASK>
Dec  4 13:57:29 engel kernel: [243421.786268]  __schedule+0x3b8/0xb00
Dec  4 13:57:29 engel kernel: [243421.786271]  schedule+0x5e/0xd0
Dec  4 13:57:29 engel kernel: [243421.786272]  
schedule_timeout+0x147/0x160
Dec  4 13:57:29 engel kernel: [243421.786274]  ? 
__pfx_sha512_transform_rorx+0x10/0x10 [sha512_ssse3]
Dec  4 13:57:29 engel kernel: [243421.786291]  
wait_for_completion+0x8a/0x160
Dec  4 13:57:29 engel kernel: [243421.786294]  
__flush_workqueue+0x140/0x410
Dec  4 13:57:29 engel kernel: [243421.786308]  
nfsd4_create_session+0x847/0xd30 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.786352]  
nfsd4_proc_compound+0x351/0x670 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.786391]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.786427]  nfsd_dispatch+0x7c/0x1b0 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.786463]  
svc_process_common+0x431/0x6e0 [sunrpc]
Dec  4 13:57:29 engel kernel: [243421.786516]  ? 
__pfx_nfsd_dispatch+0x10/0x10 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.786554]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.786589]  svc_process+0x131/0x180 
[sunrpc]
Dec  4 13:57:29 engel kernel: [243421.786641]  nfsd+0x84/0xd0 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.786679]  kthread+0xe5/0x120
Dec  4 13:57:29 engel kernel: [243421.786681]  ? __pfx_kthread+0x10/0x10
Dec  4 13:57:29 engel kernel: [243421.786682]  ret_from_fork+0x31/0x50
Dec  4 13:57:29 engel kernel: [243421.786685]  ? __pfx_kthread+0x10/0x10
Dec  4 13:57:29 engel kernel: [243421.786686]  
ret_from_fork_asm+0x1b/0x30
Dec  4 13:57:29 engel kernel: [243421.786690]  </TASK>
Dec  4 13:57:29 engel kernel: [243421.786690] INFO: task nfsd:8495 
blocked for more than 122 seconds.
Dec  4 13:57:29 engel kernel: [243421.786699]       Not tainted 
6.6.3-debian64.all+1.2 #1
Dec  4 13:57:29 engel kernel: [243421.786707] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  4 13:57:29 engel kernel: [243421.786716] task:nfsd            
state:D stack:0     pid:8495  ppid:2      flags:0x00004000
Dec  4 13:57:29 engel kernel: [243421.786718] Call Trace:
Dec  4 13:57:29 engel kernel: [243421.786719]  <TASK>
Dec  4 13:57:29 engel kernel: [243421.786720]  __schedule+0x3b8/0xb00
Dec  4 13:57:29 engel kernel: [243421.786722]  schedule+0x5e/0xd0
Dec  4 13:57:29 engel kernel: [243421.786724]  
schedule_timeout+0x147/0x160
Dec  4 13:57:29 engel kernel: [243421.786726]  
wait_for_completion+0x8a/0x160
Dec  4 13:57:29 engel kernel: [243421.786728]  
__flush_workqueue+0x140/0x410
Dec  4 13:57:29 engel kernel: [243421.786731]  
nfsd4_create_session+0x847/0xd30 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.786778]  
nfsd4_proc_compound+0x351/0x670 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.786844]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.786893]  nfsd_dispatch+0x7c/0x1b0 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.786931]  
svc_process_common+0x431/0x6e0 [sunrpc]
Dec  4 13:57:29 engel kernel: [243421.786986]  ? 
__pfx_nfsd_dispatch+0x10/0x10 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.787024]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.787060]  svc_process+0x131/0x180 
[sunrpc]
Dec  4 13:57:29 engel kernel: [243421.787125]  nfsd+0x84/0xd0 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.787172]  kthread+0xe5/0x120
Dec  4 13:57:29 engel kernel: [243421.787174]  ? __pfx_kthread+0x10/0x10
Dec  4 13:57:29 engel kernel: [243421.787175]  ret_from_fork+0x31/0x50
Dec  4 13:57:29 engel kernel: [243421.787177]  ? __pfx_kthread+0x10/0x10
Dec  4 13:57:29 engel kernel: [243421.787179]  
ret_from_fork_asm+0x1b/0x30
Dec  4 13:57:29 engel kernel: [243421.787182]  </TASK>
Dec  4 13:57:29 engel kernel: [243421.787183] INFO: task nfsd:8496 
blocked for more than 122 seconds.
Dec  4 13:57:29 engel kernel: [243421.787192]       Not tainted 
6.6.3-debian64.all+1.2 #1
Dec  4 13:57:29 engel kernel: [243421.787199] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  4 13:57:29 engel kernel: [243421.787208] task:nfsd            
state:D stack:0     pid:8496  ppid:2      flags:0x00004000
Dec  4 13:57:29 engel kernel: [243421.787210] Call Trace:
Dec  4 13:57:29 engel kernel: [243421.787211]  <TASK>
Dec  4 13:57:29 engel kernel: [243421.787212]  __schedule+0x3b8/0xb00
Dec  4 13:57:29 engel kernel: [243421.787215]  schedule+0x5e/0xd0
Dec  4 13:57:29 engel kernel: [243421.787216]  
schedule_timeout+0x147/0x160
Dec  4 13:57:29 engel kernel: [243421.787218]  ? 
sched_clock_cpu+0xf/0x190
Dec  4 13:57:29 engel kernel: [243421.787223]  ? 
__smp_call_single_queue+0xad/0x120
Dec  4 13:57:29 engel kernel: [243421.787226]  ? 
ttwu_queue_wakelist+0xef/0x110
Dec  4 13:57:29 engel kernel: [243421.787229]  
wait_for_completion+0x8a/0x160
Dec  4 13:57:29 engel kernel: [243421.787231]  
__flush_workqueue+0x140/0x410
Dec  4 13:57:29 engel kernel: [243421.787233]  ? kick_pool+0x5d/0xc0
Dec  4 13:57:29 engel kernel: [243421.787236]  
nfsd4_destroy_session+0x1c3/0x280 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.787275]  
nfsd4_proc_compound+0x351/0x670 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.787310]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.787342]  nfsd_dispatch+0x7c/0x1b0 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.787374]  
svc_process_common+0x431/0x6e0 [sunrpc]
Dec  4 13:57:29 engel kernel: [243421.787421]  ? 
__pfx_nfsd_dispatch+0x10/0x10 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.787455]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:57:29 engel kernel: [243421.787487]  svc_process+0x131/0x180 
[sunrpc]
Dec  4 13:57:29 engel kernel: [243421.787534]  nfsd+0x84/0xd0 [nfsd]
Dec  4 13:57:29 engel kernel: [243421.787567]  kthread+0xe5/0x120
Dec  4 13:57:29 engel kernel: [243421.787569]  ? __pfx_kthread+0x10/0x10
Dec  4 13:57:29 engel kernel: [243421.787570]  ret_from_fork+0x31/0x50
Dec  4 13:57:29 engel kernel: [243421.787573]  ? __pfx_kthread+0x10/0x10
Dec  4 13:57:29 engel kernel: [243421.787574]  
ret_from_fork_asm+0x1b/0x30
Dec  4 13:57:29 engel kernel: [243421.787577]  </TASK>
Dec  4 13:59:31 engel kernel: [243544.662855] INFO: task nfsd:8488 
blocked for more than 122 seconds.
Dec  4 13:59:31 engel kernel: [243544.662880]       Not tainted 
6.6.3-debian64.all+1.2 #1
Dec  4 13:59:31 engel kernel: [243544.662890] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  4 13:59:31 engel kernel: [243544.662902] task:nfsd            
state:D stack:0     pid:8488  ppid:2      flags:0x00004000
Dec  4 13:59:31 engel kernel: [243544.662907] Call Trace:
Dec  4 13:59:31 engel kernel: [243544.662909]  <TASK>
Dec  4 13:59:31 engel kernel: [243544.662913]  __schedule+0x3b8/0xb00
Dec  4 13:59:31 engel kernel: [243544.662933]  schedule+0x5e/0xd0
Dec  4 13:59:31 engel kernel: [243544.662935]  
schedule_timeout+0x147/0x160
Dec  4 13:59:31 engel kernel: [243544.662939]  ? getboottime64+0x24/0x40
Dec  4 13:59:31 engel kernel: [243544.662943]  
wait_for_completion+0x8a/0x160
Dec  4 13:59:31 engel kernel: [243544.662958]  
__flush_workqueue+0x140/0x410
Dec  4 13:59:31 engel kernel: [243544.662965]  
nfsd4_destroy_session+0x1c3/0x280 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.663069]  
nfsd4_proc_compound+0x351/0x670 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.663126]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.663164]  nfsd_dispatch+0x7c/0x1b0 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.663208]  
svc_process_common+0x431/0x6e0 [sunrpc]
Dec  4 13:59:31 engel kernel: [243544.663273]  ? 
__pfx_nfsd_dispatch+0x10/0x10 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.663325]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.663362]  svc_process+0x131/0x180 
[sunrpc]
Dec  4 13:59:31 engel kernel: [243544.663414]  nfsd+0x84/0xd0 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.663496]  kthread+0xe5/0x120
Dec  4 13:59:31 engel kernel: [243544.663500]  ? __pfx_kthread+0x10/0x10
Dec  4 13:59:31 engel kernel: [243544.663502]  ret_from_fork+0x31/0x50
Dec  4 13:59:31 engel kernel: [243544.663507]  ? __pfx_kthread+0x10/0x10
Dec  4 13:59:31 engel kernel: [243544.663509]  
ret_from_fork_asm+0x1b/0x30
Dec  4 13:59:31 engel kernel: [243544.663516]  </TASK>
Dec  4 13:59:31 engel kernel: [243544.663517] INFO: task nfsd:8491 
blocked for more than 245 seconds.
Dec  4 13:59:31 engel kernel: [243544.663528]       Not tainted 
6.6.3-debian64.all+1.2 #1
Dec  4 13:59:31 engel kernel: [243544.663536] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  4 13:59:31 engel kernel: [243544.663547] task:nfsd            
state:D stack:0     pid:8491  ppid:2      flags:0x00004000
Dec  4 13:59:31 engel kernel: [243544.663549] Call Trace:
Dec  4 13:59:31 engel kernel: [243544.663550]  <TASK>
Dec  4 13:59:31 engel kernel: [243544.663551]  __schedule+0x3b8/0xb00
Dec  4 13:59:31 engel kernel: [243544.663554]  schedule+0x5e/0xd0
Dec  4 13:59:31 engel kernel: [243544.663556]  
schedule_timeout+0x147/0x160
Dec  4 13:59:31 engel kernel: [243544.663560]  ? 
__pfx_sha512_transform_rorx+0x10/0x10 [sha512_ssse3]
Dec  4 13:59:31 engel kernel: [243544.663566]  
wait_for_completion+0x8a/0x160
Dec  4 13:59:31 engel kernel: [243544.663569]  
__flush_workqueue+0x140/0x410
Dec  4 13:59:31 engel kernel: [243544.663573]  
nfsd4_create_session+0x847/0xd30 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.663642]  
nfsd4_proc_compound+0x351/0x670 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.663689]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.663744]  nfsd_dispatch+0x7c/0x1b0 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.663806]  
svc_process_common+0x431/0x6e0 [sunrpc]
Dec  4 13:59:31 engel kernel: [243544.663877]  ? 
__pfx_nfsd_dispatch+0x10/0x10 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.663918]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.663957]  svc_process+0x131/0x180 
[sunrpc]
Dec  4 13:59:31 engel kernel: [243544.664013]  nfsd+0x84/0xd0 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.664053]  kthread+0xe5/0x120
Dec  4 13:59:31 engel kernel: [243544.664055]  ? __pfx_kthread+0x10/0x10
Dec  4 13:59:31 engel kernel: [243544.664057]  ret_from_fork+0x31/0x50
Dec  4 13:59:31 engel kernel: [243544.664060]  ? __pfx_kthread+0x10/0x10
Dec  4 13:59:31 engel kernel: [243544.664061]  
ret_from_fork_asm+0x1b/0x30
Dec  4 13:59:31 engel kernel: [243544.664065]  </TASK>
Dec  4 13:59:31 engel kernel: [243544.664066] INFO: task nfsd:8493 
blocked for more than 245 seconds.
Dec  4 13:59:31 engel kernel: [243544.664078]       Not tainted 
6.6.3-debian64.all+1.2 #1
Dec  4 13:59:31 engel kernel: [243544.664087] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  4 13:59:31 engel kernel: [243544.664098] task:nfsd            
state:D stack:0     pid:8493  ppid:2      flags:0x00004000
Dec  4 13:59:31 engel kernel: [243544.664101] Call Trace:
Dec  4 13:59:31 engel kernel: [243544.664102]  <TASK>
Dec  4 13:59:31 engel kernel: [243544.664103]  __schedule+0x3b8/0xb00
Dec  4 13:59:31 engel kernel: [243544.664106]  schedule+0x5e/0xd0
Dec  4 13:59:31 engel kernel: [243544.664108]  
schedule_timeout+0x147/0x160
Dec  4 13:59:31 engel kernel: [243544.664110]  
wait_for_completion+0x8a/0x160
Dec  4 13:59:31 engel kernel: [243544.664113]  
__flush_workqueue+0x140/0x410
Dec  4 13:59:31 engel kernel: [243544.664117]  
nfsd4_create_session+0x847/0xd30 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.664163]  
nfsd4_proc_compound+0x351/0x670 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.664218]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.664255]  nfsd_dispatch+0x7c/0x1b0 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.664317]  
svc_process_common+0x431/0x6e0 [sunrpc]
Dec  4 13:59:31 engel kernel: [243544.664386]  ? 
__pfx_nfsd_dispatch+0x10/0x10 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.664427]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.664466]  svc_process+0x131/0x180 
[sunrpc]
Dec  4 13:59:31 engel kernel: [243544.664522]  nfsd+0x84/0xd0 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.664562]  kthread+0xe5/0x120
Dec  4 13:59:31 engel kernel: [243544.664564]  ? __pfx_kthread+0x10/0x10
Dec  4 13:59:31 engel kernel: [243544.664566]  ret_from_fork+0x31/0x50
Dec  4 13:59:31 engel kernel: [243544.664568]  ? __pfx_kthread+0x10/0x10
Dec  4 13:59:31 engel kernel: [243544.664570]  
ret_from_fork_asm+0x1b/0x30
Dec  4 13:59:31 engel kernel: [243544.664574]  </TASK>
Dec  4 13:59:31 engel kernel: [243544.664575] INFO: task nfsd:8494 
blocked for more than 245 seconds.
Dec  4 13:59:31 engel kernel: [243544.664585]       Not tainted 
6.6.3-debian64.all+1.2 #1
Dec  4 13:59:31 engel kernel: [243544.664594] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  4 13:59:31 engel kernel: [243544.664605] task:nfsd            
state:D stack:0     pid:8494  ppid:2      flags:0x00004000
Dec  4 13:59:31 engel kernel: [243544.664608] Call Trace:
Dec  4 13:59:31 engel kernel: [243544.664609]  <TASK>
Dec  4 13:59:31 engel kernel: [243544.664615]  __schedule+0x3b8/0xb00
Dec  4 13:59:31 engel kernel: [243544.664619]  schedule+0x5e/0xd0
Dec  4 13:59:31 engel kernel: [243544.664621]  
schedule_timeout+0x147/0x160
Dec  4 13:59:31 engel kernel: [243544.664624]  ? 
__pfx_sha512_transform_rorx+0x10/0x10 [sha512_ssse3]
Dec  4 13:59:31 engel kernel: [243544.664629]  
wait_for_completion+0x8a/0x160
Dec  4 13:59:31 engel kernel: [243544.664632]  
__flush_workqueue+0x140/0x410
Dec  4 13:59:31 engel kernel: [243544.664636]  
nfsd4_create_session+0x847/0xd30 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.664700]  
nfsd4_proc_compound+0x351/0x670 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.664768]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.664813]  nfsd_dispatch+0x7c/0x1b0 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.664854]  
svc_process_common+0x431/0x6e0 [sunrpc]
Dec  4 13:59:31 engel kernel: [243544.664920]  ? 
__pfx_nfsd_dispatch+0x10/0x10 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.664959]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.664996]  svc_process+0x131/0x180 
[sunrpc]
Dec  4 13:59:31 engel kernel: [243544.665082]  nfsd+0x84/0xd0 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.665116]  kthread+0xe5/0x120
Dec  4 13:59:31 engel kernel: [243544.665118]  ? __pfx_kthread+0x10/0x10
Dec  4 13:59:31 engel kernel: [243544.665120]  ret_from_fork+0x31/0x50
Dec  4 13:59:31 engel kernel: [243544.665122]  ? __pfx_kthread+0x10/0x10
Dec  4 13:59:31 engel kernel: [243544.665123]  
ret_from_fork_asm+0x1b/0x30
Dec  4 13:59:31 engel kernel: [243544.665127]  </TASK>
Dec  4 13:59:31 engel kernel: [243544.665127] INFO: task nfsd:8495 
blocked for more than 245 seconds.
Dec  4 13:59:31 engel kernel: [243544.665150]       Not tainted 
6.6.3-debian64.all+1.2 #1
Dec  4 13:59:31 engel kernel: [243544.665158] "echo 0 > 
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Dec  4 13:59:31 engel kernel: [243544.665168] task:nfsd            
state:D stack:0     pid:8495  ppid:2      flags:0x00004000
Dec  4 13:59:31 engel kernel: [243544.665170] Call Trace:
Dec  4 13:59:31 engel kernel: [243544.665183]  <TASK>
Dec  4 13:59:31 engel kernel: [243544.665184]  __schedule+0x3b8/0xb00
Dec  4 13:59:31 engel kernel: [243544.665187]  schedule+0x5e/0xd0
Dec  4 13:59:31 engel kernel: [243544.665189]  
schedule_timeout+0x147/0x160
Dec  4 13:59:31 engel kernel: [243544.665191]  
wait_for_completion+0x8a/0x160
Dec  4 13:59:31 engel kernel: [243544.665193]  
__flush_workqueue+0x140/0x410
Dec  4 13:59:31 engel kernel: [243544.665197]  
nfsd4_create_session+0x847/0xd30 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.665253]  
nfsd4_proc_compound+0x351/0x670 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.665297]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.665335]  nfsd_dispatch+0x7c/0x1b0 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.665374]  
svc_process_common+0x431/0x6e0 [sunrpc]
Dec  4 13:59:31 engel kernel: [243544.665428]  ? 
__pfx_nfsd_dispatch+0x10/0x10 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.665478]  ? __pfx_nfsd+0x10/0x10 
[nfsd]
Dec  4 13:59:31 engel kernel: [243544.665526]  svc_process+0x131/0x180 
[sunrpc]
Dec  4 13:59:31 engel kernel: [243544.665576]  nfsd+0x84/0xd0 [nfsd]
Dec  4 13:59:31 engel kernel: [243544.665629]  kthread+0xe5/0x120
Dec  4 13:59:31 engel kernel: [243544.665631]  ? __pfx_kthread+0x10/0x10
Dec  4 13:59:31 engel kernel: [243544.665633]  ret_from_fork+0x31/0x50
Dec  4 13:59:31 engel kernel: [243544.665636]  ? __pfx_kthread+0x10/0x10
Dec  4 13:59:31 engel kernel: [243544.665637]  
ret_from_fork_asm+0x1b/0x30
Dec  4 13:59:31 engel kernel: [243544.665641]  </TASK>


Regards
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

