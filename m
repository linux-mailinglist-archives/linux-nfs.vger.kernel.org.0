Return-Path: <linux-nfs+bounces-17065-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31051CB9FA9
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 23:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D9B6302048E
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 22:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD70C2D9496;
	Fri, 12 Dec 2025 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="IhRbUAUA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rv8xtjBm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2383B2D94AA
	for <linux-nfs@vger.kernel.org>; Fri, 12 Dec 2025 22:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579472; cv=none; b=kopOt9F8SlhOyfjuH23SOzELBSLaXvGs8fFhVxB63PkGGxESQ1PlWvbxyxmvTdkaSUzhDirN0/+YaXzvJvlaT2W3g8TzZ33cU/8LO+OQWEu+aOWfyzZSv+gMUsgiWHJNOzNP+XfQGovBltOI/0LRfAjd4Eqq7+UprGnAxQwqY4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579472; c=relaxed/simple;
	bh=mUN7MbczmVRiCEVL7UNf+wU1CiCIR3BHOosYGfbF7m4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=g5RfccMyA9DLImNL7CfAgIB3OgMUUM3tRRuaKxYsJLLsU3q9xxxBGgV9OCy8evIxiIEJ3xdt4HZvGFzsWZPShhhQXrxkqOJY4AGJAgUw7NEBkdjWXw8WhFiz7fGqdlKlJB10Uklohkt7hClwGLfybhOXOIKfMSdeIZfbJ//dOZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IhRbUAUA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rv8xtjBm; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 423A07A00B2;
	Fri, 12 Dec 2025 17:44:29 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 12 Dec 2025 17:44:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1765579469; x=1765665869; bh=cGxb0rERi9zY41SmHPu12s2fR8DD/Kc8+1g
	BMz3XMvA=; b=IhRbUAUAHHtMWG9sWyfRWax0Fp/sJmRKbk4dzzmtBTC+nA592HO
	9NcoxFXOlLCOW5+nNINAuoHcMuxZPvnOf7Y+v3lWU/e9YFrWnh+fow0gYt0W50NR
	MG7LtryB/VoFJAxJygi28l6/cmRRbTDTECYbEik7XxCMqNG48xYhQVgbWZBqO6A3
	9MkxiRM81+WcBeuqD87RrFlITjPpmT54m/mNpgg4XOW5/NZJa4KRcOht+htKJwk2
	rC6mQi06Tm1NokCA8H3+ipLfOIc/1PwUfe7c2BgK8A2BLhX17k727UbHkXPhcYv+
	aF1HR9IKTYOiV+eAuFZ0aem54SuzwZdo0EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765579469; x=
	1765665869; bh=cGxb0rERi9zY41SmHPu12s2fR8DD/Kc8+1gBMz3XMvA=; b=R
	v8xtjBmktKjhgfZUAeroavCGx+nTf7dR+sUpsg24+Bg9HfJIILSa/7Ws1MgDwVY8
	vxR6ZeoAPLHQ3qoWJPGXGjp+5PLPgOrfdXfL9l6v5/cugilU4EKc3mnbTiKHUdFB
	ylgRf/EsZRfbpvdsFowq+MfKOYYT9oLIGm9nLkj4QQmplrhyimw3ZimcT54X+zVj
	+pDGJ5LltK3HPvTFDK4EaNv6uRuD2/qSrqPlDl6lfJdXGfB2VvG7zkl/cNSW+G+5
	LFIEpADgxChzLWiVkSFuPIm0EbwoT9x+BvGEOt3ZWiRM+HR6VJtcbrb1N/R3gPbX
	idFDkwwYrQGm8BY/HmXTQ==
X-ME-Sender: <xms:zJo8aeNlKl8_FDfDW5c_IY_LAaeoMf-Wo99nP5LjI2o9NLnrtPg0XQ>
    <xme:zJo8afNXqWJ0Joz4kGj1LiP_1EFtF7cLyvdo4d5fxptzHxPgvW-xxktC4qi7sLiSA
    QcTnGQ0c6pIHY0bKGG_gSYgyf3EK24O4-LTSgJV0z2DXNL3>
X-ME-Received: <xmr:zJo8aXigZuCJkBEqniMnoYV-SK1nwwBd9ArY8KeUWFWvs-W89hUq-qdWn2dalZVXSBrwfLssag4AQlVTU0XxNy8rtihirVQ3EwUuQkAbzvHZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepthhomhesthgrlhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhi
    vghvsehrvgguhhgrthdrtghomhdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorh
    grtghlvgdrtghomhdprhgtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdp
    rhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvg
    hilhgssegsrhhofihnrdhnrghmvg
X-ME-Proxy: <xmx:zJo8aUuRLU1YFFY02U_0AlS1T9tyHBk7aToDWmL58uk0HZIG80qetg>
    <xmx:zJo8aVQTyQ9EOlRLV7j-BkuEZv9hLjrvqXF0JeeL8MNBK6mHyAWNGw>
    <xmx:zJo8aY0SuFsfBOz3exr3A_gVptxlTc4TmYckXwAc-f0gZ9QQRhaMxg>
    <xmx:zJo8aavv4EGJ0gvgnOOx40nOBnfWX6RlrxBKsYJTuHbp0LuLrf2DeQ>
    <xmx:zZo8aWg-7hWe_O2J3UC8AKtfv8nyXKrAi7V5e9WrfLvZYWmDSyP3Ujoz>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 17:44:26 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Olga Kornievskaia" <okorniev@redhat.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-nfs@vger.kernel.org,
 neilb@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Subject:
 Re: [PATCH v2 1/1] nfsd: check that server is running in unlock_filesystem
In-reply-to: <20251212164711.55712-1-okorniev@redhat.com>
References: <20251212164711.55712-1-okorniev@redhat.com>
Date: Sat, 13 Dec 2025 09:44:22 +1100
Message-id: <176557946264.16766.8685979514740919698@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 13 Dec 2025, Olga Kornievskaia wrote:
> If we are trying to unlock the filesystem via an administrative
> interface and nfsd isn't running, it crashes the server.

I think it would be good to explain here why it crashes - it is
accessing state structures - conf_id_hashtbl in particular - which has
not been allocated, or has been freed.


And I don't think the "Modules linked in" line, nor the x??: register
values add anything but noise.  I would elide them.

>=20
> [   59.445578] Modules linked in: nfsd nfs_acl lockd grace nfs_localio ext4=
 crc16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat=
 fat uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_memops uvc vi=
deobuf2_v4l2 videobuf2_common snd_hda_intel snd_intel_dspcfg snd_hda_codec vi=
deodev snd_hda_core snd_hwdep mc snd_seq snd_seq_device snd_pcm snd_timer snd=
 soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_comm=
on vmw_vsock_vmci_transport vmw_vmci vsock xfs ghash_ce nvme e1000e nvme_core=
 nvme_keyring nvme_auth hkdf sr_mod cdrom vmwgfx drm_ttm_helper ttm 8021q gar=
p stp llc mrp sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libiscsi_tcp l=
ibiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
> [   59.451979] CPU: 4 UID: 0 PID: 5193 Comm: bash Kdump: loaded Tainted: G =
   B               6.18.0-rc4+ #74 PREEMPT(voluntary)
> [   59.453311] Tainted: [B]=3DBAD_PAGE
> [   59.453913] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.00V=
.24006586.BA64.2406042154 06/04/2024
> [   59.454869] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=
=3D--)
> [   59.455463] pc : nfsd4_revoke_states+0x1b4/0x898 [nfsd]
> [   59.456069] lr : nfsd4_revoke_states+0x19c/0x898 [nfsd]
> [   59.456701] sp : ffff80008cd67900
> [   59.457115] x29: ffff80008cd679d0 x28: 1fffe00016a53f84 x27: dfff8000000=
00000
> [   59.458006] x26: 04b800ef00000000 x25: 1fffe00016a53f80 x24: ffff0000a79=
6ea00
> [   59.458872] x23: ffff0000b89d6000 x22: ffff0000b6c36900 x21: ffff0000b6c=
36580
> [   59.459738] x20: ffff80008cd67990 x19: ffff0000b6c365c0 x18: 00000000000=
00000
> [   59.460602] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000000=
00000
> [   59.461480] x14: 0000000000000000 x13: 0000000000000001 x12: ffff7000119=
acf13
> [   59.462272] x11: 1ffff000119acf12 x10: ffff7000119acf12 x9 : dfff8000000=
00000
> [   59.463002] x8 : ffff80008cd67810 x7 : 0000000000000000 x6 : 0097001de00=
00000
> [   59.463732] x5 : 0000000000000004 x4 : ffff0000b5818000 x3 : 04b800ef000=
00004
> [   59.464368] x2 : 0000000000000000 x1 : 0000000000000005 x0 : 04b800ef000=
00000
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
>=20
> -- v2 changes to address Neil's comments/suggestions
> changing nfsd4_revoke_states() to take in nfsd_net
> holding nfsd_mutex over nfsd4_revoke_states (making sure to unlock
> and cleanup before return)
>=20
> Fixes: 1ac3629bf0125 ("nfsd: prepare for supporting admin-revocation of sta=
te")
> Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> ---
>  fs/nfsd/nfs4state.c |  3 +--
>  fs/nfsd/nfsctl.c    | 11 ++++++++++-
>  fs/nfsd/state.h     |  4 ++--
>  3 files changed, 13 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 35004568d43e..191d67973e31 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1769,9 +1769,8 @@ static struct nfs4_stid *find_one_sb_stid(struct nfs4=
_client *clp,
>   * The clients which own the states will subsequently being notified that =
the
>   * states have been "admin-revoked".
>   */
> -void nfsd4_revoke_states(struct net *net, struct super_block *sb)
> +void nfsd4_revoke_states(struct nfsd_net *nn, struct super_block *sb)
>  {
> -	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	unsigned int idhashval;
>  	unsigned int sc_types;
> =20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 2b79129703d5..35bb94f49392 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -259,6 +259,7 @@ static ssize_t write_unlock_fs(struct file *file, char =
*buf, size_t size)
>  	struct path path;
>  	char *fo_path;
>  	int error;
> +	struct nfsd_net *nn;
> =20
>  	/* sanity check */
>  	if (size =3D=3D 0)
> @@ -285,7 +286,15 @@ static ssize_t write_unlock_fs(struct file *file, char=
 *buf, size_t size)
>  	 * 3.  Is that directory the root of an exported file system?
>  	 */
>  	error =3D nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
> -	nfsd4_revoke_states(netns(file), path.dentry->d_sb);
> +	mutex_lock(&nfsd_mutex);
> +	nn =3D net_generic(netns(file), nfsd_net_id);
> +	if (!nn->nfsd_serv) {
> +		error =3D -EINVAL;
> +		goto out;
> +	}
> +	nfsd4_revoke_states(nn, path.dentry->d_sb);
> +out:
> +	mutex_unlock(&nfsd_mutex);

I'm not a fan of the goto here.
I would do

	mutex_lock(&nfsd_mutex);
	nn =3D net_generic(netns(file), nfsd_net_id);
	if (nn->nfsd_serv)
		nfsd4_revoke_states(nn, path.dentry->d_sb);
	else
		error =3D -EINVAL;
	mutex_unlock(&nfsd_mutex);

But either way:

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown

