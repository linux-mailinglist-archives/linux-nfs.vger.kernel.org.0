Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E291666F84
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jan 2023 11:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239553AbjALK0a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Jan 2023 05:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjALKZx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Jan 2023 05:25:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30FDC63
        for <linux-nfs@vger.kernel.org>; Thu, 12 Jan 2023 02:21:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 57FF2B81DD8
        for <linux-nfs@vger.kernel.org>; Thu, 12 Jan 2023 10:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900A5C433D2;
        Thu, 12 Jan 2023 10:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673518893;
        bh=AEtW0SmM45p0RWYKuV9dZCp04C018uAyZeyXRstHLsg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=V7f830NUfFZAn6ZEvDDCzV/OmZPWLtRMJFaQZZnXC7fa/0o6WHa+m0ilLBeXJxu6D
         3wsHDgUnM8OJUqEooVew7qr9qn/QIoXyX8C703RJhsA/CkZfZ+93MYjvrHLeUlf2NJ
         13EMURSDg2wTu4/dl3JGuNycTX6/g6BbnL7uvvcFFiwVutZJ87PTCh64kP4OH7sijT
         msVoL1+mY+nf+2FkThT+0Qz1NAKJQaoNImtH0fTZgDBjObR9xgynZwo/r5XD+cPDNy
         CqQk7+IOEUIyNJvggdSYbx2AqTRVcObbSxqTCRiP98cnkNOgxbvlaWwLSeKoKZNtto
         FH7G3Yh0y4JkQ==
Message-ID: <24989361df3b610f5cddad9bd9949c40ec1a9cc2.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: replace delayed_work with work_struct for
 nfsd_client_shrinker
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 12 Jan 2023 05:21:31 -0500
In-Reply-To: <1673482011-27110-1-git-send-email-dai.ngo@oracle.com>
References: <1673482011-27110-1-git-send-email-dai.ngo@oracle.com>
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

On Wed, 2023-01-11 at 16:06 -0800, Dai Ngo wrote:
> Since nfsd4_state_shrinker_count always calls mod_delayed_work with
> 0 delay, we can replace delayed_work with work_struct to save some
> space and overhead.
>=20
> Also add the call to cancel_work after unregister the shrinker
> in nfs4_state_shutdown_net.
>=20
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/netns.h     | 2 +-
>  fs/nfsd/nfs4state.c | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 8c854ba3285b..51a4b7885cae 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -195,7 +195,7 @@ struct nfsd_net {
> =20
>  	atomic_t		nfsd_courtesy_clients;
>  	struct shrinker		nfsd_client_shrinker;
> -	struct delayed_work	nfsd_shrinker_work;
> +	struct work_struct	nfsd_shrinker_work;
>  };
> =20
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a7cfefd7c205..21bee33bc6dc 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4411,7 +4411,7 @@ nfsd4_state_shrinker_count(struct shrinker *shrink,=
 struct shrink_control *sc)
>  	if (!count)
>  		count =3D atomic_long_read(&num_delegations);
>  	if (count)
> -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> +		queue_work(laundry_wq, &nn->nfsd_shrinker_work);
>  	return (unsigned long)count;
>  }
> =20
> @@ -6233,8 +6233,7 @@ deleg_reaper(struct nfsd_net *nn)
>  static void
>  nfsd4_state_shrinker_worker(struct work_struct *work)
>  {
> -	struct delayed_work *dwork =3D to_delayed_work(work);
> -	struct nfsd_net *nn =3D container_of(dwork, struct nfsd_net,
> +	struct nfsd_net *nn =3D container_of(work, struct nfsd_net,
>  				nfsd_shrinker_work);
> =20
>  	courtesy_client_reaper(nn);
> @@ -8064,7 +8063,7 @@ static int nfs4_state_create_net(struct net *net)
>  	INIT_LIST_HEAD(&nn->blocked_locks_lru);
> =20
>  	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
> -	INIT_DELAYED_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker)=
;
> +	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
>  	get_net(net);
> =20
>  	nn->nfsd_client_shrinker.scan_objects =3D nfsd4_state_shrinker_scan;
> @@ -8171,6 +8170,7 @@ nfs4_state_shutdown_net(struct net *net)
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
>  	unregister_shrinker(&nn->nfsd_client_shrinker);
> +	cancel_work(&nn->nfsd_shrinker_work);
>  	cancel_delayed_work_sync(&nn->laundromat_work);
>  	locks_end_grace(&nn->nfsd4_manager);
> =20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
