Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007AD7DBA39
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Oct 2023 14:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjJ3NBm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Oct 2023 09:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjJ3NBl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Oct 2023 09:01:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CD1C2
        for <linux-nfs@vger.kernel.org>; Mon, 30 Oct 2023 06:01:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A97C433C8;
        Mon, 30 Oct 2023 13:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698670898;
        bh=BOJZK7lhmBrXGPpgUYtW+3ey+APWpK/RPaufQQ3/DWc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CDOwAR0YEq4ABrhGiWnk9Kg38ON4APGpveLjZ7peTOuJze5/ugLlgJrKRuYVkGjFJ
         8VKRLj/blwxi7jEOT1m/67YgxgfVr6n4CwIHFzEzzrFZ6mcha0zPl2k8UV0W5J4gY/
         pUPtcjcU9PhxjjOY47AY6TR1eZhsGfbOetsURKbCZmI+fjJSOhwbbkUU5dWAF+KutG
         dkINA8MNvVsICwTQWA1GTePdqZxsj+ircIIDhIGZ/WstL7IkXU3IXt4T/He/wZBa1o
         nNwV3Jr1HYZ3BO8HcBlUCXLWfcgGnWwWPniUqBjpAC1wO8dIxSQsm00vZt4nCUZ1Cv
         DN06TzvSRB6vQ==
Message-ID: <84354fd30d4b4a162b008067ad4e0d35a7d223da.camel@kernel.org>
Subject: Re: [PATCH 2/5] svc: don't hold reference for poolstats, only mutex.
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Mon, 30 Oct 2023 09:01:36 -0400
In-Reply-To: <20231030011247.9794-3-neilb@suse.de>
References: <20231030011247.9794-1-neilb@suse.de>
         <20231030011247.9794-3-neilb@suse.de>
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
> A future patch will remove refcounting on svc_serv as it is of little
> use.
> It is currently used to keep the svc around while the pool_stats file is
> open.
> Change this to get the pointer, protected by the mutex, only in
> seq_start, and the release the mutex in seq_stop.
> This means that if the nfsd server is stopped and restarted while the
> pool_stats file it open, then some pool stats info could be from the
> first instance and some from the second.  This might appear odd, but is
> unlikely to be a problem in practice.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfsctl.c           |  2 +-
>  fs/nfsd/nfssvc.c           | 30 ++++++++---------------
>  include/linux/sunrpc/svc.h |  5 +++-
>  net/sunrpc/svc_xprt.c      | 49 ++++++++++++++++++++++++++++++++------
>  4 files changed, 57 insertions(+), 29 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 79efb1075f38..d78ae4452946 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -179,7 +179,7 @@ static const struct file_operations pool_stats_operat=
ions =3D {
>  	.open		=3D nfsd_pool_stats_open,
>  	.read		=3D seq_read,
>  	.llseek		=3D seq_lseek,
> -	.release	=3D nfsd_pool_stats_release,
> +	.release	=3D svc_pool_stats_release,
>  };
> =20
>  DEFINE_SHOW_ATTRIBUTE(nfsd_reply_cache_stats);
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 6c968c02cc29..203e1cfc1cad 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -1072,30 +1072,20 @@ bool nfssvc_encode_voidres(struct svc_rqst *rqstp=
, struct xdr_stream *xdr)
>  	return true;
>  }
> =20
> -int nfsd_pool_stats_open(struct inode *inode, struct file *file)
> +static struct svc_serv *nfsd_get_serv(struct seq_file *s, bool start)
>  {
> -	int ret;
> -	struct nfsd_net *nn =3D net_generic(inode->i_sb->s_fs_info, nfsd_net_id=
);
> -
> -	mutex_lock(&nfsd_mutex);
> -	if (nn->nfsd_serv =3D=3D NULL) {
> +	struct nfsd_net *nn =3D net_generic(file_inode(s->file)->i_sb->s_fs_inf=
o,
> +					  nfsd_net_id);
> +	if (start) {
> +		mutex_lock(&nfsd_mutex);
> +		return nn->nfsd_serv;
> +	} else {
>  		mutex_unlock(&nfsd_mutex);
> -		return -ENODEV;
> +		return NULL;
>  	}
> -	svc_get(nn->nfsd_serv);
> -	ret =3D svc_pool_stats_open(nn->nfsd_serv, file);
> -	mutex_unlock(&nfsd_mutex);
> -	return ret;
>  }
> =20
> -int nfsd_pool_stats_release(struct inode *inode, struct file *file)
> +int nfsd_pool_stats_open(struct inode *inode, struct file *file)
>  {
> -	struct seq_file *seq =3D file->private_data;
> -	struct svc_serv *serv =3D seq->private;
> -	int ret =3D seq_release(inode, file);
> -
> -	mutex_lock(&nfsd_mutex);
> -	svc_put(serv);
> -	mutex_unlock(&nfsd_mutex);
> -	return ret;
> +	return svc_pool_stats_open(nfsd_get_serv, file);
>  }
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index b10f987509cc..11acad6988a2 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -433,7 +433,10 @@ void		   svc_exit_thread(struct svc_rqst *);
>  struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
>  				     int (*threadfn)(void *data));
>  int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
> -int		   svc_pool_stats_open(struct svc_serv *serv, struct file *file);
> +int		   svc_pool_stats_open(struct svc_serv *(*get_serv)(struct seq_file=
 *, bool),
> +				       struct file *file);
> +int		   svc_pool_stats_release(struct inode *inode,
> +					  struct file *file);
>  void		   svc_process(struct svc_rqst *rqstp);
>  void		   svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp);
>  int		   svc_register(const struct svc_serv *, struct net *, const int,
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index fee83d1024bc..2f99f7475b7b 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -1366,26 +1366,38 @@ EXPORT_SYMBOL_GPL(svc_xprt_names);
> =20
>  /*----------------------------------------------------------------------=
------*/
> =20
> +struct pool_private {
> +	struct svc_serv *(*get_serv)(struct seq_file *, bool);

This bool is pretty ugly. I think I'd rather see two operations here
(get_serv/put_serv). Also, this could use a kerneldoc comment.

> +	struct svc_serv *serv;
> +};
> +
>  static void *svc_pool_stats_start(struct seq_file *m, loff_t *pos)
>  {
>  	unsigned int pidx =3D (unsigned int)*pos;
> -	struct svc_serv *serv =3D m->private;
> +	struct pool_private *pp =3D m->private;
> =20
>  	dprintk("svc_pool_stats_start, *pidx=3D%u\n", pidx);
> =20
> +	pp->serv =3D pp->get_serv(m, true);
> +
>  	if (!pidx)
>  		return SEQ_START_TOKEN;
> -	return (pidx > serv->sv_nrpools ? NULL : &serv->sv_pools[pidx-1]);
> +	if (!pp->serv)
> +		return NULL;
> +	return (pidx > pp->serv->sv_nrpools ? NULL : &pp->serv->sv_pools[pidx-1=
]);
>  }
> =20
>  static void *svc_pool_stats_next(struct seq_file *m, void *p, loff_t *po=
s)
>  {
>  	struct svc_pool *pool =3D p;
> -	struct svc_serv *serv =3D m->private;
> +	struct pool_private *pp =3D m->private;
> +	struct svc_serv *serv =3D pp->serv;
> =20
>  	dprintk("svc_pool_stats_next, *pos=3D%llu\n", *pos);
> =20
> -	if (p =3D=3D SEQ_START_TOKEN) {
> +	if (!serv) {
> +		pool =3D NULL;
> +	} else if (p =3D=3D SEQ_START_TOKEN) {
>  		pool =3D &serv->sv_pools[0];
>  	} else {
>  		unsigned int pidx =3D (pool - &serv->sv_pools[0]);
> @@ -1400,6 +1412,9 @@ static void *svc_pool_stats_next(struct seq_file *m=
, void *p, loff_t *pos)
> =20
>  static void svc_pool_stats_stop(struct seq_file *m, void *p)
>  {
> +	struct pool_private *pp =3D m->private;
> +
> +	pp->get_serv(m, false);
>  }
> =20
>  static int svc_pool_stats_show(struct seq_file *m, void *p)
> @@ -1427,15 +1442,35 @@ static const struct seq_operations svc_pool_stats=
_seq_ops =3D {
>  	.show	=3D svc_pool_stats_show,
>  };
> =20
> -int svc_pool_stats_open(struct svc_serv *serv, struct file *file)
> +int svc_pool_stats_open(struct svc_serv *(*get_serv)(struct seq_file *, =
bool),
> +			struct file *file)
>  {
> +	struct pool_private *pp;
>  	int err;
> =20
> +	pp =3D kmalloc(sizeof(*pp), GFP_KERNEL);
> +	if (!pp)
> +		return -ENOMEM;
> +
>  	err =3D seq_open(file, &svc_pool_stats_seq_ops);
> -	if (!err)
> -		((struct seq_file *) file->private_data)->private =3D serv;
> +	if (!err) {
> +		pp->get_serv =3D get_serv;
> +		((struct seq_file *) file->private_data)->private =3D pp;
> +	} else
> +		kfree(pp);
> +
>  	return err;
>  }
>  EXPORT_SYMBOL(svc_pool_stats_open);
> =20
> +int svc_pool_stats_release(struct inode *inode, struct file *file)
> +{
> +	struct seq_file *seq =3D file->private_data;
> +
> +	kfree(seq->private);
> +	seq->private =3D NULL;
> +	return seq_release(inode, file);
> +}
> +EXPORT_SYMBOL(svc_pool_stats_release);
> +
>  /*----------------------------------------------------------------------=
------*/

--=20
Jeff Layton <jlayton@kernel.org>
