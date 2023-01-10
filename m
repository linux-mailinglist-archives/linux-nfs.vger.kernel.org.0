Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEA9663E3C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Jan 2023 11:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjAJKan (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Jan 2023 05:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjAJKam (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Jan 2023 05:30:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3E13590B
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 02:30:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D796F61580
        for <linux-nfs@vger.kernel.org>; Tue, 10 Jan 2023 10:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB928C433EF;
        Tue, 10 Jan 2023 10:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673346640;
        bh=uPRhZci4VDlJQmi1h96gmgIu+UlrlcJLRatEnW88n80=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qgcyB4yB8ZlGoixZVPAC9KclMP8hDXxEKiVOeGIHlHcFu2jWLHRDvkDqFAncWqRMO
         5KwmxrzxUbWC8rFvtjWN9lsClwrr5lqG6tkNkISb/1JhL28aJAYEFh0qkzOHKIOgIG
         wSEJiifZ6kleySxfDWb4BroCadiIQpkVBh7XMnrRwTAmvxPCxjnYKAXSnHY5XMbMZ0
         9wKuj1xatOsBGAFj2n+VwynWJqzG0sn59fWJp1/VYrWowZgrvzK6had3FMbceT4RCa
         jGW2iF76Psy0704MAyfcgKvoIDIK/4sJkZ38Yuybpw8p436SPfFy5gZ/McbBF9iCtA
         WyeYciS48lqEg==
Message-ID: <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Jeff Layton <jlayton@kernel.org>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com
Cc:     efault@gmx.de, linux-nfs@vger.kernel.org
Date:   Tue, 10 Jan 2023 05:30:38 -0500
In-Reply-To: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
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

On Mon, 2023-01-09 at 22:48 -0800, Dai Ngo wrote:
> Currently nfsd4_state_shrinker_worker can be schduled multiple times
> from nfsd4_state_shrinker_count when memory is low. This causes
> the WARN_ON_ONCE in __queue_delayed_work to trigger.
>=20
> This patch allows only one instance of nfsd4_state_shrinker_worker
> at a time using the nfsd_shrinker_active flag, protected by the
> client_lock.
>=20
> Replace mod_delayed_work with queue_delayed_work since we
> don't expect to modify the delay of any pending work.
>=20
> Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory =
condition")
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/netns.h     |  1 +
>  fs/nfsd/nfs4state.c | 16 ++++++++++++++--
>  2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 8c854ba3285b..801d70926442 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -196,6 +196,7 @@ struct nfsd_net {
>  	atomic_t		nfsd_courtesy_clients;
>  	struct shrinker		nfsd_client_shrinker;
>  	struct delayed_work	nfsd_shrinker_work;
> +	bool			nfsd_shrinker_active;
>  };
> =20
>  /* Simple check to find out if a given net was properly initialized */
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ee56c9466304..e00551af6a11 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4407,11 +4407,20 @@ nfsd4_state_shrinker_count(struct shrinker *shrin=
k, struct shrink_control *sc)
>  	struct nfsd_net *nn =3D container_of(shrink,
>  			struct nfsd_net, nfsd_client_shrinker);
> =20
> +	spin_lock(&nn->client_lock);
> +	if (nn->nfsd_shrinker_active) {
> +		spin_unlock(&nn->client_lock);
> +		return 0;
> +	}

Is this extra machinery really necessary? The bool and spinlock don't
seem to be needed. Typically there is no issue with calling
queued_delayed_work when the work is already queued. It just returns
false in that case without doing anything.

>=20
>  	count =3D atomic_read(&nn->nfsd_courtesy_clients);
>  	if (!count)
>  		count =3D atomic_long_read(&num_delegations);
> -	if (count)
> -		mod_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> +	if (count) {
> +		nn->nfsd_shrinker_active =3D true;
> +		spin_unlock(&nn->client_lock);
> +		queue_delayed_work(laundry_wq, &nn->nfsd_shrinker_work, 0);
> +	} else
> +		spin_unlock(&nn->client_lock);
>  	return (unsigned long)count;
>  }
> =20
> @@ -6239,6 +6248,9 @@ nfsd4_state_shrinker_worker(struct work_struct *wor=
k)
> =20
>  	courtesy_client_reaper(nn);
>  	deleg_reaper(nn);
> +	spin_lock(&nn->client_lock);
> +	nn->nfsd_shrinker_active =3D 0;
> +	spin_unlock(&nn->client_lock);
>  }
> =20
>  static inline __be32 nfs4_check_fh(struct svc_fh *fhp, struct nfs4_stid =
*stp)

--=20
Jeff Layton <jlayton@kernel.org>
