Return-Path: <linux-nfs+bounces-7842-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528C59C3625
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 02:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117B6280EF2
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 01:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C002B67F;
	Mon, 11 Nov 2024 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Whx5jILn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B0uYZBB7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Whx5jILn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B0uYZBB7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D55422F11
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 01:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288783; cv=none; b=FslxjN2OfTMhHO/xH6xp4AoTo4C8CMDtZa4AaymePTbVnM57gRX0H3ps0C/109lol5/V6lDJiaA/LLApULD5zfj1Z4WNZPK/BXtrKkjpDAEumecNFb8VGeFCVarAOUwQ0E9k8PG+Y49Voi/e27/aE2fk9Ts1Qn7nqpndHR/lPjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288783; c=relaxed/simple;
	bh=d3YrWhOyiWsBCyy2G95Mw+iPJO7gWYaV5yExRCcTZYY=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=C1zV6dXaMW2RXQemXkPC+riiI/kbvRruDUu2EytvxXkAHKXB4sMr0R1xBVSpjCDRjYHXIfxxcgfJMbc1KZ1haq64XAqPU3xHckCRS51gFpXiLw3SQU1HEqjc7+BqSnbssxhAekXow6gGZhbA8ZOd1yQYDKB+YDhLlp65tmq7b5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Whx5jILn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B0uYZBB7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Whx5jILn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B0uYZBB7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B28CF1F38E;
	Mon, 11 Nov 2024 01:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731288779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgHLEH5JwpcthPiJNZX2Iy3BHnJabfYe6fdSX6WcM4k=;
	b=Whx5jILnotxYCJCtOA8WyY+V99E4qStYwdLYt1s0ch1qmcDrzlsCOn/ihz+i5Rn1B/yrJ7
	mPZfsVOdvtGHOUvZ/38uV2l6PvhPrsHG4LS5+os5pwZW5E3jG1trDEwy5kIn6r18cZilL2
	DAOWnHU41Ib5tfD4Onn02aMiO3d3yGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731288779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgHLEH5JwpcthPiJNZX2Iy3BHnJabfYe6fdSX6WcM4k=;
	b=B0uYZBB7PAZZhMXmm/FqcI0l/r9tKJcKpRRvNzPELnNC5UpEBCdGymYI3GZsq/nRQUAaMd
	SARixA32aFmicjCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731288779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgHLEH5JwpcthPiJNZX2Iy3BHnJabfYe6fdSX6WcM4k=;
	b=Whx5jILnotxYCJCtOA8WyY+V99E4qStYwdLYt1s0ch1qmcDrzlsCOn/ihz+i5Rn1B/yrJ7
	mPZfsVOdvtGHOUvZ/38uV2l6PvhPrsHG4LS5+os5pwZW5E3jG1trDEwy5kIn6r18cZilL2
	DAOWnHU41Ib5tfD4Onn02aMiO3d3yGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731288779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgHLEH5JwpcthPiJNZX2Iy3BHnJabfYe6fdSX6WcM4k=;
	b=B0uYZBB7PAZZhMXmm/FqcI0l/r9tKJcKpRRvNzPELnNC5UpEBCdGymYI3GZsq/nRQUAaMd
	SARixA32aFmicjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9AE6137FB;
	Mon, 11 Nov 2024 01:32:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XFNQGMleMWcXfQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Nov 2024 01:32:57 +0000
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
Subject: Re: [for-6.13 PATCH 09/19] nfs_common: rename functions that
 invalidate LOCALIO nfs_clients
In-reply-to: <20241108234002.16392-10-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>,
 <20241108234002.16392-10-snitzer@kernel.org>
Date: Mon, 11 Nov 2024 12:32:50 +1100
Message-id: <173128877080.1734440.4855614018882617409@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Sat, 09 Nov 2024, Mike Snitzer wrote:
> Rename nfs_uuid_invalidate_one_client to nfs_localio_disable_client.
> Rename nfs_uuid_invalidate_clients to nfs_localio_invalidate_clients.

I agree that is an improvement.

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown


>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/localio.c           | 2 +-
>  fs/nfs_common/nfslocalio.c | 8 ++++----
>  fs/nfsd/nfsctl.c           | 4 ++--
>  include/linux/nfslocalio.h | 5 +++--
>  4 files changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index de0dcd76d84d..cab2a8819259 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -139,7 +139,7 @@ void nfs_local_disable(struct nfs_client *clp)
>  	spin_lock(&clp->cl_localio_lock);
>  	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
>  		trace_nfs_local_disable(clp);
> -		nfs_uuid_invalidate_one_client(&clp->cl_uuid);
> +		nfs_localio_disable_client(&clp->cl_uuid);
>  	}
>  	spin_unlock(&clp->cl_localio_lock);
>  }
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index a74ec08f6c96..904439e4bb85 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -107,7 +107,7 @@ static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
>  	list_del_init(&nfs_uuid->list);
>  }
> =20
> -void nfs_uuid_invalidate_clients(struct list_head *list)
> +void nfs_localio_invalidate_clients(struct list_head *list)
>  {
>  	nfs_uuid_t *nfs_uuid, *tmp;
> =20
> @@ -116,9 +116,9 @@ void nfs_uuid_invalidate_clients(struct list_head *list)
>  		nfs_uuid_put_locked(nfs_uuid);
>  	spin_unlock(&nfs_uuid_lock);
>  }
> -EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_clients);
> +EXPORT_SYMBOL_GPL(nfs_localio_invalidate_clients);
> =20
> -void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid)
> +void nfs_localio_disable_client(nfs_uuid_t *nfs_uuid)
>  {
>  	if (nfs_uuid->net) {
>  		spin_lock(&nfs_uuid_lock);
> @@ -126,7 +126,7 @@ void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uui=
d)
>  		spin_unlock(&nfs_uuid_lock);
>  	}
>  }
> -EXPORT_SYMBOL_GPL(nfs_uuid_invalidate_one_client);
> +EXPORT_SYMBOL_GPL(nfs_localio_disable_client);
> =20
>  struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
>  		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 3adbc05ebaac..727904d8a4d0 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2276,14 +2276,14 @@ static __net_init int nfsd_net_init(struct net *net)
>   * nfsd_net_pre_exit - Disconnect localio clients from net namespace
>   * @net: a network namespace that is about to be destroyed
>   *
> - * This invalidated ->net pointers held by localio clients
> + * This invalidates ->net pointers held by localio clients
>   * while they can still safely access nn->counter.
>   */
>  static __net_exit void nfsd_net_pre_exit(struct net *net)
>  {
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
> -	nfs_uuid_invalidate_clients(&nn->local_clients);
> +	nfs_localio_invalidate_clients(&nn->local_clients);
>  }
>  #endif
> =20
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index ab6a2a53f505..a05d1043f2b0 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -37,8 +37,9 @@ bool nfs_uuid_begin(nfs_uuid_t *);
>  void nfs_uuid_end(nfs_uuid_t *);
>  void nfs_uuid_is_local(const uuid_t *, struct list_head *,
>  		       struct net *, struct auth_domain *, struct module *);
> -void nfs_uuid_invalidate_clients(struct list_head *list);
> -void nfs_uuid_invalidate_one_client(nfs_uuid_t *nfs_uuid);
> +
> +void nfs_localio_disable_client(nfs_uuid_t *nfs_uuid);
> +void nfs_localio_invalidate_clients(struct list_head *list);
> =20
>  /* localio needs to map filehandle -> struct nfsd_file */
>  extern struct nfsd_file *
> --=20
> 2.44.0
>=20
>=20


