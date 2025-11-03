Return-Path: <linux-nfs+bounces-15975-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 697CAC2E3D0
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 23:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946713B285D
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 22:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5A22BFC60;
	Mon,  3 Nov 2025 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="C73QieSk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AWQ2qZx/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE142EF664
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208073; cv=none; b=qdOajAJMyQLytwJz046dNzRQPBeWM0VUUnIOBcsX+sFIZs8VKsg+BT7pKjzlnYD4tkThvL1DRxoQsPtsZJfSpK72VpBj/HlBJjwXWUrPyELIi+/gXV7c77FnLtOg3lcCYnv2mjK8LFZOtfcjPh+kmDRGiF1SN32Kkt+N8U0t9sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208073; c=relaxed/simple;
	bh=Oh+LjXy97cTuY9uehPheB63iaTsYKyG/C+qiKtQxv1o=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=m3vaHRoJW6f4y1Ufp87wHfBvDR3FHXyVVWBbTD2+vl3vEKMF+URqyP8yVX8ok7vogoMVDXe6lbVFqYA8tt3R+4JmoJC9gngAwTJJDHLYoaRux0G5FOkmPPeWl4ilD1UmB7MFewFjmEKh2bLIjR2DkspVxPdwcUO/4EwRAZoZxfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=C73QieSk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AWQ2qZx/; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 28392EC00C7;
	Mon,  3 Nov 2025 17:14:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 03 Nov 2025 17:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1762208070; x=1762294470; bh=AeHKrSni3dzNXkjLyi98fr7pz0kCt6T9nmi
	3wZYm5CY=; b=C73QieSkVnioMsKZ5k3tq0pudl3k/g2epi6pq8J1FHGDKFgP35e
	1ocd7EN+3bf8DqkRPER/pACmSkBmLtM/pAzQhw0m7aaM51/kAIsCq0u+okZw35Mb
	hitl3nSCTmpBxrR9uPTezwju0yYtBduXSRwckoq/ObM86kTSlUlUyKZVQQaeyGGt
	81foCauoB6aqkKE4whjitNtuZRHo6wIFDRrwv2tUKznOl0dMYm+5ml4DD9/yhx8K
	/rkyk65KBG3GOPQItDmaGTwG20NZwr1f8HCZYdBIT3diO0oFJ1AXFdZuIPZRMToJ
	Zl4ZVMUrQCoWlKFx6SxHj95IlAIYmqpzEkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762208070; x=
	1762294470; bh=AeHKrSni3dzNXkjLyi98fr7pz0kCt6T9nmi3wZYm5CY=; b=A
	WQ2qZx/yakONAM1FunrrhZnRZTnPXGroNsExF+5vEi4ZTBukSkVQLckJ6s6TcMSJ
	/G8vcRYxoT0umdGrlzH/5XHy6VtCrJcu44bzrr6v9wfWoLUydkw19ezgcGRV9aQN
	SX5GGlGoEqAIav60KefMe3JprsSS/yC7BUHPpA8qirT+5p9/b88C10zvUDsLUmIJ
	SO5gZ3JNUHMmA5F7U/HWoUwVC++Rgn5PniOvid14JFsmZ9swfV9pNG48ghrj1Gf3
	8BV7xX+r6h9fbsMgdqP995mknX51AW/eHiNebGR05GV1PLBVtiGZoK2p9NsiXLZD
	kaBZaSqLs73qfHA5z6Eqw==
X-ME-Sender: <xms:RSkJaZviSuHwS_5kC-NpYrH3p8B4gdgLHaOmKzDAftlKRTfgX4kjfQ>
    <xme:RSkJaRi5xhNyPb8QeYTjanvMCAtG6Eyq_dZsNl6E46bAMg_d2ELZRZXFtm9UjN1eX
    b3axdSg1AqFJ-D7MjZB7kwIKUNY3-5D6LkJkVsON7_N6nOLWQ>
X-ME-Received: <xmr:RSkJaS8dlfudHbqoSKXFB1SSSsj6mc0Q1N0F2LYN-qudWi-vyrk6AaYr5LOKkDoCoqJwTQ12rX4zCIvy4fITOAGzwZ0bjyy-LU8nk6vDX_4G>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epvdeuteelkeejkeevteetvedtkeegleduieeftdeftefgtddtleejgfelgfevffeinecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnvghilhgssehofihnmhgrihhlrdhnvghtpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqd
    hnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhomhesthgrlhhp
    vgihrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopegurghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopegthhhu
    tghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopehsnhhithiivghrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegtvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RSkJacvE8jQ0W85qnRdT8p5dtYtYlh4u6CHgNwv-u_2KUmh-s4FUaw>
    <xmx:RSkJaeq6jkVJTI85jl2N42_apysDTxj2d7DyHScd878X21Vj0iA4Jw>
    <xmx:RSkJaYrPI_YJ_tg-4yrE2fiAtZVRPv09MKdEyQRVtrUl1JX-OV8glA>
    <xmx:RSkJaVaqsHtgLjq4pvaezvblJYtikVhM4kOOZflm1XV_wmow2-U3Tw>
    <xmx:RikJafQ7ReTQ89ccFTSP16P0KSzarnkklH-39oA-10-a_jyYV14gJI6p>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 17:14:27 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <cel@kernel.org>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>, "Mike Snitzer" <snitzer@kernel.org>
Subject: Re: [PATCH v9 01/12] NFSD: Make FILE_SYNC WRITEs comply with spec
In-reply-to: <20251103165351.10261-2-cel@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>,
 <20251103165351.10261-2-cel@kernel.org>
Date: Tue, 04 Nov 2025 09:14:22 +1100
Message-id: <176220806300.1793333.10389831266293417568@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 04 Nov 2025, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> Mike noted that when NFSD responds to an NFS_FILE_SYNC WRITE, it
> does not also persist file time stamps. To wit, Section 18.32.3
> of RFC 8881 mandates:
>=20
> > The client specifies with the stable parameter the method of how
> > the data is to be processed by the server. If stable is
> > FILE_SYNC4, the server MUST commit the data written plus all file
> > system metadata to stable storage before returning results. This
> > corresponds to the NFSv2 protocol semantics. Any other behavior
> > constitutes a protocol violation. If stable is DATA_SYNC4, then
> > the server MUST commit all of the data to stable storage and
> > enough of the metadata to retrieve the data before returning.
>=20
> For many years, NFSD has used a "data sync only" optimization for
> FILE_SYNC WRITEs, in violation of the above text (and previous
> incarnations of the NFS standard). File time stamps haven't been
> forced to be persisted as the mandate above requires.

I think that is "For the last 5 months..."

Fixes: 3f3503adb332 ("NFSD: Use vfs_iocb_iter_write()")

That patch replaced

-               flags |=3D RWF_SYNC;

with

+               kiocb.ki_flags |=3D IOCB_DSYNC;

which looks right given

	if (flags & RWF_SYNC)
		kiocb_flags |=3D IOCB_DSYNC;

in kiocb_set_rw_flags().
However that ignores the previous line

	kiocb_flags |=3D (__force int) (flags & RWF_SUPPORTED);

where RWF_SUPPORTED contains RWF_SYNC, and RWF_SYNC is the same bit
as IOCB_SYNC.

NeilBrown


>=20
> For many in-tree Linux file systems, time stamps, as well as other
> metadata not needed to find the data on disk, are piggy-backed on
> fdatasync-mandatory metadata updates. Thus, this change should
> affect only the case where previously fully-allocated file data
> is overwritten.
>=20
> Reported-by: Mike Snitzer <snitzer@kernel.org>
> Closes: https://lore.kernel.org/linux-nfs/20251018005431.3403-1-cel@kernel.=
org/T/#t
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f537a7b4ee01..5333d49910d9 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1314,8 +1314,18 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
>  		stable =3D NFS_UNSTABLE;
>  	init_sync_kiocb(&kiocb, file);
>  	kiocb.ki_pos =3D offset;
> -	if (stable && !fhp->fh_use_wgather)
> -		kiocb.ki_flags |=3D IOCB_DSYNC;
> +	if (likely(!fhp->fh_use_wgather)) {
> +		switch (stable) {
> +		case NFS_FILE_SYNC:
> +			/* persist data and timestamps */
> +			kiocb.ki_flags |=3D IOCB_DSYNC | IOCB_SYNC;
> +			break;
> +		case NFS_DATA_SYNC:
> +			/* persist data only */
> +			kiocb.ki_flags |=3D IOCB_DSYNC;
> +			break;
> +		}
> +	}
> =20
>  	nvecs =3D xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
>  	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
> --=20
> 2.51.0
>=20
>=20


