Return-Path: <linux-nfs+bounces-14995-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59952BBEA37
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Oct 2025 18:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86385189C287
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Oct 2025 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ED12DAFA4;
	Mon,  6 Oct 2025 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHsmHWSo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074762DCC05
	for <linux-nfs@vger.kernel.org>; Mon,  6 Oct 2025 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767813; cv=none; b=biJmMl0T6YJAMD91sYX+KITxa4fsbTgJP8dcFyQ02u0fA5YVBRBeC1gmjw+UVIrTtk5I2Fp/oobMFq4Ixpg8z5md6oMFXCdjdXBy9WlCL3xcS2c2ZJyPtwawQnivJuMA9MwEqzqHQLvFkS7k3jl+nJ+DKep0/c4Vz+f0m4kCgRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767813; c=relaxed/simple;
	bh=UMFyI8HromErmb0EoYJchuwpq3an3ilDVyV1hb7O4hY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=riKx64e4H+Nq9bBQ8JNWOXdwF3B6owVPCTLlGJvswn8O6992NZIfw4n78HCLbL9k87P9N2t+D08sq1iY8xsycAOghlIb8OFxx7U4k1IANlnWQXZdttmCxW7ADmTjR0ak+ojxGo13LFn5y/in6+VGTLJVuuZ74yxQEu5HXaUxNBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHsmHWSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD3AC4CEF5;
	Mon,  6 Oct 2025 16:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759767812;
	bh=UMFyI8HromErmb0EoYJchuwpq3an3ilDVyV1hb7O4hY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=uHsmHWSoqpXvAmnJr+m96IyvytJ6TT91GWCbEC8V2SeEUeP8gbkBHsS6bT3KN/Xt8
	 5043rBySELMfu8OmrdRNf+HWO4VYwo4xND6qV7M7wC1mTuFH/FnNsBjCs6I235DUsw
	 AZvw4kxdC5EBHF3cH7eOf6mhp6yzxQJaoNKpAjssXe0lmB1vgYimKfrLh5uJgHso0V
	 x9cDgtWHOqT2M1vMtKcsjZTXMm90IJ1FMKbngJEYIMnPAOP3rGqVkxm/xRZ5QJEIc1
	 u15DENV8fZku4sYH1wsYou0vttf429MpQd/MyhEneFfhqpU/QJ2PNtDfbKCery68ik
	 IRJpS6jm6kxQQ==
Message-ID: <82407fb0a2536cd9f6772dc8efab6663f9a155c3.camel@kernel.org>
Subject: Re: [PATCH v1] NFSD: Fix crash in nfsd4_read_release()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Chuck Lever <cel@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org, Chuck Lever
 <chuck.lever@oracle.com>
Date: Mon, 06 Oct 2025 12:23:30 -0400
In-Reply-To: <175955965542.1793333.13223432830700758756@noble.neil.brown.name>
References: <20250930140520.2947-1-cel@kernel.org>
	, <175928003792.1696783.17556773248679753110@noble.neil.brown.name>
	, <57b7be9c-dcbb-477d-b453-736fa7ddcfe4@kernel.org>
	, <175947529411.247319.1453292585395648663@noble.neil.brown.name>
	, <2313f8b9-56ae-4b38-a419-1d5ab8582914@kernel.org>
	 <175955965542.1793333.13223432830700758756@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-04 at 16:34 +1000, NeilBrown wrote:
> On Fri, 03 Oct 2025, Chuck Lever wrote:
> > On 10/3/25 3:08 AM, NeilBrown wrote:
> > > On Wed, 01 Oct 2025, Chuck Lever wrote:
> > > > On 9/30/25 8:53 PM, NeilBrown wrote:
> > > > > On Wed, 01 Oct 2025, Chuck Lever wrote:
> > > > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > > >=20
> > > > > > When tracing is enabled, the trace_nfsd_read_done trace point
> > > > > > crashes during the pynfs read.testNoFh test.
> > > > > >=20
> > > > > > Fixes: 87c5942e8fae ("nfsd: Add I/O trace points in the NFSv4 r=
ead proc")
> > > > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > > > ---
> > > > > >  fs/nfsd/nfs4proc.c | 7 ++++---
> > > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > > > index e466cf52d7d7..f9aeefc0da73 100644
> > > > > > --- a/fs/nfsd/nfs4proc.c
> > > > > > +++ b/fs/nfsd/nfs4proc.c
> > > > > > @@ -988,10 +988,11 @@ nfsd4_read(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
> > > > > >  static void
> > > > > >  nfsd4_read_release(union nfsd4_op_u *u)
> > > > > >  {
> > > > > > -	if (u->read.rd_nf)
> > > > > > +	if (u->read.rd_nf) {
> > > > > > +		trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> > > > > > +				     u->read.rd_offset, u->read.rd_length);
> > > > > >  		nfsd_file_put(u->read.rd_nf);
> > > > > > -	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
> > > > > > -			     u->read.rd_offset, u->read.rd_length);
> > > > > > +	}
> > > > > >  }
> > > > >=20
> > > > > I must say this looks a bit weird.  rd_nf isn't used in the trace=
 but if
> > > > > it isn't set, you say the trace crashes...
> > > > >=20
> > > > > That is because rd_fhp being NULL (because there is no current_fh=
) is
> > > > > one thing that results in rd_nf being NULL.  Seems a bit indirect=
.
> > > >=20
> > > > When rd_nf is NULL, no file or file handle is present. That's reall=
y all
> > > > there is to it. You can read it as "when rd_nf is NULL, no processi=
ng is
> > > > needed".
> > > >=20
> > > > The other read trace points are already skipped in this case as wel=
l, so
> > > > there is no need to protect them.
> > >=20
> > > They are skipped because ALLOWED_WITHOUT_FH is not set so ->op_func
> > > isn't called.  But ->op_release *is* called.  That seems inconsistent=
.
> > > I wonder if we could move the ->op_release call out of
> > > nfsd4_encode_operation() and only call it in cases were ->op_func
> > > was called.
> > >=20
> > > Something like the following?  It isn't as elegant as I would have
> > > liked, but I think it is better than hiding the ->op_release cxall in
> > > nfsd4_encode_replay().
> > >=20
> > > Thanks,
> > > NeilBrown
> > >=20
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index 71b428efcbb5..4ed823d1e6be 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -2837,6 +2837,8 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> > > =20
> > >  	trace_nfsd_compound(rqstp, args->tag, args->taglen, args->opcnt);
> > >  	while (!status && resp->opcnt < args->opcnt) {
> > > +		bool called_func =3D false;
> > > +
> >=20
> > Or call it "release_needed" ?
>=20
> That might be a bit better - yes.
>=20
> >=20
> > This change is not something I'd care to have backported into stable
> > kernels... So maybe keep the modification of nfsd4_read_release for
> > backport, and then subsequently do this change too?
>=20
> That seems like a sensible safe approach.
>=20
> >=20
> > I was reminded of a release-related change that Jeff did recently, mayb=
e
> > commit 15a8b55dbb1b ("nfsd: call op_release, even when op_func returns
> > an error")... might be relevant, might not.
>=20
> Definitely relevant.  I think this is the commit to mention in the
> Fixes: tag.  Prior to this commit nfsd4_read_release wouldn't have been
> called if there was no filehandle, so the trace point was perfectly
> safe.
>=20
> I wonder if this fix by Jeff was the best fix for the problem.
> An alternative would be to require ->op_func to release any resources
> before returning an error..... except that wouldn't work for=20
> OP_NONTRIVIAL_ERROR_ENCODE functions like OP_LOCK as the ->op_release
> frees the "deny" info which is needed to encode the reply....
>=20
> But wait ...nfs4_encode_operation - which currently calls ->op_release -
> is also called from nfsd4_enc_sequence_replay().  The status is set to
> an error so ->op_release previously would not have been called, but now
> it is.  Could that mean nfsd4_lock_release() can get called there even
> tough nfsd4_lock wasn't called.  Could that be a problem?  It isn't
> clear to me that is *isn't* a problem, should maybe there is a subtlety
> that saves it.
>=20
> I'm beginning to think that we don't want an op_release at all.
> Anything allocated in ->op_func should either be freed in ->op_func when
> an error is detected, or in the corresponding nfsd4_enc_ops function
> after the allocated value is used for encoding.
>=20
> Looking further...
>  ->op_get_currentstateid is only called immediately before the one time
>  that ->op_func is called.  So ->op_func could do that
>  get_currentstateid work.
>  and ->op_set_currentstateid looks like it could be folded in to
>  ->op_func as well.
>=20
> Does anyone have any thoughts about that?

I think that sounds reasonable. I don't see anything that would
preclude that anyway, at least with a cursory look. All of the
references that get released in the op_release calls are acquired
during op_func, AFAICT.
--=20
Jeff Layton <jlayton@kernel.org>

