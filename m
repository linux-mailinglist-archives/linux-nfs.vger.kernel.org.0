Return-Path: <linux-nfs+bounces-7405-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE2E9AD6EF
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 23:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5EC1F25C0F
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 21:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D08E137775;
	Wed, 23 Oct 2024 21:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZlL//Rn1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vdBwkw4/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="znpxW7KM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kH9nU0TT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2703C22615
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720047; cv=none; b=HJrimzjfI1E6ULVnSPrr5NYdgfB4Qfs4jU9ytxlY/lgyRLs8SSsQGih3tHO5qamj/143VQuSuR6AGKU4dEBnRAhK1luyvy6FNish9ICqz5TKGtrZoZe6Q+XW4HHmT38hmLx4jLwaLey5IIVixNQJtodELsLgZkr3dUL+gxJBGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720047; c=relaxed/simple;
	bh=RKp0dv2fcCBJJ/cL1QzSyUUzR9V+2njhTKWCe3quSNo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LC9atIGV205aJvtTyYkX1vwxQA2IicHc8rT21kJBy/m4ahbYqM68dCOVus+MAb4Mvx4uTmpQiYEfrGTCPyEsjLgwCO/43XhjTUUNa1oXTwVf9g+s8+q5soHAs1+jTh1iP16T53Yrx3t+FNI2yepvplGvSvUCHcjcEWVo4uHzXLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZlL//Rn1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vdBwkw4/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=znpxW7KM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kH9nU0TT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43CD821CB1;
	Wed, 23 Oct 2024 21:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729720043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0CUnGcpRYwJUwbyVSmfpYvqn2ZQJMCv4sh6xJkr4wQ=;
	b=ZlL//Rn1l3VtBKcyYE3VISdHktBYFsurqIftY9x9u0wPhkGqmcTZ/pky46GEE6DtqFstN0
	e1UWVwirbFg9OdVG/WuKaNeSzRPzx/8fttoRAOItgabODph9WbEu8bQA5ISWnbAzV9m2/m
	dCAhN3i/6BG5LsU9Fv9zPNbSEgwVAtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729720043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0CUnGcpRYwJUwbyVSmfpYvqn2ZQJMCv4sh6xJkr4wQ=;
	b=vdBwkw4/tDNcYi+Qr3ikI3Fg+8zWtBRbxMKBPeHcwmqwahy5mRJ92BeoFLzU/16kdnmeFx
	LS+GAunT/rw6u1Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729720042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0CUnGcpRYwJUwbyVSmfpYvqn2ZQJMCv4sh6xJkr4wQ=;
	b=znpxW7KMloaFhTNDF5NVPXbXFbJyXY/pwMlaIK1VoEck7LLk4lFjL1vlvo2LDmSk07fmlO
	F+OTDnc4zl8Oevxw2SJT8VWZZ7crvj+YWsVgTUjo9hxk6HUfo2gKH+pCFq57gRrVyLvZdO
	GBkOkIW7998eIFhASIyZqI7bTMZ2DaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729720042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0CUnGcpRYwJUwbyVSmfpYvqn2ZQJMCv4sh6xJkr4wQ=;
	b=kH9nU0TT3uKfHjZOJoWPc4t18FOkXAwN0S/XKEgJqFswMHc36wr3K8EPlM/33BD7Gs5fuC
	OYisPYX7p74LPmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 203A613A63;
	Wed, 23 Oct 2024 21:47:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2+1zMeduGWe2EQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 23 Oct 2024 21:47:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 2/6] nfsd: return hard failure for OP_SETCLIENTID when
 there are too many clients.
In-reply-to: <Zxj9T5hn0ouG38s6@tissot.1015granger.net>
References: <>, <Zxj9T5hn0ouG38s6@tissot.1015granger.net>
Date: Thu, 24 Oct 2024 08:47:17 +1100
Message-id: <172972003715.81717.2798110861190194927@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,noble.neil.brown.name:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Thu, 24 Oct 2024, Chuck Lever wrote:
> On Wed, Oct 23, 2024 at 01:37:02PM +1100, NeilBrown wrote:
> > If there are more non-courteous clients than the calculated limit, we
> > should fail the request rather than report a soft failure and
> > encouraging the client to retry indefinitely.
>=20
> Discussion:
>=20
> This change has the potential to cause behavior regressions. I'm not
> sure how clients will behave (eg, what error is reported to
> administrators) if EXCH_ID / SETCLIENTID returns SERVERFAULT.

Linux client will issues a pr_warn() and return EIO for mount.
If lease recovery is needed (e.g.  server boot) then I think the client
will retry indefinitely.  There isn't much else it can do.

>=20
> I can't find a more suitable status code than SERVERFAULT, however.

Maybe we should never fail.  Always allow at least 1 slot ??

>=20
> There is also the question of whether CREATE_SESSION, which also
> might fail when server resources are over-extended, could return a
> similar hard failure. (CREATE_SESSION has other spec-mandated
> restrictions around using NFS4ERR_DELAY, however).

Would that only be in the case of kmalloc() failure?  I think that is a
significantly different circumstance.  kmalloc() for small values never
fails in practice (citation needed).  Caches get cleans and pages are
written to swap and big processes are killed until something can be
freed.

This contrasts with that code in exchange_id which tries to guess an
amount of memory that shouldn't put too much burden on the server and so
should always be safe to allocate without risking OOM killing.

>=20
>=20
> > The only hard failure allowed for EXCHANGE_ID that doesn't clearly have
> > some other meaning is NFS4ERR_SERVERFAULT.  So use that, but explain why
> > in a comment at each place that it is returned.
> >=20
> > If there are courteous clients which push us over the limit, then expedite
> > their removal.
> >=20
> > This is not known to have caused a problem is production use, but
>=20
> The current DELAY behavior is known to trigger an (interruptible)
> infinite loop when a small-memory server can't create a new session.
> Thus I believe the infinite loop behavior is a real issue that has
> been observed and reported.

I knew it had been observed with test code.  I didn't know it had be
reported for a genuine use-case.

>=20
>=20
> > testing of lots of clients reports repeated NFS4ERR_DELAY responses
> > which doesn't seem helpful.
>=20
> No argument from me. NFSD takes the current approach for exactly the
> reason you mention above: there isn't a good choice of status code
> to return in this case.
>=20
> Nit: the description might better explain how this change is related
> to or required by on-demand thread allocation. It seems a little
> orthogonal to me right now. NBD.

Yes, it is a bit of a tangent.  It might be seen as prep for the next
patch, but maybe it is completely independent..

Thanks,
NeilBrown


>=20
>=20
> > Also remove an outdated comment - we do use a slab cache.
> >=20
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 30 ++++++++++++++++++++----------
> >  1 file changed, 20 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 56b261608af4..ca6b5b52f77d 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2212,21 +2212,20 @@ STALE_CLIENTID(clientid_t *clid, struct nfsd_net =
*nn)
> >  	return 1;
> >  }
> > =20
> > -/*=20
> > - * XXX Should we use a slab cache ?
> > - * This type of memory management is somewhat inefficient, but we use it
> > - * anyway since SETCLIENTID is not a common operation.
> > - */
> >  static struct nfs4_client *alloc_client(struct xdr_netobj name,
> >  				struct nfsd_net *nn)
> >  {
> >  	struct nfs4_client *clp;
> >  	int i;
> > =20
> > -	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients) {
> > +	if (atomic_read(&nn->nfs4_client_count) -
> > +	    atomic_read(&nn->nfsd_courtesy_clients) >=3D nn->nfs4_max_clients)
> > +		return ERR_PTR(-EUSERS);
> > +
> > +	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients &&
> > +	    atomic_read(&nn->nfsd_courtesy_clients) > 0)
> >  		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> > -		return NULL;
> > -	}
> > +
> >  	clp =3D kmem_cache_zalloc(client_slab, GFP_KERNEL);
> >  	if (clp =3D=3D NULL)
> >  		return NULL;
> > @@ -3121,8 +3120,8 @@ static struct nfs4_client *create_client(struct xdr=
_netobj name,
> >  	struct dentry *dentries[ARRAY_SIZE(client_files)];
> > =20
> >  	clp =3D alloc_client(name, nn);
> > -	if (clp =3D=3D NULL)
> > -		return NULL;
> > +	if (IS_ERR_OR_NULL(clp))
> > +		return clp;
> > =20
> >  	ret =3D copy_cred(&clp->cl_cred, &rqstp->rq_cred);
> >  	if (ret) {
> > @@ -3504,6 +3503,11 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
> >  	new =3D create_client(exid->clname, rqstp, &verf);
> >  	if (new =3D=3D NULL)
> >  		return nfserr_jukebox;
> > +	if (IS_ERR(new))
> > +		/* Protocol has no specific error for "client limit reached".
> > +		 * NFS4ERR_RESOURCE is not permitted for EXCHANGE_ID
> > +		 */
> > +		return nfserr_serverfault;
> >  	status =3D copy_impl_id(new, exid);
> >  	if (status)
> >  		goto out_nolock;
> > @@ -4422,6 +4426,12 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
> >  	new =3D create_client(clname, rqstp, &clverifier);
> >  	if (new =3D=3D NULL)
> >  		return nfserr_jukebox;
> > +	if (IS_ERR(new))
> > +		/* Protocol has no specific error for "client limit reached".
> > +		 * NFS4ERR_RESOURCE, while allowed for SETCLIENTID, implies
> > +		 * that a smaller COMPOUND might be successful.
> > +		 */
> > +		return nfserr_serverfault;
> >  	spin_lock(&nn->client_lock);
> >  	conf =3D find_confirmed_client_by_name(&clname, nn);
> >  	if (conf && client_has_state(conf)) {
> > --=20
> > 2.46.0
> >=20
>=20
> --=20
> Chuck Lever
>=20


