Return-Path: <linux-nfs+bounces-16981-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E277CAB167
	for <lists+linux-nfs@lfdr.de>; Sun, 07 Dec 2025 05:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDFA430194CA
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Dec 2025 04:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C242D3228;
	Sun,  7 Dec 2025 04:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="X7+tt09i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sjrMjQyW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A916827C866
	for <linux-nfs@vger.kernel.org>; Sun,  7 Dec 2025 04:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765081815; cv=none; b=dINk/iRjz++GGmHH0fGk7FM6fhZIobNJnx+uKhi1wrHT6S9a4YJjasiQJxBg5syi02aKrYobzu16Rvy2mS8b+ughQzCDdPpBm3Ba+CO9nqFVTzAmzGgVBNBfVGtLlVuAFDApS2GbtNnrUA55qZ0L0t+XpgOSO1v/lWpX1gC4AIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765081815; c=relaxed/simple;
	bh=Tm22/7D91E2x3DeTQ90nAXaIlE7bvPn/6vw6inqDodA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=p3NiSwG/Om96oTWouPpTyGi8E3cA1sCt2KXxIvD0rey3Ms+96bkwLBZoji73q8NmfIgG8oIVxdYM5YTGF0dsVwjfqBp5cgNXep4HnmcrVzuC5ur6KG/gvF6cbmTMXu7eFoxt2PQTDDzDxIFt3BDI5PFN1tPJV56bpndq+7cG5wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=X7+tt09i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sjrMjQyW; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB3A27A0184;
	Sat,  6 Dec 2025 23:30:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 06 Dec 2025 23:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1765081811; x=1765168211; bh=K+Fgrd4b+nThOXBaTadPJZF62vEpd9+6UrG
	RIxcRv5I=; b=X7+tt09iUs1ykjzu2FpZ/wyQUersKxaZMUkrOGOuuneL4sHepSa
	6JcFX9KIO/wVURXDf/mc93naRJfMGobGUvcwttIaL3dy85i33DekLGV3yJSA6kgl
	se+CAZef2VUK2/Uod+fUjnWbiOES44lVowsquW7YzQLXiytwA2zkoHIn0i+59ZvB
	UZehHndry6w2l6hWocMiDZMnG3TF4uuGTQtNK3braiGG0ZXbvCL3qEb7GHRgd1yA
	kDOXpYnL0GU8GGH4RH6iYqQ3qB+OIezBwyAS6lVCliIOdZnPnv/5DonLODlsYafp
	Hl9MBaseWNqLc2llEe88R7yYnRW2zmNtehQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765081811; x=
	1765168211; bh=K+Fgrd4b+nThOXBaTadPJZF62vEpd9+6UrGRIxcRv5I=; b=s
	jrMjQyWdX4E+Ty6R5jNFySiPLnXodUX0QUYm3aIGIvqbGKtgXmwYJtnpUDCXUaB0
	j91jfG8EDYw/bCj4TNCkUJ3cD9sH33ga5wnN8K1Yi97aPI4agu85tORWpTwUUSPr
	mhFNeQTodIRYhw/x0jArWyfMTh90rbnzetW54u69oTWXeDRTj84vAYpEp+eP4ztR
	G0EnWmyDQvGpQj7oDkxkT4mBPmXhLNJMmAEuvKJ8bBfwHyUFpjotqyHvMG7Oq+9Z
	TuAgrjB8HDYI/dqIwZrnih4yQpBkZit/tJTrwm28rfrkd9IjsHCLFgZ84qK1ZiuJ
	SaN8zpYSu8pDV2ghgtbVw==
X-ME-Sender: <xms:0wI1aTdpxKsNfLorSXZ9Mf4Q9fb9G4ju_HPuG8fUdOeq8X0f1EkhVQ>
    <xme:0wI1abc6qkiThkAItlStBv0GFJyvzPPAwldQRHYKWYIQvNm59eNH9rXJxf4pg_VU-
    HtavX3ZBN7Zfg0X1r02wT-u4ZH95K3GszVZw3VJxzkLIXW_dWU>
X-ME-Received: <xmr:0wI1aexFM5_KEJV0oUyADqQlTRu8WxCJnJVIqxkUi4fjHJFin3Sup1pwQ2LUle-c_G2S5zx71iMslD_HtnX4bbdh_lJuKJQUnyfzjfu00QNp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdekiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:0wI1aa875oUvBsoLBiF4LqJBWFYJiwX32tQoVt2LdEBOyR-2ODA3Cg>
    <xmx:0wI1aeh3r-s7q0QBHlUiiZKPvOyZLt5zgSsa1K8rUJf3KYZbP1H4XA>
    <xmx:0wI1aZHdnQti6wCIGyuwYuI6BPzDaUqmpR9szsLD48T7v6o1oTzD-A>
    <xmx:0wI1aV_4zTp826IHiD8-zqeDBgQJbaqbqH6yfLJzCbTs7uZjhBKx5A>
    <xmx:0wI1aRCRlkiEatCa5iJhbO5TBdYTtl9BBdnIp2_eozLy42b2Khx_M79H>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 23:30:08 -0500 (EST)
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
 Re: [PATCH 1/1] nfsd: check that server is running in unlock_filesystem
In-reply-to: <20251205184156.10983-1-okorniev@redhat.com>
References: <20251205184156.10983-1-okorniev@redhat.com>
Date: Sun, 07 Dec 2025 15:30:04 +1100
Message-id: <176508180496.16766.14577514890223630313@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sat, 06 Dec 2025, Olga Kornievskaia wrote:
> If we are trying to unlock the filesystem via an administrative
> interface and nfsd isn't running, it crashes the server.
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

But *why* does it crash?
Can you please
   ./scripts/faddr2line fs/nfsd/nfs4state.o nfsd4_revoke_states+0x1b4/0x898

and report what line of code it is crashing on?

>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 35004568d43e..faa874eff1e9 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1775,6 +1775,9 @@ void nfsd4_revoke_states(struct net *net, struct supe=
r_block *sb)
>  	unsigned int idhashval;
>  	unsigned int sc_types;
> =20
> +	if (!nn->nfsd_serv)
> +		return;
> +

Seeing that nfsd4_revoke_states() doesn't make any reference to
nfsd_serv, I think this change is - at best - confusing.

As there is no lock held here, nfsd_serv could spontaneously become NULL
at any time, so this is unlikely to be a complete fix.

I would expect each conf_id_hashtbl[] list to be empty when no server is
running so the function should do nothing.  Clearly my expectation is
wrong, but I would like to know *why* it is wrong, and to fix the root
cause.


We also need this

--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1778,7 +1778,7 @@ void nfsd4_revoke_states(struct net *net, struct super_=
block *sb)
 	sc_types =3D SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG | SC_TYPE_LAYOUT;
=20
 	spin_lock(&nn->client_lock);
-	for (idhashval =3D 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
+	for (idhashval =3D 0; idhashval < CLIENT_HASH_SIZE; idhashval++) {
 		struct list_head *head =3D &nn->conf_id_hashtbl[idhashval];
 		struct nfs4_client *clp;
 	retry:

Maybe it should be part of the same patch - maybe not.

Thanks,
NeilBrown

