Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CF2460B3B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Nov 2021 00:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359594AbhK1Xlx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 28 Nov 2021 18:41:53 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35806 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbhK1Xjt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 28 Nov 2021 18:39:49 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 44B9F1FD33;
        Sun, 28 Nov 2021 23:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638142592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KU9RDamVMC/XpHJZo5l6YA0/YLhqfBqaJeDOCiRSK3I=;
        b=VhYn8XIA2jX5wzPTwxPtznqxAkWvQXfX5C8gPQclaX4AJFtOKKERwM4z7n8f2lgASv0qVP
        zz83vtHiDLYmthT6zKfxFDjFwpx1mlR1YhOwSp/fkTymT1cJzq8deB09kpEuZ6p/6X+Q84
        pe7v0t6tzQWMHUeZD6GLDEwdP8dF0G8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638142592;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KU9RDamVMC/XpHJZo5l6YA0/YLhqfBqaJeDOCiRSK3I=;
        b=L0x9fdPUurh4ZBKOlzfwIQNBTXyrBTyiJSksh5GHu1Qs91d/wb4+73pJdDBU/aJQwQZul7
        tPS2bgVueuSrtLBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23DC9133A7;
        Sun, 28 Nov 2021 23:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jvpbNH4SpGEsHgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 28 Nov 2021 23:36:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Bruce Fields" <bfields@fieldses.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 01/19] SUNRPC/NFSD: clean up get/put functions.
In-reply-to: <92C7D2FA-6C7B-4209-B1B4-3B81B2B276F4@oracle.com>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>,
 <163763097540.7284.6343105121634986097.stgit@noble.brown>,
 <92C7D2FA-6C7B-4209-B1B4-3B81B2B276F4@oracle.com>
Date:   Mon, 29 Nov 2021 10:36:27 +1100
Message-id: <163814258705.26075.4680313747300849381@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 24 Nov 2021, Chuck Lever III wrote:
> > diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> > index b220e1b91726..135bd86ed3ad 100644
> > --- a/fs/lockd/svc.c
> > +++ b/fs/lockd/svc.c
> > @@ -430,14 +430,8 @@ static struct svc_serv *lockd_create_svc(void)
> > 	/*
> > 	 * Check whether we're already up and running.
> > 	 */
> > -	if (nlmsvc_rqst) {
> > -		/*
> > -		 * Note: increase service usage, because later in case of error
> > -		 * svc_destroy() will be called.
> > -		 */
> > -		svc_get(nlmsvc_rqst->rq_server);
> > -		return nlmsvc_rqst->rq_server;
> > -	}
> > +	if (nlmsvc_rqst)
> > +		return svc_get(nlmsvc_rqst->rq_server);
>=20
> The svc_get-related changes seem like they could be split
> into a separate clean-up patch.

I guess so.

> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index af8531c3854a..5eb564e58a9b 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -743,7 +743,7 @@ static ssize_t __write_ports_addfd(char *buf, struct =
net *net, const struct cred
> >=20
> > 	err =3D svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT, cr=
ed);
> > 	if (err < 0) {
> > -		nfsd_destroy(net);
> > +		nfsd_put(net);
>=20
> Seems like there should be a matching nfsd_get() somewhere.
> Perhaps it can just be an alias for svc_get()?

What purpose would that serve? I really don't like having simple aliases
- they seem to hide information.
In particular, I really don't like reading code, seeing some interface
that I haven't seen before, hunting it out to find out what it means,
and discovering that is just a wrapper around something that I already
know.   Why should I have to learn 2 interfaces when 1 would suffice?

So I am not inclined to a nfsd_get().

> > -void nfsd_destroy(struct net *net)
> > +void nfsd_put(struct net *net)
> > {
> > 	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > -	int destroy =3D (nn->nfsd_serv->sv_nrthreads =3D=3D 1);
> >=20
> > -	if (destroy)
> > +	nn->nfsd_serv->sv_nrthreads --;
>=20
> checkpatch.pl screamed about the whitespace between the variable
> and the unary operator here and in svc_put().

I've changed it to ".... -=3D 1;", which I generally prefer anyway.
But it'll probably become "if atomic_dec_and_test()" in a later patch.

> > +/**
> > + * svc_put - decrement reference count on a SUNRPC serv
> > + * @serv:  the svc_serv to have count decremented
> > + *
> > + * When the reference count reaches zero, svc_destroy()
> > + * is called to clean up and free the serv.
> > + */
> > +static inline void svc_put(struct svc_serv *serv)
> > +{
> > +	serv->sv_nrthreads --;
> > +	if (serv->sv_nrthreads =3D=3D 0)
>=20
> Nit: The usual idiom is "if (--serv->sv_nrthreads =3D=3D 0)"

Is it? I thought that changing variables in if() conditions was
generally discouraged (though it is OK in while()).

So I'll leave it as it is (well... -=3D 1 ..) until it become atomic_t.

> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 4292278a9552..55a1bf0d129f 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -528,17 +528,7 @@ EXPORT_SYMBOL_GPL(svc_shutdown_net);
> > void
> > svc_destroy(struct svc_serv *serv)
> > {
> > -	dprintk("svc: svc_destroy(%s, %d)\n",
> > -				serv->sv_program->pg_name,
> > -				serv->sv_nrthreads);
> > -
> > -	if (serv->sv_nrthreads) {
> > -		if (--(serv->sv_nrthreads) !=3D 0) {
> > -			svc_sock_update_bufs(serv);
> > -			return;
> > -		}
> > -	} else
> > -		printk("svc_destroy: no threads for serv=3D%p!\n", serv);
> > +	dprintk("svc: svc_destroy(%s)\n", serv->sv_program->pg_name);
>=20
> Maybe the dprintk is unnecessary. I would prefer a trace
> point if there is real value in observing destruction of
> particular svc_serv objects.
>=20
> Likewise in subsequent patches.
>=20
> Also... since we're in the clean-up frame of mind, if you
> see a BUG() call site remaining in a hunk, ask yourself
> if we really need to kill the kernel at that point, or
> if a WARN would suffice.

cleanup of BUGs (and dprinkts) is, for me, a different frame of mind
that the cleanup I currently working on.  I'd rather not get distracted.


>=20
> > 	del_timer_sync(&serv->sv_temptimer);
> >=20
> > @@ -892,9 +882,10 @@ svc_exit_thread(struct svc_rqst *rqstp)
> >=20
> > 	svc_rqst_free(rqstp);
> >=20
> > -	/* Release the server */
> > -	if (serv)
> > -		svc_destroy(serv);
> > +	if (!serv)
> > +		return;
> > +	svc_sock_update_bufs(serv);
>=20
> I don't object to moving the svc_sock_update_bufs() call
> site. But....
>=20
> Note for someday: I'm not sure of a better way of handling
> buffer size changes, but this seems like all kinds layering
> violation.

Despite the name, this function doesn't update any bufs.  It just sets
some flags.
Maybe we should have a sequential "version" number in the svc_serv which
is updated when the number of threads changes.  And each svc_sock holds
a copy of this.  If it notices the svc_serv has changed version, it
reassesses its buffer space.

Thanks,
NeilBrown
