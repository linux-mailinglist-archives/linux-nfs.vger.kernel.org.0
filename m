Return-Path: <linux-nfs+bounces-13942-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0922B3A80D
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 19:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F3145683EB
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Aug 2025 17:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F2F337689;
	Thu, 28 Aug 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVV235nb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FEB176ADB
	for <linux-nfs@vger.kernel.org>; Thu, 28 Aug 2025 17:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402180; cv=none; b=df3qjEh8eHHv3A620MLHWskYhSWC2KBtbXokIRXv6oBqvb6T9lL0EKhBKhEllIRKx5kuLpuFtmwXCfzlyg4YePyC5uBxS/YS1mFP4Z+8acaLaxSYkRReYJNFQCrCF3+qu15Z7kqwUI0RvVIPfQaQT8kVsWMB8Gu1vrWJxFJ537o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402180; c=relaxed/simple;
	bh=ZmpaVAZc/IOxjZ0mFH917N/bvG+T9S/K17pRggdx5vs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gufiHry/4NoqSE5++QTUDI9R1vyKJ/8tX46liwQZDiuyGUekfHHBcejp7VQaMlkEtKjL4q/cE5VjN/NbS2P9Ue/yTpTzBbhWzRCe98A4TbXrfyZUW18QSMbtW9E42fFvVFg0IvCb7vVfsXn1twbO+U6N/JcW30vtKf3riz+i2ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVV235nb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EADC4CEED;
	Thu, 28 Aug 2025 17:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756402180;
	bh=ZmpaVAZc/IOxjZ0mFH917N/bvG+T9S/K17pRggdx5vs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=uVV235nbYz1uemCpBmGBWfNqUylbXcAgPn+EiVeldju4u40Nuq9Ww5SWq4uom5tDi
	 1Ter5E+VHf2vFSqx9kW6U6lrLv9yMAvfZwi7wG2slEwxXzSqlCBT60LHyEv3QItqPc
	 zezZoM0RjN4VBUEjV1nQDPd94hH6xkBnj/f0MVWb8OCZGrwr35D8CMJj7+YUEiHHzW
	 zpsYZD4s2biDPOdhPEPn63F0l4KLrKKTE3Z6VnggJ0QIwTqmpCeulPrlKRcwTuejaN
	 pk8JPUjkBTPpCoe20MTXhikyjQu2MagL3T244jQAULOHqxiYrOYQ0yoRK5BmP3L8X1
	 KiOwbMDw0TO9Q==
Message-ID: <e56f9194f0e65e85d92da4129f636fe40b34e54c.camel@kernel.org>
Subject: Re: [RFC PATCH 1/1] nfsd: rework how a listener is removed
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia
	 <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org, neil@brown.name, Dai.Ngo@oracle.com, 
	tom@talpey.com
Date: Thu, 28 Aug 2025 13:29:38 -0400
In-Reply-To: <a641de95-07d3-479d-be64-11d99e56e08b@oracle.com>
References: <20250826220001.8235-1-okorniev@redhat.com>
	 <41502e2f-0d97-48a3-876f-62c33ae6d657@oracle.com>
	 <a641de95-07d3-479d-be64-11d99e56e08b@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-08-28 at 11:21 -0400, Chuck Lever wrote:
> On 8/27/25 10:21 AM, Chuck Lever wrote:
> > On 8/26/25 6:00 PM, Olga Kornievskaia wrote:
> > > This patch tries to address the following failure:
> > > nfsdctl threads 0
> > > nfsdctl listener +rdma::20049
> > > nfsdctl listener +tcp::2049
> > > nfsdctl listener -tcp::2049
> > > nfsdctl: Error: Cannot assign requested address
> > >=20
> > > The reason for the failure is due to the fact that socket cleanup onl=
y
> > > happens in __svc_rdma_free() which is a deferred work triggers when a=
n
> > > rdma transport is destroyed. To remove a listener nfsdctl is forced t=
o
> > > first remove all transports via svc_xprt_destroy_all() and then re-ad=
d
> > > the ones that are left. Due to the fact that there isn't a way to
> > > delete a particular entry from server's lwq sp_xprts that stores
> > > transports. Going back to the deferred work done in __svc_rdma_free()=
,
> > > the work might not get to run before nfsd_nl_listener_set_doit() crea=
tes
> > > the new transports. As a result, it finds that something is still
> > > listening of the rdma port and rdma_bind_addr() fails.
> > >=20
> > > Instead of using svc_xprt_destroy_all() to manipulate the sp_xprt,
> > > instead introduce a function that just dequeues all transports. Then,
> > > we add non-removed transports back to the list.
> > >=20
> > > Still not allowing to remove a listener while the server is active.
> > >=20
> > > We need to make several passes over the list of existing/new list
> > > entries. On the first pass we determined if any of the entries need
> > > to be removed. If so, we then check if the server has no active
> > > threads. Then we dequeue all the transports and then go over the
> > > list and recreate both permsocks list and sp_xprts lists. Then,
> > > for the deleted transports, the transport is closed.
> >=20
> > > --- Comments:
> > > (1) There is still a restriction on removing an active listener as
> > > I dont know how to handle if the transport to be remove is currently
> > > serving a request (it won't be on the sp_xprt list I believe?).
> >=20
> > This is a good reason why just setting a bit in the xprt and waiting fo=
r
> > the close to complete is probably a better strategy than draining and
> > refilling the permsock list.
> >=20
> > The idea of setting XPT_CLOSE and enqueuing the transport ... you know,
> > like this:
> >=20
> >  151 /**
> >=20
> >  152  * svc_xprt_deferred_close - Close a transport
> >=20
> >  153  * @xprt: transport instance
> >=20
> >  154  *
> >=20
> >  155  * Used in contexts that need to defer the work of shutting down
> >=20
> >  156  * the transport to an nfsd thread.
> >=20
> >  157  */
> >=20
> >  158 void svc_xprt_deferred_close(struct svc_xprt *xprt)
> >=20
> >  159 {
> >=20
> >  160         trace_svc_xprt_close(xprt);
> >=20
> >  161         if (!test_and_set_bit(XPT_CLOSE, &xprt->xpt_flags))
> >=20
> >  162                 svc_xprt_enqueue(xprt);
> >=20
> >  163 }
> >=20
> >  164 EXPORT_SYMBOL_GPL(svc_xprt_deferred_close);
> >=20
> > I expect that eventually the xprt will show up to svc_handle_xprt() and
> > get deleted there. But you might still need some serialization with
> >   ->xpo_accept ?
>=20
> It occurred to me why the deferred close mechanism doesn't work: it
> relies on having an nfsd thread to pick up the deferred work.
>=20
> If listener removal requires all nfsd threads to be terminated, there
> is no thread to pick up the xprt and close it.
>=20

Interesting. I guess that the old nfsdfs file just didn't allow you to
get into this situation, since you couldn't remove a listener at all.

It really sounds like we just need a more selective version of
svc_clean_up_xprts(). Something that can dequeue everything, close the
ones that need to be closed (synchronously) and then requeues the rest.


>=20
> > > In general, I'm unsure if there are other things I'm not considering.
> > > (2) I'm questioning if in svc_xprt_dequeue_all() it is correct. I
> > > used svc_cleanup_up_xprts() as the example.
> > > > Fixes: d093c90892607 ("nfsd: fix management of listener transports"=
)
> > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
> > > ---
> > >  fs/nfsd/nfsctl.c                | 123 +++++++++++++++++++-----------=
--
> > >  include/linux/sunrpc/svc_xprt.h |   1 +
> > >  include/linux/sunrpc/svcsock.h  |   1 -
> > >  net/sunrpc/svc_xprt.c           |  12 ++++
> > >  4 files changed, 88 insertions(+), 49 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index dd3267b4c203..38aaaef4734e 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -1902,44 +1902,17 @@ int nfsd_nl_version_get_doit(struct sk_buff *=
skb, struct genl_info *info)
> > >  	return err;
> > >  }
> > > =20
> > > -/**
> > > - * nfsd_nl_listener_set_doit - set the nfs running sockets
> > > - * @skb: reply buffer
> > > - * @info: netlink metadata and command arguments
> > > - *
> > > - * Return 0 on success or a negative errno.
> > > - */
> > > -int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info =
*info)
> > > +static void _nfsd_walk_listeners(struct genl_info *info, struct svc_=
serv *serv,
> > > +				 struct list_head *permsocks, int modify_xprt)
> >=20
> > So this function looks for the one listener we need to remove.
> >=20
> > Should removing a listener also close down all active temporary sockets
> > for the service, or should it kill only the ones that were established
> > via the listener being removed, or should it leave all active temporary
> > sockets in place?
> >=20
> > Perhaps this is why /all/ permanent and temporary sockets are currently
> > being removed. Once the target listener is gone, clients can't
> > re-establish new connections, and the service is effectively ready to
> > be shut down cleanly.
> >=20
> >=20
> > >  {
> > >  	struct net *net =3D genl_info_net(info);
> > > -	struct svc_xprt *xprt, *tmp;
> > >  	const struct nlattr *attr;
> > > -	struct svc_serv *serv;
> > > -	LIST_HEAD(permsocks);
> > > -	struct nfsd_net *nn;
> > > -	bool delete =3D false;
> > > -	int err, rem;
> > > -
> > > -	mutex_lock(&nfsd_mutex);
> > > -
> > > -	err =3D nfsd_create_serv(net);
> > > -	if (err) {
> > > -		mutex_unlock(&nfsd_mutex);
> > > -		return err;
> > > -	}
> > > -
> > > -	nn =3D net_generic(net, nfsd_net_id);
> > > -	serv =3D nn->nfsd_serv;
> > > -
> > > -	spin_lock_bh(&serv->sv_lock);
> > > +	struct svc_xprt *xprt, *tmp;
> > > +	int rem;
> > > =20
> > > -	/* Move all of the old listener sockets to a temp list */
> > > -	list_splice_init(&serv->sv_permsocks, &permsocks);
> > > +	if (modify_xprt)
> > > +		svc_xprt_dequeue_all(serv);
> > > =20
> > > -	/*
> > > -	 * Walk the list of server_socks from userland and move any that ma=
tch
> > > -	 * back to sv_permsocks
> > > -	 */
> > >  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> > >  		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
> > >  		const char *xcl_name;
> > > @@ -1962,7 +1935,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *s=
kb, struct genl_info *info)
> > >  		sa =3D nla_data(tb[NFSD_A_SOCK_ADDR]);
> > > =20
> > >  		/* Put back any matching sockets */
> > > -		list_for_each_entry_safe(xprt, tmp, &permsocks, xpt_list) {
> > > +		list_for_each_entry_safe(xprt, tmp, permsocks, xpt_list) {
> > >  			/* This shouldn't be possible */
> > >  			if (WARN_ON_ONCE(xprt->xpt_net !=3D net)) {
> > >  				list_move(&xprt->xpt_list, &serv->sv_permsocks);
> > > @@ -1971,35 +1944,89 @@ int nfsd_nl_listener_set_doit(struct sk_buff =
*skb, struct genl_info *info)
> > > =20
> > >  			/* If everything matches, put it back */
> > >  			if (!strcmp(xprt->xpt_class->xcl_name, xcl_name) &&
> > > -			    rpc_cmp_addr_port(sa, (struct sockaddr *)&xprt->xpt_local)) {
> > > +			    rpc_cmp_addr_port(sa,
> > > +				    (struct sockaddr *)&xprt->xpt_local)) {
> > >  				list_move(&xprt->xpt_list, &serv->sv_permsocks);
> > > +				if (modify_xprt)
> > > +					svc_xprt_enqueue(xprt);
> > >  				break;
> > >  			}
> > >  		}
> > >  	}
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_listener_set_doit - set the nfs running sockets
> > > + * @skb: reply buffer
> > > + * @info: netlink metadata and command arguments
> > > + *
> > > + * Return 0 on success or a negative errno.
> > > + */
> > > +int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info =
*info)
> > > +{
> > > +	struct net *net =3D genl_info_net(info);
> > > +	struct svc_xprt *xprt;
> > > +	const struct nlattr *attr;
> > > +	struct svc_serv *serv;
> > > +	LIST_HEAD(permsocks);
> > > +	struct nfsd_net *nn;
> > > +	bool delete =3D false;
> > > +	int err, rem;
> > > +
> > > +	mutex_lock(&nfsd_mutex);
> > > +
> > > +	err =3D nfsd_create_serv(net);
> > > +	if (err) {
> > > +		mutex_unlock(&nfsd_mutex);
> > > +		return err;
> > > +	}
> > > +
> > > +	nn =3D net_generic(net, nfsd_net_id);
> > > +	serv =3D nn->nfsd_serv;
> > > +
> > > +	spin_lock_bh(&serv->sv_lock);
> > > +
> > > +	/* Move all of the old listener sockets to a temp list */
> > > +	list_splice_init(&serv->sv_permsocks, &permsocks);
> > > =20
> > >  	/*
> > > -	 * If there are listener transports remaining on the permsocks list=
,
> > > -	 * it means we were asked to remove a listener.
> > > +	 * Walk the list of server_socks from userland and move any that ma=
tch
> > > +	 * back to sv_permsocks. Determine if anything needs to be removed =
so
> > > +	 * don't manipulate sp_xprts list.
> > >  	 */
> > > -	if (!list_empty(&permsocks)) {
> > > -		list_splice_init(&permsocks, &serv->sv_permsocks);
> > > -		delete =3D true;
> > > -	}
> > > -	spin_unlock_bh(&serv->sv_lock);
> > > +	_nfsd_walk_listeners(info, serv, &permsocks, false);
> > > =20
> > > -	/* Do not remove listeners while there are active threads. */
> > > -	if (serv->sv_nrthreads) {
> > > +	/* For now, no removing old sockets while server is running */
> > > +	if (serv->sv_nrthreads && !list_empty(&permsocks)) {
> > > +		list_splice_init(&permsocks, &serv->sv_permsocks);
> > > +		spin_unlock_bh(&serv->sv_lock);
> > >  		err =3D -EBUSY;
> > >  		goto out_unlock_mtx;
> > >  	}
> > > =20
> > >  	/*
> > > -	 * Since we can't delete an arbitrary llist entry, destroy the
> > > -	 * remaining listeners and recreate the list.
> > > +	 * If there are listener transports remaining on the permsocks list=
,
> > > +	 * it means we were asked to remove a listener. Walk the list again=
,
> > > +	 * but this time also manage the sp_xprts but first removing all of
> > > +	 * them and only adding back the ones not being deleted. Then close
> > > +	 * the ones left on the list.
> > >  	 */
> > > -	if (delete)
> > > -		svc_xprt_destroy_all(serv, net, false);
> > > +	if (!list_empty(&permsocks)) {
> > > +		list_splice_init(&permsocks, &serv->sv_permsocks);
> > > +		list_splice_init(&serv->sv_permsocks, &permsocks);
> > > +		_nfsd_walk_listeners(info, serv, &permsocks, true);
> > > +		while (!list_empty(&permsocks)) {
> > > +			xprt =3D list_first_entry(&permsocks, struct svc_xprt, xpt_list);
> > > +			clear_bit(XPT_BUSY, &xprt->xpt_flags);
> > > +			set_bit(XPT_CLOSE, &xprt->xpt_flags);
> > > +			spin_unlock_bh(&serv->sv_lock);
> > > +			svc_xprt_close(xprt);
> > > +			spin_lock_bh(&serv->sv_lock);
> > > +		}
> > > +		spin_unlock_bh(&serv->sv_lock);
> > > +		goto out_unlock_mtx;
> > > +	}
> > > +	spin_unlock_bh(&serv->sv_lock);
> > > =20
> > >  	/* walk list of addrs again, open any that still don't exist */
> > >  	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> > > diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/s=
vc_xprt.h
> > > index da2a2531e110..7038fd8ef20a 100644
> > > --- a/include/linux/sunrpc/svc_xprt.h
> > > +++ b/include/linux/sunrpc/svc_xprt.h
> > > @@ -186,6 +186,7 @@ int	svc_xprt_names(struct svc_serv *serv, char *b=
uf, const int buflen);
> > >  void	svc_add_new_perm_xprt(struct svc_serv *serv, struct svc_xprt *x=
prt);
> > >  void	svc_age_temp_xprts_now(struct svc_serv *, struct sockaddr *);
> > >  void	svc_xprt_deferred_close(struct svc_xprt *xprt);
> > > +void	svc_xprt_dequeue_all(struct svc_serv *serv);
> > > =20
> > >  static inline void svc_xprt_get(struct svc_xprt *xprt)
> > >  {
> > > diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/sv=
csock.h
> > > index 963bbe251e52..4c1be01afdb7 100644
> > > --- a/include/linux/sunrpc/svcsock.h
> > > +++ b/include/linux/sunrpc/svcsock.h
> > > @@ -65,7 +65,6 @@ int		svc_addsock(struct svc_serv *serv, struct net =
*net,
> > >  			    const struct cred *cred);
> > >  void		svc_init_xprt_sock(void);
> > >  void		svc_cleanup_xprt_sock(void);
> > > -
> > >  /*
> > >   * svc_makesock socket characteristics
> > >   */
> > > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > > index 6973184ff667..2aa46b9468d4 100644
> > > --- a/net/sunrpc/svc_xprt.c
> > > +++ b/net/sunrpc/svc_xprt.c
> > > @@ -890,6 +890,18 @@ void svc_recv(struct svc_rqst *rqstp)
> > >  }
> > >  EXPORT_SYMBOL_GPL(svc_recv);
> > > =20
> > > +void svc_xprt_dequeue_all(struct svc_serv *serv)
> > > +{
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < serv->sv_nrpools; i++) {
> > > +		struct svc_pool *pool =3D &serv->sv_pools[i];
> > > +
> > > +		lwq_dequeue_all(&pool->sp_xprts);
> > > +	}
> > > +}
> > > +EXPORT_SYMBOL_GPL(svc_xprt_dequeue_all);
> > > +
> > >  /**
> > >   * svc_send - Return reply to client
> > >   * @rqstp: RPC transaction context
> >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

