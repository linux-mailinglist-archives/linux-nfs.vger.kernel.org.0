Return-Path: <linux-nfs+bounces-9298-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BBBA13983
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 12:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8D11610BE
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 11:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640D319FA92;
	Thu, 16 Jan 2025 11:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnqAVRNb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E04A24A7C2
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 11:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737028411; cv=none; b=nHssT9o5UJkqixLLk8jsSAp2USpF2DKTA2ORqaD7Q64zSxxECzVoPLfBQGDbqfGk/sXMck/ARgHfXhTtcTS+zPX24RFqW7SJc5u5C+rBWK+Yal/EGQnk5/UA8O/CAPUIopxWALR5hM1C5PIlcNfENVIN1ih5VXsFU4UrvXu339E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737028411; c=relaxed/simple;
	bh=pQg3W9iKN1MChI8KOqD8WMmbyLe9ymmc3pL9XrlmrOo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rKseT6Sw9TqvLeGIJLDbvlxRCDDEaZ5mppNFo3+HDlVmBm8fl8jhcWywpjXuNH/UtIu2LVX7zdJ0Ywhp6FkGqQM4aBDqTkoft38shiTTyQHBp5VM5dje+ffrqBc0Fu/sRykm43d9brIcuFKvaxYUnI2VHCm6OlXSgEC3p6RwkXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnqAVRNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E00C4CED6;
	Thu, 16 Jan 2025 11:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737028410;
	bh=pQg3W9iKN1MChI8KOqD8WMmbyLe9ymmc3pL9XrlmrOo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=gnqAVRNb8jWV6z9W3s4kgmQqX9PlPgEdNrGY4NkC6Ulp4Q1hztv1kM9BgLW8ERJ8j
	 82AtG6F7zUfmbrUKUrCZ+vZGgct2YGCrDi+lC0Tovne5iPWgYLCcALSkJq8rec67Py
	 DHFXbrIc39yHCCdRbCViDN01gp86vIaCAUtfX7qpt9ZTT74i/Kz1fgdulao0PKaHg3
	 VTPpBUDzj8B2y3H1byFBIxbv9+zIAttIDlnHzmaoKHSPdvKwtfhINzVbTEg5YNSaRt
	 zcNSx39QMNOvT/Bcs1VLihJBl//b9wHr8lB3w0caM7ozLwQdJ3ACss47Az29b595T6
	 mwt28/1iugrVA==
Message-ID: <3a6f2a3d97ef3541d06c378a2dcd15fbbcdbc4dc.camel@kernel.org>
Subject: Re: [PATCH 0/3] fix removal of nfsd listeners
From: Jeff Layton <jlayton@kernel.org>
To: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com
Cc: linux-nfs@vger.kernel.org
Date: Thu, 16 Jan 2025 06:53:29 -0500
In-Reply-To: <20250115232406.44815-1-okorniev@redhat.com>
References: <20250115232406.44815-1-okorniev@redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-15 at 18:24 -0500, Olga Kornievskaia wrote:
> Currently if a root user using nfsdctl command tries to remove a particul=
ar
> listener from the list of previously added ones, then starting the nfsd
> leads to the following problem:
>=20
> [  158.835354] refcount_t: addition on 0; use-after-free.
> [  158.835603] WARNING: CPU: 2 PID: 9145 at lib/refcount.c:25 refcount_wa=
rn_saturate+0x160/0x1a0
> [  158.836017] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core nfs=
d auth_rpcgss nfs_acl lockd grace overlay isofs uinput snd_seq_dummy snd_hr=
timer nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_rej=
ect_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack=
 nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables qrtr sunrpc vfat fat=
 uvcvideo videobuf2_vmalloc videobuf2_memops uvc videobuf2_v4l2 videodev vi=
deobuf2_common snd_hda_codec_generic mc e1000e snd_hda_intel snd_intel_dspc=
fg snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device snd_pcm snd_=
timer snd soundcore sg loop dm_multipath dm_mod nfnetlink vsock_loopback vm=
w_vsock_virtio_transport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs=
 libcrc32c crct10dif_ce ghash_ce vmwgfx sha2_ce sha256_arm64 sr_mod sha1_ce=
 cdrom nvme drm_client_lib drm_ttm_helper ttm nvme_core drm_kms_helper nvme=
_auth drm fuse
> [  158.840093] CPU: 2 UID: 0 PID: 9145 Comm: nfsd Kdump: loaded Tainted: =
G    B   W          6.13.0-rc6+ #7
> [  158.840624] Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
> [  158.840802] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS VMW201.0=
0V.24006586.BA64.2406042154 06/04/2024
> [  158.841220] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYP=
E=3D--)
> [  158.841563] pc : refcount_warn_saturate+0x160/0x1a0
> [  158.841780] lr : refcount_warn_saturate+0x160/0x1a0
> [  158.842000] sp : ffff800089be7d80
> [  158.842147] x29: ffff800089be7d80 x28: ffff00008e68c148 x27: ffff00008=
e68c148
> [  158.842492] x26: ffff0002e3b5c000 x25: ffff600011cd1829 x24: ffff00008=
653c010
> [  158.842832] x23: ffff00008653c000 x22: 1fffe00011cd1829 x21: ffff00008=
653c028
> [  158.843175] x20: 0000000000000002 x19: ffff00008653c010 x18: 000000000=
0000000
> [  158.843505] x17: 0000000000000000 x16: 0000000000000000 x15: 000000000=
0000000
> [  158.843836] x14: 0000000000000000 x13: 0000000000000001 x12: ffff60005=
0a26493
> [  158.844143] x11: 1fffe00050a26492 x10: ffff600050a26492 x9 : dfff80000=
0000000
> [  158.844475] x8 : 00009fffaf5d9b6e x7 : ffff000285132493 x6 : 000000000=
0000001
> [  158.844823] x5 : ffff000285132490 x4 : ffff600050a26493 x3 : ffff80008=
05e72bc
> [  158.845174] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00009=
8588000
> [  158.845528] Call trace:
> [  158.845658]  refcount_warn_saturate+0x160/0x1a0 (P)
> [  158.845894]  svc_recv+0x58c/0x680 [sunrpc]
> [  158.846183]  nfsd+0x1fc/0x348 [nfsd]
> [  158.846390]  kthread+0x274/0x2f8
> [  158.846546]  ret_from_fork+0x10/0x20
> [  158.846714] ---[ end trace 0000000000000000 ]---
>=20
> nfsd_nl_listener_set_doit() would manipulate the list of transports of
> server's sv_permsocks and svc_xprt_close() the specified listener but
> the other list of transports (server's sp_xprts list) would not be
> changed leading to the problem.
>=20
> the other problem is that sp_xprt is a lwq structure of lockless
> list which does not have an ability to remove a single entry from
> the list.
>=20
> this patch series addis a function to remove a single entry, then modifie=
s
> nfsd_nl_listener_set_doit() to make sure the to-be-removed listener is
> removed from both lists and then it also ensures that the remaining
> listeners are added back in the correct state.
>=20
> Olga Kornievskaia (3):
>   llist: add ability to remove a particular entry from the list
>   SUNRPC: add ability to remove specific server transport
>   nfsd: fix management of listener transports
>=20
>  fs/nfsd/nfsctl.c           |  4 +++-
>  include/linux/llist.h      | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/sunrpc/svc.h |  1 +
>  net/sunrpc/svc_xprt.c      | 11 +++++++++++
>  4 files changed, 51 insertions(+), 1 deletion(-)
>=20

Nice work, Olga.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

