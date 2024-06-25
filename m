Return-Path: <linux-nfs+bounces-4307-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CFD91749D
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 01:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B000284F2B
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 23:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AAB1487C1;
	Tue, 25 Jun 2024 23:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w36hbKrr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8pgxjks3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w36hbKrr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8pgxjks3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E696146A64
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 23:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719357338; cv=none; b=GqIZQng3QaXDQOS1ZgkrbrznWqbpj3COk48ggLNI26bzrYq4V/PYHgG/JX6FuykUoSVifcL03Px4uEofVSa8p0X5efdHK8mtktgo1qfr4eLH6IAgKgEm5IM3ZJCfM7n/sAvvE2dM59EuDY8w/YTqv39tyEkSNc5RCcV1YRr8jps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719357338; c=relaxed/simple;
	bh=jcuEhpJOoIw3h9R7GTP4DoPwjVrsB7BrSebqyLj0UKY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=E941VR0/ieuj7mTMn2k5gD/4/hYJTS3vJQWBkuwiuNP6o8Ri52ujSmxKCr7s+reydnJQgUbGd5JS8zPte7ae1vZlWwo31JE9rWWdfTygATVeKGnNCjybNOdlERSMNgtVq7cVjn2xLZMxxjw56DsKVK3flKmxspmvc6JFbt2HdQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w36hbKrr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8pgxjks3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w36hbKrr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8pgxjks3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3F0E81F8B3;
	Tue, 25 Jun 2024 23:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719357329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeSj6ZeCuAkfdRoq+nJ5hofYJm9mNMYrJq8nXIrS5cQ=;
	b=w36hbKrrNd1P97h30Xq+7hILFU8F3mZjffeywwIu8faNaaXpIUxFcdWXNfHLvNdN6rVutl
	G4ES8VUoADg/pdhzPZqF9G4ZR4tDlXuqoMtO7fym9y78lmLYfAZqC+RjzBFWQHJam7fA4t
	iT2iL/omIPGZbggUJvaKuCG8rQJ+uNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719357329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeSj6ZeCuAkfdRoq+nJ5hofYJm9mNMYrJq8nXIrS5cQ=;
	b=8pgxjks3qutEjC0AnxHbeepWKqaMsAafue1qGLy0T9zMSaBg7plWY3yO86eWT7tyZQnPAa
	r5E8Xi9itVHOjoDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719357329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeSj6ZeCuAkfdRoq+nJ5hofYJm9mNMYrJq8nXIrS5cQ=;
	b=w36hbKrrNd1P97h30Xq+7hILFU8F3mZjffeywwIu8faNaaXpIUxFcdWXNfHLvNdN6rVutl
	G4ES8VUoADg/pdhzPZqF9G4ZR4tDlXuqoMtO7fym9y78lmLYfAZqC+RjzBFWQHJam7fA4t
	iT2iL/omIPGZbggUJvaKuCG8rQJ+uNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719357329;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YeSj6ZeCuAkfdRoq+nJ5hofYJm9mNMYrJq8nXIrS5cQ=;
	b=8pgxjks3qutEjC0AnxHbeepWKqaMsAafue1qGLy0T9zMSaBg7plWY3yO86eWT7tyZQnPAa
	r5E8Xi9itVHOjoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A098D1384C;
	Tue, 25 Jun 2024 23:15:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OGdREY5Pe2YwRgAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 25 Jun 2024 23:15:26 +0000
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
Cc: linux-nfs@vger.kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v7 10/20] nfs/localio: use dedicated workqueues for
 filesystem read and write
In-reply-to: <20240624162741.68216-11-snitzer@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>,
 <20240624162741.68216-11-snitzer@kernel.org>
Date: Wed, 26 Jun 2024 09:15:22 +1000
Message-id: <171935732291.14261.6800212776300704961@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Tue, 25 Jun 2024, Mike Snitzer wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>=20
> For localio access, don't call filesystem read() and write() routines
> directly.
>=20
> Some filesystem writeback routines can end up taking up a lot of stack
> space (particularly xfs). Instead of risking running over due to the
> extra overhead from the NFS stack, we should just call these routines
> from a workqueue job.
>=20
> Use of dedicated workqueues improves performance over using the
> system_unbound_wq. Localio is motivated by the promise of improved
> performance, it makes little sense to yield it back.
>=20
> But further analysis of the latest stack depth requirements would be
> useful. It'd be nice to root cause and fix the latest stack hogs,
> because using workqueues at all can cause a loss in performance due to
> context switches.
>=20

I would rather this patch were left out of the final submission, and
only added if/when we have documented evidence that it helps.

Thanks,
NeilBrown


> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>


> ---
>  fs/nfs/inode.c    |  57 +++++++++++++++++---------
>  fs/nfs/internal.h |   1 +
>  fs/nfs/localio.c  | 102 +++++++++++++++++++++++++++++++++++-----------
>  3 files changed, 118 insertions(+), 42 deletions(-)
>=20
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index f9923cbf6058..aac8c5302503 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -2394,35 +2394,54 @@ static void nfs_destroy_inodecache(void)
>  	kmem_cache_destroy(nfs_inode_cachep);
>  }
> =20
> +struct workqueue_struct *nfslocaliod_workqueue;
>  struct workqueue_struct *nfsiod_workqueue;
>  EXPORT_SYMBOL_GPL(nfsiod_workqueue);
> =20
>  /*
> - * start up the nfsiod workqueue
> - */
> -static int nfsiod_start(void)
> -{
> -	struct workqueue_struct *wq;
> -	dprintk("RPC:       creating workqueue nfsiod\n");
> -	wq =3D alloc_workqueue("nfsiod", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> -	if (wq =3D=3D NULL)
> -		return -ENOMEM;
> -	nfsiod_workqueue =3D wq;
> -	return 0;
> -}
> -
> -/*
> - * Destroy the nfsiod workqueue
> + * Destroy the nfsiod workqueues
>   */
>  static void nfsiod_stop(void)
>  {
>  	struct workqueue_struct *wq;
> =20
>  	wq =3D nfsiod_workqueue;
> -	if (wq =3D=3D NULL)
> -		return;
> -	nfsiod_workqueue =3D NULL;
> -	destroy_workqueue(wq);
> +	if (wq !=3D NULL) {
> +		nfsiod_workqueue =3D NULL;
> +		destroy_workqueue(wq);
> +	}
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	wq =3D nfslocaliod_workqueue;
> +	if (wq !=3D NULL) {
> +		nfslocaliod_workqueue =3D NULL;
> +		destroy_workqueue(wq);
> +	}
> +#endif /* CONFIG_NFS_LOCALIO */
> +}
> +
> +/*
> + * Start the nfsiod workqueues
> + */
> +static int nfsiod_start(void)
> +{
> +	dprintk("RPC:       creating workqueue nfsiod\n");
> +	nfsiod_workqueue =3D alloc_workqueue("nfsiod", WQ_MEM_RECLAIM | WQ_UNBOUN=
D, 0);
> +	if (nfsiod_workqueue =3D=3D NULL)
> +		return -ENOMEM;
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	/*
> +	 * localio writes need to use a normal (non-memreclaim) workqueue.
> +	 * When we start getting low on space, XFS goes and calls flush_work() on
> +	 * a non-memreclaim work queue, which causes a priority inversion problem.
> +	 */
> +	dprintk("RPC:       creating workqueue nfslocaliod\n");
> +	nfslocaliod_workqueue =3D alloc_workqueue("nfslocaliod", WQ_UNBOUND, 0);
> +	if (unlikely(nfslocaliod_workqueue =3D=3D NULL)) {
> +		nfsiod_stop();
> +		return -ENOMEM;
> +	}
> +#endif /* CONFIG_NFS_LOCALIO */
> +	return 0;
>  }
> =20
>  unsigned int nfs_net_id;
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index d352040e3232..9251a357d097 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -440,6 +440,7 @@ int nfs_check_flags(int);
> =20
>  /* inode.c */
>  extern struct workqueue_struct *nfsiod_workqueue;
> +extern struct workqueue_struct *nfslocaliod_workqueue;
>  extern struct inode *nfs_alloc_inode(struct super_block *sb);
>  extern void nfs_free_inode(struct inode *);
>  extern int nfs_write_inode(struct inode *, struct writeback_control *);
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 724e81716b16..418b8d76692b 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -44,6 +44,12 @@ struct nfs_local_fsync_ctx {
>  };
>  static void nfs_local_fsync_work(struct work_struct *work);
> =20
> +struct nfs_local_io_args {
> +	struct nfs_local_kiocb *iocb;
> +	struct work_struct work;
> +	struct completion *done;
> +};
> +
>  /*
>   * We need to translate between nfs status return values and
>   * the local errno values which may not be the same.
> @@ -307,30 +313,54 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, lon=
g status)
>  			status > 0 ? status : 0, hdr->res.eof);
>  }
> =20
> -static int
> -nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *filp,
> -		const struct rpc_call_ops *call_ops)
> +static void nfs_local_call_read(struct work_struct *work)
>  {
> -	struct nfs_local_kiocb *iocb;
> +	struct nfs_local_io_args *args =3D
> +		container_of(work, struct nfs_local_io_args, work);
> +	struct nfs_local_kiocb *iocb =3D args->iocb;
> +	struct file *filp =3D iocb->kiocb.ki_filp;
>  	struct iov_iter iter;
>  	ssize_t status;
> =20
> +	nfs_local_iter_init(&iter, iocb, READ);
> +
> +	status =3D filp->f_op->read_iter(&iocb->kiocb, &iter);
> +	if (status !=3D -EIOCBQUEUED) {
> +		nfs_local_read_done(iocb, status);
> +		nfs_local_pgio_release(iocb);
> +	}
> +	complete(args->done);
> +}
> +
> +static int nfs_do_local_read(struct nfs_pgio_header *hdr, struct file *fil=
p,
> +			     const struct rpc_call_ops *call_ops)
> +{
> +	struct nfs_local_io_args args;
> +	DECLARE_COMPLETION_ONSTACK(done);
> +	struct nfs_local_kiocb *iocb;
> +
>  	dprintk("%s: vfs_read count=3D%u pos=3D%llu\n",
>  		__func__, hdr->args.count, hdr->args.offset);
> =20
>  	iocb =3D nfs_local_iocb_alloc(hdr, filp, GFP_KERNEL);
>  	if (iocb =3D=3D NULL)
>  		return -ENOMEM;
> -	nfs_local_iter_init(&iter, iocb, READ);
> =20
>  	nfs_local_pgio_init(hdr, call_ops);
>  	hdr->res.eof =3D false;
> =20
> -	status =3D filp->f_op->read_iter(&iocb->kiocb, &iter);
> -	if (status !=3D -EIOCBQUEUED) {
> -		nfs_local_read_done(iocb, status);
> -		nfs_local_pgio_release(iocb);
> -	}
> +	/*
> +	 * Don't call filesystem read() routines directly.
> +	 * In order to avoid issues with stack overflow,
> +	 * call the read routines from a workqueue job.
> +	 */
> +	args.iocb =3D iocb;
> +	args.done =3D &done;
> +	INIT_WORK_ONSTACK(&args.work, nfs_local_call_read);
> +	queue_work(nfslocaliod_workqueue, &args.work);
> +	wait_for_completion(&done);
> +	destroy_work_on_stack(&args.work);
> +
>  	return 0;
>  }
> =20
> @@ -420,14 +450,35 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, lo=
ng status)
>  	nfs_local_pgio_done(hdr, status);
>  }
> =20
> -static int
> -nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *filp,
> -		const struct rpc_call_ops *call_ops)
> +static void nfs_local_call_write(struct work_struct *work)
>  {
> -	struct nfs_local_kiocb *iocb;
> +	struct nfs_local_io_args *args =3D
> +		container_of(work, struct nfs_local_io_args, work);
> +	struct nfs_local_kiocb *iocb =3D args->iocb;
> +	struct file *filp =3D iocb->kiocb.ki_filp;
>  	struct iov_iter iter;
>  	ssize_t status;
> =20
> +	nfs_local_iter_init(&iter, iocb, WRITE);
> +
> +	file_start_write(filp);
> +	status =3D filp->f_op->write_iter(&iocb->kiocb, &iter);
> +	file_end_write(filp);
> +	if (status !=3D -EIOCBQUEUED) {
> +		nfs_local_write_done(iocb, status);
> +		nfs_get_vfs_attr(filp, iocb->hdr->res.fattr);
> +		nfs_local_pgio_release(iocb);
> +	}
> +	complete(args->done);
> +}
> +
> +static int nfs_do_local_write(struct nfs_pgio_header *hdr, struct file *fi=
lp,
> +			      const struct rpc_call_ops *call_ops)
> +{
> +	struct nfs_local_io_args args;
> +	DECLARE_COMPLETION_ONSTACK(done);
> +	struct nfs_local_kiocb *iocb;
> +
>  	dprintk("%s: vfs_write count=3D%u pos=3D%llu %s\n",
>  		__func__, hdr->args.count, hdr->args.offset,
>  		(hdr->args.stable =3D=3D NFS_UNSTABLE) ?  "unstable" : "stable");
> @@ -435,7 +486,6 @@ nfs_do_local_write(struct nfs_pgio_header *hdr, struct =
file *filp,
>  	iocb =3D nfs_local_iocb_alloc(hdr, filp, GFP_NOIO);
>  	if (iocb =3D=3D NULL)
>  		return -ENOMEM;
> -	nfs_local_iter_init(&iter, iocb, WRITE);
> =20
>  	switch (hdr->args.stable) {
>  	default:
> @@ -450,14 +500,20 @@ nfs_do_local_write(struct nfs_pgio_header *hdr, struc=
t file *filp,
> =20
>  	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
> =20
> -	file_start_write(filp);
> -	status =3D filp->f_op->write_iter(&iocb->kiocb, &iter);
> -	file_end_write(filp);
> -	if (status !=3D -EIOCBQUEUED) {
> -		nfs_local_write_done(iocb, status);
> -		nfs_get_vfs_attr(filp, hdr->res.fattr);
> -		nfs_local_pgio_release(iocb);
> -	}
> +	/*
> +	 * Don't call filesystem write() routines directly.
> +	 * Some filesystem writeback routines can end up taking up a lot of
> +	 * stack (particularly xfs). Instead of risking running over due to
> +	 * the extra overhead from the NFS stack, call these write routines
> +	 * from a workqueue job.
> +	 */
> +	args.iocb =3D iocb;
> +	args.done =3D &done;
> +	INIT_WORK_ONSTACK(&args.work, nfs_local_call_write);
> +	queue_work(nfslocaliod_workqueue, &args.work);
> +	wait_for_completion(&done);
> +	destroy_work_on_stack(&args.work);
> +
>  	return 0;
>  }
> =20
> --=20
> 2.44.0
>=20
>=20


