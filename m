Return-Path: <linux-nfs+bounces-16976-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39833CAAC4D
	for <lists+linux-nfs@lfdr.de>; Sat, 06 Dec 2025 19:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEB7B301EC5C
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Dec 2025 18:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59DB2D0C9A;
	Sat,  6 Dec 2025 18:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eG68zWXo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7258A2D0C83
	for <linux-nfs@vger.kernel.org>; Sat,  6 Dec 2025 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765046207; cv=none; b=HQr0YROgZ6tgPHw8Voq9iATpxIGdoQDi58cXuiK8IxFgEI3iQE5WTSGQPWyviNL9smCpUMGjO+pDAP6C7cUN++VyxvlwRHQP2oa8jpswSIL/dgMvYx1UPO4gGTPWfSwpu06D28GpT1Ee/yk+ASFSzXn6x6DyNVjm2ZTlBUokfOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765046207; c=relaxed/simple;
	bh=lRCodCDpCl+O+76zFf9G6mJPgM0zQ34Ji4rw8JUexSc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kejOeX6gu85ZV3AVkWf8xt21kdMVj2k+n8D1VUJtbl7M/KWnsXpGSSyF2lOlSuRncbTPqNEbzxC6CrwrqEEVwkHR/PYyHt2sE1DxhQEKc3n8sJiXy4Rbmut4fVaH6904N/s4ucrHp+QGAVdIRVrn0qKVgyjPLMdbMY2pyJlMnRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eG68zWXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEC7C4CEF5;
	Sat,  6 Dec 2025 18:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765046206;
	bh=lRCodCDpCl+O+76zFf9G6mJPgM0zQ34Ji4rw8JUexSc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eG68zWXo/pmT5qapZ+o70O3qR6ytWkdYqssqGlOJsH59S6Cu7uO0C/0vi4LSUbVyE
	 1zcvzLIBDyiM25uHoBDhU17ndfqZr5rEVJnzedqb9sZ9XD1rnI/vMRjH9OWyTSTxgX
	 9S6jKf0D4lxeO6gwbmdbVEiKKwngzkXMNrnBa2yVNTw+oFvmx04LBnVUK41aVvg7/y
	 5Bl7fOFrw8YZJZXlJuCtokpeWQwx77KgBSlEBJ2nDKNisKvSmc7n510NejxVD/g7Qu
	 TjSGSDVyueNhCqjJEh8ZIMh9MJZMJPVYzw9AyMmy9PYkYrOxAx4M9WZBMuhCn1s6Iq
	 eCHDwWMo77xDg==
Message-ID: <817d25dbce20c38ed3a2e1bcece089e50c1164d0.camel@kernel.org>
Subject: Re: [PATCH 1/1] nfsd: check that server is running in
 unlock_filesystem
From: Jeff Layton <jlayton@kernel.org>
To: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com, 
	tom@talpey.com
Date: Sun, 07 Dec 2025 03:36:42 +0900
In-Reply-To: <20251205184156.10983-1-okorniev@redhat.com>
References: <20251205184156.10983-1-okorniev@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-12-05 at 13:41 -0500, Olga Kornievskaia wrote:
> If we are trying to unlock the filesystem via an administrative
> interface and nfsd isn't running, it crashes the server.
>=20
> [   59.445578] Modules linked in: nfsd nfs_acl lockd grace nfs_localio ex=
t4 crc16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill =
vfat fat uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_memops =
uvc videobuf2_v4l2 videobuf2_common snd_hda_intel snd_intel_dspcfg snd_hda_=
codec videodev snd_hda_core snd_hwdep mc snd_seq snd_seq_device snd_pcm snd=
_timer snd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_tr=
ansport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs ghash_ce nvme e1=
000e nvme_core nvme_keyring nvme_auth hkdf sr_mod cdrom vmwgfx drm_ttm_help=
er ttm 8021q garp stp llc mrp sunrpc dm_mirror dm_region_hash dm_log iscsi_=
tcp libiscsi_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfn=
etlink
> [   59.451979] CPU: 4 UID: 0 PID: 5193 Comm: bash Kdump: loaded Tainted: =
G    B               6.18.0-rc4+ #74 PREEMPT(voluntary)
> [   59.453311] Tainted: [B]=3DBAD_PAGE
> [   59.453913] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.0=
0V.24006586.BA64.2406042154 06/04/2024
> [   59.454869] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
> [   59.455463] pc : nfsd4_revoke_states+0x1b4/0x898 [nfsd]
> [   59.456069] lr : nfsd4_revoke_states+0x19c/0x898 [nfsd]
> [   59.456701] sp : ffff80008cd67900
> [   59.457115] x29: ffff80008cd679d0 x28: 1fffe00016a53f84 x27: dfff80000=
0000000
> [   59.458006] x26: 04b800ef00000000 x25: 1fffe00016a53f80 x24: ffff0000a=
796ea00
> [   59.458872] x23: ffff0000b89d6000 x22: ffff0000b6c36900 x21: ffff0000b=
6c36580
> [   59.459738] x20: ffff80008cd67990 x19: ffff0000b6c365c0 x18: 000000000=
0000000
> [   59.460602] x17: 0000000000000000 x16: 0000000000000000 x15: 000000000=
0000000
> [   59.461480] x14: 0000000000000000 x13: 0000000000000001 x12: ffff70001=
19acf13
> [   59.462272] x11: 1ffff000119acf12 x10: ffff7000119acf12 x9 : dfff80000=
0000000
> [   59.463002] x8 : ffff80008cd67810 x7 : 0000000000000000 x6 : 0097001de=
0000000
> [   59.463732] x5 : 0000000000000004 x4 : ffff0000b5818000 x3 : 04b800ef0=
0000004
> [   59.464368] x2 : 0000000000000000 x1 : 0000000000000005 x0 : 04b800ef0=
0000000
> [   59.465072] Call trace:
> [   59.465308]  nfsd4_revoke_states+0x1b4/0x898 [nfsd] (P)
> [   59.465830]  write_unlock_fs+0x258/0x440 [nfsd]
> [   59.466278]  nfsctl_transaction_write+0xb0/0x120 [nfsd]
> [   59.466780]  vfs_write+0x1f0/0x938
> [   59.467088]  ksys_write+0xfc/0x1f8
> [   59.467395]  __arm64_sys_write+0x74/0xb8
> [   59.467746]  invoke_syscall.constprop.0+0xdc/0x1e8
> [   59.468177]  do_el0_svc+0x154/0x1d8
> [   59.468489]  el0_svc+0x40/0xe0
> [   59.468767]  el0t_64_sync_handler+0xa0/0xe8
> [   59.469138]  el0t_64_sync+0x1ac/0x1b0
> [   59.469472] Code: 91001343 92400865 d343fc66 110004a1 (38fb68c0)
> [   59.470012] SMP: stopping secondary CPUs
> [   59.472070] Starting crashdump kernel...
> [   59.472537] Bye!
>=20
> Fixes: 1ac3629bf0125 ("nfsd: prepare for supporting admin-revocation of s=
tate")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfs4state.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 35004568d43e..faa874eff1e9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1775,6 +1775,9 @@ void nfsd4_revoke_states(struct net *net, struct su=
per_block *sb)
>  	unsigned int idhashval;
>  	unsigned int sc_types;
> =20
> +	if (!nn->nfsd_serv)
> +		return;
> +
>  	sc_types =3D SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG | SC_TYPE_LAYO=
UT;
> =20
>  	spin_lock(&nn->client_lock);

Ouch. Good catch. I'm surprised we haven't seen this before!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

