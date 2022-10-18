Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6522D602C6C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Oct 2022 15:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJRNHr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Oct 2022 09:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJRNHp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Oct 2022 09:07:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E2FC5897
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 06:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8406B81F1D
        for <linux-nfs@vger.kernel.org>; Tue, 18 Oct 2022 13:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6CFC433C1;
        Tue, 18 Oct 2022 13:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666098461;
        bh=FnRVeG/qCCThLsTV97E3VMbWP8nkHqfmsSSLmP88rbI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ys/jql1hjeLZ6t1GUGD8kSThztHvj/ZZv6To7KSvIFzJqyw4FvyNLrRZBipc5x77U
         vhd4e4M3WIpamO6UmRUbVuk+Kbkj5x1JSe0sa25f/CVUKcnGvd+cKYHsBvrZc5D41s
         JrLgkPefdspciieG2vK7Q005K/VDPTjjoNPyXb5OBVQGWsLuITrRgVVSkVj580neHO
         5MaBjZLKaTOc0+FRTN52uZmJNb0gEzGXVwpq2HhSu+CHXOklaqqQt5aTMCYMZ73f1u
         7urBc/jGzr9tdjQIsNtoAs5mEfV2BGBe0CHuHaPJzxp/1sFq8WInEiqAhc/4Yr4zRz
         Lg3KRPjpgrkSg==
Message-ID: <9d1be93452dc03f911c684946464b0862c93b965.camel@kernel.org>
Subject: Re: [PATCH 2/2] NFSD: add delegation shrinker to react to low
 memory condition
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Oct 2022 09:07:39 -0400
In-Reply-To: <1666070139-18843-3-git-send-email-dai.ngo@oracle.com>
References: <1666070139-18843-1-git-send-email-dai.ngo@oracle.com>
         <1666070139-18843-3-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-17 at 22:15 -0700, Dai Ngo wrote:
> The delegation shrinker is scheduled to run on every shrinker's
> 'count' callback. It scans the client list and sends the
> courtesy CB_RECALL_ANY to the clients that hold delegations.
>=20
> To avoid flooding the clients with CB_RECALL_ANY requests, the
> delegation shrinker is scheduled to run after a 5 seconds delay.
>=20

But...when the kernel needs memory, it generally needs it _now_, and 5s
is a long time. It'd be better to not delay the initial sending of
CB_RECALL_ANY callbacks this much.

Maybe the logic should be changed such that it runs no more frequently
than once every 5s, but don't delay the initial sending of
CB_RECALL_ANYs.

> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/netns.h     |  3 +++
>  fs/nfsd/nfs4state.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  fs/nfsd/state.h     |  1 +
>  3 files changed, 73 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 8c854ba3285b..394a05fb46d8 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -196,6 +196,9 @@ struct nfsd_net {
>  	atomic_t		nfsd_courtesy_clients;
>  	struct shrinker		nfsd_client_shrinker;
>  	struct delayed_work	nfsd_shrinker_work;
> +
> +	struct shrinker		nfsd_deleg_shrinker;
> +	struct delayed_work	nfsd_deleg_shrinker_work;
>  };
> =20
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c60c937dece6..bdaea0e6e72f 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4392,11 +4392,32 @@ nfsd_courtesy_client_scan(struct shrinker *shrink=
, struct shrink_control *sc)
>  	return SHRINK_STOP;
>  }
> =20
> +static unsigned long
> +nfsd_deleg_shrinker_count(struct shrinker *shrink, struct shrink_control=
 *sc)
> +{
> +	unsigned long cnt;
> +	struct nfsd_net *nn =3D container_of(shrink,
> +				struct nfsd_net, nfsd_deleg_shrinker);
> +
> +	cnt =3D atomic_long_read(&num_delegations);
> +	if (cnt)
> +		mod_delayed_work(laundry_wq,
> +			&nn->nfsd_deleg_shrinker_work, 5 * HZ);
> +	return cnt;
> +}
> +

What's the rationale for doing all of this in the count callback? Why
not just return the value here and leave scheduling to the scan
callback?

> +static unsigned long
> +nfsd_deleg_shrinker_scan(struct shrinker *shrink, struct shrink_control =
*sc)
> +{
> +	return SHRINK_STOP;
> +}
> +
>  int
>  nfsd4_init_leases_net(struct nfsd_net *nn)
>  {
>  	struct sysinfo si;
>  	u64 max_clients;
> +	int retval;
> =20
>  	nn->nfsd4_lease =3D 90;	/* default lease time */
>  	nn->nfsd4_grace =3D 90;
> @@ -4417,13 +4438,23 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
>  	nn->nfsd_client_shrinker.scan_objects =3D nfsd_courtesy_client_scan;
>  	nn->nfsd_client_shrinker.count_objects =3D nfsd_courtesy_client_count;
>  	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> -	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> +	retval =3D register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> +	if (retval)
> +		return retval;
> +	nn->nfsd_deleg_shrinker.scan_objects =3D nfsd_deleg_shrinker_scan;
> +	nn->nfsd_deleg_shrinker.count_objects =3D nfsd_deleg_shrinker_count;
> +	nn->nfsd_deleg_shrinker.seeks =3D DEFAULT_SEEKS;
> +	retval =3D register_shrinker(&nn->nfsd_deleg_shrinker, "nfsd-delegation=
");
> +	if (retval)
> +		unregister_shrinker(&nn->nfsd_client_shrinker);
> +	return retval;
>  }
> =20
>  void
>  nfsd4_leases_net_shutdown(struct nfsd_net *nn)
>  {
>  	unregister_shrinker(&nn->nfsd_client_shrinker);
> +	unregister_shrinker(&nn->nfsd_deleg_shrinker);
>  }
> =20
>  static void init_nfs4_replay(struct nfs4_replay *rp)
> @@ -6162,6 +6193,42 @@ courtesy_client_reaper(struct work_struct *reaper)
>  	nfs4_process_client_reaplist(&reaplist);
>  }
> =20
> +static void
> +deleg_reaper(struct work_struct *deleg_work)
> +{
> +	struct list_head *pos, *next;
> +	struct nfs4_client *clp;
> +	struct list_head cblist;
> +	struct delayed_work *dwork =3D to_delayed_work(deleg_work);
> +	struct nfsd_net *nn =3D container_of(dwork, struct nfsd_net,
> +					nfsd_deleg_shrinker_work);
> +
> +	INIT_LIST_HEAD(&cblist);
> +	spin_lock(&nn->client_lock);
> +	list_for_each_safe(pos, next, &nn->client_lru) {
> +		clp =3D list_entry(pos, struct nfs4_client, cl_lru);
> +		if (clp->cl_state !=3D NFSD4_ACTIVE ||
> +				list_empty(&clp->cl_delegations) ||
> +				atomic_read(&clp->cl_delegs_in_recall) ||
> +				clp->cl_recall_any_busy) {
> +			continue;
> +		}
> +		clp->cl_recall_any_busy =3D true;
> +		list_add(&clp->cl_recall_any_cblist, &cblist);
> +
> +		/* release in nfsd4_cb_recall_any_release */
> +		atomic_inc(&clp->cl_rpc_users);
> +	}
> +	spin_unlock(&nn->client_lock);
> +	list_for_each_safe(pos, next, &cblist) {
> +		clp =3D list_entry(pos, struct nfs4_client, cl_recall_any_cblist);
> +		list_del_init(&clp->cl_recall_any_cblist);
> +		clp->cl_recall_any_bm =3D BIT(RCA4_TYPE_MASK_RDATA_DLG) |
> +						BIT(RCA4_TYPE_MASK_WDATA_DLG);
> +		nfsd4_run_cb(&clp->cl_recall_any);
> +	}
> +}
> +
>  static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid =
*stp)
>  {
>  	if (!fh_match(&fhp->fh_handle, &stp->sc_file->fi_fhandle))
> @@ -7985,6 +8052,7 @@ static int nfs4_state_create_net(struct net *net)
> =20
>  	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
>  	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, courtesy_client_reaper);
> +	INIT_DELAYED_WORK(&nn->nfsd_deleg_shrinker_work, deleg_reaper);
>  	get_net(net);
> =20
>  	return 0;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 49ca06169642..05b572ce6605 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -415,6 +415,7 @@ struct nfs4_client {
>  	bool			cl_recall_any_busy;
>  	uint32_t		cl_recall_any_bm;
>  	struct nfsd4_callback	cl_recall_any;
> +	struct list_head	cl_recall_any_cblist;
>  };
> =20
>  /* struct nfs4_client_reset

--=20
Jeff Layton <jlayton@kernel.org>
