Return-Path: <linux-nfs+bounces-16586-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89382C712CC
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 22:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D64B342B16
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Nov 2025 21:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E1E2FF656;
	Wed, 19 Nov 2025 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="R+K+Jd43";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cb/HxSI5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F182E7F1E
	for <linux-nfs@vger.kernel.org>; Wed, 19 Nov 2025 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588335; cv=none; b=faAnbdd4HY/KRiiK7ztt2JMYxshHlwSyA4ycn/9WHxyqTiQkQ6lTLt1iEhsfOmqK8ShjDgObhP+w4qc5l4BVjHHokZGnvP+GkuRCK0bXlelUpw5EaevbyPHt55IBbAyqUHJu6jfKViapCsjg9MoRgjntOZw0iwUm7znHFgKK5RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588335; c=relaxed/simple;
	bh=KkmLc2T6JLLxfaIDw7PYVesIXok+qmNdGRoUgedNNJE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OBKDRPDwrUGiXYUs0rP/KDh/+UOHuwMcJjeOsbQQ02TX6WmXIxVKb+I1mxfZvup3CINYMDyDdC3GNm56Qu8ddmxEoi3Fe5aUqtZCnccJj6TfnGwt+W30IVGuGiYVWSYz+9ePyJ9VtJI1wiKIpcKeBPohx6dbT+0tnepIrFxty8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=R+K+Jd43; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cb/HxSI5; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4ED11400155;
	Wed, 19 Nov 2025 16:38:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 19 Nov 2025 16:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1763588330; x=1763674730; bh=B7pHW0TRIl/m/Z4qzlav/6kHYtv0cX0COaO
	kpsVNgMk=; b=R+K+Jd43mWht9I4wQvgUNSVJaURCqCZvP87zGZ3pYUF0aWVPJMU
	9RljkelpUFfxY4C3PB10uzDe+YWRPsos/Xbh9TkeJkeuCg8FX6n7R5c1hgo2j+/6
	WWGAwsf0B1/AvHkHcgmPUA0p4TB98Ex8jpI6xbKtjzcvYuyYNTP/+AaPV2HdJslA
	+BI4BXGCf2gzKOvyBn/r/xwHjzgh5AYTRBY+jmOSOdQk5fayfoWYPHfoIWq2wg3g
	j4OgPYPxLoBiQxUPas8kdGKoMHAQw21uavrZZ6Uiz1k5EQskJ3HCItWD4MAuVuDw
	wETFXJh3UKncw55H83GyZjUzsv4oIboerQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763588330; x=
	1763674730; bh=B7pHW0TRIl/m/Z4qzlav/6kHYtv0cX0COaOkpsVNgMk=; b=C
	b/HxSI5Uru/jeYjaeEprvOvluUvPX6L+lyOxHlxuOqmUdx9C5A9NMI/coWO5s9A2
	jgKYTXGxKMVmRejZI8feigjX5liXl8sujUI+XDWSaSW+DPOM8QZFDnyP05M10xc4
	VQ6Levw/6uFd8R7fqFzRHJr4k24kze8TdqTYo5AKHJfM23a25uAtLcewIogV4vnM
	24dDAjK0Wmq8wBg48/sttjpQJdMZ0HHCWirg28h0oI212LK7UAeQUHlllT6pctdT
	oWhhrQkDs9PCH++yHyBerSn+EIVNg9Dp5FWOGtswk3paeZOO3WNjBWeVHNn6P4DZ
	/ce+PI4VtN+KQM8vJ5cZg==
X-ME-Sender: <xms:6jgeaXAvhV2jFKuinXv60B7aSr3Rwi-B28g8HJeLO3w2OXMdW5-5Cw>
    <xme:6jgeaRMUBU1v76yC9tUiyit6ZlqvVXTm7PB1seUG1ecQwX0CesqStei9p4C1yVE-X
    deguyO218wDv73JPGgKzFIqvvEW96uZUbHqK1fj_Rl-FyLVtbk>
X-ME-Received: <xmr:6jgeacb4eZ-vuniRepy4EHgLY4pXkc63p6Ch-_z32nwn0w-NT8kU9xgKirhSA7CwUjmzb5pqxqbKvOuKAZVu4X0_h6xzQoCVf0_pSvYHMfQy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufgjfhffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epleejtdefgeeukeeiteduveehudevfeffvedutefgteduhfegvdfgtdeigeeuudejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehokhhorhhn
    ihgvvhesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhesoh
    hrrggtlhgvrdgtohhmpdhrtghpthhtohepuggrihdrnhhgohesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6jgeaQtA5mpQY2D-0R_Rw3wyXzBa7OeCM3OkToF_g0dh_YNwq2vRGg>
    <xmx:6jgeaeP1LFxMWem5z-LkqTb_bGs9_hUk0eEBVkZVf27SyEVz9bZ9AQ>
    <xmx:6jgeaX7CgrpMEzh7K6VCL5UUdIMAw5vht4K6nTz2YLBIpsB2OkmHAg>
    <xmx:6jgeaUR6moIf5TmoA4S6zhCj-yxMciuaDUfFhzKZEodReI2I9pkacg>
    <xmx:6jgeaYisCFDTj_zcR8ZCstaRqDSwO0sQMR4TWin9rTwJ5S2q7GpVzRH4>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 16:38:48 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 03/11] nfsd: simplify foreign-filehandle handling to
 better match RFC-7862
In-reply-to: <3097252a-8071-49ef-ad2d-1e9733540913@oracle.com>
References: <20251119033204.360415-1-neilb@ownmail.net>,
 <20251119033204.360415-4-neilb@ownmail.net>,
 <3097252a-8071-49ef-ad2d-1e9733540913@oracle.com>
Date: Thu, 20 Nov 2025 08:38:42 +1100
Message-id: <176358832223.634289.3617743312148292910@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 20 Nov 2025, Chuck Lever wrote:
> On 11/18/25 10:28 PM, NeilBrown wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > When the COPY v4.2 op is used in the inter-server copy mode, the file
> > handle of the source file (presented as the saved filehandle to COPY)
> > is for a different ("foreign") file server which would not be expected
> > to be understood by this server.  fh_verify() might return nfserr_stale
> > or nfserr_badhandle.
> >=20
> > In order of this filehandle to still be available to COPY, both PUTFH
> > and SAVEFH much not trigger an error.
> >=20
> > RFC 7862 section 15.2.3 says:
> >=20
> >    If the request is for an inter-server copy, the source-fh is a
> >    filehandle from the source server and the COMPOUND procedure is being
> >    executed on the destination server.  In this case, the source-fh is a
> >    foreign filehandle on the server receiving the COPY request.  If
> >    either PUTFH or SAVEFH checked the validity of the filehandle, the
> >    operation would likely fail and return NFS4ERR_STALE.
> >=20
> >    If a server supports the inter-server copy feature, a PUTFH followed
> >    by a SAVEFH MUST NOT return NFS4ERR_STALE for either operation.
> >    These restrictions do not pose substantial difficulties for servers.
> >    CURRENT_FH and SAVED_FH may be validated in the context of the
> >    operation referencing them and an NFS4ERR_STALE error returned for an
> >    invalid filehandle at that point.
> >=20
> > [The RFC neglects the possibility of NFS4ERR_BADHANDLE]
> >=20
> > Linux nfsd currently takes a different approach.  Rather than just
> > checking for "a PUTFH followed by a SAVEFH", it goes further to consider
> > only that case when this filehandle is then used for COPY, and allows
> > that it might have been subject of RESTOREFH and SAVEFH in between.
> >=20
> > This is not a problem in itself except for the extra code with little
> > benefit.  This analysis of the COMPOUND to detect PUTFH ops which need
> > care is performed on every COMPOUND request, which is not necessary.
> >=20
> > It is sufficient to check if the relevant conditions are met only when a
> > PUTFH op actually receives an error from fh_verify().
> >=20
> > This patch removes the checking code from common paths and places it in
> > nfsd4_putfh() only when fh_verify() returns a relevant error.
> >=20
> > Rather than scanning ahead for a COPY, this patch notes (in
> > nfsd4_compoundargs) when an inter-server COPY is decoded, and in that
> > case only checks the next op to see if it is SAVEFH as this is what the
> > RFC requires.
> >=20
> > A test on "inter_copy_offload_enable" is also added to be completely
> > consistent with the "If a server supports the inter-server copy feature"
> > precondition.
> >=20
> > As we do this test in nfsd4_putfh() there is no now need to mark the
> > putfh op as "no_verify".
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/nfsd/nfs4proc.c | 64 ++++++++++++++++------------------------------
> >  fs/nfsd/nfs4xdr.c  |  2 +-
> >  fs/nfsd/xdr4.h     |  2 +-
> >  3 files changed, 24 insertions(+), 44 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 3160e899a5da..e6f8b5b907a9 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -693,8 +693,28 @@ nfsd4_putfh(struct svc_rqst *rqstp, struct nfsd4_com=
pound_state *cstate,
> >  	       putfh->pf_fhlen);
> >  	ret =3D fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_BYPASS_GSS);
> >  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
> > -	if (ret =3D=3D nfserr_stale && putfh->no_verify)
> > -		ret =3D 0;
> > +	if ((ret =3D=3D nfserr_badhandle || ret =3D=3D nfserr_stale) &&
> > +	    inter_copy_offload_enable) {
> > +		struct nfsd4_compoundargs *args =3D rqstp->rq_argp;
> > +		struct nfsd4_compoundres *resp =3D rqstp->rq_resp;
> > +		struct nfsd4_op	*next_op =3D &args->ops[resp->opcnt];
> > +
>=20
> I find the initializer confusing -- it's only generating an address,
> but not yet dereferencing it -- but it can generate an address beyond
> the end of the args->ops array.

"confusing", yet you understand it perfectly!

The var is only used once so I'll drop it.
Though then I need a comment explaining that

		/*
		 * args->opcnt is the number of ops in the request.
		 * resp->opcnt is the number of ops, including this
		 * one, that have been processed, so it points
		 * to the next op.
		 */

>=20
>=20
> > +		if (resp->opcnt <=3D args->opcnt &&
>=20
> In fact the "resp->opcnt <=3D args->opcnt" check allows accessing
> the N+1th array element, since the array is indexed 0 to N-1. So
> the condition here needs to by "<" not "<=3D"

and having that new comment make this observation clear too - thanks.

>=20
>=20
> > +		    next_op->opnum =3D=3D OP_SAVEFH &&
> > +		    args->is_inter_server_copy) {
> > +			/*
> > +			 * RFC 7862 section 15.2.3 says:
> > +			 *  If a server supports the inter-server copy
> > +			 *  feature, a PUTFH followed by a SAVEFH MUST
> > +			 *  NOT return NFS4ERR_STALE for either
> > +			 *  operation.
> > +			 * We limit this to when there is a COPY
> > +			 * in the COMPOUND, and extend it to
> > +			 * NFS4ERR_BADHANDLE.
>=20
> Extending to match NFS4ERR_BADHANDLE as well explicitly does /not/
> comply with RFC 7862, as you say above. So the short description is
> misleading.

Does:
			/*
			 * RFC 7862 section 15.2.3 says:
			 *  If a server supports the inter-server copy
			 *  feature, a PUTFH followed by a SAVEFH MUST
			 *  NOT return NFS4ERR_STALE for either
			 *  operation.
			 * We limit this to when there is a COPY
			 * in the COMPOUND, and extend it to
			 * also ignore NFS4ERR_BADHANDLE despite the
			 * RFC not requiring this.  If the remote
			 * server is running a different NFS implementation,
			 * NFS4ERR_BADHANDLE is a likely error.
			 */

resolve your concern?

Thanks,
NeilBrown

