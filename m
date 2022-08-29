Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6658C5A5403
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 20:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiH2SkT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 14:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2SkR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 14:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8045C6B15C
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 11:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B622561215
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 18:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B95D2C433D6;
        Mon, 29 Aug 2022 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661798415;
        bh=hEHpd+0PdPV6UWXP5j+mdinxoD2kOVu/f8WmUETk0qg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SKqzALuWYDcTWFPA2NrhMwgEt6+SoYb4dsCmPRokXLBvIWXKTZgIdoYzxpGvpcGyU
         jr/E7eaxEMuhL66Uv9jZulOMm7z5RhPDVebXUPpcGm+MMLCiRlTLDGwrTLuQb/Xt7M
         rffnXohqOUIPh9zYqHeXqVqFo0CyrUceLhhBtYYdII317WgwrJu/yL3bQlXYIwHQAm
         K4vndeR9HYL1KZm7fDAUyuyrGLX7iMDH5gOkMeKxXvQ+k+dKymBlycjlgunuwBMDG2
         OaSZdTcFIqfCj6XZOXdmFDPKpz5kFdbpWjqsUv8rr3PHenaqvy6BVFns37PTOCYhM0
         gMv8C8Jq9Zn2Q==
Message-ID: <b038317d230490bf79466ee74fb837e37e5ca25c.camel@kernel.org>
Subject: Re: [PATCH v2 2/2] NFSD: add shrinker to reap courtesy clients on
 low memory condition
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 29 Aug 2022 14:40:13 -0400
In-Reply-To: <94838eff-af62-8ed4-05cf-10a9cec6a473@oracle.com>
References: <1661734063-22023-1-git-send-email-dai.ngo@oracle.com>
         <1661734063-22023-3-git-send-email-dai.ngo@oracle.com>
         <b12994817cda7d9509767182edb1b1f21697648a.camel@kernel.org>
         <94838eff-af62-8ed4-05cf-10a9cec6a473@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-08-29 at 11:25 -0700, dai.ngo@oracle.com wrote:
> On 8/29/22 10:15 AM, Jeff Layton wrote:
> > On Sun, 2022-08-28 at 17:47 -0700, Dai Ngo wrote:
> > > Add the courtesy client shrinker to react to low memory condition
> > > triggered by the memory shrinker.
> > >=20
> > > On the shrinker's count callback, we increment a callback counter
> > > and return the number of outstanding courtesy clients. When the
> > > laundromat runs, it checks if this counter is not zero and starts
> > > reaping old courtesy clients. The maximum number of clients to be
> > > reaped is limited to NFSD_CIENT_MAX_TRIM_PER_RUN (128). This limit
> > > is to prevent the laundromat from spending too much time reaping
> > > the clients and not processing other tasks in a timely manner.
> > >=20
> > > The laundromat is rescheduled to run sooner if it detects low
> > > low memory condition and there are more clients to reap.
> > >=20
> > > On the shrinker's scan callback, we return the number of clients
> > > That were reaped since the last scan callback. We can not reap
> > > the clients on the scan callback context since destroying the
> > > client might require call into the underlying filesystem or other
> > > subsystems which might allocate memory which can cause deadlock.
> > >=20
> > > Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> > > ---
> > >   fs/nfsd/netns.h     |  3 +++
> > >   fs/nfsd/nfs4state.c | 51 ++++++++++++++++++++++++++++++++++++++++++=
+++++----
> > >   fs/nfsd/nfsctl.c    |  6 ++++--
> > >   fs/nfsd/nfsd.h      |  9 +++++++--
> > >   4 files changed, 61 insertions(+), 8 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> > > index 2695dff1378a..2a604951623f 100644
> > > --- a/fs/nfsd/netns.h
> > > +++ b/fs/nfsd/netns.h
> > > @@ -194,6 +194,9 @@ struct nfsd_net {
> > >   	int			nfs4_max_clients;
> > >  =20
> > >   	atomic_t		nfsd_courtesy_client_count;
> > > +	atomic_t		nfsd_client_shrinker_cb_count;
> > > +	atomic_t		nfsd_client_shrinker_reapcount;
> > > +	struct shrinker		nfsd_client_shrinker;
> > >   };
> > >  =20
> > >   /* Simple check to find out if a given net was properly initialized=
 */
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 3d8d7ebb5b91..9d5a20f0c3c4 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -4341,7 +4341,39 @@ nfsd4_init_slabs(void)
> > >   	return -ENOMEM;
> > >   }
> > >  =20
> > > -void nfsd4_init_leases_net(struct nfsd_net *nn)
> > > +static unsigned long
> > > +nfsd_courtesy_client_count(struct shrinker *shrink, struct shrink_co=
ntrol *sc)
> > > +{
> > > +	struct nfsd_net *nn =3D container_of(shrink,
> > > +			struct nfsd_net, nfsd_client_shrinker);
> > > +
> > > +	atomic_inc(&nn->nfsd_client_shrinker_cb_count);
> > > +	return (unsigned long)atomic_read(&nn->nfsd_courtesy_client_count);
> > > +}
> > > +
> > > +static unsigned long
> > > +nfsd_courtesy_client_scan(struct shrinker *shrink, struct shrink_con=
trol *sc)
> > > +{
> > > +	struct nfsd_net *nn =3D container_of(shrink,
> > > +			struct nfsd_net, nfsd_client_shrinker);
> > > +	unsigned long cnt;
> > > +
> > > +	cnt =3D atomic_read(&nn->nfsd_client_shrinker_reapcount);
> > > +	atomic_set(&nn->nfsd_client_shrinker_reapcount, 0);
> > Is it legit to return that we freed these objects when it hasn't
> > actually been done yet? Maybe this should always return 0? I'm not sure
> > what the rules are with shrinkers.
>=20
> nfsd_client_shrinker_reapcount is the actual number of clients that
> the laudromat was able to destroy in its last run.
>=20
> >=20
> > Either way, it seems like "scan" should cue the laundromat to run ASAP.
> > When this is called, it may be quite some time before the laundromat
> > runs again. Currently, it's always just scheduled it out to when we kno=
w
> > there may be work to be done, but this is a different situation.
>=20
> Normally the "scan" callback is used to free unused resources and return
> the number of objects freed. For the NFSv4 clients, we can not free the
> clients on the "scan" context due to potential deadlock and also the
> laundromat might block while destroying the clients. Because of this we
> use the "count" callback to notify the laundromat of the low memory
> condition.
>=20
> In the "count" callback we do not call mod_delayed_work to kick start
> the laundromat since we do not want to rely on the inner working
> mod_delayed_work to guarantee no deadlock. I also think we should do
> the minimal while on the memory shrinker's callback context.
>=20

Are you aware of a specific problem with shrinkers and queueing work?

As I understand it, shrinkers are run in the context of an allocation.
An allocation crosses a threshold of some sort and and we start trying
to free stuff using shrinkers. queueing delayed work will never allocate
anything, so I would think it'd be safe to do in the count callback.

> Once the laundromat runs it monitors the low memory condition and
> reschedules itself to run immediately (NFSD_LAUNDROMAT_MINTIMEOUT) if
> needed.
>=20
> Thanks,
> -Dai
>=20
> >=20
> > > +	return cnt;
> > > +}
> > > +
> > > +static int
> > > +nfsd_register_client_shrinker(struct nfsd_net *nn)
> > > +{
> > > +	nn->nfsd_client_shrinker.scan_objects =3D nfsd_courtesy_client_scan=
;
> > > +	nn->nfsd_client_shrinker.count_objects =3D nfsd_courtesy_client_cou=
nt;
> > > +	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> > > +	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> > > +}
> > > +
> > > +int
> > > +nfsd4_init_leases_net(struct nfsd_net *nn)
> > >   {
> > >   	struct sysinfo si;
> > >   	u64 max_clients;
> > > @@ -4362,6 +4394,8 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
> > >   	nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_=
GB);
> > >  =20
> > >   	atomic_set(&nn->nfsd_courtesy_client_count, 0);
> > > +	atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
> > > +	return nfsd_register_client_shrinker(nn);
> > >   }
> > >  =20
> > >   static void init_nfs4_replay(struct nfs4_replay *rp)
> > > @@ -5870,12 +5904,17 @@ static void
> > >   nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *rea=
plist,
> > >   				struct laundry_time *lt)
> > >   {
> > > -	unsigned int oldstate, maxreap, reapcnt =3D 0;
> > > +	unsigned int oldstate, maxreap =3D 0, reapcnt =3D 0;
> > > +	int cb_cnt;
> > >   	struct list_head *pos, *next;
> > >   	struct nfs4_client *clp;
> > >  =20
> > > -	maxreap =3D (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_=
clients) ?
> > > -			NFSD_CLIENT_MAX_TRIM_PER_RUN : 0;
> > > +	cb_cnt =3D atomic_read(&nn->nfsd_client_shrinker_cb_count);
> > > +	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients |=
|
> > > +							cb_cnt) {
> > > +		maxreap =3D NFSD_CLIENT_MAX_TRIM_PER_RUN;
> > > +		atomic_set(&nn->nfsd_client_shrinker_cb_count, 0);
> > > +	}
> > >   	INIT_LIST_HEAD(reaplist);
> > >   	spin_lock(&nn->client_lock);
> > >   	list_for_each_safe(pos, next, &nn->client_lru) {
> > > @@ -5902,6 +5941,8 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, s=
truct list_head *reaplist,
> > >   		}
> > >   	}
> > >   	spin_unlock(&nn->client_lock);
> > > +	if (cb_cnt)
> > > +		atomic_add(reapcnt, &nn->nfsd_client_shrinker_reapcount);
> > >   }
> > >  =20
> > >   static time64_t
> > > @@ -5942,6 +5983,8 @@ nfs4_laundromat(struct nfsd_net *nn)
> > >   		list_del_init(&clp->cl_lru);
> > >   		expire_client(clp);
> > >   	}
> > > +	if (atomic_read(&nn->nfsd_client_shrinker_cb_count) > 0)
> > > +		lt.new_timeo =3D NFSD_LAUNDROMAT_MINTIMEOUT;
> > >   	spin_lock(&state_lock);
> > >   	list_for_each_safe(pos, next, &nn->del_recall_lru) {
> > >   		dp =3D list_entry (pos, struct nfs4_delegation, dl_recall_lru);
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 917fa1892fd2..597a26ad4183 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -1481,11 +1481,12 @@ static __net_init int nfsd_init_net(struct ne=
t *net)
> > >   		goto out_idmap_error;
> > >   	nn->nfsd_versions =3D NULL;
> > >   	nn->nfsd4_minorversions =3D NULL;
> > > +	retval =3D nfsd4_init_leases_net(nn);
> > > +	if (retval)
> > > +		goto out_drc_error;
> > >   	retval =3D nfsd_reply_cache_init(nn);
> > >   	if (retval)
> > >   		goto out_drc_error;
> > > -	nfsd4_init_leases_net(nn);
> > > -
> > >   	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
> > >   	seqlock_init(&nn->writeverf_lock);
> > >  =20
> > > @@ -1507,6 +1508,7 @@ static __net_exit void nfsd_exit_net(struct net=
 *net)
> > >   	nfsd_idmap_shutdown(net);
> > >   	nfsd_export_shutdown(net);
> > >   	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
> > > +	nfsd4_leases_net_shutdown(nn);
> > >   }
> > >  =20
> > >   static struct pernet_operations nfsd_net_ops =3D {
> > > diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> > > index 57a468ed85c3..7e05ab7a3532 100644
> > > --- a/fs/nfsd/nfsd.h
> > > +++ b/fs/nfsd/nfsd.h
> > > @@ -498,7 +498,11 @@ extern void unregister_cld_notifier(void);
> > >   extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
> > >   #endif
> > >  =20
> > > -extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> > > +extern int nfsd4_init_leases_net(struct nfsd_net *nn);
> > > +static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn)
> > > +{
> > > +	unregister_shrinker(&nn->nfsd_client_shrinker);
> > > +};
> > >  =20
> > >   #else /* CONFIG_NFSD_V4 */
> > >   static inline int nfsd4_is_junction(struct dentry *dentry)
> > > @@ -506,7 +510,8 @@ static inline int nfsd4_is_junction(struct dentry=
 *dentry)
> > >   	return 0;
> > >   }
> > >  =20
> > > -static inline void nfsd4_init_leases_net(struct nfsd_net *nn) {};
> > > +static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { retur=
n 0; };
> > > +static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) { =
};
> > >  =20
> > >   #define register_cld_notifier() 0
> > >   #define unregister_cld_notifier() do { } while(0)

--=20
Jeff Layton <jlayton@kernel.org>
