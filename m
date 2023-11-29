Return-Path: <linux-nfs+bounces-176-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE537FDF24
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 19:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9493A282AB8
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 18:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BB548CE2;
	Wed, 29 Nov 2023 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKgjzLDe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5193532C87;
	Wed, 29 Nov 2023 18:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CB3C433C7;
	Wed, 29 Nov 2023 18:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701281616;
	bh=BR6bMeSMLVUQcqnoNJeJ/gzKsyIxmNEVW2nozCx9DHk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cKgjzLDeDTLbTIzc3E1O7IbR/IgO3dnobKgKjclpAtM5SShRVyfm8FrDlxiEQI9Zs
	 KKrQF30NNCMm8sFG9tfr9gqbn715VSPFgjoyeZatpWc8WAV9WAWinaAjZqtb9WJbO5
	 i5NcV72c71BERGhx+2diz/22H8C/SpBxa8MAvj8pjhgJjKspEJ6URDkViFU8Y7hV3E
	 9WGcRxoJ0W39n6M6Ari+0zWbZ5X0AQ1pd2SB3MN60czIX+DqIBCvywWBS3UDMrWdnH
	 MWtFNP5LYKB6QYfq7uAm7+SeJMwf4JEXzYqCtGb/VsfQdMfQ+IQnRyp11s8qdIoEWK
	 hCEUBGwg32CEw==
Message-ID: <ffbbdd1ce7c87b02f75095f0146924d996268957.camel@kernel.org>
Subject: Re: [PATCH v5 1/3] NFSD: convert write_threads to netlink command
From: Jeff Layton <jlayton@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, neilb@suse.de, netdev@vger.kernel.org, 
	kuba@kernel.org
Date: Wed, 29 Nov 2023 13:13:34 -0500
In-Reply-To: <d9461e660b5f47df7b869f0f809485c9b4bf60ea.1701277475.git.lorenzo@kernel.org>
References: <cover.1701277475.git.lorenzo@kernel.org>
	 <d9461e660b5f47df7b869f0f809485c9b4bf60ea.1701277475.git.lorenzo@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-29 at 18:12 +0100, Lorenzo Bianconi wrote:
> Introduce write_threads netlink command similar to the ones available
> through the procfs.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd.yaml | 23 +++++++
>  fs/nfsd/netlink.c                     | 17 +++++
>  fs/nfsd/netlink.h                     |  2 +
>  fs/nfsd/nfsctl.c                      | 58 +++++++++++++++++
>  include/uapi/linux/nfsd_netlink.h     |  9 +++
>  tools/net/ynl/generated/nfsd-user.c   | 92 +++++++++++++++++++++++++++
>  tools/net/ynl/generated/nfsd-user.h   | 47 ++++++++++++++
>  7 files changed, 248 insertions(+)
>=20
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlin=
k/specs/nfsd.yaml
> index 05acc73e2e33..c92e1425d316 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -62,6 +62,12 @@ attribute-sets:
>          name: compound-ops
>          type: u32
>          multi-attr: true
> +  -
> +    name: server-worker
> +    attributes:
> +      -
> +        name: threads
> +        type: u32
> =20
>  operations:
>    list:
> @@ -87,3 +93,20 @@ operations:
>              - sport
>              - dport
>              - compound-ops
> +    -
> +      name: threads-set
> +      doc: set the number of running threads
> +      attribute-set: server-worker
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - threads
> +    -
> +      name: threads-get
> +      doc: get the number of running threads
> +      attribute-set: server-worker
> +      do:
> +        reply:
> +          attributes:
> +            - threads
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 0e1d635ec5f9..1a59a8e6c7e2 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -10,6 +10,11 @@
> =20
>  #include <uapi/linux/nfsd_netlink.h>
> =20
> +/* NFSD_CMD_THREADS_SET - do */
> +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_=
WORKER_THREADS + 1] =3D {
> +	[NFSD_A_SERVER_WORKER_THREADS] =3D { .type =3D NLA_U32, },
> +};
> +
>  /* Ops table for nfsd */
>  static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  	{
> @@ -19,6 +24,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  		.done	=3D nfsd_nl_rpc_status_get_done,
>  		.flags	=3D GENL_CMD_CAP_DUMP,
>  	},
> +	{
> +		.cmd		=3D NFSD_CMD_THREADS_SET,
> +		.doit		=3D nfsd_nl_threads_set_doit,
> +		.policy		=3D nfsd_threads_set_nl_policy,
> +		.maxattr	=3D NFSD_A_SERVER_WORKER_THREADS,
> +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd	=3D NFSD_CMD_THREADS_GET,
> +		.doit	=3D nfsd_nl_threads_get_doit,
> +		.flags	=3D GENL_CMD_CAP_DO,
> +	},
>  };
> =20
>  struct genl_family nfsd_nl_family __ro_after_init =3D {
> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> index d83dd6bdee92..4137fac477e4 100644
> --- a/fs/nfsd/netlink.h
> +++ b/fs/nfsd/netlink.h
> @@ -16,6 +16,8 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callback=
 *cb);
> =20
>  int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  				  struct netlink_callback *cb);
> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info=
);
> +int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info=
);
> =20
>  extern struct genl_family nfsd_nl_family;
> =20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index d6eeee149370..130b3d937a79 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1699,6 +1699,64 @@ int nfsd_nl_rpc_status_get_done(struct netlink_cal=
lback *cb)
>  	return 0;
>  }
> =20
> +/**
> + * nfsd_nl_threads_set_doit - set the number of running threads
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info=
)
> +{
> +	u32 nthreads;
> +	int ret;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_WORKER_THREADS))
> +		return -EINVAL;
> +
> +	nthreads =3D nla_get_u32(info->attrs[NFSD_A_SERVER_WORKER_THREADS]);
> +	ret =3D nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
> +
> +	return ret =3D=3D nthreads ? 0 : ret;
> +}
> +
> +/**
> + * nfsd_nl_threads_get_doit - get the number of running threads
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info=
)
> +{
> +	void *hdr;
> +	int err;
> +
> +	skb =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	hdr =3D genlmsg_iput(skb, info);
> +	if (!hdr) {
> +		err =3D -EMSGSIZE;
> +		goto err_free_msg;
> +	}
> +
> +	if (nla_put_u32(skb, NFSD_A_SERVER_WORKER_THREADS,
> +			nfsd_nrthreads(genl_info_net(info)))) {
> +		err =3D -EINVAL;
> +		goto err_free_msg;
> +	}
> +
> +	genlmsg_end(skb, hdr);
> +
> +	return genlmsg_reply(skb, info);
> +
> +err_free_msg:
> +	nlmsg_free(skb);
> +	return err;
> +}
> +
>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace
> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_=
netlink.h
> index 3cd044edee5d..1b6fe1f9ed0e 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -29,8 +29,17 @@ enum {
>  	NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
>  };
> =20
> +enum {
> +	NFSD_A_SERVER_WORKER_THREADS =3D 1,
> +
> +	__NFSD_A_SERVER_WORKER_MAX,
> +	NFSD_A_SERVER_WORKER_MAX =3D (__NFSD_A_SERVER_WORKER_MAX - 1)
> +};
> +
>  enum {
>  	NFSD_CMD_RPC_STATUS_GET =3D 1,
> +	NFSD_CMD_THREADS_SET,
> +	NFSD_CMD_THREADS_GET,
> =20
>  	__NFSD_CMD_MAX,
>  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generate=
d/nfsd-user.c
> index 360b6448c6e9..9768328a7751 100644
> --- a/tools/net/ynl/generated/nfsd-user.c
> +++ b/tools/net/ynl/generated/nfsd-user.c
> @@ -15,6 +15,8 @@
>  /* Enums */
>  static const char * const nfsd_op_strmap[] =3D {
>  	[NFSD_CMD_RPC_STATUS_GET] =3D "rpc-status-get",
> +	[NFSD_CMD_THREADS_SET] =3D "threads-set",
> +	[NFSD_CMD_THREADS_GET] =3D "threads-get",
>  };
> =20
>  const char *nfsd_op_str(int op)
> @@ -47,6 +49,15 @@ struct ynl_policy_nest nfsd_rpc_status_nest =3D {
>  	.table =3D nfsd_rpc_status_policy,
>  };
> =20
> +struct ynl_policy_attr nfsd_server_worker_policy[NFSD_A_SERVER_WORKER_MA=
X + 1] =3D {
> +	[NFSD_A_SERVER_WORKER_THREADS] =3D { .name =3D "threads", .type =3D YNL=
_PT_U32, },
> +};
> +
> +struct ynl_policy_nest nfsd_server_worker_nest =3D {
> +	.max_attr =3D NFSD_A_SERVER_WORKER_MAX,
> +	.table =3D nfsd_server_worker_policy,
> +};
> +
>  /* Common nested types */
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATUS_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>  /* NFSD_CMD_RPC_STATUS_GET - dump */
> @@ -198,6 +209,87 @@ nfsd_rpc_status_get_dump(struct ynl_sock *ys)
>  	return NULL;
>  }
> =20
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_THREADS_SET =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +/* NFSD_CMD_THREADS_SET - do */
> +void nfsd_threads_set_req_free(struct nfsd_threads_set_req *req)
> +{
> +	free(req);
> +}
> +
> +int nfsd_threads_set(struct ynl_sock *ys, struct nfsd_threads_set_req *r=
eq)
> +{
> +	struct nlmsghdr *nlh;
> +	int err;
> +
> +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_THREADS_SET, 1)=
;
> +	ys->req_policy =3D &nfsd_server_worker_nest;
> +
> +	if (req->_present.threads)
> +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_WORKER_THREADS, req->threads);
> +
> +	err =3D ynl_exec(ys, nlh, NULL);
> +	if (err < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_THREADS_GET =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +/* NFSD_CMD_THREADS_GET - do */
> +void nfsd_threads_get_rsp_free(struct nfsd_threads_get_rsp *rsp)
> +{
> +	free(rsp);
> +}
> +
> +int nfsd_threads_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> +{
> +	struct ynl_parse_arg *yarg =3D data;
> +	struct nfsd_threads_get_rsp *dst;
> +	const struct nlattr *attr;
> +
> +	dst =3D yarg->data;
> +
> +	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> +		unsigned int type =3D mnl_attr_get_type(attr);
> +
> +		if (type =3D=3D NFSD_A_SERVER_WORKER_THREADS) {
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +			dst->_present.threads =3D 1;
> +			dst->threads =3D mnl_attr_get_u32(attr);
> +		}
> +	}
> +
> +	return MNL_CB_OK;
> +}
> +
> +struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys)
> +{
> +	struct ynl_req_state yrs =3D { .yarg =3D { .ys =3D ys, }, };
> +	struct nfsd_threads_get_rsp *rsp;
> +	struct nlmsghdr *nlh;
> +	int err;
> +
> +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_THREADS_GET, 1)=
;
> +	ys->req_policy =3D &nfsd_server_worker_nest;
> +	yrs.yarg.rsp_policy =3D &nfsd_server_worker_nest;
> +
> +	rsp =3D calloc(1, sizeof(*rsp));
> +	yrs.yarg.data =3D rsp;
> +	yrs.cb =3D nfsd_threads_get_rsp_parse;
> +	yrs.rsp_cmd =3D NFSD_CMD_THREADS_GET;
> +
> +	err =3D ynl_exec(ys, nlh, &yrs);
> +	if (err < 0)
> +		goto err_free;
> +
> +	return rsp;
> +
> +err_free:
> +	nfsd_threads_get_rsp_free(rsp);
> +	return NULL;
> +}
> +
>  const struct ynl_family ynl_nfsd_family =3D  {
>  	.name		=3D "nfsd",
>  };
> diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generate=
d/nfsd-user.h
> index 989c6e209ced..e162a4f20d91 100644
> --- a/tools/net/ynl/generated/nfsd-user.h
> +++ b/tools/net/ynl/generated/nfsd-user.h
> @@ -64,4 +64,51 @@ nfsd_rpc_status_get_rsp_list_free(struct nfsd_rpc_stat=
us_get_rsp_list *rsp);
>  struct nfsd_rpc_status_get_rsp_list *
>  nfsd_rpc_status_get_dump(struct ynl_sock *ys);
> =20
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_THREADS_SET =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +/* NFSD_CMD_THREADS_SET - do */
> +struct nfsd_threads_set_req {
> +	struct {
> +		__u32 threads:1;
> +	} _present;
> +
> +	__u32 threads;
> +};
> +
> +static inline struct nfsd_threads_set_req *nfsd_threads_set_req_alloc(vo=
id)
> +{
> +	return calloc(1, sizeof(struct nfsd_threads_set_req));
> +}
> +void nfsd_threads_set_req_free(struct nfsd_threads_set_req *req);
> +
> +static inline void
> +nfsd_threads_set_req_set_threads(struct nfsd_threads_set_req *req,
> +				 __u32 threads)
> +{
> +	req->_present.threads =3D 1;
> +	req->threads =3D threads;
> +}
> +
> +/*
> + * set the number of running threads
> + */
> +int nfsd_threads_set(struct ynl_sock *ys, struct nfsd_threads_set_req *r=
eq);
> +
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_THREADS_GET =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +/* NFSD_CMD_THREADS_GET - do */
> +
> +struct nfsd_threads_get_rsp {
> +	struct {
> +		__u32 threads:1;
> +	} _present;
> +
> +	__u32 threads;
> +};
> +
> +void nfsd_threads_get_rsp_free(struct nfsd_threads_get_rsp *rsp);
> +
> +/*
> + * get the number of running threads
> + */
> +struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys);
> +
>  #endif /* _LINUX_NFSD_GEN_H */

Ok, Uncle! I'll relent on the quest for a single netlink command to
start the server. This patch looks reasonable to me.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

