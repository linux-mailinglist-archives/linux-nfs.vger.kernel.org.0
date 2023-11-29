Return-Path: <linux-nfs+bounces-178-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A2F7FDF4C
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 19:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7851C208DE
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Nov 2023 18:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73D55C907;
	Wed, 29 Nov 2023 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8Ctai6K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C64F5F2;
	Wed, 29 Nov 2023 18:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3A7C433C7;
	Wed, 29 Nov 2023 18:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701282494;
	bh=hVw1raVVra5N/mwFWBzlermyZ2HQNDYLRw7Zp8Kb1wM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=j8Ctai6Kmzf9ug7L3yKafrETg/zGeV9M3vGurEGJEgDZE/SgBwvrvUnVrCsCkYH1F
	 +te2rhTipCsiH++4XO3lQT7VFgUWhVm16dyeG2VDtZzG6aEc+DGZx85u3wKI+edPS3
	 l1m71owvh6BJ0eYqldzDdFDER3XXyFLMmFjSj4Mdt3SJMEZe1zheYqtn83SdeKom4h
	 TsK2XK/U5w6bd69yu6iCXnoNEw+XKQjaeC08vBKEsE9YHkQ/ChVSsnTxUJXYqxDtxr
	 nNQczd4jUXc8UdoJlhbxYTdjqZAD0x4PPmg7ybwfVadIqIfMbiZlRYIvDEtdEgJ8Fk
	 o99p8WDDxD0uQ==
Message-ID: <7b21c962c2a6c552c9807d6f382e1097da4ba748.camel@kernel.org>
Subject: Re: [PATCH v5 3/3] NFSD: convert write_ports to netlink command
From: Jeff Layton <jlayton@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, neilb@suse.de, netdev@vger.kernel.org, 
	kuba@kernel.org
Date: Wed, 29 Nov 2023 13:28:12 -0500
In-Reply-To: <67251eabfbbccb806991e6437ebcf1cf00166017.1701277475.git.lorenzo@kernel.org>
References: <cover.1701277475.git.lorenzo@kernel.org>
	 <67251eabfbbccb806991e6437ebcf1cf00166017.1701277475.git.lorenzo@kernel.org>
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
> Introduce write_ports netlink command similar to the ones available
> through the procfs.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  28 +++++++
>  fs/nfsd/netlink.c                     |  18 +++++
>  fs/nfsd/netlink.h                     |   3 +
>  fs/nfsd/nfsctl.c                      | 104 ++++++++++++++++++++++++--
>  include/uapi/linux/nfsd_netlink.h     |  10 +++
>  tools/net/ynl/generated/nfsd-user.c   |  81 ++++++++++++++++++++
>  tools/net/ynl/generated/nfsd-user.h   |  54 +++++++++++++
>  7 files changed, 291 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlin=
k/specs/nfsd.yaml
> index 6c5e42bb20f6..1c342ad3c5fa 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -80,6 +80,15 @@ attribute-sets:
>        -
>          name: status
>          type: u8
> +  -
> +    name: server-listener
> +    attributes:
> +      -
> +        name: transport-name
> +        type: string
> +      -
> +        name: port
> +        type: u32
> =20
>  operations:
>    list:
> @@ -142,3 +151,22 @@ operations:
>            attributes:
>              - major
>              - minor
> +    -
> +      name: listener-start
> +      doc: start server listener
> +      attribute-set: server-listener
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - transport-name
> +            - port
> +    -
> +      name: listener-get
> +      doc: dump server listeners
> +      attribute-set: server-listener
> +      dump:
> +        reply:
> +          attributes:
> +            - transport-name
> +            - port
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 0608a7bd193b..cd51393ede72 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -22,6 +22,12 @@ static const struct nla_policy nfsd_version_set_nl_pol=
icy[NFSD_A_SERVER_VERSION_
>  	[NFSD_A_SERVER_VERSION_STATUS] =3D { .type =3D NLA_U8, },
>  };
> =20
> +/* NFSD_CMD_LISTENER_START - do */
> +static const struct nla_policy nfsd_listener_start_nl_policy[NFSD_A_SERV=
ER_LISTENER_PORT + 1] =3D {
> +	[NFSD_A_SERVER_LISTENER_TRANSPORT_NAME] =3D { .type =3D NLA_NUL_STRING,=
 },
> +	[NFSD_A_SERVER_LISTENER_PORT] =3D { .type =3D NLA_U32, },
> +};
> +
>  /* Ops table for nfsd */
>  static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  	{
> @@ -55,6 +61,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  		.dumpit	=3D nfsd_nl_version_get_dumpit,
>  		.flags	=3D GENL_CMD_CAP_DUMP,
>  	},
> +	{
> +		.cmd		=3D NFSD_CMD_LISTENER_START,
> +		.doit		=3D nfsd_nl_listener_start_doit,
> +		.policy		=3D nfsd_listener_start_nl_policy,
> +		.maxattr	=3D NFSD_A_SERVER_LISTENER_PORT,
> +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd	=3D NFSD_CMD_LISTENER_GET,
> +		.dumpit	=3D nfsd_nl_listener_get_dumpit,
> +		.flags	=3D GENL_CMD_CAP_DUMP,
> +	},
>  };
> =20
>  struct genl_family nfsd_nl_family __ro_after_init =3D {
> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> index 7d203cec08e4..9a51cb83f343 100644
> --- a/fs/nfsd/netlink.h
> +++ b/fs/nfsd/netlink.h
> @@ -21,6 +21,9 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struc=
t genl_info *info);
>  int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info=
);
>  int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
>  			       struct netlink_callback *cb);
> +int nfsd_nl_listener_start_doit(struct sk_buff *skb, struct genl_info *i=
nfo);
> +int nfsd_nl_listener_get_dumpit(struct sk_buff *skb,
> +				struct netlink_callback *cb);
> =20
>  extern struct genl_family nfsd_nl_family;
> =20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index f04430f79687..53129b5b7d3c 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -721,18 +721,16 @@ static ssize_t __write_ports_addfd(char *buf, struc=
t net *net, const struct cred
>   * A transport listener is added by writing its transport name and
>   * a port number.
>   */
> -static ssize_t __write_ports_addxprt(char *buf, struct net *net, const s=
truct cred *cred)
> +static ssize_t ___write_ports_addxprt(struct net *net, const struct cred=
 *cred,
> +				      const char *transport, const int port)
>  {
> -	char transport[16];
> -	struct svc_xprt *xprt;
> -	int port, err;
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> -
> -	if (sscanf(buf, "%15s %5u", transport, &port) !=3D 2)
> -		return -EINVAL;
> +	struct svc_xprt *xprt;
> +	int err;
> =20
>  	if (port < 1 || port > USHRT_MAX)
>  		return -EINVAL;
> +
>  	trace_nfsd_ctl_ports_addxprt(net, transport, port);
> =20
>  	err =3D nfsd_create_serv(net);
> @@ -765,6 +763,17 @@ static ssize_t __write_ports_addxprt(char *buf, stru=
ct net *net, const struct cr
>  	return err;
>  }
> =20
> +static ssize_t __write_ports_addxprt(char *buf, struct net *net, const s=
truct cred *cred)
> +{
> +	char transport[16];
> +	int port;
> +
> +	if (sscanf(buf, "%15s %5u", transport, &port) !=3D 2)
> +		return -EINVAL;
> +
> +	return ___write_ports_addxprt(net, cred, transport, port);
> +}
> +
>  static ssize_t __write_ports(struct file *file, char *buf, size_t size,
>  			     struct net *net)
>  {
> @@ -1862,6 +1871,87 @@ int nfsd_nl_version_get_dumpit(struct sk_buff *skb=
,
>  	return ret;
>  }
> =20
> +/**
> + * nfsd_nl_listener_start_doit - start the provided nfs server listener
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_listener_start_doit(struct sk_buff *skb, struct genl_info *i=
nfo)
> +{
> +	int ret;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_LISTENER_TRANSPORT_NAME) ||
> +	    GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_LISTENER_PORT))
> +		return -EINVAL;
> +
> +	mutex_lock(&nfsd_mutex);
> +	ret =3D ___write_ports_addxprt(genl_info_net(info), get_current_cred(),
> +			nla_data(info->attrs[NFSD_A_SERVER_LISTENER_TRANSPORT_NAME]),
> +			nla_get_u32(info->attrs[NFSD_A_SERVER_LISTENER_PORT]));
> +	mutex_unlock(&nfsd_mutex);
> +
> +	return 0;
> +}
> +
> +/**
> + * nfsd_nl_version_get_dumpit - Handle listener_get dumpit
> + * @skb: reply buffer
> + * @cb: netlink metadata and command arguments
> + *
> + * Returns the size of the reply or a negative errno.
> + */
> +int nfsd_nl_listener_get_dumpit(struct sk_buff *skb,
> +				struct netlink_callback *cb)
> +{
> +	struct nfsd_net *nn =3D net_generic(sock_net(skb->sk), nfsd_net_id);
> +	int i =3D 0, ret =3D -ENOMEM;
> +	struct svc_xprt *xprt;
> +	struct svc_serv *serv;
> +
> +	mutex_lock(&nfsd_mutex);
> +
> +	serv =3D nn->nfsd_serv;
> +	if (!serv) {
> +		mutex_unlock(&nfsd_mutex);
> +		return 0;
> +	}
> +
> +	spin_lock_bh(&serv->sv_lock);
> +	list_for_each_entry(xprt, &serv->sv_permsocks, xpt_list) {
> +		void *hdr;
> +
> +		if (i < cb->args[0]) /* already consumed */
> +			continue;
> +
> +		hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> +				  cb->nlh->nlmsg_seq, &nfsd_nl_family,
> +				  0, NFSD_CMD_LISTENER_GET);
> +		if (!hdr)
> +			goto out;
> +
> +		if (nla_put_string(skb, NFSD_A_SERVER_LISTENER_TRANSPORT_NAME,
> +				   xprt->xpt_class->xcl_name))
> +			goto out;
> +
> +		if (nla_put_u32(skb, NFSD_A_SERVER_LISTENER_PORT,
> +				svc_xprt_local_port(xprt)))
> +			goto out;
> +
> +		genlmsg_end(skb, hdr);
> +		i++;
> +	}
> +	cb->args[0] =3D i;
> +	ret =3D skb->len;
> +out:
> +	spin_unlock_bh(&serv->sv_lock);
> +
> +	mutex_unlock(&nfsd_mutex);
> +
> +	return ret;
> +}
> +
>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace
> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_=
netlink.h
> index 1b3340f31baa..61f4c5b50ecb 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -45,12 +45,22 @@ enum {
>  	NFSD_A_SERVER_VERSION_MAX =3D (__NFSD_A_SERVER_VERSION_MAX - 1)
>  };
> =20
> +enum {
> +	NFSD_A_SERVER_LISTENER_TRANSPORT_NAME =3D 1,
> +	NFSD_A_SERVER_LISTENER_PORT,
> +
> +	__NFSD_A_SERVER_LISTENER_MAX,
> +	NFSD_A_SERVER_LISTENER_MAX =3D (__NFSD_A_SERVER_LISTENER_MAX - 1)
> +};
> +
>  enum {
>  	NFSD_CMD_RPC_STATUS_GET =3D 1,
>  	NFSD_CMD_THREADS_SET,
>  	NFSD_CMD_THREADS_GET,
>  	NFSD_CMD_VERSION_SET,
>  	NFSD_CMD_VERSION_GET,
> +	NFSD_CMD_LISTENER_START,
> +	NFSD_CMD_LISTENER_GET,
> =20
>  	__NFSD_CMD_MAX,
>  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generate=
d/nfsd-user.c
> index 4cb71c3cd18d..167e404c9e20 100644
> --- a/tools/net/ynl/generated/nfsd-user.c
> +++ b/tools/net/ynl/generated/nfsd-user.c
> @@ -19,6 +19,8 @@ static const char * const nfsd_op_strmap[] =3D {
>  	[NFSD_CMD_THREADS_GET] =3D "threads-get",
>  	[NFSD_CMD_VERSION_SET] =3D "version-set",
>  	[NFSD_CMD_VERSION_GET] =3D "version-get",
> +	[NFSD_CMD_LISTENER_START] =3D "listener-start",
> +	[NFSD_CMD_LISTENER_GET] =3D "listener-get",
>  };
> =20
>  const char *nfsd_op_str(int op)
> @@ -71,6 +73,16 @@ struct ynl_policy_nest nfsd_server_version_nest =3D {
>  	.table =3D nfsd_server_version_policy,
>  };
> =20
> +struct ynl_policy_attr nfsd_server_listener_policy[NFSD_A_SERVER_LISTENE=
R_MAX + 1] =3D {
> +	[NFSD_A_SERVER_LISTENER_TRANSPORT_NAME] =3D { .name =3D "transport-name=
", .type =3D YNL_PT_NUL_STR, },
> +	[NFSD_A_SERVER_LISTENER_PORT] =3D { .name =3D "port", .type =3D YNL_PT_=
U32, },
> +};
> +
> +struct ynl_policy_nest nfsd_server_listener_nest =3D {
> +	.max_attr =3D NFSD_A_SERVER_LISTENER_MAX,
> +	.table =3D nfsd_server_listener_policy,
> +};
> +
>  /* Common nested types */
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATUS_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>  /* NFSD_CMD_RPC_STATUS_GET - dump */
> @@ -371,6 +383,75 @@ struct nfsd_version_get_list *nfsd_version_get_dump(=
struct ynl_sock *ys)
>  	return NULL;
>  }
> =20
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_START =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +/* NFSD_CMD_LISTENER_START - do */
> +void nfsd_listener_start_req_free(struct nfsd_listener_start_req *req)
> +{
> +	free(req->transport_name);
> +	free(req);
> +}
> +
> +int nfsd_listener_start(struct ynl_sock *ys,
> +			struct nfsd_listener_start_req *req)
> +{
> +	struct nlmsghdr *nlh;
> +	int err;
> +
> +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_LISTENER_START,=
 1);
> +	ys->req_policy =3D &nfsd_server_listener_nest;
> +
> +	if (req->_present.transport_name_len)
> +		mnl_attr_put_strz(nlh, NFSD_A_SERVER_LISTENER_TRANSPORT_NAME, req->tra=
nsport_name);
> +	if (req->_present.port)
> +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_LISTENER_PORT, req->port);
> +
> +	err =3D ynl_exec(ys, nlh, NULL);
> +	if (err < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_GET =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +/* NFSD_CMD_LISTENER_GET - dump */
> +void nfsd_listener_get_list_free(struct nfsd_listener_get_list *rsp)
> +{
> +	struct nfsd_listener_get_list *next =3D rsp;
> +
> +	while ((void *)next !=3D YNL_LIST_END) {
> +		rsp =3D next;
> +		next =3D rsp->next;
> +
> +		free(rsp->obj.transport_name);
> +		free(rsp);
> +	}
> +}
> +
> +struct nfsd_listener_get_list *nfsd_listener_get_dump(struct ynl_sock *y=
s)
> +{
> +	struct ynl_dump_state yds =3D {};
> +	struct nlmsghdr *nlh;
> +	int err;
> +
> +	yds.ys =3D ys;
> +	yds.alloc_sz =3D sizeof(struct nfsd_listener_get_list);
> +	yds.cb =3D nfsd_listener_get_rsp_parse;
> +	yds.rsp_cmd =3D NFSD_CMD_LISTENER_GET;
> +	yds.rsp_policy =3D &nfsd_server_listener_nest;
> +
> +	nlh =3D ynl_gemsg_start_dump(ys, ys->family_id, NFSD_CMD_LISTENER_GET, =
1);
> +
> +	err =3D ynl_exec_dump(ys, nlh, &yds);
> +	if (err < 0)
> +		goto free_list;
> +
> +	return yds.first;
> +
> +free_list:
> +	nfsd_listener_get_list_free(yds.first);
> +	return NULL;
> +}
> +
>  const struct ynl_family ynl_nfsd_family =3D  {
>  	.name		=3D "nfsd",
>  };
> diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generate=
d/nfsd-user.h
> index e61c5a9e46fb..da3aaaf3f6c0 100644
> --- a/tools/net/ynl/generated/nfsd-user.h
> +++ b/tools/net/ynl/generated/nfsd-user.h
> @@ -166,4 +166,58 @@ void nfsd_version_get_list_free(struct nfsd_version_=
get_list *rsp);
> =20
>  struct nfsd_version_get_list *nfsd_version_get_dump(struct ynl_sock *ys)=
;
> =20
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_START =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +/* NFSD_CMD_LISTENER_START - do */
> +struct nfsd_listener_start_req {
> +	struct {
> +		__u32 transport_name_len;
> +		__u32 port:1;
> +	} _present;
> +
> +	char *transport_name;
> +	__u32 port;
> +};

How do you deconfigure a listener with this interface? i.e. suppose I
want to stop nfsd from listening on a particular port? I think this too
is a place where a declarative interface would be better:

Have userland send down a list of the ports that we should currently be
listening on, and let the kernel do the work to match the request. Again
too, an empty list could mean "close everything".

> +
> +static inline struct nfsd_listener_start_req *
> +nfsd_listener_start_req_alloc(void)
> +{
> +	return calloc(1, sizeof(struct nfsd_listener_start_req));
> +}
> +void nfsd_listener_start_req_free(struct nfsd_listener_start_req *req);
> +
> +static inline void
> +nfsd_listener_start_req_set_transport_name(struct nfsd_listener_start_re=
q *req,
> +					   const char *transport_name)
> +{
> +	free(req->transport_name);
> +	req->_present.transport_name_len =3D strlen(transport_name);
> +	req->transport_name =3D malloc(req->_present.transport_name_len + 1);
> +	memcpy(req->transport_name, transport_name, req->_present.transport_nam=
e_len);
> +	req->transport_name[req->_present.transport_name_len] =3D 0;
> +}
> +static inline void
> +nfsd_listener_start_req_set_port(struct nfsd_listener_start_req *req,
> +				 __u32 port)
> +{
> +	req->_present.port =3D 1;
> +	req->port =3D port;
> +}
> +
> +/*
> + * start server listener
> + */
> +int nfsd_listener_start(struct ynl_sock *ys,
> +			struct nfsd_listener_start_req *req);
> +
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_GET =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +/* NFSD_CMD_LISTENER_GET - dump */
> +struct nfsd_listener_get_list {
> +	struct nfsd_listener_get_list *next;
> +	struct nfsd_listener_get_rsp obj __attribute__ ((aligned (8)));
> +};
> +
> +void nfsd_listener_get_list_free(struct nfsd_listener_get_list *rsp);
> +
> +struct nfsd_listener_get_list *nfsd_listener_get_dump(struct ynl_sock *y=
s);
> +
>  #endif /* _LINUX_NFSD_GEN_H */

--=20
Jeff Layton <jlayton@kernel.org>

