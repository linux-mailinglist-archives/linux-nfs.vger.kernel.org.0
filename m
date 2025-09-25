Return-Path: <linux-nfs+bounces-14726-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98420BA1898
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 23:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4967ABC05
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Sep 2025 21:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7D62E7F3F;
	Thu, 25 Sep 2025 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtOtQt6s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84382E62A6
	for <linux-nfs@vger.kernel.org>; Thu, 25 Sep 2025 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835864; cv=none; b=hy7Ci1enJHaiEOtj9kRHPdWrTGS+BXBkRgpK1JM/fqfTjP4L9Y26dBtzgiTdN5fHH2mQc5E8BQNbNcD8ntpLSbZ5ytj5TkU66N0HnTOivUyIRVkAdUEBCJYJ/imbYowTdRrYpFbNqPUsSlqnfPGqnpM8vBCa27Q5TRu2jzW9ZSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835864; c=relaxed/simple;
	bh=crzBGNgoMv2bHdID2eNRMiF0xLJzPpWkeYDAgs+NDd8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kXMFy05GRwN/+HArS5tRLmEmpzT0cbso/+0zrrDGX+X8bT/9TOcIihcYHfyn3Ul8PRlrDB/yzJ2Ziiw8AVDQdvwnW1QBQbhJOeQqYOyI3GmCB/RF99kf3+5kDhRzlFeo5O/uboVghoTTx8sdf+WZQhGlGrTi6tLmkY1omZ4vbpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtOtQt6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D52C4CEF0;
	Thu, 25 Sep 2025 21:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758835864;
	bh=crzBGNgoMv2bHdID2eNRMiF0xLJzPpWkeYDAgs+NDd8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=FtOtQt6sWm29DrMATREiQOT5RtLVg85B29k1+pcheVITnTZofo2c4sitQmdyn1GaO
	 cZf1DMH+8lKGXLshx1Yplhppj8dQo7aWWSr7qJOnMrs2mqmwMG0ICOv4KICnfaJTbW
	 vNy4tUmOEGIyeT91YX2K4ks+myVYBh6oliN+vWuCFaa+jiiIcYSZ5uU3LIeFI5PwpQ
	 rli1ZrySSLjDQE9WBNen56vMovPnRWffctzIa3nnPWYlfjmglGj1O3djMzNdmL7ppt
	 3zvx9vfWZl/f0RJMIJ3VKw32MKFm43Dl52Rp1RqihPJtPnIch6deaNKfLhmL4bP1z8
	 MFxwAGy8QegUQ==
Message-ID: <b87a9432fb9dedbd96e58753c43fb047b9046720.camel@kernel.org>
Subject: Re: [PATCH v3 00/38] vfs, nfsd: implement directory delegations
From: Jeff Layton <jlayton@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>, Anna Schumaker
 <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Date: Thu, 25 Sep 2025 17:31:03 -0400
In-Reply-To: <e5d134e7cc21bc5cdb2e33ec9ad72f3d21ff6841.camel@kernel.org>
References: <20250924-dir-deleg-v3-0-9f3af8bc5c40@kernel.org>
		 <414c0a7b-e767-4061-acd6-bfe8dbff39a1@oracle.com>
	 <e5d134e7cc21bc5cdb2e33ec9ad72f3d21ff6841.camel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-25 at 17:02 -0400, Jeff Layton wrote:
> On Thu, 2025-09-25 at 16:45 -0400, Anna Schumaker wrote:
> > Hi Jeff,
> >=20
> > (I trimmed off most of the extra people CC-ed, since this appears to mo=
stly be an
> > NFS issue)
> >=20
> > I hit this crash while stepping through my client side code and fixing =
it up against
> > your latest branch. I'm at a point where the client only requests the d=
elegation, but
> > without any requested notifications, if that helps:
> >=20
> >=20
> > [  643.888646] BUG: kernel NULL pointer dereference, address: 000000000=
0000168
> > [  643.889045] #PF: supervisor read access in kernel mode
> > [  643.889314] #PF: error_code(0x0000) - not-present page
> > [  643.889591] PGD 0 P4D 0=20
> > [  643.889733] Oops: Oops: 0000 [#1] SMP NOPTI
> > [  643.889960] CPU: 3 UID: 0 PID: 1003 Comm: nfsd Not tainted 6.17.0-rc=
7-00095-gf6fa32f97c33 #47188 PREEMPT(full)  b859994234adae648e07409684697d1=
3c51d22ee
> > [  643.890665] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 unknown 02/02/2022
> > [  643.891076] RIP: 0010:nfsd_handle_dir_event+0x49/0x2c0 [nfsd]
> > [  643.891490] Code: 24 04 83 f9 01 74 11 83 f9 04 74 19 83 f9 02 75 11=
 4d 8b 64 24 08 eb 0d 49 8b 04 24 4c 8b 60 08 eb 03 45 31 e4 0f 1f 44 00 00=
 <4c> 8b b6 68 01 00 00 4d 85 f6 0f 84 dc 01 00 00 49 8d 5e 28 49 8b
> > [  643.892432] RSP: 0018:ffffd0d202333a80 EFLAGS: 00010246
> > [  643.892711] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000=
000000004
> > [  643.893076] RDX: ffff8e3b55ad4480 RSI: 0000000000000000 RDI: 0000000=
040000004
> > [  643.893441] RBP: 0000000040000004 R08: 0000000000000000 R09: 0000000=
000000000
> > [  643.893816] R10: fffffffffffffffb R11: ffffffffc0a80500 R12: ffff8e3=
b55ad4480
> > [  643.894183] R13: 0000000000000000 R14: 0000000000000004 R15: 0000000=
000000004
> > [  643.894554] FS:  0000000000000000(0000) GS:ffff8e3f10206000(0000) kn=
lGS:0000000000000000
> > [  643.894961] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  643.895258] CR2: 0000000000000168 CR3: 0000000112571002 CR4: 0000000=
000772ef0
> > [  643.895644] PKRU: 55555554
> > [  643.895792] Call Trace:
> > [  643.895931]  <TASK>
> > [  643.896050]  fsnotify+0x69a/0x9a0
> > [  643.896233]  fsnotify_change+0xad/0xc0
> > [  643.896431]  notify_change+0x34f/0x380
> > [  643.896633]  nfsd_setattr+0x314/0x6f0 [nfsd 0b3fc8b3981bb65e36d518f9=
edccb6d9f216a09a]
> > [  643.897073]  ? nfsd_setuser_and_check_port+0xdd/0x120 [nfsd 0b3fc8b3=
981bb65e36d518f9edccb6d9f216a09a]
> > [  643.897576]  nfsd4_setattr+0x254/0x370 [nfsd 0b3fc8b3981bb65e36d518f=
9edccb6d9f216a09a]
> > [  643.898014]  ? nfsd4_encode_operation+0x207/0x2b0 [nfsd 0b3fc8b3981b=
b65e36d518f9edccb6d9f216a09a]
> > [  643.898502]  nfsd4_proc_compound+0x337/0x600 [nfsd 0b3fc8b3981bb65e3=
6d518f9edccb6d9f216a09a]
> > [  643.898964]  nfsd_dispatch+0xc1/0x210 [nfsd 0b3fc8b3981bb65e36d518f9=
edccb6d9f216a09a]
> > [  643.899390]  svc_process_common+0x567/0x6a0 [sunrpc c8ffd8e151f2f4e7=
c45ca22edc099dc57603df52]
> > [  643.899881]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd 0b3fc8b3981bb65e3=
6d518f9edccb6d9f216a09a]
> > [  643.900341]  svc_process+0x117/0x200 [sunrpc c8ffd8e151f2f4e7c45ca22=
edc099dc57603df52]
> > [  643.900790]  svc_recv+0xa7d/0xbc0 [sunrpc c8ffd8e151f2f4e7c45ca22edc=
099dc57603df52]
> > [  643.901208]  nfsd+0xb6/0xf0 [nfsd 0b3fc8b3981bb65e36d518f9edccb6d9f2=
16a09a]
> > [  643.901598]  ? __pfx_nfsd+0x10/0x10 [nfsd 0b3fc8b3981bb65e36d518f9ed=
ccb6d9f216a09a]
> > [  643.902024]  kthread+0x215/0x250
> > [  643.902201]  ? __pfx_kthread+0x10/0x10
> > [  643.902394]  ret_from_fork+0x106/0x1d0
> > [  643.902606]  ? __pfx_kthread+0x10/0x10
> > [  643.902800]  ret_from_fork_asm+0x1a/0x30
> > [  643.903013]  </TASK>
> > [  643.903133] Modules linked in: rpcsec_gss_krb5 rpcrdma rdma_cm ib_cm=
 iw_cm ib_core cfg80211 rfkill 8021q mrp garp stp llc ext4 mbcache crc16 jb=
d2 vfat fat intel_rapl_msr intel_rapl_common intel_uncore_frequency_common =
intel_pmc_core intel_pmc_ssram_telemetry pmt_telemetry snd_hda_codec_generi=
c pmt_discovery pmt_class intel_vsec snd_hda_intel snd_intel_dspcfg kvm_int=
el snd_hda_codec snd_hwdep kvm snd_hda_core irqbypass snd_pcm polyval_clmul=
ni iTCO_wdt ghash_clmulni_intel intel_pmc_bxt iTCO_vendor_support aesni_int=
el snd_timer psmouse rapl i2c_i801 pcspkr snd lpc_ich i2c_smbus soundcore j=
oydev mousedev mac_hid btrfs raid6_pq xor nfsd nfs_acl lockd grace nfs_loca=
lio auth_rpcgss usbip_host usbip_core dm_mod loop sunrpc nfnetlink vsock_lo=
opback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vmw=
_vmci qemu_fw_cfg xfs serio_raw virtio_gpu virtio_dma_buf virtio_rng virtio=
_scsi virtio_balloon virtio_net intel_agp net_failover failover intel_gtt
> > [  643.909087] CR2: 0000000000000168
> > [  643.909503] ---[ end trace 0000000000000000 ]---
> >=20
> >=20
> > Any guesses for what could be causing this?
> > Anna
> >=20
>=20
> Yes. It happened in a SETATTR and I forgot to handle that case in
> nfsd_handle_dir_event(). Will fix.
>=20
> I suspect that we probably just want to just recall the delegation in
> this case. Another option would be to send a DIR_ATTRS update to the
> client, but it's possible that the dir_delegation isn't set up to send
> the attrs that changed, and trying to sort that out sounds like a mess.

Actually, the delegation should have been recalled. We just want to
ignore the update in this case. The latest patches in my dir-deleg
branch should have a fix.

Thanks for helping test!
--=20
Jeff Layton <jlayton@kernel.org>

