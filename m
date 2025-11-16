Return-Path: <linux-nfs+bounces-16428-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 194FBC60E14
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Nov 2025 01:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5FCA136030B
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Nov 2025 00:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F115D191484;
	Sun, 16 Nov 2025 00:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b="IUKNAN/4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-106117.protonmail.ch (mail-106117.protonmail.ch [79.135.106.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBEFD531;
	Sun, 16 Nov 2025 00:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763253550; cv=none; b=Umx+364OnzwJYAhI7Fj3a0f7qGWzJ8jIV8+r1K4FLM+Q6IViRjLjPy0AKfGvpNe255KOIboSDQ9tIwuvWlJIH3FqGkX3rJa94T8mDETgIi0dQ2OUKAqBir4xvuDQ3taRRQQCiNRcW2auL4jFUU6c8dXw9laIUnFEuyUMssNAZl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763253550; c=relaxed/simple;
	bh=SH36YVeUL0VlNuzlGB1Lp2ApO/VvjCZBM7RVQu8JqPQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HruRNU1PJw1QJJM+nu5ks+sFxAfkFxIXd1oVXDttmsGYjVGfgMlk/vySX3FE/qJMsYGKyD96K3TOb9GTK9yMKzmpE+SXaUhAv4QbevMmY116JOfsQJkLZy493V278nDsBSBcyfkeVRz7xa/Ba/o66hlELSGRRvXWkt2SkwoUMhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com; spf=pass smtp.mailfrom=tylerwross.com; dkim=pass (2048-bit key) header.d=tylerwross.com header.i=@tylerwross.com header.b=IUKNAN/4; arc=none smtp.client-ip=79.135.106.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tylerwross.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tylerwross.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tylerwross.com;
	s=protonmail; t=1763253536; x=1763512736;
	bh=ID0/6f9v1gAFj9IjLkMXRYgQerjMnF5Cek3jDTkefus=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IUKNAN/4AWWwp9BvaxamDkQQCpKuDtvDNIbTR++jLmMSUM2w4mgJ9nnjo1P6nbNWJ
	 vPCP8D62fsJM3X5zN+GJojzg1RkxknjAzco3VIJKoo6PS//FsVr32D/xoflqjKVYmQ
	 Od5Cvtqp57GRJu7K/eo39u7yM/Hfdret7m0O2Pc2cHVcUmSPeo3fkFZPvMLn3QbqLO
	 r4cRHue4gKqVS0Th1evNu9pFDisUqkSVA2t/0ZSokbget6XnRw4Ty7xfcDIVOyb7qr
	 xYQl+H6z7sV3f22dl7xf42B5MRqaf1rklXf7wuURhf1yvtEF6eHvVMf5jMQY80hriv
	 y/U0gG0eU4l5Q==
Date: Sun, 16 Nov 2025 00:38:51 +0000
To: Chuck Lever <chuck.lever@oracle.com>
From: "Tyler W. Ross" <TWR@tylerwross.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, "1120598@bugs.debian.org" <1120598@bugs.debian.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Scott Mayhew <smayhew@redhat.com>, Steve Dickson <steved@redhat.com>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5 NFSv4 client using SHA2
Message-ID: <Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com>
In-Reply-To: <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com>
References: <176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net> <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com> <aRZL8kbmfbssOwKF@eldamar.lan> <1cee1c3e-e6b9-485a-a4d4-c336072f14c3@oracle.com> <aRZZoNB5rsC8QUi4@eldamar.lan> <de44bf50-0c87-4062-b974-0b879868c0f5@oracle.com> <AVpI5XolCCA38sGzxlfk6azQI9oUAxafUVl9B7B1WgJEmGgSAQq5nvulQO6P_RQqjBp3adqasHFsodhAAxai0dcp5scRMJk0dLsGMQeSiew=@tylerwross.com> <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com> <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com>
Feedback-ID: 101639484:user:proton
X-Pm-Message-ID: d9838c32606aff77f902115a2631bf442f99aab7
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, November 14th, 2025 at 7:19 AM, Chuck Lever <chuck.lever@oracle.=
com> wrote:
> Then I would say further hunting for the broken commit is going to be
> fruitless. Adding the WARNs in net/sunrpc/xdr.c is a good next step so
> we see which XDR data item (assuming it's the same one every time) is
> failing to decode.

I added WARNs after each trace_rpc_xdr_overflow() call, and then a couple
pr_info() inside xdr_copy_to_scratch() as a follow-up.

If I'm understanding correctly, it's failing in the xdr_copy_to_scratch()
call inside xdr_inline_decode(), because the xdr_stream struct has an
unset/NULL scratch kvec. I don't understand the context enough to
speculate on why, though.

[   26.844102] Entered xdr_copy_to_scratch()
[   26.844105] xdr->scratch.iov_base: 0000000000000000
[   26.844107] xdr->scratch.iov_len: 0
[   26.844127] ------------[ cut here ]------------
[   26.844128] WARNING: CPU: 1 PID: 886 at net/sunrpc/xdr.c:1490 xdr_inline=
_decode.cold+0x65/0x141 [sunrpc]
[   26.844153] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs lo=
ckd grace netfs binfmt_misc intel_rapl_msr intel_rapl_common kvm_amd ccp kv=
m cfg80211 hid_generic usbhid hid irqbypass rfkill ghash_clmulni_intel aesn=
i_intel pcspkr 8021q garp stp virtio_balloon llc mrp button evdev joydev sg=
 auth_rpcgss sunrpc configfs efi_pstore nfnetlink vsock_loopback vmw_vsock_=
virtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci qemu_fw_cfg=
 ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_cryptoapi sr_mod=
 cdrom bochs uhci_hcd drm_client_lib drm_shmem_helper ehci_pci ata_generic =
sd_mod drm_kms_helper ehci_hcd ata_piix libata drm virtio_net usbcore virti=
o_scsi floppy psmouse net_failover failover scsi_mod serio_raw i2c_piix4 us=
b_common scsi_common i2c_smbus
[   26.844217] CPU: 1 UID: 591200003 PID: 886 Comm: ls Not tainted 6.17.8-d=
ebbug1120598hack3 #9 PREEMPT(lazy) =20
[   26.844220] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
[   26.844222] RIP: 0010:xdr_inline_decode.cold+0x65/0x141 [sunrpc]
[   26.844238] Code: 24 48 c7 c7 e7 eb 8c c0 48 8b 71 28 e8 5a 36 fc d7 48 =
8b 0c 24 4c 8b 44 24 10 48 8b 54 24 08 4c 39 41 28 73 0c 0f 1f 44 00 00 <0f=
> 0b e9 b7 fe fe ff 48 89 d8 48 89 cf 4c 89 44 24 08 48 29 d0 48
[   26.844240] RSP: 0018:ffffd09e82ce3758 EFLAGS: 00010293
[   26.844242] RAX: 0000000000000017 RBX: ffff8f1e0adcffe8 RCX: ffffd09e82c=
e3838
[   26.844244] RDX: ffff8f1e0adcffe4 RSI: 0000000000000001 RDI: ffff8f1f37c=
5ce40
[   26.844245] RBP: ffffd09e82ce37b4 R08: 0000000000000008 R09: ffffd09e82c=
e3600
[   26.844246] R10: ffffffff9acdb348 R11: 00000000ffffefff R12: 00000000000=
0001a
[   26.844247] R13: ffff8f1e01151200 R14: 0000000000000000 R15: 00000000004=
40000
[   26.844250] FS:  00007fa5d13db240(0000) GS:ffff8f1f9c44a000(0000) knlGS:=
0000000000000000
[   26.844252] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   26.844253] CR2: 00007fa5d13b9000 CR3: 000000010ab82000 CR4: 00000000007=
50ef0
[   26.844255] PKRU: 55555554
[   26.844257] Call Trace:
[   26.844259]  <TASK>
[   26.844263]  __decode_op_hdr+0x20/0x120 [nfsv4]
[   26.844288]  nfs4_xdr_dec_readdir+0xbb/0x120 [nfsv4]
[   26.844305]  gss_unwrap_resp+0x9e/0x150 [auth_rpcgss]
[   26.844311]  call_decode+0x211/0x230 [sunrpc]
[   26.844332]  ? __pfx_call_decode+0x10/0x10 [sunrpc]
[   26.844348]  __rpc_execute+0xb6/0x480 [sunrpc]
[   26.844369]  ? rpc_new_task+0x17a/0x200 [sunrpc]
[   26.844386]  rpc_execute+0x133/0x160 [sunrpc]
[   26.844401]  rpc_run_task+0x103/0x160 [sunrpc]
[   26.844419]  nfs4_call_sync_sequence+0x74/0xb0 [nfsv4]
[   26.844440]  _nfs4_proc_readdir+0x28d/0x310 [nfsv4]
[   26.844459]  nfs4_proc_readdir+0x60/0xf0 [nfsv4]
[   26.844475]  nfs_readdir_xdr_to_array+0x1fb/0x410 [nfs]
[   26.844494]  nfs_readdir+0x2ed/0xf00 [nfs]
[   26.844506]  iterate_dir+0xaa/0x270
[   26.844517]  ? srso_alias_return_thunk+0x5/0xfbef5
[   26.844521]  __x64_sys_getdents64+0x7b/0x110
[   26.844523]  ? __pfx_filldir64+0x10/0x10
[   26.844526]  do_syscall_64+0x82/0x320
[   26.844530]  ? mod_memcg_lruvec_state+0xe7/0x2e0
[   26.844533]  ? srso_alias_return_thunk+0x5/0xfbef5
[   26.844535]  ? srso_alias_return_thunk+0x5/0xfbef5
[   26.844537]  ? __lruvec_stat_mod_folio+0x85/0xd0
[   26.844539]  ? srso_alias_return_thunk+0x5/0xfbef5
[   26.844541]  ? srso_alias_return_thunk+0x5/0xfbef5
[   26.844550]  ? set_ptes.isra.0+0x36/0x80
[   26.844555]  ? srso_alias_return_thunk+0x5/0xfbef5
[   26.844557]  ? srso_alias_return_thunk+0x5/0xfbef5
[   26.844560]  ? do_anonymous_page+0x101/0x970
[   26.844563]  ? srso_alias_return_thunk+0x5/0xfbef5
[   26.844565]  ? ___pte_offset_map+0x1b/0x160
[   26.844570]  ? srso_alias_return_thunk+0x5/0xfbef5
[   26.844572]  ? __handle_mm_fault+0xac6/0xef0
[   26.844577]  ? srso_alias_return_thunk+0x5/0xfbef5
[   26.844578]  ? count_memcg_events+0xd6/0x220
[   26.844581]  ? srso_alias_return_thunk+0x5/0xfbef5
[   26.844583]  ? handle_mm_fault+0x1d6/0x2d0
[   26.844585]  ? srso_alias_return_thunk+0x5/0xfbef5
[   26.844587]  ? do_user_addr_fault+0x21a/0x690
[   26.844591]  ? srso_alias_return_thunk+0x5/0xfbef5
[   26.844593]  ? srso_alias_return_thunk+0x5/0xfbef5
[   26.844595]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   26.844597] RIP: 0033:0x7fa5d15678a3
[   26.844606] Code: 8b 05 59 a5 10 00 64 c7 00 16 00 00 00 31 c0 eb 9e e8 =
11 03 04 00 90 b8 ff ff ff 7f 48 39 c2 48 0f 47 d0 b8 d9 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 21 a5 10 00 f7 d8
[   26.844607] RSP: 002b:00007fffa272d848 EFLAGS: 00000293 ORIG_RAX: 000000=
00000000d9
[   26.844609] RAX: ffffffffffffffda RBX: 00007fa5d13b9010 RCX: 00007fa5d15=
678a3
[   26.844610] RDX: 0000000000020000 RSI: 00007fa5d13b9040 RDI: 00000000000=
00003
[   26.844611] RBP: 00007fa5d13b9040 R08: 00007fa5d1707400 R09: 00000000000=
00000
[   26.844613] R10: 0000000000000022 R11: 0000000000000293 R12: 00007fa5d13=
b9014
[   26.844614] R13: fffffffffffffea0 R14: 0000000000000000 R15: 0000564585c=
1c200
[   26.844617]  </TASK>
[   26.844618] ---[ end trace 0000000000000000 ]---



TWR

