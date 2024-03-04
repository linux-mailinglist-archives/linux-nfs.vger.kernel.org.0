Return-Path: <linux-nfs+bounces-2184-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2F7870E2E
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 22:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03379288CD5
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBA110A35;
	Mon,  4 Mar 2024 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ugYi/XF1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FFDzZ/jZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d+zZOpur";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+p0q42+9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB28F58
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588499; cv=none; b=qEEehCIqzF2lAy04TbEO/YEiI2ibXgS7DlXY/VBVwwZhyAovgiyp7rL34sV9COcHsEjnaPA2FYyTiwCo1mGdbYfhgUJWPNSazt6FcJKxh7v1wMqH5fDS3piwc5sDk6bj8p9dfelVNiH5g8p7/w7gf4EATmoX6TF01z+C9UUBA1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588499; c=relaxed/simple;
	bh=RX01kIB2fyVBwOg2G++lkbhpzL3qUAIsksj5ug7liOM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=K/NIkMHMqfrtv6cOnYUpG3+qRDeOKDDTpDgbZOYeddeiclk3c9CgXANNC7sEtsHY7X0oytUFjakvkLcFA4nkrrOD6WTVaQgOFY2I2OTaH72IPEtXsmzaMkUDN/8EO+UYmdCvMt0lH1FgJDiVZREYU6eJ3l6oYfU/nXVLGKMTw3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ugYi/XF1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FFDzZ/jZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d+zZOpur; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+p0q42+9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DFE41348F6;
	Mon,  4 Mar 2024 21:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709588495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxAP3Dpzrxvfs0Q819+M+gajdKHBJjUC73q0O/tiwQg=;
	b=ugYi/XF1ruK2Q8FS7BCVUE0K8mIAO8HBGDOGdgyfDlqC5sv7571F3N+GzL2nxk110/ngxD
	jtdRY0Gj/LZZRWFNeeCOm9FKUAaHkqfdbypC41D/kfh4tkTV2H5ihsFwVZLdht4TXnXlyE
	MchJg/pW+TGZwic9PJrqZqCyKiwjGow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709588495;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxAP3Dpzrxvfs0Q819+M+gajdKHBJjUC73q0O/tiwQg=;
	b=FFDzZ/jZ+SBLipZpJp5zOoo01D6FZsIXlqtctU4v8rbuLoPxCW9t/UCsggnQtbPgWGnftf
	cuDnQX+cd7Se9UCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709588494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxAP3Dpzrxvfs0Q819+M+gajdKHBJjUC73q0O/tiwQg=;
	b=d+zZOpurzxbN160+IstAuhdp30W4czYWmtCgjSAWelp7wn4sxGR9uiaeoyVnIxBzR0GET6
	db+BsVsNudXyYKHslgtwLkNyrJ8C6XLW3bR44FMRBZ25nj7ExXNxWzH8RobTfRJnsE+1zl
	G2fvYXYJ0aQVipWwrhBgfdteGZgHhG0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709588494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxAP3Dpzrxvfs0Q819+M+gajdKHBJjUC73q0O/tiwQg=;
	b=+p0q42+9uTwPkB2kXZTUVTlt6YonKQO5cxreWhYQioJtuU31VShG0dbcyxTDxl+3r7DD6M
	QwMT6szF53UitRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4803A13A58;
	Mon,  4 Mar 2024 21:41:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PjOxNgtA5mWwUQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 21:41:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 2/4] nfsd: perform all find_openstateowner_str calls in
 the one place.
In-reply-to: <5de242d62709e11a18406981b189c0476b5da5ca.camel@kernel.org>
References: <20240304044304.3657-1-neilb@suse.de>,
 <20240304044304.3657-3-neilb@suse.de>,
 <5de242d62709e11a18406981b189c0476b5da5ca.camel@kernel.org>
Date: Tue, 05 Mar 2024 08:41:26 +1100
Message-id: <170958848677.24797.14503972307018020397@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d+zZOpur;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+p0q42+9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -6.51
X-Rspamd-Queue-Id: DFE41348F6
X-Spam-Flag: NO

On Mon, 04 Mar 2024, Jeff Layton wrote:
> On Mon, 2024-03-04 at 15:40 +1100, NeilBrown wrote:
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
> > index 2f1e465628b1..690d0e697320 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -539,7 +539,7 @@ same_owner_str(struct nfs4_stateowner *sop, struct xd=
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
> > @@ -556,18 +556,6 @@ find_openstateowner_str_locked(unsigned int hashval,=
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
> > @@ -4588,34 +4576,46 @@ nfsd4_find_and_lock_existing_open(struct nfs4_fil=
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
>=20
> The while (1) makes the control flow a little weird here, but the logic
> seems correct.

Would you prefer a goto?  That is more consistent with common patterns.
I'll do that.

>=20
> >  }
> > =20
> >  static struct nfs4_ol_stateid *
> > @@ -5064,28 +5064,15 @@ nfsd4_process_open1(struct nfsd4_compound_state *=
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
>=20
> Nice cleanup overall:
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>

Thanks.
BTW I've moved this to the start of the series - but kept your SoB.
That avoid having one patch add code that the next patch removes.

Thanks,
NeilBrown

>=20


