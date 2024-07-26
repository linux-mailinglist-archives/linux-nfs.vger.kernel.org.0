Return-Path: <linux-nfs+bounces-5082-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F36393DA99
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jul 2024 00:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE3E1C2248E
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 22:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C32B13C9C8;
	Fri, 26 Jul 2024 22:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Pj5ejX7i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YhVWnwtf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mDQoOSV7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JsuADpMI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C622138DEE
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722031643; cv=none; b=c00BAUTtzgGxeUsYDr/I4usWOIK5yJ4K404P6nL5NWuEQmIsmgTRAKjbUAHZajTXAtPsyuuMFghkwk0ERunbpn8bM0l2PLdBlQuqbZz5TNTZP7WIO+aZxUe/4HKNCbVsMHg6FajU+0+oxANE83biNLW33i2BT6pL1V3zRhfpgv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722031643; c=relaxed/simple;
	bh=GzowPDg4k3ky4eCPBf5K5NGhTlRcpjsZkUbJg86gHJI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=GeDzpITZ+u2jNoCv3LQsxXaEBrK0caUQya3A2HkctbqCL6/gnNCzw553G8Zvtaxy+gTvZ7Cjl4ljjwfuhArSjb37SUhw+O6wHl416U5XkaMK+xK2MrW6Q4K9Yzzjo6JdeFEsr0Y5V2QpQacb1//ooqpFU3rnP2TL/krnfl3lG3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Pj5ejX7i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YhVWnwtf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mDQoOSV7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JsuADpMI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D17D91F74C;
	Fri, 26 Jul 2024 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722031639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=if4qag14HD7hMJoLW/dVwmC+RN4D6ToX7VA3jvUeW/Q=;
	b=Pj5ejX7iF38vR0avOu5A8reAMry2LDzEbKz9+azS3G5s3a+Zetx60aNrKQumsE6Oh2L8u1
	5wHHxSoImiZ57cQKUwDJSPtvHNi1BVA4PXg8MFELtDzA8NPgneEcahudEMgpXomCKMp0cf
	J5x1KVu+R8VDq2qqnxcF2Ryhw8ke6HQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722031639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=if4qag14HD7hMJoLW/dVwmC+RN4D6ToX7VA3jvUeW/Q=;
	b=YhVWnwtfsOtKu9oewR+WloWQCjd3wYk1N40FVi4x+3OlgdG1n7mJvn6v1502F4rnrgsan7
	fVXOL1B6rqE/a4Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mDQoOSV7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JsuADpMI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722031638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=if4qag14HD7hMJoLW/dVwmC+RN4D6ToX7VA3jvUeW/Q=;
	b=mDQoOSV7/dnhbbiM0nfoG5CDFxMXz8AoZeih2wPQhMKSAGwRKJ89va+iVUgr7+rnYKDlIc
	ZNDslL2Yj2uD9cpwVm87iyhqVmtPhJww4U+dUivIEQ25PN4w1Sdb9cFD8yzIBEtaaPzGjh
	JDfI+lbMGcbJDy58hfPBqT/tV/ptB54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722031638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=if4qag14HD7hMJoLW/dVwmC+RN4D6ToX7VA3jvUeW/Q=;
	b=JsuADpMIQ1p3igFObcZyDMcTJGqr5UNs1SuurvFWm32AX2p2Zcky3ZKn5x5PEicdv8SwiF
	KqhTJlvoomIvA9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B55AB1396E;
	Fri, 26 Jul 2024 22:07:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dKhiGhQepGaOEAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 26 Jul 2024 22:07:16 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject:
 Re: [PATCH 3/6] nfsd: Move error code mapping to per-version xdr code.
In-reply-to: <ZqPDW/dgEHKBGAUp@tissot.1015granger.net>
References: <>, <ZqPDW/dgEHKBGAUp@tissot.1015granger.net>
Date: Sat, 27 Jul 2024 08:07:12 +1000
Message-id: <172203163250.18529.11813729769952524563@noble.neil.brown.name>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.31 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -1.31
X-Rspamd-Queue-Id: D17D91F74C

On Sat, 27 Jul 2024, Chuck Lever wrote:
> On Thu, Jul 25, 2024 at 10:21:32PM -0400, NeilBrown wrote:
> > There is code scatter around nfsd which chooses an error status based on
> > the particular version of nfs being used.  It is cleaner to have the
> > version specific choices in version specific code.
> >=20
> > With this patch common code returns the most specific error code
> > possible and the version specific code maps that if necessary.
>=20
> I applaud the top-level goal of this patch. There are some details
> that I'm not comfortable with. (And I've already applied the other
> patches in this series; nice work).
>=20
>=20
> > One complication is that the NFSv4 code NFS4ERR_SYMLINK might be used
> > where v3 expects NFSERR_NOTDIR of NFSERR_INVAL.  To handle this we
> > introduce an internal error code NFSERR_SYMLINK_NOT_DIR and convert that
> > as appropriate for all versions.
>=20
> IMO this patch is trying to do too much at once, both from a review
> standpoint and also in terms of bisectability.
>=20
> Can you break it up so that the SYMLINK-related changes are
> separated from, eg, the xdev and other changes which are somewhat
> less controversial?

Yes, I can break it up as you suggest - makes sense.

>=20
> More specific comments below.
>=20
>=20

> > diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> > index a7a07470c1f8..8d75759c600d 100644
> > --- a/fs/nfsd/nfs3xdr.c
> > +++ b/fs/nfsd/nfs3xdr.c
> > @@ -111,6 +111,23 @@ svcxdr_encode_nfsstat3(struct xdr_stream *xdr, __be3=
2 status)
> >  {
> >  	__be32 *p;
> > =20
> > +	switch (status) {
> > +	case nfserr_symlink_not_dir:
> > +		status =3D nfserr_notdir;
> > +		break;
> > +	case nfserr_symlink:
> > +	case nfserr_wrong_type:
> > +		status =3D nfserr_inval;
> > +		break;
> > +	case nfserr_nofilehandle:
> > +		status =3D nfserr_badhandle;
> > +		break;
> > +	case nfserr_wrongsec:
> > +	case nfserr_file_open:
> > +		status =3D nfserr_acces;
> > +		break;
> > +	}
> > +
>=20
> This is entirely the wrong place for this logic. It is specific to
> symlinks, and it is not XDR layer functionality. I prefer to see
> this moved to the proc functions that need it.

The logic in not specific to symlinks.  It is specific to RPC procedures
which act on things that are not expected to be symlinks.  There are
lots of procedures like that.

We could put the mapping in each .pc_func function, or between the
proc->pc_func() call in nfsd_dispatch() and the following
proc->pc_encode() call, or in each .pc_encode call.

Putting it in each .pc_func would mean changing the "return status;" at
the end of each nfs3_proc_* function to "return map_status(status);"

Putting it between ->pc_func() and ->pc_encode() would mean defining a
new ->pc_map_status() for each program/version and calling that.

Putting it in each .pc_encode is what I did.

It isn't clear to me that either of the first two are better than the
third, but neither are terrible.  However the second wouldn't work for
NFSv4.0 mapping (as individual ops need to be mapped).  But v4.0 needs
special handling anyway.

Where would you prefer I put it?

>=20
> The layering here is that XDR should handle only data serialization.
> Transformations like this go upstairs in the proc layer. I know NFSD
> doesn't always adhere to this layering model, very often out of
> convenience, but I want new code to try to stick to a stricter
> layering model.
>=20
> Again, the reason for this is that eventually much of the existing
> XDR code will be replaced by machine-generated code. Adding bespoke
> bits of logic here makes the task of converting this code more
> difficult.

I suspect it we won't be able to avoid the machine generated code
occasionally calling bespoke code - but we won't know until we try.

> > =20
> >  /* error codes for internal use */
> > +enum {
> > +	NFSERR_DROPIT =3D NFS4ERR_FIRST_FREE,
> >  /* if a request fails due to kmalloc failure, it gets dropped.
> >   *  Client should resend eventually
> >   */
> > -#define	nfserr_dropit		cpu_to_be32(30000)
> > +#define	nfserr_dropit		cpu_to_be32(NFSERR_DROPIT)
> > +
> >  /* end-of-file indicator in readdir */
> > -#define	nfserr_eof		cpu_to_be32(30001)
> > +	NFSERR_EOF,
> > +#define	nfserr_eof		cpu_to_be32(NFSERR_EOF)
> > +
> >  /* replay detected */
> > -#define	nfserr_replay_me	cpu_to_be32(11001)
> > +	NFSERR_REPLAY_ME,
> > +#define	nfserr_replay_me	cpu_to_be32(NFSERR_REPLAY_ME)
> > +
> >  /* nfs41 replay detected */
> > -#define	nfserr_replay_cache	cpu_to_be32(11002)
> > +	NFSERR_REPLAY_CACHE,
> > +#define	nfserr_replay_cache	cpu_to_be32(NFSERR_REPLAY_CACHE)
> > +
> > +/* symlink found where dir expected - handled differently to
> > + * other symlink found errors by NSv3.
>=20
> ^NSv3^NFSv3
>=20

Thanks.

>=20
> > + */
> > +	NFSERR_SYMLINK_NOT_DIR,
> > +#define	nfserr_symlink_not_dir	cpu_to_be32(NFSERR_SYMLINK_NOT_DIR)
> > +};
>=20
> It's confusing to me that we're using the same naming scheme for
> symbolic status codes defined by spec and the ones defined for
> internal use only. It would be nice to rename these, say, with an
> _INT_ or _INTL_ in their name somewhere.

Well the spec say v4 statuses start NFS4ERR_ but we don't follow that.
It isn't clear to me that disambiguation the name would help.  At the
point where the error is returned the important thing is what the error
means, that that is spelt out in the text after nfserr_*.  At the point
where the error is interpreted the meaning is obvious in the code.
From the perspective of NFSv2, nfserr_xdev is an internal error code.
From the perspective of NFSv3 it is not.  Should it have 'int'?]

But if you really want this and you can tell me exactly where you want
the INT or INTL (and presumably int or intl for the be32 version) I'll do it.

>=20
> A short comment that explains why these /internal/ error codes need
> big-endian versions would be helpful to add. I assume it's because
> they will be stored or returned via a __be32 result that actually
> does sometimes carry an on-the-wire status code.

Yes exactly.  I'll add some text like that.

Thanks,
NeilBrown

>=20
> As a note about patch series organization, it would be helpful to
> split this hunk into a separate, preceding patch, IMO.
>=20
>=20
> >  /* Check for dir entries '.' and '..' */
> >  #define isdotent(n, l)	(l < 3 && n[0] =3D=3D '.' && (l =3D=3D 1 || n[1] =
=3D=3D '.'))
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index a485d630d10e..8fb56e2f896c 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -62,8 +62,7 @@ static int nfsd_acceptable(void *expv, struct dentry *d=
entry)
> >   * the write call).
> >   */
> >  static inline __be32
> > -nfsd_mode_check(struct svc_rqst *rqstp, struct dentry *dentry,
> > -		umode_t requested)
> > +nfsd_mode_check(struct dentry *dentry, umode_t requested)
> >  {
> >  	umode_t mode =3D d_inode(dentry)->i_mode & S_IFMT;
> > =20
> > @@ -76,17 +75,16 @@ nfsd_mode_check(struct svc_rqst *rqstp, struct dentry=
 *dentry,
> >  		}
> >  		return nfs_ok;
> >  	}
> > -	/*
> > -	 * v4 has an error more specific than err_notdir which we should
> > -	 * return in preference to err_notdir:
> > -	 */
> > -	if (rqstp->rq_vers =3D=3D 4 && mode =3D=3D S_IFLNK)
> > +	if (mode =3D=3D S_IFLNK) {
> > +		if (requested =3D=3D S_IFDIR)
> > +			return nfserr_symlink_not_dir;
> >  		return nfserr_symlink;
> > +	}
> >  	if (requested =3D=3D S_IFDIR)
> >  		return nfserr_notdir;
> >  	if (mode =3D=3D S_IFDIR)
> >  		return nfserr_isdir;
> > -	return nfserr_inval;
> > +	return nfserr_wrong_type;
> >  }
> > =20
> >  static bool nfsd_originating_port_ok(struct svc_rqst *rqstp, int flags)
> > @@ -162,10 +160,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rq=
stp, struct svc_fh *fhp)
> >  	int len;
> >  	__be32 error;
> > =20
> > -	error =3D nfserr_stale;
> > -	if (rqstp->rq_vers > 2)
> > -		error =3D nfserr_badhandle;
> > -	if (rqstp->rq_vers =3D=3D 4 && fh->fh_size =3D=3D 0)
> > +	error =3D nfserr_badhandle;
> > +	if (fh->fh_size =3D=3D 0)
> >  		return nfserr_nofilehandle;
> > =20
> >  	if (fh->fh_version !=3D 1)
> > @@ -239,9 +235,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqs=
tp, struct svc_fh *fhp)
> >  	/*
> >  	 * Look up the dentry using the NFS file handle.
> >  	 */
> > -	error =3D nfserr_stale;
> > -	if (rqstp->rq_vers > 2)
> > -		error =3D nfserr_badhandle;
> > +	error =3D nfserr_badhandle;
> > =20
> >  	fileid_type =3D fh->fh_fileid_type;
> > =20
> > @@ -368,7 +362,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp,=
 umode_t type, int access)
> >  	if (error)
> >  		goto out;
> > =20
> > -	error =3D nfsd_mode_check(rqstp, dentry, type);
> > +	error =3D nfsd_mode_check(dentry, type);
> >  	if (error)
> >  		goto out;
> > =20
> > diff --git a/fs/nfsd/nfsxdr.c b/fs/nfsd/nfsxdr.c
> > index 5777f40c7353..9bb306bdc225 100644
> > --- a/fs/nfsd/nfsxdr.c
> > +++ b/fs/nfsd/nfsxdr.c
> > @@ -38,6 +38,25 @@ svcxdr_encode_stat(struct xdr_stream *xdr, __be32 stat=
us)
> >  {
> >  	__be32 *p;
> > =20
> > +	switch (status) {
> > +	case nfserr_symlink_not_dir:
> > +		status =3D nfserr_notdir;
> > +		break;
> > +	case nfserr_symlink:
> > +	case nfserr_wrong_type:
> > +		status =3D nfserr_inval;
> > +		break;
> > +	case nfserr_nofilehandle:
> > +	case nfserr_badhandle:
> > +		status =3D nfserr_stale;
> > +		break;
> > +	case nfserr_wrongsec:
> > +	case nfserr_xdev:
> > +	case nfserr_file_open:
> > +		status =3D nfserr_acces;
> > +		break;
> > +	}
> > +
>=20
> Same comment as above.
>=20
>=20
> >  	p =3D xdr_reserve_space(xdr, sizeof(status));
> >  	if (!p)
> >  		return false;
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 0862f6ae86a9..cf96a2ef6533 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -1770,10 +1770,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *f=
fhp,
> >  		if (!err)
> >  			err =3D nfserrno(commit_metadata(tfhp));
> >  	} else {
> > -		if (host_err =3D=3D -EXDEV && rqstp->rq_vers =3D=3D 2)
> > -			err =3D nfserr_acces;
> > -		else
> > -			err =3D nfserrno(host_err);
> > +		err =3D nfserrno(host_err);
> >  	}
> >  	dput(dnew);
> >  out_drop_write:
> > @@ -1839,7 +1836,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
> >  	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
> >  		goto out;
> > =20
> > -	err =3D (rqstp->rq_vers =3D=3D 2) ? nfserr_acces : nfserr_xdev;
> > +	err =3D nfserr_xdev;
> >  	if (ffhp->fh_export->ex_path.mnt !=3D tfhp->fh_export->ex_path.mnt)
> >  		goto out;
> >  	if (ffhp->fh_export->ex_path.dentry !=3D tfhp->fh_export->ex_path.dentr=
y)
> > @@ -1854,7 +1851,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *=
ffhp, char *fname, int flen,
> > =20
> >  	trap =3D lock_rename(tdentry, fdentry);
> >  	if (IS_ERR(trap)) {
> > -		err =3D (rqstp->rq_vers =3D=3D 2) ? nfserr_acces : nfserr_xdev;
> > +		err =3D nfserr_xdev;
> >  		goto out_want_write;
> >  	}
> >  	err =3D fh_fill_pre_attrs(ffhp);
> > @@ -2023,10 +2020,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh =
*fhp, int type,
> >  		/* name is mounted-on. There is no perfect
> >  		 * error status.
> >  		 */
> > -		if (nfsd_v4client(rqstp))
> > -			err =3D nfserr_file_open;
> > -		else
> > -			err =3D nfserr_acces;
> > +		err =3D nfserr_file_open;
> >  	} else {
> >  		err =3D nfserrno(host_err);
> >  	}
> > diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
> > index 0d896ce296ce..04dad965fa66 100644
> > --- a/include/linux/nfs4.h
> > +++ b/include/linux/nfs4.h
> > @@ -290,6 +290,9 @@ enum nfsstat4 {
> >  	/* xattr (RFC8276) */
> >  	NFS4ERR_NOXATTR        =3D 10095,
> >  	NFS4ERR_XATTR2BIG      =3D 10096,
> > +
> > +	/* can be used for internal errors */
> > +	NFS4ERR_FIRST_FREE
> >  };
> > =20
> >  /* error codes for internal client use */
> > --=20
> > 2.44.0
> >=20
>=20
> --=20
> Chuck Lever
>=20


