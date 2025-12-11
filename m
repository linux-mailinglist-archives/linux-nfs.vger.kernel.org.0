Return-Path: <linux-nfs+bounces-17044-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B946DCB75CA
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 00:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 626B73009FD6
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Dec 2025 23:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9062DF710;
	Thu, 11 Dec 2025 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="0TmrAY2N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eNz2sr3Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A162DCF47
	for <linux-nfs@vger.kernel.org>; Thu, 11 Dec 2025 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765495190; cv=none; b=URYG8534AlU8HYYn3QnhYSDCXycmE5gs2YtM56TVTptQoFoGOIs38VeMorXndvWz3RDueG7BXGiOGT1tRc3L2eP7BIy/rRElAbKb/gQDuGdoaoKjZISuXK/rxtXzGhYbY0Mdr1g/UkNa1+XjjIAH8SHG9RlRxRTw7A9WT9G0WgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765495190; c=relaxed/simple;
	bh=zmbyOkUXkYngZ5JbtaV3DlwxDf41C7D8oVogTZlcf2k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=m6+GQG9MncZn7GtbyLTZplEH6oNidKWLZBvbY+3jYz0ItNsU5ZswTGSEJP56bLeMD7VgnAaWKtZh7XOFrW5AwePbBrcSicIKmg7N7Jvyclxs0PuJky1pGb37f3Ef8dIxviM04nRUZQscEH/v9Ec3fCOEhdB7VB4jaSvZ4rKPyQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=0TmrAY2N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eNz2sr3Y; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 91C4C7A0182;
	Thu, 11 Dec 2025 18:19:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 11 Dec 2025 18:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1765495187; x=1765581587; bh=3hEVw/dBGKr1JDh5NJTm+2tT2sYhWVGxlJv
	6/0gPrDA=; b=0TmrAY2NtsbbZni6khhWjIsJGtGSFu7R6R9gy0E0OBWpJPLkQ3H
	aG3zdf+6ze8h2ltYsXuK/GuH7VYn2HEijQPO/F21L2z8sD+p/B21hAL/yIQfAbN0
	Ol4exrmUnyp+qYpIr0Zwq8sfUvc0Veg1Xz3s5RWqOCvs8Iw2rMmXI+CyVf7Fltyj
	W0ZyzjaXBCh7FFnFQHTdYRPdsUHV7eJR93PEQY1bI6ip0dp1UAQ83H52A462dEdH
	GRM/Xnen6Ow2IAZVb5Dr6k39E13JpmJj9kXp2QmX3f0Nc2TfpZqBCPxbq0mBfZJ6
	cTt556YxIQwMFBBbbcoRjCN3AC2QovzmkVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765495187; x=
	1765581587; bh=3hEVw/dBGKr1JDh5NJTm+2tT2sYhWVGxlJv6/0gPrDA=; b=e
	Nz2sr3Yyovsze/BKk0mpcNnzNdHY2muGDnboToPYF0hb4KlOEnx/MS93urAmLUFi
	l3EORaxMs4A34sZf4mcogxc2VO/rjqbmGrgz/Br1sgwQj0aO/iW41P/Ei65E3BEr
	WmK77nRCSrJehTeuQJfSA3l/E384fThbzNDOrWhXF4NavsWN/ns3o3S46oy4q2OL
	0DvfxdibWMoGEF+0TlvIGNCNWiVxXZtnOkSb+FrCukpAGop/Rh1wGYu1WfOKgOvR
	p64dw/HLgenpLqOQgDkm8aFsU89+ieWRm6YPdhsPt4+66bYdnrrQrWdn4wLHAX2R
	BRLaaMwEyYXsRmrYKqh8g==
X-ME-Sender: <xms:k1E7aYRAeNpc31EaFFLmcEbCC_9OWtexS5ZHNq1UmKZzcYlQLxbKYg>
    <xme:k1E7aU0LQ494-az1pJVPqkIS7vW3r2OGUMj1vWJHYPn-8De0vDfmdvcwry8s64Bn_
    ZnZA5Nhb-k_xQOmlUevyy2GA48vbaqAgWG3a4FHCARUXZw5hw>
X-ME-Received: <xmr:k1E7acC7OwDrgF8scagqZHWY5LG9cY071PQ_5qXmZQ0VZgmCkwWuFF_ZzBA6bQH4WLtxdgPLRAAbUKU3XtGEJeXMQQ8c9xYOIJ9rwUkxlcYt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:k1E7aYiOBs7zSTtCJFYUNDXyKJuLq5XJ_kRx6FUN3nYBJxZk9X6mMA>
    <xmx:k1E7aWNudxoCkSKxRZnNDHCQgJh4mLIAi-rNDA7dX_FK-n_7oCQ3Vg>
    <xmx:k1E7aQ_wAhCVi7qsJGzNiviLziyCoYU83nIyqJLzmDAicn1RKcpLMw>
    <xmx:k1E7afcAhUdzW2X81_WCp_BymVx0xl7bWrkCHfqLdW5vr6bUJf9k3Q>
    <xmx:k1E7aTAyXXFvtYKiARXF4vmlA-rUmNiFAMcDfiY_-U_cRWvaZv81pP3d>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 18:19:44 -0500 (EST)
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
 <CAN-5tyE6DEoH9r2SH=3BwxM8vaQoYF83Zk9+s_iq3Vk6MKSV1w@mail.gmail.com>
References: <20251205184156.10983-1-okorniev@redhat.com>,
 <176508180496.16766.14577514890223630313@noble.neil.brown.name>,
 <CAN-5tyFNgMk0j37ZnhiRqKK8LoLChb25_oCjvo5LWsjapGJL9w@mail.gmail.com>,
 <176522947804.16766.1562289482158759372@noble.neil.brown.name>,
 <CAN-5tyE6DEoH9r2SH=3BwxM8vaQoYF83Zk9+s_iq3Vk6MKSV1w@mail.gmail.com>
Date: Fri, 12 Dec 2025 10:19:42 +1100
Message-id: <176549518259.16766.11594053603722440783@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 11 Dec 2025, Olga Kornievskaia wrote:
> On Mon, Dec 8, 2025 at 4:31=E2=80=AFPM NeilBrown <neilb@ownmail.net> wrote:
> >
> > On Tue, 09 Dec 2025, Olga Kornievskaia wrote:
> > > On Sat, Dec 6, 2025 at 11:30=E2=80=AFPM NeilBrown <neilb@ownmail.net> w=
rote:
> > > >
> > > > On Sat, 06 Dec 2025, Olga Kornievskaia wrote:
> > > > > If we are trying to unlock the filesystem via an administrative
> > > > > interface and nfsd isn't running, it crashes the server.
> > > > >
> > > > > [   59.445578] Modules linked in: nfsd nfs_acl lockd grace nfs_loca=
lio ext4 crc16 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfk=
ill vfat fat uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_memop=
s uvc videobuf2_v4l2 videobuf2_common snd_hda_intel snd_intel_dspcfg snd_hda_=
codec videodev snd_hda_core snd_hwdep mc snd_seq snd_seq_device snd_pcm snd_t=
imer snd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transp=
ort_common vmw_vsock_vmci_transport vmw_vmci vsock xfs ghash_ce nvme e1000e n=
vme_core nvme_keyring nvme_auth hkdf sr_mod cdrom vmwgfx drm_ttm_helper ttm 8=
021q garp stp llc mrp sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libisc=
si_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
> > > > > [   59.451979] CPU: 4 UID: 0 PID: 5193 Comm: bash Kdump: loaded Tai=
nted: G    B               6.18.0-rc4+ #74 PREEMPT(voluntary)
> > > > > [   59.453311] Tainted: [B]=3DBAD_PAGE
> > > > > [   59.453913] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VM=
W201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > [   59.454869] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSB=
S BTYPE=3D--)
> > > > > [   59.455463] pc : nfsd4_revoke_states+0x1b4/0x898 [nfsd]
> > > >
> > > > But *why* does it crash?
> > >
> > > > Can you please
> > > >    ./scripts/faddr2line fs/nfsd/nfs4state.o nfsd4_revoke_states+0x1b4=
/0x898
> > > >
> > > > and report what line of code it is crashing on?
> > >
> > > okorniev@linux-10:/source/linux$ ./scripts/faddr2line
> > > fs/nfsd/nfs4state.o nfsd4_revoke_states+0x1b4/0x898
> > > nfsd4_revoke_states+0x1b4/0x898:
> > > find_one_sb_stid at /source/linux/fs/nfsd/nfs4state.c:1748
> > > (inlined by) nfsd4_revoke_states at /source/linux/fs/nfsd/nfs4state.c:1=
786
> >
> > Thanks.  As you suggest it is likely accessing memory that we freed by
> > nfsd_shutdown_net().  By the time it gets into find_one_sb_stid() it
> > would have already accessed some freed memory so it was lucky to get
> > that far.
> >
> > Code that wants to access conf_id_hash and related parts of nn should
> > use:
> >
> >   nfsd_net_try_get(net)
> >
> > to check if it is safe and to keep it safe, and then nfsd_net_put(net)
> > when it has finished.  That is more robust than simply checking nfsd_serv.
>=20
> I'm confused by the guidance given.

Probably the guidance was confused.

>=20
> I understood that other uses of nn->nfsd_server did so by grabbing the
> nfsd_mutex lock. Thus, I ask, if it would be acceptable to do. Again,
> I vote for this as it's the same as what the other proc uses (note,
> unsure what the appropriate error code here should be).

Yes it would be acceptable to use nfsd_mutex.
I don't like nfsd_mutex and would like to get rid of it.  In most
cases there is no desire to wait, only to ensure other code waits before
destroying anything, and that fits the refcount pattern better.

But we have nfsd_mutex now so it isn't wrong to use it.


> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 2b79129703d5..fcd026db553c 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -259,6 +259,7 @@ static ssize_t write_unlock_fs(struct file *file,
> char *buf, size_t size)
>         struct path path;
>         char *fo_path;
>         int error;
> +       struct nfsd_net *nn;
>=20
>         /* sanity check */
>         if (size =3D=3D 0)
> @@ -285,6 +286,11 @@ static ssize_t write_unlock_fs(struct file *file,
> char *buf, size_t size)
>          * 3.  Is that directory the root of an exported file system?
>          */
>         error =3D nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
> +       mutex_lock(&nfsd_mutex);
> +       nn =3D net_generic(netns(file), nfsd_net_id);
> +       if (!nn->nfsd_serv)
> +               return -EINVAL;
> +       mutex_unlock(&nfsd_mutex);
>         nfsd4_revoke_states(netns(file), path.dentry->d_sb);

If you move the mutex_unlock to *after* the nfsd4_revoke_states() call,
this should be correct.

It might be nicer to change nfsd4_revoke_states() to take an nfsd_net
rather than a net, then you could just pass 'nn', but it isn't a big deal.

>=20
>         path_put(&path);
>=20
> However, your preference was to make use of nfsd_net_try_get()
> function and here's my attempt:
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 2b79129703d5..3ab22bab1d51 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -285,8 +285,10 @@ static ssize_t write_unlock_fs(struct file *file,
> char *buf, size_t size)
>          * 3.  Is that directory the root of an exported file system?
>          */
>         error =3D nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
> +       if (!nfsd_net_try_get(netns(file)))
> +               return -EINVAL;
>         nfsd4_revoke_states(netns(file), path.dentry->d_sb);
> -
> +       nfsd_net_put(netns(file));

This looks correct - except that it might need rcu protection as you
note below.

>         path_put(&path);
>         return error;
>  }
>=20
> But I'm confused that nfsd_net_try_get() has "__must_hold(rcu)" yet
> when I look at usage of that function there is only one place that
> calls under rcu_read_lock(). Thus I'm confused about the said
> requirement. Also say if rca_read_lock was gotten before
> nfsd_net_try_get() call can it be released directly after it or is it
> supposed to be held over the call to nfssd4_revoke_states().

That __must_hold(rcu) is wrong - sort of.
It should be in the .h file as well to be at all useful.
The important thing is that a stable ref should be held to 'net', and
rcu is one have a stable reference is via rcu.

I think rcu is needed inside nfsd_net_try_get() to ensure that if 'nn'
is not NULL, then percpu_ref_tryget_live() cannot access freed memory.
I think it is currently safe because when netd_net_try_get() is called
without rcu_read_lock, there is already a ref held and the code is just
trying to get an extra one.

In general, if rcu is used to stablise 'net', then nfsd_net_try_get()
will stablise it more permanently and also stablise the nfsd-specific
parts of 'net'.  So after nfsd_net_try_get() succeeds, rcu_read_lock()
is no longer needed.

>=20
> Neil/Chuck/Jeff please which of those 2 patches should I resend (and
> if the 2nd one needs modifications as I said I'm too unsure about the
> suggested approach).

Given the uncertainties around rcu, it is probably best use the
nfsd_mutex approach, as long as the we don't unlock until after the work
is done.

Thanks,
NeilBrown

