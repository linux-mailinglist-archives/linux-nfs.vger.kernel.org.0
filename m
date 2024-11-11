Return-Path: <linux-nfs+bounces-7846-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9071C9C36DA
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 04:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF18C1C2082F
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 03:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03E913D619;
	Mon, 11 Nov 2024 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L/tgSJD/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YNMzkSw/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V1ezF6PJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TwSzT0BX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE42C79CD
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 03:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731294393; cv=none; b=U/eUDHXAZIOmmdvfV1kSy7TwZNlojpfsr1e/9HXRXUl0dSSTNUSSV7WWqjWCa8zTRscBIh8ei+xHTJO9QgeOQZevvnxc09gBy1L9Rr8Q/Md7mla1TnFBNsv5kYlkkqxxgEPr+o52ei/PKRZM+WS7LytW4aQaNRpkzFgbeYoURDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731294393; c=relaxed/simple;
	bh=4Zxq05GleDJ78hCivYnOeUR2Am5JHMrlognUA+T6TXU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=iNPJ+3d63jOe9grvOCcBzoD1gBVicJmp5oV6oTNIqSWqQF/r2bTPHy5Wl5Sg99/sPED7TcB1QptatX7yvq8xF+miLbN8H+zJPnyrh01krrHMbdPM8YoZ+ff8ykHzZVv3VfX+ymRgQhZbl79JguC45lXiEo74bS6kisiZoFAZle8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L/tgSJD/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YNMzkSw/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V1ezF6PJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TwSzT0BX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB1A0219EA;
	Mon, 11 Nov 2024 03:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731294390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZUOC10Z5sIPlwOBuHtJ0gegxagkUSXOLsreKk6sodI=;
	b=L/tgSJD/JeCGqqnJQcmz5G0AWNMYoUumRb7/LfdqTbhjst2Spwi5eoBWUB+I+rcKYo8hdz
	DZCfxNBVhACM5CcjOkDY887zXrLUu8EXN9LWJPx07Q3GiCL5bnRxLsyp2HB/TCby57eMGH
	Vo5uq9AiA9N4Z1OerEIBPbpnrK3cj84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731294390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZUOC10Z5sIPlwOBuHtJ0gegxagkUSXOLsreKk6sodI=;
	b=YNMzkSw/v4MNJQIIR6PfWaoK+S6mqwhDatD0tUpbJT66ZemBYIeQ+eOiVr3Xn8ch25BzNC
	Sc7wLXluKhTQ53DQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V1ezF6PJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TwSzT0BX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731294389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZUOC10Z5sIPlwOBuHtJ0gegxagkUSXOLsreKk6sodI=;
	b=V1ezF6PJe/uQa/lavDyooMfJcJTcKO3IYDG9018ftSoiFg43StGS5isNxpvAn0iU9TFH/H
	3B/GaCh2TMuBOCuEajNHWULOVjMYmMNJf7EZBgvZ0QaKvHtqZgmvaYQy/bp2u2LyY7jUaP
	iFUQG5MYF5BDSy+oFRwQUCJ7nXlvyWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731294389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZUOC10Z5sIPlwOBuHtJ0gegxagkUSXOLsreKk6sodI=;
	b=TwSzT0BXKWaRBtBn/hjI2zwGzSCl5uvFBPd7hpQM/YDybUMNSwQ1LWa0ii6RUGTOOgg6/c
	MxTy0qvmqX2M+ZDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE541137FB;
	Mon, 11 Nov 2024 03:06:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yAe9JLN0MWeUGQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Nov 2024 03:06:27 +0000
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
Subject: Re: [for-6.13 PATCH 19/19] nfs: probe for LOCALIO when v3 client
 reconnects to server
In-reply-to: <20241108234002.16392-20-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>,
 <20241108234002.16392-20-snitzer@kernel.org>
Date: Mon, 11 Nov 2024 14:06:17 +1100
Message-id: <173129437701.1734440.15421867470403487809@noble.neil.brown.name>
X-Rspamd-Queue-Id: EB1A0219EA
X-Spam-Level: 
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
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Sat, 09 Nov 2024, Mike Snitzer wrote:
> Re-enabling NFSv3 LOCALIO is made more complex (than NFSv4) because v3
> is stateless.  As such, the hueristic used to identify a LOCALIO probe
> point is more adhoc by nature: if/when NFSv3 client IO begins to
> complete again in terms of normal RPC-based NFSv3 server IO, attempt
> nfs_local_probe_async().
>=20
> Care is taken to throttle the frequency of nfs_local_probe_async(),
> otherwise there could be a flood of repeat calls to
> nfs_local_probe_async().

I think it would be good to limit this to only probing when the network
connection is reestablished - assuming we can ignore connectionless
protocols like UDP.

I think you can stash rpc_clnt->cl_xprt->connect_cookie and check if
that has changed or not.  If not, then there is no point probing again.

Thanks,
NeilBrown


>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/internal.h          |  5 +++++
>  fs/nfs/localio.c           | 11 +++++++++++
>  fs/nfs/nfs3proc.c          | 34 +++++++++++++++++++++++++++++++---
>  fs/nfs_common/nfslocalio.c |  4 ++++
>  include/linux/nfs_fs_sb.h  |  1 +
>  include/linux/nfslocalio.h |  4 +++-
>  6 files changed, 55 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
> index efd42efd9405..fb1ab7cee6b9 100644
> --- a/fs/nfs/internal.h
> +++ b/fs/nfs/internal.h
> @@ -470,6 +470,7 @@ extern int nfs_local_commit(struct nfsd_file *,
>  			    struct nfs_commit_data *,
>  			    const struct rpc_call_ops *, int);
>  extern bool nfs_server_is_local(const struct nfs_client *clp);
> +extern bool nfs_server_was_local(const struct nfs_client *clp);
> =20
>  #else /* CONFIG_NFS_LOCALIO */
>  static inline void nfs_local_disable(struct nfs_client *clp) {}
> @@ -499,6 +500,10 @@ static inline bool nfs_server_is_local(const struct nf=
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
> index 710e537b3402..1559dc2f1850 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -64,6 +64,17 @@ bool nfs_server_is_local(const struct nfs_client *clp)
>  }
>  EXPORT_SYMBOL_GPL(nfs_server_is_local);
> =20
> +static inline bool nfs_client_was_local(const struct nfs_client *clp)
> +{
> +	return !!test_bit(NFS_CS_LOCAL_IO_CAPABLE, &clp->cl_flags);
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
> diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
> index 1566163c6d85..4d2018760e9b 100644
> --- a/fs/nfs/nfs3proc.c
> +++ b/fs/nfs/nfs3proc.c
> @@ -844,6 +844,29 @@ nfs3_proc_pathconf(struct nfs_server *server, struct n=
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
> +	mutex_lock(&nfs_uuid->local_probe_mutex);
> +	/* Arbitrary throttle to reduce nfs_local_probe_async() frequency */
> +	if ((nfs_uuid->local_probe_count++ & 255) =3D=3D 0) {
> +		if (unlikely(!nfs_server_is_local(clp) && nfs_server_was_local(clp)))
> +			nfs_local_probe_async(clp);
> +	}
> +	mutex_unlock(&nfs_uuid->local_probe_mutex);
> +#endif
> +}
> +
>  static int nfs3_read_done(struct rpc_task *task, struct nfs_pgio_header *h=
dr)
>  {
>  	struct inode *inode =3D hdr->inode;
> @@ -855,8 +878,11 @@ static int nfs3_read_done(struct rpc_task *task, struc=
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
> @@ -886,8 +912,10 @@ static int nfs3_write_done(struct rpc_task *task, stru=
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
> index fb376d38ac9a..852ba8fd73f3 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -43,6 +43,8 @@ void nfs_uuid_init(nfs_uuid_t *nfs_uuid)
>  	INIT_LIST_HEAD(&nfs_uuid->list);
>  	INIT_LIST_HEAD(&nfs_uuid->files);
>  	spin_lock_init(&nfs_uuid->lock);
> +	mutex_init(&nfs_uuid->local_probe_mutex);
> +	nfs_uuid->local_probe_count =3D 0;
>  }
>  EXPORT_SYMBOL_GPL(nfs_uuid_init);
> =20
> @@ -143,6 +145,8 @@ void nfs_localio_enable_client(struct nfs_client *clp)
> =20
>  	spin_lock(&nfs_uuid->lock);
>  	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> +	/* Also set hint that client and server are LOCALIO capable */
> +	set_bit(NFS_CS_LOCAL_IO_CAPABLE, &clp->cl_flags);
>  	trace_nfs_localio_enable_client(clp);
>  	spin_unlock(&nfs_uuid->lock);
>  }
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 63d7e0f478d8..45906c402c98 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -51,6 +51,7 @@ struct nfs_client {
>  #define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
>  #define NFS_CS_PNFS		9		/* - Server used for pnfs */
>  #define NFS_CS_LOCAL_IO		10		/* - client is local */
> +#define NFS_CS_LOCAL_IO_CAPABLE		11	/* - client was previously local */
>  	struct sockaddr_storage	cl_addr;	/* server identifier */
>  	size_t			cl_addrlen;
>  	char *			cl_hostname;	/* hostname of server */
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index c68a529230c1..3dfef0bb18fe 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -27,7 +27,9 @@ struct nfs_file_localio;
>   */
>  typedef struct {
>  	uuid_t uuid;
> -	/* sadly this struct is just over a cacheline, avoid bouncing */
> +	struct mutex local_probe_mutex;
> +	unsigned local_probe_count;
> +	/* sadly this struct is over a cacheline, avoid bouncing */
>  	spinlock_t ____cacheline_aligned lock;
>  	struct list_head list;
>  	spinlock_t *list_lock; /* nn->local_clients_lock */
> --=20
> 2.44.0
>=20
>=20
>=20


