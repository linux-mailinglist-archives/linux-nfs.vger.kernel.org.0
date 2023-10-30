Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094B57DBA5C
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 14:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjJ3NPW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 09:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJ3NPV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 09:15:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C470FC2
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 06:15:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B353FC433C7;
        Mon, 30 Oct 2023 13:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698671719;
        bh=TK05TgQa791zSI6DSG3ywBpcYeyjIJZwSXRYgWfw6Ds=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mjW6ufyvpxUU39QwOH7p8TD8KBMS7fAPbZrTqvTXbUU2+WcgymcSLrzRNhSqQj4rk
         e2oj6IK9g61hJk7Fhf6eZHnUSAVz7CYK3cFIGHozrjHzxjKtXW1MCZF6WdOev3wOQA
         +P9KNh9j4HBkFS2FulmKhR6aW/blBDMrAg57qd+Khrpni/WYrYEXCgGtFUHZLcBgtO
         wVPYrxtwgBULY8St3JmP9KorYQLj+4rpWhJxdmj+T7dv4F3xJwNsSFupT894mjm1d5
         KTkRorDSbZ6hn0J3ktgrnwwdERxu//XuFZB/CPgbQQ172mPYv76YyKeEgBS8ZqKl6G
         mYRrATGTx5w9Q==
Message-ID: <eb7fe40bc430891519a038434d41fb9ca6557526.camel@kernel.org>
Subject: Re: [PATCH 1/5] nfsd: call nfsd_last_thread() before final
 nfsd_put()
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Mon, 30 Oct 2023 09:15:17 -0400
In-Reply-To: <20231030011247.9794-2-neilb@suse.de>
References: <20231030011247.9794-1-neilb@suse.de>
         <20231030011247.9794-2-neilb@suse.de>
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
> If write_ports_addfd or write_ports_addxprt fail, they call nfsD_put()
> without calling nfsd_last_thread().  This leaves nn->nfsd_serv pointing
> to a structure that has been freed.
>=20
> So export nfsd_last_thread() and call it when the nfsd_serv is about to
> be destroy.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfsctl.c | 9 +++++++--
>  fs/nfsd/nfsd.h   | 1 +
>  fs/nfsd/nfssvc.c | 2 +-
>  3 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 739ed5bf71cd..79efb1075f38 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -705,8 +705,10 @@ static ssize_t __write_ports_addfd(char *buf, struct=
 net *net, const struct cred
> =20
>  	err =3D svc_addsock(nn->nfsd_serv, net, fd, buf, SIMPLE_TRANSACTION_LIM=
IT, cred);
> =20
> -	if (err >=3D 0 &&
> -	    !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
> +	if (err < 0 && !nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
> +		nfsd_last_thread(net);
> +	else if (err >=3D 0 &&
> +		 !nn->nfsd_serv->sv_nrthreads && !xchg(&nn->keep_active, 1))
>  		svc_get(nn->nfsd_serv);
> =20
>  	nfsd_put(net);
> @@ -757,6 +759,9 @@ static ssize_t __write_ports_addxprt(char *buf, struc=
t net *net, const struct cr
>  		svc_xprt_put(xprt);
>  	}
>  out_err:
> +	if (!nn->nfsd_serv->sv_nrthreads && !nn->keep_active)
> +		nfsd_last_thread(net);
> +
>  	nfsd_put(net);
>  	return err;
>  }
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index f5ff42f41ee7..3286ffacbc56 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -155,6 +155,7 @@ int nfsd_vers(struct nfsd_net *nn, int vers, enum ver=
s_op change);
>  int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_o=
p change);
>  void nfsd_reset_versions(struct nfsd_net *nn);
>  int nfsd_create_serv(struct net *net);
> +void nfsd_last_thread(struct net *net);
> =20
>  extern int nfsd_max_blksize;
> =20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index d6122bb2d167..6c968c02cc29 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -542,7 +542,7 @@ static struct notifier_block nfsd_inet6addr_notifier =
=3D {
>  /* Only used under nfsd_mutex, so this atomic may be overkill: */
>  static atomic_t nfsd_notifier_refcount =3D ATOMIC_INIT(0);
> =20
> -static void nfsd_last_thread(struct net *net)
> +void nfsd_last_thread(struct net *net)
>  {
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv =3D nn->nfsd_serv;

This patch should fix the problem that I was seeing with write_ports,
but it won't fix the hinky error cleanup in nfsd_svc. It looks like that
does get fixed in patch #4 though, so I'm not too concerned.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
