Return-Path: <linux-nfs+bounces-7734-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F39E9BF8E9
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 23:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E81D2844EB
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Nov 2024 22:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C5B1DFE13;
	Wed,  6 Nov 2024 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i1pDgpzh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SrF9kqkf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rrxNl1YD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7g8Xjz2+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B19D1CF2A5
	for <linux-nfs@vger.kernel.org>; Wed,  6 Nov 2024 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730930858; cv=none; b=pXoVBblu65ny212hVWcNsm+jrnqmbjs+jK71lAC//CKfC/lCf9gpMj7f/iP90VkECS5CY/iEEvOtoMx6l+t3gUmTDviA8qLKAQnEz3kTyupWBKxO/B2F2U+QjUTIrNg8o989hn6+7kjVMfJvGU/ISxOYlvkiyKdL6rcw/sa5Nio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730930858; c=relaxed/simple;
	bh=2A8JlNSGHgOyvMT7InDyczfgg++uyAim4s9yIN3WD1c=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZHmNCJLbwNJupJcwzZuyNoNKnA2yiKqBZALdvNdG3gkcU7p7evo8YiMxquiZWuinfjLUrBO2/6X+PI2qD2jVyeBQinDtZYmUwq4HEb0CE9VSIJt1xkBxtNAE7NeGcfuIXcVTnnFDTaEgne4x/l0hm0M8W4f1DS/LLoCTI7APHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i1pDgpzh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SrF9kqkf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rrxNl1YD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7g8Xjz2+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44A1C21CF1;
	Wed,  6 Nov 2024 22:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730930853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ET/SillFYpvCPj1/fAwp7NpEqt/n5B55X9QHCfb4y4w=;
	b=i1pDgpzhHzrD1gPw1jpHLBVTxu8cD2dxpiCmC4alLpC/Av2TUKgToTp7tT6hIf+kxcnhdk
	ZgpPqNLN1Pp/KVZnCX9JQYEkes8tvPtq558SYtwPzKwgszXElNseB3619pWpXHWMbE4eoI
	Cz8I2ly9EWbmy9aBL/E6dtxkNa2LZ9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730930853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ET/SillFYpvCPj1/fAwp7NpEqt/n5B55X9QHCfb4y4w=;
	b=SrF9kqkfFcOfUWPafOCso4uS5EB8U4WYtgI3kRquU0sw4PNxNXpPe26RFZw4bZH0BlB7Q9
	h1b0sG3QJESmXYDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rrxNl1YD;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7g8Xjz2+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730930851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ET/SillFYpvCPj1/fAwp7NpEqt/n5B55X9QHCfb4y4w=;
	b=rrxNl1YD+cv06Qg/ugMyEWvph06n1iVLaXhsodCO/4YHfRqSFYUyq1xbLMIt4OviP1MGez
	VuN+kBltcrRBNBr9Y2Zdh2iqRNKldrQcRGghmsbC5Iu57VKsNzp+8IGUANigbuZuntKlwl
	bpsFd6VL/mLMnW3Hbs2MJ37DaydQN8E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730930851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ET/SillFYpvCPj1/fAwp7NpEqt/n5B55X9QHCfb4y4w=;
	b=7g8Xjz2+AuarTxsW+JPvmBGvoJqyJdmH4r/af8H0R36vpC1kskCEUuweYv9qM59s/UpvBr
	6UX+8nLc0rQVR5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1A8E137C4;
	Wed,  6 Nov 2024 22:07:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dzLqIKDoK2f7PwAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 06 Nov 2024 22:07:28 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: cel@kernel.org
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 "Chuck Lever" <chuck.lever@oracle.com>
Subject: Re: [PATCH v2] NFSD: Fix READDIR on NFSv3 mounts of ext4 exports
In-reply-to: <20241106215505.115774-1-cel@kernel.org>
References: <20241106215505.115774-1-cel@kernel.org>
Date: Thu, 07 Nov 2024 09:07:14 +1100
Message-id: <173093083448.1734440.17908449315448640364@noble.neil.brown.name>
X-Rspamd-Queue-Id: 44A1C21CF1
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,oracle.com:email,noble.neil.brown.name:mid];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 07 Nov 2024, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
>=20
> I noticed that recently, simple operations like "make" started
> failing on NFSv3 mounts of ext4 exports. Network capture shows that
> READDIRPLUS operated correctly but READDIR failed with
> NFS3ERR_INVAL. The vfs_llseek() call returned EINVAL when it is
> passed a non-zero starting directory cookie.
>=20
> I bisected to commit c689bdd3bffa ("nfsd: further centralize
> protocol version checks.").
>=20
> Turns out that nfsd3_proc_readdir() does not call fh_verify() before
> it calls nfsd_readdir(), so the new fhp->fh_64bit_cookies boolean is
> not set properly. This leaves the NFSD_MAY_64BIT_COOKIE unset when
> the directory is opened.
>=20
> For ext4, this causes the wrong "max file size" value to be used
> when sanity checking the incoming directory cookie (which is a seek
> offset value).
>=20
> The fhp->fh_64bit_cookies boolean is /always/ properly initialized
> after nfsd_open() returns. There doesn't seem to be a reason for the
> generic NFSD open helper to handle the f_mode fix-up for
> directories, so just move that to the one caller that tries to open
> an S_IFDIR with NFSD_MAY_64BIT_COOKIE.

Thanks.  Looks good.  I like that you moved the f_mode setting out of
nfsd_open().  It really is only needed for directories.

Reviewed-by: NeilBrown <neilb@suse.de>

NeilBrown


>=20
> Suggested-by: NeilBrown <neilb@suse.de>
> Fixes: c689bdd3bffa ("nfsd: further centralize protocol version checks.")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/vfs.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>=20
> I'd like to get rolling with CI on this fix so it can go into
> v6.12-rc this week, so I authored this version based on Neil's
> suggestion.
>=20
> Note that removing the NFSD_MAY_64BIT_COOKIE flag entirely conflicts
> with the addition of NFSD_MAY_LOCALIO in v6.13. I've postponed the
> clean-up parts of this patch until then to help make merging this
> fix more smooth.
>=20
>=20
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 22325b590e17..d6d4f2a0e898 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -903,11 +903,6 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp=
, umode_t type,
>  		goto out;
>  	}
> =20
> -	if (may_flags & NFSD_MAY_64BIT_COOKIE)
> -		file->f_mode |=3D FMODE_64BITHASH;
> -	else
> -		file->f_mode |=3D FMODE_32BITHASH;
> -
>  	*filp =3D file;
>  out:
>  	return host_err;
> @@ -2174,13 +2169,15 @@ nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh =
*fhp, loff_t *offsetp,
>  	loff_t		offset =3D *offsetp;
>  	int             may_flags =3D NFSD_MAY_READ;
> =20
> -	if (fhp->fh_64bit_cookies)
> -		may_flags |=3D NFSD_MAY_64BIT_COOKIE;
> -
>  	err =3D nfsd_open(rqstp, fhp, S_IFDIR, may_flags, &file);
>  	if (err)
>  		goto out;
> =20
> +	if (fhp->fh_64bit_cookies)
> +		file->f_mode |=3D FMODE_64BITHASH;
> +	else
> +		file->f_mode |=3D FMODE_32BITHASH;
> +
>  	offset =3D vfs_llseek(file, offset, SEEK_SET);
>  	if (offset < 0) {
>  		err =3D nfserrno((int)offset);
> --=20
> 2.47.0
>=20
>=20


