Return-Path: <linux-nfs+bounces-7993-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B979CD604
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 04:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA0AB20B45
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 03:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC701459EA;
	Fri, 15 Nov 2024 03:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fUiNRfck";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="apH1p/PX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eJEQXbbu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LtfS/7gO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA9F42ABD
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 03:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731642956; cv=none; b=o48nifnqfy9fUIxyvlJXlqe82UmwHNVG5qir1pqVae5mui7+qUhO5K6+6JbaMCdK9yvsJ6dkFFIkgXfDTKOo4WE6FDQPYkpb4CR70tFyRdth33yLkFblZs/llHefgFkQuVa+zU2+iyCr5DvaJ4LnWKPyANhDcn0h74if1LSrAkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731642956; c=relaxed/simple;
	bh=FwRIGbw9KbnsTqReeHinTIj5O4HFmVjpVqp4gUAMqds=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=apUBkuwAMnjO1r4YMReIZ/SivVHbvNUQqz/3Q2fyGXlVWEEbfNgT+y8mb7PUhqLUsshlyHHpKXUJpYs1PGctZcpMhCvyItlBUuC8O9bPqUORH5+F05z7B6sB1N6pvAnH3Rmyj7UWaLhJz5zFsHxvcoN2qHUUtqHoCzxeCgnH484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fUiNRfck; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=apH1p/PX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eJEQXbbu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LtfS/7gO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D04B21F84D;
	Fri, 15 Nov 2024 03:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731642952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=77rosiROFoiuWUnUFH7ufPrTfJG87TwbN/Ak93dDtKI=;
	b=fUiNRfckvdakkTcQQ2FoDEzF5SHHkxBnCskJsciiZRra+xvWKP0BQQYnPhR96U1Ql+PP6r
	aPDCPH4jtfTlmmhvJnzzz2hx1nI/Ne/tCYiD5DY8n5CNopENQo0hJpLLCJ03FK3WMrpuYO
	l39fwupN/k+FOto34YWic/mKsL5PxhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731642952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=77rosiROFoiuWUnUFH7ufPrTfJG87TwbN/Ak93dDtKI=;
	b=apH1p/PXAPgYMm7/wktMyv/qM28Z4lK94BQtnvBS0ZYLOg/ArN22Gihfei543AZtUgCTCL
	ZPWNJmhMBhTXtWDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eJEQXbbu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="LtfS/7gO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731642950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=77rosiROFoiuWUnUFH7ufPrTfJG87TwbN/Ak93dDtKI=;
	b=eJEQXbbuIKgZ6GKRYrKI0vXq7cLqeb7WdSRQbhluEM1TaH011mavpbvuiItyyqxo9WgqAS
	OuCFZpzKLlAdrAbd4yz0bzI1PHuO1CoEXuVQh1lPXh/2xsaVu7v/9IkQnGIECaPBQsYWDR
	fBCfy80zDqNBqppbSI7JxqkIj5y/UsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731642950;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=77rosiROFoiuWUnUFH7ufPrTfJG87TwbN/Ak93dDtKI=;
	b=LtfS/7gOySeWpldZheUd07RTFBsaMjrROflPExWp59EEvUe2XbPWIdyeze2FbjYDxodSoP
	A9YI/hm+Y9lWDFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B25681347F;
	Fri, 15 Nov 2024 03:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4mVWGUTGNmfgYgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 15 Nov 2024 03:55:48 +0000
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
Subject: Re: [for-6.13 PATCH v2 15/15] nfs: probe for LOCALIO when v3 client
 reconnects to server
In-reply-to: <20241114035952.13889-16-snitzer@kernel.org>
References: <20241114035952.13889-1-snitzer@kernel.org>,
 <20241114035952.13889-16-snitzer@kernel.org>
Date: Fri, 15 Nov 2024 14:55:41 +1100
Message-id: <173164294134.1734440.17660781932071314545@noble.neil.brown.name>
X-Rspamd-Queue-Id: D04B21F84D
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[noble.neil.brown.name:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, 14 Nov 2024, Mike Snitzer wrote:
> Re-enabling NFSv3 LOCALIO is made more complex (than NFSv4) because v3
> is stateless.  As such, the hueristic used to identify a LOCALIO probe
> point is more adhoc by nature: if/when NFSv3 client IO begins to
> complete again in terms of normal RPC-based NFSv3 server IO, attempt
> nfs_local_probe_async().
>=20
> Care is taken to throttle the frequency of nfs_local_probe_async(),
> otherwise there could be a flood of repeat calls to
> nfs_local_probe_async().
>=20
> This approach works for most use-cases but it doesn't handle the
> possibility of using HA to migrate an NFS server local to the same
> host as an NFS client that is actively connected to the migrated NFS
> server. NFSv3 LOCALIO won't handle this case given it relies on the
> client having been flagged with NFS_CS_LOCAL_IO when the client was
> created on the host (e.g. mount time).

You could simply remove the NFS_CS_LOCAL_IO flag from the patch
completely, and always probe every 512 IO requests.  That would not be
much worse, and would be substantially better.

Then we would be well placed to remove "struct nfs_client" from
nfs_common.

NeilBrown


>=20
> Alternatve approaches have been discussed but there isn't clear
> consensus yet.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/internal.h          |  5 +++++
>  fs/nfs/localio.c           | 18 +++++++++++++++++-
>  fs/nfs/nfs3proc.c          | 32 +++++++++++++++++++++++++++++---
>  fs/nfs_common/nfslocalio.c |  1 +
>  include/linux/nfslocalio.h |  3 ++-
>  5 files changed, 54 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index ad9c56bc977bf..14f4d871b6a30 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -470,6 +470,7 @@ extern int nfs_local_commit(struct nfsd_file *,
>  			    struct nfs_commit_data *,
>  			    const struct rpc_call_ops *, int);
>  extern bool nfs_server_is_local(const struct nfs_client *clp);
> +extern bool nfs_server_was_local(const struct nfs_client *clp);
> =20
>  #else /* CONFIG_NFS_LOCALIO */
>  static inline void nfs_local_probe(struct nfs_client *clp) {}
> @@ -498,6 +499,10 @@ static inline bool nfs_server_is_local(const struct nf=
s_client *clp)
>  {
>  	return false;
>  }
> +static inline bool nfs_server_was_local(const struct nfs_client *clp)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_NFS_LOCALIO */
> =20
>  /* super.c */
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index 1eee5aac28843..d5152aa46813c 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -65,6 +65,17 @@ bool nfs_server_is_local(const struct nfs_client *clp)
>  }
>  EXPORT_SYMBOL_GPL(nfs_server_is_local);
> =20
> +static inline bool nfs_client_was_local(const struct nfs_client *clp)
> +{
> +	return !!test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> +}
> +
> +bool nfs_server_was_local(const struct nfs_client *clp)
> +{
> +	return nfs_client_was_local(clp) && localio_enabled;
> +}
> +EXPORT_SYMBOL_GPL(nfs_server_was_local);
> +
>  /*
>   * UUID_IS_LOCAL XDR functions
>   */
> @@ -187,8 +198,13 @@ void nfs_local_probe(struct nfs_client *clp)
> =20
>  	if (!nfs_uuid_begin(&clp->cl_uuid))
>  		return;
> -	if (nfs_server_uuid_is_local(clp))
> +	if (nfs_server_uuid_is_local(clp)) {
>  		nfs_localio_enable_client(clp);
> +		/* Set hint that client and server are LOCALIO capable */
> +		spin_lock(&clp->cl_uuid.lock);
> +		set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> +		spin_unlock(&clp->cl_uuid.lock);
> +	}
>  	nfs_uuid_end(&clp->cl_uuid);
>  }
>  EXPORT_SYMBOL_GPL(nfs_local_probe);
> diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
> index 1566163c6d85b..6ed2e4466002d 100644
> --- a/fs/nfs/nfs3proc.c
> +++ b/fs/nfs/nfs3proc.c
> @@ -844,6 +844,27 @@ nfs3_proc_pathconf(struct nfs_server *server, struct n=
fs_fh *fhandle,
>  	return status;
>  }
> =20
> +static void nfs3_local_probe(struct nfs_server *server)
> +{
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	struct nfs_client *clp =3D server->nfs_client;
> +	nfs_uuid_t *nfs_uuid =3D &clp->cl_uuid;
> +
> +	if (likely(!nfs_server_was_local(clp)))
> +		return;
> +	/*
> +	 * Try re-enabling LOCALIO if it was previously enabled, but
> +	 * was disabled due to server restart, and IO has successfully
> +	 * completed in terms of normal RPC.
> +	 */
> +	/* Arbitrary throttle to reduce nfs_local_probe_async() frequency */
> +	if ((nfs_uuid->local_probe_count++ & 511) =3D=3D 0) {
> +		if (unlikely(!nfs_server_is_local(clp) && nfs_server_was_local(clp)))
> +			nfs_local_probe_async(clp);
> +	}
> +#endif
> +}
> +
>  static int nfs3_read_done(struct rpc_task *task, struct nfs_pgio_header *h=
dr)
>  {
>  	struct inode *inode =3D hdr->inode;
> @@ -855,8 +876,11 @@ static int nfs3_read_done(struct rpc_task *task, struc=
t nfs_pgio_header *hdr)
>  	if (nfs3_async_handle_jukebox(task, inode))
>  		return -EAGAIN;
> =20
> -	if (task->tk_status >=3D 0 && !server->read_hdrsize)
> -		cmpxchg(&server->read_hdrsize, 0, hdr->res.replen);
> +	if (task->tk_status >=3D 0) {
> +		if (!server->read_hdrsize)
> +			cmpxchg(&server->read_hdrsize, 0, hdr->res.replen);
> +		nfs3_local_probe(server);
> +	}
> =20
>  	nfs_invalidate_atime(inode);
>  	nfs_refresh_inode(inode, &hdr->fattr);
> @@ -886,8 +910,10 @@ static int nfs3_write_done(struct rpc_task *task, stru=
ct nfs_pgio_header *hdr)
> =20
>  	if (nfs3_async_handle_jukebox(task, inode))
>  		return -EAGAIN;
> -	if (task->tk_status >=3D 0)
> +	if (task->tk_status >=3D 0) {
>  		nfs_writeback_update_inode(hdr);
> +		nfs3_local_probe(NFS_SERVER(inode));
> +	}
>  	return 0;
>  }
> =20
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 0a26c0ca99c21..41c0077ead721 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -43,6 +43,7 @@ void nfs_uuid_init(nfs_uuid_t *nfs_uuid)
>  	INIT_LIST_HEAD(&nfs_uuid->list);
>  	INIT_LIST_HEAD(&nfs_uuid->files);
>  	spin_lock_init(&nfs_uuid->lock);
> +	nfs_uuid->local_probe_count =3D 0;
>  }
>  EXPORT_SYMBOL_GPL(nfs_uuid_init);
> =20
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index c68a529230c14..e05f1cf3cf476 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -27,7 +27,8 @@ struct nfs_file_localio;
>   */
>  typedef struct {
>  	uuid_t uuid;
> -	/* sadly this struct is just over a cacheline, avoid bouncing */
> +	unsigned local_probe_count;
> +	/* sadly this struct is over a cacheline, avoid bouncing */
>  	spinlock_t ____cacheline_aligned lock;
>  	struct list_head list;
>  	spinlock_t *list_lock; /* nn->local_clients_lock */
> --=20
> 2.44.0
>=20
>=20


