Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CA75A6D7F
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Aug 2022 21:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiH3TkZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 Aug 2022 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiH3TkZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 Aug 2022 15:40:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344912C132
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 12:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBFB561731
        for <linux-nfs@vger.kernel.org>; Tue, 30 Aug 2022 19:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3843C433D6;
        Tue, 30 Aug 2022 19:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661888423;
        bh=cZUU2onp3wriv5Xemx9q6G40/jEofE0TJtD5iLXJlwo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BgMnev3o4qjHEPSGVdZRKc9DRXsMPb8MCYFKj/mXlArSWP4HZRGOWuts8kTBzKOcA
         5/j601wjrqRRqA9n4GRDYkD0wXhhBBAytW6CQpnIg6keo2ugwBLvth9nUCkKCSwTNa
         wTV91KdGCITcAPKF/2u99dljdMb5KXTyk5j5qIFID+3RfDaBqhWEkHgUsjnpd7aQL6
         0QRrvcyXP8A7lQRAeyOU/RRj9g0CikVSULV4+IW2+LCdVc88D8TEKGnbNNMRHfFTLF
         IncrDhG7lQroU9TsTaCN1PL7RHgidx1thDdLVUKn1W15OpvF3LSkwWQH6F/+2uLvoB
         J9wzQVFRUkOow==
Message-ID: <e32e725974ca5f5f5ee4e16192d4c4cce80e9248.camel@kernel.org>
Subject: Re: [PATCH v3 1/2] NFSD: keep track of the number of courtesy
 clients in the system
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 30 Aug 2022 15:40:21 -0400
In-Reply-To: <1661886865-30304-2-git-send-email-dai.ngo@oracle.com>
References: <1661886865-30304-1-git-send-email-dai.ngo@oracle.com>
         <1661886865-30304-2-git-send-email-dai.ngo@oracle.com>
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

On Tue, 2022-08-30 at 12:14 -0700, Dai Ngo wrote:
> Add counter nfs4_courtesy_client_count to nfsd_net to keep track
> of the number of courtesy clients in the system.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/netns.h     |  2 ++
>  fs/nfsd/nfs4state.c | 14 +++++++++++---
>  2 files changed, 13 insertions(+), 3 deletions(-)
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
> index c5d199d7e6b4..9675b5d8f408 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -169,7 +169,8 @@ static __be32 get_client_locked(struct nfs4_client *c=
lp)
>  	if (is_client_expired(clp))
>  		return nfserr_expired;
>  	atomic_inc(&clp->cl_rpc_users);
> -	clp->cl_state =3D NFSD4_ACTIVE;
> +	if (xchg(&clp->cl_state, NFSD4_ACTIVE) !=3D NFSD4_ACTIVE)
> +		atomic_add_unless(&nn->nfsd_courtesy_client_count, -1, 0);

I'd prefer this:

	if (clp->cl_state !=3D NFSD4_ACTIVE)
		atomic_add_unless(...
	clp->cl_state =3D NFSD4_ACTIVE;

It's more lines, but it's easier to read. It's may also be more
efficient since you're protected by a spinlock anyway.

I think it's also less deceptive when reading the code. When I see
xchg() operations being used like that, my immediate thought is that
they must be needed for synchronization purposes. It's not in this case.

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
> @@ -5879,7 +5885,9 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struc=
t list_head *reaplist,
>  		if (!state_expired(lt, clp->cl_time))
>  			break;
>  		if (!atomic_read(&clp->cl_rpc_users))
> -			clp->cl_state =3D NFSD4_COURTESY;
> +			if (xchg(&clp->cl_state, NFSD4_COURTESY) =3D=3D
> +							NFSD4_ACTIVE)
> +				atomic_inc(&nn->nfsd_courtesy_client_count);
>  		if (!client_has_state(clp))
>  			goto exp_client;
>  		if (!nfs4_anylock_blockers(clp))

--=20
Jeff Layton <jlayton@kernel.org>
