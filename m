Return-Path: <linux-nfs+bounces-13809-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE3EB2E880
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Aug 2025 01:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA21B5E1583
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Aug 2025 23:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ACC2DAFDB;
	Wed, 20 Aug 2025 23:15:21 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D886136CE0E
	for <linux-nfs@vger.kernel.org>; Wed, 20 Aug 2025 23:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731721; cv=none; b=G1dAD5uC4U92bm/07jhfuUrKZjtcS4rpOQi0j3qMNRkqz4eCjwor8gI8ur8yCE5VWoXsVGtzRe9l5X0rUTTTdH8lt8aWy98FKH8vR1oeeu41aCtqFC1sSLu03AU0TkHCypve+qnMHv+JCKEElpPFma0ar7hqlkdDL/EDGWdV7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731721; c=relaxed/simple;
	bh=BSR8VTUGKC8LiEdjFQZVVg4MtSChgByewnYhsVFhOx8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=OMKTbbWhljhknf4n7F+XbfvUWL08TRNuZGLvI1OVfsJRtjp6CrYpJSKn1qwhaoRGLpgzqdUYKOqJ2x3ivCnTpMlnV2BRzsmO/SaBeoUec4a6PyCWzjebG8j2C7Xt16idGp/L0Ki8gcCZ2BOcLUAYs463AfvrvRoleRZh+DBB1TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uos1N-006W0Z-D4;
	Wed, 20 Aug 2025 23:15:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Olga Kornievskaia" <aglo@umich.edu>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>, chuck.lever@oracle.com,
 jlayton@kernel.org, linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com,
 tom@talpey.com
Subject: Re: [PATCH v2 2/2] lockd: while grace prefer to fail with
 nlm_lck_denied_grace_period
In-reply-to:
 <CAN-5tyEammkfv3QGwe5Z38q1nFAxYV=REFDN++3XrX7Lni+H0A@mail.gmail.com>
References:
 <>, <CAN-5tyEammkfv3QGwe5Z38q1nFAxYV=REFDN++3XrX7Lni+H0A@mail.gmail.com>
Date: Thu, 21 Aug 2025 09:15:10 +1000
Message-id: <175573171079.2234665.16260718612520667514@noble.neil.brown.name>

On Thu, 14 Aug 2025, Olga Kornievskaia wrote:
> On Tue, Aug 12, 2025 at 8:05=E2=80=AFPM NeilBrown <neil@brown.name> wrote:
> >
> > On Wed, 13 Aug 2025, Olga Kornievskaia wrote:
> > > When nfsd is in grace and receives an NLM LOCK request which turns
> > > out to have a conflicting delegation, return that the server is in
> > > grace.
> > >
> > > Reviewed-by: Jeff Layton <jlayton@redhat.com>
> > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > ---
> > >  fs/lockd/svc4proc.c | 15 +++++++++++++--
> > >  1 file changed, 13 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > > index 109e5caae8c7..7ac4af5c9875 100644
> > > --- a/fs/lockd/svc4proc.c
> > > +++ b/fs/lockd/svc4proc.c
> > > @@ -141,8 +141,19 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct=
 nlm_res *resp)
> > >       resp->cookie =3D argp->cookie;
> > >
> > >       /* Obtain client and file */
> > > -     if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &=
file)))
> > > -             return resp->status =3D=3D nlm_drop_reply ? rpc_drop_repl=
y :rpc_success;
> > > +     resp->status =3D nlm4svc_retrieve_args(rqstp, argp, &host, &file);
> > > +     switch (resp->status) {
> > > +     case 0:
> > > +             break;
> > > +     case nlm_drop_reply:
> > > +             if (locks_in_grace(SVC_NET(rqstp))) {
> > > +                     resp->status =3D nlm_lck_denied_grace_period;
> >
> > I think this is wrong.  If the lock request has the "reclaim" flag set,
> > then nlm_lck_denied_grace_period is not a meaningful error.
> > nlm4svc_retrieve_args() returns nlm_drop_reply when there is a delay
> > getting a response to an upcall to mountd.  For NLM the request really
> > must be dropped.
>=20
> Thank you for pointing out this case so we are suggesting to.
>=20
> if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim)
>=20
> However, I've been looking and looking but I cannot figure out how
> nlm4svc_retrieve_args() would ever get nlm_drop_reply. You say it can
> happen during the upcall to mountd. So that happens within nfsd_open()
> call and a part of fh_verify().
> To return nlm_drop_reply, nlm_fopen() must have gotten nfserr_dropit
> from the nfsd_open().  I have searched and searched but I don't see
> anything that ever sets nfserr_dropit (NFSERR_DROPIT).
>=20
> I searched the logs and nfserr_dropit was an error that was EAGAIN
> translated into but then removed by the following patch.

Oh.  I didn't know that.
We now use RQ_DROPME instead.
I guess we should remove NFSERR_DROPIT completely as it not used at all
any more.

Though returning nfserr_jukebox to an v2 client isn't a good idea....

So I guess my main complaint isn't valid, but I still don't like this
patch.  It seems an untidy place to put the locks_in_grace test.
Other callers of nlm4svc_retrieve_args() check locks_in_grace() before
making that call.  __nlm4svc_proc_lock probably should too.  Or is there
a reason that it is delayed until the middle of nlmsvc_lock()..

The patch is not needed and isn't clearly an improvement, so I would
rather it were dropped.

Thanks,
NeilBrown


>=20
> commit 062304a815fe10068c478a4a3f28cf091c55cb82
> Author: J. Bruce Fields <bfields@fieldses.org>
> Date:   Sun Jan 2 22:05:33 2011 -0500
>=20
>     nfsd: stop translating EAGAIN to nfserr_dropit
>=20
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index dc9c2e3fd1b8..fd608a27a8d5 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -735,7 +735,8 @@ nfserrno (int errno)
>                 { nfserr_stale, -ESTALE },
>                 { nfserr_jukebox, -ETIMEDOUT },
>                 { nfserr_jukebox, -ERESTARTSYS },
> -               { nfserr_dropit, -EAGAIN },
> +               { nfserr_jukebox, -EAGAIN },
> +               { nfserr_jukebox, -EWOULDBLOCK },
>                 { nfserr_jukebox, -ENOMEM },
>                 { nfserr_badname, -ESRCH },
>                 { nfserr_io, -ETXTBSY },
>=20
> so if fh_verify is failing whatever it is returning, it is not
> nfserr_dropit nor is it nfserr_jukebox which means nlm_fopen() would
> translate it to nlm_failed which with my patch would not trigger
> nlm_lck_denied_grace_period error but resp->status would be set to
> nlm_failed.
>=20
> So I circle back to I hope that convinces you that we don't need a
> check for the reclaim lock.
>=20
> I believe nlm_drop_reply is nfsd_open's jukebox error, one of which is
> delegation recall. it can be a memory failure. But I'm sure when
> EWOULDBLOCK occurs.
>=20
> > At the very least we need to guard against the reclaim flag being set in
> > the above test.  But I would much rather a more clear distinction were
> > made between "drop because of a conflicting delegation" and "drop
> > because of a delay getting upcall response".
> > Maybe a new "nlm_conflicting_delegtion" return from ->fopen which nlm4
> > (and ideally nlm2) handles appropriately.
>=20
>=20
> > NeilBrown
> >
> >
> > > +                     return rpc_success;
> > > +             }
> > > +             return nlm_drop_reply;
> > > +     default:
> > > +             return rpc_success;
> > > +     }
> > >
> > >       /* Now try to lock the file */
> > >       resp->status =3D nlmsvc_lock(rqstp, file, host, &argp->lock,
> > > --
> > > 2.47.1
> > >
> > >
> >
> >
>=20


