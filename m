Return-Path: <linux-nfs+bounces-11249-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0F9A99438
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 18:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02C34C0D2D
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 16:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E96C290BC5;
	Wed, 23 Apr 2025 15:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6euZqwN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E61290BC1
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423627; cv=none; b=N1TnvEJM0jqRhARrQYgcQqFGqAshIrVWk28/7avrriZ/qpeE6MTos9hVWA3iUvBzgL5TXria6EYdN0mEZ7APdhd1ivDmcZXw2uGk9En5RnKiZWAk7agKBZn4E11ZqscTZHPgDK6KFuU/i1sgxuLMRDls/nuWc5wNRf+br2OiFdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423627; c=relaxed/simple;
	bh=zpsnqxv2i0Vu+P+he96Ff3jJsbMtiX8zAN737SyClxY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P+QYL1x6366H81ccdRl8gaWZivlZYqwlapMeNf5OIOwvk/3P9Ezq9FAmccW0xteZpJq+g9s5ufvEPkKfzTpnb+jjOTql716/My2mt3ie8lBMBxv8U7HwO99m3rAS8mD52LmfWUQEnHokAsJ5uhjPhft3f4W+9UIUVO61svI4lo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6euZqwN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ED0C4CEE2;
	Wed, 23 Apr 2025 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745423625;
	bh=zpsnqxv2i0Vu+P+he96Ff3jJsbMtiX8zAN737SyClxY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=U6euZqwN2pXdHiDeVINKI/k4iP9qXWZoqLyuqfdUmlUX6mD7gm2qbggE2aJDKuS+m
	 Tteihjy9rcHwOhZVPpNuPzqIA/kWm4f3G0wtHvm8vCWKCao2sQG5uVwbNCdj1pKKDQ
	 NySjjnJ58Lez8kAzjINNqlKanT+lJuXpLYGEh01PiAFyWIXTk4e14aBCczeApKJ0wd
	 O2Iz/klNuXRAGYKEaIMB8TVWozFTMaO5Ts4IolJBh5Ei7AbquIaIUm87EAQxiewZKX
	 KCCqzsOdh4BuiHTKNfa9sMSf+9Oy8X4Qp5cLtbxLA7E1aiNrsqfmR46DDqiRw++th6
	 w+oSgyTPUPrfA==
Message-ID: <9fd8b6f84a39d5dc7715b1a7411df90b2ea83b74.camel@kernel.org>
Subject: Re: leaked pNFS DS nfs_client references
From: Jeff Layton <jlayton@kernel.org>
To: Trond Myklebust <trondmy@hammerspace.com>, Anna Schumaker
 <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Omar Sandoval <osandov@osandov.com>, Chris
 Mason	 <clm@meta.com>
Date: Wed, 23 Apr 2025 11:53:44 -0400
In-Reply-To: <6dcb8370766dac91240301e1cfbf9b77e863da08.camel@kernel.org>
References: <6dcb8370766dac91240301e1cfbf9b77e863da08.camel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 15:46 -0400, Jeff Layton wrote:
> Hi Trond/Anna:
>=20
> We (at Meta) have been hunting a number of problems surrounding leaked
> network namespaces with containerized workloads. We recently deployed a
> v6.9 based kernel on the clients that has all the known containerized
> NFS fixes from upstream.
>=20
> Usually, when we've found problems with leaked netns's it has been
> because there were still outstanding RPCs associated with the rpc_clnt.
> Today, we found a host that seems to have some leaked nfs_client
> structures, but there is no associated RPC activity.
>=20
> In this case, we had 2 leaked net namespaces. We discovered them by
> looking under /sys/kernel/debugfs/rpc_xprt for xprts associated with
> netns's that no longer have any userland tasks attached.
>=20
> Some drgn (pardon my terrible Python):
>=20
> > > > for net in for_each_net():
> ...     if (net.ns.inum =3D=3D 4026558887 or net.ns.inum =3D=3D 402655880=
5):                                  =20
> ...         print("netns:", net.ns.inum)                                 =
                             =20
> ...         nfs_net =3D cast("struct nfs_net *", net.gen.ptr[prog["nfs_ne=
t_id"]])
> ...         print("Volume list empty:", list_empty(nfs_net.nfs_volume_lis=
t.address_of_()))
> ...         for clnt in list_for_each_entry("struct nfs_client", nfs_net.=
nfs_client_list.address_of_(), "cl_share_link"):
> ...             rpcclnt =3D clnt.cl_rpcclient
> ...             print(clnt.cl_count.refs.counter, clnt.cl_hostname, rpccl=
nt.cl_vers, "tasks: ", list_count_nodes(rpcclnt.cl_tasks.address_of_()))
> ...=20
> netns: (unsigned int)4026558805
> Volume list empty: True
> (int)1 (char *)0xffff8a12e988a500 =3D "f00::3117:a4f1:a940:94af" (u32)3 t=
asks:  0
> (int)1 (char *)0xffff8881a0f694c0 =3D "f00::bfaa:cec2:8ee2:295" (u32)3 ta=
sks:  0
> (int)1 (char *)0xffff889e81a74e40 =3D "f00::8f23:f52d:9d79:a7b0" (u32)3 t=
asks:  0
> (int)1 (char *)0xffff8a027d8e0780 =3D "f00::d209:97ba:1c6:3282" (u32)3 ta=
sks:  0
> netns: (unsigned int)4026558887
> Volume list empty: True
> (int)1 (char *)0xffff8a14d5b0e2c0 =3D "f00::3f52:fea6:4ccb:96dd" (u32)3 t=
asks:  0
> (int)1 (char *)0xffff8881e6626cc0 =3D "f00::705:c924:ddc1:51e4" (u32)3 ta=
sks:  0
> (int)1 (char *)0xffff8a149cdb6680 =3D "f00::3117:a4f1:a940:94af" (u32)3 t=
asks:  0
> (int)1 (char *)0xffff8896ada2f800 =3D "f00::d56c:cd93:1f0c:99c7" (u32)3 t=
asks:  0
> (int)1 (char *)0xffff8a159251f240 =3D "f00::614d:87c1:a73f:1f09" (u32)3 t=
asks:  0
> (int)1 (char *)0xffff888e699f4940 =3D "f00::1285:b785:f114:d38b" (u32)3 t=
asks:  0
> (int)1 (char *)0xffff88812ae41500 =3D "f00::fb1c:bc4a:3d9a:c2a6" (u32)3 t=
asks:  0
> (int)1 (char *)0xffff8a137dbc4e00 =3D "f00::bd2f:5851:b552:5bce" (u32)3 t=
asks:  0
>=20
> There are 12 leaked nfs_clients in 2 netns's. There are no longer any
> struct nfs_servers associated with either netns. Each leaked client has
> a single outstanding reference. They're all connections to different
> DS's (except for one between the two netns's, but I suspect that's just
> coincidence). They're all NFSv3, which indicates that they are pNFS DS
> clients. None of them have any running RPCs.
>=20
> I took a look at the nfs_client refcount handling in the pNFS code but
> didn't see any obvious bugs.
>=20
> One thing we could consider is adding a refcount tracker for these
> objects. That would tell us pretty quickly what took the leftover
> references in the first place, assuming this is reproducible.
>=20
> This kernel is based on v6.9, so it's possible we missed a fix that we
> need. I didn't see anything obvious in recent git fixes though.
>=20
> Any thoughts?

An update:

Omar and I worked together yesterday, and confirmed that this is the
same problem that he reported a week or two ago. This kernel has the
two patches you sent on April 6th:

    [PATCH v2 1/2] NFSv4: Handle fatal ENETDOWN and ENETUNREACH errors
    [PATCH v2 2/2] NFSv4/pnfs: Layoutreturn on close must handle fatal netw=
orking errors

...so that's evidently not enough to fix it.

Note that this is a potential memory corruptor. The leaked layout segs
were all sitting on the layouts plh_return_segs list. If they get freed
later, then that will likely scribble over the list_head in the freed
layout.

Looking over the code, it appears that when the inode is evicted, the
plh_return_segs list should get cleaned out via:

nfs4_evict_inode
    pnfs_destroy_layout_final
        __pnfs_destroy_layout
            pnfs_mark_layout_stateid_invalid
                pnfs_free_returned_lsegs

pnfs_free_returned_lsegs() should put them all on the tmp_list and then
__pnfs_destroy_layout() should free the contents of the list via
pnfs_free_lseg_list().

It's not clear to me why that didn't happen here.
--=20
Jeff Layton <jlayton@kernel.org>

