Return-Path: <linux-nfs+bounces-7634-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAAF9BAAB4
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 03:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F264E1C20F5D
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 02:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AEB5FDA7;
	Mon,  4 Nov 2024 02:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sAg0alFN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T0c43zZg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sAg0alFN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T0c43zZg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC815B0EF
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730685945; cv=none; b=OLBKSSY6ncMG5a8OaHwLQsMowPsWclrzR7iJXoZ0Mr6hGw+sMdyCCF6D1euHMGuD8DVs9du+PfDQTo0DrBoTvymW9F7BpVLo7dIulJcxC1zeN/23wg9R85pVcrdPtvw/511HsIAWrcCL27cqbcDWTB+x9eOU8ZGv99hHN4l0nIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730685945; c=relaxed/simple;
	bh=xoHuGWHVixsANphH8I2pKFSZZaeCvm1sO+S5BS71CHs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=FnMz4fKavjiGAQZjNNTvxeZsf1f8b1s89svHQdYuTXvvyeT8cgZc8z3lBUuJqvsIFKyg/Y+jNJk1tre/MxiuXOEKrMmFVrIfFbVtoHwNtNCsgFtHEv/9zjQKalvR6gRnI/7KF/V/1YSvkKRXDbBk+w+En/jQwQ+TbYeWGcf2lF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sAg0alFN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T0c43zZg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sAg0alFN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T0c43zZg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0A9321F7AF;
	Mon,  4 Nov 2024 02:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730685941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDbJU2AQDMVfMta0IXu5q4r/9qKSAcmB0tJThrIf9eo=;
	b=sAg0alFNTKnHflyNzBZdzC9L6BKjEbFrEmxAhhI42MpUiJJ0lCxTqsy6Z7/9eWAUuNGtMc
	UvuXWaPArVOzCINxxN8VkCwSCZytEj4CGJZZa1sFVCpvPSgFsW0ZHfDNwz8N3+malAcIIz
	Aj8Hvd9wUarruz/XBWdHTz9uzxHBC9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730685941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDbJU2AQDMVfMta0IXu5q4r/9qKSAcmB0tJThrIf9eo=;
	b=T0c43zZgdbk2zCkeitD3mvS8JWpQRKjSFJFJwWxOckRxBh45wWejp9xM6curIPfQZ00NTj
	NNRrI6FMWo5VZJBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730685941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDbJU2AQDMVfMta0IXu5q4r/9qKSAcmB0tJThrIf9eo=;
	b=sAg0alFNTKnHflyNzBZdzC9L6BKjEbFrEmxAhhI42MpUiJJ0lCxTqsy6Z7/9eWAUuNGtMc
	UvuXWaPArVOzCINxxN8VkCwSCZytEj4CGJZZa1sFVCpvPSgFsW0ZHfDNwz8N3+malAcIIz
	Aj8Hvd9wUarruz/XBWdHTz9uzxHBC9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730685941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RDbJU2AQDMVfMta0IXu5q4r/9qKSAcmB0tJThrIf9eo=;
	b=T0c43zZgdbk2zCkeitD3mvS8JWpQRKjSFJFJwWxOckRxBh45wWejp9xM6curIPfQZ00NTj
	NNRrI6FMWo5VZJBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CE9E13736;
	Mon,  4 Nov 2024 02:05:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5TRKFPIrKGfxKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Nov 2024 02:05:38 +0000
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
Subject: Re: [RFC PATCH] NFSD: Fix READDIR on NFSv3 mounts of ext4 exports
In-reply-to: <20241103213731.85803-2-cel@kernel.org>
References: <20241103213731.85803-2-cel@kernel.org>
Date: Mon, 04 Nov 2024 13:05:27 +1100
Message-id: <173068592763.81717.8053187930798590061@noble.neil.brown.name>
X-Spam-Score: -4.30
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 04 Nov 2024, cel@kernel.org wrote:
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
> Both NFSv2 and NFSv3 READDIR need to call fh_verify() now to ensure
> the new boolean fields are properly initialized.
>=20
> There is a risk that these procedures might now return a status code
> that is not valid (by spec), or that operations that are currently
> allowed might no longer be.

This seems like the wrong fix to me.  Why should nfsd4_proc_readdir()
call fh_verify() when nfsd_readdir() already does that via=20
nfsd_open()??

The only reason is to set NFSD_MAY_64BIT_COOKIE.  Let's just get rid of
that flag instead and use fhp->fh_64bit_cookies directly.

Like this:

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index b8470d4cbe99..51b2074d92a5 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -86,7 +86,6 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
 		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
 		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
 		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
-		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
 		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
=20
 TRACE_EVENT(nfsd_compound,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 22325b590e17..a86b6f6a3b98 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -903,7 +903,7 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, u=
mode_t type,
 		goto out;
 	}
=20
-	if (may_flags & NFSD_MAY_64BIT_COOKIE)
+	if (fhp->fh_64bit_cookies)
 		file->f_mode |=3D FMODE_64BITHASH;
 	else
 		file->f_mode |=3D FMODE_32BITHASH;
@@ -2174,9 +2174,6 @@ nfsd_readdir(struct svc_rqst *rqstp, struct svc_fh *fhp=
, loff_t *offsetp,
 	loff_t		offset =3D *offsetp;
 	int             may_flags =3D NFSD_MAY_READ;
=20
-	if (fhp->fh_64bit_cookies)
-		may_flags |=3D NFSD_MAY_64BIT_COOKIE;
-
 	err =3D nfsd_open(rqstp, fhp, S_IFDIR, may_flags, &file);
 	if (err)
 		goto out;
diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
index 3ff146522556..2ba4265a22a0 100644
--- a/fs/nfsd/vfs.h
+++ b/fs/nfsd/vfs.h
@@ -31,8 +31,6 @@
 #define NFSD_MAY_BYPASS_GSS		0x400
 #define NFSD_MAY_READ_IF_EXEC		0x800
=20
-#define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >=3D NFS=
v3 */
-
 #define NFSD_MAY_LOCALIO		0x2000 /* for tracing, reflects when localio used =
*/
=20
 #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)


If you agree I can send that as a proper patch.

Thanks,
NeilBrown



>=20
> Fixes: c689bdd3bffa ("nfsd: further centralize protocol version checks.")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/nfsd/nfs3proc.c | 6 ++++++
>  fs/nfsd/nfsproc.c  | 8 +++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index dfcc957e460d..48bcdc96b867 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -592,6 +592,11 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
>  	resp->cookie_offset =3D 0;
>  	resp->rqstp =3D rqstp;
>  	offset =3D argp->cookie;
> +
> +	resp->status =3D fh_verify(rqstp, &resp->fh, S_IFDIR, NFSD_MAY_NOP);
> +	if (resp->status !=3D nfs_ok)
> +		goto out;
> +
>  	resp->status =3D nfsd_readdir(rqstp, &resp->fh, &offset,
>  				    &resp->common, nfs3svc_encode_entry3);
>  	memcpy(resp->verf, argp->verf, 8);
> @@ -600,6 +605,7 @@ nfsd3_proc_readdir(struct svc_rqst *rqstp)
>  	/* Recycle only pages that were part of the reply */
>  	rqstp->rq_next_page =3D resp->xdr.page_ptr + 1;
> =20
> +out:
>  	return rpc_success;
>  }
> =20
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 97aab34593ef..ebe8fd3c9ddd 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -586,11 +586,17 @@ nfsd_proc_readdir(struct svc_rqst *rqstp)
>  	resp->common.err =3D nfs_ok;
>  	resp->cookie_offset =3D 0;
>  	offset =3D argp->cookie;
> +
> +	resp->status =3D fh_verify(rqstp, &resp->fh, S_IFDIR, NFSD_MAY_NOP);
> +	if (resp->status !=3D nfs_ok)
> +		goto out;
> +
>  	resp->status =3D nfsd_readdir(rqstp, &argp->fh, &offset,
>  				    &resp->common, nfssvc_encode_entry);
>  	nfssvc_encode_nfscookie(resp, offset);
> -
>  	fh_put(&argp->fh);
> +
> +out:
>  	return rpc_success;
>  }
> =20
> --=20
> 2.47.0
>=20
>=20


