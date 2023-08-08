Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A30377472B
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Aug 2023 21:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjHHTK2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 15:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjHHTKH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 15:10:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF9532988
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 09:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B53C9624E1
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 11:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B0FC433C7;
        Tue,  8 Aug 2023 11:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691494856;
        bh=gsyMb/07N0eGMczPL9H6ej98QpY2XyejWHJmO/bHLx8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QAputt6AntFmvJv9T2xveiltUkdqtMGh+Bcw3tLnKW0FuwBARxqPdMu8XBnlyJKzU
         IXSdnjosrbh7t+kQSbXrBmzoDeTeJcS9lCF6Ucc8tz+seocgBe4IQrV53ianOTjCh8
         okvV36BlyvLnBtb/7y6uNpKDf1hY2I6oCQ7Mnd4w4R5hOTbNlkMw55UVA1tkLD7b3r
         6jOnf5nzSMGvJTK3W9xa8UZrckxriNqYLwrVNYXHrNsxfc1l1vVmrC6vemL4eGQZao
         OMY4IiXDV8T/rE3CeGDzNzMWpj8aSzSkl6Y+tNcTv0lGmmCch18TM6Wq1fBeNbvB0+
         UHUcUtF8Rc1/g==
Message-ID: <c8933c2d806b9859a79957b5ceba12b3f4893596.camel@kernel.org>
Subject: Re: [PATCH] NFSD: reduce code duplication between
 pool_stats_operations and nfsd_rpc_status_operations
From:   Jeff Layton <jlayton@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com, neilb@suse.de
Date:   Tue, 08 Aug 2023 07:40:54 -0400
In-Reply-To: <426191138f5801148a6f7df470ccb59d219452d6.1691481752.git.lorenzo@kernel.org>
References: <426191138f5801148a6f7df470ccb59d219452d6.1691481752.git.lorenzo@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-08-08 at 10:05 +0200, Lorenzo Bianconi wrote:
> Introduce nfsd_stats_open utility routine in order to reduce code
> duplication between pool_stats_operations and
> nfsd_rpc_status_operations.
> Rename nfsd_pool_stats_release in nfsd_stats_release.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  fs/nfsd/nfsctl.c |  4 ++--
>  fs/nfsd/nfsd.h   |  2 +-
>  fs/nfsd/nfssvc.c | 35 ++++++++++++++++++++---------------
>  3 files changed, 23 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 6bf168b6a410..83eb5c6d894e 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -179,7 +179,7 @@ static const struct file_operations pool_stats_operat=
ions =3D {
>  	.open		=3D nfsd_pool_stats_open,
>  	.read		=3D seq_read,
>  	.llseek		=3D seq_lseek,
> -	.release	=3D nfsd_pool_stats_release,
> +	.release	=3D nfsd_stats_release,
>  };
> =20
>  DEFINE_SHOW_ATTRIBUTE(nfsd_reply_cache_stats);
> @@ -200,7 +200,7 @@ static const struct file_operations nfsd_rpc_status_o=
perations =3D {
>  	.open		=3D nfsd_rpc_status_open,
>  	.read		=3D seq_read,
>  	.llseek		=3D seq_lseek,
> -	.release	=3D nfsd_pool_stats_release,
> +	.release	=3D nfsd_stats_release,
>  };
> =20
>  /*
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 38c390fb2cf9..3e8a47b93fd4 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -93,7 +93,7 @@ int		nfsd_nrpools(struct net *);
>  int		nfsd_get_nrthreads(int n, int *, struct net *);
>  int		nfsd_set_nrthreads(int n, int *, struct net *);
>  int		nfsd_pool_stats_open(struct inode *, struct file *);
> -int		nfsd_pool_stats_release(struct inode *, struct file *);
> +int		nfsd_stats_release(struct inode *, struct file *);
>  int		nfsd_rpc_status_open(struct inode *inode, struct file *file);
>  void		nfsd_shutdown_threads(struct net *net);
> =20
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 51a6f7a8d3f7..33ad91dd3a2d 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1079,23 +1079,34 @@ bool nfssvc_encode_voidres(struct svc_rqst *rqstp=
, struct xdr_stream *xdr)
>  	return true;
>  }
> =20
> -int nfsd_pool_stats_open(struct inode *inode, struct file *file)
> +static int nfsd_stats_open(struct inode *inode)
>  {
> -	int ret;
>  	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_id=
);
> =20
>  	mutex_lock(&nfsd_mutex);
> -	if (nn->nfsd_serv =3D=3D NULL) {
> +	if (!nn->nfsd_serv) {
>  		mutex_unlock(&nfsd_mutex);
>  		return -ENODEV;
>  	}
> +
>  	svc_get(nn->nfsd_serv);
> -	ret =3D svc_pool_stats_open(nn->nfsd_serv, file);

Note that svc_pool_stats_open used to be called under the nfsd_mutex and
it won't be after this change. I think that's ok though since you hold a
reference to the serv.

>  	mutex_unlock(&nfsd_mutex);
> -	return ret;
> +
> +	return 0;
>  }
> =20
> -int nfsd_pool_stats_release(struct inode *inode, struct file *file)
> +int nfsd_pool_stats_open(struct inode *inode, struct file *file)
> +{
> +	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_id=
);
> +	int ret =3D nfsd_stats_open(inode);
> +
> +	if (ret)
> +		return ret;
> +
> +	return svc_pool_stats_open(nn->nfsd_serv, file);
> +}
> +
> +int nfsd_stats_release(struct inode *inode, struct file *file)
>  {
>  	int ret =3D seq_release(inode, file);
>  	struct net *net =3D inode->i_sb->s_fs_info;
> @@ -1217,16 +1228,10 @@ static int nfsd_rpc_status_show(struct seq_file *=
m, void *v)
>   */
>  int nfsd_rpc_status_open(struct inode *inode, struct file *file)
>  {
> -	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_id=
);
> +	int ret =3D nfsd_stats_open(inode);
> =20
> -	mutex_lock(&nfsd_mutex);
> -	if (!nn->nfsd_serv) {
> -		mutex_unlock(&nfsd_mutex);
> -		return -ENODEV;
> -	}
> -
> -	svc_get(nn->nfsd_serv);
> -	mutex_unlock(&nfsd_mutex);
> +	if (ret)
> +		return ret;
> =20
>  	return single_open(file, nfsd_rpc_status_show, inode->i_private);
>  }

Meh. I'm not sure this change is really worth it, but it seems to be
correct.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
