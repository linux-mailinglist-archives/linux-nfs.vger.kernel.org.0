Return-Path: <linux-nfs+bounces-20675-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI59NR/l02n/ngcAu9opvQ
	(envelope-from <linux-nfs+bounces-20675-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 18:53:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5916B3A5752
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Apr 2026 18:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42ED93010B92
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Apr 2026 16:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE5A2848A8;
	Mon,  6 Apr 2026 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apW7s+aS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1729A21883E
	for <linux-nfs@vger.kernel.org>; Mon,  6 Apr 2026 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494428; cv=none; b=Adylht8BgivXeY1UMAPR9mpbCP4yOlgWnO5AzF7AlUEBo5FoeMr8nGuS3fiLtspdje3/Gv6wB0rK/Oyr8cZuKsVYpNBj95Bn85JiDPEGct+ucQNlR/y2kI1kQLmTv+O3kiaar5Bngviwmjztxnr5f8MLnkxLUx9NuSEuems1csw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494428; c=relaxed/simple;
	bh=y5q0DvihJbweDYxZSvrODfiBkOfezStNk/bg8g2Mk0E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HbkE8KJeT+msvgwSIbJ/Y4zxzTbSJIx2KevYvkl3BYLZ6OwvjNpMet0+KM4T7ouVJwWRMrfNswP5/SLEvd+e7+DYl4J2ARYhxsJdws6b3X68EOvJAAzy2/SCatRD6K5QTm3J9xbEcVPlxBb+tKw4Dl7BSzz6CZjOPvTBFAF9GIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apW7s+aS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A59C4CEF7;
	Mon,  6 Apr 2026 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775494427;
	bh=y5q0DvihJbweDYxZSvrODfiBkOfezStNk/bg8g2Mk0E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=apW7s+aSdY68+XQxmi6A9V3yQ/itRaou1XAphm0tlZiGUJ2uC8k0lfNG89YqwXV6/
	 pfKpSbS7VRyflRjfe1sFRw2b8XQqgRIkdD/87tue6PGF0meWJZqhARsRL8K5W3i2QV
	 hb9wtXWMQ2kms+MRrb33zUt44yKSeoFqXdfr2DI2afRKr8BB1huoOKID4dezk7hbjG
	 qLeMZL3Jd0Wat6eSr6B/CWCGIB5lNaDTaHaig4SR/ZlssuyIwxS8FaJsFo3y2iLsQ0
	 PbJoVibdXCzrZpJyCUJTypkkan64ceNIstVkLNYKLg/2ea06g+A7GSfuR5fqNWPc3B
	 fHgEoJP+MYn0w==
Message-ID: <0c134e9a9670a30d858b7f28da5b92420fd0ac8f.camel@kernel.org>
Subject: Re: [PATCH 1/1] nfsd: update mtime/ctime on CLONE and COPY in
 presence of delegated attributes
From: Jeff Layton <jlayton@kernel.org>
To: Olga Kornievskaia <aglo@umich.edu>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, 
	linux-nfs@vger.kernel.org, neilb@brown.name, Dai.Ngo@oracle.com,
 tom@talpey.com
Date: Mon, 06 Apr 2026 12:53:44 -0400
In-Reply-To: <CAN-5tyE7yW=27HObj+cfHW-6HJsiGx=m6JbAcfEw+fTA2HXgsA@mail.gmail.com>
References: <20260403165335.73070-1-okorniev@redhat.com>
	 <63fbd05720af891a2f7339be78fea2460beda7a8.camel@kernel.org>
	 <CAN-5tyE7yW=27HObj+cfHW-6HJsiGx=m6JbAcfEw+fTA2HXgsA@mail.gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20675-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5916B3A5752
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-04-06 at 09:59 -0400, Olga Kornievskaia wrote:
> On Fri, Apr 3, 2026 at 1:02=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
> >=20
> > On Fri, 2026-04-03 at 12:53 -0400, Olga Kornievskaia wrote:
> > > When delegated attributes are given on open the file is opened with N=
OCMTIME
> > > and modifying operations do not update mtime/ctime as to not get out-=
of-sync
> > > with the client's delegated view. However, for operations CLONE/COPY =
server
> > > should update its view of mtime/ctime and reflect that in any GETATTR=
 queries.
> > >=20
> > > Fixes: e5e9b24ab8fa ("nfsd: freeze c/mtime updates with outstanding W=
RITE_ATTRS delegation")
> > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > ---
> > >  fs/nfsd/nfs4proc.c | 27 ++++++++++++++++++++++++++-
> > >  1 file changed, 26 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > index 99b44b6ec056..66bde3732b03 100644
> > > --- a/fs/nfsd/nfs4proc.c
> > > +++ b/fs/nfsd/nfs4proc.c
> > > @@ -1396,6 +1396,24 @@ nfsd4_verify_copy(struct svc_rqst *rqstp, stru=
ct nfsd4_compound_state *cstate,
> > >       goto out;
> > >  }
> > >=20
> > > +static bool nfsd4_clear_nocmtime(struct file *f)
> > > +{
> > > +     if ((READ_ONCE(f->f_mode) & FMODE_NOCMTIME) !=3D 0) {
> > > +             spin_lock(&f->f_lock);
> > > +             f->f_mode &=3D ~FMODE_NOCMTIME;
> > > +             spin_unlock(&f->f_lock);
> > > +             return true;
> > > +     }
> > > +     return false;
> > > +}
> > > +
> > > +static void nfsd4_restore_nocmtime(struct file *f)
> > > +{
> > > +     spin_lock(&f->f_lock);
> > > +     f->f_mode |=3D FMODE_NOCMTIME;
> > > +     spin_unlock(&f->f_lock);
> > > +}
> > > +
> > >  static __be32
> > >  nfsd4_clone(struct svc_rqst *rqstp, struct nfsd4_compound_state *cst=
ate,
> > >               union nfsd4_op_u *u)
> > > @@ -1403,16 +1421,19 @@ nfsd4_clone(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
> > >       struct nfsd4_clone *clone =3D &u->clone;
> > >       struct nfsd_file *src, *dst;
> > >       __be32 status;
> > > +     bool restore_nocmtime =3D false;
> > >=20
> > >       status =3D nfsd4_verify_copy(rqstp, cstate, &clone->cl_src_stat=
eid, &src,
> > >                                  &clone->cl_dst_stateid, &dst);
> > >       if (status)
> > >               goto out;
> > >=20
> > > +     restore_nocmtime =3D nfsd4_clear_nocmtime(dst->nf_file);
> > >       status =3D nfsd4_clone_file_range(rqstp, src, clone->cl_src_pos=
,
> > >                       dst, clone->cl_dst_pos, clone->cl_count,
> > >                       EX_ISSYNC(cstate->current_fh.fh_export));
> > > -
> > > +     if (restore_nocmtime)
> > > +             nfsd4_restore_nocmtime(dst->nf_file);
> > >       nfsd_file_put(dst);
> > >       nfsd_file_put(src);
> > >  out:
> > > @@ -2132,6 +2153,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> > >       struct nfsd4_copy *copy =3D &u->copy;
> > >       struct nfsd42_write_res *result;
> > >       __be32 status;
> > > +     bool restore_nocmtime =3D false;
> > >=20
> > >       result =3D &copy->cp_res;
> > >       nfsd_copy_write_verifier((__be32 *)&result->wr_verifier.data, n=
n);
> > > @@ -2157,6 +2179,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> > >               }
> > >       }
> > >=20
> > > +     restore_nocmtime =3D nfsd4_clear_nocmtime(copy->nf_dst->nf_file=
);
> > >       memcpy(&copy->fh, &cstate->current_fh.fh_handle,
> > >               sizeof(struct knfsd_fh));
> > >       if (nfsd4_copy_is_async(copy)) {
> > > @@ -2199,6 +2222,8 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> > >                                      copy->nf_dst->nf_file, true);
> > >       }
> > >  out:
> > > +     if (restore_nocmtime)
> > > +             nfsd4_restore_nocmtime(copy->nf_dst->nf_file);
> > >       trace_nfsd_copy_done(copy, status);
> > >       release_copy_files(copy);
> > >       return status;
> >=20
> > This seems simple enough, but there is some raciness involved if other
> > calls are running concurrently with the COPY/CLONE. You might end up
> > reenabling FMODE_NOCMTIME before a second COPY/CLONE finishes.
> >=20
> > A simpler idea might be to just do a notify_change() for ATTR_MTIME
> > after each COPY or CLONE operation done on a file with FMODE_NOCMTIME
> > set.
> >=20
> > That should set the timestamp to something pretty close to whatever the
> > last write() would have set it to, but without having to monkey with
> > the fmode.
>=20
> Thanks Jeff and Chuck. I've changed the code to use the
> notify_change() but before I send out I have a question regarding
> where you think this notify_change () should take place in case of a
> copy (specifically thinking about async copy vs sync copy). The
> easiest option is to do it (regardless of sync or async) upon
> completion of the COPY compound (ie not at the end of when async copy
> completes). Or for the async copy should it happen upon (successful)
> copy completion?
>=20
>=20

I think you want to do it when the copy completes. If that's sync copy
then you'd stamp it before you send the COPY reply. For async copy, I
think you'd want to do it before sending a CB_OFFLOAD.

--=20
Jeff Layton <jlayton@kernel.org>

