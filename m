Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB845A521A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Aug 2022 18:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiH2Qsm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Aug 2022 12:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiH2Qsj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Aug 2022 12:48:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8048168D
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 09:48:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4123F6123F
        for <linux-nfs@vger.kernel.org>; Mon, 29 Aug 2022 16:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ADBC433C1;
        Mon, 29 Aug 2022 16:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661791717;
        bh=VW8Z9xzYpgHUmD0wSVjM5z8pwUw/DB6zVmpeOH27le4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RYEjNGTVEX+4HwjT8/K6DGINQTaxLVIDhCvySh2FKyFwNRhWxMXnhFvNqy/UgGY2S
         rR52Y3WNdIw9Xt3pGCblI67rSVX2zX8RSdChnGkSWjKOi6VFi9yFY7FN5UgBo9sQse
         qT9eL53YIz+rwX9E5OF3zNn1gNGFse8jDx+9fmZ+dv0Hm5jB3GknbrnyDOi0qJnId8
         j+8hnjiswaWQu9sjWC3IIF8ClYTj8b3qtKgLT3NzTyZeNiiUEVOP7xrUmf6SEN+MS4
         34hjZCvYPLHza+BtMezRVKLnK0NFC8UD3hTLD7clm+W93YGIf9WyWELE1l/kDHC+bU
         apB1rlvKfWdSw==
Message-ID: <d922f34be03a6df4bb8a0dd12df4a085ba983cb8.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] NFSD: keep track of the number of courtesy
 clients in the system
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 29 Aug 2022 12:48:35 -0400
In-Reply-To: <1661734063-22023-2-git-send-email-dai.ngo@oracle.com>
References: <1661734063-22023-1-git-send-email-dai.ngo@oracle.com>
         <1661734063-22023-2-git-send-email-dai.ngo@oracle.com>
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

On Sun, 2022-08-28 at 17:47 -0700, Dai Ngo wrote:
> Add counter nfs4_courtesy_client_count to nfsd_net to keep track
> of the number of courtesy clients in the system.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/netns.h     |  2 ++
>  fs/nfsd/nfs4state.c | 20 +++++++++++++++-----
>  2 files changed, 17 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index ffe17743cc74..2695dff1378a 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -192,6 +192,8 @@ struct nfsd_net {
> =20
>  	atomic_t		nfs4_client_count;
>  	int			nfs4_max_clients;
> +
> +	atomic_t		nfsd_courtesy_client_count;
>  };
> =20
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c5d199d7e6b4..3d8d7ebb5b91 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -169,7 +169,8 @@ static __be32 get_client_locked(struct nfs4_client *c=
lp)
>  	if (is_client_expired(clp))
>  		return nfserr_expired;
>  	atomic_inc(&clp->cl_rpc_users);
> -	clp->cl_state =3D NFSD4_ACTIVE;
> +	if (xchg(&clp->cl_state, NFSD4_ACTIVE) !=3D NFSD4_ACTIVE)

The xchg calls seem like overkill. The cl_state is protected by the
nn->client_lock. Nothing else can race in and change it here.

> +		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);
>  	return nfs_ok;
>  }
> =20
> @@ -190,7 +191,8 @@ renew_client_locked(struct nfs4_client *clp)
> =20
>  	list_move_tail(&clp->cl_lru, &nn->client_lru);
>  	clp->cl_time =3D ktime_get_boottime_seconds();
> -	clp->cl_state =3D NFSD4_ACTIVE;
> +	if (xchg(&clp->cl_state, NFSD4_ACTIVE) !=3D NFSD4_ACTIVE)
> +		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);
>  }
> =20
>  static void put_client_renew_locked(struct nfs4_client *clp)
> @@ -2233,6 +2235,8 @@ __destroy_client(struct nfs4_client *clp)
>  	if (clp->cl_cb_conn.cb_xprt)
>  		svc_xprt_put(clp->cl_cb_conn.cb_xprt);
>  	atomic_add_unless(&nn->nfs4_client_count, -1, 0);
> +	if (clp->cl_state !=3D NFSD4_ACTIVE)
> +		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);
>  	free_client(clp);
>  	wake_up_all(&expiry_wq);
>  }
> @@ -4356,6 +4360,8 @@ void nfsd4_init_leases_net(struct nfsd_net *nn)
>  	max_clients =3D (u64)si.totalram * si.mem_unit / (1024 * 1024 * 1024);
>  	max_clients *=3D NFS4_CLIENTS_PER_GB;
>  	nn->nfs4_max_clients =3D max_t(int, max_clients, NFS4_CLIENTS_PER_GB);
> +
> +	atomic_set(&nn->nfsd_courtesy_client_count, 0);
>  }
> =20
>  static void init_nfs4_replay(struct nfs4_replay *rp)
> @@ -5864,7 +5870,7 @@ static void
>  nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist=
,
>  				struct laundry_time *lt)
>  {
> -	unsigned int maxreap, reapcnt =3D 0;
> +	unsigned int oldstate, maxreap, reapcnt =3D 0;
>  	struct list_head *pos, *next;
>  	struct nfs4_client *clp;
> =20
> @@ -5878,8 +5884,12 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, stru=
ct list_head *reaplist,
>  			goto exp_client;
>  		if (!state_expired(lt, clp->cl_time))
>  			break;
> -		if (!atomic_read(&clp->cl_rpc_users))
> -			clp->cl_state =3D NFSD4_COURTESY;
> +		oldstate =3D NFSD4_ACTIVE;
> +		if (!atomic_read(&clp->cl_rpc_users)) {
> +			oldstate =3D xchg(&clp->cl_state, NFSD4_COURTESY);
> +			if (oldstate =3D=3D NFSD4_ACTIVE)
> +				atomic_inc(&nn->nfsd_courtesy_client_count);
> +		}
>  		if (!client_has_state(clp))
>  			goto exp_client;
>  		if (!nfs4_anylock_blockers(clp))

--=20
Jeff Layton <jlayton@kernel.org>
