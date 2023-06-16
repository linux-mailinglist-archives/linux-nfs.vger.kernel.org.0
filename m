Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F84733B31
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Jun 2023 22:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjFPUyO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 16 Jun 2023 16:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjFPUyM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 16 Jun 2023 16:54:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A533AA4;
        Fri, 16 Jun 2023 13:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F285161CBD;
        Fri, 16 Jun 2023 20:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76881C433C8;
        Fri, 16 Jun 2023 20:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686948846;
        bh=NrAobrTe3AneDvWlvrBYB/0D3DWtkcZgIcza4DyN11I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Uw0rdLJlzgaDorNeC1joVMvK3Quuju9NPy/vk9na7o27eSB0uNif2cf42pT3ocxVx
         vYgomJui68c3Mcr7ItRmTC2uZr9MNGjOprPvP72z0/wMA87oQIGoeYP0VN+oyfnXDk
         d6fDVNN1ikKUcx+/aM2Y+0xYRriOlkff17Qt0s+0vMx0aF/EApSNQ25ojt2EMsSRA8
         APwQ5SMt98sQuhgWSxyh+FejOevWQoiF9ZGaW5tOruArSFzkKL4I7JXCsnGNRC780H
         N9P8W0yf4B4Kek104S4RCj3Pz2a+ui2R8u+bHP/ChiGI7p+RIf262pqNbEZduroMY7
         xunXRjQjB/TLA==
Message-ID: <4b5063eb5a1139adc9dd4bdadde30674faee0700.camel@kernel.org>
Subject: Re: [PATCH] nfsd: move init of percpu reply_cache_stats counters
 back to nfsd_init_net
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        stable@vger.kernel.org, Eirik Fuller <efuller@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Jun 2023 16:54:04 -0400
In-Reply-To: <ZIzFp3ViiU2SCi6J@manet.1015granger.net>
References: <20230616191744.202292-1-jlayton@kernel.org>
         <ZIzFp3ViiU2SCi6J@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2023-06-16 at 16:27 -0400, Chuck Lever wrote:
> Thanks Eirik and Jeff.
>=20
> At this point in the release cycle, I plan to apply this for the
> next merge window (6.5).
>=20

I think we should take this in sooner. This is a regression and a
user-triggerable oops in the right situation. If:

- non-x86_64 arch
- /proc/fs/nfsd is mounted in the namespace
- nfsd is not started in the namespace
- unprivileged user calls "cat /proc/fs/nfsd/reply_cache_stats"

> A few cosmetic remarks below. I can take this as-is and make
> adjustments, or you can redrive. Just let me know.
>=20
>=20

I'll plan to redrive it.

> On Fri, Jun 16, 2023 at 03:17:43PM -0400, Jeff Layton wrote:
> > f5f9d4a314da moved the initialization of the reply cache into the nfsd
> > startup, but it didn't account for the stats counters which can be
> > accessed before nfsd is ever started, causing a NULL pointer
> > dereference.
> >=20
> > This is easy to trigger on some arches (like aarch64), but on x86_64,
> > calling this_cpu_ptr(NULL) evidently returns a pointer to the
> > fixed_percpu_data, which I guess this looks just enough like a newly
> > initialized percpu var to allow nfsd_reply_cache_stats_show to access i=
t
> > without Oopsing.
> >=20
> > Move the initialization of the per-net+per-cpu reply-cache counters bac=
k
> > into nfsd_init_net, while leaving the rest of the reply cache
> > allocations to be done at nfsd startup time.
> >=20
> > Kudos to Eirik who did most of the legwork to track this down.
> >=20
> > Cc: stable@vger.kernel.org # v6.3+
> > Fixes: f5f9d4a314da ("nfsd: move reply cache initialization into nfsd s=
tartup")
>=20
> Why both Fixes: and Cc: stable?
>=20
>=20

*shrug* : they mean different things. I can drop the Cc stable.

> > Reported-and-Tested-by: Eirik Fuller <efuller@redhat.com>
>=20
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2215429  ?
>=20
>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/cache.h    |  2 ++
> >  fs/nfsd/nfscache.c | 13 +++----------
> >  fs/nfsd/nfsctl.c   |  8 ++++++++
> >  3 files changed, 13 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/fs/nfsd/cache.h b/fs/nfsd/cache.h
> > index f21259ead64b..a4b12d6c41d3 100644
> > --- a/fs/nfsd/cache.h
> > +++ b/fs/nfsd/cache.h
> > @@ -80,6 +80,8 @@ enum {
> > =20
> >  int	nfsd_drc_slab_create(void);
> >  void	nfsd_drc_slab_free(void);
> > +int	nfsd_reply_cache_stats_init(struct nfsd_net *nn);
> > +void	nfsd_reply_cache_stats_destroy(struct nfsd_net *nn);
> >  int	nfsd_reply_cache_init(struct nfsd_net *);
> >  void	nfsd_reply_cache_shutdown(struct nfsd_net *);
> >  int	nfsd_cache_lookup(struct svc_rqst *);
> > diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
> > index 041faa13b852..b696dc629c0b 100644
> > --- a/fs/nfsd/nfscache.c
> > +++ b/fs/nfsd/nfscache.c
> > @@ -148,12 +148,12 @@ void nfsd_drc_slab_free(void)
> >  	kmem_cache_destroy(drc_slab);
> >  }
> > =20
> > -static int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
> > +int nfsd_reply_cache_stats_init(struct nfsd_net *nn)
>=20
> As part of making these two functions into a more public API, I
> would prefer to rename this nfsd_net_reply_cache_init(), and it
> should include a KDOC comment out front.
>=20
> I'm having some trouble easily distinguishing between the purpose of
>=20
>    static __net_init int nfsd_init_net(struct net *net)
>=20
> and
>=20
>    static int nfsd_startup_net(struct net *net, const struct cred *cred)
>=20
> The former is invoked when a net namespace is created. The latter is
> called by write_threads, therefore /proc/fs/nfsd/ must already be
> mounted.
>=20
> The function names are confusingly similar and there's no KDOC to be
> found. I might add a clean-up patch to this one.
>=20

I can add some kdoc patches in v2.
> >  {
> >  	return nfsd_percpu_counters_init(nn->counter, NFSD_NET_COUNTERS_NUM);
> >  }
> > =20
> > -static void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
> > +void nfsd_reply_cache_stats_destroy(struct nfsd_net *nn)
>=20
> Ditto, rename this nfsd_net_reply_cache_destroy(), plus KDOC.
>=20
>=20

Ok.

> >  {
> >  	nfsd_percpu_counters_destroy(nn->counter, NFSD_NET_COUNTERS_NUM);
> >  }
> > @@ -169,17 +169,13 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
> >  	hashsize =3D nfsd_hashsize(nn->max_drc_entries);
> >  	nn->maskbits =3D ilog2(hashsize);
> > =20
> > -	status =3D nfsd_reply_cache_stats_init(nn);
> > -	if (status)
> > -		goto out_nomem;
> > -
> >  	nn->nfsd_reply_cache_shrinker.scan_objects =3D nfsd_reply_cache_scan;
> >  	nn->nfsd_reply_cache_shrinker.count_objects =3D nfsd_reply_cache_coun=
t;
> >  	nn->nfsd_reply_cache_shrinker.seeks =3D 1;
> >  	status =3D register_shrinker(&nn->nfsd_reply_cache_shrinker,
> >  				   "nfsd-reply:%s", nn->nfsd_name);
> >  	if (status)
> > -		goto out_stats_destroy;
> > +		return status;
> > =20
> >  	nn->drc_hashtbl =3D kvzalloc(array_size(hashsize,
> >  				sizeof(*nn->drc_hashtbl)), GFP_KERNEL);
> > @@ -195,9 +191,6 @@ int nfsd_reply_cache_init(struct nfsd_net *nn)
> >  	return 0;
> >  out_shrinker:
> >  	unregister_shrinker(&nn->nfsd_reply_cache_shrinker);
> > -out_stats_destroy:
> > -	nfsd_reply_cache_stats_destroy(nn);
> > -out_nomem:
> >  	printk(KERN_ERR "nfsd: failed to allocate reply cache\n");
> >  	return -ENOMEM;
> >  }
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 1489e0b703b4..7c837afcf615 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1505,6 +1505,9 @@ static __net_init int nfsd_init_net(struct net *n=
et)
> >  	retval =3D nfsd_idmap_init(net);
> >  	if (retval)
> >  		goto out_idmap_error;
> > +	retval =3D nfsd_reply_cache_stats_init(nn);
> > +	if (retval)
> > +		goto out_repcache_error;
> >  	nn->nfsd_versions =3D NULL;
> >  	nn->nfsd4_minorversions =3D NULL;
> >  	nfsd4_init_leases_net(nn);
> > @@ -1513,6 +1516,8 @@ static __net_init int nfsd_init_net(struct net *n=
et)
> > =20
> >  	return 0;
> > =20
> > +out_repcache_error:
> > +	nfsd_idmap_shutdown(net);
> >  out_idmap_error:
> >  	nfsd_export_shutdown(net);
> >  out_export_error:
> > @@ -1521,6 +1526,9 @@ static __net_init int nfsd_init_net(struct net *n=
et)
> > =20
> >  static __net_exit void nfsd_exit_net(struct net *net)
> >  {
> > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +
> > +	nfsd_reply_cache_stats_destroy(nn);
> >  	nfsd_idmap_shutdown(net);
> >  	nfsd_export_shutdown(net);
> >  	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
>=20
> We should update this nfsd_netns_free_versions() call site to take
> the new @nn variable.
>=20

Ahh yes. Will fix.

I'll plan to send a v2 with the changes you suggest.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
