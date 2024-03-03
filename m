Return-Path: <linux-nfs+bounces-2149-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8159A86F7E9
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 01:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084581F21153
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 00:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4950779B7D;
	Mon,  4 Mar 2024 00:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hLUSZHcm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9wWzWXuI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JWpPAAzj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qsyo+Riv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FBA2E418
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 00:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709510404; cv=none; b=CeLF8ffQqvgEPLObrpjQxPhircl4O5JmANPQ3S0rFtcHerry0y322iDhlI7lwQwsq8XX4xFNjKRr7Ww34jladOKkDsCBAG5LTLvb5shm5sOKeRRuif511UyQjPFlSCaPJFSycQzY1jUr97cDT0ijDHhMgc4S5qNkzf1y/kxQIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709510404; c=relaxed/simple;
	bh=UQOSLLYIWM4fnfaBGM4uKQFvxGwMsl1fktSptjjWzKE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IQW5GuGUxkJvlOp77Ut9rfXSDIIeZkANeSlOcUPjwHMKbCf3p+VBPHJOKR63EWl7esfSo7XtVYFF7WjHpueHqsFFJSC/0ZlGBbt6V7Md7eTpF93tGisnXA4DsiMW1aFMCfMD58jCeISpW419CTJqKfRX32mUPzFabu3DBdFm/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hLUSZHcm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9wWzWXuI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JWpPAAzj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qsyo+Riv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E97104D1FB;
	Sun,  3 Mar 2024 23:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709510400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4K550BskOVbhJUPeKubz9LV+zwYlptfWqSMPfpyEVY=;
	b=hLUSZHcmzJoDruJ2Qr3CJR13jQvZ3bUMh02vH6VET81OYRcu52PpjWgruNW7ZE0dESZT5K
	XelmM6K0SoRN6KOSa5i3FDed0IBdP1Sa1YPARhxgZO10RKDd2EqlVXGm74rZLnQ93zWnOj
	y7nbTBerRmMZSxTzC2pLBHgIeRJj88M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709510400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4K550BskOVbhJUPeKubz9LV+zwYlptfWqSMPfpyEVY=;
	b=9wWzWXuI0Q7C34iVVlv1JeIGC00GBhVuUSeV/eyFJtpCEOfMOlfmzkAwkMiloyiQ4WhCv6
	5HnQ/UYFaedzILBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709510399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4K550BskOVbhJUPeKubz9LV+zwYlptfWqSMPfpyEVY=;
	b=JWpPAAzjBgRcNrhv+CXMDl/Bsy9OdBuWAcyRESfD1ekcXplIKAdZUpjgtINpsPTSSBfzwA
	X3y+BSzXWuqqYLqdHvfECCWYOrmYEDMDdBgsmiKZ5Ilybn3PET8TC60jeQqAKQ5iDavSWX
	AneV6VtdHDJ0jArCWo1G1OkhI/CH2fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709510399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4K550BskOVbhJUPeKubz9LV+zwYlptfWqSMPfpyEVY=;
	b=Qsyo+RivoV7xfsUr/OJZWdB5Ax10h/lj3qYqxxoQAM3RmXzgMBJj3l8VZZ2oQjgegcti1T
	zc+XM8u5d0MjZKAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A36B133F6;
	Sun,  3 Mar 2024 23:59:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aTjmNvwO5WX9dQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 03 Mar 2024 23:59:56 +0000
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
Subject: Re: [PATCH 1/3] nfsd: move nfsd4_cstate_assign_replay() earlier in
 open handling.
In-reply-to: <b2f720cb8993fbf0072a3d02434214c5f3b613fa.camel@kernel.org>
References: <20240301000950.2306-1-neilb@suse.de>,
 <20240301000950.2306-2-neilb@suse.de>,
 <b2f720cb8993fbf0072a3d02434214c5f3b613fa.camel@kernel.org>
Date: Mon, 04 Mar 2024 10:59:53 +1100
Message-id: <170951039351.24797.11983130591432693683@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JWpPAAzj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Qsyo+Riv
X-Spamd-Result: default: False [-1.06 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.75)[84.10%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E97104D1FB
X-Spam-Level: 
X-Spam-Score: -1.06
X-Spam-Flag: NO

On Fri, 01 Mar 2024, Jeff Layton wrote:
> On Fri, 2024-03-01 at 11:07 +1100, NeilBrown wrote:
> > Rather than taking the rp_mutex in nfsd4_cleanup_open_state() (which
> > seems counter-intuitive), take it and assign rp_owner as soon as
> > possible.
> >=20
> > This will support a future change when nfsd4_cstate_assign_replay() might
> > fail.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 7d6c657e0409..e625f738f7b0 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5066,15 +5066,15 @@ nfsd4_process_open1(struct nfsd4_compound_state *=
cstate,
> >  	strhashval =3D ownerstr_hashval(&open->op_owner);
> >  	oo =3D find_openstateowner_str(strhashval, open, clp);
> >  	open->op_openowner =3D oo;
> > -	if (!oo) {
> > +	if (!oo)
> >  		goto new_owner;
> > -	}
> >  	if (!(oo->oo_flags & NFS4_OO_CONFIRMED)) {
> >  		/* Replace unconfirmed owners without checking for replay. */
> >  		release_openowner(oo);
> >  		open->op_openowner =3D NULL;
> >  		goto new_owner;
> >  	}
> > +	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> >  	status =3D nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
> >  	if (status)
> >  		return status;
> > @@ -5084,6 +5084,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cs=
tate,
> >  	if (oo =3D=3D NULL)
> >  		return nfserr_jukebox;
> >  	open->op_openowner =3D oo;
> > +	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> >  alloc_stateid:
> >  	open->op_stp =3D nfs4_alloc_open_stateid(clp);
> >  	if (!open->op_stp)
> > @@ -5835,12 +5836,8 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct=
 svc_fh *current_fh, struct nf
> >  void nfsd4_cleanup_open_state(struct nfsd4_compound_state *cstate,
> >  			      struct nfsd4_open *open)
> >  {
> > -	if (open->op_openowner) {
> > -		struct nfs4_stateowner *so =3D &open->op_openowner->oo_owner;
> > -
> > -		nfsd4_cstate_assign_replay(cstate, so);
> > -		nfs4_put_stateowner(so);
> > -	}
> > +	if (cstate->replay_owner)
> > +		nfs4_put_stateowner(cstate->replay_owner);
>=20
> The above delta doesn't look right. The replay_owner won't be set on
> v4.1+ mounts, but op_openowner will still hold a valid reference that
> will now leak.

Yes, of course.  I was over-thinking and making a mess of it.

Fixed,
thanks.

NeilBrown

>=20
> >  	if (open->op_file)
> >  		kmem_cache_free(file_slab, open->op_file);
> >  	if (open->op_stp)
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20


