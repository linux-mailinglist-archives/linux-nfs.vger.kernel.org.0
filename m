Return-Path: <linux-nfs+bounces-7843-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADE79C3646
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 02:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4ED2812FE
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 01:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61481B95B;
	Mon, 11 Nov 2024 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R+X8Zvc8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gx56lGTs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="htjMQfnR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X4dWOVTm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8BC4C66
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731290141; cv=none; b=auhw6nOyzxtZLPHuwaTp3sFSipiYX+OP+yMh64opu60t+238i9GYuZP67bTUROBxc3fIZfyfYrFow+rgWw3c849AjXoBthvJ2a99EEBXayrNOBksujq0WHw5OcggF51xQjSXH8iDL9pLjhOJfb5/jB3pT6jX66kQY+Cy5I9EuRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731290141; c=relaxed/simple;
	bh=IPuJb6IwHoYjHuY5N1BAJJHVUF3ViKZDMgfmozkSEt8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ChscJpsZ0S8OBBdPIsXRtdace+hHtPDxGWX99VD2kePWnSwhkSTKGkJGLAc+JrXAltpqotr+Dl8xr6/RUY/ATuFl9ITCfB87lC3III+617PZzcQ5BbxvnCV8cbWsS3Zn/4F7PNASWDApTxzAuOQrcVMVHHEtYAiiwEhmibZumoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R+X8Zvc8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gx56lGTs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=htjMQfnR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X4dWOVTm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2E55219ED;
	Mon, 11 Nov 2024 01:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731290138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+tzUtVpr96C4aBm16xkyVlrIA62vF+/8BwBKH280gY=;
	b=R+X8Zvc8Zc6wc0KOhzT90aqjMC+dFxh20Rw5LB3U4CJGALf72dgOqYUjHXAurpboXqa65f
	ocOMP4k3Yr4uj3EgX+e4jLhMZeaR9qTgn5wi8WlmEhT16nCtZgzQNWHqkEvYqI0InMNwQH
	lj7MwWA+I8IblgRp2w86T0c5qCoLQts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731290138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+tzUtVpr96C4aBm16xkyVlrIA62vF+/8BwBKH280gY=;
	b=gx56lGTsMjbWlanTxSMzN+7dWV5lOAvItzL12G6X6eL11FhxguMFSe0qWzZbzYsxjPu7sO
	GHauh3eCKxwsZhCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=htjMQfnR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=X4dWOVTm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731290137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+tzUtVpr96C4aBm16xkyVlrIA62vF+/8BwBKH280gY=;
	b=htjMQfnRw+oXGRwfuR55vEOVla3QvkMG9nTdNlIK78Mu0iro1EDQTr+LyWr8xpVHMHpVyd
	JiFqniHOtc5QeiqQbJ2cwK2gRdb+QhEZz3sv/5Gn2l49SSpI4/D/NxwVh6Df1GL6DU+73k
	GLOR8d8eGTcMUeKl2VntS/MdidhcM28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731290137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+tzUtVpr96C4aBm16xkyVlrIA62vF+/8BwBKH280gY=;
	b=X4dWOVTmM9TUiCxj+cZMMiLPZP0Y5FUTrOd8kFHtcyLx1z0dLqJZqk0i47FbfIbZ18skuJ
	P47UQuRLTgEhtGDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 840F813690;
	Mon, 11 Nov 2024 01:55:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WaAkDxdkMWfJAwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Nov 2024 01:55:35 +0000
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
Subject: Re: [for-6.13 PATCH 10/19] nfs_common: move localio_lock to new lock
 member of nfs_uuid_t
In-reply-to: <20241108234002.16392-11-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>,
 <20241108234002.16392-11-snitzer@kernel.org>
Date: Mon, 11 Nov 2024 12:55:24 +1100
Message-id: <173129012433.1734440.14130461870880893050@noble.neil.brown.name>
X-Rspamd-Queue-Id: D2E55219ED
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Sat, 09 Nov 2024, Mike Snitzer wrote:
> Remove cl_localio_lock from 'struct nfs_client' in favor of adding a
> lock to the nfs_uuid_t struct (which is embedded in each nfs_client).
>=20
> Push nfs_local_{enable,disable} implementation down to nfs_common.
> Those methods now call nfs_localio_{enable,disable}_client.
>=20
> This allows implementing nfs_localio_invalidate_clients in terms of
> nfs_localio_disable_client.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/client.c            |  1 -
>  fs/nfs/localio.c           | 18 ++++++------
>  fs/nfs_common/nfslocalio.c | 57 ++++++++++++++++++++++++++------------
>  include/linux/nfs_fs_sb.h  |  1 -
>  include/linux/nfslocalio.h |  8 +++++-
>  5 files changed, 55 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index 03ecc7765615..124232054807 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -182,7 +182,6 @@ struct nfs_client *nfs_alloc_client(const struct nfs_cl=
ient_initdata *cl_init)
>  	seqlock_init(&clp->cl_boot_lock);
>  	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
>  	nfs_uuid_init(&clp->cl_uuid);
> -	spin_lock_init(&clp->cl_localio_lock);
>  #endif /* CONFIG_NFS_LOCALIO */
> =20
>  	clp->cl_principal =3D "*";
> diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> index cab2a8819259..4c75ffc5efa2 100644
> --- a/fs/nfs/localio.c
> +++ b/fs/nfs/localio.c
> @@ -125,10 +125,8 @@ const struct rpc_program nfslocalio_program =3D {
>   */
>  static void nfs_local_enable(struct nfs_client *clp)
>  {
> -	spin_lock(&clp->cl_localio_lock);
> -	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
>  	trace_nfs_local_enable(clp);
> -	spin_unlock(&clp->cl_localio_lock);
> +	nfs_localio_enable_client(clp);
>  }

Why do we need this function?  The one caller could call
nfs_localio_enable_client() directly instead.  The tracepoint could be
placed in that one caller.

> =20
>  /*
> @@ -136,12 +134,8 @@ static void nfs_local_enable(struct nfs_client *clp)
>   */
>  void nfs_local_disable(struct nfs_client *clp)
>  {
> -	spin_lock(&clp->cl_localio_lock);
> -	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
> -		trace_nfs_local_disable(clp);
> -		nfs_localio_disable_client(&clp->cl_uuid);
> -	}
> -	spin_unlock(&clp->cl_localio_lock);
> +	trace_nfs_local_disable(clp);
> +	nfs_localio_disable_client(clp);
>  }

Ditto.  Though there are more callers so the tracepoint solution isn't
quite so obvious.

> =20
>  /*
> @@ -183,8 +177,12 @@ static bool nfs_server_uuid_is_local(struct nfs_client=
 *clp)
>  	rpc_shutdown_client(rpcclient_localio);
> =20
>  	/* Server is only local if it initialized required struct members */
> -	if (status || !clp->cl_uuid.net || !clp->cl_uuid.dom)
> +	rcu_read_lock();
> +	if (status || !rcu_access_pointer(clp->cl_uuid.net) || !clp->cl_uuid.dom)=
 {
> +		rcu_read_unlock();
>  		return false;
> +	}
> +	rcu_read_unlock();

What value does RCU provide here?  I don't think this change is needed.
rcu_access_pointer does not require rcu_read_lock().

> =20
>  	return true;
>  }
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 904439e4bb85..cf2f47ea4f8d 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -7,6 +7,9 @@
>  #include <linux/module.h>
>  #include <linux/list.h>
>  #include <linux/nfslocalio.h>
> +#include <linux/nfs3.h>
> +#include <linux/nfs4.h>
> +#include <linux/nfs_fs_sb.h>

I don't feel good about adding this nfs client knowledge in to nfs_common.

>  #include <net/netns/generic.h>
> =20
>  MODULE_LICENSE("GPL");
> @@ -25,6 +28,7 @@ void nfs_uuid_init(nfs_uuid_t *nfs_uuid)
>  	nfs_uuid->net =3D NULL;
>  	nfs_uuid->dom =3D NULL;
>  	INIT_LIST_HEAD(&nfs_uuid->list);
> +	spin_lock_init(&nfs_uuid->lock);
>  }
>  EXPORT_SYMBOL_GPL(nfs_uuid_init);
> =20
> @@ -94,12 +98,23 @@ void nfs_uuid_is_local(const uuid_t *uuid, struct list_=
head *list,
>  }
>  EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
> =20
> +void nfs_localio_enable_client(struct nfs_client *clp)
> +{
> +	nfs_uuid_t *nfs_uuid =3D &clp->cl_uuid;
> +
> +	spin_lock(&nfs_uuid->lock);
> +	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> +	spin_unlock(&nfs_uuid->lock);
> +}
> +EXPORT_SYMBOL_GPL(nfs_localio_enable_client);

And I don't feel good about nfs_local accessing nfs_client directly.
It only uses it for NFS_CS_LOCAL_IO.  Can we ditch that flag and instead
so something like testing nfs_uuid.net ??

> +
>  static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
>  {
> -	if (nfs_uuid->net) {
> -		module_put(nfsd_mod);
> -		nfs_uuid->net =3D NULL;
> -	}
> +	if (!nfs_uuid->net)
> +		return;
> +	module_put(nfsd_mod);
> +	rcu_assign_pointer(nfs_uuid->net, NULL);
> +

I much prefer RCU_INIT_POINTER for assigning NULL as there is no need
for ordering here.

>  	if (nfs_uuid->dom) {
>  		auth_domain_put(nfs_uuid->dom);
>  		nfs_uuid->dom =3D NULL;
> @@ -107,27 +122,35 @@ static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
>  	list_del_init(&nfs_uuid->list);
>  }
> =20
> -void nfs_localio_invalidate_clients(struct list_head *list)
> +void nfs_localio_disable_client(struct nfs_client *clp)
> +{
> +	nfs_uuid_t *nfs_uuid =3D &clp->cl_uuid;
> +
> +	spin_lock(&nfs_uuid->lock);
> +	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
> +		spin_lock(&nfs_uuid_lock);
> +		nfs_uuid_put_locked(nfs_uuid);
> +		spin_unlock(&nfs_uuid_lock);
> +	}
> +	spin_unlock(&nfs_uuid->lock);
> +}
> +EXPORT_SYMBOL_GPL(nfs_localio_disable_client);
> +
> +void nfs_localio_invalidate_clients(struct list_head *cl_uuid_list)
>  {
>  	nfs_uuid_t *nfs_uuid, *tmp;
> =20
>  	spin_lock(&nfs_uuid_lock);
> -	list_for_each_entry_safe(nfs_uuid, tmp, list, list)
> -		nfs_uuid_put_locked(nfs_uuid);
> +	list_for_each_entry_safe(nfs_uuid, tmp, cl_uuid_list, list) {
> +		struct nfs_client *clp =3D
> +			container_of(nfs_uuid, struct nfs_client, cl_uuid);
> +
> +		nfs_localio_disable_client(clp);
> +	}
>  	spin_unlock(&nfs_uuid_lock);
>  }
>  EXPORT_SYMBOL_GPL(nfs_localio_invalidate_clients);
> =20
> -void nfs_localio_disable_client(nfs_uuid_t *nfs_uuid)
> -{
> -	if (nfs_uuid->net) {
> -		spin_lock(&nfs_uuid_lock);
> -		nfs_uuid_put_locked(nfs_uuid);
> -		spin_unlock(&nfs_uuid_lock);
> -	}
> -}
> -EXPORT_SYMBOL_GPL(nfs_localio_disable_client);
> -
>  struct nfsd_file *nfs_open_local_fh(nfs_uuid_t *uuid,
>  		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
>  		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index b804346a9741..239d86ef166c 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -132,7 +132,6 @@ struct nfs_client {
>  	struct timespec64	cl_nfssvc_boot;
>  	seqlock_t		cl_boot_lock;
>  	nfs_uuid_t		cl_uuid;
> -	spinlock_t		cl_localio_lock;
>  #endif /* CONFIG_NFS_LOCALIO */
>  };
> =20
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index a05d1043f2b0..4d5583873f41 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -6,6 +6,7 @@
>  #ifndef __LINUX_NFSLOCALIO_H
>  #define __LINUX_NFSLOCALIO_H
> =20
> +
>  /* nfsd_file structure is purposely kept opaque to NFS client */
>  struct nfsd_file;
> =20
> @@ -19,6 +20,8 @@ struct nfsd_file;
>  #include <linux/nfs.h>
>  #include <net/net_namespace.h>
> =20
> +struct nfs_client;
> +
>  /*
>   * Useful to allow a client to negotiate if localio
>   * possible with its server.
> @@ -27,6 +30,8 @@ struct nfsd_file;
>   */
>  typedef struct {
>  	uuid_t uuid;
> +	/* sadly this struct is just over a cacheline, avoid bouncing */
> +	spinlock_t ____cacheline_aligned lock;
>  	struct list_head list;
>  	struct net __rcu *net; /* nfsd's network namespace */
>  	struct auth_domain *dom; /* auth_domain for localio */
> @@ -38,7 +43,8 @@ void nfs_uuid_end(nfs_uuid_t *);
>  void nfs_uuid_is_local(const uuid_t *, struct list_head *,
>  		       struct net *, struct auth_domain *, struct module *);
> =20
> -void nfs_localio_disable_client(nfs_uuid_t *nfs_uuid);
> +void nfs_localio_enable_client(struct nfs_client *clp);
> +void nfs_localio_disable_client(struct nfs_client *clp);
>  void nfs_localio_invalidate_clients(struct list_head *list);
> =20
>  /* localio needs to map filehandle -> struct nfsd_file */
> --=20
> 2.44.0
>=20
>=20

I think this is a good refactoring to do, but I don't like some of the
details, or some of the RCU code.

NeilBrown

