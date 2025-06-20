Return-Path: <linux-nfs+bounces-12598-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02527AE1BCE
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 15:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75FF24A81EA
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5962857DE;
	Fri, 20 Jun 2025 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOgl4Rv0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FAA258A
	for <linux-nfs@vger.kernel.org>; Fri, 20 Jun 2025 13:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425231; cv=none; b=L8S7kS99P9Y5ykWBymZHtX5F9dzPDGM194R6iK+Rx4ngkwcFrFwi7dfcaZtIfVlQQhgHtA1VCt0ZUnGkvd9VO2l8LaNBJ06+NyVB3t4O7PUnWQhU/b4+FPeuuAF4iNUczzrQf5KNbS1xtVaTPkezY72OGBwBZ4/6cAJE5EpjYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425231; c=relaxed/simple;
	bh=OM9G71pMJTxuHavcgVR0hmwfr2TB3r3BbJAEeLOm2F8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TcgqW+SESHDFLh+dUcnqmh9/4FOFYkk5O6ylhb9C1pDCGbIesk9RAnfnjKQrh0KnzyIEciwEV00b7m5twjIXv0VbB6Amh3b2+SG+NCS13OsiZjJ06nMPZGtj2hEy2B6ME8U8byaYiRyXV9a8vM81J2TfE2UpnjNBjjh8U0udsWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOgl4Rv0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FB4C4CEEF;
	Fri, 20 Jun 2025 13:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750425231;
	bh=OM9G71pMJTxuHavcgVR0hmwfr2TB3r3BbJAEeLOm2F8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XOgl4Rv0gHjMr/FCvFgrD+P0G7GngN1uiqDPLb974ao2rSHmMp6Nyr6q5NeCmjvxh
	 cs8FHn9BtbMph10raLHjQUa3k3bWztc0YdLf4W+CYckTmp3xVE8z9dAnQMLfVUPML0
	 ePqWkfRGRE+n2o948ts68FbaEAMtEoRKB4yE493gV1aCCUt3bBKOD+rnkoSfM4Jrl/
	 iY5bDmErT5hdKrgwMbGCx7OrSWYzlULXGfP1e4xSkpPP4NS8aRo0UEgGKy6Dtxv0l/
	 6hnhl+0sLue/YNGp1Y0kT5ZF2CgLLlMtBFuvH+inBAM0K0W4+TnDjSxqtJfWBqJxYQ
	 KKKX7FGtaF8gQ==
Message-ID: <5b68f9be179df2f69f8568dc0752b6ed71676f15.camel@kernel.org>
Subject: Re: [PATCH 3/3] nfsd: split nfsd_mutex into one mutex per
 net-namespace.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Li Lingfeng	
 <lilingfeng3@huawei.com>
Date: Fri, 20 Jun 2025 09:13:50 -0400
In-Reply-To: <20250618213347.425503-4-neil@brown.name>
References: <20250618213347.425503-1-neil@brown.name>
	 <20250618213347.425503-4-neil@brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-19 at 07:31 +1000, NeilBrown wrote:
> The remaining uses for nfsd_mutex are all to protect per-netns
> resources.
>=20
> This patch replaces the global mutex with one per netns.  The "svc_info"
> struct now contains that mutex rather than a pointer to the mutex.
>=20
> Macros are provided to make it easy to take the mutex given a file or net=
.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  .../admin-guide/nfs/nfsd-admin-interfaces.rst |   2 +-
>  fs/nfsd/nfsctl.c                              | 113 +++++++++---------
>  fs/nfsd/nfsd.h                                |   1 -
>  fs/nfsd/nfssvc.c                              |  33 ++---
>  include/linux/sunrpc/svc.h                    |   2 +-
>  net/sunrpc/svc_xprt.c                         |   4 +-
>  6 files changed, 72 insertions(+), 83 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst b/Do=
cumentation/admin-guide/nfs/nfsd-admin-interfaces.rst
> index c05926f79054..9548e4ab35b6 100644
> --- a/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
> +++ b/Documentation/admin-guide/nfs/nfsd-admin-interfaces.rst
> @@ -37,4 +37,4 @@ Implementation notes
> =20
>  Note that the rpc server requires the caller to serialize addition and
>  removal of listening sockets, and startup and shutdown of the server.
> -For nfsd this is done using nfsd_mutex.
> +For nfsd this is done using nfsd_info.mutex in struct nfsd_net.
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 3710a1992d17..70eddf2640f0 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -95,6 +95,13 @@ static ssize_t (*const write_op[])(struct file *, char=
 *, size_t) =3D {
>  #endif
>  };
> =20
> +#define	with_nfsd_net_locked(__net)					\
> +	for (struct nfsd_net *__nn =3D net_generic(__net, nfsd_net_id);	\
> +	     __nn ? ({mutex_lock(&__nn->nfsd_info.mutex); 1; }) : 0;	\
> +	     ({mutex_unlock(&__nn->nfsd_info.mutex); __nn =3D NULL;}))
> +#define with_nfsd_file_locked(__file)					\
> +	with_nfsd_net_locked(netns(__file))
> +

This is certainly clever, but I think I'd rather have simple
nfsd_net_mutex_lock/_unlock() functions than have to maintain this sort
of macro.

>  static ssize_t nfsctl_transaction_write(struct file *file, const char __=
user *buf, size_t size, loff_t *pos)
>  {
>  	ino_t ino =3D  file_inode(file)->i_ino;
> @@ -249,9 +256,8 @@ static ssize_t write_unlock_ip(struct file *file, cha=
r *buf, size_t size)
>  {
>  	ssize_t rv;
> =20
> -	mutex_lock(&nfsd_mutex);
> -	rv =3D __write_unlock_ip(file, buf, size);
> -	mutex_unlock(&nfsd_mutex);
> +	with_nfsd_file_locked(file)
> +		rv =3D __write_unlock_ip(file, buf, size);
>  	return rv;
>  }
> =20
> @@ -315,9 +321,8 @@ static ssize_t write_unlock_fs(struct file *file, cha=
r *buf, size_t size)
>  {
>  	ssize_t rv;
> =20
> -	mutex_lock(&nfsd_mutex);
> -	rv =3D __write_unlock_fs(file, buf, size);
> -	mutex_unlock(&nfsd_mutex);
> +	with_nfsd_file_locked(file)
> +		rv =3D __write_unlock_fs(file, buf, size);
>  	return rv;
>  }
> =20
> @@ -440,9 +445,8 @@ static ssize_t write_threads(struct file *file, char =
*buf, size_t size)
>  		if (newthreads < 0)
>  			return -EINVAL;
>  		trace_nfsd_ctl_threads(net, newthreads);
> -		mutex_lock(&nfsd_mutex);
> -		rv =3D nfsd_svc(1, &newthreads, net, file->f_cred, NULL);
> -		mutex_unlock(&nfsd_mutex);
> +		with_nfsd_net_locked(net)
> +			rv =3D nfsd_svc(1, &newthreads, net, file->f_cred, NULL);
>  		if (rv < 0)
>  			return rv;
>  	} else
> @@ -473,7 +477,7 @@ static ssize_t write_threads(struct file *file, char =
*buf, size_t size)
>   *			return code is the size in bytes of the string
>   *	On error:	return code is zero or a negative errno value
>   */
> -static ssize_t write_pool_threads(struct file *file, char *buf, size_t s=
ize)
> +static ssize_t __write_pool_threads(struct file *file, char *buf, size_t=
 size)
>  {
>  	/* if size > 0, look for an array of number of threads per node
>  	 * and apply them  then write out number of threads per node as reply
> @@ -486,7 +490,6 @@ static ssize_t write_pool_threads(struct file *file, =
char *buf, size_t size)
>  	int *nthreads;
>  	struct net *net =3D netns(file);
> =20
> -	mutex_lock(&nfsd_mutex);
>  	npools =3D nfsd_nrpools(net);
>  	if (npools =3D=3D 0) {
>  		/*
> @@ -494,7 +497,6 @@ static ssize_t write_pool_threads(struct file *file, =
char *buf, size_t size)
>  		 * writing to the threads file but NOT the pool_threads
>  		 * file, sorry.  Report zero threads.
>  		 */
> -		mutex_unlock(&nfsd_mutex);
>  		strcpy(buf, "0\n");
>  		return strlen(buf);
>  	}
> @@ -544,10 +546,18 @@ static ssize_t write_pool_threads(struct file *file=
, char *buf, size_t size)
>  	rv =3D mesg - buf;
>  out_free:
>  	kfree(nthreads);
> -	mutex_unlock(&nfsd_mutex);
>  	return rv;
>  }
> =20
> +static ssize_t write_pool_threads(struct file *file, char *buf, size_t s=
ize)
> +{
> +	ssize_t ret;
> +
> +	with_nfsd_file_locked(file)
> +		ret =3D __write_pool_threads(file, buf, size);
> +	return ret;
> +}
> +
>  static ssize_t
>  nfsd_print_version_support(struct nfsd_net *nn, char *buf, int remaining=
,
>  		const char *sep, unsigned vers, int minor)
> @@ -709,9 +719,9 @@ static ssize_t write_versions(struct file *file, char=
 *buf, size_t size)
>  {
>  	ssize_t rv;
> =20
> -	mutex_lock(&nfsd_mutex);
> -	rv =3D __write_versions(file, buf, size);
> -	mutex_unlock(&nfsd_mutex);
> +	with_nfsd_file_locked(file)
> +		rv =3D __write_versions(file, buf, size);
> +
>  	return rv;
>  }
> =20
> @@ -868,9 +878,8 @@ static ssize_t write_ports(struct file *file, char *b=
uf, size_t size)
>  {
>  	ssize_t rv;
> =20
> -	mutex_lock(&nfsd_mutex);
> -	rv =3D __write_ports(file, buf, size, netns(file));
> -	mutex_unlock(&nfsd_mutex);
> +	with_nfsd_file_locked(file)
> +		rv =3D __write_ports(file, buf, size, netns(file));
>  	return rv;
>  }
> =20
> @@ -916,13 +925,13 @@ static ssize_t write_maxblksize(struct file *file, =
char *buf, size_t size)
>  		bsize =3D max_t(int, bsize, 1024);
>  		bsize =3D min_t(int, bsize, NFSSVC_MAXBLKSIZE);
>  		bsize &=3D ~(1024-1);
> -		mutex_lock(&nfsd_mutex);
> +		mutex_lock(&nn->nfsd_info.mutex);
>  		if (nn->nfsd_serv) {
> -			mutex_unlock(&nfsd_mutex);
> +			mutex_unlock(&nn->nfsd_info.mutex);
>  			return -EBUSY;
>  		}
>  		nfsd_max_blksize =3D bsize;
> -		mutex_unlock(&nfsd_mutex);
> +		mutex_unlock(&nn->nfsd_info.mutex);
>  	}
> =20
>  	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%d\n",
> @@ -971,9 +980,8 @@ static ssize_t nfsd4_write_time(struct file *file, ch=
ar *buf, size_t size,
>  {
>  	ssize_t rv;
> =20
> -	mutex_lock(&nfsd_mutex);
> -	rv =3D __nfsd4_write_time(file, buf, size, time, nn);
> -	mutex_unlock(&nfsd_mutex);
> +	with_nfsd_file_locked(file)
> +		rv =3D __nfsd4_write_time(file, buf, size, time, nn);
>  	return rv;
>  }
> =20
> @@ -1076,9 +1084,8 @@ static ssize_t write_recoverydir(struct file *file,=
 char *buf, size_t size)
>  	ssize_t rv;
>  	struct nfsd_net *nn =3D net_generic(netns(file), nfsd_net_id);
> =20
> -	mutex_lock(&nfsd_mutex);
> -	rv =3D __write_recoverydir(file, buf, size, nn);
> -	mutex_unlock(&nfsd_mutex);
> +	with_nfsd_file_locked(file)
> +		rv =3D __write_recoverydir(file, buf, size, nn);
>  	return rv;
>  }
>  #endif
> @@ -1130,9 +1137,8 @@ static ssize_t write_v4_end_grace(struct file *file=
, char *buf, size_t size)
>  {
>  	ssize_t rv;
> =20
> -	mutex_lock(&nfsd_mutex);
> -	rv =3D __write_v4_end_grace(file, buf, size);
> -	mutex_unlock(&nfsd_mutex);
> +	with_nfsd_file_locked(file)
> +		rv =3D __write_v4_end_grace(file, buf, size);
>  	return rv;
>  }
>  #endif
> @@ -1552,9 +1558,8 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *s=
kb,
>  	int i, ret, rqstp_index =3D 0;
>  	struct nfsd_net *nn;
> =20
> -	mutex_lock(&nfsd_mutex);
> -
>  	nn =3D net_generic(sock_net(skb->sk), nfsd_net_id);
> +	mutex_lock(&nn->nfsd_info.mutex);
>  	if (!nn->nfsd_serv) {
>  		ret =3D -ENODEV;
>  		goto out_unlock;
> @@ -1636,7 +1641,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *s=
kb,
>  out:
>  	rcu_read_unlock();
>  out_unlock:
> -	mutex_unlock(&nfsd_mutex);
> +	mutex_unlock(&nn->nfsd_info.mutex);
> =20
>  	return ret;
>  }
> @@ -1665,7 +1670,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, s=
truct genl_info *info)
>  			count++;
>  	}
> =20
> -	mutex_lock(&nfsd_mutex);
> +	mutex_lock(&nn->nfsd_info.mutex);
> =20
>  	nrpools =3D max(count, nfsd_nrpools(net));
>  	nthreads =3D kcalloc(nrpools, sizeof(int), GFP_KERNEL);
> @@ -1720,7 +1725,7 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, s=
truct genl_info *info)
>  	if (ret > 0)
>  		ret =3D 0;
>  out_unlock:
> -	mutex_unlock(&nfsd_mutex);
> +	mutex_unlock(&nn->nfsd_info.mutex);
>  	kfree(nthreads);
>  	return ret;
>  }
> @@ -1749,7 +1754,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, s=
truct genl_info *info)
>  		goto err_free_msg;
>  	}
> =20
> -	mutex_lock(&nfsd_mutex);
> +	mutex_lock(&nn->nfsd_info.mutex);
> =20
>  	err =3D nla_put_u32(skb, NFSD_A_SERVER_GRACETIME,
>  			  nn->nfsd4_grace) ||
> @@ -1777,14 +1782,14 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb,=
 struct genl_info *info)
>  			goto err_unlock;
>  	}
> =20
> -	mutex_unlock(&nfsd_mutex);
> +	mutex_unlock(&nn->nfsd_info.mutex);
> =20
>  	genlmsg_end(skb, hdr);
> =20
>  	return genlmsg_reply(skb, info);
> =20
>  err_unlock:
> -	mutex_unlock(&nfsd_mutex);
> +	mutex_unlock(&nn->nfsd_info.mutex);
>  err_free_msg:
>  	nlmsg_free(skb);
> =20
> @@ -1807,11 +1812,10 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb,=
 struct genl_info *info)
>  	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_PROTO_VERSION))
>  		return -EINVAL;
> =20
> -	mutex_lock(&nfsd_mutex);
> -
>  	nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> +	mutex_lock(&nn->nfsd_info.mutex);
>  	if (nn->nfsd_serv) {
> -		mutex_unlock(&nfsd_mutex);
> +		mutex_unlock(&nn->nfsd_info.mutex);
>  		return -EBUSY;
>  	}
> =20
> @@ -1856,7 +1860,7 @@ int nfsd_nl_version_set_doit(struct sk_buff *skb, s=
truct genl_info *info)
>  		}
>  	}
> =20
> -	mutex_unlock(&nfsd_mutex);
> +	mutex_unlock(&nn->nfsd_info.mutex);
> =20
>  	return 0;
>  }
> @@ -1884,7 +1888,7 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, s=
truct genl_info *info)
>  		goto err_free_msg;
>  	}
> =20
> -	mutex_lock(&nfsd_mutex);
> +	mutex_lock(&nn->nfsd_info.mutex);
>  	nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> =20
>  	for (i =3D 2; i <=3D 4; i++) {
> @@ -1928,13 +1932,13 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb,=
 struct genl_info *info)
>  		}
>  	}
> =20
> -	mutex_unlock(&nfsd_mutex);
> +	mutex_unlock(&nn->nfsd_info.mutex);
>  	genlmsg_end(skb, hdr);
> =20
>  	return genlmsg_reply(skb, info);
> =20
>  err_nfsd_unlock:
> -	mutex_unlock(&nfsd_mutex);
> +	mutex_unlock(&nn->nfsd_info.mutex);
>  err_free_msg:
>  	nlmsg_free(skb);
> =20
> @@ -1959,15 +1963,16 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb=
, struct genl_info *info)
>  	bool delete =3D false;
>  	int err, rem;
> =20
> -	mutex_lock(&nfsd_mutex);
> +	nn =3D net_generic(net, nfsd_net_id);
> +
> +	mutex_lock(&nn->nfsd_info.mutex);
> =20
>  	err =3D nfsd_create_serv(net);
>  	if (err) {
> -		mutex_unlock(&nfsd_mutex);
> +		mutex_unlock(&nn->nfsd_info.mutex);
>  		return err;
>  	}
> =20
> -	nn =3D net_generic(net, nfsd_net_id);
>  	serv =3D nn->nfsd_serv;
> =20
>  	spin_lock_bh(&serv->sv_lock);
> @@ -2083,7 +2088,7 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, =
struct genl_info *info)
>  		nfsd_destroy_serv(net);
> =20
>  out_unlock_mtx:
> -	mutex_unlock(&nfsd_mutex);
> +	mutex_unlock(&nn->nfsd_info.mutex);
> =20
>  	return err;
>  }
> @@ -2113,8 +2118,8 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb, =
struct genl_info *info)
>  		goto err_free_msg;
>  	}
> =20
> -	mutex_lock(&nfsd_mutex);
>  	nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> +	mutex_lock(&nn->nfsd_info.mutex);
> =20
>  	/* no nfs server? Just send empty socket list */
>  	if (!nn->nfsd_serv)
> @@ -2144,14 +2149,14 @@ int nfsd_nl_listener_get_doit(struct sk_buff *skb=
, struct genl_info *info)
>  	}
>  	spin_unlock_bh(&serv->sv_lock);
>  out_unlock_mtx:
> -	mutex_unlock(&nfsd_mutex);
> +	mutex_unlock(&nn->nfsd_info.mutex);
>  	genlmsg_end(skb, hdr);
> =20
>  	return genlmsg_reply(skb, info);
> =20
>  err_serv_unlock:
>  	spin_unlock_bh(&serv->sv_lock);
> -	mutex_unlock(&nfsd_mutex);
> +	mutex_unlock(&nn->nfsd_info.mutex);
>  err_free_msg:
>  	nlmsg_free(skb);
> =20
> @@ -2253,7 +2258,7 @@ static __net_init int nfsd_net_init(struct net *net=
)
>  		nn->nfsd_versions[i] =3D nfsd_support_version(i);
>  	for (i =3D 0; i < sizeof(nn->nfsd4_minorversions); i++)
>  		nn->nfsd4_minorversions[i] =3D nfsd_support_version(4);
> -	nn->nfsd_info.mutex =3D &nfsd_mutex;
> +	mutex_init(&nn->nfsd_info.mutex);
>  	nn->nfsd_serv =3D NULL;
>  	nfsd4_init_leases_net(nn);
>  	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 8ad9fcc23789..3cbca4d34f48 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -77,7 +77,6 @@ struct nfsd_genl_rqstp {
> =20
>  extern struct svc_program	nfsd_programs[];
>  extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_versi=
on4;
> -extern struct mutex		nfsd_mutex;
>  extern atomic_t			nfsd_th_cnt;		/* number of available threads */
> =20
>  bool nfsd_startup_get(void);
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index b2080e5a71e6..9f70b1fbc55e 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -56,20 +56,6 @@ static __be32			nfsd_init_request(struct svc_rqst *,
>  						const struct svc_program *,
>  						struct svc_process_info *);
> =20
> -/*
> - * nfsd_mutex protects nn->nfsd_serv -- both the pointer itself and some=
 members
> - * of the svc_serv struct such as ->sv_temp_socks and ->sv_permsocks.
> - *
> - * Finally, the nfsd_mutex also protects some of the global variables th=
at are
> - * accessed when nfsd starts and that are settable via the write_* routi=
nes in
> - * nfsctl.c. In particular:
> - *
> - *	user_recovery_dirname
> - *	user_lease_time
> - *	nfsd_versions
> - */
> -DEFINE_MUTEX(nfsd_mutex);
> -
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  static const struct svc_version *localio_versions[] =3D {
>  	[1] =3D &localio_version1,
> @@ -242,10 +228,10 @@ int nfsd_nrthreads(struct net *net)
>  	int rv =3D 0;
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
> -	mutex_lock(&nfsd_mutex);
> +	mutex_lock(&nn->nfsd_info.mutex);
>  	if (nn->nfsd_serv)
>  		rv =3D nn->nfsd_serv->sv_nrthreads;
> -	mutex_unlock(&nfsd_mutex);
> +	mutex_unlock(&nn->nfsd_info.mutex);
>  	return rv;
>  }
> =20
> @@ -522,7 +508,6 @@ static struct notifier_block nfsd_inet6addr_notifier =
=3D {
>  };
>  #endif
> =20
> -/* Only used under nfsd_mutex, so this atomic may be overkill: */
>  static atomic_t nfsd_notifier_refcount =3D ATOMIC_INIT(0);
> =20
>  /**
> @@ -534,7 +519,7 @@ void nfsd_destroy_serv(struct net *net)
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv =3D nn->nfsd_serv;
> =20
> -	lockdep_assert_held(&nfsd_mutex);
> +	lockdep_assert_held(&nn->nfsd_info.mutex);
> =20
>  	spin_lock(&nfsd_notifier_lock);
>  	nn->nfsd_serv =3D NULL;
> @@ -606,17 +591,17 @@ void nfsd_shutdown_threads(struct net *net)
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv;
> =20
> -	mutex_lock(&nfsd_mutex);
> +	mutex_lock(&nn->nfsd_info.mutex);
>  	serv =3D nn->nfsd_serv;
>  	if (serv =3D=3D NULL) {
> -		mutex_unlock(&nfsd_mutex);
> +		mutex_unlock(&nn->nfsd_info.mutex);
>  		return;
>  	}
> =20
>  	/* Kill outstanding nfsd threads */
>  	svc_set_num_threads(serv, NULL, 0);
>  	nfsd_destroy_serv(net);
> -	mutex_unlock(&nfsd_mutex);
> +	mutex_unlock(&nn->nfsd_info.mutex);
>  }
> =20
>  struct svc_rqst *nfsd_current_rqst(void)
> @@ -632,7 +617,7 @@ int nfsd_create_serv(struct net *net)
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv;
> =20
> -	WARN_ON(!mutex_is_locked(&nfsd_mutex));
> +	WARN_ON(!mutex_is_locked(&nn->nfsd_info.mutex));
>  	if (nn->nfsd_serv)
>  		return 0;
> =20
> @@ -714,7 +699,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct n=
et *net)
>  	int err =3D 0;
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
> -	lockdep_assert_held(&nfsd_mutex);
> +	lockdep_assert_held(&nn->nfsd_info.mutex);
> =20
>  	if (nn->nfsd_serv =3D=3D NULL || n <=3D 0)
>  		return 0;
> @@ -787,7 +772,7 @@ nfsd_svc(int n, int *nthreads, struct net *net, const=
 struct cred *cred, const c
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
>  	struct svc_serv *serv;
> =20
> -	lockdep_assert_held(&nfsd_mutex);
> +	lockdep_assert_held(&nn->nfsd_info.mutex);
> =20
>  	dprintk("nfsd: creating service\n");
> =20
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 48666b83fe68..a12fe99156ec 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -98,7 +98,7 @@ struct svc_serv {
>  /* This is used by pool_stats to find and lock an svc */
>  struct svc_info {
>  	struct svc_serv		*serv;
> -	struct mutex		*mutex;
> +	struct mutex		mutex;

I know we haven't been good about it with this struct so far, but I
like prefixes on names like this. Maybe we can call this "si_mutex" ?

>  };
> =20
>  void svc_destroy(struct svc_serv **svcp);
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 8b1837228799..b8352b7d6860 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -1399,7 +1399,7 @@ static void *svc_pool_stats_start(struct seq_file *=
m, loff_t *pos)
> =20
>  	dprintk("svc_pool_stats_start, *pidx=3D%u\n", pidx);
> =20
> -	mutex_lock(si->mutex);
> +	mutex_lock(&si->mutex);
> =20
>  	if (!pidx)
>  		return SEQ_START_TOKEN;
> @@ -1436,7 +1436,7 @@ static void svc_pool_stats_stop(struct seq_file *m,=
 void *p)
>  {
>  	struct svc_info *si =3D m->private;
> =20
> -	mutex_unlock(si->mutex);
> +	mutex_unlock(&si->mutex);
>  }
> =20
>  static int svc_pool_stats_show(struct seq_file *m, void *p)

All that said, I definitely support making this mutex per-net.

--=20
Jeff Layton <jlayton@kernel.org>

