Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95504665E25
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 15:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjAKOix (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 09:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjAKOiS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 09:38:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9574F373BE
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 06:34:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9328B81C01
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 14:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B92C433D2;
        Wed, 11 Jan 2023 14:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673447662;
        bh=JJ1AH3NyOUc993My1bfK4VE0j7GAlWIpZha51c/IZ2Q=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=slRAftZ7o24wkvCv3bVhtXigDrIwCmF5GQIDUq+6ZnQyfIhY/PwYJxC0kPnqgOART
         My+i+LdHyaf4JgUGrNAQdLBgOCPpXl+F3smUluAno/wpL77fePtzv4Jel+F8KM/xpX
         kmxqHceS8sN1Hp6IRHAiyySZGCqN6u1nN61zqskeBuESJuaZEShLaDbK9TUn5Sei6c
         fkWYHF+RJwAFW7eN8SsDcnGpfftIG0gy70hWE+NPbvMyHHaOeE/lJSm+BoAueL9U0x
         G9qV5DYwshr+U7WRO/M7p/IzSLbU+iS0M2xhI9+DQl8oh2ohfF3iaT4aR1c7Msm2fN
         OrsdELwkLSZaA==
Message-ID: <23f1fda9f550a73182cafc140bb8dfb9af2ea874.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: register/unregister of nfsd-client shrinker
 at nfsd startup/shutdown time
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        Mike Galbraith <efault@gmx.de>
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 11 Jan 2023 09:34:20 -0500
In-Reply-To: <1673332991-24406-1-git-send-email-dai.ngo@oracle.com>
References: <1673332991-24406-1-git-send-email-dai.ngo@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

I suspect that this patch is probably enough to fix the problem that
Mike is hitting. Perhaps we should mark this for stable after revising
the changelog?

Mike, would you be able to test this patch and see whether it fixes the
shrinker oopses you've been hitting? It's also commit a77ce15ca9cb10 in
Chuck's git tree.
--=20
Jeff Layton <jlayton@kernel.org>
