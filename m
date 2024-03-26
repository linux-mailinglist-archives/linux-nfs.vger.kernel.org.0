Return-Path: <linux-nfs+bounces-2476-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 965E788C63F
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 16:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520592E6773
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB3913C801;
	Tue, 26 Mar 2024 15:04:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39713C3F4
	for <linux-nfs@vger.kernel.org>; Tue, 26 Mar 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465482; cv=none; b=B7sonwwMvASFE/psymqbwdTSAjVmXzedLCrTW/CNBkkFLtefdmWn7UOFn2D7QDGTvJo849Mpblhk38EgCPH+AQS2PjET5l7qxVg3m28m3mcaaBGCgRt2CoyzTsMqbh8jiZFRgeKjGjPkgPHi9Y2YjVRV+3MzkfsUbm++VN556kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465482; c=relaxed/simple;
	bh=vEoCckO5wKJ935oaYtVf5N8rfMfUwdCuXOXGYCnffvU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=dJPFj1KAyxwS/d+1SFhgadYYeOpAPVTls1x8pEe2VwdrDnswp1/LqD/MKUnyd4xktlNmJU0oZtjtwQEYiUGvTP5N7tOByaxIvWlWGypFlVBbyg2nzB5ztUeYMt6sKDzJR5GDsv9LtrKV/APC9Eh9zUNuszpZQCRvoMk2Nw2gLVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.31.7] (theinternet.molgen.mpg.de [141.14.31.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: buczek)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7ABBD61E5FE01;
	Tue, 26 Mar 2024 16:04:28 +0100 (CET)
Message-ID: <5b63ad24-1967-4e0c-b52b-f3a853b613ff@molgen.mpg.de>
Date: Tue, 26 Mar 2024 16:04:27 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-nfs@vger.kernel.org, it+linux@molgen.mpg.de
From: Donald Buczek <buczek@molgen.mpg.de>
Subject: WARN_ONCE from nfsd_break_one_deleg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

we just got this on a nfs file server on 6.6.12 :

[2719554.674554] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000432042d3 xid c369f54d
[2719555.391416] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000017cc0507 xid d6018727
[2719555.742118] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000008f2509ff xid 83d0248e
[2719555.742566] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000637a135a xid 7064546d
[2719555.742803] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000044ea3c51 xid a184bbe5
[2719555.742836] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000b6992e65 xid ed3fe82e
[2719555.785358] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000044ea3c51 xid a384bbe5
[2719588.733414] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000008f2509ff xid 89d0248e
[2719592.067221] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000b6992e65 xid f33fe82e
[2719807.431344] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000fd87f88f xid 28b51379
[2719838.510792] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000432042d3 xid fa69f54d
[2719852.493779] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000ac1e99fe xid a16378bb
[2719852.494853] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000017cc0507 xid 0f028727
[2719852.515457] receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000017cc0507 xid 10028727
[2719917.753429] ------------[ cut here ]------------
[2719917.758951] WARNING: CPU: 1 PID: 1448 at fs/nfsd/nfs4state.c:4939 nfsd_break_deleg_cb+0x115/0x190 [nfsd]
[2719917.769208] Modules linked in: af_packet xt_nat xt_tcpudp iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rpcsec_gss_krb5 nfsv4 nfs i915 iosf_mbi drm_buddy drm_display_helper ttm intel_gtt video 8021q garp stp mrp llc input_leds x86_pkg_temp_thermal led_class hid_generic usbhid coretemp kvm_intel kvm irqbypass tg3 libphy smartpqi mgag200 i2c_algo_bit efi_pstore iTCO_wdt i40e crc32c_intel wmi_bmof pstore iTCO_vendor_support wmi ipmi_si nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc efivarfs ip_tables x_tables ipv6 autofs4
[2719917.818740] CPU: 1 PID: 1448 Comm: nfsd Not tainted 6.6.12.mx64.461 #1
[2719917.825777] Hardware name: Dell Inc. PowerEdge T440/021KCD, BIOS 2.12.2 07/09/2021
[2719917.833781] RIP: 0010:nfsd_break_deleg_cb+0x115/0x190 [nfsd]
[2719917.839911] Code: 00 00 00 e8 3d ae e8 e0 e9 5f ff ff ff 48 89 df be 01 00 00 00 e8 8b 1f 3d e1 48 8d bb 98 00 00 00 e8 ef 10 01 00 84 c0 75 8a <0f> 0b eb 86 65 8b 05 0c 66 e0 5f 89 c0 48 0f a3 05 d6 1a 75 e2 0f
[2719917.859303] RSP: 0018:ffffc9000bae7b70 EFLAGS: 00010246
[2719917.864962] RAX: 0000000000000000 RBX: ffff8881e2fd6000 RCX: 0000000000000024
[2719917.872520] RDX: ffff8881e2fd60c8 RSI: ffff889086d5de00 RDI: 0000000000000200
[2719917.880050] RBP: ffff889301aa812c R08: 0000000000033580 R09: 0000000000000000
[2719917.887575] R10: ffff889ef63b20d8 R11: 0000000000000000 R12: ffff888104cfb290
[2719917.895095] R13: ffff889301aa8118 R14: ffff88989c8ace00 R15: ffff888104cfb290
[2719917.902625] FS:  0000000000000000(0000) GS:ffff88a03fc00000(0000) knlGS:0000000000000000
[2719917.911094] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[2719917.917236] CR2: 00007fb8a1cfc418 CR3: 000000000262c006 CR4: 00000000007706e0
[2719917.924760] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[2719917.932285] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[2719917.939833] PKRU: 55555554
[2719917.942971] Call Trace:
[2719917.945834]  <TASK>
[2719917.948344]  ? __warn+0x81/0x140
[2719917.951983]  ? nfsd_break_deleg_cb+0x115/0x190 [nfsd]
[2719917.957470]  ? report_bug+0x171/0x1a0
[2719917.961562]  ? handle_bug+0x3c/0x70
[2719917.965459]  ? exc_invalid_op+0x17/0x70
[2719917.969715]  ? asm_exc_invalid_op+0x1a/0x20
[2719917.974317]  ? nfsd_break_deleg_cb+0x115/0x190 [nfsd]
[2719917.979820]  __break_lease+0x24b/0x7c0
[2719917.983991]  ? __pfx_nfsd_acceptable+0x10/0x10 [nfsd]
[2719917.989495]  nfs4_get_vfs_file+0x195/0x380 [nfsd]
[2719917.994740]  ? prepare_creds+0x14c/0x240
[2719917.999164]  nfsd4_process_open2+0x3ed/0x16b0 [nfsd]
[2719918.004570]  ? nfsd_permission+0x4e/0x100 [nfsd]
[2719918.009618]  ? fh_verify+0x17b/0x8a0 [nfsd]
[2719918.014243]  nfsd4_open+0x6ae/0xcd0 [nfsd]
[2719918.018777]  ? nfsd4_encode_operation+0xa6/0x290 [nfsd]
[2719918.024524]  nfsd4_proc_compound+0x2f2/0x6a0 [nfsd]
[2719918.029922]  nfsd_dispatch+0xee/0x220 [nfsd]
[2719918.034619]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[2719918.039144]  svc_process_common+0x307/0x730 [sunrpc]
[2719918.044551]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
[2719918.049883]  ? __pfx_nfsd+0x10/0x10 [nfsd]
[2719918.054404]  svc_process+0x131/0x180 [sunrpc]
[2719918.059171]  nfsd+0x84/0xd0 [nfsd]
[2719918.063012]  kthread+0xe5/0x120
[2719918.066539]  ? __pfx_kthread+0x10/0x10
[2719918.070664]  ret_from_fork+0x31/0x50
[2719918.074611]  ? __pfx_kthread+0x10/0x10
[2719918.078735]  ret_from_fork_asm+0x1b/0x30
[2719918.083018]  </TASK>
[2719918.085563] ---[ end trace 0000000000000000 ]---

nfsd_break_deleg_cb+0x115 is the `WARN_ON_ONCE(!nfsd4_run_cb(&dp->dl_recall))` in nfsd_break_one_deleg() in our compilation

I think that means, that the callback is already scheduled?

One nfs client hung trying to mount something from that server.

Best

  Donald

-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433

