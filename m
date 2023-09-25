Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62797AD71D
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Sep 2023 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjIYLlT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Sep 2023 07:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIYLlT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Sep 2023 07:41:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FA5DF
        for <linux-nfs@vger.kernel.org>; Mon, 25 Sep 2023 04:41:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C9EC433C8;
        Mon, 25 Sep 2023 11:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695642072;
        bh=pwKKr9wZ0WLihtz2SXvQsIjojN6HnaAZ6z9uqP/9hjg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jDi5/6dzh4WYvI3z1Vs0jawYwslu37v+wjt89oCTJzEXzblBZ+TtfoDsQlvpHwNcb
         2vEIWWHcNhOs0KfQj/FLWypfp7atgLfDTlR/CRgPn6KAQZvYymKXO73EXbfdH8i6g2
         0AgXdaTDXGJCYstuBELgMesK8qnRqteb2jzXQbkMOcbo6lQjddD4h1VGxGORAqlxHD
         bcIssi6dcj+HVLj+6lrWdu3iCFk+/bpCaqkC8To+uQSFAkYxcGB7IIE8UC2VKgfw1G
         IMiezqB0XdCUeASmag8pBEzDtPWYukLXoNRP2zdPdDZxsxwVfS/O7uqXczMh5buNwd
         s2ZcZd+octnFg==
Message-ID: <c31e35b33606211c766a0fae12187b16d67e8a0f.camel@kernel.org>
Subject: Re: [PATCH nfsd-next] NFSD: simplify error paths in nfsd_svc()
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
        Tom Talpey <tom@talpey.com>,
        Linux NFS list <linux-nfs@vger.kernel.org>
Date:   Mon, 25 Sep 2023 07:41:10 -0400
In-Reply-To: <169561203735.19404.6014131036692240448@noble.neil.brown.name>
References: <169561203735.19404.6014131036692240448@noble.neil.brown.name>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-09-25 at 12:06 +1000, NeilBrown wrote:
> The error paths in nfsd_svc() are needlessly complex and can result in a
> final call to svc_put() without nfsd_last_thread() being called.  This
> results in the listening sockets not being closed properly.
>=20
> The per-netns setup provided by nfsd_startup_new() and removed by
> nfsd_shutdown_net() is needed precisely when there are running threads.
> So we don't need nfsd_up_before.  We don't need to know if it *was* up.
> We only need to know if any threads are left.  If none are, then we must
> call nfsd_shutdown_net().  But we don't need to do that explicitly as
> nfsd_last_thread() does that for us.
>=20
> So simply call nfsd_last_thread() before the last svc_put() if there are
> no running threads.  That will always do the right thing.
>=20
> Also discard:
>  pr_info("nfsd: last server has exited, flushing export cache\n");
> It may not be true if an attempt to start the first server failed, and
> it isn't particularly helpful and it simply reports normal behaviour.
>=20

Thanks. Removing that is long overdue.

> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfssvc.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>=20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index c5890cdfe97b..d6122bb2d167 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -572,7 +572,6 @@ static void nfsd_last_thread(struct net *net)
>  		return;
> =20
>  	nfsd_shutdown_net(net);
> -	pr_info("nfsd: last server has exited, flushing export cache\n");
>  	nfsd_export_flush(net);
>  }
> =20
> @@ -786,7 +785,6 @@ int
>  nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
>  {
>  	int	error;
> -	bool	nfsd_up_before;
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv;
> =20
> @@ -806,8 +804,6 @@ nfsd_svc(int nrservs, struct net *net, const struct c=
red *cred)
>  	error =3D nfsd_create_serv(net);
>  	if (error)
>  		goto out;
> -
> -	nfsd_up_before =3D nn->nfsd_net_up;
>  	serv =3D nn->nfsd_serv;
> =20
>  	error =3D nfsd_startup_net(net, cred);
> @@ -815,17 +811,15 @@ nfsd_svc(int nrservs, struct net *net, const struct=
 cred *cred)
>  		goto out_put;
>  	error =3D svc_set_num_threads(serv, NULL, nrservs);
>  	if (error)
> -		goto out_shutdown;
> +		goto out_put;
>  	error =3D serv->sv_nrthreads;
> -	if (error =3D=3D 0)
> -		nfsd_last_thread(net);
> -out_shutdown:
> -	if (error < 0 && !nfsd_up_before)
> -		nfsd_shutdown_net(net);
>  out_put:
>  	/* Threads now hold service active */
>  	if (xchg(&nn->keep_active, 0))
>  		svc_put(serv);
> +
> +	if (serv->sv_nrthreads =3D=3D 0)
> +		nfsd_last_thread(net);
>  	svc_put(serv);
>  out:
>  	mutex_unlock(&nfsd_mutex);

Nice cleanup.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
