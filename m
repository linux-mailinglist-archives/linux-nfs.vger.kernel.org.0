Return-Path: <linux-nfs+bounces-11795-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA08ABB3B5
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 05:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B27A189581C
	for <lists+linux-nfs@lfdr.de>; Mon, 19 May 2025 03:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D5135897;
	Mon, 19 May 2025 03:49:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BB1171D2
	for <linux-nfs@vger.kernel.org>; Mon, 19 May 2025 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747626582; cv=none; b=aay3K0Ao726eKwobuLYpFYg7b3HuiyxySUIxvdRBP1K91YBc+eHPQ7O3gjFxeAM61IeBPDcycOxtohC6y+d74xR/3u8+E8sgrW+V+EAtZDnisvuUgmoIAp1y3qMhdvjEpYA9HBqZHkRXZXAgMJQ/lyORcWBe4lJz3kdMJySgAms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747626582; c=relaxed/simple;
	bh=1GO9bb9OovNa/wZ31lfGFhUxYmbJGVBNoonEGm/a1h4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=GCER36CUL6XIUvbgEGFGcEkzpNvE5yIKEzFOgrSAouMYvwlmBv9mxhqiemL/YbQJEGkuIgwZ5sgpaMGq0BtpfACrP+6CEbSVMLH+53QZhiEGbjTfTjSMGw0BzeNlidh5ODXKd5355I7FHzW5gvf+9JWR+ox4zBEcXvwBWy60b+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uGrVK-0067hM-Ja;
	Mon, 19 May 2025 03:49:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 Pali =?utf-8?q?Roh=C3=A1r?= <pali@kernel.org>,
 "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
 "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 paulmck@kernel.org
Subject: Re: [PATCH 0/6 v2] nfs_localio: fixes for races and errors from older
 compilers
In-reply-to: <aB-vxtKNKxpPnkz2@kernel.org>
References: <>, <aB-vxtKNKxpPnkz2@kernel.org>
Date: Mon, 19 May 2025 13:49:30 +1000
Message-id: <174762657001.62796.7283949995262534578@noble.neil.brown.name>

On Sun, 11 May 2025, Mike Snitzer wrote:
> On Sat, May 10, 2025 at 12:02:27PM -0400, Chuck Lever wrote:
> > On 5/9/25 11:01 PM, NeilBrown wrote:
> > > On Sat, 10 May 2025, Chuck Lever wrote:
> > >> [ adding Paul McK ]
> > >>
> > >> On 5/8/25 8:46 PM, NeilBrown wrote:
> > >>> This is a revised version a the earlier series.  I've actually tested
> > >>> this time and fixed a few issues including the one that Mike found.
> > >>
> > >> As Mike mentioned in a previous thread, at this point, any fix for this
> > >> issue will need to be applied to recent stable kernels as well. This
> > >> series looks a bit too complicated for that.
> > >>
> > >> I expect that other subsystems will encounter this issue eventually,
> > >> so it would be beneficial to address the root cause. For that purpose,=
 I
> > >> think I like Vincent's proposal the best:
> > >>
> > >> https://lore.kernel.org/linux-nfs/8c67a295-8caa-4e53-a764-f691657bbe62=
@wanadoo.fr/raw
> > >>
> > >> None of this is to say that Neil's patches shouldn't be applied. But
> > >> perhaps these are not a broad solution to the RCU compilation issue.
> > >=20
> > > Do we need a "broad solution to the RCU compilation issue"?
> >=20
> > Fair question. If the current localio code is simply incorrect as it
> > stands, then I suppose the answer is no. Because gcc is happy to compile
> > it in most cases, I thought the problem was with older versions of gcc,
> > not with localio (even though, I agree, the use of an incomplete
> > structure definition is somewhat brittle when used with RCU).
> >=20
> >=20
> > > Does it ever make sense to "dereference" a pointer to a structure that =
is
> > > not fully specified?  What does that even mean?
> > >=20
> > > I find it harder to argue against use of rcu_access_pointer() in that
> > > context, at least for test-against-NULL, but sparse doesn't complain
> > > about a bare test of an __rcu pointer against NULL, so maybe there is no
> > > need for rcu_access_pointer() for simple tests - in which case the
> > > documentation should be updated.
> >=20
> > For backporting purposes, inventing our own local RCU helper to handle
> > the situation might be best. Then going forward, apply your patches to
> > rectify the use of the incomplete structure definition, and the local
> > helper can eventually be removed.
> >=20
> > My interest is getting to a narrow set of changes that can be applied
> > now and backported as needed. The broader clean-ups can then be applied
> > to future kernels (or as subsequent patches in the same merge window).
> >=20
> > My 2 cents, worth every penny.
>=20
> I really would prefer we just use this patch as the stop-gap for 6.14
> and 6.15 (which I have been carrying for nearly a year now because I
> need to support an EL8 platform that uses gcc 8.5):
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/commit/?h=
=3Dkernel-6.12.24/nfs-testing&id=3Df9add5e4c9b4629b102876dce9484e1da3e35d1f
>=20
> Then we work through getting Neil's patchset to land for 6.16 and
> revert the stop-gap (dummy nfsd_file) patch.
>=20
> > > (of course rcu_dereference() doesn't actually dereference the pointer,
> > >  despite its name.  It just declared that there is an imminent intention
> > >  to dereference the pointer.....)
> > >=20
> > > NeilBrown
>=20
> Rather than do a way more crazy stop-gap like this (which actually works):

"works" in what sense?  Presumably that gcc-8 doesn't complain.
sparse doesn't like it at all though.
If you don't care about sparse not being happy, then it would be easier
to just use READ_ONCE and WRITE_ONCE rather than creating the new
_opaque interfaces.

Thanks,
NeilBrown



>=20
>  fs/nfs/localio.c           |  6 +++---
>  fs/nfs_common/nfslocalio.c |  8 +++----
>  include/linux/nfslocalio.h | 52 ++++++++++++++++++++++++++++++++++++++++++=
++++
>  3 files changed, 59 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 73dd07495440..fedc07254c00 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -272,7 +272,7 @@ nfs_local_open_fh(struct nfs_client *clp, const struct =
cred *cred,
> =20
>  	new =3D NULL;
>  	rcu_read_lock();
> -	nf =3D rcu_dereference(*pnf);
> +	nf =3D rcu_dereference_opaque(*pnf);
>  	if (!nf) {
>  		rcu_read_unlock();
>  		new =3D __nfs_local_open_fh(clp, cred, fh, nfl, mode);
> @@ -281,11 +281,11 @@ nfs_local_open_fh(struct nfs_client *clp, const struc=
t cred *cred,
>  		rcu_read_lock();
>  		/* try to swap in the pointer */
>  		spin_lock(&clp->cl_uuid.lock);
> -		nf =3D rcu_dereference_protected(*pnf, 1);
> +		nf =3D rcu_dereference_opaque_protected(*pnf, 1);
>  		if (!nf) {
>  			nf =3D new;
>  			new =3D NULL;
> -			rcu_assign_pointer(*pnf, nf);
> +			rcu_assign_opaque_pointer(*pnf, nf);
>  		}
>  		spin_unlock(&clp->cl_uuid.lock);
>  	}
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 6a0bdea6d644..213862ceb8bb 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -285,14 +285,14 @@ void nfs_close_local_fh(struct nfs_file_localio *nfl)
>  		return;
>  	}
> =20
> -	ro_nf =3D rcu_access_pointer(nfl->ro_file);
> -	rw_nf =3D rcu_access_pointer(nfl->rw_file);
> +	ro_nf =3D rcu_access_opaque(nfl->ro_file);
> +	rw_nf =3D rcu_access_opaque(nfl->rw_file);
>  	if (ro_nf || rw_nf) {
>  		spin_lock(&nfs_uuid->lock);
>  		if (ro_nf)
> -			ro_nf =3D rcu_dereference_protected(xchg(&nfl->ro_file, NULL), 1);
> +			ro_nf =3D rcu_dereference_opaque_protected(xchg(&nfl->ro_file, NULL), 1=
);
>  		if (rw_nf)
> -			rw_nf =3D rcu_dereference_protected(xchg(&nfl->rw_file, NULL), 1);
> +			rw_nf =3D rcu_dereference_opaque_protected(xchg(&nfl->rw_file, NULL), 1=
);
> =20
>  		/* Remove nfl from nfs_uuid->files list */
>  		RCU_INIT_POINTER(nfl->nfs_uuid, NULL);
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index 9aa8a43843d7..c6e86891d4b5 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -15,6 +15,58 @@
>  #include <linux/sunrpc/svcauth.h>
>  #include <linux/nfs.h>
>  #include <net/net_namespace.h>
> +#include <linux/rcupdate.h>
> +
> +/*
> + * RCU methods to allow fs/nfs_common and fs/nfs LOCALIO code to avoid
> + * dereferencing pointer to 'struct nfs_file' which is opaque outside fs/n=
fsd
> +*/
> +#define __rcu_access_opaque_pointer(p, local, space) \
> +({ \
> +	typeof(p) local =3D (__force typeof(p))READ_ONCE(p); \
> +	rcu_check_sparse(p, space); \
> +	(__force __kernel typeof(p))(local); \
> +})
> +
> +#define rcu_access_opaque(p) __rcu_access_opaque_pointer((p), __UNIQUE_ID(=
rcu), __rcu)
> +
> +#define __rcu_dereference_opaque_protected(p, local, c, space) \
> +({ \
> +	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_opaque_protected() usa=
ge"); \
> +	rcu_check_sparse(p, space); \
> +	(__force __kernel typeof(p))(p); \
> +})
> +
> +#define rcu_dereference_opaque_protected(p, c) \
> +	__rcu_dereference_opaque_protected((p), __UNIQUE_ID(rcu), (c), __rcu)
> +
> +#define __rcu_dereference_opaque_check(p, local, c, space) \
> +({ \
> +	/* Dependency order vs. p above. */ \
> +	typeof(p) local =3D (__force typeof(p))READ_ONCE(p); \
> +	RCU_LOCKDEP_WARN(!(c), "suspicious rcu_dereference_opaque_check() usage")=
; \
> +	rcu_check_sparse(p, space); \
> +	(__force __kernel typeof(p))(local); \
> +})
> +
> +#define rcu_dereference_opaque_check(p, c) \
> +	__rcu_dereference_opaque_check((p), __UNIQUE_ID(rcu), \
> +				       (c) || rcu_read_lock_held(), __rcu)
> +
> +#define rcu_dereference_opaque(p) rcu_dereference_opaque_check(p, 0)
> +
> +#define RCU_INITIALIZER_OPAQUE(v) (typeof((v)) __force __rcu)(v)
> +
> +#define rcu_assign_opaque_pointer(p, v)					      \
> +do {									      \
> +	uintptr_t _r_a_p__v =3D (uintptr_t)(v);				      \
> +	rcu_check_sparse(p, __rcu);					      \
> +									      \
> +	if (__builtin_constant_p(v) && (_r_a_p__v) =3D=3D (uintptr_t)NULL)	      \
> +		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
> +	else								      \
> +		smp_store_release(&p, RCU_INITIALIZER_OPAQUE((typeof(p))_r_a_p__v)); \
> +} while (0)
> =20
>  struct nfs_client;
>  struct nfs_file_localio;
>=20


