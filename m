Return-Path: <linux-nfs+bounces-492-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B671B80D9B3
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 19:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386B91F2193C
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 18:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A3651C59;
	Mon, 11 Dec 2023 18:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teP89eo+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90ED321B8;
	Mon, 11 Dec 2023 18:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE5AC433C8;
	Mon, 11 Dec 2023 18:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702320970;
	bh=AhEJzLRNnF//o4btxFf0wfbAQQHwZk8WnH6CwtL7800=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=teP89eo+VeXm53rwGkHXfMmtwmasOUG3QbsYR4NBrG4Rq84F+KjyBxOJWn3Nn0AAE
	 mNBd2W+g7Tuzstztn7467Kn5vDUgR9t0CVtn/0Pp/77KlRsiQae48Fwh+19ojTrvvZ
	 s/yRv6dKeGlfx6WwFVyFm4chsBKUg1tL+rHq9V19bV03YR42EUCcwnHbWKor6Zi3wr
	 84H5H8BqHwESkSoAfvLPQqvZ6SGWGj0HNqz3xbU5ju5LMDVX2h550voQ5vZhJPKyQh
	 SMg++pbz8nrnBwL+yZ6d3QcIcv8z93DQuJs/i/tBS58rC8Rdkl8FiQ1HjSqZvU/vYQ
	 IABVkR4x8XRiw==
Message-ID: <a30b00df8b40ca94d0ff243c0305f36c7cbafc43.camel@kernel.org>
Subject: Re: [PATCH v8 3/3] NFSD: add rpc_status netlink support
From: Jeff Layton <jlayton@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, chuck.lever@oracle.com, neilb@suse.de, 
	netdev@vger.kernel.org
Date: Mon, 11 Dec 2023 13:56:08 -0500
In-Reply-To: <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
References: <cover.1694436263.git.lorenzo@kernel.org>
	 <ac18892ea3f718c63f0a12e39aeaac812c081515.1694436263.git.lorenzo@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-09-11 at 14:49 +0200, Lorenzo Bianconi wrote:
> Introduce rpc_status netlink support for NFSD in order to dump pending
> RPC requests debugging information from userspace.
>=20
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  fs/nfsd/nfsctl.c           | 192 ++++++++++++++++++++++++++++++++++++-
>  fs/nfsd/nfsd.h             |  16 ++++
>  fs/nfsd/nfssvc.c           |  15 +++
>  fs/nfsd/state.h            |   2 -
>  include/linux/sunrpc/svc.h |   1 +
>  5 files changed, 222 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 1be66088849c..b862a759ea15 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -26,6 +26,7 @@
>  #include "pnfs.h"
>  #include "filecache.h"
>  #include "trace.h"
> +#include "nfs_netlink_gen.h"
> =20
>  /*
>   *	We have a single directory with several nodes in it.
> @@ -1497,17 +1498,199 @@ unsigned int nfsd_net_id;
> =20
>  int nfsd_server_nl_rpc_status_get_start(struct netlink_callback *cb)
>  {
> -	return 0;
> +	struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net_id)=
;
> +	int ret =3D -ENODEV;
> +
> +	mutex_lock(&nfsd_mutex);
> +	if (nn->nfsd_serv) {
> +		svc_get(nn->nfsd_serv);
> +		ret =3D 0;
> +	}
> +	mutex_unlock(&nfsd_mutex);
> +
> +	return ret;
>  }

I think there is a potential race above. Once you've dropped the
nfsd_mutex, there is no guarantee that the nn->nfsd_serv will still be
set when you come back to put the serv. That means that we could oops
when we hit the _done method below.

Is it possible to stash a pointer to the serv while we hold the
reference?

> =20
> -int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb)
> +static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
> +					    struct netlink_callback *cb,
> +					    struct nfsd_genl_rqstp *rqstp)
>  {
> +	void *hdr;
> +	int i;
> +
> +	hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq=
,
> +			  &nfsd_server_nl_family, NLM_F_MULTI,
> +			  NFSD_CMD_RPC_STATUS_GET);
> +	if (!hdr)
> +		return -ENOBUFS;
> +
> +	if (nla_put_be32(skb, NFSD_ATTR_RPC_STATUS_XID, rqstp->rq_xid) ||
> +	    nla_put_u32(skb, NFSD_ATTR_RPC_STATUS_FLAGS, rqstp->rq_flags) ||
> +	    nla_put_u32(skb, NFSD_ATTR_RPC_STATUS_PROG, rqstp->rq_prog) ||
> +	    nla_put_u32(skb, NFSD_ATTR_RPC_STATUS_PROC, rqstp->rq_proc) ||
> +	    nla_put_u8(skb, NFSD_ATTR_RPC_STATUS_VERSION, rqstp->rq_vers) ||
> +	    nla_put_s64(skb, NFSD_ATTR_RPC_STATUS_SERVICE_TIME,
> +			ktime_to_us(rqstp->rq_stime),
> +			NFSD_ATTR_RPC_STATUS_PAD))
> +		return -ENOBUFS;
> +
> +	switch (rqstp->saddr.sa_family) {
> +	case AF_INET: {
> +		const struct sockaddr_in *s_in, *d_in;
> +
> +		s_in =3D (const struct sockaddr_in *)&rqstp->saddr;
> +		d_in =3D (const struct sockaddr_in *)&rqstp->daddr;
> +		if (nla_put_in_addr(skb, NFSD_ATTR_RPC_STATUS_SADDR4,
> +				    s_in->sin_addr.s_addr) ||
> +		    nla_put_in_addr(skb, NFSD_ATTR_RPC_STATUS_DADDR4,
> +				    d_in->sin_addr.s_addr) ||
> +		    nla_put_be16(skb, NFSD_ATTR_RPC_STATUS_SPORT,
> +				 s_in->sin_port) ||
> +		    nla_put_be16(skb, NFSD_ATTR_RPC_STATUS_DPORT,
> +				 d_in->sin_port))
> +			return -ENOBUFS;
> +		break;
> +	}
> +	case AF_INET6: {
> +		const struct sockaddr_in6 *s_in, *d_in;
> +
> +		s_in =3D (const struct sockaddr_in6 *)&rqstp->saddr;
> +		d_in =3D (const struct sockaddr_in6 *)&rqstp->daddr;
> +		if (nla_put_in6_addr(skb, NFSD_ATTR_RPC_STATUS_SADDR6,
> +				     &s_in->sin6_addr) ||
> +		    nla_put_in6_addr(skb, NFSD_ATTR_RPC_STATUS_DADDR6,
> +				     &d_in->sin6_addr) ||
> +		    nla_put_be16(skb, NFSD_ATTR_RPC_STATUS_SPORT,
> +				 s_in->sin6_port) ||
> +		    nla_put_be16(skb, NFSD_ATTR_RPC_STATUS_DPORT,
> +				 d_in->sin6_port))
> +			return -ENOBUFS;
> +		break;
> +	}
> +	default:
> +		break;
> +	}
> +
> +	if (rqstp->opcnt) {
> +		struct nlattr *attr;
> +
> +		attr =3D nla_nest_start(skb, NFSD_ATTR_RPC_STATUS_COMPOND_OP);
> +		if (!attr)
> +			return -ENOBUFS;
> +
> +		for (i =3D 0; i < rqstp->opcnt; i++) {
> +			struct nlattr *op_attr;
> +
> +			op_attr =3D nla_nest_start(skb, i);
> +			if (!op_attr)
> +				return -ENOBUFS;
> +
> +			if (nla_put_u32(skb, NFSD_ATTR_RPC_STATUS_COMP_OP,
> +					rqstp->opnum[i]))
> +				return -ENOBUFS;
> +
> +			nla_nest_end(skb, op_attr);
> +		}
> +
> +		nla_nest_end(skb, attr);
> +	}
> +
> +	genlmsg_end(skb, hdr);
> +
>  	return 0;
>  }
> =20
>  int nfsd_server_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  					 struct netlink_callback *cb)
>  {
> +	struct nfsd_net *nn =3D net_generic(sock_net(skb->sk), nfsd_net_id);
> +	int i, ret, rqstp_index;
> +
> +	rcu_read_lock();
> +
> +	for (i =3D 0; i < nn->nfsd_serv->sv_nrpools; i++) {
> +		struct svc_rqst *rqstp;
> +
> +		if (i < cb->args[0]) /* already consumed */
> +			continue;
> +
> +		rqstp_index =3D 0;
> +		list_for_each_entry_rcu(rqstp,
> +				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
> +				rq_all) {
> +			struct nfsd_genl_rqstp genl_rqstp;
> +			unsigned int status_counter;
> +
> +			if (rqstp_index++ < cb->args[1]) /* already consumed */
> +				continue;
> +			/*
> +			 * Acquire rq_status_counter before parsing the rqst
> +			 * fields. rq_status_counter is set to an odd value in
> +			 * order to notify the consumers the rqstp fields are
> +			 * meaningful.
> +			 */
> +			status_counter =3D
> +				smp_load_acquire(&rqstp->rq_status_counter);
> +			if (!(status_counter & 1))
> +				continue;
> +
> +			genl_rqstp.rq_xid =3D rqstp->rq_xid;
> +			genl_rqstp.rq_flags =3D rqstp->rq_flags;
> +			genl_rqstp.rq_vers =3D rqstp->rq_vers;
> +			genl_rqstp.rq_prog =3D rqstp->rq_prog;
> +			genl_rqstp.rq_proc =3D rqstp->rq_proc;
> +			genl_rqstp.rq_stime =3D rqstp->rq_stime;
> +			genl_rqstp.opcnt =3D 0;
> +			memcpy(&genl_rqstp.daddr, svc_daddr(rqstp),
> +			       sizeof(struct sockaddr));
> +			memcpy(&genl_rqstp.saddr, svc_addr(rqstp),
> +			       sizeof(struct sockaddr));
> +
> +#ifdef CONFIG_NFSD_V4
> +			if (rqstp->rq_vers =3D=3D NFS4_VERSION &&
> +			    rqstp->rq_proc =3D=3D NFSPROC4_COMPOUND) {
> +				/* NFSv4 compund */
> +				struct nfsd4_compoundargs *args;
> +				int j;
> +
> +				args =3D rqstp->rq_argp;
> +				genl_rqstp.opcnt =3D args->opcnt;
> +				for (j =3D 0; j < genl_rqstp.opcnt; j++)
> +					genl_rqstp.opnum[j] =3D
> +						args->ops[j].opnum;
> +			}
> +#endif /* CONFIG_NFSD_V4 */
> +
> +			/*
> +			 * Acquire rq_status_counter before reporting the rqst
> +			 * fields to the user.
> +			 */
> +			if (smp_load_acquire(&rqstp->rq_status_counter) !=3D
> +			    status_counter)
> +				continue;
> +
> +			ret =3D nfsd_genl_rpc_status_compose_msg(skb, cb,
> +							       &genl_rqstp);
> +			if (ret)
> +				goto out;
> +		}
> +	}
> +
> +	cb->args[0] =3D i;
> +	cb->args[1] =3D rqstp_index;
> +	ret =3D skb->len;
> +out:
> +	rcu_read_unlock();
> +
> +	return ret;
> +}
> +
> +int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb)
> +{
> +	mutex_lock(&nfsd_mutex);
> +	nfsd_put(sock_net(cb->skb->sk));
> +	mutex_unlock(&nfsd_mutex);
> +
>  	return 0;
>  }
> =20

I think there is a potential race above. Once you've=20


> @@ -1605,6 +1788,10 @@ static int __init init_nfsd(void)
>  	retval =3D register_filesystem(&nfsd_fs_type);
>  	if (retval)
>  		goto out_free_all;
> +	retval =3D genl_register_family(&nfsd_server_nl_family);
> +	if (retval)
> +		goto out_free_all;
> +
>  	return 0;
>  out_free_all:
>  	nfsd4_destroy_laundry_wq();
> @@ -1629,6 +1816,7 @@ static int __init init_nfsd(void)
> =20
>  static void __exit exit_nfsd(void)
>  {
> +	genl_unregister_family(&nfsd_server_nl_family);
>  	unregister_filesystem(&nfsd_fs_type);
>  	nfsd4_destroy_laundry_wq();
>  	unregister_cld_notifier();
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 11c14faa6c67..d787bd38c053 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -62,6 +62,22 @@ struct readdir_cd {
>  	__be32			err;	/* 0, nfserr, or nfserr_eof */
>  };
> =20
> +/* Maximum number of operations per session compound */
> +#define NFSD_MAX_OPS_PER_COMPOUND	50
> +
> +struct nfsd_genl_rqstp {
> +	struct sockaddr daddr;
> +	struct sockaddr saddr;
> +	unsigned long rq_flags;
> +	ktime_t rq_stime;
> +	__be32 rq_xid;
> +	u32 rq_vers;
> +	u32 rq_prog;
> +	u32 rq_proc;
> +	/* NFSv4 compund */
> +	u32 opnum[NFSD_MAX_OPS_PER_COMPOUND];
> +	u16 opcnt;
> +};
> =20
>  extern struct svc_program	nfsd_program;
>  extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_versi=
on4;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 1582af33e204..fad34a7325b3 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -998,6 +998,15 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_decode(rqstp, &rqstp->rq_arg_stream))
>  		goto out_decode_err;
> =20
> +	/*
> +	 * Release rq_status_counter setting it to an odd value after the rpc
> +	 * request has been properly parsed. rq_status_counter is used to
> +	 * notify the consumers if the rqstp fields are stable
> +	 * (rq_status_counter is odd) or not meaningful (rq_status_counter
> +	 * is even).
> +	 */
> +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter |=
 1);
> +
>  	rp =3D NULL;
>  	switch (nfsd_cache_lookup(rqstp, &rp)) {
>  	case RC_DOIT:
> @@ -1015,6 +1024,12 @@ int nfsd_dispatch(struct svc_rqst *rqstp)
>  	if (!proc->pc_encode(rqstp, &rqstp->rq_res_stream))
>  		goto out_encode_err;
> =20
> +	/*
> +	 * Release rq_status_counter setting it to an even value after the rpc
> +	 * request has been properly processed.
> +	 */
> +	smp_store_release(&rqstp->rq_status_counter, rqstp->rq_status_counter +=
 1);
> +
>  	nfsd_cache_update(rqstp, rp, rqstp->rq_cachetype, statp + 1);
>  out_cached_reply:
>  	return 1;
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index cbddcf484dba..41bdc913fa71 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -174,8 +174,6 @@ static inline struct nfs4_delegation *delegstateid(st=
ruct nfs4_stid *s)
> =20
>  /* Maximum number of slots per session. 160 is useful for long haul TCP =
*/
>  #define NFSD_MAX_SLOTS_PER_SESSION     160
> -/* Maximum number of operations per session compound */
> -#define NFSD_MAX_OPS_PER_COMPOUND	50
>  /* Maximum  session per slot cache size */
>  #define NFSD_SLOT_CACHE_SIZE		2048
>  /* Maximum number of NFSD_SLOT_CACHE_SIZE slots per session */
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index dbf5b21feafe..caa20defd255 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -251,6 +251,7 @@ struct svc_rqst {
>  						 * net namespace
>  						 */
>  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
> +	unsigned int		rq_status_counter; /* RPC processing counter */
>  };
> =20
>  /* bits for rq_flags */

--=20
Jeff Layton <jlayton@kernel.org>

