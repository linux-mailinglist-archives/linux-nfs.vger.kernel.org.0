Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1397663E16
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 11:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjAJKZF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 05:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbjAJKYv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 05:24:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA3E3219B
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 02:24:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39E0B615AE
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 10:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484BCC433EF;
        Tue, 10 Jan 2023 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673346288;
        bh=0K7jUOx78sKOIkP1rbpliTjxKadbuYn2S0L3Myn0Sy8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YHuVtxdnw3yMws7FBumQNaP25UlWTFocOitvkUX6+y7B3hgZJ+j17MfdT9y2NIA6o
         E9Jvehnb/UJfbM7LgKPXM66trsV0XX9fukeMukNPH0vQvBWNTMsHfBCZLFjNia76Fb
         9qzATAa61TudHo9saRoUlT4uF2bvqKb2JZR+qUowF2HW3WGvFpEb9imQEMW105IPP8
         kNkS0mPN9iPxUhRHUMrrdkbo0FSURBbXcr4mZbCbH3RHnjSaiOgjOmzzHVN+C4G2rW
         EgypxLFYN8k15qk44OhdX7xa31GYQoIgtacTDofttBiT9AbfH8hlEe0+OBbN96fnU3
         CIfkRxGrOjKaA==
Message-ID: <8b456fe7a351b861a29186a421afdee57bd10309.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: register/unregister of nfsd-client shrinker
 at nfsd startup/shutdown time
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 10 Jan 2023 05:24:46 -0500
In-Reply-To: <1673332991-24406-1-git-send-email-dai.ngo@oracle.com>
References: <1673332991-24406-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-01-09 at 22:43 -0800, Dai Ngo wrote:
> Currently the nfsd-client shrinker is registered and unregistered at
> the time the nfsd module is loaded and unloaded. This means after the
> nfsd service is shutdown, the nfsd-client shrinker is still registered
> in the system. This causes the nfsd-client shrinker to be called when
> memory is low even thought nfsd service is not running. This is also
> true for the nfsd_reply_cache_shrinker.
>=20

But this patch doesn't move the reply cache shrinker. Do you intend to
do that too?

> This patch moves the register/unregister of nfsd-client shrinker from
> module load/unload time to nfsd startup/shutdown time.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4state.c | 18 ++++++------------
>  fs/nfsd/nfsctl.c    |  7 +------
>  fs/nfsd/nfsd.h      |  6 ++----
>  3 files changed, 9 insertions(+), 22 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 7b2ee535ade8..ee56c9466304 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4421,7 +4421,7 @@ nfsd4_state_shrinker_scan(struct shrinker *shrink, =
struct shrink_control *sc)
>  	return SHRINK_STOP;
>  }
> =20
> -int
> +void
>  nfsd4_init_leases_net(struct nfsd_net *nn)
>  {
>  	struct sysinfo si;
> @@ -4443,16 +4443,6 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
>  	nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
> =20
>  	atomic_set(&nn->nfsd_courtesy_clients, 0);
> -	nn->nfsd_client_shrinker.scan_objects =3D nfsd4_state_shrinker_scan;
> -	nn->nfsd_client_shrinker.count_objects =3D nfsd4_state_shrinker_count;
> -	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> -	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> -}
> -
> -void
> -nfsd4_leases_net_shutdown(struct nfsd_net *nn)
> -{
> -	unregister_shrinker(&nn->nfsd_client_shrinker);
>  }
> =20
>  static void init_nfs4_replay(struct nfs4_replay *rp)
> @@ -8077,7 +8067,10 @@ static int nfs4_state_create_net(struct net *net)
>  	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker)=
;
>  	get_net(net);
> =20
> -	return 0;
> +	nn->nfsd_client_shrinker.scan_objects =3D nfsd4_state_shrinker_scan;
> +	nn->nfsd_client_shrinker.count_objects =3D nfsd4_state_shrinker_count;
> +	nn->nfsd_client_shrinker.seeks =3D DEFAULT_SEEKS;
> +	return register_shrinker(&nn->nfsd_client_shrinker, "nfsd-client");
> =20
>  err_sessionid:
>  	kfree(nn->unconf_id_hashtbl);
> @@ -8171,6 +8164,7 @@ nfs4_state_shutdown_net(struct net *net)
>  	struct list_head *pos, *next, reaplist;
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
> +	unregister_shrinker(&nn->nfsd_client_shrinker);
>  	cancel_delayed_work_sync(&nn->laundromat_work);
>  	locks_end_grace(&nn->nfsd4_manager);
> =20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index d1e581a60480..c2577ee7ffb2 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1457,9 +1457,7 @@ static __net_init int nfsd_init_net(struct net *net=
)
>  		goto out_idmap_error;
>  	nn->nfsd_versions =3D NULL;
>  	nn->nfsd4_minorversions =3D NULL;
> -	retval =3D nfsd4_init_leases_net(nn);
> -	if (retval)
> -		goto out_drc_error;
> +	nfsd4_init_leases_net(nn);
>  	retval =3D nfsd_reply_cache_init(nn);
>  	if (retval)
>  		goto out_cache_error;
> @@ -1469,8 +1467,6 @@ static __net_init int nfsd_init_net(struct net *net=
)
>  	return 0;
> =20
>  out_cache_error:
> -	nfsd4_leases_net_shutdown(nn);
> -out_drc_error:
>  	nfsd_idmap_shutdown(net);
>  out_idmap_error:
>  	nfsd_export_shutdown(net);
> @@ -1486,7 +1482,6 @@ static __net_exit void nfsd_exit_net(struct net *ne=
t)
>  	nfsd_idmap_shutdown(net);
>  	nfsd_export_shutdown(net);
>  	nfsd_netns_free_versions(net_generic(net, nfsd_net_id));
> -	nfsd4_leases_net_shutdown(nn);
>  }
> =20
>  static struct pernet_operations nfsd_net_ops =3D {
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 93b42ef9ed91..fa0144a74267 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -504,8 +504,7 @@ extern void unregister_cld_notifier(void);
>  extern void nfsd4_ssc_init_umount_work(struct nfsd_net *nn);
>  #endif
> =20
> -extern int nfsd4_init_leases_net(struct nfsd_net *nn);
> -extern void nfsd4_leases_net_shutdown(struct nfsd_net *nn);
> +extern void nfsd4_init_leases_net(struct nfsd_net *nn);
> =20
>  #else /* CONFIG_NFSD_V4 */
>  static inline int nfsd4_is_junction(struct dentry *dentry)
> @@ -513,8 +512,7 @@ static inline int nfsd4_is_junction(struct dentry *de=
ntry)
>  	return 0;
>  }
> =20
> -static inline int nfsd4_init_leases_net(struct nfsd_net *nn) { return 0;=
 };
> -static inline void nfsd4_leases_net_shutdown(struct nfsd_net *nn) {};
> +static inline void nfsd4_init_leases_net(struct nfsd_net *nn) { };
> =20
>  #define register_cld_notifier() 0
>  #define unregister_cld_notifier() do { } while(0)



Patch looks reasonable. It might be good to also move the reply cache
init in a similar way (as you pointed out in the patch description).

Reviewed-by: Jeff Layton <jlayton@kernel.org>
