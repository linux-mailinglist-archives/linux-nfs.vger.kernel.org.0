Return-Path: <linux-nfs+bounces-16474-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F47C667E1
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 23:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA97B4E1B4E
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 22:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC85C34C9AE;
	Mon, 17 Nov 2025 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjNgOQUX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBEC34888C
	for <linux-nfs@vger.kernel.org>; Mon, 17 Nov 2025 22:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763420061; cv=none; b=nrM2Z7s35MBQtWO4W1xnyXaEMFOc+PpCtdrNGyXljvFKs9dyDQEILXcJqppw47xZHyeouymd1h+RmNIjt4EDMtjP46R/kXHX3zezQNobMWpA7sp608v7mfYV2UwEUwxqVvS2ZR0jS/A0X9IRayVFR8tM4E2ZkzN5xxKxUBlvW0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763420061; c=relaxed/simple;
	bh=3jnNW8n0NTjbUDU7klixZgiAvvhwUdS1fISy+VvIpZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=agbCRqoiFtLXZ2KDN1YHlYg+qyzJVId7ACbPDkH4tLyCt0wDP4NIN4gmYtFMNfHahCK9YOWDkxhcJYzDgx3xY+OTIaGBrSmgJHz1L/kLUKvZc7kRVdyjzVn15wVemUQvYpsyqyGG8x792PZw+ePQogrHH2QexJzbtAiaf1v5XSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjNgOQUX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763420058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UPJIFnSezoO/svVeVSa5tqwSF3bEtIA0JRQ+MhzUvEM=;
	b=TjNgOQUXqXrRZODHQ6IoKg7iKoZYhZ53TETn3KKSe1fPnWuUXePddy4s24gwWc2VwEGpyH
	Z9qTQ870O3VGY6deOG88g71UW1lEyFijlFu4fHvXfuqXJFT8kmdhUz46z7dvGEB5TRH4Ew
	C1JZt+Sx7Iv6VtUGcNve6SSpVcOE7K8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-OgwhEP0mMPe5GzcZiovkDg-1; Mon,
 17 Nov 2025 17:54:15 -0500
X-MC-Unique: OgwhEP0mMPe5GzcZiovkDg-1
X-Mimecast-MFC-AGG-ID: OgwhEP0mMPe5GzcZiovkDg_1763420053
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14C33195608F;
	Mon, 17 Nov 2025 22:54:13 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.81.26])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E77553003761;
	Mon, 17 Nov 2025 22:54:11 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 223C8505600; Mon, 17 Nov 2025 17:54:10 -0500 (EST)
Date: Mon, 17 Nov 2025 17:54:10 -0500
From: Scott Mayhew <smayhew@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>,
	Salvatore Bonaccorso <carnil@debian.org>,
	"1120598@bugs.debian.org" <1120598@bugs.debian.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Steve Dickson <steved@redhat.com>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Tyler W. Ross" <TWR@tylerwross.com>
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
Message-ID: <aRunktdq8sJ7Eecj@aion>
References: <aRZL8kbmfbssOwKF@eldamar.lan>
 <1cee1c3e-e6b9-485a-a4d4-c336072f14c3@oracle.com>
 <aRZZoNB5rsC8QUi4@eldamar.lan>
 <de44bf50-0c87-4062-b974-0b879868c0f5@oracle.com>
 <AVpI5XolCCA38sGzxlfk6azQI9oUAxafUVl9B7B1WgJEmGgSAQq5nvulQO6P_RQqjBp3adqasHFsodhAAxai0dcp5scRMJk0dLsGMQeSiew=@tylerwross.com>
 <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com>
 <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com>
 <Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com>
 <4a63ad3d-b53a-4eab-8ffb-dd206f52c20e@oracle.com>
 <902ff4995d8e75ad1cd2196bf7d8da42932fba35.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <902ff4995d8e75ad1cd2196bf7d8da42932fba35.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, 16 Nov 2025, Trond Myklebust wrote:

> On Sun, 2025-11-16 at 11:29 -0500, Chuck Lever wrote:
> > On 11/15/25 7:38 PM, Tyler W. Ross wrote:
> > > On Friday, November 14th, 2025 at 7:19 AM, Chuck Lever
> > > <chuck.lever@oracle.com> wrote:
> > > > Then I would say further hunting for the broken commit is going
> > > > to be
> > > > fruitless. Adding the WARNs in net/sunrpc/xdr.c is a good next
> > > > step so
> > > > we see which XDR data item (assuming it's the same one every
> > > > time) is
> > > > failing to decode.
> > >=20
> > > I added WARNs after each trace_rpc_xdr_overflow() call, and then a
> > > couple
> > > pr_info() inside xdr_copy_to_scratch() as a follow-up.
> > >=20
> > > If I'm understanding correctly, it's failing in the
> > > xdr_copy_to_scratch()
> > > call inside xdr_inline_decode(), because the xdr_stream struct has
> > > an
> > > unset/NULL scratch kvec. I don't understand the context enough to
> > > speculate on why, though.
> > >=20
> > > [=A0=A0 26.844102] Entered xdr_copy_to_scratch()
> > > [=A0=A0 26.844105] xdr->scratch.iov_base: 0000000000000000
> > > [=A0=A0 26.844107] xdr->scratch.iov_len: 0
> > > [=A0=A0 26.844127] ------------[ cut here ]------------
> > > [=A0=A0 26.844128] WARNING: CPU: 1 PID: 886 at net/sunrpc/xdr.c:1490
> > > xdr_inline_decode.cold+0x65/0x141 [sunrpc]
> > > [=A0=A0 26.844153] Modules linked in: rpcsec_gss_krb5 nfsv4
> > > dns_resolver nfs lockd grace netfs binfmt_misc intel_rapl_msr
> > > intel_rapl_common kvm_amd ccp kvm cfg80211 hid_generic usbhid hid
> > > irqbypass rfkill ghash_clmulni_intel aesni_intel pcspkr 8021q garp
> > > stp virtio_balloon llc mrp button evdev joydev sg auth_rpcgss
> > > sunrpc configfs efi_pstore nfnetlink vsock_loopback
> > > vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock
> > > vmw_vmci qemu_fw_cfg ip_tables x_tables autofs4 ext4 crc16 mbcache
> > > jbd2 crc32c_cryptoapi sr_mod cdrom bochs uhci_hcd drm_client_lib
> > > drm_shmem_helper ehci_pci ata_generic sd_mod drm_kms_helper
> > > ehci_hcd ata_piix libata drm virtio_net usbcore virtio_scsi floppy
> > > psmouse net_failover failover scsi_mod serio_raw i2c_piix4
> > > usb_common scsi_common i2c_smbus
> > > [=A0=A0 26.844217] CPU: 1 UID: 591200003 PID: 886 Comm: ls Not tainted
> > > 6.17.8-debbug1120598hack3 #9 PREEMPT(lazy)=A0=20
> > > [=A0=A0 26.844220] Hardware name: QEMU Standard PC (i440FX + PIIX,
> > > 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > > [=A0=A0 26.844222] RIP: 0010:xdr_inline_decode.cold+0x65/0x141 [sunrp=
c]
> > > [=A0=A0 26.844238] Code: 24 48 c7 c7 e7 eb 8c c0 48 8b 71 28 e8 5a 36
> > > fc d7 48 8b 0c 24 4c 8b 44 24 10 48 8b 54 24 08 4c 39 41 28 73 0c
> > > 0f 1f 44 00 00 <0f> 0b e9 b7 fe fe ff 48 89 d8 48 89 cf 4c 89 44 24
> > > 08 48 29 d0 48
> > > [=A0=A0 26.844240] RSP: 0018:ffffd09e82ce3758 EFLAGS: 00010293
> > > [=A0=A0 26.844242] RAX: 0000000000000017 RBX: ffff8f1e0adcffe8 RCX:
> > > ffffd09e82ce3838
> > > [=A0=A0 26.844244] RDX: ffff8f1e0adcffe4 RSI: 0000000000000001 RDI:
> > > ffff8f1f37c5ce40
> > > [=A0=A0 26.844245] RBP: ffffd09e82ce37b4 R08: 0000000000000008 R09:
> > > ffffd09e82ce3600
> > > [=A0=A0 26.844246] R10: ffffffff9acdb348 R11: 00000000ffffefff R12:
> > > 000000000000001a
> > > [=A0=A0 26.844247] R13: ffff8f1e01151200 R14: 0000000000000000 R15:
> > > 0000000000440000
> > > [=A0=A0 26.844250] FS:=A0 00007fa5d13db240(0000)
> > > GS:ffff8f1f9c44a000(0000) knlGS:0000000000000000
> > > [=A0=A0 26.844252] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [=A0=A0 26.844253] CR2: 00007fa5d13b9000 CR3: 000000010ab82000 CR4:
> > > 0000000000750ef0
> > > [=A0=A0 26.844255] PKRU: 55555554
> > > [=A0=A0 26.844257] Call Trace:
> > > [=A0=A0 26.844259]=A0 <TASK>
> > > [=A0=A0 26.844263]=A0 __decode_op_hdr+0x20/0x120 [nfsv4]
> > > [=A0=A0 26.844288]=A0 nfs4_xdr_dec_readdir+0xbb/0x120 [nfsv4]
> > > [=A0=A0 26.844305]=A0 gss_unwrap_resp+0x9e/0x150 [auth_rpcgss]
> > > [=A0=A0 26.844311]=A0 call_decode+0x211/0x230 [sunrpc]
> > > [=A0=A0 26.844332]=A0 ? __pfx_call_decode+0x10/0x10 [sunrpc]
> > > [=A0=A0 26.844348]=A0 __rpc_execute+0xb6/0x480 [sunrpc]
> > > [=A0=A0 26.844369]=A0 ? rpc_new_task+0x17a/0x200 [sunrpc]
> > > [=A0=A0 26.844386]=A0 rpc_execute+0x133/0x160 [sunrpc]
> > > [=A0=A0 26.844401]=A0 rpc_run_task+0x103/0x160 [sunrpc]
> > > [=A0=A0 26.844419]=A0 nfs4_call_sync_sequence+0x74/0xb0 [nfsv4]
> > > [=A0=A0 26.844440]=A0 _nfs4_proc_readdir+0x28d/0x310 [nfsv4]
> > > [=A0=A0 26.844459]=A0 nfs4_proc_readdir+0x60/0xf0 [nfsv4]
> > > [=A0=A0 26.844475]=A0 nfs_readdir_xdr_to_array+0x1fb/0x410 [nfs]
> > > [=A0=A0 26.844494]=A0 nfs_readdir+0x2ed/0xf00 [nfs]
> > > [=A0=A0 26.844506]=A0 iterate_dir+0xaa/0x270
> >=20
> > Hi Trond, Anna -
> >=20
> > NFSv4 READDIR is hitting an XDR overflow because the XDR stream's
> > scratch buffer is missing, and one of the READDIR response's fields
> > crosses a page boundary in the receive buffer.
> >=20
> > Shouldn't the client's readdir XDR decoder have a scratch buffer?
>=20
> No it shouldn't.
>=20
> The READDIR XDR decoder doesn't interpret the contents of the readdir
> buffer. What it is supposed to do is read the op header and the readdir
> verifier, and then to align the remaining data into the pages that were
> allocated as buffer using a call to xdr_read_page(). Essentially, it's
> the exact same procedure as we follow for a READ call.
>=20
> So if we're crossing into the pages before we hit the call to
> xdr_read_pages() then that means we've allocated too small a header
> buffer. Since it only appears to happen with RPCSEC_GSS, then my money
> would be on AUTH_GSS not padding the reply buffer sufficiently when
> setting the value of auth->au_cslack.

If replies are the problem, why wouldn't we want to focus on
auth->au_rslack and auth->au_ralign?

FWIW I have both Debian Trixie and Sid/Forky VMs, and krb5{,i,p} is
working across the board for me.  Normally I just use a plain MIT KDC,
so I tried IPA and that works fine too.  Looking Tyler's tracepoint
output, these two jump out:

              ls-969   [003] .....   270.326933: rpc_buf_alloc:        task=
:00000008@00000005 callsize=3D3932 recvsize=3D176 status=3D0
                                                                           =
                                          ^^^
              ls-969   [003] .....   270.326936: rpc_xdr_reply_pages:  task=
:00000008@00000005 head=3D[0xffff8895c29fef64,140] page=3D4008(88) tail=3D[=
0xffff8895c29feff0,36] len=3D0
                                                                           =
                                            ^^^

Contrast that with what I see on my own systems:
              ls-13558   [000] ..... 419637.290876: rpc_buf_alloc: task:000=
00008@00000007 callsize=3D3932 recvsize=3D148 status=3D0
                                                                           =
                                      ^^^=20
              ls-13558   [000] ..... 419637.290879: rpc_xdr_reply_pages: ta=
sk:00000008@00000007 head=3D[0000000050ca7092,144] page=3D4008(88) tail=3D[=
000000007b84934f,4] len=3D0
                                                                           =
                                            ^^^
Those values for the receive size and the head iov length are consistent
across all my VMs (not just my Debian ones).

>=20
> --=20
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trondmy@kernel.org, trond.myklebust@hammerspace.com
>=20


