Return-Path: <linux-nfs+bounces-16999-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E18ECAE3AD
	for <lists+linux-nfs@lfdr.de>; Mon, 08 Dec 2025 22:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F6503011A8B
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Dec 2025 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BFC21770A;
	Mon,  8 Dec 2025 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="nG6D1hE0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H3GYsMoB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394AD1DB95E
	for <linux-nfs@vger.kernel.org>; Mon,  8 Dec 2025 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765229488; cv=none; b=WmDzD4pF1H5wqp72e1144AYWE/qTIiMcz/tTKMll7bBJ/Qy+NBa3mTBo6hFht/C4uvqwN6i9dMqXFIEPE972kqwlbryYG3hpZXIhAoJIbm0AyoVkbRNW+ZJz/4y5Bi4CWbkQLqHTabAQJ6kPsS55DCUQN599fTm5zy2QxJ7635o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765229488; c=relaxed/simple;
	bh=xuGcHFhZh52029i4ab6iLtKZBMhXZML7k0oHM31vp20=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=rqBH6OhezvQNkv36iy7kAJHyK2JVZJO40Yb19vS8MUp+7EauV4ng3PgsbHcT8Bs7pAz2IH4XR8tQ3Glmcs0755qXrx2saVSKDxJvfRmu9igm8f0iCbFdWNSw5I62D6fdXbT+LBYSYF6OQISF5KU5DXf+T2eIX8LslcUUiMbJdKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=nG6D1hE0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H3GYsMoB; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D3987A0024;
	Mon,  8 Dec 2025 16:31:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Dec 2025 16:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1765229484; x=1765315884; bh=PSeQIO+RkV4MrrbLMAtpMehGhdhaCVWd3vh
	4CuAcEes=; b=nG6D1hE00FaFosbi6hYwNHULyYTJu54+aN6sUBo9Lqv1amlXGVx
	AXpfth43EE9DxuRmBBsr5y97c7Xjc2q5o/F/0f3/kaLZWof3aohI3tM3LkbC8NOw
	WZjU7aT8yF82UqUXOb+KTQ9C+I4oLccHMjNkTMBqXf1PUnNHdecRojmGIxmTaQw2
	cUsU6MKpwF/c+DtuTB4IZ/202w2d+0cY7c9SMJrhmY3xOmodB3pNCUeaCVmdXmw3
	84DZ/cMJrqHJ6/0hMcatZ99CP3oG95F2+yhEykFkeNLCytLisCA34Dm6UqpHO9/r
	V/R+bZoshQZC3GVa1svE7O82vor9sDwaK+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765229484; x=
	1765315884; bh=PSeQIO+RkV4MrrbLMAtpMehGhdhaCVWd3vh4CuAcEes=; b=H
	3GYsMoBif3ofRWsIIeMgcYr6or7PE2/o8BF2kRCIbJrDdZjotb/A3q6dT9VfYwlg
	n9Tw2S8yGAuEAPB3jh93ahSJzC5+aw8XJvmpxpQoYx6yXmWfVJ4Bslc1mv+WVTIR
	ob/J4R9u94YHlJ4RBAk73Y1UnYAjjRzm1V8q06qssnVAylWzL658Co1+vQ5y3mnC
	7o6KOncdwxFl0bExwNUHZ1g0q/tcTgN58r6nMKyfVet5L8aB2mJ08RATD7is8exW
	QqNqVDjSiL+HxmZhvnynA6AcoAswFrW0O/LxC+iHBi8E+e3KXF7//UGs9eWWGlwo
	HmGOBtCBAkidqE5WFPNUQ==
X-ME-Sender: <xms:q0M3aWQlDYJ5jyCbGpQjXqLKW204fZJ3wbz1X2iANgqFsxJLp1b2bg>
    <xme:q0M3aa2-ye1xoMA6-F6K5gBLz4HnVPc0FwZCQ3Zsfdq0VXxv1boAF-PYlIsd1sCD2
    nU1EhNPxjpIoJ6ZC7km3xtxgtg8G4ql0f02cDbFAAeNFMH3kw>
X-ME-Received: <xmr:q0M3aaBbPuH-kcZs9v4Ro4RoS2-bm11k8z9QnyE9TUCYOVKnZuctCWVoUL4IjPP6mnzrq3_lL1jGClZk-E2JlGKJsG2WGcNV5M6kLLBuPH9q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpegtgfgghffvvefujghffffkrhesthhqredttddtjeenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    eljedtfeegueekieetudevheduveefffevudetgfetudfhgedvgfdtieeguedujeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghglhhosehumhhitghhrdgvughupdhrtghpthhtohepthhomhesthgr
    lhhpvgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomh
    dprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphht
    thhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehjlhgrhihtoh
    hnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghilhgssegsrhhofihnrdhnrghm
    vg
X-ME-Proxy: <xmx:q0M3aejgR5r2ttd0ck1lJT4sA-tkOhZceAyd-Kx3W_ocYjxfpxpwJA>
    <xmx:q0M3aUPByfKUTiBaXiEkp4u68nXMhL9nd8F8K1y7BEEWo1_t5D7d9g>
    <xmx:q0M3aW95BcgElRpsE74esdEhGg2ueryW93Q9sZU1MYFHaSRgXFjepA>
    <xmx:q0M3ade-hcx-1CQ4WH1M1KD7HBLbAhPeGxaWqTD9NYMy9lWcXobFMQ>
    <xmx:rEM3aRBUkcmHinJD1P-J1zpYrGA2dywN7Y84SYGPt-KFDyERjosk7E12>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 16:31:21 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Olga Kornievskaia" <aglo@umich.edu>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, chuck.lever@oracle.com,
 jlayton@kernel.org, linux-nfs@vger.kernel.org, neilb@brown.name,
 Dai.Ngo@oracle.com, tom@talpey.com
Subject:
 Re: [PATCH 1/1] nfsd: check that server is running in unlock_filesystem
In-reply-to:
 <CAN-5tyFNgMk0j37ZnhiRqKK8LoLChb25_oCjvo5LWsjapGJL9w@mail.gmail.com>
References: <20251205184156.10983-1-okorniev@redhat.com>,
 <176508180496.16766.14577514890223630313@noble.neil.brown.name>,
 <CAN-5tyFNgMk0j37ZnhiRqKK8LoLChb25_oCjvo5LWsjapGJL9w@mail.gmail.com>
Date: Tue, 09 Dec 2025 08:31:18 +1100
Message-id: <176522947804.16766.1562289482158759372@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 09 Dec 2025, Olga Kornievskaia wrote:
> On Sat, Dec 6, 2025 at 11:30=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote:
> >
> > On Sat, 06 Dec 2025, Olga Kornievskaia wrote:
> > > If we are trying to unlock the filesystem via an administrative
> > > interface and nfsd isn't running, it crashes the server.
> > >
> > > [   59.445578] Modules linked in: nfsd nfs_acl lockd grace nfs_localio =
ext4 crc16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill =
vfat fat uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_memops uv=
c videobuf2_v4l2 videobuf2_common snd_hda_intel snd_intel_dspcfg snd_hda_code=
c videodev snd_hda_core snd_hwdep mc snd_seq snd_seq_device snd_pcm snd_timer=
 snd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_=
common vmw_vsock_vmci_transport vmw_vmci vsock xfs ghash_ce nvme e1000e nvme_=
core nvme_keyring nvme_auth hkdf sr_mod cdrom vmwgfx drm_ttm_helper ttm 8021q=
 garp stp llc mrp sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libiscsi_t=
cp libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
> > > [   59.451979] CPU: 4 UID: 0 PID: 5193 Comm: bash Kdump: loaded Tainted=
: G    B               6.18.0-rc4+ #74 PREEMPT(voluntary)
> > > [   59.453311] Tainted: [B]=3DBAD_PAGE
> > > [   59.453913] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201=
.00V.24006586.BA64.2406042154 06/04/2024
> > > [   59.454869] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BT=
YPE=3D--)
> > > [   59.455463] pc : nfsd4_revoke_states+0x1b4/0x898 [nfsd]
> >
> > But *why* does it crash?
>=20
> > Can you please
> >    ./scripts/faddr2line fs/nfsd/nfs4state.o nfsd4_revoke_states+0x1b4/0x8=
98
> >
> > and report what line of code it is crashing on?
>=20
> okorniev@linux-10:/source/linux$ ./scripts/faddr2line
> fs/nfsd/nfs4state.o nfsd4_revoke_states+0x1b4/0x898
> nfsd4_revoke_states+0x1b4/0x898:
> find_one_sb_stid at /source/linux/fs/nfsd/nfs4state.c:1748
> (inlined by) nfsd4_revoke_states at /source/linux/fs/nfsd/nfs4state.c:1786

Thanks.  As you suggest it is likely accessing memory that we freed by
nfsd_shutdown_net().  By the time it gets into find_one_sb_stid() it
would have already accessed some freed memory so it was lucky to get
that far.

Code that wants to access conf_id_hash and related parts of nn should
use:

  nfsd_net_try_get(net)

to check if it is safe and to keep it safe, and then nfsd_net_put(net)
when it has finished.  That is more robust than simply checking nfsd_serv.

>=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 35004568d43e..faa874eff1e9 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -1775,6 +1775,9 @@ void nfsd4_revoke_states(struct net *net, struct =
super_block *sb)
> > >       unsigned int idhashval;
> > >       unsigned int sc_types;
> > >
> > > +     if (!nn->nfsd_serv)
> > > +             return;
> > > +
> >
> > Seeing that nfsd4_revoke_states() doesn't make any reference to
> > nfsd_serv, I think this change is - at best - confusing.
>=20
> This solution was in line with how the rest of proc functionality did
> it (ie it checks whether or not the server is running).

That code checks nfsd_serv while holding nfsd_mutex.  write_unlock_fs()
does not take nfsd_mutex, so testing nfsd_serv in nfsd4_revoke_state()
is racy.

>=20
> > As there is no lock held here, nfsd_serv could spontaneously become NULL
> > at any time, so this is unlikely to be a complete fix.
>=20
> I disagree that it's not a fix. As the main logic I think should be
> that the unlock operation shouldn't be attempted if there isn't a
> running server.
>=20
> However, what I think you are saying is that the server shutdown
> cleanup should have cleaned things such that this error shouldn't
> occur even if there isn't a check for the running server. While I see
> the logic there, I find it more confusing to ignore the fact that we
> are not checking for the running state of the server before trying to
> perform an operation that assumes the server is running.
>=20
> > I would expect each conf_id_hashtbl[] list to be empty
>=20
> Not only is it empty, it's been freed by nfsd4_state_destroy_net() function.
>=20
> "systemctl start nfs-server" --- creates the conf_id_hashtbl
> "systemctl stop nfs-server" --- ends up freeing it
> echo path > unlock_filesystem --- has no conf_id_hashtbl.
>=20
> I still stand that the solution here is to check for the running
> server. If you think the check nn->nfsd_net_up is better than checking
> for null, I can do that.
>=20
> >  when no server is
> > running so the function should do nothing.  Clearly my expectation is
> > wrong, but I would like to know *why* it is wrong, and to fix the root
> > cause.
> >
> >
> > We also need this
> >
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -1778,7 +1778,7 @@ void nfsd4_revoke_states(struct net *net, struct su=
per_block *sb)
> >         sc_types =3D SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG | SC_TYP=
E_LAYOUT;
> >
> >         spin_lock(&nn->client_lock);
> > -       for (idhashval =3D 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
> > +       for (idhashval =3D 0; idhashval < CLIENT_HASH_SIZE; idhashval++) {
> >                 struct list_head *head =3D &nn->conf_id_hashtbl[idhashval=
];
> >                 struct nfs4_client *clp;
> >         retry:
> >
> > Maybe it should be part of the same patch - maybe not.
>=20
> I gather this is a needed change but insufficient to fix the issue and
> should be a separate patch (as a fix for something but not this
> problem).

It is just a tangentially related bug that I noticed while reading the
code.  Not really related to the bug you found, so it deserves to be a
separate patch.  I'll send something.

Thanks,
NeilBrown

