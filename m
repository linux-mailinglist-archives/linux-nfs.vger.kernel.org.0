Return-Path: <linux-nfs+bounces-4446-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C55091D447
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 00:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155B0281229
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 22:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C5F46542;
	Sun, 30 Jun 2024 22:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RPp8PhCf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FlpaqHzg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lwqq5Fq5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8Nfbczf2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE78843ABD
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 22:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719784904; cv=none; b=u4jBEbla3ms9Ufhja0V7nZYFOsaIxiXQ+siEpR1KX2MqxcHkJNqvHE8cOwksXNIZgoPaETkwoZgsimfd/GwqzmyMGHIvCPq8z4vsrxzKQn7WPSns4b9rPchz92PtU0xq2vc4qWHKSwY87ZvUILRLPKEuW2LNvyRMhz9XKj1Q8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719784904; c=relaxed/simple;
	bh=fc4q0H4VXcNkWQNjcSStK9LZCS679MtnrT6fTONjj/M=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=t5xIBnxmG3ds6UTwGS3OysSbLVwZ2lqY5ubd3e5lEWi1pKTCrJ+9sAe/rYyMSHortvp2KyctIHQ4huT9bAUGn79ibBIVool2Gbnoqd96z4nUZKDGXgPZ4n4/5VIUfQGTUYp8EZQMbiPGQqC3ZpcEWm5ytg7wvK91DPxyQh+1hvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RPp8PhCf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FlpaqHzg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lwqq5Fq5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8Nfbczf2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D35DF1F891;
	Sun, 30 Jun 2024 22:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719784901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ov4nnDHWSRU3iMw9mzEhNbtexaO8O5MC72aBAHlMzOk=;
	b=RPp8PhCf3VPLWWgC0WS5V0CfE+FYjzW+63opz5IdLpSo6spp0JZa7DukzzXLcELW7con0w
	TTmaQYLykaCBttDevvi/c7yiZQQi3m9bYM4/53QMc2N/mzjR4vFJfJrj1sUNDi6youReZP
	8od/7jKaU18yVOIP1A3m0S3doLqNjtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719784901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ov4nnDHWSRU3iMw9mzEhNbtexaO8O5MC72aBAHlMzOk=;
	b=FlpaqHzgh55lTMxeC8JOINFhEIXShwBm5gdC85NOD31S00V0CXlSpFae+hXkH2uTZLa8Zn
	uMYn8B6W7yphfPCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719784900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ov4nnDHWSRU3iMw9mzEhNbtexaO8O5MC72aBAHlMzOk=;
	b=lwqq5Fq5V8D+u5g09ZjKgTo0zSJUmLswN6nSsqbVZWFVu4zHZJWGkHt4eWN9VwA/tvwylM
	gVLZd11GKGSTrp9PNuRZ4njm3gZ8CNyR45e67urzDumLbFLX/AYIiEP0bpq4TrFyHLVRZm
	ElCy6HWPZqrA6ijp2sCK5R5Czi259iE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719784900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ov4nnDHWSRU3iMw9mzEhNbtexaO8O5MC72aBAHlMzOk=;
	b=8Nfbczf2soeALBPJUri8MJy9t5Q8upC0IHYeu8BO5KpdGx0rYFPgT8LEQztP1OrVaDk504
	wyol3CdTNA0IQOCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D168F13A7F;
	Sun, 30 Jun 2024 22:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lu5JHcHVgWYhaQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 30 Jun 2024 22:01:37 +0000
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
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v9 07/19] nfs/localio: fix nfs_localio_vfs_getattr() to
 properly support v4
In-reply-to: <ZoAtT4M3jCIF8pIC@tissot.1015granger.net>
References: <>, <ZoAtT4M3jCIF8pIC@tissot.1015granger.net>
Date: Mon, 01 Jul 2024 08:01:30 +1000
Message-id: <171978489020.16071.9497041442174299803@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On Sun, 30 Jun 2024, Chuck Lever wrote:
> On Fri, Jun 28, 2024 at 05:10:53PM -0400, Mike Snitzer wrote:
> > This is nfs-localio code which blurs the boundary between server and
> > client...
> >=20
> > The change_attr is used by NFS to detect if a file might have changed.
> > This code is used to get the attributes after a write request.  NFS
> > uses a GETATTR request to the server at other times.  The change_attr
> > should be consistent between the two else comparisons will be
> > meaningless.
> >=20
> > So nfs_localio_vfs_getattr() should use the same change_attr as the
> > one that would be used if the NFS GETATTR request were made.  For
> > NFSv3, that is nfs_timespec_to_change_attr() as was already
> > implemented.  For NFSv4 it is something different (as implemented in
> > this commit).
> >=20
> > [above header derived from linux-nfs message Neil sent on this topic]
>=20
> Instead of this note, I recommend:
>=20
> Message-Id: <171918165963.14261.959545364150864599@noble.neil.brown.name>

Linus would not be impressed.  He likes links that you can click on and
follow.
So
   Link: https://lore.kernel.org/171918165963.14261.959545364150864599@noble.=
neil.brown.name

is preferred (at least I think that is the current state of the
conversation

see https://lore.kernel.org/all/CAHk-=3DwiD9du3fBHuLYzwUSdNgY+hxMZEWNZpqJXy-=
=3DwD2wafdg@mail.gmail.com/

NeilBrown

>=20
>=20
> > Suggested-by: NeilBrown <neil@brown.name>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfs/localio.c | 48 +++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 39 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> > index 0f7d6d55087b..fe96f05ba8ca 100644
> > --- a/fs/nfs/localio.c
> > +++ b/fs/nfs/localio.c
> > @@ -364,21 +364,47 @@ nfs_set_local_verifier(struct inode *inode,
> >  	verf->committed =3D how;
> >  }
> > =20
> > +/* Factored out from fs/nfsd/vfs.h:fh_getattr() */
> > +static int __vfs_getattr(struct path *p, struct kstat *stat, int version)
> > +{
> > +	u32 request_mask =3D STATX_BASIC_STATS;
> > +
> > +	if (version =3D=3D 4)
> > +		request_mask |=3D (STATX_BTIME | STATX_CHANGE_COOKIE);
> > +	return vfs_getattr(p, stat, request_mask, AT_STATX_SYNC_AS_STAT);
> > +}
> > +
> > +/*
> > + * Copied from fs/nfsd/nfsfh.c:nfsd4_change_attribute(),
> > + * FIXME: factor out to common code.
> > + */
> > +static u64 __nfsd4_change_attribute(const struct kstat *stat,
> > +				    const struct inode *inode)
> > +{
> > +	u64 chattr;
> > +
> > +	if (stat->result_mask & STATX_CHANGE_COOKIE) {
> > +		chattr =3D stat->change_cookie;
> > +		if (S_ISREG(inode->i_mode) &&
> > +		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
> > +			chattr +=3D (u64)stat->ctime.tv_sec << 30;
> > +			chattr +=3D stat->ctime.tv_nsec;
> > +		}
> > +	} else {
> > +		chattr =3D time_to_chattr(&stat->ctime);
> > +	}
> > +	return chattr;
> > +}
> > +
> >  static void nfs_local_vfs_getattr(struct nfs_local_kiocb *iocb)
> >  {
> >  	struct kstat stat;
> >  	struct file *filp =3D iocb->kiocb.ki_filp;
> >  	struct nfs_pgio_header *hdr =3D iocb->hdr;
> >  	struct nfs_fattr *fattr =3D hdr->res.fattr;
> > +	int version =3D NFS_PROTO(hdr->inode)->version;
> > =20
> > -	if (unlikely(!fattr) || vfs_getattr(&filp->f_path, &stat,
> > -					    STATX_INO |
> > -					    STATX_ATIME |
> > -					    STATX_MTIME |
> > -					    STATX_CTIME |
> > -					    STATX_SIZE |
> > -					    STATX_BLOCKS,
> > -					    AT_STATX_SYNC_AS_STAT))
> > +	if (unlikely(!fattr) || __vfs_getattr(&filp->f_path, &stat, version))
> >  		return;
> > =20
> >  	fattr->valid =3D (NFS_ATTR_FATTR_FILEID |
> > @@ -394,7 +420,11 @@ static void nfs_local_vfs_getattr(struct nfs_local_k=
iocb *iocb)
> >  	fattr->atime =3D stat.atime;
> >  	fattr->mtime =3D stat.mtime;
> >  	fattr->ctime =3D stat.ctime;
> > -	fattr->change_attr =3D nfs_timespec_to_change_attr(&fattr->ctime);
> > +	if (version =3D=3D 4) {
> > +		fattr->change_attr =3D
> > +			__nfsd4_change_attribute(&stat, file_inode(filp));
> > +	} else
> > +		fattr->change_attr =3D nfs_timespec_to_change_attr(&fattr->ctime);
> >  	fattr->du.nfs3.used =3D stat.blocks << 9;
> >  }
> > =20
> > --=20
> > 2.44.0
> >=20
>=20
> --=20
> Chuck Lever
>=20


