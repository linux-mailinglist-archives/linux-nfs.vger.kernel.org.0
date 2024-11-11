Return-Path: <linux-nfs+bounces-7841-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 226409C361B
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 02:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43DA41C226BE
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 01:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1B07641E;
	Mon, 11 Nov 2024 01:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QQvPPOtO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="09enohJY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QQvPPOtO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="09enohJY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4FA12C54B
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 01:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288687; cv=none; b=T4A+11kowfWHoGUKs/xG0dQsY4EeRqFqRuyxfGvObvEfVEhQslGjlWRn+F/v6C5lvy6EKNTok7vxfy8idKj/GY2dYaJBs+N1qDN/fe6lQqlNqlZrzOFI3jcn9fp8geXcCTM+BtuYWMqs5etVg/qegAJYdaUnD59Nomxip72lArk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288687; c=relaxed/simple;
	bh=b4SGvWXzLLHu3YJfbeUJ403SJRRSY7i0VXbqJhrs+Qs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=H0DLYVwmjjlgEujhiyoZlBVglFfGCyW9IOCxt5m92MwR/Eqi3Sog43fsZaFNyJXaw96jDVsr2dxlDgd+8qiI2FjIy/+TxSTXUBLi1vZa1UEWchO5wN7HeEuOHpSLtEozwTXkhwa6NWEGXj3J0t/JfzsBaLZ8ml+dyw1B3ZaIwJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QQvPPOtO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=09enohJY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QQvPPOtO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=09enohJY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B161219EA;
	Mon, 11 Nov 2024 01:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731288683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7ef1EX7wAGkTQMrgYV3jQAlW0NlI4+X2HcbO4ZI78g=;
	b=QQvPPOtODI9fI8PlerZeSur49327sSARfszansn42Jvqmfrf8d8kkfMNcVeKmJt8Zx3eS2
	1hbPVFWcrraC35GI8vByUo29W+lgWc1hpXKNNfns8Yj2G6sZt7ziUM92RxOX7d9ruIiUPN
	IeWPPoaZp6sxT9tNXlzjGaXQhmmNFeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731288683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7ef1EX7wAGkTQMrgYV3jQAlW0NlI4+X2HcbO4ZI78g=;
	b=09enohJYj0EQ14U3dqFwIDUyVQRkDAkCzwf3K0U9epCAJ8jmzO5NFV5330q9pbCbYiqTEO
	jQDtO9ndA7Il3tDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QQvPPOtO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=09enohJY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731288683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7ef1EX7wAGkTQMrgYV3jQAlW0NlI4+X2HcbO4ZI78g=;
	b=QQvPPOtODI9fI8PlerZeSur49327sSARfszansn42Jvqmfrf8d8kkfMNcVeKmJt8Zx3eS2
	1hbPVFWcrraC35GI8vByUo29W+lgWc1hpXKNNfns8Yj2G6sZt7ziUM92RxOX7d9ruIiUPN
	IeWPPoaZp6sxT9tNXlzjGaXQhmmNFeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731288683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w7ef1EX7wAGkTQMrgYV3jQAlW0NlI4+X2HcbO4ZI78g=;
	b=09enohJYj0EQ14U3dqFwIDUyVQRkDAkCzwf3K0U9epCAJ8jmzO5NFV5330q9pbCbYiqTEO
	jQDtO9ndA7Il3tDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30C69137FB;
	Mon, 11 Nov 2024 01:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id npFiNmheMWeXfAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Nov 2024 01:31:20 +0000
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
Subject: Re: [for-6.13 PATCH 07/19] nfs/localio: add direct IO enablement with
 sync and async IO support
In-reply-to: <20241108234002.16392-8-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>,
 <20241108234002.16392-8-snitzer@kernel.org>
Date: Mon, 11 Nov 2024 12:31:14 +1100
Message-id: <173128867427.1734440.11627053372464152311@noble.neil.brown.name>
X-Rspamd-Queue-Id: 3B161219EA
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Sat, 09 Nov 2024, Mike Snitzer wrote:
> This commit simply adds the required O_DIRECT plumbing.  It doesn't
> address the fact that NFS doesn't ensure all writes are page aligned
> (nor device logical block size aligned as required by O_DIRECT).
>=20
> Because NFS will read-modify-write for IO that isn't aligned, LOCALIO
> will not use O_DIRECT semantics by default if/when an application
> requests the use of O_DIRECT.  Allow the use of O_DIRECT semantics by:
> 1: Adding a flag to the nfs_pgio_header struct to allow the NFS
>    O_DIRECT layer to signal that O_DIRECT was used by the application
> 2: Adding a 'localio_O_DIRECT_semantics' NFS module parameter that
>    when enabled will cause LOCALIO to use O_DIRECT semantics (this may
>    cause IO to fail if applications do not properly align their IO).
>=20
> Adding Direct IO support helps side-step the problem that LOCALIO
> currently double buffers buffered IO (by using page cache in both NFS
> and the underlying filesystem).  More care is needed to craft a proper
> solution for LOCALIO's redundant use of page cache for buffered IO,
> e.g.: https://marc.info/?l=3Dlinux-nfs&m=3D171996211625151&w=3D2
>=20
> This commit is derived from code developed by Weston Andros Adamson.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/direct.c         |  1 +
>  fs/nfs/localio.c        | 92 ++++++++++++++++++++++++++++++++++++-----
>  include/linux/nfs_xdr.h |  1 +
>  3 files changed, 84 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 90079ca134dd..4b92493d6ff0 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
> @@ -303,6 +303,7 @@ static void nfs_read_sync_pgio_error(struct list_head *=
head, int error)
>  static void nfs_direct_pgio_init(struct nfs_pgio_header *hdr)
>  {
>  	get_dreq(hdr->dreq);
> +	set_bit(NFS_IOHDR_ODIRECT, &hdr->flags);
>  }
> =20
>  static const struct nfs_pgio_completion_ops nfs_direct_read_completion_ops=
 =3D {
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 4b8618cf114c..de0dcd76d84d 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -35,6 +35,7 @@ struct nfs_local_kiocb {
>  	struct bio_vec		*bvec;
>  	struct nfs_pgio_header	*hdr;
>  	struct work_struct	work;
> +	void (*aio_complete_work)(struct work_struct *);
>  	struct nfsd_file	*localio;
>  };
> =20
> @@ -48,6 +49,10 @@ struct nfs_local_fsync_ctx {
>  static bool localio_enabled __read_mostly =3D true;
>  module_param(localio_enabled, bool, 0644);
> =20
> +static bool localio_O_DIRECT_semantics __read_mostly =3D false;
> +module_param(localio_O_DIRECT_semantics, bool, 0644);
> +MODULE_PARM_DESC(localio_O_DIRECT_semantics, "Use O_DIRECT semantics");

Should the text mention localio??


> +
>  static inline bool nfs_client_is_local(const struct nfs_client *clp)
>  {
>  	return !!test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> @@ -285,10 +290,19 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
>  		kfree(iocb);
>  		return NULL;
>  	}
> -	init_sync_kiocb(&iocb->kiocb, file);
> +
> +	if (localio_O_DIRECT_semantics &&
> +	    test_bit(NFS_IOHDR_ODIRECT, &hdr->flags)) {
> +		iocb->kiocb.ki_filp =3D file;
> +		iocb->kiocb.ki_flags =3D IOCB_DIRECT;

why isn't ki_ioprio initialised??

The rest I am not able to review as I'm that that familiar with iocb
code.

Thanks,
NeilBrown


> +	} else
> +		init_sync_kiocb(&iocb->kiocb, file);
> +
>  	iocb->kiocb.ki_pos =3D hdr->args.offset;
>  	iocb->hdr =3D hdr;
>  	iocb->kiocb.ki_flags &=3D ~IOCB_APPEND;
> +	iocb->aio_complete_work =3D NULL;
> +
>  	return iocb;
>  }
> =20
> @@ -343,6 +357,18 @@ nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
>  	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
>  }
> =20
> +/*
> + * Complete the I/O from iocb->kiocb.ki_complete()
> + *
> + * Note that this function can be called from a bottom half context,
> + * hence we need to queue the rpc_call_done() etc to a workqueue
> + */
> +static inline void nfs_local_pgio_aio_complete(struct nfs_local_kiocb *ioc=
b)
> +{
> +	INIT_WORK(&iocb->work, iocb->aio_complete_work);
> +	queue_work(nfsiod_workqueue, &iocb->work);
> +}
> +
>  static void
>  nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
>  {
> @@ -365,6 +391,23 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long=
 status)
>  			status > 0 ? status : 0, hdr->res.eof);
>  }
> =20
> +static void nfs_local_read_aio_complete_work(struct work_struct *work)
> +{
> +	struct nfs_local_kiocb *iocb =3D
> +		container_of(work, struct nfs_local_kiocb, work);
> +
> +	nfs_local_pgio_release(iocb);
> +}
> +
> +static void nfs_local_read_aio_complete(struct kiocb *kiocb, long ret)
> +{
> +	struct nfs_local_kiocb *iocb =3D
> +		container_of(kiocb, struct nfs_local_kiocb, kiocb);
> +
> +	nfs_local_read_done(iocb, ret);
> +	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_read_aio_complete_w=
ork */
> +}
> +
>  static void nfs_local_call_read(struct work_struct *work)
>  {
>  	struct nfs_local_kiocb *iocb =3D
> @@ -379,10 +422,10 @@ static void nfs_local_call_read(struct work_struct *w=
ork)
>  	nfs_local_iter_init(&iter, iocb, READ);
> =20
>  	status =3D filp->f_op->read_iter(&iocb->kiocb, &iter);
> -	WARN_ON_ONCE(status =3D=3D -EIOCBQUEUED);
> -
> -	nfs_local_read_done(iocb, status);
> -	nfs_local_pgio_release(iocb);
> +	if (status !=3D -EIOCBQUEUED) {
> +		nfs_local_read_done(iocb, status);
> +		nfs_local_pgio_release(iocb);
> +	}
> =20
>  	revert_creds(save_cred);
>  }
> @@ -410,6 +453,11 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
>  	nfs_local_pgio_init(hdr, call_ops);
>  	hdr->res.eof =3D false;
> =20
> +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> +		iocb->kiocb.ki_complete =3D nfs_local_read_aio_complete;
> +		iocb->aio_complete_work =3D nfs_local_read_aio_complete_work;
> +	}
> +
>  	INIT_WORK(&iocb->work, nfs_local_call_read);
>  	queue_work(nfslocaliod_workqueue, &iocb->work);
> =20
> @@ -534,6 +582,24 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, lon=
g status)
>  	nfs_local_pgio_done(hdr, status);
>  }
> =20
> +static void nfs_local_write_aio_complete_work(struct work_struct *work)
> +{
> +	struct nfs_local_kiocb *iocb =3D
> +		container_of(work, struct nfs_local_kiocb, work);
> +
> +	nfs_local_vfs_getattr(iocb);
> +	nfs_local_pgio_release(iocb);
> +}
> +
> +static void nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
> +{
> +	struct nfs_local_kiocb *iocb =3D
> +		container_of(kiocb, struct nfs_local_kiocb, kiocb);
> +
> +	nfs_local_write_done(iocb, ret);
> +	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_write_aio_complete_=
work */
> +}
> +
>  static void nfs_local_call_write(struct work_struct *work)
>  {
>  	struct nfs_local_kiocb *iocb =3D
> @@ -552,11 +618,11 @@ static void nfs_local_call_write(struct work_struct *=
work)
>  	file_start_write(filp);
>  	status =3D filp->f_op->write_iter(&iocb->kiocb, &iter);
>  	file_end_write(filp);
> -	WARN_ON_ONCE(status =3D=3D -EIOCBQUEUED);
> -
> -	nfs_local_write_done(iocb, status);
> -	nfs_local_vfs_getattr(iocb);
> -	nfs_local_pgio_release(iocb);
> +	if (status !=3D -EIOCBQUEUED) {
> +		nfs_local_write_done(iocb, status);
> +		nfs_local_vfs_getattr(iocb);
> +		nfs_local_pgio_release(iocb);
> +	}
> =20
>  	revert_creds(save_cred);
>  	current->flags =3D old_flags;
> @@ -592,10 +658,16 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
>  	case NFS_FILE_SYNC:
>  		iocb->kiocb.ki_flags |=3D IOCB_DSYNC|IOCB_SYNC;
>  	}
> +
>  	nfs_local_pgio_init(hdr, call_ops);
> =20
>  	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
> =20
> +	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
> +		iocb->kiocb.ki_complete =3D nfs_local_write_aio_complete;
> +		iocb->aio_complete_work =3D nfs_local_write_aio_complete_work;
> +	}
> +
>  	INIT_WORK(&iocb->work, nfs_local_call_write);
>  	queue_work(nfslocaliod_workqueue, &iocb->work);
> =20
> diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
> index e0ae0a14257f..f30e94d105b7 100644
> --- a/include/linux/nfs_xdr.h
> +++ b/include/linux/nfs_xdr.h
> @@ -1632,6 +1632,7 @@ enum {
>  	NFS_IOHDR_RESEND_PNFS,
>  	NFS_IOHDR_RESEND_MDS,
>  	NFS_IOHDR_UNSTABLE_WRITES,
> +	NFS_IOHDR_ODIRECT,
>  };
> =20
>  struct nfs_io_completion;
> --=20
> 2.44.0
>=20
>=20


