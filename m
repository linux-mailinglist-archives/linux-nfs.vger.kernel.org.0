Return-Path: <linux-nfs+bounces-5268-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF49C94C699
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Aug 2024 00:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EF51C20C7A
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Aug 2024 22:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317CA3398E;
	Thu,  8 Aug 2024 22:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D+4ibFWu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wGVnuhaP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D+4ibFWu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wGVnuhaP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93952AE91
	for <linux-nfs@vger.kernel.org>; Thu,  8 Aug 2024 22:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154419; cv=none; b=kfXEmbFl0VA1vqB2iqpGg970G+jh0MvQAMszOODaljc3rcMsOwAA18U4lhLoTdQYTTQKvFPRmfh4UWAPmVX/k45GU4/6OjImfnLJgSvsRl8i41hv3ZubMJBvUE7ius2ap3dp1lWsaXrrYsG1wZrqWkv9Gw9H/4BYGuvxJK8OTVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154419; c=relaxed/simple;
	bh=kXG8zsa+2WWZV+zpG2dKXDq5+V3NbjUz+IJDUCrArI8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=TE4KAtAFm+LUMzt0wIRx48N/m1IHalCC4vv3na3H85/hvScpF+HnuEq4Iz4MgZCADpZ9ZbKKDZjILvVB42FG8In/YSUp/IjyOXCIgTnd5ktg/buYoM7MXQWRvV3g1Oly+1ifhar1VoUH9gzxQSymIflRyc6Yehali4nI8gVmCxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D+4ibFWu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wGVnuhaP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D+4ibFWu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wGVnuhaP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BEA111FE42;
	Thu,  8 Aug 2024 22:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723154414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avpbxG2UpNrWbgNEVLucJCYsfIVOklOaKt8sI9mTwUE=;
	b=D+4ibFWuQyYp1xT1u6Zo0Jint1ItjSH/ZYaqFJmlqf/YnQFB0VhSIxO3WGxLng/Cq/Maur
	+Ki4F1sckFbPTgrwc1cfZbPY+XtuyxNk44+Dydh/Hd21KR8QUg9NJL1Fy64B2GFDpc5cnH
	mr60atUIokjTxTp6xg9v2O73U8jKsyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723154414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avpbxG2UpNrWbgNEVLucJCYsfIVOklOaKt8sI9mTwUE=;
	b=wGVnuhaP57HjxHzZH09pahInehi/UJYI2/bshIZXmBkAKU8ijx33VtJEk0KNusyO6R4UIq
	AJOzbnq1pQyKl4Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1723154414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avpbxG2UpNrWbgNEVLucJCYsfIVOklOaKt8sI9mTwUE=;
	b=D+4ibFWuQyYp1xT1u6Zo0Jint1ItjSH/ZYaqFJmlqf/YnQFB0VhSIxO3WGxLng/Cq/Maur
	+Ki4F1sckFbPTgrwc1cfZbPY+XtuyxNk44+Dydh/Hd21KR8QUg9NJL1Fy64B2GFDpc5cnH
	mr60atUIokjTxTp6xg9v2O73U8jKsyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1723154414;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avpbxG2UpNrWbgNEVLucJCYsfIVOklOaKt8sI9mTwUE=;
	b=wGVnuhaP57HjxHzZH09pahInehi/UJYI2/bshIZXmBkAKU8ijx33VtJEk0KNusyO6R4UIq
	AJOzbnq1pQyKl4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F9BE136A2;
	Thu,  8 Aug 2024 22:00:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QDS2Bew/tWYTBgAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 08 Aug 2024 22:00:12 +0000
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
Subject: Re: [PATCH 3/3] nfsd: move error choice for incorrect object types to
 version-specific code.
In-reply-to: <2f37c577c26c69f23345153576b2e1270115d63d.camel@kernel.org>
References: <>, <2f37c577c26c69f23345153576b2e1270115d63d.camel@kernel.org>
Date: Fri, 09 Aug 2024 08:00:08 +1000
Message-id: <172315440855.6062.9482773808089698009@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 08 Aug 2024, Jeff Layton wrote:
> On Thu, 2024-08-08 at 21:40 +1000, NeilBrown wrote:
> > On Thu, 08 Aug 2024, Jeff Layton wrote:
> > > On Mon, 2024-07-29 at 11:47 +1000, NeilBrown wrote:
> > > > If an NFS operation expect a particular sort of object (file, dir, li=
nk,
> > > > etc) but gets a file handle for a different sort of object, it must
> > > > return an error.  The actual error varies among version in no-trivial
> > > > ways.
> > > >=20
> > > > For v2 and v3 there are ISDIR and NOTDIR errors, and for any else, on=
ly
> > > > INVAL is suitable.
> > > >=20
> > > > For v4.0 there is also NFS4ERR_SYMLINK which should be used if a SYML=
INK
> > > > was found when not expected.  This take precedence over NOTDIR.
> > > >=20
> > > > For v4.1+ there is also NFS4ERR_WRONG_TYPE which should be used in
> > > > preference to EINVAL when none of the specific error codes apply.
> > > >=20
> > > > When nfsd_mode_check() finds a symlink where it expect a directory it
> > > > needs to return an error code that can be converted to NOTDIR for v2 =
or
> > > > v3 but will be SYMLINK for v4.  It must be different from the error
> > > > code returns when it finds a symlink but expects a regular file - that
> > > > must be converted to EINVAL or SYMLINK.
> > > >=20
> > > > So we introduce an internal error code nfserr_symlink_not_dir which e=
ach
> > > > version converts as appropriate.
> > > >=20
> > > > We also allow nfserr_wrong_type to be returned by
> > > > nfsd_check_obj_is_reg() in nfsv4 code) and nfsd_mode_check().  This a
> > > > behavioural change as nfsd_check_obj_is_reg() would previously return
> > > > nfserr_symiink for non-directory objects that aren't regular files.  =
Now
> > > > it will return nfserr_wrong_type for objects that aren't regular,
> > > > directory, symlink (so char-special, block-special, sockets), which is
> > > > mapped to nfserr_inval for NFSv4.0.  This should not be a problem as =
the
> > > > behaviour is supported by RFCs.
> > > >=20
> > > > As a result of these changes, nfsd_mode_check() doesn't need an rqstp
> > > > arg any more.
> > > >=20
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > >  fs/nfsd/nfs3proc.c |  8 ++++++++
> > > >  fs/nfsd/nfs4proc.c | 24 ++++++++++++++++--------
> > > >  fs/nfsd/nfsd.h     |  5 +++++
> > > >  fs/nfsd/nfsfh.c    | 16 +++++++---------
> > > >  fs/nfsd/nfsproc.c  |  7 +++++++
> > > >  5 files changed, 43 insertions(+), 17 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> > > > index 31bd9bcf8687..ac7ee24415a3 100644
> > > > --- a/fs/nfsd/nfs3proc.c
> > > > +++ b/fs/nfsd/nfs3proc.c
> > > > @@ -38,6 +38,14 @@ static __be32 map_status(__be32 status)
> > > >  	case nfserr_file_open:
> > > >  		status =3D nfserr_acces;
> > > >  		break;
> > > > +
> > > > +	case nfserr_symlink_not_dir:
> > > > +		status =3D nfserr_notdir;
> > > > +		break;
> > > > +	case nfserr_symlink:
> > > > +	case nfserr_wrong_type:
> > > > +		status =3D nfserr_inval;
> > > > +		break;
> > > >  	}
> > > >  	return status;
> > > >  }
> > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > index 46bd20fe5c0f..cc715438e77a 100644
> > > > --- a/fs/nfsd/nfs4proc.c
> > > > +++ b/fs/nfsd/nfs4proc.c
> > > > @@ -166,14 +166,9 @@ static __be32 nfsd_check_obj_isreg(struct svc_fh=
 *fh)
> > > >  		return nfs_ok;
> > > >  	if (S_ISDIR(mode))
> > > >  		return nfserr_isdir;
> > > > -	/*
> > > > -	 * Using err_symlink as our catch-all case may look odd; but
> > > > -	 * there's no other obvious error for this case in 4.0, and we
> > > > -	 * happen to know that it will cause the linux v4 client to do
> > > > -	 * the right thing on attempts to open something other than a
> > > > -	 * regular file.
> > > > -	 */
> > > > -	return nfserr_symlink;
> > > > +	if (S_ISLNK(mode))
> > > > +		return nfserr_symlink;
> > > > +	return nfserr_wrong_type;
> > > >  }
> > > > =20
> > > >  static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_s=
tate *cstate, struct nfsd4_open *open, struct svc_fh *resfh)
> > > > @@ -184,6 +179,17 @@ static void nfsd4_set_open_owner_reply_cache(str=
uct nfsd4_compound_state *cstate
> > > >  			&resfh->fh_handle);
> > > >  }
> > > > =20
> > > > +static __be32 map_status(__be32 status, int minor)
> > > > +{
> > > > +	if (status =3D=3D nfserr_wrong_type &&
> > > > +	    minor =3D=3D 0)
> > > > +		/* RFC5661 - 15.1.2.9 */
> > > > +		status =3D nfserr_inval;
> > > > +
> > > > +	if (status =3D=3D nfserr_symlink_not_dir)
> > > > +		status =3D nfserr_symlink;
> > > > +	return status;
> > > > +}
> > > >  static inline bool nfsd4_create_is_exclusive(int createmode)
> > > >  {
> > > >  	return createmode =3D=3D NFS4_CREATE_EXCLUSIVE ||
> > > > @@ -2798,6 +2804,8 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> > > >  			nfsd4_encode_replay(resp->xdr, op);
> > > >  			status =3D op->status =3D op->replay->rp_status;
> > > >  		} else {
> > > > +			op->status =3D map_status(op->status,
> > > > +						cstate->minorversion);
> > > >  			nfsd4_encode_operation(resp, op);
> > > >  			status =3D op->status;
> > > >  		}
> > > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > > index 593c34fd325a..3c8c8da063b0 100644
> > > > --- a/fs/nfsd/nfsd.h
> > > > +++ b/fs/nfsd/nfsd.h
> > > > @@ -349,6 +349,11 @@ enum {
> > > >  	NFSERR_REPLAY_CACHE,
> > > >  #define	nfserr_replay_cache	cpu_to_be32(NFSERR_REPLAY_CACHE)
> > > > =20
> > > > +/* symlink found where dir expected - handled differently to
> > > > + * other symlink found errors by NFSv3.
> > > > + */
> > > > +	NFSERR_SYMLINK_NOT_DIR,
> > > > +#define	nfserr_symlink_not_dir	cpu_to_be32(NFSERR_SYMLINK_NOT_DIR)
> > > >  };
> > > > =20
> > > >  /* Check for dir entries '.' and '..' */
> > > > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > > > index 0130103833e5..8cd70f93827c 100644
> > > > --- a/fs/nfsd/nfsfh.c
> > > > +++ b/fs/nfsd/nfsfh.c
> > > > @@ -62,8 +62,7 @@ static int nfsd_acceptable(void *expv, struct dentr=
y *dentry)
> > > >   * the write call).
> > > >   */
> > > >  static inline __be32
> > > > -nfsd_mode_check(struct svc_rqst *rqstp, struct dentry *dentry,
> > > > -		umode_t requested)
> > > > +nfsd_mode_check(struct dentry *dentry, umode_t requested)
> > > >  {
> > > >  	umode_t mode =3D d_inode(dentry)->i_mode & S_IFMT;
> > > > =20
> > > > @@ -76,17 +75,16 @@ nfsd_mode_check(struct svc_rqst *rqstp, struct de=
ntry *dentry,
> > > >  		}
> > > >  		return nfs_ok;
> > > >  	}
> > > > -	/*
> > > > -	 * v4 has an error more specific than err_notdir which we should
> > > > -	 * return in preference to err_notdir:
> > > > -	 */
> > > > -	if (rqstp->rq_vers =3D=3D 4 && mode =3D=3D S_IFLNK)
> > > > +	if (mode =3D=3D S_IFLNK) {
> > > > +		if (requested =3D=3D S_IFDIR)
> > > > +			return nfserr_symlink_not_dir;
> > > >  		return nfserr_symlink;
> > > > +	}
> > > >  	if (requested =3D=3D S_IFDIR)
> > > >  		return nfserr_notdir;
> > > >  	if (mode =3D=3D S_IFDIR)
> > > >  		return nfserr_isdir;
> > > > -	return nfserr_inval;
> > > > +	return nfserr_wrong_type;
> > > >  }
> > > > =20
> > > >  static bool nfsd_originating_port_ok(struct svc_rqst *rqstp, int fla=
gs)
> > > > @@ -362,7 +360,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *=
fhp, umode_t type, int access)
> > > >  	if (error)
> > > >  		goto out;
> > > > =20
> > > > -	error =3D nfsd_mode_check(rqstp, dentry, type);
> > > > +	error =3D nfsd_mode_check(dentry, type);
> > > >  	if (error)
> > > >  		goto out;
> > > > =20
> > > > diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> > > > index cb7099c6dc78..3d65ab558091 100644
> > > > --- a/fs/nfsd/nfsproc.c
> > > > +++ b/fs/nfsd/nfsproc.c
> > > > @@ -25,6 +25,13 @@ static __be32 map_status(__be32 status)
> > > >  	case nfserr_file_open:
> > > >  		status =3D nfserr_acces;
> > > >  		break;
> > > > +	case nfserr_symlink_not_dir:
> > > > +		status =3D nfserr_notdir;
> > > > +		break;
> > > > +	case nfserr_symlink:
> > > > +	case nfserr_wrong_type:
> > > > +		status =3D nfserr_inval;
> > > > +		break;
> > > >  	}
> > > >  	return status;
> > > >  }
> > >=20
> > > Hi Neil,
> > >=20
> > > I'm seeing a set of failures in pynfs with this patch (json results
> > > attached). I haven't looked in detail yet, but we should probably drop
> > > this one for now.
> >=20
> > Most of the complaints are because pynfs is expecting the incorrect
> > error code that nfsd currently returns, rather than the correct one that
> > my patch makes it return.
> >=20
> > There is one where the internal error code of 10101 leaks out.  That is
> > NFSERR_SYMLNK_NOT_DIR.
> > That certainly requires investigation.
> >=20
>=20
> I'm not sure these error code changes are correct, now that I look. For
> instance:
>=20
>         {
>             "classname": "st_readlink",
>             "code": "RDLK2r",
>             "failure": {
>                 "err": "Traceback (most recent call last):\n  File \"/data/=
pynfs/nfs4.0/lib/testmod.py\", line 234, in run\n    self.runtest(self, envir=
onment)\n  File \"/data/pynfs/nfs4.0/servertests/st_readlink.py\", line 29, i=
n testFile\n    check(res, NFS4ERR_INVAL, \"READLINK on non-symlink objects\"=
)\n  File \"/data/pynfs/nfs4.0/servertests/environment.py\", line 270, in che=
ck\n    raise testmod.FailureException(msg)\ntestmod.FailureException: READLI=
NK on non-symlink objects should return NFS4ERR_INVAL, instead got NFS4ERR_WR=
ONG_TYPE\n",
>                 "message": "READLINK on non-symlink objects should return N=
FS4ERR_INVAL, instead got NFS4ERR_WRONG_TYPE"
>             },
>             "name": "testFile",
>             "time": "0.003440380096435547"
>         },
>=20
>=20
> Looking at RFC7530, the READLINK section (16.25.5) says:
>=20
>    The READLINK operation is only allowed on objects of type NF4LNK.
>    The server should return the error NFS4ERR_INVAL if the object is not
>    of type NF4LNK.

RFC7530 is for NFSv4.0 It doesn't have NFS4ERR_WRONG_TYPE.  So if this
is a 4.0 test then that is indeed a bug.  If the "nfs4.0" in the File
path the only hit that this was 4.0 rather than 4.1?
(RFC8881 declares this should be NFS4ERR_WRONG_TYPE for 4.1)

>=20
> Several OPEN cases have errors similar to this one:
>=20
>         {
>             "classname": "st_open",
>             "code": "OPEN7s",
>             "failure": {
>                 "err": "Traceback (most recent call last):\n  File \"/data/=
pynfs/nfs4.0/lib/testmod.py\", line 234, in run\n    self.runtest(self, envir=
onment)\n  File \"/data/pynfs/nfs4.0/servertests/st_open.py\", line 183, in t=
estSocket\n    check(res, NFS4ERR_SYMLINK, \"Trying to OPEN socket\")\n  File=
 \"/data/pynfs/nfs4.0/servertests/environment.py\", line 270, in check\n    r=
aise testmod.FailureException(msg)\ntestmod.FailureException: Trying to OPEN =
socket should return NFS4ERR_SYMLINK, instead got NFS4ERR_INVAL\n",
>                 "message": "Trying to OPEN socket should return NFS4ERR_SYM=
LINK, instead got NFS4ERR_INVAL"
>             },
>             "name": "testSocket",
>             "time": "0.006421566009521484"
>         },
>=20
> RFC7530, 16.16.6:
>=20
>    If the component provided to OPEN resolves to something other than a
>    regular file (or a named attribute), an error will be returned to the
>    client.  If it is a directory, NFS4ERR_ISDIR is returned; otherwise,
>    NFS4ERR_SYMLINK is returned.  Note that NFS4ERR_SYMLINK is returned
>    for both symlinks and for special files of other types; NFS4ERR_INVAL
>    would be inappropriate, since the arguments provided by the client
>    were correct, and the client cannot necessarily know at the time it
>    sent the OPEN that the component would resolve to a non-regular file.

Ahhh - thanks.  The comments in the code seemed to suggest that the RFC
wasn't specific.  I guess I misread them.

Thanks for the more careful analysis.  I'll aim to have an update on
Monday.

NeilBrown


>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20


