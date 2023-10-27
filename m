Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6A77DA35C
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Oct 2023 00:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjJ0WXb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Oct 2023 18:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjJ0WXa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Oct 2023 18:23:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C55B1A5;
        Fri, 27 Oct 2023 15:23:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0F2331FEF4;
        Fri, 27 Oct 2023 22:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698445406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbyuAI8nWTQaFyKEs2hMMCmDe8XjY6AQ2mGWmMDjEsA=;
        b=ZBFmCKN8uR+Sf0t3PwU0QNWLICKcMHTv9x6zafFrToso/kd7NaEsF+39/j4bJbzxEwYLhu
        A5jb3zEvFKbuAuteSkEZMJW3uPwWGIbRihq50grokLzc/Arvu4XXbWjOH6LtD3aujuJYMe
        M1URGcPUPDC8GwnBTS2V+lQlpaAD1t4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698445406;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IbyuAI8nWTQaFyKEs2hMMCmDe8XjY6AQ2mGWmMDjEsA=;
        b=Tp3YiueaztvEvf21Wb5QXtA8pZOfZ57XaQqgy17IOS1tcM8kgm36Q5gKVzvIzDNRjqNFD+
        LjSIp0yY2nPlX8DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3BEE1358C;
        Fri, 27 Oct 2023 22:23:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v0AoJVo4PGV1PAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Oct 2023 22:23:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Chuck Lever" <chuck.lever@oracle.com>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Zhi Li" <yieli@redhat.com>, "Jeff Layton" <jlayton@kernel.org>
Subject: Re: [PATCH] nfsd: ensure the nfsd_serv pointer is cleared when svc is
 torn down
In-reply-to: <20231027-kdevops-v1-1-73711c16186c@kernel.org>
References: <20231027-kdevops-v1-1-73711c16186c@kernel.org>
Date:   Sat, 28 Oct 2023 09:23:19 +1100
Message-id: <169844539954.20306.1375894928598489617@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 27 Oct 2023, Jeff Layton wrote:
> Zhi Li reported a refcount_t use-after-free when bringing up nfsd.
>=20
> We set the nn->nfsd_serv pointer in nfsd_create_serv, but it's only ever
> cleared in nfsd_last_thread. When setting up a new socket, if there is
> an error, this can leave nfsd_serv pointer set after it has been freed.
> We need to better couple the existence of the object with the value of
> the nfsd_serv pointer.
>=20
> Since we always increment and decrement the svc_serv references under
> mutex, just test for whether the next put will destroy it in nfsd_put,
> and clear the pointer beforehand if so. Add a new nfsd_get function for
> better clarity and so that we can enforce that the mutex is held via
> lockdep. Remove the clearing of the pointer from nfsd_last_thread.
> Finally, change all of the svc_get and svc_put calls to use the updated
> wrappers.
>=20
> Reported-by: Zhi Li <yieli@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> When using their test harness, the RHQA folks would sometimes see the
> nfsv3 portmapper registration fail with -ERESTARTSYS, and that would
> trigger this bug. I could never reproduce that easily on my own, but I
> was able to validate this by hacking some fault injection into
> svc_register.

Maybe you could share that fault-injection with us?

> ---
>  fs/nfsd/nfsctl.c |  4 ++--
>  fs/nfsd/nfsd.h   |  8 ++-----
>  fs/nfsd/nfssvc.c | 72 ++++++++++++++++++++++++++++++++++++----------------=
----
>  3 files changed, 51 insertions(+), 33 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 7ed02fb88a36..f8c0fed99c7f 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -706,7 +706,7 @@ static ssize_t __write_ports_addfd(char *buf, struct ne=
t *net, const struct cred
> =20
>  	if (err >=3D 0 &&
>  	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> -		svc_get(nn->nfsd_serv);
> +		nfsd_get(net);
> =20
>  	nfsd_put(net);
>  	return err;
> @@ -745,7 +745,7 @@ static ssize_t __write_ports_addxprt(char *buf, struct =
net *net, const struct cr
>  		goto out_close;
> =20
>  	if (!nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> -		svc_get(nn->nfsd_serv);
> +		nfsd_get(net);
> =20
>  	nfsd_put(net);
>  	return 0;
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 11c14faa6c67..c9cb70bf2a6d 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -96,12 +96,8 @@ int		nfsd_pool_stats_open(struct inode *, struct file *);
>  int		nfsd_pool_stats_release(struct inode *, struct file *);
>  void		nfsd_shutdown_threads(struct net *net);
> =20
> -static inline void nfsd_put(struct net *net)
> -{
> -	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> -
> -	svc_put(nn->nfsd_serv);
> -}
> +struct svc_serv	*nfsd_get(struct net *net);
> +void		nfsd_put(struct net *net);
> =20
>  bool		i_am_nfsd(void);
> =20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index c7af1095f6b5..4c00478c28dd 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -66,7 +66,7 @@ static __be32			nfsd_init_request(struct svc_rqst *,
>   * ->sv_pools[].
>   *
>   * Each active thread holds a counted reference on nn->nfsd_serv, as does
> - * the nn->keep_active flag and various transient calls to svc_get().
> + * the nn->keep_active flag and various transient calls to nfsd_get().
>   *
>   * Finally, the nfsd_mutex also protects some of the global variables that=
 are
>   * accessed when nfsd starts and that are settable via the write_* routine=
s in
> @@ -477,6 +477,39 @@ static void nfsd_shutdown_net(struct net *net)
>  }
> =20
>  static DEFINE_SPINLOCK(nfsd_notifier_lock);
> +
> +struct svc_serv *nfsd_get(struct net *net)
> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct svc_serv *serv =3D nn->nfsd_serv;
> +
> +	lockdep_assert_held(&nfsd_mutex);
> +	if (serv)
> +		svc_get(serv);
> +	return serv;
> +}

As far as I can tell, the addition of nfsd_get() is pure noise here.
Maybe it is a useful abstraction to add, but it makes the patch so noisy
that I cannot see where the actual fix is.

> +
> +void nfsd_put(struct net *net)
> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +	struct svc_serv *serv =3D nn->nfsd_serv;
> +
> +	/*
> +	 * The notifiers expect that if the nfsd_serv pointer is
> +	 * set that it's safe to access, so we must clear that
> +	 * pointer first before putting the last reference. Because
> +	 * we always increment and decrement the refcount under the
> +	 * mutex, it's safe to determine this via kref_read.
> +	 */
> +	lockdep_assert_held(&nfsd_mutex);
> +	if (kref_read(&serv->sv_refcnt) =3D=3D 1) {

This is horrible.  Using kref_read() is OK for debug messages, but
almost always wrong anywhere else.
In this case it is actually safe but only because the use of kref has
become pointless.  We now ONLY change sv_refcnt while holding a mutex so
we may as well make it a simple integer (which I'd been thinking of
doing, but hadn't got to yet).  So this isn't wrong, but it looks wrong.

Also I think we should only have one place where we special-case
sv_refcnt going from 1 to 0.  nfsd_last_thread() must be called at that
time.  So if we are going to have nfsd_put() like this, it should be
calling nfsd_last_thread().

I'm certainly open to the possibility that these are still bugs here.  I
don't think patch helps me be confident that there are fewer.  Sorry.

NeilBrown



> +		spin_lock(&nfsd_notifier_lock);
> +		nn->nfsd_serv =3D NULL;
> +		spin_unlock(&nfsd_notifier_lock);
> +	}
> +	svc_put(serv);
> +}
> +
>  static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long =
event,
>  	void *ptr)
>  {
> @@ -547,10 +580,6 @@ static void nfsd_last_thread(struct net *net)
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv =3D nn->nfsd_serv;
> =20
> -	spin_lock(&nfsd_notifier_lock);
> -	nn->nfsd_serv =3D NULL;
> -	spin_unlock(&nfsd_notifier_lock);
> -
>  	/* check if the notifier still has clients */
>  	if (atomic_dec_return(&nfsd_notifier_refcount) =3D=3D 0) {
>  		unregister_inetaddr_notifier(&nfsd_inetaddr_notifier);
> @@ -638,21 +667,19 @@ static int nfsd_get_default_max_blksize(void)
> =20
>  void nfsd_shutdown_threads(struct net *net)
>  {
> -	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv;
> =20
>  	mutex_lock(&nfsd_mutex);
> -	serv =3D nn->nfsd_serv;
> +	serv =3D nfsd_get(net);
>  	if (serv =3D=3D NULL) {
>  		mutex_unlock(&nfsd_mutex);
>  		return;
>  	}
> =20
> -	svc_get(serv);
>  	/* Kill outstanding nfsd threads */
>  	svc_set_num_threads(serv, NULL, 0);
>  	nfsd_last_thread(net);
> -	svc_put(serv);
> +	nfsd_put(net);
>  	mutex_unlock(&nfsd_mutex);
>  }
> =20
> @@ -663,15 +690,13 @@ bool i_am_nfsd(void)
> =20
>  int nfsd_create_serv(struct net *net)
>  {
> -	int error;
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv;
> +	int error;
> =20
> -	WARN_ON(!mutex_is_locked(&nfsd_mutex));
> -	if (nn->nfsd_serv) {
> -		svc_get(nn->nfsd_serv);
> +	serv =3D nfsd_get(net);
> +	if (serv)
>  		return 0;
> -	}
>  	if (nfsd_max_blksize =3D=3D 0)
>  		nfsd_max_blksize =3D nfsd_get_default_max_blksize();
>  	nfsd_reset_versions(nn);
> @@ -731,8 +756,6 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net=
 *net)
>  	int err =3D 0;
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
> -	WARN_ON(!mutex_is_locked(&nfsd_mutex));
> -
>  	if (nn->nfsd_serv =3D=3D NULL || n <=3D 0)
>  		return 0;
> =20
> @@ -766,7 +789,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net=
 *net)
>  		nthreads[0] =3D 1;
> =20
>  	/* apply the new numbers */
> -	svc_get(nn->nfsd_serv);
> +	nfsd_get(net);
>  	for (i =3D 0; i < n; i++) {
>  		err =3D svc_set_num_threads(nn->nfsd_serv,
>  					  &nn->nfsd_serv->sv_pools[i],
> @@ -774,7 +797,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct net=
 *net)
>  		if (err)
>  			break;
>  	}
> -	svc_put(nn->nfsd_serv);
> +	nfsd_put(net);
>  	return err;
>  }
> =20
> @@ -826,8 +849,8 @@ nfsd_svc(int nrservs, struct net *net, const struct cre=
d *cred)
>  out_put:
>  	/* Threads now hold service active */
>  	if (xchg(&nn->keep_active, 0))
> -		svc_put(serv);
> -	svc_put(serv);
> +		nfsd_put(net);
> +	nfsd_put(net);
>  out:
>  	mutex_unlock(&nfsd_mutex);
>  	return error;
> @@ -1067,14 +1090,14 @@ bool nfssvc_encode_voidres(struct svc_rqst *rqstp, =
struct xdr_stream *xdr)
>  int nfsd_pool_stats_open(struct inode *inode, struct file *file)
>  {
>  	int ret;
> +	struct net *net =3D inode->i_sb->s_fs_info;
>  	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
> =20
>  	mutex_lock(&nfsd_mutex);
> -	if (nn->nfsd_serv =3D=3D NULL) {
> +	if (nfsd_get(net) =3D=3D NULL) {
>  		mutex_unlock(&nfsd_mutex);
>  		return -ENODEV;
>  	}
> -	svc_get(nn->nfsd_serv);
>  	ret =3D svc_pool_stats_open(nn->nfsd_serv, file);
>  	mutex_unlock(&nfsd_mutex);
>  	return ret;
> @@ -1082,12 +1105,11 @@ int nfsd_pool_stats_open(struct inode *inode, struc=
t file *file)
> =20
>  int nfsd_pool_stats_release(struct inode *inode, struct file *file)
>  {
> -	struct seq_file *seq =3D file->private_data;
> -	struct svc_serv *serv =3D seq->private;
> +	struct net *net =3D inode->i_sb->s_fs_info;
>  	int ret =3D seq_release(inode, file);
> =20
>  	mutex_lock(&nfsd_mutex);
> -	svc_put(serv);
> +	nfsd_put(net);
>  	mutex_unlock(&nfsd_mutex);
>  	return ret;
>  }
>=20
> ---
> base-commit: 80eea12811ab8b32e3eac355adff695df5b4ba8e
> change-id: 20231026-kdevops-3c18d260bf7c
>=20
> Best regards,
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20

