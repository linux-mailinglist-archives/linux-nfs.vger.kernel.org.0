Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA6C7DBA60
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 14:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjJ3NP5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 09:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjJ3NP4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 09:15:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38893C9
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 06:15:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C6FC433C8;
        Mon, 30 Oct 2023 13:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698671753;
        bh=rIQ5dWszKDhjRevaDxMx4ZG8zSyXUzknjrq1MDvtt8c=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UNiaCiR3bOXwnSPvWox5uVQoowqtX08bmrjgoCaytnOs5rrcqaAAgN7xSU0NsoX+t
         LhsFppxrfVucmV0c654sCcKH6MxhheiwvqZ/8qW7OhYmBmCb3z70RfQm00oxcgnS93
         oNgW84M1ZsoivPwM9VUw/OQa7bPUjRyD3f0WB9HEagrI0++HPzgGF9TkClAku+Te0m
         +7QVZuu0etU8uAuFJj+5NGzPTvlsAaw4eg99E+3ZOUzRIWVTtSft5TMp/EAJC5yeS7
         1L0Te7UQ2G14hYEh/NrLkaM8E5qYvS17ZbncSO5gzM7KgQiyY/Ce/eK3GMl69k6Snf
         t7ud1od235lIw==
Message-ID: <8ea64c4e24ecf5105f98ecb6776167de8afd5fbf.camel@kernel.org>
Subject: Re: [PATCH 5/5] nfsd: rename nfsd_last_thread() to
 nfsd_destroy_serv()
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Mon, 30 Oct 2023 09:15:52 -0400
In-Reply-To: <20231030011247.9794-6-neilb@suse.de>
References: <20231030011247.9794-1-neilb@suse.de>
         <20231030011247.9794-6-neilb@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-10-30 at 12:08 +1100, NeilBrown wrote:
> As this function now destroys the svc_serv, this is a better name.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfsctl.c | 4 ++--
>  fs/nfsd/nfsd.h   | 2 +-
>  fs/nfsd/nfssvc.c | 8 ++++----
>  3 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 86cab5281fd2..d603e672d568 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -707,7 +707,7 @@ static ssize_t __write_ports_addfd(char *buf, struct =
net *net, const struct cred
> =20
>  	if (!nn->nfsd_serv->sv_nrthreads &&
>  	    list_empty(&nn->nfsd_serv->sv_permsocks))
> -		nfsd_last_thread(net);
> +		nfsd_destroy_serv(net);
> =20
>  	return err;
>  }
> @@ -754,7 +754,7 @@ static ssize_t __write_ports_addxprt(char *buf, struc=
t net *net, const struct cr
>  out_err:
>  	if (!nn->nfsd_serv->sv_nrthreads &&
>  	    list_empty(&nn->nfsd_serv->sv_permsocks))
> -		nfsd_last_thread(net);
> +		nfsd_destroy_serv(net);
> =20
>  	return err;
>  }
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 9ed0e08d16c2..304e9728b929 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -148,7 +148,7 @@ int nfsd_vers(struct nfsd_net *nn, int vers, enum ver=
s_op change);
>  int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_o=
p change);
>  void nfsd_reset_versions(struct nfsd_net *nn);
>  int nfsd_create_serv(struct net *net);
> -void nfsd_last_thread(struct net *net);
> +void nfsd_destroy_serv(struct net *net);
> =20
>  extern int nfsd_max_blksize;
> =20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 61a1d966ca48..88c2e2c94829 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -533,7 +533,7 @@ static struct notifier_block nfsd_inet6addr_notifier =
=3D {
>  /* Only used under nfsd_mutex, so this atomic may be overkill: */
>  static atomic_t nfsd_notifier_refcount =3D ATOMIC_INIT(0);
> =20
> -void nfsd_last_thread(struct net *net)
> +void nfsd_destroy_serv(struct net *net)
>  {
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv =3D nn->nfsd_serv;
> @@ -555,7 +555,7 @@ void nfsd_last_thread(struct net *net)
>  	/*
>  	 * write_ports can create the server without actually starting
>  	 * any threads--if we get shut down before any threads are
> -	 * started, then nfsd_last_thread will be run before any of this
> +	 * started, then nfsd_destroy_serv will be run before any of this
>  	 * other initialization has been done except the rpcb information.
>  	 */
>  	svc_rpcb_cleanup(serv, net);
> @@ -641,7 +641,7 @@ void nfsd_shutdown_threads(struct net *net)
> =20
>  	/* Kill outstanding nfsd threads */
>  	svc_set_num_threads(serv, NULL, 0);
> -	nfsd_last_thread(net);
> +	nfsd_destroy_serv(net);
>  	mutex_unlock(&nfsd_mutex);
>  }
> =20
> @@ -802,7 +802,7 @@ nfsd_svc(int nrservs, struct net *net, const struct c=
red *cred)
>  	error =3D serv->sv_nrthreads;
>  out_put:
>  	if (serv->sv_nrthreads =3D=3D 0)
> -		nfsd_last_thread(net);
> +		nfsd_destroy_serv(net);
>  out:
>  	mutex_unlock(&nfsd_mutex);
>  	return error;

LGTM

Reviewed-by: Jeff Layton <jlayton@kernel.org>
