Return-Path: <linux-nfs+bounces-4312-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB4F9174BB
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 01:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CB5281C90
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 23:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04401487C0;
	Tue, 25 Jun 2024 23:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lw2eL85e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Io5R5QfQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lw2eL85e";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Io5R5QfQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105CF14AD20
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719358393; cv=none; b=LKSVymPWtMKE7kzb+/hWLjpub7UbsZmdaxnk8xdiqAsFZ6RAM2oIWMZnpRLI2McVBW58EAlnAmdTyB7BiZvaV/8ptvCHp2Gn3Pb0zQe6HZNTmdFhFOFlgeJMMqPhw4d/fEaCk3dC4PZyD5tXfnKFvS+h796TGifNm7ZZKBVJIcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719358393; c=relaxed/simple;
	bh=aWal8vM40/leFSwMnKXwruq2sI94cALYZZyL9l2Ekn8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QzHGyueagMrHSbN9m0x0cI88J4fVCuQsDaGAaWN/jB8TseFbBce72RILiRsU7S5PnmF6LuDeejcqRxiz1KCnC6Zm87vm2ZcnPwsS/njyAQzztobDIUsTm4Em/QGVsNH4KUpiIcPPh/KlWTPId7MbEy/Fe8FMoRvaHj9Ctj1bl5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lw2eL85e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Io5R5QfQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lw2eL85e; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Io5R5QfQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2296721ABF;
	Tue, 25 Jun 2024 23:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719358390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMHyqfxiWXW3zcex/JE7wqV22B0HYpVxtQwSE6F/2Ww=;
	b=Lw2eL85eyGHf5F3nE3OfT5dVsdiVkWgXX8UaIpdwDnwYId5c3bPoVB+K/tSKSd4w8zml4B
	umoXDftHRVW2EFUUNI0tPJaIiTBo7knTxiAoaYcUXuTlElnOlyczMQxD3KW1KjEMa3lEwZ
	Gnj01nFa4YQjJ9vjPhc92q3qtwjo3Eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719358390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMHyqfxiWXW3zcex/JE7wqV22B0HYpVxtQwSE6F/2Ww=;
	b=Io5R5QfQL4FslkWikiSMbgf2NaQLSbOade9C2ig3fvy0AKbatsY5A3wovGctb9vgFjpGlw
	MlP/qUEyVOji2dBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719358390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMHyqfxiWXW3zcex/JE7wqV22B0HYpVxtQwSE6F/2Ww=;
	b=Lw2eL85eyGHf5F3nE3OfT5dVsdiVkWgXX8UaIpdwDnwYId5c3bPoVB+K/tSKSd4w8zml4B
	umoXDftHRVW2EFUUNI0tPJaIiTBo7knTxiAoaYcUXuTlElnOlyczMQxD3KW1KjEMa3lEwZ
	Gnj01nFa4YQjJ9vjPhc92q3qtwjo3Eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719358390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMHyqfxiWXW3zcex/JE7wqV22B0HYpVxtQwSE6F/2Ww=;
	b=Io5R5QfQL4FslkWikiSMbgf2NaQLSbOade9C2ig3fvy0AKbatsY5A3wovGctb9vgFjpGlw
	MlP/qUEyVOji2dBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A04E1384C;
	Tue, 25 Jun 2024 23:33:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9C/3BrNTe2YiSwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 25 Jun 2024 23:33:07 +0000
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
Subject: Re: [PATCH v7 05/20] nfs_common: add NFS LOCALIO auxiliary protocol
 enablement
In-reply-to: <20240624162741.68216-6-snitzer@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>,
 <20240624162741.68216-6-snitzer@kernel.org>
Date: Wed, 26 Jun 2024 09:33:03 +1000
Message-id: <171935838369.14261.10478134782573516898@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:email,imap1.dmz-prg2.suse.org:helo]

On Tue, 25 Jun 2024, Mike Snitzer wrote:
> First use is in nfsd, to add access to a global nfsd_uuids list that
> will be used to identify local nfsd instances.
>=20
> nfsd_uuids is protected by nfsd_mutex or RCU read lock.  List is
> composed of nfsd_uuid_t instances that are managed as nfsd creates
> them (per network namespace).
>=20
> nfsd_uuid_is_local() will be used to search all local nfsd for the
> client specified nfsd uuid.
>=20
> This commit also adds all the nfs_client members required to implement
> the entire localio feature (which depends on the LOCALIO protocol).
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs/client.c            |  8 +++++
>  fs/nfs_common/Makefile     |  3 ++
>  fs/nfs_common/nfslocalio.c | 72 ++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/netns.h            |  4 +++
>  fs/nfsd/nfssvc.c           | 12 ++++++-
>  include/linux/nfs_fs_sb.h  |  9 +++++
>  include/linux/nfslocalio.h | 39 +++++++++++++++++++++
>  7 files changed, 146 insertions(+), 1 deletion(-)
>  create mode 100644 fs/nfs_common/nfslocalio.c
>  create mode 100644 include/linux/nfslocalio.h
>=20
> diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> index de77848ae654..bcdf8d42cbc7 100644
> --- a/fs/nfs/client.c
> +++ b/fs/nfs/client.c
> @@ -178,6 +178,14 @@ struct nfs_client *nfs_alloc_client(const struct nfs_c=
lient_initdata *cl_init)
>  	clp->cl_max_connect =3D cl_init->max_connect ? cl_init->max_connect : 1;
>  	clp->cl_net =3D get_net(cl_init->net);
> =20
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	seqlock_init(&clp->cl_boot_lock);
> +	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
> +	clp->cl_rpcclient_localio =3D ERR_PTR(-EINVAL);
> +	clp->nfsd_open_local_fh =3D NULL;
> +	clp->cl_nfssvc_net =3D NULL;
> +#endif /* CONFIG_NFS_LOCALIO */
> +
>  	clp->cl_principal =3D "*";
>  	clp->cl_xprtsec =3D cl_init->xprtsec;
>  	return clp;
> diff --git a/fs/nfs_common/Makefile b/fs/nfs_common/Makefile
> index 119c75ab9fd0..d81623b76aba 100644
> --- a/fs/nfs_common/Makefile
> +++ b/fs/nfs_common/Makefile
> @@ -6,5 +6,8 @@
>  obj-$(CONFIG_NFS_ACL_SUPPORT) +=3D nfs_acl.o
>  nfs_acl-objs :=3D nfsacl.o
> =20
> +obj-$(CONFIG_NFS_COMMON_LOCALIO_SUPPORT) +=3D nfs_localio.o
> +nfs_localio-objs :=3D nfslocalio.o
> +
>  obj-$(CONFIG_GRACE_PERIOD) +=3D grace.o
>  obj-$(CONFIG_NFS_V4_2_SSC_HELPER) +=3D nfs_ssc.o
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> new file mode 100644
> index 000000000000..755b84b742a6
> --- /dev/null
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/rculist.h>
> +#include <linux/nfslocalio.h>
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("NFS localio protocol bypass support");
> +
> +/*
> + * Global list of nfsd_uuid_t instances, add/remove
> + * is protected by fs/nfsd/nfssvc.c:nfsd_mutex.
> + * Reads are protected by RCU read lock (see below).
> + */
> +LIST_HEAD(nfsd_uuids);
> +EXPORT_SYMBOL(nfsd_uuids);
> +
> +/* Must be called with RCU read lock held. */
> +static const uuid_t * nfsd_uuid_lookup(const uuid_t *uuid,
> +				struct net **netp)
> +{
> +	nfsd_uuid_t *nfsd_uuid;
> +
> +	list_for_each_entry_rcu(nfsd_uuid, &nfsd_uuids, list)
> +		if (uuid_equal(&nfsd_uuid->uuid, uuid)) {
> +			*netp =3D nfsd_uuid->net;
> +			return &nfsd_uuid->uuid;
> +		}
> +
> +	return &uuid_null;
> +}
> +
> +bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp)
> +{
> +	const uuid_t *nfsd_uuid;
> +
> +	rcu_read_lock();
> +	nfsd_uuid =3D nfsd_uuid_lookup(uuid, netp);
> +	rcu_read_unlock();
> +
> +	return !uuid_is_null(nfsd_uuid);

This is still unsafe.  You can only safely dereference nfsd_uuid while
still holding the rcu_read_lock.

NeilBrown


> +}
> +EXPORT_SYMBOL_GPL(nfsd_uuid_is_local);
> +
> +/*
> + * The nfs localio code needs to call into nfsd to do the filehandle -> st=
ruct path
> + * mapping, but cannot be statically linked, because that will make the nf=
s module
> + * depend on the nfsd module.
> + *
> + * Instead, do dynamic linking to the nfsd module (via nfs_common module).=
 The
> + * nfs_common module will only hold a reference on nfsd when localio is in=
 use.
> + * This allows some sanity checking, like giving up on localio if nfsd isn=
't loaded.
> + */
> +
> +extern int nfsd_open_local_fh(struct net *, struct rpc_clnt *rpc_clnt,
> +			const struct cred *cred, const struct nfs_fh *nfs_fh,
> +			const fmode_t fmode, struct file **pfilp);
> +
> +nfs_to_nfsd_open_t get_nfsd_open_local_fh(void)
> +{
> +	return symbol_request(nfsd_open_local_fh);
> +}
> +EXPORT_SYMBOL_GPL(get_nfsd_open_local_fh);
> +
> +void put_nfsd_open_local_fh(void)
> +{
> +	symbol_put(nfsd_open_local_fh);
> +}
> +EXPORT_SYMBOL_GPL(put_nfsd_open_local_fh);
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 14ec15656320..0c5a1d97e4ac 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -15,6 +15,7 @@
>  #include <linux/percpu_counter.h>
>  #include <linux/siphash.h>
>  #include <linux/sunrpc/stats.h>
> +#include <linux/nfslocalio.h>
> =20
>  /* Hash tables for nfs4_clientid state */
>  #define CLIENT_HASH_BITS                 4
> @@ -213,6 +214,9 @@ struct nfsd_net {
>  	/* last time an admin-revoke happened for NFSv4.0 */
>  	time64_t		nfs40_last_revoke;
> =20
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +	nfsd_uuid_t		nfsd_uuid;
> +#endif
>  };
> =20
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 9edb4f7c4cc2..1222a0a33fe1 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -19,6 +19,7 @@
>  #include <linux/sunrpc/svc_xprt.h>
>  #include <linux/lockd/bind.h>
>  #include <linux/nfsacl.h>
> +#include <linux/nfslocalio.h>
>  #include <linux/seq_file.h>
>  #include <linux/inetdevice.h>
>  #include <net/addrconf.h>
> @@ -427,6 +428,10 @@ static int nfsd_startup_net(struct net *net, const str=
uct cred *cred)
> =20
>  #ifdef CONFIG_NFSD_V4_2_INTER_SSC
>  	nfsd4_ssc_init_umount_work(nn);
> +#endif
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +	INIT_LIST_HEAD(&nn->nfsd_uuid.list);
> +	list_add_tail_rcu(&nn->nfsd_uuid.list, &nfsd_uuids);
>  #endif
>  	nn->nfsd_net_up =3D true;
>  	return 0;
> @@ -456,6 +461,9 @@ static void nfsd_shutdown_net(struct net *net)
>  		lockd_down(net);
>  		nn->lockd_up =3D false;
>  	}
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +	list_del_rcu(&nn->nfsd_uuid.list);
> +#endif
>  	nn->nfsd_net_up =3D false;
>  	nfsd_shutdown_generic();
>  }
> @@ -802,7 +810,9 @@ nfsd_svc(int n, int *nthreads, struct net *net, const s=
truct cred *cred, const c
> =20
>  	strscpy(nn->nfsd_name, scope ? scope : utsname()->nodename,
>  		sizeof(nn->nfsd_name));
> -
> +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> +	uuid_gen(&nn->nfsd_uuid.uuid);
> +#endif
>  	error =3D nfsd_create_serv(net);
>  	if (error)
>  		goto out;
> diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
> index 92de074e63b9..e58e706a6503 100644
> --- a/include/linux/nfs_fs_sb.h
> +++ b/include/linux/nfs_fs_sb.h
> @@ -8,6 +8,7 @@
>  #include <linux/wait.h>
>  #include <linux/nfs_xdr.h>
>  #include <linux/sunrpc/xprt.h>
> +#include <linux/nfslocalio.h>
> =20
>  #include <linux/atomic.h>
>  #include <linux/refcount.h>
> @@ -125,6 +126,14 @@ struct nfs_client {
>  	struct net		*cl_net;
>  	struct list_head	pending_cb_stateids;
>  	struct rcu_head		rcu;
> +
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	struct timespec64	cl_nfssvc_boot;
> +	seqlock_t		cl_boot_lock;
> +	struct rpc_clnt *	cl_rpcclient_localio;
> +	struct net *	        cl_nfssvc_net;
> +	nfs_to_nfsd_open_t	nfsd_open_local_fh;
> +#endif /* CONFIG_NFS_LOCALIO */
>  };
> =20
>  /*
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> new file mode 100644
> index 000000000000..c9592ad0afe2
> --- /dev/null
> +++ b/include/linux/nfslocalio.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + */
> +#ifndef __LINUX_NFSLOCALIO_H
> +#define __LINUX_NFSLOCALIO_H
> +
> +#include <linux/list.h>
> +#include <linux/uuid.h>
> +#include <linux/nfs.h>
> +#include <net/net_namespace.h>
> +
> +/*
> + * Global list of nfsd_uuid_t instances, add/remove
> + * is protected by fs/nfsd/nfssvc.c:nfsd_mutex.
> + */
> +extern struct list_head nfsd_uuids;
> +
> +/*
> + * Each nfsd instance has an nfsd_uuid_t that is accessible through the
> + * global nfsd_uuids list. Useful to allow a client to negotiate if localio
> + * possible with its server.
> + */
> +typedef struct {
> +	uuid_t uuid;
> +	struct list_head list;
> +	struct net *net; /* nfsd's network namespace */
> +} nfsd_uuid_t;
> +
> +bool nfsd_uuid_is_local(const uuid_t *uuid, struct net **netp);
> +
> +typedef int (*nfs_to_nfsd_open_t)(struct net *, struct rpc_clnt *,
> +				const struct cred *, const struct nfs_fh *,
> +				const fmode_t, struct file **);
> +
> +nfs_to_nfsd_open_t get_nfsd_open_local_fh(void);
> +void put_nfsd_open_local_fh(void);
> +
> +#endif  /* __LINUX_NFSLOCALIO_H */
> --=20
> 2.44.0
>=20
>=20
>=20


