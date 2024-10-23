Return-Path: <linux-nfs+bounces-7401-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 344789AD67F
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 23:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADCC41F210DB
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 21:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE4615B0EE;
	Wed, 23 Oct 2024 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mOjTtMkP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="22+9ZXaK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mOjTtMkP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="22+9ZXaK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805231494B3
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 21:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718348; cv=none; b=nNsCFLaBG1HHZEReHxUDOzarVwyKI13c+NhG6EvMskgNo07y/nmIPLf8MIRNyfoBv9PTlK+fel/uF1xnk5O3FeTG4r0VXbgVoNB+YiDU2SPzojpt7RuReO6ENvfY3uuiBj4bMjqagEl9ylJfzR3U4iGV/sAuqQwtZatfGNZ+IoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718348; c=relaxed/simple;
	bh=wGHEzZ3gvkbWsPYNZBmdTmRU9rcwXEmc7EA5kUNgPDE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=uhXh1eIayb/KSnv8K1Mb4+bTmKr20RFHktkxf15nGjVtvL9uFCmdKma7R4lpHhpwFzYt8RAVnSYdDCt+b8SIS5+AXhj0xY2PrWL9DCt/kbWYjhLLgJmO75QlWNXgULIyQRJeTUkRDlFCdeJtmOpG/HsRDS/Hqj4ITD8cbF8ncQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mOjTtMkP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=22+9ZXaK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mOjTtMkP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=22+9ZXaK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 619741FB79;
	Wed, 23 Oct 2024 21:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729718343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMSc7GqbDZRrXTOSGbVuAfbTYZYNFNYIedDMPhf/Xuo=;
	b=mOjTtMkPEJHJrCCQSl13WMQokilRCI+3fTrkprne3G3i3Ngwa4wJFExW4KmqNhHIJc295/
	xkHQnN5ySNTKGdUiIZdOFoBDF4h0b8we3PgqA5K+HtVHqR1ZtbE+PxlydePZoIgo99C1bI
	Hk1rZsWfbK6TxOJBEnsMdEYQ9LutHrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729718343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMSc7GqbDZRrXTOSGbVuAfbTYZYNFNYIedDMPhf/Xuo=;
	b=22+9ZXaKqHQ5sPwQ2qLl5LKgXnE/SJH2cdFcp7iyGsjIkz9B8KoCy2Bt+oRuL4lbHS3DPO
	k/nbCjBXXZkUfkDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mOjTtMkP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=22+9ZXaK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729718343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMSc7GqbDZRrXTOSGbVuAfbTYZYNFNYIedDMPhf/Xuo=;
	b=mOjTtMkPEJHJrCCQSl13WMQokilRCI+3fTrkprne3G3i3Ngwa4wJFExW4KmqNhHIJc295/
	xkHQnN5ySNTKGdUiIZdOFoBDF4h0b8we3PgqA5K+HtVHqR1ZtbE+PxlydePZoIgo99C1bI
	Hk1rZsWfbK6TxOJBEnsMdEYQ9LutHrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729718343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMSc7GqbDZRrXTOSGbVuAfbTYZYNFNYIedDMPhf/Xuo=;
	b=22+9ZXaKqHQ5sPwQ2qLl5LKgXnE/SJH2cdFcp7iyGsjIkz9B8KoCy2Bt+oRuL4lbHS3DPO
	k/nbCjBXXZkUfkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A96613A63;
	Wed, 23 Oct 2024 21:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FUWXAEVoGWfeCgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 23 Oct 2024 21:19:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 4/6] nfsd: don't use sv_nrthreads in connection limiting
 calculations.
In-reply-to: <de7e2dfbbbe3f51848e303af446afe615d14efe8.camel@kernel.org>
References: <>, <de7e2dfbbbe3f51848e303af446afe615d14efe8.camel@kernel.org>
Date: Thu, 24 Oct 2024 08:18:49 +1100
Message-id: <172971832999.81717.378431428903601298@noble.neil.brown.name>
X-Rspamd-Queue-Id: 619741FB79
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Wed, 23 Oct 2024, Jeff Layton wrote:
> On Wed, 2024-10-23 at 13:37 +1100, NeilBrown wrote:
> > The heuristic for limiting the number of incoming connections to nfsd
> > currently uses sv_nrthreads - allowing more connections if more threads
> > were configured.
> >=20
> > A future patch will allow number of threads to grow dynamically so that
> > there will be no need to configure sv_nrthreads.  So we need a different
> > solution for limiting connections.
> >=20
> > It isn't clear what problem is solved by limiting connections (as
> > mentioned in a code comment) but the most likely problem is a connection
> > storm - many connections that are not doing productive work.  These will
> > be closed after about 6 minutes already but it might help to slow down a
> > storm.
> >=20
> > This patch adds a per-connection flag XPT_PEER_VALID which indicates
> > that the peer has presented a filehandle for which it has some sort of
> > access.  i.e the peer is known to be trusted in some way.  We now only
> > count connections which have NOT been determined to be valid.  There
> > should be relative few of these at any given time.
> >=20
> > If the number of non-validated peer exceed a limit - currently 64 - we
> > close the oldest non-validated peer to avoid having too many of these
> > useless connections.
> >=20
> > Note that this patch significantly changes the meaning of the various
> > configuration parameters for "max connections".  The next patch will
> > remove all of these.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfs/callback.c               |  4 ----
> >  fs/nfs/callback_xdr.c           |  1 +
> >  fs/nfsd/netns.h                 |  4 ++--
> >  fs/nfsd/nfsfh.c                 |  2 ++
> >  include/linux/sunrpc/svc.h      |  2 +-
> >  include/linux/sunrpc/svc_xprt.h | 15 +++++++++++++++
> >  net/sunrpc/svc_xprt.c           | 33 +++++++++++++++++----------------
> >  7 files changed, 38 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> > index 6cf92498a5ac..86bdc7d23fb9 100644
> > --- a/fs/nfs/callback.c
> > +++ b/fs/nfs/callback.c
> > @@ -211,10 +211,6 @@ static struct svc_serv *nfs_callback_create_svc(int =
minorversion)
> >  		return ERR_PTR(-ENOMEM);
> >  	}
> >  	cb_info->serv =3D serv;
> > -	/* As there is only one thread we need to over-ride the
> > -	 * default maximum of 80 connections
> > -	 */
> > -	serv->sv_maxconn =3D 1024;
> >  	dprintk("nfs_callback_create_svc: service created\n");
> >  	return serv;
> >  }
> > diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
> > index fdeb0b34a3d3..4254ba3ee7c5 100644
> > --- a/fs/nfs/callback_xdr.c
> > +++ b/fs/nfs/callback_xdr.c
> > @@ -984,6 +984,7 @@ static __be32 nfs4_callback_compound(struct svc_rqst =
*rqstp)
> >  			nfs_put_client(cps.clp);
> >  			goto out_invalidcred;
> >  		}
> > +		svc_xprt_set_valid(rqstp->rq_xprt);
> >  	}
> > =20
> >  	cps.minorversion =3D hdr_arg.minorversion;
> > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > index 26f7b34d1a03..a05a45bb1978 100644
> > --- a/fs/nfsd/netns.h
> > +++ b/fs/nfsd/netns.h
> > @@ -129,8 +129,8 @@ struct nfsd_net {
> >  	unsigned char writeverf[8];
> > =20
> >  	/*
> > -	 * Max number of connections this nfsd container will allow. Defaults
> > -	 * to '0' which is means that it bases this on the number of threads.
> > +	 * Max number of non-validated connections this nfsd container
> > +	 * will allow.  Defaults to '0' gets mapped to 64.
> >  	 */
> >  	unsigned int max_connections;
> > =20
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index 40ad58a6a036..2f44de99f709 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -383,6 +383,8 @@ __fh_verify(struct svc_rqst *rqstp,
> >  		goto out;
> > =20
> >  skip_pseudoflavor_check:
> > +	svc_xprt_set_valid(rqstp->rq_xprt);
> > +
>=20
> This makes a lot of sense, but I don't see where lockd sets
> XPT_PEER_VALID with this patch. Does it need a call in
> nlm_lookup_file() or someplace similar?

Lockd calls nlm_svc_binding.fopen which is nlm_fopen() which calls
nfsd_open() which calls fh_verify() which calls svc_xprt_set_valid().


>=20
> >  	/* Finally, check access permissions. */
> >  	error =3D nfsd_permission(cred, exp, dentry, access);
> >  out:
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index e68fecf6eab5..617ebfff2f30 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -81,7 +81,7 @@ struct svc_serv {
> >  	unsigned int		sv_xdrsize;	/* XDR buffer size */
> >  	struct list_head	sv_permsocks;	/* all permanent sockets */
> >  	struct list_head	sv_tempsocks;	/* all temporary sockets */
> > -	int			sv_tmpcnt;	/* count of temporary sockets */
> > +	int			sv_tmpcnt;	/* count of temporary "valid" sockets */
> >  	struct timer_list	sv_temptimer;	/* timer for aging temporary sockets */
> > =20
> >  	char *			sv_name;	/* service name */
> > diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_x=
prt.h
> > index 0981e35a9fed..35929a7727c7 100644
> > --- a/include/linux/sunrpc/svc_xprt.h
> > +++ b/include/linux/sunrpc/svc_xprt.h
> > @@ -99,8 +99,23 @@ enum {
> >  	XPT_HANDSHAKE,		/* xprt requests a handshake */
> >  	XPT_TLS_SESSION,	/* transport-layer security established */
> >  	XPT_PEER_AUTH,		/* peer has been authenticated */
> > +	XPT_PEER_VALID,		/* peer has presented a filehandle that
> > +				 * it has access to.  It is NOT counted
> > +				 * in ->sv_tmpcnt.
> > +				 */
> >  };
> > =20
> > +static inline void svc_xprt_set_valid(struct svc_xprt *xpt)
> > +{
> > +	if (test_bit(XPT_TEMP, &xpt->xpt_flags) &&
> > +	    !test_and_set_bit(XPT_PEER_VALID, &xpt->xpt_flags)) {
> > +		struct svc_serv *serv =3D xpt->xpt_server;
> > +		spin_lock(&serv->sv_lock);
> > +		serv->sv_tmpcnt -=3D 1;
> > +		spin_unlock(&serv->sv_lock);
> > +	}
> > +}
> > +
> >  static inline void unregister_xpt_user(struct svc_xprt *xpt, struct svc_=
xpt_user *u)
> >  {
> >  	spin_lock(&xpt->xpt_lock);
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index 43c57124de52..ff5b8bb8a88f 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -606,7 +606,8 @@ int svc_port_is_privileged(struct sockaddr *sin)
> >  }
> > =20
> >  /*
> > - * Make sure that we don't have too many active connections. If we have,
> > + * Make sure that we don't have too many connections that have not yet
> > + * demonstrated that they have access the the NFS server. If we have,
> >   * something must be dropped. It's not clear what will happen if we allow
> >   * "too many" connections, but when dealing with network-facing software,
> >   * we have to code defensively. Here we do that by imposing hard limits.
> > @@ -625,27 +626,26 @@ int svc_port_is_privileged(struct sockaddr *sin)
> >   */
> >  static void svc_check_conn_limits(struct svc_serv *serv)
> >  {
> > -	unsigned int limit =3D serv->sv_maxconn ? serv->sv_maxconn :
> > -				(serv->sv_nrthreads+3) * 20;
> > +	unsigned int limit =3D serv->sv_maxconn ? serv->sv_maxconn : 64;
> > =20
> >  	if (serv->sv_tmpcnt > limit) {
> > -		struct svc_xprt *xprt =3D NULL;
> > +		struct svc_xprt *xprt =3D NULL, *xprti;
> >  		spin_lock_bh(&serv->sv_lock);
> >  		if (!list_empty(&serv->sv_tempsocks)) {
> > -			/* Try to help the admin */
> > -			net_notice_ratelimited("%s: too many open connections, consider incre=
asing the %s\n",
> > -					       serv->sv_name, serv->sv_maxconn ?
> > -					       "max number of connections" :
> > -					       "number of threads");
> >  			/*
> >  			 * Always select the oldest connection. It's not fair,
> > -			 * but so is life
> > +			 * but nor is life.
> >  			 */
> > -			xprt =3D list_entry(serv->sv_tempsocks.prev,
> > -					  struct svc_xprt,
> > -					  xpt_list);
> > -			set_bit(XPT_CLOSE, &xprt->xpt_flags);
> > -			svc_xprt_get(xprt);
> > +			list_for_each_entry_reverse(xprti, &serv->sv_tempsocks,
> > +						    xpt_list)
> > +			{
> > +				if (!test_bit(XPT_PEER_VALID, &xprti->xpt_flags)) {
> > +					xprt =3D xprti;
> > +					set_bit(XPT_CLOSE, &xprt->xpt_flags);
> > +					svc_xprt_get(xprt);
> > +					break;
> > +				}
> > +			}
> >  		}
> >  		spin_unlock_bh(&serv->sv_lock);
> > =20
> > @@ -1039,7 +1039,8 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
> > =20
> >  	spin_lock_bh(&serv->sv_lock);
> >  	list_del_init(&xprt->xpt_list);
> > -	if (test_bit(XPT_TEMP, &xprt->xpt_flags))
> > +	if (test_bit(XPT_TEMP, &xprt->xpt_flags) &&
> > +	    !test_bit(XPT_PEER_VALID, &xprt->xpt_flags))
> >  		serv->sv_tmpcnt--;
> >  	spin_unlock_bh(&serv->sv_lock);
> > =20
>=20
> Other than the comment about lockd, I like this:
>=20
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>=20

Thanks,
NeilBrown

