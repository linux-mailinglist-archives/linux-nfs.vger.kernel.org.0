Return-Path: <linux-nfs+bounces-4445-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A7491D434
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 23:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B45E1C203B2
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 21:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3DC2C1BA;
	Sun, 30 Jun 2024 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lKuaI2ft";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n1EPHTYY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lKuaI2ft";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="n1EPHTYY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116886EB46
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 21:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719784660; cv=none; b=lER1BSCDuK7988TRq+KrtXWd6jzUoZMB4l2pB0anxKe/ewyuN6X/4+JVOdUGvdCvcmJGJpb5R0ZAf1s5Hpf2HVeT5NvmnaQWXuTt8rTe3klnccVIW7aZ7F9bzmNJrj1X1REpDTGC7iLUGX1fSW83XJc8rWu+rQlitdgwyzk3obg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719784660; c=relaxed/simple;
	bh=co0Zk95VdahC/vl4He/rdVkvmAKLtI4IVWIHqSfQ3M4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=YeDFAWIoUrFk5V7XSjAzE1foCbx1TAZEYMx+BGq03ZiHsaPDyljhMVM02BD2TDXvpAkRnTxO7LV0hXem7Ni5eEcILJK5uIseqKdOrdAMRtPonWt0v9MWpcXoTOiTW4k3ia0Ir3d9wcljpC2YAG4PxzgMqyjyPxOSsCsCo7KxTjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lKuaI2ft; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n1EPHTYY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lKuaI2ft; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=n1EPHTYY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2ECA11F88F;
	Sun, 30 Jun 2024 21:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719784656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzDIZ6eUlvQ9tf3zFd19WDLBcyqHANMwwtxvBVqv9JY=;
	b=lKuaI2ft3i/m0B2TV4Gcul3dL62uw04qs9T9xs9SdQO4/wiUlPYTnf6vi4ISV12gU7SkUi
	4G1QYhr2ZGw8jKohQRP0ZNHxqn4scO739DCfPvy62/eePliASxeohjXt9C4V/3RhwG2XGp
	9ZJ2lvUVufO/FAT0jQ6UouRLl/oZuTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719784656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzDIZ6eUlvQ9tf3zFd19WDLBcyqHANMwwtxvBVqv9JY=;
	b=n1EPHTYYvD3BucDx22rXVGgk+fZsEqPvXgjjZpx67FTsBq2L2B3PQ/u9YN9UE7htDjkR0n
	xEeNnJ6JKPVNfDCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lKuaI2ft;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n1EPHTYY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719784656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzDIZ6eUlvQ9tf3zFd19WDLBcyqHANMwwtxvBVqv9JY=;
	b=lKuaI2ft3i/m0B2TV4Gcul3dL62uw04qs9T9xs9SdQO4/wiUlPYTnf6vi4ISV12gU7SkUi
	4G1QYhr2ZGw8jKohQRP0ZNHxqn4scO739DCfPvy62/eePliASxeohjXt9C4V/3RhwG2XGp
	9ZJ2lvUVufO/FAT0jQ6UouRLl/oZuTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719784656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzDIZ6eUlvQ9tf3zFd19WDLBcyqHANMwwtxvBVqv9JY=;
	b=n1EPHTYYvD3BucDx22rXVGgk+fZsEqPvXgjjZpx67FTsBq2L2B3PQ/u9YN9UE7htDjkR0n
	xEeNnJ6JKPVNfDCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA8D513A7F;
	Sun, 30 Jun 2024 21:57:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8j9YG8zUgWb/ZwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 30 Jun 2024 21:57:32 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v9 18/19] SUNRPC: replace program list with program array
In-reply-to: <ZoAvgLhX+fOdoXXU@tissot.1015granger.net>
References: <>, <ZoAvgLhX+fOdoXXU@tissot.1015granger.net>
Date: Mon, 01 Jul 2024 07:57:25 +1000
Message-id: <171978464512.16071.9345065038530000024@noble.neil.brown.name>
X-Rspamd-Queue-Id: 2ECA11F88F
X-Spam-Score: -5.51
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sun, 30 Jun 2024, Chuck Lever wrote:
> On Fri, Jun 28, 2024 at 05:11:04PM -0400, Mike Snitzer wrote:
> > From: NeilBrown <neil@brown.name>
> >=20
> > A service created with svc_create_pooled() can be given a linked list of
> > programs and all of these will be served.
> >=20
> > Using a linked list makes it cumbersome when there are several programs
> > that can be optionally selected with CONFIG settings.
> >=20
> > So change to use an array with explicit size.  svc_create() is always
> > passed a single program.  svc_create_pooled() now must be used for
> > multiple programs.
>=20
> Instead of this last sentence, it might be more clear to say:
>=20
> > After this patch is applied, API consumers must use only
> > svc_create_pooled() when creating an RPC service that listens for
> > more than one RPC program.

Thanks - that's a much clearer way to say it.

NeilBrown

>=20
> I like the idea of replacing these static linked lists.
>=20
>=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  fs/nfsd/nfsctl.c           |  2 +-
> >  fs/nfsd/nfsd.h             |  2 +-
> >  fs/nfsd/nfssvc.c           | 69 ++++++++++++++++++--------------------
> >  include/linux/sunrpc/svc.h |  7 ++--
> >  net/sunrpc/svc.c           | 68 +++++++++++++++++++++----------------
> >  net/sunrpc/svc_xprt.c      |  2 +-
> >  net/sunrpc/svcauth_unix.c  |  3 +-
> >  7 files changed, 80 insertions(+), 73 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index e5d2cc74ef77..6fb92bb61c6d 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -2265,7 +2265,7 @@ static __net_init int nfsd_net_init(struct net *net)
> >  	if (retval)
> >  		goto out_repcache_error;
> >  	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
> > -	nn->nfsd_svcstats.program =3D &nfsd_program;
> > +	nn->nfsd_svcstats.program =3D &nfsd_programs[0];
> >  	nn->nfsd_versions =3D NULL;
> >  	nn->nfsd4_minorversions =3D NULL;
> >  	nfsd4_init_leases_net(nn);
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index cec8697b1cd6..c3f7c5957950 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -80,7 +80,7 @@ struct nfsd_genl_rqstp {
> >  	u32			rq_opnum[NFSD_MAX_OPS_PER_COMPOUND];
> >  };
> > =20
> > -extern struct svc_program	nfsd_program;
> > +extern struct svc_program	nfsd_programs[];
> >  extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_versi=
on4;
> >  extern struct mutex		nfsd_mutex;
> >  extern spinlock_t		nfsd_drc_lock;
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 6cc6a1971e21..ef2532303ece 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -36,7 +36,6 @@
> >  #define NFSDDBG_FACILITY	NFSDDBG_SVC
> > =20
> >  atomic_t			nfsd_th_cnt =3D ATOMIC_INIT(0);
> > -extern struct svc_program	nfsd_program;
> >  static int			nfsd(void *vrqstp);
> >  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> >  static int			nfsd_acl_rpcbind_set(struct net *,
> > @@ -89,16 +88,6 @@ static const struct svc_version *localio_versions[] =
=3D {
> > =20
> >  #define NFSD_LOCALIO_NRVERS		ARRAY_SIZE(localio_versions)
> > =20
> > -static struct svc_program	nfsd_localio_program =3D {
> > -	.pg_prog		=3D NFS_LOCALIO_PROGRAM,
> > -	.pg_nvers		=3D NFSD_LOCALIO_NRVERS,
> > -	.pg_vers		=3D localio_versions,
> > -	.pg_name		=3D "nfslocalio",
> > -	.pg_class		=3D "nfsd",
> > -	.pg_authenticate	=3D &svc_set_client,
> > -	.pg_init_request	=3D svc_generic_init_request,
> > -	.pg_rpcbind_set		=3D svc_generic_rpcbind_set,
> > -};
> >  #endif /* CONFIG_NFSD_LOCALIO */
> > =20
> >  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> > @@ -111,23 +100,9 @@ static const struct svc_version *nfsd_acl_version[] =
=3D {
> >  # endif
> >  };
> > =20
> > -#define NFSD_ACL_MINVERS            2
> > +#define NFSD_ACL_MINVERS	2
> >  #define NFSD_ACL_NRVERS		ARRAY_SIZE(nfsd_acl_version)
> > =20
> > -static struct svc_program	nfsd_acl_program =3D {
> > -#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> > -	.pg_next		=3D &nfsd_localio_program,
> > -#endif /* CONFIG_NFSD_LOCALIO */
> > -	.pg_prog		=3D NFS_ACL_PROGRAM,
> > -	.pg_nvers		=3D NFSD_ACL_NRVERS,
> > -	.pg_vers		=3D nfsd_acl_version,
> > -	.pg_name		=3D "nfsacl",
> > -	.pg_class		=3D "nfsd",
> > -	.pg_authenticate	=3D &svc_set_client,
> > -	.pg_init_request	=3D nfsd_acl_init_request,
> > -	.pg_rpcbind_set		=3D nfsd_acl_rpcbind_set,
> > -};
> > -
> >  #endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
> > =20
> >  static const struct svc_version *nfsd_version[] =3D {
> > @@ -140,25 +115,44 @@ static const struct svc_version *nfsd_version[] =3D=
 {
> >  #endif
> >  };
> > =20
> > -#define NFSD_MINVERS    	2
> > +#define NFSD_MINVERS		2
> >  #define NFSD_NRVERS		ARRAY_SIZE(nfsd_version)
> > =20
> > -struct svc_program		nfsd_program =3D {
> > -#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> > -	.pg_next		=3D &nfsd_acl_program,
> > -#else
> > -#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> > -	.pg_next		=3D &nfsd_localio_program,
> > -#endif /* CONFIG_NFSD_LOCALIO */
> > -#endif
> > +struct svc_program		nfsd_programs[] =3D {
> > +	{
> >  	.pg_prog		=3D NFS_PROGRAM,		/* program number */
> >  	.pg_nvers		=3D NFSD_NRVERS,		/* nr of entries in nfsd_version */
> >  	.pg_vers		=3D nfsd_version,		/* version table */
> >  	.pg_name		=3D "nfsd",		/* program name */
> >  	.pg_class		=3D "nfsd",		/* authentication class */
> > -	.pg_authenticate	=3D &svc_set_client,	/* export authentication */
> > +	.pg_authenticate	=3D svc_set_client,	/* export authentication */
> >  	.pg_init_request	=3D nfsd_init_request,
> >  	.pg_rpcbind_set		=3D nfsd_rpcbind_set,
> > +	},
> > +#if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> > +	{
> > +	.pg_prog		=3D NFS_ACL_PROGRAM,
> > +	.pg_nvers		=3D NFSD_ACL_NRVERS,
> > +	.pg_vers		=3D nfsd_acl_version,
> > +	.pg_name		=3D "nfsacl",
> > +	.pg_class		=3D "nfsd",
> > +	.pg_authenticate	=3D svc_set_client,
> > +	.pg_init_request	=3D nfsd_acl_init_request,
> > +	.pg_rpcbind_set		=3D nfsd_acl_rpcbind_set,
> > +	},
> > +#endif /* defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL) */
> > +#if IS_ENABLED(CONFIG_NFSD_LOCALIO)
> > +	{
> > +	.pg_prog		=3D NFS_LOCALIO_PROGRAM,
> > +	.pg_nvers		=3D NFSD_LOCALIO_NRVERS,
> > +	.pg_vers		=3D localio_versions,
> > +	.pg_name		=3D "nfslocalio",
> > +	.pg_class		=3D "nfsd",
> > +	.pg_authenticate	=3D svc_set_client,
> > +	.pg_init_request	=3D svc_generic_init_request,
> > +	.pg_rpcbind_set		=3D svc_generic_rpcbind_set,
> > +	}
> > +#endif /* IS_ENABLED(CONFIG_NFSD_LOCALIO) */
> >  };
> > =20
> >  bool nfsd_support_version(int vers)
> > @@ -735,7 +729,8 @@ int nfsd_create_serv(struct net *net)
> >  	if (nfsd_max_blksize =3D=3D 0)
> >  		nfsd_max_blksize =3D nfsd_get_default_max_blksize();
> >  	nfsd_reset_versions(nn);
> > -	serv =3D svc_create_pooled(&nfsd_program, &nn->nfsd_svcstats,
> > +	serv =3D svc_create_pooled(nfsd_programs, ARRAY_SIZE(nfsd_programs),
> > +				 &nn->nfsd_svcstats,
> >  				 nfsd_max_blksize, nfsd);
> >  	if (serv =3D=3D NULL)
> >  		return -ENOMEM;
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index a7d0406b9ef5..7c86b1696398 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -66,9 +66,10 @@ enum {
> >   * We currently do not support more than one RPC program per daemon.
> >   */
> >  struct svc_serv {
> > -	struct svc_program *	sv_program;	/* RPC program */
> > +	struct svc_program *	sv_programs;	/* RPC programs */
> >  	struct svc_stat *	sv_stats;	/* RPC statistics */
> >  	spinlock_t		sv_lock;
> > +	unsigned int		sv_nprogs;	/* Number of sv_programs */
> >  	unsigned int		sv_nrthreads;	/* # of server threads */
> >  	unsigned int		sv_maxconn;	/* max connections allowed or
> >  						 * '0' causing max to be based
> > @@ -329,10 +330,9 @@ struct svc_process_info {
> >  };
> > =20
> >  /*
> > - * List of RPC programs on the same transport endpoint
> > + * RPC program - an array of these can use the same transport endpoint
> >   */
> >  struct svc_program {
> > -	struct svc_program *	pg_next;	/* other programs (same xprt) */
> >  	u32			pg_prog;	/* program number */
> >  	unsigned int		pg_lovers;	/* lowest version */
> >  	unsigned int		pg_hivers;	/* highest version */
> > @@ -414,6 +414,7 @@ void		   svc_rqst_release_pages(struct svc_rqst *rqst=
p);
> >  void		   svc_rqst_free(struct svc_rqst *);
> >  void		   svc_exit_thread(struct svc_rqst *);
> >  struct svc_serv *  svc_create_pooled(struct svc_program *prog,
> > +				     unsigned int nprog,
> >  				     struct svc_stat *stats,
> >  				     unsigned int bufsize,
> >  				     int (*threadfn)(void *data));
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 965a27806bfd..d9f348aa0672 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -440,10 +440,11 @@ EXPORT_SYMBOL_GPL(svc_rpcb_cleanup);
> > =20
> >  static int svc_uses_rpcbind(struct svc_serv *serv)
> >  {
> > -	struct svc_program	*progp;
> > -	unsigned int		i;
> > +	unsigned int		p, i;
> > +
> > +	for (p =3D 0; p < serv->sv_nprogs; p++) {
> > +		struct svc_program *progp =3D &serv->sv_programs[p];
> > =20
> > -	for (progp =3D serv->sv_program; progp; progp =3D progp->pg_next) {
> >  		for (i =3D 0; i < progp->pg_nvers; i++) {
> >  			if (progp->pg_vers[i] =3D=3D NULL)
> >  				continue;
> > @@ -480,7 +481,7 @@ __svc_init_bc(struct svc_serv *serv)
> >   * Create an RPC service
> >   */
> >  static struct svc_serv *
> > -__svc_create(struct svc_program *prog, struct svc_stat *stats,
> > +__svc_create(struct svc_program *prog, int nprogs, struct svc_stat *stat=
s,
> >  	     unsigned int bufsize, int npools, int (*threadfn)(void *data))
> >  {
> >  	struct svc_serv	*serv;
> > @@ -491,7 +492,8 @@ __svc_create(struct svc_program *prog, struct svc_sta=
t *stats,
> >  	if (!(serv =3D kzalloc(sizeof(*serv), GFP_KERNEL)))
> >  		return NULL;
> >  	serv->sv_name      =3D prog->pg_name;
> > -	serv->sv_program   =3D prog;
> > +	serv->sv_programs  =3D prog;
> > +	serv->sv_nprogs    =3D nprogs;
> >  	serv->sv_stats     =3D stats;
> >  	if (bufsize > RPCSVC_MAXPAYLOAD)
> >  		bufsize =3D RPCSVC_MAXPAYLOAD;
> > @@ -499,17 +501,18 @@ __svc_create(struct svc_program *prog, struct svc_s=
tat *stats,
> >  	serv->sv_max_mesg  =3D roundup(serv->sv_max_payload + PAGE_SIZE, PAGE_S=
IZE);
> >  	serv->sv_threadfn =3D threadfn;
> >  	xdrsize =3D 0;
> > -	while (prog) {
> > -		prog->pg_lovers =3D prog->pg_nvers-1;
> > -		for (vers=3D0; vers<prog->pg_nvers ; vers++)
> > -			if (prog->pg_vers[vers]) {
> > -				prog->pg_hivers =3D vers;
> > -				if (prog->pg_lovers > vers)
> > -					prog->pg_lovers =3D vers;
> > -				if (prog->pg_vers[vers]->vs_xdrsize > xdrsize)
> > -					xdrsize =3D prog->pg_vers[vers]->vs_xdrsize;
> > +	for (i =3D 0; i < nprogs; i++) {
> > +		struct svc_program *progp =3D &prog[i];
> > +
> > +		progp->pg_lovers =3D progp->pg_nvers-1;
> > +		for (vers =3D 0; vers < progp->pg_nvers ; vers++)
> > +			if (progp->pg_vers[vers]) {
> > +				progp->pg_hivers =3D vers;
> > +				if (progp->pg_lovers > vers)
> > +					progp->pg_lovers =3D vers;
> > +				if (progp->pg_vers[vers]->vs_xdrsize > xdrsize)
> > +					xdrsize =3D progp->pg_vers[vers]->vs_xdrsize;
> >  			}
> > -		prog =3D prog->pg_next;
> >  	}
> >  	serv->sv_xdrsize   =3D xdrsize;
> >  	INIT_LIST_HEAD(&serv->sv_tempsocks);
> > @@ -558,13 +561,14 @@ __svc_create(struct svc_program *prog, struct svc_s=
tat *stats,
> >  struct svc_serv *svc_create(struct svc_program *prog, unsigned int bufsi=
ze,
> >  			    int (*threadfn)(void *data))
> >  {
> > -	return __svc_create(prog, NULL, bufsize, 1, threadfn);
> > +	return __svc_create(prog, 1, NULL, bufsize, 1, threadfn);
> >  }
> >  EXPORT_SYMBOL_GPL(svc_create);
> > =20
> >  /**
> >   * svc_create_pooled - Create an RPC service with pooled threads
> > - * @prog: the RPC program the new service will handle
> > + * @prog:  Array of RPC programs the new service will handle
> > + * @nprogs: Number of programs in the array
> >   * @stats: the stats struct if desired
> >   * @bufsize: maximum message size for @prog
> >   * @threadfn: a function to service RPC requests for @prog
> > @@ -572,6 +576,7 @@ EXPORT_SYMBOL_GPL(svc_create);
> >   * Returns an instantiated struct svc_serv object or NULL.
> >   */
> >  struct svc_serv *svc_create_pooled(struct svc_program *prog,
> > +				   unsigned int nprogs,
> >  				   struct svc_stat *stats,
> >  				   unsigned int bufsize,
> >  				   int (*threadfn)(void *data))
> > @@ -579,7 +584,7 @@ struct svc_serv *svc_create_pooled(struct svc_program=
 *prog,
> >  	struct svc_serv *serv;
> >  	unsigned int npools =3D svc_pool_map_get();
> > =20
> > -	serv =3D __svc_create(prog, stats, bufsize, npools, threadfn);
> > +	serv =3D __svc_create(prog, nprogs, stats, bufsize, npools, threadfn);
> >  	if (!serv)
> >  		goto out_err;
> >  	serv->sv_is_pooled =3D true;
> > @@ -602,16 +607,16 @@ svc_destroy(struct svc_serv **servp)
> > =20
> >  	*servp =3D NULL;
> > =20
> > -	dprintk("svc: svc_destroy(%s)\n", serv->sv_program->pg_name);
> > +	dprintk("svc: svc_destroy(%s)\n", serv->sv_programs->pg_name);
> >  	timer_shutdown_sync(&serv->sv_temptimer);
> > =20
> >  	/*
> >  	 * Remaining transports at this point are not expected.
> >  	 */
> >  	WARN_ONCE(!list_empty(&serv->sv_permsocks),
> > -		  "SVC: permsocks remain for %s\n", serv->sv_program->pg_name);
> > +		  "SVC: permsocks remain for %s\n", serv->sv_programs->pg_name);
> >  	WARN_ONCE(!list_empty(&serv->sv_tempsocks),
> > -		  "SVC: tempsocks remain for %s\n", serv->sv_program->pg_name);
> > +		  "SVC: tempsocks remain for %s\n", serv->sv_programs->pg_name);
> > =20
> >  	cache_clean_deferred(serv);
> > =20
> > @@ -1156,15 +1161,16 @@ int svc_register(const struct svc_serv *serv, str=
uct net *net,
> >  		 const int family, const unsigned short proto,
> >  		 const unsigned short port)
> >  {
> > -	struct svc_program	*progp;
> > -	unsigned int		i;
> > +	unsigned int		p, i;
> >  	int			error =3D 0;
> > =20
> >  	WARN_ON_ONCE(proto =3D=3D 0 && port =3D=3D 0);
> >  	if (proto =3D=3D 0 && port =3D=3D 0)
> >  		return -EINVAL;
> > =20
> > -	for (progp =3D serv->sv_program; progp; progp =3D progp->pg_next) {
> > +	for (p =3D 0; p < serv->sv_nprogs; p++) {
> > +		struct svc_program *progp =3D &serv->sv_programs[p];
> > +
> >  		for (i =3D 0; i < progp->pg_nvers; i++) {
> > =20
> >  			error =3D progp->pg_rpcbind_set(net, progp, i,
> > @@ -1216,13 +1222,14 @@ static void __svc_unregister(struct net *net, con=
st u32 program, const u32 versi
> >  static void svc_unregister(const struct svc_serv *serv, struct net *net)
> >  {
> >  	struct sighand_struct *sighand;
> > -	struct svc_program *progp;
> >  	unsigned long flags;
> > -	unsigned int i;
> > +	unsigned int p, i;
> > =20
> >  	clear_thread_flag(TIF_SIGPENDING);
> > =20
> > -	for (progp =3D serv->sv_program; progp; progp =3D progp->pg_next) {
> > +	for (p =3D 0; p < serv->sv_nprogs; p++) {
> > +		struct svc_program *progp =3D &serv->sv_programs[p];
> > +
> >  		for (i =3D 0; i < progp->pg_nvers; i++) {
> >  			if (progp->pg_vers[i] =3D=3D NULL)
> >  				continue;
> > @@ -1328,7 +1335,7 @@ svc_process_common(struct svc_rqst *rqstp)
> >  	struct svc_process_info process;
> >  	enum svc_auth_status	auth_res;
> >  	unsigned int		aoffset;
> > -	int			rc;
> > +	int			pr, rc;
> >  	__be32			*p;
> > =20
> >  	/* Will be turned off only when NFSv4 Sessions are used */
> > @@ -1352,9 +1359,12 @@ svc_process_common(struct svc_rqst *rqstp)
> >  	rqstp->rq_vers =3D be32_to_cpup(p++);
> >  	rqstp->rq_proc =3D be32_to_cpup(p);
> > =20
> > -	for (progp =3D serv->sv_program; progp; progp =3D progp->pg_next)
> > +	for (pr =3D 0; pr < serv->sv_nprogs; pr++) {
> > +		progp =3D &serv->sv_programs[pr];
> > +
> >  		if (rqstp->rq_prog =3D=3D progp->pg_prog)
> >  			break;
> > +	}
> > =20
> >  	/*
> >  	 * Decode auth data, and add verifier to reply buffer.
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index d3735ab3e6d1..16634afdf253 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -268,7 +268,7 @@ static int _svc_xprt_create(struct svc_serv *serv, co=
nst char *xprt_name,
> >  		spin_unlock(&svc_xprt_class_lock);
> >  		newxprt =3D xcl->xcl_ops->xpo_create(serv, net, sap, len, flags);
> >  		if (IS_ERR(newxprt)) {
> > -			trace_svc_xprt_create_err(serv->sv_program->pg_name,
> > +			trace_svc_xprt_create_err(serv->sv_programs->pg_name,
> >  						  xcl->xcl_name, sap, len,
> >  						  newxprt);
> >  			module_put(xcl->xcl_owner);
> > diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
> > index 04b45588ae6f..8ca98b146ec8 100644
> > --- a/net/sunrpc/svcauth_unix.c
> > +++ b/net/sunrpc/svcauth_unix.c
> > @@ -697,7 +697,8 @@ svcauth_unix_set_client(struct svc_rqst *rqstp)
> >  	rqstp->rq_auth_stat =3D rpc_autherr_badcred;
> >  	ipm =3D ip_map_cached_get(xprt);
> >  	if (ipm =3D=3D NULL)
> > -		ipm =3D __ip_map_lookup(sn->ip_map_cache, rqstp->rq_server->sv_program=
->pg_class,
> > +		ipm =3D __ip_map_lookup(sn->ip_map_cache,
> > +				      rqstp->rq_server->sv_programs->pg_class,
> >  				    &sin6->sin6_addr);
> > =20
> >  	if (ipm =3D=3D NULL)
> > --=20
> > 2.44.0
> >=20
> >=20
>=20
> --=20
> Chuck Lever
>=20


