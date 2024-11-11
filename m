Return-Path: <linux-nfs+bounces-7877-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101049C46EE
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 21:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9D91F222AB
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 20:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812FA13A250;
	Mon, 11 Nov 2024 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w/JJF4sz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f9Ze/57C";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w/JJF4sz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f9Ze/57C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F6F8468
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357315; cv=none; b=lZPyPT7fqgyPmzqlaVwAM3y/mEBrrGeDaSG4M90J/t5/yIsrxjMSAE0DDZy1XSXqT2k0oTiDMrndRzJIOfav/fP0J3Q9aK4k55TQidjpy9a0rpLFV3b7XUSeWNg955wJbP4AgE5sTIyTtQW3Vs5kADsBzGiBZB6lp2D/VpuwzLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357315; c=relaxed/simple;
	bh=Wl9552X3dKoPUyi0di77zjzVZOZ22OvJWnYLCalK3Ek=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=hjZs2LPrXg8oMT9yuN9D6ZAEeWyy78CqwCneihlZkdRbsoj5s3/eqjMu7GgHtfBjRJWjmOxLNDdXUwY/amInZ3JoA6imRsbHPZ5YpEUsm+Rq1HPErew/J/y1p4oX/kUJ3c0tCK5iGwdbKXxeCeXCSSrmUpXCJM2t3fqlhvL7YWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w/JJF4sz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f9Ze/57C; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w/JJF4sz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f9Ze/57C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 341731F38E;
	Mon, 11 Nov 2024 20:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731357311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3XfncjbugmkAryM0+8d0XfzqTas+aAHSBh0CK2womY=;
	b=w/JJF4szGFyXmEKBeajq/ZHzNejJ/8lWNBfzO9yyoPtDOm0L3G7qne0uMukv1/Ot9AbjJO
	rOiCsP/oUlPxFUNg9qswPTZvSElO+j3NwpQGKy6+pxUiZ/w07/Ac5FreTQZj6idASMtweg
	2bQF94bAIZ7c+vnVyR99YmF4hD3qHFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731357311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3XfncjbugmkAryM0+8d0XfzqTas+aAHSBh0CK2womY=;
	b=f9Ze/57CwIkCcj/1J/UovFDddrKKw8/lzpFfoy3nWLHBVYAT2XbpriKw1e+mVHtYkhiSTa
	LUk5W+Aiqv+/HQCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="w/JJF4sz";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="f9Ze/57C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1731357311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3XfncjbugmkAryM0+8d0XfzqTas+aAHSBh0CK2womY=;
	b=w/JJF4szGFyXmEKBeajq/ZHzNejJ/8lWNBfzO9yyoPtDOm0L3G7qne0uMukv1/Ot9AbjJO
	rOiCsP/oUlPxFUNg9qswPTZvSElO+j3NwpQGKy6+pxUiZ/w07/Ac5FreTQZj6idASMtweg
	2bQF94bAIZ7c+vnVyR99YmF4hD3qHFs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1731357311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3XfncjbugmkAryM0+8d0XfzqTas+aAHSBh0CK2womY=;
	b=f9Ze/57CwIkCcj/1J/UovFDddrKKw8/lzpFfoy3nWLHBVYAT2XbpriKw1e+mVHtYkhiSTa
	LUk5W+Aiqv+/HQCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BAF113301;
	Mon, 11 Nov 2024 20:35:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QoUqMHxqMmfYTAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Nov 2024 20:35:08 +0000
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
In-reply-to: <ZzIj52LUYVgu-wZh@kernel.org>
References: <>, <ZzIj52LUYVgu-wZh@kernel.org>
Date: Tue, 12 Nov 2024 07:35:04 +1100
Message-id: <173135730484.1734440.14401027783167324575@noble.neil.brown.name>
X-Rspamd-Queue-Id: 341731F38E
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Tue, 12 Nov 2024, Mike Snitzer wrote:
> On Mon, Nov 11, 2024 at 12:55:24PM +1100, NeilBrown wrote:
> > On Sat, 09 Nov 2024, Mike Snitzer wrote:
> > > Remove cl_localio_lock from 'struct nfs_client' in favor of adding a
> > > lock to the nfs_uuid_t struct (which is embedded in each nfs_client).
> > >=20
> > > Push nfs_local_{enable,disable} implementation down to nfs_common.
> > > Those methods now call nfs_localio_{enable,disable}_client.
> > >=20
> > > This allows implementing nfs_localio_invalidate_clients in terms of
> > > nfs_localio_disable_client.
> > >=20
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  fs/nfs/client.c            |  1 -
> > >  fs/nfs/localio.c           | 18 ++++++------
> > >  fs/nfs_common/nfslocalio.c | 57 ++++++++++++++++++++++++++------------
> > >  include/linux/nfs_fs_sb.h  |  1 -
> > >  include/linux/nfslocalio.h |  8 +++++-
> > >  5 files changed, 55 insertions(+), 30 deletions(-)
> > >=20
> > > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > > index 03ecc7765615..124232054807 100644
> > > --- a/fs/nfs/client.c
> > > +++ b/fs/nfs/client.c
> > > @@ -182,7 +182,6 @@ struct nfs_client *nfs_alloc_client(const struct nf=
s_client_initdata *cl_init)
> > >  	seqlock_init(&clp->cl_boot_lock);
> > >  	ktime_get_real_ts64(&clp->cl_nfssvc_boot);
> > >  	nfs_uuid_init(&clp->cl_uuid);
> > > -	spin_lock_init(&clp->cl_localio_lock);
> > >  #endif /* CONFIG_NFS_LOCALIO */
> > > =20
> > >  	clp->cl_principal =3D "*";
> > > diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> > > index cab2a8819259..4c75ffc5efa2 100644
> > > --- a/fs/nfs/localio.c
> > > +++ b/fs/nfs/localio.c
> > > @@ -125,10 +125,8 @@ const struct rpc_program nfslocalio_program =3D {
> > >   */
> > >  static void nfs_local_enable(struct nfs_client *clp)
> > >  {
> > > -	spin_lock(&clp->cl_localio_lock);
> > > -	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> > >  	trace_nfs_local_enable(clp);
> > > -	spin_unlock(&clp->cl_localio_lock);
> > > +	nfs_localio_enable_client(clp);
> > >  }
> >=20
> > Why do we need this function?  The one caller could call
> > nfs_localio_enable_client() directly instead.  The tracepoint could be
> > placed in that one caller.
>=20
> Yeah, I saw that too but felt it useful to differentiate between calls
> that occur during NFS client initialization and those that happen as a
> side-effect of callers from other contexts (in later patch this
> manifests as nfs_localio_disable_client vs nfs_local_disable).
>=20
> Hence my adding secondary tracepoints for nfs_common (see "[PATCH
> 17/19] nfs_common: add nfs_localio trace events).
>=20
> But sure, we can just eliminate nfs_local_{enable,disable} and the
> corresponding tracepoints (which will have moved down to nfs_common).

I don't feel strongly about this.  If you think these is value in these
wrapper functions then I won't argue.  As a general rule I don't like
multiple interfaces that do (much) the same thing as keeping track of
them increases the mental load.

>=20
> > >  /*
> > > @@ -136,12 +134,8 @@ static void nfs_local_enable(struct nfs_client *cl=
p)
> > >   */
> > >  void nfs_local_disable(struct nfs_client *clp)
> > >  {
> > > -	spin_lock(&clp->cl_localio_lock);
> > > -	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
> > > -		trace_nfs_local_disable(clp);
> > > -		nfs_localio_disable_client(&clp->cl_uuid);
> > > -	}
> > > -	spin_unlock(&clp->cl_localio_lock);
> > > +	trace_nfs_local_disable(clp);
> > > +	nfs_localio_disable_client(clp);
> > >  }
> >=20
> > Ditto.  Though there are more callers so the tracepoint solution isn't
> > quite so obvious.
>=20
> Right... as I just explained: that's why I preserved nfs_local_disable
> (and the tracepoint).
>=20
>=20
> > >  /*
> > > @@ -183,8 +177,12 @@ static bool nfs_server_uuid_is_local(struct nfs_cl=
ient *clp)
> > >  	rpc_shutdown_client(rpcclient_localio);
> > > =20
> > >  	/* Server is only local if it initialized required struct members */
> > > -	if (status || !clp->cl_uuid.net || !clp->cl_uuid.dom)
> > > +	rcu_read_lock();
> > > +	if (status || !rcu_access_pointer(clp->cl_uuid.net) || !clp->cl_uuid.=
dom) {
> > > +		rcu_read_unlock();
> > >  		return false;
> > > +	}
> > > +	rcu_read_unlock();
> >=20
> > What value does RCU provide here?  I don't think this change is needed.
> > rcu_access_pointer does not require rcu_read_lock().
>=20
> OK, not sure why I though RCU read-side needed for rcu_access_pointer()...
>=20
> > >  	return true;
> > >  }
> > > diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> > > index 904439e4bb85..cf2f47ea4f8d 100644
> > > --- a/fs/nfs_common/nfslocalio.c
> > > +++ b/fs/nfs_common/nfslocalio.c
> > > @@ -7,6 +7,9 @@
> > >  #include <linux/module.h>
> > >  #include <linux/list.h>
> > >  #include <linux/nfslocalio.h>
> > > +#include <linux/nfs3.h>
> > > +#include <linux/nfs4.h>
> > > +#include <linux/nfs_fs_sb.h>
> >=20
> > I don't feel good about adding this nfs client knowledge in to nfs_common.
>=20
> I hear you.. I was "OK with it".
>=20
> > >  #include <net/netns/generic.h>
> > > =20
> > >  MODULE_LICENSE("GPL");
> > > @@ -25,6 +28,7 @@ void nfs_uuid_init(nfs_uuid_t *nfs_uuid)
> > >  	nfs_uuid->net =3D NULL;
> > >  	nfs_uuid->dom =3D NULL;
> > >  	INIT_LIST_HEAD(&nfs_uuid->list);
> > > +	spin_lock_init(&nfs_uuid->lock);
> > >  }
> > >  EXPORT_SYMBOL_GPL(nfs_uuid_init);
> > > =20
> > > @@ -94,12 +98,23 @@ void nfs_uuid_is_local(const uuid_t *uuid, struct l=
ist_head *list,
> > >  }
> > >  EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
> > > =20
> > > +void nfs_localio_enable_client(struct nfs_client *clp)
> > > +{
> > > +	nfs_uuid_t *nfs_uuid =3D &clp->cl_uuid;
> > > +
> > > +	spin_lock(&nfs_uuid->lock);
> > > +	set_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
> > > +	spin_unlock(&nfs_uuid->lock);
> > > +}
> > > +EXPORT_SYMBOL_GPL(nfs_localio_enable_client);
> >=20
> > And I don't feel good about nfs_local accessing nfs_client directly.
> > It only uses it for NFS_CS_LOCAL_IO.  Can we ditch that flag and instead
> > so something like testing nfs_uuid.net ??
>=20
> That'd probably be OK for the equivalent of NFS_CS_LOCAL_IO but the last
> patch in this series ("nfs: probe for LOCALIO when v3 client
> reconnects to server") adds NFS_CS_LOCAL_IO_CAPABLE to provide a hint
> that the client and server successfully established themselves local
> via LOCALIO protocol.  This is needed so that NFSv3 (stateless) has a
> hint that reestablishing LOCALIO needed if/when the client loses
> connectivity to the server (because it was shutdown and restarted).

I don't like NFS_CS_LOCAL_IO_CAPABLE.
A use case that I imagine (and a customer does something like this) is an
HA cluster where the NFS server can move from one node to another.  All
the node access the filesystem, most over NFS.  If a server-migration
happens (e.g.  the current server node failed) then the new server node
would suddenly become LOCALIO-capable even though it wasn't at
mount-time.  I would like it to be able to detect this and start doing
localio.

So I don't want NFS_CS_LOCAL_IO_CAPABLE.  I think tracking when the
network connection is re-established is sufficient.

Thanks,
NeilBrown


