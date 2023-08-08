Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6539D7741F8
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Aug 2023 19:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjHHRbd (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Aug 2023 13:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjHHRaj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Aug 2023 13:30:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4529B8DCCA
        for <linux-nfs@vger.kernel.org>; Tue,  8 Aug 2023 09:13:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 18F1C21BE0;
        Tue,  8 Aug 2023 11:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691493941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5fyh1qO7SWX3LJT/N3lj8tTpVeUj5DV4o4IoXfpXJBo=;
        b=uASV0L0epd6REW7s4AppzI3mcR1bjZnmk04HErVgDHF6TsepMyQBH9l81JKlV6jslcT8Wu
        hL+VblZV3KJobbrkRR1wZO9L1A3supxAxBi/BhHEc5QJer4ZWLIaP5iXN0FPinUz5+BfmS
        mvudl6g81VD3GkMQesaFWxXN65NQDWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691493941;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5fyh1qO7SWX3LJT/N3lj8tTpVeUj5DV4o4IoXfpXJBo=;
        b=YBl+amNCVJsLpPkV8sDSDWiwka8LzAwKsEbsAs4+UvL2dMNhcwo6EAHdzW3v2vJDtuAowH
        OUcdCm/MKNDifeBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3848513451;
        Tue,  8 Aug 2023 11:25:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kVArNzIm0mT6UgAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 08 Aug 2023 11:25:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc:     linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
        chuck.lever@oracle.com, jlayton@kernel.org
Subject: Re: [PATCH] NFSD: reduce code duplication between
 pool_stats_operations and nfsd_rpc_status_operations
In-reply-to: <426191138f5801148a6f7df470ccb59d219452d6.1691481752.git.lorenzo@kernel.org>
References: <426191138f5801148a6f7df470ccb59d219452d6.1691481752.git.lorenzo@kernel.org>
Date:   Tue, 08 Aug 2023 21:25:33 +1000
Message-id: <169149393339.32308.3848599313522448037@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 08 Aug 2023, Lorenzo Bianconi wrote:
> Introduce nfsd_stats_open utility routine in order to reduce code
> duplication between pool_stats_operations and
> nfsd_rpc_status_operations.
> Rename nfsd_pool_stats_release in nfsd_stats_release.

Looks good.
I was imagining going one step further and having only one 'struct
file_operations' for both files similar to how 'transaction_ops' is used
for multiple different files.  Maybe that isn't necessary..

Reviewed-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown

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
> @@ -179,7 +179,7 @@ static const struct file_operations pool_stats_operatio=
ns =3D {
>  	.open		=3D nfsd_pool_stats_open,
>  	.read		=3D seq_read,
>  	.llseek		=3D seq_lseek,
> -	.release	=3D nfsd_pool_stats_release,
> +	.release	=3D nfsd_stats_release,
>  };
> =20
>  DEFINE_SHOW_ATTRIBUTE(nfsd_reply_cache_stats);
> @@ -200,7 +200,7 @@ static const struct file_operations nfsd_rpc_status_ope=
rations =3D {
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
> @@ -1079,23 +1079,34 @@ bool nfssvc_encode_voidres(struct svc_rqst *rqstp, =
struct xdr_stream *xdr)
>  	return true;
>  }
> =20
> -int nfsd_pool_stats_open(struct inode *inode, struct file *file)
> +static int nfsd_stats_open(struct inode *inode)
>  {
> -	int ret;
>  	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
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
>  	mutex_unlock(&nfsd_mutex);
> -	return ret;
> +
> +	return 0;
>  }
> =20
> -int nfsd_pool_stats_release(struct inode *inode, struct file *file)
> +int nfsd_pool_stats_open(struct inode *inode, struct file *file)
> +{
> +	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
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
> @@ -1217,16 +1228,10 @@ static int nfsd_rpc_status_show(struct seq_file *m,=
 void *v)
>   */
>  int nfsd_rpc_status_open(struct inode *inode, struct file *file)
>  {
> -	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_id);
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
> --=20
> 2.41.0
>=20
>=20

