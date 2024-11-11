Return-Path: <linux-nfs+bounces-7839-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAD79C35DB
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 02:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594802814A4
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 01:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B87C8F0;
	Mon, 11 Nov 2024 01:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TH8cCIUl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4uBlOZKV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pklxFzPj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nAnfGVxG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BFCAD58
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288021; cv=none; b=OY2EYsGqkCcvNqnjpZ+r454qIYkEZ1obPafww/7OYb/3MWQBHmX33DggsPwKdXL9w/mIGcL1Fg3F5WynFNmSIOhGzNwRKvq5e3THzXmVpMtEwniTfv7Lcs+/9JXK/k99GyJM7PC9RXsfoHuBbLAwyfbYaMOSf5XgXsiN4rqNkdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288021; c=relaxed/simple;
	bh=FUPFJRfp8NXPpW1hYr7Fp8yp/g/Zsdftr+gbdJGT2Yo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Shz9tq+8bged8TPxtL390nurq8I0qNzAOG6JkK6xZ81/ojL9SA+XeRj2EOZtvf1HWyYGCptuU7bNvmSxdBve8e1i3ICS9Vg9o7WS3awrOINFHp0VB6ZgeCvATZlAQ1YbpXRAdvjI9niFeS4aUKDvoMAh5HWjNudpzwPuxaT/n7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TH8cCIUl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4uBlOZKV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pklxFzPj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nAnfGVxG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 67670219EA;
	Mon, 11 Nov 2024 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731288018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ep9KdOiunD3uNUbQssGH8PjC4rUuTllcc7X+QyVUxig=;
	b=TH8cCIUl8Ao+/M6zgQkIIYPiC+mlkZ9QkpHt9DeC3fFiN1yL1DHanyZ8B7JloYj1ghLL4p
	+IoCnNkHsdnrjx6GsXKGzCiuVcpCkCcD/4/INAXQtDVyZLwNDa1KCDFgKXnLhSAmkpFAPe
	qSel7OoqtKghP4jVbTkRCjtNdF/tvDE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731288018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ep9KdOiunD3uNUbQssGH8PjC4rUuTllcc7X+QyVUxig=;
	b=4uBlOZKVLwcpYeALFYPNYbihIHVYxdTEwUIF9KYQomsALRmK81i0s1+M2lsB1bhNyIiHHB
	iJ4a50a9I6SVBQAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731288017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ep9KdOiunD3uNUbQssGH8PjC4rUuTllcc7X+QyVUxig=;
	b=pklxFzPjkGMz7YmjTzhQ1iKvB9VvoDyf9oIpyS2BoEfdNu0Cjb5yFNDZfRBp2n4Ob7TOt8
	Jh62h8ryuBOJnyyF3jiLOwCkoLiMPtjLSxT4C5islaKmoe1fyMLrqW6xXX/2Qjg+7MClC/
	SjjOhtVVLy+BwPdY2kp5IfKySmQd4Cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731288017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ep9KdOiunD3uNUbQssGH8PjC4rUuTllcc7X+QyVUxig=;
	b=nAnfGVxGGho1JjyvCRxep0gHoqGh6vMHjb1uz3ZmAkIY69lum9PbClaMh9G4XPRYxwmPeC
	dQY57M8oW41kpICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 612A2137FB;
	Mon, 11 Nov 2024 01:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kVu3Bs9bMWfoeQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Nov 2024 01:20:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [for-6.13 PATCH 05/19] nfs/localio: remove extra indirect nfs_to
 call to check {read,write}_iter
In-reply-to: <20241108234002.16392-6-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>,
 <20241108234002.16392-6-snitzer@kernel.org>
Date: Mon, 11 Nov 2024 12:20:12 +1100
Message-id: <173128801252.1734440.2215679616952985988@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 09 Nov 2024, Mike Snitzer wrote:
> Push the read_iter and write_iter availability checks down to
> nfs_do_local_read and nfs_do_local_write respectively.
>=20
> This eliminates a redundant nfs_to->nfsd_file_file() call.

Do it?

The patch removes 2 of these calls and add 2 of these calls.  So it
isn't clear what is being eliminated.

Maybe it is a good think to do, but it isn't obvious to me why.

Thanks,
NeilBrown


>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/localio.c | 32 +++++++++++++++++++-------------
>  1 file changed, 19 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index a7eb83a604d0..a77ac7e8a05c 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -273,7 +273,7 @@ nfs_local_iocb_free(struct nfs_local_kiocb *iocb)
> =20
>  static struct nfs_local_kiocb *
>  nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
> -		     struct nfsd_file *localio, gfp_t flags)
> +		     struct file *file, gfp_t flags)
>  {
>  	struct nfs_local_kiocb *iocb;
> =20
> @@ -286,9 +286,8 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
>  		kfree(iocb);
>  		return NULL;
>  	}
> -	init_sync_kiocb(&iocb->kiocb, nfs_to->nfsd_file_file(localio));
> +	init_sync_kiocb(&iocb->kiocb, file);
>  	iocb->kiocb.ki_pos =3D hdr->args.offset;
> -	iocb->localio =3D localio;
>  	iocb->hdr =3D hdr;
>  	iocb->kiocb.ki_flags &=3D ~IOCB_APPEND;
>  	return iocb;
> @@ -395,13 +394,19 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
>  		  const struct rpc_call_ops *call_ops)
>  {
>  	struct nfs_local_kiocb *iocb;
> +	struct file *file =3D nfs_to->nfsd_file_file(localio);
> +
> +	/* Don't support filesystems without read_iter */
> +	if (!file->f_op->read_iter)
> +		return -EAGAIN;
> =20
>  	dprintk("%s: vfs_read count=3D%u pos=3D%llu\n",
>  		__func__, hdr->args.count, hdr->args.offset);
> =20
> -	iocb =3D nfs_local_iocb_alloc(hdr, localio, GFP_KERNEL);
> +	iocb =3D nfs_local_iocb_alloc(hdr, file, GFP_KERNEL);
>  	if (iocb =3D=3D NULL)
>  		return -ENOMEM;
> +	iocb->localio =3D localio;
> =20
>  	nfs_local_pgio_init(hdr, call_ops);
>  	hdr->res.eof =3D false;
> @@ -564,14 +569,20 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
>  		   const struct rpc_call_ops *call_ops)
>  {
>  	struct nfs_local_kiocb *iocb;
> +	struct file *file =3D nfs_to->nfsd_file_file(localio);
> +
> +	/* Don't support filesystems without write_iter */
> +	if (!file->f_op->write_iter)
> +		return -EAGAIN;
> =20
>  	dprintk("%s: vfs_write count=3D%u pos=3D%llu %s\n",
>  		__func__, hdr->args.count, hdr->args.offset,
>  		(hdr->args.stable =3D=3D NFS_UNSTABLE) ?  "unstable" : "stable");
> =20
> -	iocb =3D nfs_local_iocb_alloc(hdr, localio, GFP_NOIO);
> +	iocb =3D nfs_local_iocb_alloc(hdr, file, GFP_NOIO);
>  	if (iocb =3D=3D NULL)
>  		return -ENOMEM;
> +	iocb->localio =3D localio;
> =20
>  	switch (hdr->args.stable) {
>  	default:
> @@ -597,16 +608,9 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd=
_file *localio,
>  		   const struct rpc_call_ops *call_ops)
>  {
>  	int status =3D 0;
> -	struct file *filp =3D nfs_to->nfsd_file_file(localio);
> =20
>  	if (!hdr->args.count)
>  		return 0;
> -	/* Don't support filesystems without read_iter/write_iter */
> -	if (!filp->f_op->read_iter || !filp->f_op->write_iter) {
> -		nfs_local_disable(clp);
> -		status =3D -EAGAIN;
> -		goto out;
> -	}
> =20
>  	switch (hdr->rw_mode) {
>  	case FMODE_READ:
> @@ -620,8 +624,10 @@ int nfs_local_doio(struct nfs_client *clp, struct nfsd=
_file *localio,
>  			hdr->rw_mode);
>  		status =3D -EINVAL;
>  	}
> -out:
> +
>  	if (status !=3D 0) {
> +		if (status =3D=3D -EAGAIN)
> +			nfs_local_disable(clp);
>  		nfs_to_nfsd_file_put_local(localio);
>  		hdr->task.tk_status =3D status;
>  		nfs_local_hdr_release(hdr, call_ops);
> --=20
> 2.44.0
>=20
>=20


