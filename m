Return-Path: <linux-nfs+bounces-2250-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 593618778B6
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Mar 2024 23:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2843DB20A3F
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Mar 2024 22:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF823BB23;
	Sun, 10 Mar 2024 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nQLxbNOg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SPCX2ogt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nQLxbNOg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SPCX2ogt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C73B2A1
	for <linux-nfs@vger.kernel.org>; Sun, 10 Mar 2024 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710108823; cv=none; b=qjEjAovBWMumVImtCA+4Vse8kaefdbjvSAdmkWCc10rbio2M+aEbl3qy3638f6SHo9359nA0RwLmXPgx5D9QNYA/e9XPg3Ap89xiw92/F8xg0G69zBlN2DmMgyODhxELta9lLPBs+IYlLlDTdcimn9MLOOdAt9+2uRTcfZBZgTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710108823; c=relaxed/simple;
	bh=Mkb3s7r7Fd1EsjC6FnL5nj5sK7mE/yBFHBVxuiG71Ec=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=MXIxjSGb22IZk/g/4qXXjHw1/hcpPxGmbG0Ny0o5pqBkKNf+FzLFWLTFSpfOOPxkoUHZTulig8VN0QYwv9F9jMe4WUcXxl0k80UCuKI98G5JJCenrPndq93K/b/T17ZsAyYCMZCWIlpMPLttZsFjxiOl98FSbyfn9P10MBY41Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nQLxbNOg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SPCX2ogt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nQLxbNOg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SPCX2ogt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B13F4344E6;
	Sun, 10 Mar 2024 22:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710108819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6H3jovtB50LbUYT7FVgaNmIlgt8/bwuq3bnX6llRvJk=;
	b=nQLxbNOgbn9+FLKU6KimCWiO8E/lTM0MQ+ymfSx1njVVL8hUF2Bv4kw+UUBip0PQ20XB4y
	DYe6+FyyRsv5TkIoCW/V/+a+GsdSliR9KAmXj//tRv0ISA0Jt/CbZi6rEJehGsFG7oA4Ed
	fzmmyOpA5sMAReK3Y1n/HDiBM/Y0vVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710108819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6H3jovtB50LbUYT7FVgaNmIlgt8/bwuq3bnX6llRvJk=;
	b=SPCX2ogtruUlvvVdBB7MG+YfOxAlJOHbq1Z3hgZktxnwedtpofv9oE4kYB5IajO0dzqLb6
	4ywW4SNOIC2LkgDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710108819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6H3jovtB50LbUYT7FVgaNmIlgt8/bwuq3bnX6llRvJk=;
	b=nQLxbNOgbn9+FLKU6KimCWiO8E/lTM0MQ+ymfSx1njVVL8hUF2Bv4kw+UUBip0PQ20XB4y
	DYe6+FyyRsv5TkIoCW/V/+a+GsdSliR9KAmXj//tRv0ISA0Jt/CbZi6rEJehGsFG7oA4Ed
	fzmmyOpA5sMAReK3Y1n/HDiBM/Y0vVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710108819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6H3jovtB50LbUYT7FVgaNmIlgt8/bwuq3bnX6llRvJk=;
	b=SPCX2ogtruUlvvVdBB7MG+YfOxAlJOHbq1Z3hgZktxnwedtpofv9oE4kYB5IajO0dzqLb6
	4ywW4SNOIC2LkgDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1AC5E134AB;
	Sun, 10 Mar 2024 22:13:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qdMiLJAw7mWzSQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 10 Mar 2024 22:13:36 +0000
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
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 2/4] nfsd: perform all find_openstateowner_str calls in
 the one place.
In-reply-to: <Zeyw5c3WO-OjinBE@manet.1015granger.net>
References: <20240304224714.10370-1-neilb@suse.de>,
 <20240304224714.10370-3-neilb@suse.de>,
 <Zeyw5c3WO-OjinBE@manet.1015granger.net>
Date: Mon, 11 Mar 2024 09:13:33 +1100
Message-id: <171010881340.13576.4048275134557370137@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Sun, 10 Mar 2024, Chuck Lever wrote:
> On Tue, Mar 05, 2024 at 09:45:22AM +1100, NeilBrown wrote:
> > Currently find_openstateowner_str looks are done both in
> > nfsd4_process_open1() and alloc_init_open_stateowner() - the latter
> > possibly being a surprise based on its name.
> >=20
> > It would be easier to follow, and more conformant to common patterns, if
> > the lookup was all in the one place.
> >=20
> > So replace alloc_init_open_stateowner() with
> > find_or_alloc_open_stateowner() and use the latter in
> > nfsd4_process_open1() without any calls to find_openstateowner_str().
> >=20
> > This means all finds are find_openstateowner_str_locked() and
> > find_openstateowner_str() is no longer needed.  So discard
> > find_openstateowner_str() and rename find_openstateowner_str_locked() to
> > find_openstateowner_str().
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 93 +++++++++++++++++++--------------------------
> >  1 file changed, 40 insertions(+), 53 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index b9b3a2601675..0c1058e8cc4b 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -541,7 +541,7 @@ same_owner_str(struct nfs4_stateowner *sop, struct xd=
r_netobj *owner)
> >  }
> > =20
> >  static struct nfs4_openowner *
> > -find_openstateowner_str_locked(unsigned int hashval, struct nfsd4_open *=
open,
> > +find_openstateowner_str(unsigned int hashval, struct nfsd4_open *open,
> >  			struct nfs4_client *clp)
> >  {
> >  	struct nfs4_stateowner *so;
> > @@ -558,18 +558,6 @@ find_openstateowner_str_locked(unsigned int hashval,=
 struct nfsd4_open *open,
> >  	return NULL;
> >  }
> > =20
> > -static struct nfs4_openowner *
> > -find_openstateowner_str(unsigned int hashval, struct nfsd4_open *open,
> > -			struct nfs4_client *clp)
> > -{
> > -	struct nfs4_openowner *oo;
> > -
> > -	spin_lock(&clp->cl_lock);
> > -	oo =3D find_openstateowner_str_locked(hashval, open, clp);
> > -	spin_unlock(&clp->cl_lock);
> > -	return oo;
> > -}
> > -
> >  static inline u32
> >  opaque_hashval(const void *ptr, int nbytes)
> >  {
> > @@ -4855,34 +4843,46 @@ nfsd4_find_and_lock_existing_open(struct nfs4_fil=
e *fp, struct nfsd4_open *open)
> >  }
> > =20
> >  static struct nfs4_openowner *
> > -alloc_init_open_stateowner(unsigned int strhashval, struct nfsd4_open *o=
pen,
> > -			   struct nfsd4_compound_state *cstate)
> > +find_or_alloc_open_stateowner(unsigned int strhashval, struct nfsd4_open=
 *open,
> > +			      struct nfsd4_compound_state *cstate)
> >  {
> >  	struct nfs4_client *clp =3D cstate->clp;
> > -	struct nfs4_openowner *oo, *ret;
> > +	struct nfs4_openowner *oo, *new =3D NULL;
> > =20
> > -	oo =3D alloc_stateowner(openowner_slab, &open->op_owner, clp);
> > -	if (!oo)
> > -		return NULL;
> > -	oo->oo_owner.so_ops =3D &openowner_ops;
> > -	oo->oo_owner.so_is_open_owner =3D 1;
> > -	oo->oo_owner.so_seqid =3D open->op_seqid;
> > -	oo->oo_flags =3D 0;
> > -	if (nfsd4_has_session(cstate))
> > -		oo->oo_flags |=3D NFS4_OO_CONFIRMED;
> > -	oo->oo_time =3D 0;
> > -	oo->oo_last_closed_stid =3D NULL;
> > -	INIT_LIST_HEAD(&oo->oo_close_lru);
> > -	spin_lock(&clp->cl_lock);
> > -	ret =3D find_openstateowner_str_locked(strhashval, open, clp);
> > -	if (ret =3D=3D NULL) {
> > -		hash_openowner(oo, clp, strhashval);
> > -		ret =3D oo;
> > -	} else
> > -		nfs4_free_stateowner(&oo->oo_owner);
> > +	while (1) {
> > +		spin_lock(&clp->cl_lock);
> > +		oo =3D find_openstateowner_str(strhashval, open, clp);
> > +		if (oo && !(oo->oo_flags & NFS4_OO_CONFIRMED)) {
> > +			/* Replace unconfirmed owners without checking for replay. */
> > +			release_openowner(oo);
> > +			oo =3D NULL;
> > +		}
> > +		if (oo) {
> > +			spin_unlock(&clp->cl_lock);
> > +			if (new)
> > +				nfs4_free_stateowner(&new->oo_owner);
> > +			return oo;
> > +		}
> > +		if (new) {
> > +			hash_openowner(new, clp, strhashval);
> > +			spin_unlock(&clp->cl_lock);
> > +			return new;
> > +		}
> > +		spin_unlock(&clp->cl_lock);
> > =20
> > -	spin_unlock(&clp->cl_lock);
> > -	return ret;
> > +		new =3D alloc_stateowner(openowner_slab, &open->op_owner, clp);
> > +		if (!new)
> > +			return NULL;
> > +		new->oo_owner.so_ops =3D &openowner_ops;
> > +		new->oo_owner.so_is_open_owner =3D 1;
> > +		new->oo_owner.so_seqid =3D open->op_seqid;
> > +		new->oo_flags =3D 0;
> > +		if (nfsd4_has_session(cstate))
> > +			new->oo_flags |=3D NFS4_OO_CONFIRMED;
> > +		new->oo_time =3D 0;
> > +		new->oo_last_closed_stid =3D NULL;
> > +		INIT_LIST_HEAD(&new->oo_close_lru);
> > +	}
> >  }
> > =20
> >  static struct nfs4_ol_stateid *
> > @@ -5331,28 +5331,15 @@ nfsd4_process_open1(struct nfsd4_compound_state *=
cstate,
> >  	clp =3D cstate->clp;
> > =20
> >  	strhashval =3D ownerstr_hashval(&open->op_owner);
> > -	oo =3D find_openstateowner_str(strhashval, open, clp);
> > +	oo =3D find_or_alloc_open_stateowner(strhashval, open, cstate);
> >  	open->op_openowner =3D oo;
> >  	if (!oo)
> > -		goto new_owner;
> > -	if (!(oo->oo_flags & NFS4_OO_CONFIRMED)) {
> > -		/* Replace unconfirmed owners without checking for replay. */
> > -		release_openowner(oo);
> > -		open->op_openowner =3D NULL;
> > -		goto new_owner;
> > -	}
> > +		return nfserr_jukebox;
> >  	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> >  	status =3D nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
> >  	if (status)
> >  		return status;
> > -	goto alloc_stateid;
> > -new_owner:
> > -	oo =3D alloc_init_open_stateowner(strhashval, open, cstate);
> > -	if (oo =3D=3D NULL)
> > -		return nfserr_jukebox;
> > -	open->op_openowner =3D oo;
> > -	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> > -alloc_stateid:
> > +
> >  	open->op_stp =3D nfs4_alloc_open_stateid(clp);
> >  	if (!open->op_stp)
> >  		return nfserr_jukebox;
> > --=20
> > 2.43.0
> >=20
>=20
> While running the NFSv4.0 pynfs tests with KASAN and lock debugging
> enabled, I get a number of CPU soft lockup warnings on the test
> server and then it wedges hard. I bisected to this patch.

Almost certainly this is the problem Dan Carpenter found and reported.

>=20
> Because we are just a day shy of the v6.9 merge window, I'm going to
> drop these four patches for v6.9. We can try them again for v6.10.

I'll post a revised version of this patch - it shouldn't affect the
subsequent patches (though I can resend them to if/when you want).

Up to you when it lands of course.

NeilBrown


