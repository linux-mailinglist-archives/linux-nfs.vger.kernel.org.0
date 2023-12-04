Return-Path: <linux-nfs+bounces-299-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89100803909
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 16:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29515B20B4C
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Dec 2023 15:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EAC2C862;
	Mon,  4 Dec 2023 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="g8s7peQe"
X-Original-To: linux-nfs@vger.kernel.org
X-Greylist: delayed 466 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 07:41:48 PST
Received: from email.studentenwerk.mhn.de (dresden.studentenwerk.mhn.de [141.84.225.229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D878B6
	for <linux-nfs@vger.kernel.org>; Mon,  4 Dec 2023 07:41:48 -0800 (PST)
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4SkSPh48Q8zRhT0
	for <linux-nfs@vger.kernel.org>; Mon,  4 Dec 2023 16:34:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1701704040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0PFg7X5ndOHZDWLvPiwxWVrWFHi8/t/5vhmznD/yuj4=;
	b=g8s7peQeeDivdM4rLFbgQxwH+03Ow1Hrysg6rR9U9xB3bEbImIvG3Er3flBZl+UTkuqI3p
	Bxj4dWMCMs88N8KSxoVm0TeLqapa494oFYGPDvS0J6tyHLAlhLdcpaVz3VEo6F6KCkbo6G
	qYIfVKwPXsewiCc61qcwHSn47y8mPGm/T3DF7iJYZtOxoo293YeHfRZVbN9NSvDVTWl4kf
	+5hkO5elBtzPD+EdqH8GqTiTxSulLPuYK/XLu/riO9BTAl2J8nwoECuViOmDLx8SpezyuA
	wpag3NJ7srVKUYJgmE80Fpmv+d312mns0W73bTurIs1t7RNMYJKaFd5Ya8Citw==
Received: from roundcube.studentenwerk.mhn.de (roundcube.studentenwerk.mhn.de [10.148.7.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhub.studentenwerk.mhn.de (Postfix) with ESMTPS id 4SkSPh43v4zHnGf
	for <linux-nfs@vger.kernel.org>; Mon,  4 Dec 2023 16:34:00 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 04 Dec 2023 16:34:00 +0100
From: Wolfgang Walter <linux-nfs@stwm.de>
To: Linux Nfs <linux-nfs@vger.kernel.org>
Subject: kernel v6.6.3: nfsd hangs in nfsd_break_deleg_cb
Message-ID: <e3d43ecdad554fbdcaa7181833834f78@stwm.de>
X-Sender: linux-nfs@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hello,

after upgrading from stable 6.1.63 to stable 6.6.3 our nfs-server logged 
a WARNING and then more and more clients hanged:


Dec 04 14:59:25 engel kernel: ------------[ cut here ]------------
Dec 04 14:59:25 engel kernel: WARNING: CPU: 17 PID: 8431 at 
fs/nfsd/nfs4state.c:4919 nfsd_break_deleg_cb+0x174/0x190 [nfsd]
Dec 04 14:59:25 engel kernel: Modules linked in: cts rpcsec_gss_krb5 msr 
8021q garp stp mrp llc binfmt_misc intel_rapl_msr intel_rapl_common 
sb_edac x86_pkg_temp_thermal intel_powerclamp coretemp kv>
Dec 04 14:59:25 engel kernel:  enclosure sd_mod usbhid t10_pi hid 
crc64_rocksoft crc64 crc_t10dif crct10dif_generic ixgbe ahci xfrm_algo 
xhci_pci libahci dca mdio_devres mpt3sas ehci_pci crct10dif_p>
Dec 04 14:59:25 engel kernel: CPU: 17 PID: 8431 Comm: nfsd Not tainted 
6.6.3-debian64.all+1.2 #1
Dec 04 14:59:25 engel kernel: Hardware name: Supermicro X10DRi/X10DRI-T, 
BIOS 1.1a 10/16/2015
Dec 04 14:59:25 engel kernel: RIP: 0010:nfsd_break_deleg_cb+0x174/0x190 
[nfsd]
Dec 04 14:59:25 engel kernel: Code: 02 8c a4 c2 e9 ff fe ff ff 48 89 df 
be 01 00 00 00 e8 70 7c ed c2 48 8d bb 98 00 00 00 e8 b4 0e 01 00 84 c0 
0f 85 2e ff ff ff <0f> 0b e9 27 ff ff ff be 02 00 00 0>
Dec 04 14:59:25 engel kernel: RSP: 0018:ffffbd57227c7a98 EFLAGS: 
00010246
Dec 04 14:59:25 engel kernel: RAX: 0000000000000000 RBX: 
ffff94a77356e200 RCX: 0000000000000000
Dec 04 14:59:25 engel kernel: RDX: ffff94a77356e2c8 RSI: 
ffff94b78cf58000 RDI: 0000000000002000
Dec 04 14:59:25 engel kernel: RBP: ffff94a0392b3a34 R08: 
ffffbd57227c7a80 R09: 0000000000000000
Dec 04 14:59:25 engel kernel: R10: ffff94a05f4a9440 R11: 
0000000000000000 R12: ffff94b8e3995b00
Dec 04 14:59:25 engel kernel: R13: ffff94a0392b3a20 R14: 
ffff94b8e3995b00 R15: 000000010eb733cd
Dec 04 14:59:25 engel kernel: FS:  0000000000000000(0000) 
GS:ffff94b71fcc0000(0000) knlGS:0000000000000000
Dec 04 14:59:25 engel kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 
0000000080050033
Dec 04 14:59:25 engel kernel: CR2: 00007f9ef8554000 CR3: 
000000295e020003 CR4: 00000000001706e0
Dec 04 14:59:25 engel kernel: Call Trace:
Dec 04 14:59:25 engel kernel:  <TASK>
Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 [nfsd]
Dec 04 14:59:25 engel kernel:  ? __warn+0x81/0x130
Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 [nfsd]
Dec 04 14:59:25 engel kernel:  ? report_bug+0x171/0x1a0
Dec 04 14:59:25 engel kernel:  ? handle_bug+0x3c/0x80
Dec 04 14:59:25 engel kernel:  ? exc_invalid_op+0x17/0x70
Dec 04 14:59:25 engel kernel:  ? asm_exc_invalid_op+0x1a/0x20
Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x174/0x190 [nfsd]
Dec 04 14:59:25 engel kernel:  ? nfsd_break_deleg_cb+0x9a/0x190 [nfsd]
Dec 04 14:59:25 engel kernel:  __break_lease+0x25c/0x720
Dec 04 14:59:25 engel kernel:  __nfsd_open.isra.0+0xa9/0x1a0 [nfsd]
Dec 04 14:59:25 engel kernel:  nfsd_file_do_acquire+0x4ca/0xc50 [nfsd]
Dec 04 14:59:25 engel kernel:  nfs4_get_vfs_file+0x34c/0x3b0 [nfsd]
Dec 04 14:59:25 engel kernel:  nfsd4_process_open2+0x42c/0x15d0 [nfsd]
Dec 04 14:59:25 engel kernel:  ? nfsd_permission+0x63/0x100 [nfsd]
Dec 04 14:59:25 engel kernel:  ? fh_verify+0x42e/0x720 [nfsd]
Dec 04 14:59:25 engel kernel:  nfsd4_open+0x64a/0xc40 [nfsd]
Dec 04 14:59:25 engel kernel:  ? nfsd4_encode_operation+0xa7/0x2b0 
[nfsd]
Dec 04 14:59:25 engel kernel:  nfsd4_proc_compound+0x351/0x670 [nfsd]
Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
Dec 04 14:59:25 engel kernel:  nfsd_dispatch+0x7c/0x1b0 [nfsd]
Dec 04 14:59:25 engel kernel:  svc_process_common+0x431/0x6e0 [sunrpc]
Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
Dec 04 14:59:25 engel kernel:  ? __pfx_nfsd+0x10/0x10 [nfsd]
Dec 04 14:59:25 engel kernel:  svc_process+0x131/0x180 [sunrpc]
Dec 04 14:59:25 engel kernel:  nfsd+0x84/0xd0 [nfsd]
Dec 04 14:59:25 engel kernel:  kthread+0xe5/0x120
Dec 04 14:59:25 engel kernel:  ? __pfx_kthread+0x10/0x10
Dec 04 14:59:25 engel kernel:  ret_from_fork+0x31/0x50
Dec 04 14:59:25 engel kernel:  ? __pfx_kthread+0x10/0x10
Dec 04 14:59:25 engel kernel:  ret_from_fork_asm+0x1b/0x30
Dec 04 14:59:25 engel kernel:  </TASK>
Dec 04 14:59:25 engel kernel: ---[ end trace 0000000000000000 ]---


6.1. did not show such a problem.

Both are vanilla stable kernels (self-built).

Regards,
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

