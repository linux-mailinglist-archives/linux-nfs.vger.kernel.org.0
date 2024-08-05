Return-Path: <linux-nfs+bounces-5232-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14340947474
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2024 06:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6675281255
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Aug 2024 04:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843001411E9;
	Mon,  5 Aug 2024 04:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xjsuZmLT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zgjj1TIo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xjsuZmLT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zgjj1TIo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5CA13C673
	for <linux-nfs@vger.kernel.org>; Mon,  5 Aug 2024 04:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722833769; cv=none; b=pTKVzUG7MNcjUQJTIaBrK48xPaQ79f4+Yo50SqrQ5hvHpPSAS85UBbQrrwUQ7swJqA4f2CYi7Te8guHU5kj5Y8hUxZfX9OHxPargFZKb1MO615kpuFAsETdGI0wZE+akHRGTBWG6fUcU6bolAcIzReCBA2cRe3R5fEhw7rTKtk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722833769; c=relaxed/simple;
	bh=IXwX1MhBUe8tnfdbwh23GFnFsVy5USyP6EuohlBgh+U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=pkqHCWX/WztlsHcZOde3hrvr3al8Y/mm1djd0u3HBq7m+PISmVnh059eA1JMKiYHukwbXCKMexVbcUosO8vyosdQDw1EpKWQbrQq/vQBzZGMSoeibwb8K29mVvGUb3JUN1ahMF3xQjod4FwuhQJ3piT5lc4roaqiaEimKASo5B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xjsuZmLT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zgjj1TIo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xjsuZmLT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zgjj1TIo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A6521FCD8;
	Mon,  5 Aug 2024 04:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722833757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w8rW8JoyF8/Pyr0Kpm8W8qqWl+cxqjrn+5AdbnaIW9U=;
	b=xjsuZmLTzs8yXAuZrsIelCB0NDbgB3D3KcKD/5DbMbqSK/6H3DbOTENUyBMlX/JQ0fHqPF
	+bfxAkvWAF1xvJhOBtFtZBoWiJzBiJ3uVrR2EJsjoXKH4YIY6bPtwHhcbKtt9dkR7xX8FG
	Ui3oKGTHGMYRwx2A1KVt2k/DjkiN1uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722833757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w8rW8JoyF8/Pyr0Kpm8W8qqWl+cxqjrn+5AdbnaIW9U=;
	b=zgjj1TIou2vuuR49zBEnk5bbSO69t0RbHd9rqWgSj2uI2mdwKDLoeUFSNkBn+sz4Vke8wB
	xAZ0fbOr8yXQ/tDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722833757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w8rW8JoyF8/Pyr0Kpm8W8qqWl+cxqjrn+5AdbnaIW9U=;
	b=xjsuZmLTzs8yXAuZrsIelCB0NDbgB3D3KcKD/5DbMbqSK/6H3DbOTENUyBMlX/JQ0fHqPF
	+bfxAkvWAF1xvJhOBtFtZBoWiJzBiJ3uVrR2EJsjoXKH4YIY6bPtwHhcbKtt9dkR7xX8FG
	Ui3oKGTHGMYRwx2A1KVt2k/DjkiN1uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722833757;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w8rW8JoyF8/Pyr0Kpm8W8qqWl+cxqjrn+5AdbnaIW9U=;
	b=zgjj1TIou2vuuR49zBEnk5bbSO69t0RbHd9rqWgSj2uI2mdwKDLoeUFSNkBn+sz4Vke8wB
	xAZ0fbOr8yXQ/tDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2968113ACF;
	Mon,  5 Aug 2024 04:55:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y5aCM1lbsGYnJgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 05 Aug 2024 04:55:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "Mike Snitzer" <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, "Olga Kornievskaia" <kolga@netapp.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Steve Dickson" <steved@redhat.com>
Subject: Re: [PATCH 04/14] nfsd: don't allocate the versions array.
In-reply-to: <172263986618.6062.12535168158374219174@noble.neil.brown.name>
References: <>, <Zq1Q8f1Dslc2Cvjo@kernel.org>,
 <172263986618.6062.12535168158374219174@noble.neil.brown.name>
Date: Mon, 05 Aug 2024 14:55:46 +1000
Message-id: <172283374675.6062.6848122859794837508@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 03 Aug 2024, NeilBrown wrote:
> On Sat, 03 Aug 2024, Mike Snitzer wrote:
> > On Mon, Jul 15, 2024 at 05:14:17PM +1000, NeilBrown wrote:
> > > Instead of using kmalloc to allocate an array for storing active version
> > > info, just declare and array to the max size - it is only 5 or so.
> > >=20
> > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > ---
> > >  fs/nfs/nfs4state.c |   2 +
> > >  fs/nfsd/cache.h    |   2 +-
> > >  fs/nfsd/netns.h    |   6 +--
> > >  fs/nfsd/nfsctl.c   |  10 +++--
> > >  fs/nfsd/nfsd.h     |   9 +++-
> > >  fs/nfsd/nfssvc.c   | 100 ++++++++-------------------------------------
> > >  6 files changed, 36 insertions(+), 93 deletions(-)
> > >=20
> > > diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
> > > index 5b452411e8fd..68c663626480 100644
> > > --- a/fs/nfs/nfs4state.c
> > > +++ b/fs/nfs/nfs4state.c
> > > @@ -1953,6 +1953,8 @@ static int nfs4_do_reclaim(struct nfs_client *clp=
, const struct nfs4_state_recov
> > >  				if (lost_locks)
> > >  					pr_warn("NFS: %s: lost %d locks\n",
> > >  						clp->cl_hostname, lost_locks);
> > > +				nfs4_free_state_owners(&freeme);
> > > +
> > >  				set_bit(ops->owner_flag_bit, &sp->so_flags);
> > >  				nfs4_put_state_owner(sp);
> > >  				status =3D nfs4_recovery_handle_error(clp, status);
> >=20
> > Hey Neil,
> >=20
> > This call to nfs4_free_state_owners() feels out of place given the
> > rest of this patch.  Was it meant to be folded into a different
> > patch?
>=20
> I think I was writing a different patch (there is a case where the
> lost-locks warning can be incorrect) and I got half way and stopped for
> some reason.  Then later I wanted to do this patch and did "git stash"
> but I hadn't saved all my work.  So when I later did a "save all
> buffers" that change went into the wrong patch.
>=20
> I'll follow up on Monday - thanks for noticing and letting me know!

Chuck / Jeff - could you please just remove the change to fs/nfs/ from
this patch - that is probably easier than me sending an incremental
patch or a revised version.

Thanks,
NeilBrown


>=20
> NeilBrown
>=20
>=20
> >=20
> > Thanks,
> > Mike
> >=20
> >=20
> > > diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
> > > index 66a05fefae98..bb7addef4a31 100644
> > > --- a/fs/nfsd/cache.h
> > > +++ b/fs/nfsd/cache.h
> > > @@ -10,7 +10,7 @@
> > >  #define NFSCACHE_H
> > > =20
> > >  #include <linux/sunrpc/svc.h>
> > > -#include "netns.h"
> > > +#include "nfsd.h"
> > > =20
> > >  /*
> > >   * Representation of a reply cache entry.
> > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > index 14ec15656320..238fc4e56e53 100644
> > > --- a/fs/nfsd/netns.h
> > > +++ b/fs/nfsd/netns.h
> > > @@ -152,8 +152,8 @@ struct nfsd_net {
> > >  	/*
> > >  	 * Version information
> > >  	 */
> > > -	bool *nfsd_versions;
> > > -	bool *nfsd4_minorversions;
> > > +	bool nfsd_versions[NFSD_MAXVERS + 1];
> > > +	bool nfsd4_minorversions[NFSD_SUPPORTED_MINOR_VERSION + 1];
> > > =20
> > >  	/*
> > >  	 * Duplicate reply cache
> > > @@ -219,8 +219,6 @@ struct nfsd_net {
> > >  #define nfsd_netns_ready(nn) ((nn)->sessionid_hashtbl)
> > > =20
> > >  extern bool nfsd_support_version(int vers);
> > > -extern void nfsd_netns_free_versions(struct nfsd_net *nn);
> > > -
> > >  extern unsigned int nfsd_net_id;
> > > =20
> > >  void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 9b47723fc110..5b0f2e0d7ccf 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -2232,8 +2232,9 @@ int nfsd_nl_pool_mode_get_doit(struct sk_buff *sk=
b, struct genl_info *info)
> > >   */
> > >  static __net_init int nfsd_net_init(struct net *net)
> > >  {
> > > -	int retval;
> > >  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > > +	int retval;
> > > +	int i;
> > > =20
> > >  	retval =3D nfsd_export_init(net);
> > >  	if (retval)
> > > @@ -2247,8 +2248,10 @@ static __net_init int nfsd_net_init(struct net *=
net)
> > >  		goto out_repcache_error;
> > >  	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
> > >  	nn->nfsd_svcstats.program =3D &nfsd_program;
> > > -	nn->nfsd_versions =3D NULL;
> > > -	nn->nfsd4_minorversions =3D NULL;
> > > +	for (i =3D 0; i < sizeof(nn->nfsd_versions); i++)
> > > +		nn->nfsd_versions[i] =3D nfsd_support_version(i);
> > > +	for (i =3D 0; i < sizeof(nn->nfsd4_minorversions); i++)
> > > +		nn->nfsd4_minorversions[i] =3D nfsd_support_version(4);
> > >  	nn->nfsd_info.mutex =3D &nfsd_mutex;
> > >  	nn->nfsd_serv =3D NULL;
> > >  	nfsd4_init_leases_net(nn);
> > > @@ -2279,7 +2282,6 @@ static __net_exit void nfsd_net_exit(struct net *=
net)
> > >  	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
> > >  	nfsd_idmap_shutdown(net);
> > >  	nfsd_export_shutdown(net);
> > > -	nfsd_netns_free_versions(nn);
> > >  }
> > > =20
> > >  static struct pernet_operations nfsd_net_ops =3D {
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index 39e109a7d56d..369c3b3ce53e 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -23,9 +23,7 @@
> > > =20
> > >  #include <uapi/linux/nfsd/debug.h>
> > > =20
> > > -#include "netns.h"
> > >  #include "export.h"
> > > -#include "stats.h"
> > > =20
> > >  #undef ifdebug
> > >  #ifdef CONFIG_SUNRPC_DEBUG
> > > @@ -37,7 +35,14 @@
> > >  /*
> > >   * nfsd version
> > >   */
> > > +#define NFSD_MINVERS			2
> > > +#define	NFSD_MAXVERS			4
> > >  #define NFSD_SUPPORTED_MINOR_VERSION	2
> > > +bool nfsd_support_version(int vers);
> > > +
> > > +#include "netns.h"
> > > +#include "stats.h"
> > > +
> > >  /*
> > >   * Maximum blocksizes supported by daemon under various circumstances.
> > >   */
> > > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > > index f25b26bc5670..4438cdcd4873 100644
> > > --- a/fs/nfsd/nfssvc.c
> > > +++ b/fs/nfsd/nfssvc.c
> > > @@ -116,15 +116,12 @@ static const struct svc_version *nfsd_version[] =
=3D {
> > >  #endif
> > >  };
> > > =20
> > > -#define NFSD_MINVERS    	2
> > > -#define NFSD_NRVERS		ARRAY_SIZE(nfsd_version)
> > > -
> > >  struct svc_program		nfsd_program =3D {
> > >  #if defined(CONFIG_NFSD_V2_ACL) || defined(CONFIG_NFSD_V3_ACL)
> > >  	.pg_next		=3D &nfsd_acl_program,
> > >  #endif
> > >  	.pg_prog		=3D NFS_PROGRAM,		/* program number */
> > > -	.pg_nvers		=3D NFSD_NRVERS,		/* nr of entries in nfsd_version */
> > > +	.pg_nvers		=3D NFSD_MAXVERS+1,	/* nr of entries in nfsd_version */
> > >  	.pg_vers		=3D nfsd_version,		/* version table */
> > >  	.pg_name		=3D "nfsd",		/* program name */
> > >  	.pg_class		=3D "nfsd",		/* authentication class */
> > > @@ -135,78 +132,24 @@ struct svc_program		nfsd_program =3D {
> > > =20
> > >  bool nfsd_support_version(int vers)
> > >  {
> > > -	if (vers >=3D NFSD_MINVERS && vers < NFSD_NRVERS)
> > > +	if (vers >=3D NFSD_MINVERS && vers <=3D NFSD_MAXVERS)
> > >  		return nfsd_version[vers] !=3D NULL;
> > >  	return false;
> > >  }
> > > =20
> > > -static bool *
> > > -nfsd_alloc_versions(void)
> > > -{
> > > -	bool *vers =3D kmalloc_array(NFSD_NRVERS, sizeof(bool), GFP_KERNEL);
> > > -	unsigned i;
> > > -
> > > -	if (vers) {
> > > -		/* All compiled versions are enabled by default */
> > > -		for (i =3D 0; i < NFSD_NRVERS; i++)
> > > -			vers[i] =3D nfsd_support_version(i);
> > > -	}
> > > -	return vers;
> > > -}
> > > -
> > > -static bool *
> > > -nfsd_alloc_minorversions(void)
> > > -{
> > > -	bool *vers =3D kmalloc_array(NFSD_SUPPORTED_MINOR_VERSION + 1,
> > > -			sizeof(bool), GFP_KERNEL);
> > > -	unsigned i;
> > > -
> > > -	if (vers) {
> > > -		/* All minor versions are enabled by default */
> > > -		for (i =3D 0; i <=3D NFSD_SUPPORTED_MINOR_VERSION; i++)
> > > -			vers[i] =3D nfsd_support_version(4);
> > > -	}
> > > -	return vers;
> > > -}
> > > -
> > > -void
> > > -nfsd_netns_free_versions(struct nfsd_net *nn)
> > > -{
> > > -	kfree(nn->nfsd_versions);
> > > -	kfree(nn->nfsd4_minorversions);
> > > -	nn->nfsd_versions =3D NULL;
> > > -	nn->nfsd4_minorversions =3D NULL;
> > > -}
> > > -
> > > -static void
> > > -nfsd_netns_init_versions(struct nfsd_net *nn)
> > > -{
> > > -	if (!nn->nfsd_versions) {
> > > -		nn->nfsd_versions =3D nfsd_alloc_versions();
> > > -		nn->nfsd4_minorversions =3D nfsd_alloc_minorversions();
> > > -		if (!nn->nfsd_versions || !nn->nfsd4_minorversions)
> > > -			nfsd_netns_free_versions(nn);
> > > -	}
> > > -}
> > > -
> > >  int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change)
> > >  {
> > > -	if (vers < NFSD_MINVERS || vers >=3D NFSD_NRVERS)
> > > +	if (vers < NFSD_MINVERS || vers > NFSD_MAXVERS)
> > >  		return 0;
> > >  	switch(change) {
> > >  	case NFSD_SET:
> > > -		if (nn->nfsd_versions)
> > > -			nn->nfsd_versions[vers] =3D nfsd_support_version(vers);
> > > +		nn->nfsd_versions[vers] =3D nfsd_support_version(vers);
> > >  		break;
> > >  	case NFSD_CLEAR:
> > > -		nfsd_netns_init_versions(nn);
> > > -		if (nn->nfsd_versions)
> > > -			nn->nfsd_versions[vers] =3D false;
> > > +		nn->nfsd_versions[vers] =3D false;
> > >  		break;
> > >  	case NFSD_TEST:
> > > -		if (nn->nfsd_versions)
> > > -			return nn->nfsd_versions[vers];
> > > -		fallthrough;
> > > +		return nn->nfsd_versions[vers];
> > >  	case NFSD_AVAIL:
> > >  		return nfsd_support_version(vers);
> > >  	}
> > > @@ -233,23 +176,16 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 mi=
norversion, enum vers_op change
> > > =20
> > >  	switch(change) {
> > >  	case NFSD_SET:
> > > -		if (nn->nfsd4_minorversions) {
> > > -			nfsd_vers(nn, 4, NFSD_SET);
> > > -			nn->nfsd4_minorversions[minorversion] =3D
> > > -				nfsd_vers(nn, 4, NFSD_TEST);
> > > -		}
> > > +		nfsd_vers(nn, 4, NFSD_SET);
> > > +		nn->nfsd4_minorversions[minorversion] =3D
> > > +			nfsd_vers(nn, 4, NFSD_TEST);
> > >  		break;
> > >  	case NFSD_CLEAR:
> > > -		nfsd_netns_init_versions(nn);
> > > -		if (nn->nfsd4_minorversions) {
> > > -			nn->nfsd4_minorversions[minorversion] =3D false;
> > > -			nfsd_adjust_nfsd_versions4(nn);
> > > -		}
> > > +		nn->nfsd4_minorversions[minorversion] =3D false;
> > > +		nfsd_adjust_nfsd_versions4(nn);
> > >  		break;
> > >  	case NFSD_TEST:
> > > -		if (nn->nfsd4_minorversions)
> > > -			return nn->nfsd4_minorversions[minorversion];
> > > -		return nfsd_vers(nn, 4, NFSD_TEST);
> > > +		return nn->nfsd4_minorversions[minorversion];
> > >  	case NFSD_AVAIL:
> > >  		return minorversion <=3D NFSD_SUPPORTED_MINOR_VERSION &&
> > >  			nfsd_vers(nn, 4, NFSD_AVAIL);
> > > @@ -568,11 +504,11 @@ void nfsd_reset_versions(struct nfsd_net *nn)
> > >  {
> > >  	int i;
> > > =20
> > > -	for (i =3D 0; i < NFSD_NRVERS; i++)
> > > +	for (i =3D 0; i <=3D NFSD_MAXVERS; i++)
> > >  		if (nfsd_vers(nn, i, NFSD_TEST))
> > >  			return;
> > > =20
> > > -	for (i =3D 0; i < NFSD_NRVERS; i++)
> > > +	for (i =3D 0; i <=3D NFSD_MAXVERS; i++)
> > >  		if (i !=3D 4)
> > >  			nfsd_vers(nn, i, NFSD_SET);
> > >  		else {
> > > @@ -905,17 +841,17 @@ nfsd_init_request(struct svc_rqst *rqstp,
> > >  	if (likely(nfsd_vers(nn, rqstp->rq_vers, NFSD_TEST)))
> > >  		return svc_generic_init_request(rqstp, progp, ret);
> > > =20
> > > -	ret->mismatch.lovers =3D NFSD_NRVERS;
> > > -	for (i =3D NFSD_MINVERS; i < NFSD_NRVERS; i++) {
> > > +	ret->mismatch.lovers =3D NFSD_MAXVERS + 1;
> > > +	for (i =3D NFSD_MINVERS; i <=3D NFSD_MAXVERS; i++) {
> > >  		if (nfsd_vers(nn, i, NFSD_TEST)) {
> > >  			ret->mismatch.lovers =3D i;
> > >  			break;
> > >  		}
> > >  	}
> > > -	if (ret->mismatch.lovers =3D=3D NFSD_NRVERS)
> > > +	if (ret->mismatch.lovers > NFSD_MAXVERS)
> > >  		return rpc_prog_unavail;
> > >  	ret->mismatch.hivers =3D NFSD_MINVERS;
> > > -	for (i =3D NFSD_NRVERS - 1; i >=3D NFSD_MINVERS; i--) {
> > > +	for (i =3D NFSD_MAXVERS; i >=3D NFSD_MINVERS; i--) {
> > >  		if (nfsd_vers(nn, i, NFSD_TEST)) {
> > >  			ret->mismatch.hivers =3D i;
> > >  			break;
> > > --=20
> > > 2.44.0
> > >=20
> > >=20
> >=20
>=20
>=20
>=20


