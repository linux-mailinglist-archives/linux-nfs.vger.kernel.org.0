Return-Path: <linux-nfs+bounces-499-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740F080DF0F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Dec 2023 00:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC8C282623
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 23:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB43A55C26;
	Mon, 11 Dec 2023 23:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s31NYK2t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vXkte2f5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="s31NYK2t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vXkte2f5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A41CB;
	Mon, 11 Dec 2023 14:59:51 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5CFD322447;
	Mon, 11 Dec 2023 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702335590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LePoVybpwvjdQcOaFjez5cAm5ufuJxfHDIgldQ+mJQQ=;
	b=s31NYK2tYhVzD/kOQAbVDWOyHgYJG5A2oAE4tGDLPA1tgwlWW5QiJHiE9BWwd+X4LNMCuP
	y8z3YdpVSRP6GwU2DsikWUVnzQfAj1U2Q2JwJV1SWy9nQfuBkU1rQM+fwxyS97Atd984Vy
	sgKsz99gJLiqQOT76spBUVSyVj9niQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702335590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LePoVybpwvjdQcOaFjez5cAm5ufuJxfHDIgldQ+mJQQ=;
	b=vXkte2f5eKZYCH1yElSfOqEwEopj17bua+4JN63psupnTHgI8YuV2VuWyxqm2XL+XwO3Mn
	LpMut4w5kCgHKPDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702335590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LePoVybpwvjdQcOaFjez5cAm5ufuJxfHDIgldQ+mJQQ=;
	b=s31NYK2tYhVzD/kOQAbVDWOyHgYJG5A2oAE4tGDLPA1tgwlWW5QiJHiE9BWwd+X4LNMCuP
	y8z3YdpVSRP6GwU2DsikWUVnzQfAj1U2Q2JwJV1SWy9nQfuBkU1rQM+fwxyS97Atd984Vy
	sgKsz99gJLiqQOT76spBUVSyVj9niQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702335590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LePoVybpwvjdQcOaFjez5cAm5ufuJxfHDIgldQ+mJQQ=;
	b=vXkte2f5eKZYCH1yElSfOqEwEopj17bua+4JN63psupnTHgI8YuV2VuWyxqm2XL+XwO3Mn
	LpMut4w5kCgHKPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 759F1133DE;
	Mon, 11 Dec 2023 22:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R/i2CWOUd2WVRQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 11 Dec 2023 22:59:47 +0000
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Zhi Li" <yieli@redhat.com>,
 "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: properly tear down server when write_ports fails
In-reply-to: <20231211-nfsd-fixes-v1-1-c87a802f4977@kernel.org>
References: <20231211-nfsd-fixes-v1-1-c87a802f4977@kernel.org>
Date: Tue, 12 Dec 2023 09:59:44 +1100
Message-id: <170233558429.12910.17902271117186364002@noble.neil.brown.name>
X-Spam-Level: *******
X-Spam-Score: 7.11
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s31NYK2t;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vXkte2f5;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-12.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 R_SPF_SOFTFAIL(0.00)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 DMARC_POLICY_ALLOW(0.00)[suse.de,none];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 WHITELIST_DMARC(-7.00)[suse.de:D:+];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -12.01
X-Rspamd-Queue-Id: 5CFD322447
X-Spam-Flag: NO

On Tue, 12 Dec 2023, Jeff Layton wrote:
> When the initial write to the "portlist" file fails, we'll currently put
> the reference to the nn->nfsd_serv, but leave the pointer intact. This
> leads to a UAF if someone tries to write to "portlist" again.
>=20
> Simple reproducer, from a host with nfsd shut down:
>=20
>     # echo "foo 2049" > /proc/fs/nfsd/portlist
>     # echo "foo 2049" > /proc/fs/nfsd/portlist
>=20
> The kernel will oops on the second one when it trips over the dangling
> nn->nfsd_serv pointer. There is a similar bug in __write_ports_addfd.
>=20
> This patch fixes it by adding some extra logic to nfsd_put to ensure
> that nfsd_last_thread is called prior to putting the reference when the
> conditions are right.
>=20
> Fixes: 9f28a971ee9f ("nfsd: separate nfsd_last_thread() from nfsd_put()")
> Closes: https://issues.redhat.com/browse/RHEL-19081
> Reported-by: Zhi Li <yieli@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> This should probably go to stable, but we'll need to backport for v6.6
> since older kernels don't have nfsd_nl_rpc_status_get_done. We should
> just be able to drop that hunk though.
> ---
>  fs/nfsd/nfsctl.c | 32 ++++++++++++++++++++++++++++----
>  fs/nfsd/nfsd.h   |  8 +-------
>  fs/nfsd/nfssvc.c |  2 +-
>  3 files changed, 30 insertions(+), 12 deletions(-)

This is much the same as

https://lore.kernel.org/linux-nfs/20231030011247.9794-2-neilb@suse.de/

It seems that didn't land.  Maybe I dropped the ball...

NeilBrown


>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 3e15b72f421d..1ceccf804e44 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -61,6 +61,30 @@ enum {
>  	NFSD_MaxReserved
>  };
> =20
> +/**
> + * nfsd_put - put the reference to the nfsd_serv for given net
> + * @net: the net namespace for the serv
> + * @err: current error for the op
> + *
> + * When putting a reference to the nfsd_serv from a control operation
> + * we must first call nfsd_last_thread if all of these are true:
> + *
> + * - the configuration operation is going fail
> + * - there are no running threads
> + * - there are no successfully configured ports
> + *
> + * Otherwise, just put the serv reference.
> + */
> +static inline void nfsd_put(struct net *net, int err)
> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct svc_serv *serv =3D nn->nfsd_serv;
> +
> +	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
> +		nfsd_last_thread(net);
> +	svc_put(serv);
> +}
> +
>  /*
>   * write() for these nodes.
>   */
> @@ -709,7 +733,7 @@ static ssize_t __write_ports_addfd(char *buf, struct ne=
t *net, const struct cred
>  	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
>  		svc_get(nn->nfsd_serv);
> =20
> -	nfsd_put(net);
> +	nfsd_put(net, err);
>  	return err;
>  }
> =20
> @@ -748,7 +772,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct =
net *net, const struct cr
>  	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
>  		svc_get(nn->nfsd_serv);
> =20
> -	nfsd_put(net);
> +	nfsd_put(net, 0);
>  	return 0;
>  out_close:
>  	xprt =3D svc_find_xprt(nn->nfsd_serv, transport, net, PF_INET, port);
> @@ -757,7 +781,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct =
net *net, const struct cr
>  		svc_xprt_put(xprt);
>  	}
>  out_err:
> -	nfsd_put(net);
> +	nfsd_put(net, err);
>  	return err;
>  }
> =20
> @@ -1687,7 +1711,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb)
>  {
>  	mutex_lock(&nfsd_mutex);
> -	nfsd_put(sock_net(cb->skb->sk));
> +	nfsd_put(sock_net(cb->skb->sk), 0);
>  	mutex_unlock(&nfsd_mutex);
> =20
>  	return 0;
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index f5ff42f41ee7..3aa8cd2c19ac 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -113,13 +113,6 @@ int		nfsd_pool_stats_open(struct inode *, struct file =
*);
>  int		nfsd_pool_stats_release(struct inode *, struct file *);
>  void		nfsd_shutdown_threads(struct net *net);
> =20
> -static inline void nfsd_put(struct net *net)
> -{
> -	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> -
> -	svc_put(nn->nfsd_serv);
> -}
> -
>  bool		i_am_nfsd(void);
> =20
>  struct nfsdfs_client {
> @@ -153,6 +146,7 @@ struct nfsd_net;
>  enum vers_op {NFSD_SET, NFSD_CLEAR, NFSD_TEST, NFSD_AVAIL };
>  int nfsd_vers(struct nfsd_net *nn, int vers, enum vers_op change);
>  int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op =
change);
> +void nfsd_last_thread(struct net *net);
>  void nfsd_reset_versions(struct nfsd_net *nn);
>  int nfsd_create_serv(struct net *net);
> =20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index fe61d9bbcc1f..d6939e23ffcf 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -542,7 +542,7 @@ static struct notifier_block nfsd_inet6addr_notifier =
=3D {
>  /* Only used under nfsd_mutex, so this atomic may be overkill: */
>  static atomic_t nfsd_notifier_refcount =3D ATOMIC_INIT(0);
> =20
> -static void nfsd_last_thread(struct net *net)
> +void nfsd_last_thread(struct net *net)
>  {
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv =3D nn->nfsd_serv;
>=20
> ---
> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> change-id: 20231211-nfsd-fixes-d9f21d5c12d7
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20


