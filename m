Return-Path: <linux-nfs+bounces-2022-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5FA8599A8
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Feb 2024 23:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8425E2815F4
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Feb 2024 22:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1846F6F074;
	Sun, 18 Feb 2024 22:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XPHfvmx9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1jWPJOAk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XPHfvmx9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1jWPJOAk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE311E86E
	for <linux-nfs@vger.kernel.org>; Sun, 18 Feb 2024 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708293688; cv=none; b=R5GJX7jcWKZx+0qoQUFyoLetBfuiOFrFOMiSsM289rNJlWbvMwvJWNqK504P+EwH3y6pHeBpVf5p5l3SPdVtwCPAD3MQKHSFKT5eTuVRLqIBcrWExR08AIvacJBUmHLM2ne8YXm+OFL5R5bQkWe1lzTlYRaIXyRO5QQ4mPxm8CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708293688; c=relaxed/simple;
	bh=ub4Cqa5mCyJQ4wIvqiRR7F5Ssqj8AizN4pJYibPMoMA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JDE4XEi+xaWcaFz4lTYntbOtou6EntzAWXJRapf4ikb+hh+MIZtvGgdmurDBHeFC5Ppkx9pAgDgrFWKjaABqtvHExVB9LYYRLJ73i9N1gj4fq24UPciRvqLvriFXqaeWCqwXf8/Fr/J+ngWMl/O8Hj1deXhBC9S8jI63rCX06Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XPHfvmx9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1jWPJOAk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XPHfvmx9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1jWPJOAk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1877421FFC;
	Sun, 18 Feb 2024 22:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708293684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HchRN5c7R/aDj7ltCw7QSckvHfOBbYUh2WRljx2DHm4=;
	b=XPHfvmx9q6L1jdKLm2ykRr6T6VkQ1v5iaAhLqeoSbdEDTr3l98cZJp4jyF4F/UH/QpBTGJ
	JAbrcj+O11aoL70vMXChHHOkcrf4Nd2ZLfrekZDncgA+w25guauePttsXyRusnmQMkAXpI
	EwijkJmfv9YvGKOSx7UpbXMGVXX5H5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708293684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HchRN5c7R/aDj7ltCw7QSckvHfOBbYUh2WRljx2DHm4=;
	b=1jWPJOAkOlP5LgoUoErEtehxPnwRfcrxoqy3/YnXDxXPuK5Ftj6K+ec5Db9HcY2frSmKP9
	TYkdcMytcJoBR4Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708293684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HchRN5c7R/aDj7ltCw7QSckvHfOBbYUh2WRljx2DHm4=;
	b=XPHfvmx9q6L1jdKLm2ykRr6T6VkQ1v5iaAhLqeoSbdEDTr3l98cZJp4jyF4F/UH/QpBTGJ
	JAbrcj+O11aoL70vMXChHHOkcrf4Nd2ZLfrekZDncgA+w25guauePttsXyRusnmQMkAXpI
	EwijkJmfv9YvGKOSx7UpbXMGVXX5H5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708293684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HchRN5c7R/aDj7ltCw7QSckvHfOBbYUh2WRljx2DHm4=;
	b=1jWPJOAkOlP5LgoUoErEtehxPnwRfcrxoqy3/YnXDxXPuK5Ftj6K+ec5Db9HcY2frSmKP9
	TYkdcMytcJoBR4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAA1813A73;
	Sun, 18 Feb 2024 22:01:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YYvMIzJ+0mUHAwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 18 Feb 2024 22:01:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: trondmy@kernel.org
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()
In-reply-to: <20240216012451.22725-3-trondmy@kernel.org>
References: <20240216012451.22725-1-trondmy@kernel.org>,
 <20240216012451.22725-2-trondmy@kernel.org>,
 <20240216012451.22725-3-trondmy@kernel.org>
Date: Mon, 19 Feb 2024 09:01:15 +1100
Message-id: <170829367594.1530.16517783767988740646@noble.neil.brown.name>
X-Spam-Level: ***
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XPHfvmx9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1jWPJOAk
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_SPAM(5.10)[99.99%];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 3.59
X-Rspamd-Queue-Id: 1877421FFC
X-Spam-Flag: NO

On Fri, 16 Feb 2024, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> The main point of the guarded SETATTR is to prevent races with other
> WRITE and SETATTR calls. That requires that the check of the guard time
> against the inode ctime be done after taking the inode lock.
>=20
> Furthermore, we need to take into account the 32-bit nature of
> timestamps in NFSv3, and the possibility that files may change at a
> faster rate than once a second.
>=20
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/nfs3proc.c  |  6 ++++--
>  fs/nfsd/nfs3xdr.c   |  5 +----
>  fs/nfsd/nfs4proc.c  |  3 +--
>  fs/nfsd/nfs4state.c |  2 +-
>  fs/nfsd/nfsproc.c   |  6 +++---
>  fs/nfsd/vfs.c       | 20 +++++++++++++-------
>  fs/nfsd/vfs.h       |  2 +-
>  fs/nfsd/xdr3.h      |  2 +-
>  8 files changed, 25 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index b78eceebd945..dfcc957e460d 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -71,13 +71,15 @@ nfsd3_proc_setattr(struct svc_rqst *rqstp)
>  	struct nfsd_attrs attrs =3D {
>  		.na_iattr	=3D &argp->attrs,
>  	};
> +	const struct timespec64 *guardtime =3D NULL;
> =20
>  	dprintk("nfsd: SETATTR(3)  %s\n",
>  				SVCFH_fmt(&argp->fh));
> =20
>  	fh_copy(&resp->fh, &argp->fh);
> -	resp->status =3D nfsd_setattr(rqstp, &resp->fh, &attrs,
> -				    argp->check_guard, argp->guardtime);
> +	if (argp->check_guard)
> +		guardtime =3D &argp->guardtime;
> +	resp->status =3D nfsd_setattr(rqstp, &resp->fh, &attrs, guardtime);
>  	return rpc_success;
>  }
> =20
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index f32128955ec8..a7a07470c1f8 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -295,17 +295,14 @@ svcxdr_decode_sattr3(struct svc_rqst *rqstp, struct x=
dr_stream *xdr,
>  static bool
>  svcxdr_decode_sattrguard3(struct xdr_stream *xdr, struct nfsd3_sattrargs *=
args)
>  {
> -	__be32 *p;
>  	u32 check;
> =20
>  	if (xdr_stream_decode_bool(xdr, &check) < 0)
>  		return false;
>  	if (check) {
> -		p =3D xdr_inline_decode(xdr, XDR_UNIT * 2);
> -		if (!p)
> +		if (!svcxdr_decode_nfstime3(xdr, &args->guardtime))
>  			return false;
>  		args->check_guard =3D 1;
> -		args->guardtime =3D be32_to_cpup(p);
>  	} else
>  		args->check_guard =3D 0;
> =20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index e6d8624efc83..ae48690f4c7c 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1171,8 +1171,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  		goto out;
>  	save_no_wcc =3D cstate->current_fh.fh_no_wcc;
>  	cstate->current_fh.fh_no_wcc =3D true;
> -	status =3D nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
> -				0, (time64_t)0);
> +	status =3D nfsd_setattr(rqstp, &cstate->current_fh, &attrs, NULL);
>  	cstate->current_fh.fh_no_wcc =3D save_no_wcc;
>  	if (!status)
>  		status =3D nfserrno(attrs.na_labelerr);
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 2fa54cfd4882..538edd85b51e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5191,7 +5191,7 @@ nfsd4_truncate(struct svc_rqst *rqstp, struct svc_fh =
*fh,
>  		return 0;
>  	if (!(open->op_share_access & NFS4_SHARE_ACCESS_WRITE))
>  		return nfserr_inval;
> -	return nfsd_setattr(rqstp, fh, &attrs, 0, (time64_t)0);
> +	return nfsd_setattr(rqstp, fh, &attrs, NULL);
>  }
> =20
>  static __be32 nfs4_get_vfs_file(struct svc_rqst *rqstp, struct nfs4_file *=
fp,
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index a7315928a760..36370b957b63 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -103,7 +103,7 @@ nfsd_proc_setattr(struct svc_rqst *rqstp)
>  		}
>  	}
> =20
> -	resp->status =3D nfsd_setattr(rqstp, fhp, &attrs, 0, (time64_t)0);
> +	resp->status =3D nfsd_setattr(rqstp, fhp, &attrs, NULL);
>  	if (resp->status !=3D nfs_ok)
>  		goto out;
> =20
> @@ -390,8 +390,8 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  		 */
>  		attr->ia_valid &=3D ATTR_SIZE;
>  		if (attr->ia_valid)
> -			resp->status =3D nfsd_setattr(rqstp, newfhp, &attrs, 0,
> -						    (time64_t)0);
> +			resp->status =3D nfsd_setattr(rqstp, newfhp, &attrs,
> +						    NULL);
>  	}
> =20
>  out_unlock:
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 58fab461bc00..3602e35e83d2 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -476,7 +476,6 @@ static int __nfsd_setattr(struct dentry *dentry, struct=
 iattr *iap)
>   * @rqstp: controlling RPC transaction
>   * @fhp: filehandle of target
>   * @attr: attributes to set
> - * @check_guard: set to 1 if guardtime is a valid timestamp
>   * @guardtime: do not act if ctime.tv_sec does not match this timestamp
>   *
>   * This call may adjust the contents of @attr (in particular, this
> @@ -488,8 +487,7 @@ static int __nfsd_setattr(struct dentry *dentry, struct=
 iattr *iap)
>   */
>  __be32
>  nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
> -	     struct nfsd_attrs *attr,
> -	     int check_guard, time64_t guardtime)
> +	     struct nfsd_attrs *attr, const struct timespec64 *guardtime)
>  {
>  	struct dentry	*dentry;
>  	struct inode	*inode;
> @@ -538,9 +536,6 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
> =20
>  	nfsd_sanitize_attrs(inode, iap);
> =20
> -	if (check_guard && guardtime !=3D inode_get_ctime_sec(inode))
> -		return nfserr_notsync;
> -
>  	/*
>  	 * The size case is special, it changes the file in addition to the
>  	 * attributes, and file systems don't expect it to be mixed with
> @@ -558,6 +553,16 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fh=
p,
>  	err =3D fh_fill_pre_attrs(fhp);
>  	if (err)
>  		goto out_unlock;
> +
> +	if (guardtime) {
> +		struct timespec64 ctime =3D inode_get_ctime(inode);
> +		if ((u32)guardtime->tv_sec !=3D (u32)ctime.tv_sec ||
> +		    guardtime->tv_nsec !=3D ctime.tv_nsec) {
> +			err =3D nfserr_notsync;
> +			goto out_fill_attrs;
> +		}
> +	}
> +
>  	for (retries =3D 1;;) {
>  		struct iattr attrs;
> =20
> @@ -585,6 +590,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		attr->na_aclerr =3D set_posix_acl(&nop_mnt_idmap,
>  						dentry, ACL_TYPE_DEFAULT,
>  						attr->na_dpacl);
> +out_fill_attrs:
>  	fh_fill_post_attrs(fhp);
>  out_unlock:
>  	inode_unlock(inode);
> @@ -1409,7 +1415,7 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struct sv=
c_fh *fhp,
>  	 * if the attributes have not changed.
>  	 */
>  	if (iap->ia_valid)
> -		status =3D nfsd_setattr(rqstp, resfhp, attrs, 0, (time64_t)0);
> +		status =3D nfsd_setattr(rqstp, resfhp, attrs, NULL);
>  	else
>  		status =3D nfserrno(commit_metadata(resfhp));
> =20
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 702fbc4483bf..7d77303ef5f7 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -69,7 +69,7 @@ __be32		 nfsd_lookup_dentry(struct svc_rqst *, struct svc=
_fh *,
>  				const char *, unsigned int,
>  				struct svc_export **, struct dentry **);
>  __be32		nfsd_setattr(struct svc_rqst *, struct svc_fh *,
> -				struct nfsd_attrs *, int, time64_t);
> +			     struct nfsd_attrs *, const struct timespec64 *);
>  int nfsd_mountpoint(struct dentry *, struct svc_export *);
>  #ifdef CONFIG_NFSD_V4
>  __be32		nfsd4_vfs_fallocate(struct svc_rqst *, struct svc_fh *,
> diff --git a/fs/nfsd/xdr3.h b/fs/nfsd/xdr3.h
> index 03fe4e21306c..522067b7fd75 100644
> --- a/fs/nfsd/xdr3.h
> +++ b/fs/nfsd/xdr3.h
> @@ -14,7 +14,7 @@ struct nfsd3_sattrargs {
>  	struct svc_fh		fh;
>  	struct iattr		attrs;
>  	int			check_guard;
> -	time64_t		guardtime;
> +	struct timespec64	guardtime;
>  };
> =20
>  struct nfsd3_diropargs {
> --=20
> 2.43.1
>=20
>=20
>=20

Nice cleanup was well as the bug fix - thanks,

Reviewed-by: NeilBrown <neilb@suse.de>

NeilBrown

