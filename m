Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9EF7D9E32
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 18:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjJ0QuS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 12:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjJ0QuR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 12:50:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D42E1;
        Fri, 27 Oct 2023 09:50:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB4BC433C7;
        Fri, 27 Oct 2023 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698425414;
        bh=SaGw9jHheUzO+r0FI8PxiwIPJF9z/2Y9GdeCduPymZM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SFSERl8Ud4q7XAsMtgqMV+mXVxLD6NFyXggDNSeTkx0JhtoRj9fxsXe2OOO6MTmY5
         gXEchfcyH42eTmZVhUeoU5yZa7i+0NEOVLMHmHQ9jNRcmXTFhGvb7l49Db6LhDBrSn
         Vp3ZHWUyBs+XF3eShY2IW4owZsrxQsrLJrNrJqY0MQR7s17sv9k+zfHi3dc3oKyFKu
         y7dm7zRPMq4UR3IduV6KpqWKhtZe5qOjEs+DfAYXU3pSRur+Mv2BDNdpDrtZYjYxTR
         em8h2zoMAWGRSn63KwPTgi9yyCaeMd3uFwSPUEkVZ1UYjUXEtcwgdd9oSGVKmi4Jzo
         WuJmYHLcl1yVA==
Message-ID: <3164f1a893197381cd3b5edc2271f2c67713c93a.camel@kernel.org>
Subject: Re: [PATCH] nfsd: ensure the nfsd_serv pointer is cleared when svc
 is torn down
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhi Li <yieli@redhat.com>
Date:   Fri, 27 Oct 2023 12:50:12 -0400
In-Reply-To: <ZTvh0tyY0pNUlboH@tissot.1015granger.net>
References: <20231027-kdevops-v1-1-73711c16186c@kernel.org>
         <ZTvh0tyY0pNUlboH@tissot.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-10-27 at 12:14 -0400, Chuck Lever wrote:
> On Fri, Oct 27, 2023 at 07:53:44AM -0400, Jeff Layton wrote:
> > Zhi Li reported a refcount_t use-after-free when bringing up nfsd.
>=20
> Aw, Jeff. You promised you wouldn't post a bug fix during the last
> weekend of -rc again. ;-)
>=20

I never promised anything!

>=20
> > We set the nn->nfsd_serv pointer in nfsd_create_serv, but it's only eve=
r
> > cleared in nfsd_last_thread. When setting up a new socket, if there is
> > an error, this can leave nfsd_serv pointer set after it has been freed.
>=20
> Maybe missing a call to nfsd_last_thread in this case?
>=20

Yeah, that might be the better fix here.

>=20
> > We need to better couple the existence of the object with the value of
> > the nfsd_serv pointer.
> >=20
> > Since we always increment and decrement the svc_serv references under
> > mutex, just test for whether the next put will destroy it in nfsd_put,
> > and clear the pointer beforehand if so. Add a new nfsd_get function for
>=20
> My memory isn't 100% reliable, but I seem to recall that Neil spent
> some effort getting rid of the nfsd_get() helper in recent kernels.
> So, nfsd_get() isn't especially new. I will wait for Neil's review.
>=20
> Let's target the fix (when we've agreed upon one) for v6.7-rc.
>=20
>=20
> > better clarity and so that we can enforce that the mutex is held via
> > lockdep. Remove the clearing of the pointer from nfsd_last_thread.
> > Finally, change all of the svc_get and svc_put calls to use the updated
> > wrappers.
>=20
> This seems like a good clean-up. If we need to deal with the set up
> and tear down of per-net namespace metadata, I don't see a nicer
> way to do it than nfsd_get/put.
>=20

Zhi reported a second panic where we hit the BUG_ON because sv_permsocks
is still populated. Those sockets also get cleaned out in
nfsd_last_thread, but some of the error paths in nfsd_svc don't call
into there.

So, I think this patch is not a complete fix. We need to ensure that we
clean up everything if writing to "threads" fails for any reason, and it
wasn't already started before.

What I'm not sure of at this point is whether this is a recent
regression. We don't have a reliable reproducer just yet, unfortunately.

Maybe consider this patch an RFC that illustrates at least part of the
problem. ;)

>=20
> > Reported-by: Zhi Li <yieli@redhat.com>
>=20
> Closes: ?
>=20

I don't have a separate bug for that just yet. This was found in a
backport from upstream of a large swath of sunrpc/nfsd/nfs patches. I'll
plan to open a linux-nfs.org bug before I re-post though.

>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > When using their test harness, the RHQA folks would sometimes see the
> > nfsv3 portmapper registration fail with -ERESTARTSYS, and that would
> > trigger this bug. I could never reproduce that easily on my own, but I
> > was able to validate this by hacking some fault injection into
> > svc_register.
> > ---
> >  fs/nfsd/nfsctl.c |  4 ++--
> >  fs/nfsd/nfsd.h   |  8 ++-----
> >  fs/nfsd/nfssvc.c | 72 ++++++++++++++++++++++++++++++++++++------------=
--------
> >  3 files changed, 51 insertions(+), 33 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 7ed02fb88a36..f8c0fed99c7f 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -706,7 +706,7 @@ static ssize_t __write_ports_addfd(char *buf, struc=
t net *net, const struct cred
> > =20
> >  	if (err >=3D 0 &&
> >  	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> > -		svc_get(nn->nfsd_serv);
> > +		nfsd_get(net);
> > =20
> >  	nfsd_put(net);
> >  	return err;
> > @@ -745,7 +745,7 @@ static ssize_t __write_ports_addxprt(char *buf, str=
uct net *net, const struct cr
> >  		goto out_close;
> > =20
> >  	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> > -		svc_get(nn->nfsd_serv);
> > +		nfsd_get(net);
> > =20
> >  	nfsd_put(net);
> >  	return 0;
> > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > index 11c14faa6c67..c9cb70bf2a6d 100644
> > --- a/fs/nfsd/nfsd.h
> > +++ b/fs/nfsd/nfsd.h
> > @@ -96,12 +96,8 @@ int		nfsd_pool_stats_open(struct inode *, struct fil=
e *);
> >  int		nfsd_pool_stats_release(struct inode *, struct file *);
> >  void		nfsd_shutdown_threads(struct net *net);
> > =20
> > -static inline void nfsd_put(struct net *net)
> > -{
> > -	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > -
> > -	svc_put(nn->nfsd_serv);
> > -}
> > +struct svc_serv	*nfsd_get(struct net *net);
> > +void		nfsd_put(struct net *net);
> > =20
> >  bool		i_am_nfsd(void);
> > =20
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index c7af1095f6b5..4c00478c28dd 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -66,7 +66,7 @@ static __be32			nfsd_init_request(struct svc_rqst *,
> >   * ->sv_pools[].
> >   *
> >   * Each active thread holds a counted reference on nn->nfsd_serv, as d=
oes
> > - * the nn->keep_active flag and various transient calls to svc_get().
> > + * the nn->keep_active flag and various transient calls to nfsd_get().
> >   *
> >   * Finally, the nfsd_mutex also protects some of the global variables =
that are
> >   * accessed when nfsd starts and that are settable via the write_* rou=
tines in
> > @@ -477,6 +477,39 @@ static void nfsd_shutdown_net(struct net *net)
> >  }
> > =20
> >  static DEFINE_SPINLOCK(nfsd_notifier_lock);
> > +
> > +struct svc_serv *nfsd_get(struct net *net)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +	struct svc_serv *serv =3D nn->nfsd_serv;
> > +
> > +	lockdep_assert_held(&nfsd_mutex);
> > +	if (serv)
> > +		svc_get(serv);
> > +	return serv;
> > +}
> > +
> > +void nfsd_put(struct net *net)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +	struct svc_serv *serv =3D nn->nfsd_serv;
> > +
> > +	/*
> > +	 * The notifiers expect that if the nfsd_serv pointer is
> > +	 * set that it's safe to access, so we must clear that
> > +	 * pointer first before putting the last reference. Because
> > +	 * we always increment and decrement the refcount under the
> > +	 * mutex, it's safe to determine this via kref_read.
> > +	 */
>=20
> These two need kdoc comments. You could move this big block into
> the kdoc comment for nfsd_put.
>=20
>=20
> > +	lockdep_assert_held(&nfsd_mutex);
> > +	if (kref_read(&serv->sv_refcnt) =3D=3D 1) {
> > +		spin_lock(&nfsd_notifier_lock);
> > +		nn->nfsd_serv =3D NULL;
> > +		spin_unlock(&nfsd_notifier_lock);
> > +	}
> > +	svc_put(serv);
> > +}
> > +
> >  static int nfsd_inetaddr_event(struct notifier_block *this, unsigned l=
ong event,
> >  	void *ptr)
> >  {
> > @@ -547,10 +580,6 @@ static void nfsd_last_thread(struct net *net)
> >  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> >  	struct svc_serv *serv =3D nn->nfsd_serv;
> > =20
> > -	spin_lock(&nfsd_notifier_lock);
> > -	nn->nfsd_serv =3D NULL;
> > -	spin_unlock(&nfsd_notifier_lock);
> > -
> >  	/* check if the notifier still has clients */
> >  	if (atomic_dec_return(&nfsd_notifier_refcount) =3D=3D 0) {
> >  		unregister_inetaddr_notifier(&nfsd_inetaddr_notifier);
> > @@ -638,21 +667,19 @@ static int nfsd_get_default_max_blksize(void)
> > =20
> >  void nfsd_shutdown_threads(struct net *net)
> >  {
> > -	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> >  	struct svc_serv *serv;
> > =20
> >  	mutex_lock(&nfsd_mutex);
> > -	serv =3D nn->nfsd_serv;
> > +	serv =3D nfsd_get(net);
> >  	if (serv =3D=3D NULL) {
> >  		mutex_unlock(&nfsd_mutex);
> >  		return;
> >  	}
> > =20
> > -	svc_get(serv);
> >  	/* Kill outstanding nfsd threads */
> >  	svc_set_num_threads(serv, NULL, 0);
> >  	nfsd_last_thread(net);
> > -	svc_put(serv);
> > +	nfsd_put(net);
> >  	mutex_unlock(&nfsd_mutex);
> >  }
> > =20
> > @@ -663,15 +690,13 @@ bool i_am_nfsd(void)
> > =20
> >  int nfsd_create_serv(struct net *net)
> >  {
> > -	int error;
> >  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> >  	struct svc_serv *serv;
> > +	int error;
> > =20
> > -	WARN_ON(!mutex_is_locked(&nfsd_mutex));
> > -	if (nn->nfsd_serv) {
> > -		svc_get(nn->nfsd_serv);
> > +	serv =3D nfsd_get(net);
> > +	if (serv)
> >  		return 0;
> > -	}
> >  	if (nfsd_max_blksize =3D=3D 0)
> >  		nfsd_max_blksize =3D nfsd_get_default_max_blksize();
> >  	nfsd_reset_versions(nn);
> > @@ -731,8 +756,6 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct=
 net *net)
> >  	int err =3D 0;
> >  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > =20
> > -	WARN_ON(!mutex_is_locked(&nfsd_mutex));
> > -
> >  	if (nn->nfsd_serv =3D=3D NULL || n <=3D 0)
> >  		return 0;
> > =20
> > @@ -766,7 +789,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct=
 net *net)
> >  		nthreads[0] =3D 1;
> > =20
> >  	/* apply the new numbers */
> > -	svc_get(nn->nfsd_serv);
> > +	nfsd_get(net);
> >  	for (i =3D 0; i < n; i++) {
> >  		err =3D svc_set_num_threads(nn->nfsd_serv,
> >  					  &nn->nfsd_serv->sv_pools[i],
> > @@ -774,7 +797,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct=
 net *net)
> >  		if (err)
> >  			break;
> >  	}
> > -	svc_put(nn->nfsd_serv);
> > +	nfsd_put(net);
> >  	return err;
> >  }
> > =20
> > @@ -826,8 +849,8 @@ nfsd_svc(int nrservs, struct net *net, const struct=
 cred *cred)
> >  out_put:
> >  	/* Threads now hold service active */
> >  	if (xchg(&nn->keep_active, 0))
> > -		svc_put(serv);
> > -	svc_put(serv);
> > +		nfsd_put(net);
> > +	nfsd_put(net);
> >  out:
> >  	mutex_unlock(&nfsd_mutex);
> >  	return error;
> > @@ -1067,14 +1090,14 @@ bool nfssvc_encode_voidres(struct svc_rqst *rqs=
tp, struct xdr_stream *xdr)
> >  int nfsd_pool_stats_open(struct inode *inode, struct file *file)
> >  {
> >  	int ret;
> > +	struct net *net =3D inode->i_sb->s_fs_info;
> >  	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_=
id);
> > =20
> >  	mutex_lock(&nfsd_mutex);
> > -	if (nn->nfsd_serv =3D=3D NULL) {
> > +	if (nfsd_get(net) =3D=3D NULL) {
> >  		mutex_unlock(&nfsd_mutex);
> >  		return -ENODEV;
> >  	}
> > -	svc_get(nn->nfsd_serv);
> >  	ret =3D svc_pool_stats_open(nn->nfsd_serv, file);
> >  	mutex_unlock(&nfsd_mutex);
> >  	return ret;
> > @@ -1082,12 +1105,11 @@ int nfsd_pool_stats_open(struct inode *inode, s=
truct file *file)
> > =20
> >  int nfsd_pool_stats_release(struct inode *inode, struct file *file)
> >  {
> > -	struct seq_file *seq =3D file->private_data;
> > -	struct svc_serv *serv =3D seq->private;
> > +	struct net *net =3D inode->i_sb->s_fs_info;
> >  	int ret =3D seq_release(inode, file);
> > =20
> >  	mutex_lock(&nfsd_mutex);
> > -	svc_put(serv);
> > +	nfsd_put(net);
> >  	mutex_unlock(&nfsd_mutex);
> >  	return ret;
> >  }
> >=20
> > ---
> > base-commit: 80eea12811ab8b32e3eac355adff695df5b4ba8e
> > change-id: 20231026-kdevops-3c18d260bf7c
> >=20
> > Best regards,
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
