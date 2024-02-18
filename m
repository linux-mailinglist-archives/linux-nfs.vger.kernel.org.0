Return-Path: <linux-nfs+bounces-2021-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4618599A6
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Feb 2024 22:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA92028166F
	for <lists+linux-nfs@lfdr.de>; Sun, 18 Feb 2024 21:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08C96F062;
	Sun, 18 Feb 2024 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gjFeB7v6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="k1nSoXNC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="08QXkxSV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zaSsZ+p4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E98745C0
	for <linux-nfs@vger.kernel.org>; Sun, 18 Feb 2024 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708293454; cv=none; b=a+thEb+vKHrSAZoXIHv46qLOxFrzD78DFsjH1gGFikvs6Dps8BaEKqUDGN7kjIo4vuWRI9b5WZGAAsJfolEOXPj5zoKXAi/lqbvXvZ/3NfQcixYLbe1sQ1Wq+n5LAL5iiJsVsBLR1u8cQE6RNBC7JL7dHOtWAlIUSH4CyiSLr8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708293454; c=relaxed/simple;
	bh=TwFGdXV2R2OrYuep11HiT4kVZQaIf5WVGAJMupql0jY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=NMHKrvUe7HS3ZiSrcDGnSMPYblMo37Ed5KTeeeiatxklcr9RzSy/hQbwkTWmEZ7YOXVH9LhsRVZvIx7r7CagsQskIutONW44izNYXllfvtk38Mj1MFaJPxjuLRzu/WZ6SMzQKr5Mzt6RqjNxc1n2Jor6ciV46gn+GxyFhrfxY/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gjFeB7v6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=k1nSoXNC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=08QXkxSV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zaSsZ+p4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8F56121FE6;
	Sun, 18 Feb 2024 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708293445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6+EQmzdoFE75oKcZNSZ2+2y8pMJJo6AsxuKG4rwtvY=;
	b=gjFeB7v6BkVHISUB7o8EJvJouwaO+o01CBuLmiWUQJInEc7C8nPgcqopt/LFMheZbuSujg
	SUdFtxTKLCFocbVv0PDnNMO+/i2AtwdoX5vSahJidSkMA1G7615Xa3peCph0C4N6x0kmKm
	M2nviXxsMviKBW9ipQG7kxnFJPgEnsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708293445;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6+EQmzdoFE75oKcZNSZ2+2y8pMJJo6AsxuKG4rwtvY=;
	b=k1nSoXNCmMTVzlEOomispBEMmgwJ2o50qok0iV9eb7lIh+4ovGcKtKyFKPG3qSYC5N7fFg
	k84DGZvbskL724CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708293443; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6+EQmzdoFE75oKcZNSZ2+2y8pMJJo6AsxuKG4rwtvY=;
	b=08QXkxSV8dW9NMeMJt32+4ofMKjUbTTsJ8oV3jCRVg1W95e8o0slaNLr/gBzUpocnBpBjL
	iEp9q8Pqo77hlfW6YhbDEo1UCN1oGgrlErtJHAxBaRQgqDfsCQNyznn34eMPzuTJipb6un
	H9Daw8yTGZ0U7Up5YtWwwi2xYTPuYtY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708293443;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d6+EQmzdoFE75oKcZNSZ2+2y8pMJJo6AsxuKG4rwtvY=;
	b=zaSsZ+p42Xonb8NZP5DuRKk+vCv6o6ndsQaboPo9L4DUq7fVDi/K+ePv+FHeh57IYd80O3
	WuWVXQTaxUq4xEBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C5DF13A73;
	Sun, 18 Feb 2024 21:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 72nFBEJ90mXuAQAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 18 Feb 2024 21:57:22 +0000
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
Subject: Re: [PATCH v2 1/2] nfsd: Fix a regression in nfsd_setattr()
In-reply-to: <20240216012451.22725-2-trondmy@kernel.org>
References: <20240216012451.22725-1-trondmy@kernel.org>,
 <20240216012451.22725-2-trondmy@kernel.org>
Date: Mon, 19 Feb 2024 08:57:15 +1100
Message-id: <170829343514.1530.1077342787397990579@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Fri, 16 Feb 2024, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> Commit bb4d53d66e4b broke the NFSv3 pre/post op attributes behaviour
> when doing a SETATTR rpc call by stripping out the calls to
> fh_fill_pre_attrs() and fh_fill_post_attrs().
>=20
> Fixes: bb4d53d66e4b ("NFSD: use (un)lock_inode instead of fh_(un)lock for f=
ile operations")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfsd/nfs4proc.c | 4 ++++
>  fs/nfsd/vfs.c      | 9 +++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 14712fa08f76..e6d8624efc83 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1143,6 +1143,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_co=
mpound_state *cstate,
>  	};
>  	struct inode *inode;
>  	__be32 status =3D nfs_ok;
> +	bool save_no_wcc;
>  	int err;
> =20
>  	if (setattr->sa_iattr.ia_valid & ATTR_SIZE) {
> @@ -1168,8 +1169,11 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_c=
ompound_state *cstate,
> =20
>  	if (status)
>  		goto out;
> +	save_no_wcc =3D cstate->current_fh.fh_no_wcc;
> +	cstate->current_fh.fh_no_wcc =3D true;
>  	status =3D nfsd_setattr(rqstp, &cstate->current_fh, &attrs,
>  				0, (time64_t)0);
> +	cstate->current_fh.fh_no_wcc =3D save_no_wcc;

This looks clumsy.
I think the background is that NFSv3 needs atomic wcc attributes for
file operations, but NFSv4 doesn't - it only has them for directory ops.
So NFSv4, like NFSv2, doesn't want fh_fill_pre_attrs() to be called by
nfsd_setattr().

NFSv2 avoids it by always setting ->fh_no_wcc.  Here you temporarily set
fh_no_wcc to true for the same effect.  So the code is correct.
But it is not obvious to the casual reader why this is happening.

I would rather a "wcc_wanted" flag or similar, but that can be done in a
separate clean-up patch later.

Thanks for finding and fixing this regression of mine.

Reviewed-by: NeilBrown <neilb@suse.de>

NeilBrown



>  	if (!status)
>  		status =3D nfserrno(attrs.na_labelerr);
>  	if (!status)
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 6e7e37192461..58fab461bc00 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -497,7 +497,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	int		accmode =3D NFSD_MAY_SATTR;
>  	umode_t		ftype =3D 0;
>  	__be32		err;
> -	int		host_err;
> +	int		host_err =3D 0;
>  	bool		get_write_count;
>  	bool		size_change =3D (iap->ia_valid & ATTR_SIZE);
>  	int		retries;
> @@ -555,6 +555,9 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  	}
> =20
>  	inode_lock(inode);
> +	err =3D fh_fill_pre_attrs(fhp);
> +	if (err)
> +		goto out_unlock;
>  	for (retries =3D 1;;) {
>  		struct iattr attrs;
> =20
> @@ -582,13 +585,15 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *f=
hp,
>  		attr->na_aclerr =3D set_posix_acl(&nop_mnt_idmap,
>  						dentry, ACL_TYPE_DEFAULT,
>  						attr->na_dpacl);
> +	fh_fill_post_attrs(fhp);
> +out_unlock:
>  	inode_unlock(inode);
>  	if (size_change)
>  		put_write_access(inode);
>  out:
>  	if (!host_err)
>  		host_err =3D commit_metadata(fhp);
> -	return nfserrno(host_err);
> +	return err !=3D 0 ? err : nfserrno(host_err);
>  }
> =20
>  #if defined(CONFIG_NFSD_V4)
> --=20
> 2.43.1
>=20
>=20
>=20


