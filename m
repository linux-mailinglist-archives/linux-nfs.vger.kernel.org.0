Return-Path: <linux-nfs+bounces-16432-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 109A3C61A81
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Nov 2025 19:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BDAB4E23BB
	for <lists+linux-nfs@lfdr.de>; Sun, 16 Nov 2025 18:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BAA22D9ED;
	Sun, 16 Nov 2025 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFPEeY2f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E59A1E2834;
	Sun, 16 Nov 2025 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763317280; cv=none; b=gGW2FL3qIr87sg7b/TotBqvF7fDUQDJbYU9qtQHneRrmIbArCpSk1uScjSlDjsuNx5h1TVVPGvC75Ppnllc5Iwj5ENPIPFwjGL64KkJX7Xn/R0IxnAgONEUKvS8vUEBofr6hCWjqIFAEW406T92A0Tq91P66Wqnzzs4URQvZMBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763317280; c=relaxed/simple;
	bh=BBwOfGsIR2WYKAgmYVDXOdQZXnX8vF/kpG6vWvQSe60=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c5f1irJDQUg6jgoxtzIeUICL4Z3RHC6se5FwlW7rNk8ZZ4t5KFCTI3jwWTxsu5G/d8iJE03+vkgj2QDsF8f4GUXQ5Vb1yvEHL4ETVTwBYRo6/JJSWI43Ny39HEWfFi/J6Gpn4WHLJJAaP2ZAmi56bwl087M6z5/CD3XaGJdQhII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFPEeY2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F56C19425;
	Sun, 16 Nov 2025 18:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763317279;
	bh=BBwOfGsIR2WYKAgmYVDXOdQZXnX8vF/kpG6vWvQSe60=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dFPEeY2fgAI/hzSCPItFidS5nxCLU3Hrr5/CObweDlNK1eOQ6kMyeI5Da0dwozZ4P
	 kbu8JlAmcNMLpT9BOZQuzNLeR/LB81TzJ4YSldsDSIi2nmpcOxhcEjzi6JZDtC06K7
	 S5RpRy9A+mAtDmTC/h+kn4g20wt7dkU1JSx+CvofCvIbwguvZbenTNVNiGHNUQBylh
	 rC1UI85rD4ctb7pQwD/YSmc2GQBeoewWIlQ+/WmAVm/SnjRvljeFglInlDrK8VkcRE
	 IyH1+W7zldbDSyiKqAFpYsdVt6yZ2Ux+PhIsy8cdikI5cYOtWXAC+85v7BjlfKN7QD
	 K5wIT4MwhRRnQ==
Message-ID: <902ff4995d8e75ad1cd2196bf7d8da42932fba35.camel@kernel.org>
Subject: Re: ls input/output error ("NFS: readdir(/) returns -5") on krb5
 NFSv4 client using SHA2
From: Trond Myklebust <trondmy@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>
Cc: Salvatore Bonaccorso <carnil@debian.org>, "1120598@bugs.debian.org"	
 <1120598@bugs.debian.org>, Jeff Layton <jlayton@kernel.org>, NeilBrown	
 <neil@brown.name>, Scott Mayhew <smayhew@redhat.com>, Steve Dickson	
 <steved@redhat.com>, Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo	
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 linux-nfs@vger.kernel.org, 	linux-kernel@vger.kernel.org, "Tyler W. Ross"
 <TWR@tylerwross.com>
Date: Sun, 16 Nov 2025 13:21:16 -0500
In-Reply-To: <4a63ad3d-b53a-4eab-8ffb-dd206f52c20e@oracle.com>
References: 
	<176298368872.955.14091113173156448257.reportbug@nfsclient-sid.ipa.twrlab.net>
	 <c7136bad-5a00-4224-a25c-0cf7e8252f4a@oracle.com>
	 <aRZL8kbmfbssOwKF@eldamar.lan>
	 <1cee1c3e-e6b9-485a-a4d4-c336072f14c3@oracle.com>
	 <aRZZoNB5rsC8QUi4@eldamar.lan>
	 <de44bf50-0c87-4062-b974-0b879868c0f5@oracle.com>
	 <AVpI5XolCCA38sGzxlfk6azQI9oUAxafUVl9B7B1WgJEmGgSAQq5nvulQO6P_RQqjBp3adqasHFsodhAAxai0dcp5scRMJk0dLsGMQeSiew=@tylerwross.com>
	 <fVv3cF7Ulh3cKUP17C98gh_uOv9BcMlMpsIh1Nv5_0tdw-75PKiPJgIEP5o2jBVry7orwz7jeiGQenfCbuUxyj5JFstbx3RTFYr223qDmV0=@tylerwross.com>
	 <a6d1435b-f507-49eb-b80c-4322dc7e1157@oracle.com>
	 <Y79HV0VGpScPYqI_dDxeItkX2UZwSdReaUOpIeMeZXq2HLsHf5J_PTQqr7HrBYygICRsn-OB89QPrxPzjgv2smuzTThUPy_3fq_N1NprlUg=@tylerwross.com>
	 <4a63ad3d-b53a-4eab-8ffb-dd206f52c20e@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-16 at 11:29 -0500, Chuck Lever wrote:
> On 11/15/25 7:38 PM, Tyler W. Ross wrote:
> > On Friday, November 14th, 2025 at 7:19 AM, Chuck Lever
> > <chuck.lever@oracle.com> wrote:
> > > Then I would say further hunting for the broken commit is going
> > > to be
> > > fruitless. Adding the WARNs in net/sunrpc/xdr.c is a good next
> > > step so
> > > we see which XDR data item (assuming it's the same one every
> > > time) is
> > > failing to decode.
> >=20
> > I added WARNs after each trace_rpc_xdr_overflow() call, and then a
> > couple
> > pr_info() inside xdr_copy_to_scratch() as a follow-up.
> >=20
> > If I'm understanding correctly, it's failing in the
> > xdr_copy_to_scratch()
> > call inside xdr_inline_decode(), because the xdr_stream struct has
> > an
> > unset/NULL scratch kvec. I don't understand the context enough to
> > speculate on why, though.
> >=20
> > [=C2=A0=C2=A0 26.844102] Entered xdr_copy_to_scratch()
> > [=C2=A0=C2=A0 26.844105] xdr->scratch.iov_base: 0000000000000000
> > [=C2=A0=C2=A0 26.844107] xdr->scratch.iov_len: 0
> > [=C2=A0=C2=A0 26.844127] ------------[ cut here ]------------
> > [=C2=A0=C2=A0 26.844128] WARNING: CPU: 1 PID: 886 at net/sunrpc/xdr.c:1=
490
> > xdr_inline_decode.cold+0x65/0x141 [sunrpc]
> > [=C2=A0=C2=A0 26.844153] Modules linked in: rpcsec_gss_krb5 nfsv4
> > dns_resolver nfs lockd grace netfs binfmt_misc intel_rapl_msr
> > intel_rapl_common kvm_amd ccp kvm cfg80211 hid_generic usbhid hid
> > irqbypass rfkill ghash_clmulni_intel aesni_intel pcspkr 8021q garp
> > stp virtio_balloon llc mrp button evdev joydev sg auth_rpcgss
> > sunrpc configfs efi_pstore nfnetlink vsock_loopback
> > vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock
> > vmw_vmci qemu_fw_cfg ip_tables x_tables autofs4 ext4 crc16 mbcache
> > jbd2 crc32c_cryptoapi sr_mod cdrom bochs uhci_hcd drm_client_lib
> > drm_shmem_helper ehci_pci ata_generic sd_mod drm_kms_helper
> > ehci_hcd ata_piix libata drm virtio_net usbcore virtio_scsi floppy
> > psmouse net_failover failover scsi_mod serio_raw i2c_piix4
> > usb_common scsi_common i2c_smbus
> > [=C2=A0=C2=A0 26.844217] CPU: 1 UID: 591200003 PID: 886 Comm: ls Not ta=
inted
> > 6.17.8-debbug1120598hack3 #9 PREEMPT(lazy)=C2=A0=20
> > [=C2=A0=C2=A0 26.844220] Hardware name: QEMU Standard PC (i440FX + PIIX=
,
> > 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > [=C2=A0=C2=A0 26.844222] RIP: 0010:xdr_inline_decode.cold+0x65/0x141 [s=
unrpc]
> > [=C2=A0=C2=A0 26.844238] Code: 24 48 c7 c7 e7 eb 8c c0 48 8b 71 28 e8 5=
a 36
> > fc d7 48 8b 0c 24 4c 8b 44 24 10 48 8b 54 24 08 4c 39 41 28 73 0c
> > 0f 1f 44 00 00 <0f> 0b e9 b7 fe fe ff 48 89 d8 48 89 cf 4c 89 44 24
> > 08 48 29 d0 48
> > [=C2=A0=C2=A0 26.844240] RSP: 0018:ffffd09e82ce3758 EFLAGS: 00010293
> > [=C2=A0=C2=A0 26.844242] RAX: 0000000000000017 RBX: ffff8f1e0adcffe8 RC=
X:
> > ffffd09e82ce3838
> > [=C2=A0=C2=A0 26.844244] RDX: ffff8f1e0adcffe4 RSI: 0000000000000001 RD=
I:
> > ffff8f1f37c5ce40
> > [=C2=A0=C2=A0 26.844245] RBP: ffffd09e82ce37b4 R08: 0000000000000008 R0=
9:
> > ffffd09e82ce3600
> > [=C2=A0=C2=A0 26.844246] R10: ffffffff9acdb348 R11: 00000000ffffefff R1=
2:
> > 000000000000001a
> > [=C2=A0=C2=A0 26.844247] R13: ffff8f1e01151200 R14: 0000000000000000 R1=
5:
> > 0000000000440000
> > [=C2=A0=C2=A0 26.844250] FS:=C2=A0 00007fa5d13db240(0000)
> > GS:ffff8f1f9c44a000(0000) knlGS:0000000000000000
> > [=C2=A0=C2=A0 26.844252] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
> > [=C2=A0=C2=A0 26.844253] CR2: 00007fa5d13b9000 CR3: 000000010ab82000 CR=
4:
> > 0000000000750ef0
> > [=C2=A0=C2=A0 26.844255] PKRU: 55555554
> > [=C2=A0=C2=A0 26.844257] Call Trace:
> > [=C2=A0=C2=A0 26.844259]=C2=A0 <TASK>
> > [=C2=A0=C2=A0 26.844263]=C2=A0 __decode_op_hdr+0x20/0x120 [nfsv4]
> > [=C2=A0=C2=A0 26.844288]=C2=A0 nfs4_xdr_dec_readdir+0xbb/0x120 [nfsv4]
> > [=C2=A0=C2=A0 26.844305]=C2=A0 gss_unwrap_resp+0x9e/0x150 [auth_rpcgss]
> > [=C2=A0=C2=A0 26.844311]=C2=A0 call_decode+0x211/0x230 [sunrpc]
> > [=C2=A0=C2=A0 26.844332]=C2=A0 ? __pfx_call_decode+0x10/0x10 [sunrpc]
> > [=C2=A0=C2=A0 26.844348]=C2=A0 __rpc_execute+0xb6/0x480 [sunrpc]
> > [=C2=A0=C2=A0 26.844369]=C2=A0 ? rpc_new_task+0x17a/0x200 [sunrpc]
> > [=C2=A0=C2=A0 26.844386]=C2=A0 rpc_execute+0x133/0x160 [sunrpc]
> > [=C2=A0=C2=A0 26.844401]=C2=A0 rpc_run_task+0x103/0x160 [sunrpc]
> > [=C2=A0=C2=A0 26.844419]=C2=A0 nfs4_call_sync_sequence+0x74/0xb0 [nfsv4=
]
> > [=C2=A0=C2=A0 26.844440]=C2=A0 _nfs4_proc_readdir+0x28d/0x310 [nfsv4]
> > [=C2=A0=C2=A0 26.844459]=C2=A0 nfs4_proc_readdir+0x60/0xf0 [nfsv4]
> > [=C2=A0=C2=A0 26.844475]=C2=A0 nfs_readdir_xdr_to_array+0x1fb/0x410 [nf=
s]
> > [=C2=A0=C2=A0 26.844494]=C2=A0 nfs_readdir+0x2ed/0xf00 [nfs]
> > [=C2=A0=C2=A0 26.844506]=C2=A0 iterate_dir+0xaa/0x270
>=20
> Hi Trond, Anna -
>=20
> NFSv4 READDIR is hitting an XDR overflow because the XDR stream's
> scratch buffer is missing, and one of the READDIR response's fields
> crosses a page boundary in the receive buffer.
>=20
> Shouldn't the client's readdir XDR decoder have a scratch buffer?

No it shouldn't.

The READDIR XDR decoder doesn't interpret the contents of the readdir
buffer. What it is supposed to do is read the op header and the readdir
verifier, and then to align the remaining data into the pages that were
allocated as buffer using a call to xdr_read_page(). Essentially, it's
the exact same procedure as we follow for a READ call.

So if we're crossing into the pages before we hit the call to
xdr_read_pages() then that means we've allocated too small a header
buffer. Since it only appears to happen with RPCSEC_GSS, then my money
would be on AUTH_GSS not padding the reply buffer sufficiently when
setting the value of auth->au_cslack.

--=20
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trondmy@kernel.org, trond.myklebust@hammerspace.com

