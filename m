Return-Path: <linux-nfs+bounces-1236-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F349E83646E
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 14:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 238CB1C21F29
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 13:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49493CF60;
	Mon, 22 Jan 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBEygPfI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C73D0A0;
	Mon, 22 Jan 2024 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930024; cv=none; b=Vh98oXaY9ZzPNduiXQKcY36ZASJ04rcq5+pJ3haNoPQJnhYeY5JOv1pax9PDg3z8Mp+hpwrbzk/4K6umHH8zRa5fvpf5kRVgm1yOZWUU3Zgm2qETXbCxawbSMZijnqcjTWS4HBUQVsmcMY/kumNqkvMqU3lMJZFl1ElxY/xGNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930024; c=relaxed/simple;
	bh=CKsYSzD4PPHIin1HDP45hy6N8j4GjA4I8j9w2Kl7nY8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qCaNmRDONzeWoX8oTUK5pwwWYmyHOD5FQ+ZbzD2T74JBSa9Tv64/NNk0R6RiL/spoS2ZvNTy7blASaGqjY5oK8myJPKZMJoMhUqwoeTCAocNJqEAQhl7mfqw8zPTgU+H3qpELe9UKDqqR8sRZnyB/Y8pL3hHt73PbAINtUmy5nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBEygPfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C57CC43399;
	Mon, 22 Jan 2024 13:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705930024;
	bh=CKsYSzD4PPHIin1HDP45hy6N8j4GjA4I8j9w2Kl7nY8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UBEygPfISeRjzoYLuTyfeycDQuaHeMdDhZwJ2eqXnLB+yp88ot6XsLCgqm0TLY10j
	 QwaW7ZCPKTK3GXUuvLjkDXBF/yr7HLd9hZ28qaBnMnVOfWm7ie3MsYrupqdnSSnBj1
	 UhegN1BHEHRQdmJOgCoXp5POQRB/CQ5bP0noHsczvIKvil3zC1ebNfHFIWuaQY/k7B
	 doMA8Sqqo1SUYu8rvd0qGAl0JlP12rVk4qNzvdlZB0yIWemXESduEMsJv3cGsoWAzm
	 R90dCkMG+tWvmyG9AGs8AVNuTgmhwW0sWkC4Em5HJXeKKa5Hble1HmkcHd4cyFMAWP
	 bXNKYhS495adg==
Message-ID: <2a59c1ce7320af8d645540522c87ae1b44f76a3d.camel@kernel.org>
Subject: Re: [PATCH v6 2/3] NFSD: add write_version to netlink command
From: Jeff Layton <jlayton@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, neilb@suse.de, kuba@kernel.org, 
	chuck.lever@oracle.com, horms@kernel.org, netdev@vger.kernel.org
Date: Mon, 22 Jan 2024 08:27:01 -0500
In-Reply-To: <fd54905f4d66b84afbc9a8270261d27ad509f0a0.1705771400.git.lorenzo@kernel.org>
References: <cover.1705771400.git.lorenzo@kernel.org>
	 <fd54905f4d66b84afbc9a8270261d27ad509f0a0.1705771400.git.lorenzo@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-01-20 at 18:33 +0100, Lorenzo Bianconi wrote:
> Introduce write_version netlink command. For version-set, userspace is
> expected to provide a NFS major/minor version list it wants to enable
> (all the other ones will be disabled).
>=20

To be clear, this is a departure from how the existing interface works.
The "versions" file was an imperative interface. You write "+3" to it,
and that just enables v3.

This is a declarative interface. If a version is not listed in the set,
then it will be _disabled_. I think this is a better way to do it, given
the way that rpc.nfsd works, but we should all be aware that this is a
change in behavior.

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  34 +++++
>  fs/nfsd/netlink.c                     |  23 ++++
>  fs/nfsd/netlink.h                     |   5 +
>  fs/nfsd/nfsctl.c                      | 140 ++++++++++++++++++++
>  include/uapi/linux/nfsd_netlink.h     |  17 +++
>  tools/net/ynl/generated/nfsd-user.c   | 176 ++++++++++++++++++++++++++
>  tools/net/ynl/generated/nfsd-user.h   |  53 ++++++++
>  7 files changed, 448 insertions(+)
>=20
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlin=
k/specs/nfsd.yaml
> index c92e1425d316..30f18798e84e 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -68,6 +68,23 @@ attribute-sets:
>        -
>          name: threads
>          type: u32
> +  -
> +    name: nfs-version
> +    attributes:
> +      -
> +        name: major
> +        type: u32
> +      -
> +        name: minor
> +        type: u32
> +  -
> +    name: server-proto
> +    attributes:
> +      -
> +        name: version
> +        type: nest
> +        nested-attributes: nfs-version
> +        multi-attr: true
> =20
>  operations:
>    list:
> @@ -110,3 +127,20 @@ operations:
>          reply:
>            attributes:
>              - threads
> +    -
> +      name: version-set
> +      doc: set nfs enabled versions
> +      attribute-set: server-proto
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - version
> +    -
> +      name: version-get
> +      doc: get nfs enabled versions
> +      attribute-set: server-proto
> +      do:
> +        reply:
> +          attributes:
> +            - version
> diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> index 1a59a8e6c7e2..5cbbd3295543 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -10,11 +10,22 @@
> =20
>  #include <uapi/linux/nfsd_netlink.h>
> =20
> +/* Common nested types */
> +const struct nla_policy nfsd_nfs_version_nl_policy[NFSD_A_NFS_VERSION_MI=
NOR + 1] =3D {
> +	[NFSD_A_NFS_VERSION_MAJOR] =3D { .type =3D NLA_U32, },
> +	[NFSD_A_NFS_VERSION_MINOR] =3D { .type =3D NLA_U32, },
> +};
> +
>  /* NFSD_CMD_THREADS_SET - do */
>  static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVER_=
WORKER_THREADS + 1] =3D {
>  	[NFSD_A_SERVER_WORKER_THREADS] =3D { .type =3D NLA_U32, },
>  };
> =20
> +/* NFSD_CMD_VERSION_SET - do */
> +static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SERVER_=
PROTO_VERSION + 1] =3D {
> +	[NFSD_A_SERVER_PROTO_VERSION] =3D NLA_POLICY_NESTED(nfsd_nfs_version_nl=
_policy),
> +};
> +
>  /* Ops table for nfsd */
>  static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  	{
> @@ -36,6 +47,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  		.doit	=3D nfsd_nl_threads_get_doit,
>  		.flags	=3D GENL_CMD_CAP_DO,
>  	},
> +	{
> +		.cmd		=3D NFSD_CMD_VERSION_SET,
> +		.doit		=3D nfsd_nl_version_set_doit,
> +		.policy		=3D nfsd_version_set_nl_policy,
> +		.maxattr	=3D NFSD_A_SERVER_PROTO_VERSION,
> +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> +	},
> +	{
> +		.cmd	=3D NFSD_CMD_VERSION_GET,
> +		.doit	=3D nfsd_nl_version_get_doit,
> +		.flags	=3D GENL_CMD_CAP_DO,
> +	},
>  };
> =20
>  struct genl_family nfsd_nl_family __ro_after_init =3D {
> diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> index 4137fac477e4..c9a1be693fef 100644
> --- a/fs/nfsd/netlink.h
> +++ b/fs/nfsd/netlink.h
> @@ -11,6 +11,9 @@
> =20
>  #include <uapi/linux/nfsd_netlink.h>
> =20
> +/* Common nested types */
> +extern const struct nla_policy nfsd_nfs_version_nl_policy[NFSD_A_NFS_VER=
SION_MINOR + 1];
> +
>  int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
>  int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
> =20
> @@ -18,6 +21,8 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
>  				  struct netlink_callback *cb);
>  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *info=
);
>  int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info=
);
> +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info=
);
> +int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info=
);
> =20
>  extern struct genl_family nfsd_nl_family;
> =20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 68718448d660..53af82303f93 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1756,6 +1756,146 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb,=
 struct genl_info *info)
>  	return err;
>  }
> =20
> +/**
> + * nfsd_nl_version_set_doit - set the nfs enabled versions
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *info=
)
> +{
> +	const struct nlattr *attr;
> +	struct nfsd_net *nn;
> +	int i, rem;
> +
> +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_PROTO_VERSION))
> +		return -EINVAL;
> +
> +	mutex_lock(&nfsd_mutex);
> +
> +	nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> +	if (nn->nfsd_serv) {
> +		mutex_unlock(&nfsd_mutex);
> +		return -EBUSY;
> +	}
> +
> +	/* clear current supported versions. */
> +	nfsd_vers(nn, 2, NFSD_CLEAR);
> +	nfsd_vers(nn, 3, NFSD_CLEAR);
> +	for (i =3D 0; i <=3D NFSD_SUPPORTED_MINOR_VERSION; i++)
> +		nfsd_minorversion(nn, i, NFSD_CLEAR);
> +
> +	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> +		struct nlattr *tb[ARRAY_SIZE(nfsd_nfs_version_nl_policy)];
> +		u32 major, minor =3D 0;
> +
> +		if (nla_type(attr) !=3D NFSD_A_SERVER_PROTO_VERSION)
> +			continue;
> +
> +		if (nla_parse_nested(tb, ARRAY_SIZE(tb), attr,
> +				     nfsd_nfs_version_nl_policy,
> +				     info->extack) < 0)
> +			continue;
> +
> +		if (!tb[NFSD_A_NFS_VERSION_MAJOR])
> +			continue;
> +
> +		major =3D nla_get_u32(tb[NFSD_A_NFS_VERSION_MAJOR]);
> +		if (tb[NFSD_A_NFS_VERSION_MINOR])
> +			minor =3D nla_get_u32(tb[NFSD_A_NFS_VERSION_MINOR]);
> +
> +		switch (major) {
> +		case 4:
> +			nfsd_minorversion(nn, minor, NFSD_SET);
> +			break;
> +		case 3:
> +		case 2:
> +			if (!minor)
> +				nfsd_vers(nn, major, NFSD_SET);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&nfsd_mutex);
> +
> +	return 0;
> +}
> +
> +/**
> + * nfsd_nl_version_get_doit - get the nfs enabled versions
> + * @skb: reply buffer
> + * @info: netlink metadata and command arguments
> + *
> + * Return 0 on success or a negative errno.
> + */
> +int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info=
)
> +{
> +	struct nfsd_net *nn;
> +	int i, err;
> +	void *hdr;
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
> +	mutex_lock(&nfsd_mutex);
> +	nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> +
> +	for (i =3D 2; i <=3D 4; i++) {
> +		int j;
> +
> +		for (j =3D 0; j <=3D NFSD_SUPPORTED_MINOR_VERSION; j++) {
> +			struct nlattr *attr;
> +
> +			if (!nfsd_vers(nn, i, NFSD_TEST))
> +				continue;
> +
> +			/* NFSv{2,3} does not support minor numbers */
> +			if (i < 4 && j)
> +				continue;
> +
> +			if (i =3D=3D 4 && !nfsd_minorversion(nn, j, NFSD_TEST))
> +				continue;
> +
> +			attr =3D nla_nest_start_noflag(skb,
> +					NFSD_A_SERVER_PROTO_VERSION);
> +			if (!attr) {
> +				err =3D -EINVAL;
> +				goto err_nfsd_unlock;
> +			}
> +
> +			if (nla_put_u32(skb, NFSD_A_NFS_VERSION_MAJOR, i) ||
> +			    nla_put_u32(skb, NFSD_A_NFS_VERSION_MINOR, j)) {
> +				err =3D -EINVAL;
> +				goto err_nfsd_unlock;
> +			}
> +
> +			nla_nest_end(skb, attr);
> +		}
> +	}
> +
> +	mutex_unlock(&nfsd_mutex);
> +	genlmsg_end(skb, hdr);
> +
> +	return genlmsg_reply(skb, info);
> +
> +err_nfsd_unlock:
> +	mutex_unlock(&nfsd_mutex);
> +err_free_msg:
> +	nlmsg_free(skb);
> +
> +	return err;
> +}
> +
>  /**
>   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
>   * @net: a freshly-created network namespace
> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_=
netlink.h
> index 1b6fe1f9ed0e..2a06f9fe6fe9 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -36,10 +36,27 @@ enum {
>  	NFSD_A_SERVER_WORKER_MAX =3D (__NFSD_A_SERVER_WORKER_MAX - 1)
>  };
> =20
> +enum {
> +	NFSD_A_NFS_VERSION_MAJOR =3D 1,
> +	NFSD_A_NFS_VERSION_MINOR,
> +
> +	__NFSD_A_NFS_VERSION_MAX,
> +	NFSD_A_NFS_VERSION_MAX =3D (__NFSD_A_NFS_VERSION_MAX - 1)
> +};
> +
> +enum {
> +	NFSD_A_SERVER_PROTO_VERSION =3D 1,
> +
> +	__NFSD_A_SERVER_PROTO_MAX,
> +	NFSD_A_SERVER_PROTO_MAX =3D (__NFSD_A_SERVER_PROTO_MAX - 1)
> +};
> +
>  enum {
>  	NFSD_CMD_RPC_STATUS_GET =3D 1,
>  	NFSD_CMD_THREADS_SET,
>  	NFSD_CMD_THREADS_GET,
> +	NFSD_CMD_VERSION_SET,
> +	NFSD_CMD_VERSION_GET,
> =20
>  	__NFSD_CMD_MAX,
>  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/generate=
d/nfsd-user.c
> index f4121a52ccf8..ad498543f464 100644
> --- a/tools/net/ynl/generated/nfsd-user.c
> +++ b/tools/net/ynl/generated/nfsd-user.c
> @@ -17,6 +17,8 @@ static const char * const nfsd_op_strmap[] =3D {
>  	[NFSD_CMD_RPC_STATUS_GET] =3D "rpc-status-get",
>  	[NFSD_CMD_THREADS_SET] =3D "threads-set",
>  	[NFSD_CMD_THREADS_GET] =3D "threads-get",
> +	[NFSD_CMD_VERSION_SET] =3D "version-set",
> +	[NFSD_CMD_VERSION_GET] =3D "version-get",
>  };
> =20
>  const char *nfsd_op_str(int op)
> @@ -27,6 +29,16 @@ const char *nfsd_op_str(int op)
>  }
> =20
>  /* Policies */
> +struct ynl_policy_attr nfsd_nfs_version_policy[NFSD_A_NFS_VERSION_MAX + =
1] =3D {
> +	[NFSD_A_NFS_VERSION_MAJOR] =3D { .name =3D "major", .type =3D YNL_PT_U3=
2, },
> +	[NFSD_A_NFS_VERSION_MINOR] =3D { .name =3D "minor", .type =3D YNL_PT_U3=
2, },
> +};
> +
> +struct ynl_policy_nest nfsd_nfs_version_nest =3D {
> +	.max_attr =3D NFSD_A_NFS_VERSION_MAX,
> +	.table =3D nfsd_nfs_version_policy,
> +};
> +
>  struct ynl_policy_attr nfsd_rpc_status_policy[NFSD_A_RPC_STATUS_MAX + 1]=
 =3D {
>  	[NFSD_A_RPC_STATUS_XID] =3D { .name =3D "xid", .type =3D YNL_PT_U32, },
>  	[NFSD_A_RPC_STATUS_FLAGS] =3D { .name =3D "flags", .type =3D YNL_PT_U32=
, },
> @@ -58,7 +70,60 @@ struct ynl_policy_nest nfsd_server_worker_nest =3D {
>  	.table =3D nfsd_server_worker_policy,
>  };
> =20
> +struct ynl_policy_attr nfsd_server_proto_policy[NFSD_A_SERVER_PROTO_MAX =
+ 1] =3D {
> +	[NFSD_A_SERVER_PROTO_VERSION] =3D { .name =3D "version", .type =3D YNL_=
PT_NEST, .nest =3D &nfsd_nfs_version_nest, },
> +};
> +
> +struct ynl_policy_nest nfsd_server_proto_nest =3D {
> +	.max_attr =3D NFSD_A_SERVER_PROTO_MAX,
> +	.table =3D nfsd_server_proto_policy,
> +};
> +
>  /* Common nested types */
> +void nfsd_nfs_version_free(struct nfsd_nfs_version *obj)
> +{
> +}
> +
> +int nfsd_nfs_version_put(struct nlmsghdr *nlh, unsigned int attr_type,
> +			 struct nfsd_nfs_version *obj)
> +{
> +	struct nlattr *nest;
> +
> +	nest =3D mnl_attr_nest_start(nlh, attr_type);
> +	if (obj->_present.major)
> +		mnl_attr_put_u32(nlh, NFSD_A_NFS_VERSION_MAJOR, obj->major);
> +	if (obj->_present.minor)
> +		mnl_attr_put_u32(nlh, NFSD_A_NFS_VERSION_MINOR, obj->minor);
> +	mnl_attr_nest_end(nlh, nest);
> +
> +	return 0;
> +}
> +
> +int nfsd_nfs_version_parse(struct ynl_parse_arg *yarg,
> +			   const struct nlattr *nested)
> +{
> +	struct nfsd_nfs_version *dst =3D yarg->data;
> +	const struct nlattr *attr;
> +
> +	mnl_attr_for_each_nested(attr, nested) {
> +		unsigned int type =3D mnl_attr_get_type(attr);
> +
> +		if (type =3D=3D NFSD_A_NFS_VERSION_MAJOR) {
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +			dst->_present.major =3D 1;
> +			dst->major =3D mnl_attr_get_u32(attr);
> +		} else if (type =3D=3D NFSD_A_NFS_VERSION_MINOR) {
> +			if (ynl_attr_validate(yarg, attr))
> +				return MNL_CB_ERROR;
> +			dst->_present.minor =3D 1;
> +			dst->minor =3D mnl_attr_get_u32(attr);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATUS_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>  /* NFSD_CMD_RPC_STATUS_GET - dump */
>  int nfsd_rpc_status_get_rsp_dump_parse(const struct nlmsghdr *nlh, void =
*data)
> @@ -291,6 +356,117 @@ struct nfsd_threads_get_rsp *nfsd_threads_get(struc=
t ynl_sock *ys)
>  	return NULL;
>  }
> =20
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_VERSION_SET =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +/* NFSD_CMD_VERSION_SET - do */
> +void nfsd_version_set_req_free(struct nfsd_version_set_req *req)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < req->n_version; i++)
> +		nfsd_nfs_version_free(&req->version[i]);
> +	free(req->version);
> +	free(req);
> +}
> +
> +int nfsd_version_set(struct ynl_sock *ys, struct nfsd_version_set_req *r=
eq)
> +{
> +	struct ynl_req_state yrs =3D { .yarg =3D { .ys =3D ys, }, };
> +	struct nlmsghdr *nlh;
> +	int err;
> +
> +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_VERSION_SET, 1)=
;
> +	ys->req_policy =3D &nfsd_server_proto_nest;
> +
> +	for (unsigned int i =3D 0; i < req->n_version; i++)
> +		nfsd_nfs_version_put(nlh, NFSD_A_SERVER_PROTO_VERSION, &req->version[i=
]);
> +
> +	err =3D ynl_exec(ys, nlh, &yrs);
> +	if (err < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_VERSION_GET =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +/* NFSD_CMD_VERSION_GET - do */
> +void nfsd_version_get_rsp_free(struct nfsd_version_get_rsp *rsp)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < rsp->n_version; i++)
> +		nfsd_nfs_version_free(&rsp->version[i]);
> +	free(rsp->version);
> +	free(rsp);
> +}
> +
> +int nfsd_version_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> +{
> +	struct ynl_parse_arg *yarg =3D data;
> +	struct nfsd_version_get_rsp *dst;
> +	unsigned int n_version =3D 0;
> +	const struct nlattr *attr;
> +	struct ynl_parse_arg parg;
> +	int i;
> +
> +	dst =3D yarg->data;
> +	parg.ys =3D yarg->ys;
> +
> +	if (dst->version)
> +		return ynl_error_parse(yarg, "attribute already present (server-proto.=
version)");
> +
> +	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> +		unsigned int type =3D mnl_attr_get_type(attr);
> +
> +		if (type =3D=3D NFSD_A_SERVER_PROTO_VERSION) {
> +			n_version++;
> +		}
> +	}
> +
> +	if (n_version) {
> +		dst->version =3D calloc(n_version, sizeof(*dst->version));
> +		dst->n_version =3D n_version;
> +		i =3D 0;
> +		parg.rsp_policy =3D &nfsd_nfs_version_nest;
> +		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> +			if (mnl_attr_get_type(attr) =3D=3D NFSD_A_SERVER_PROTO_VERSION) {
> +				parg.data =3D &dst->version[i];
> +				if (nfsd_nfs_version_parse(&parg, attr))
> +					return MNL_CB_ERROR;
> +				i++;
> +			}
> +		}
> +	}
> +
> +	return MNL_CB_OK;
> +}
> +
> +struct nfsd_version_get_rsp *nfsd_version_get(struct ynl_sock *ys)
> +{
> +	struct ynl_req_state yrs =3D { .yarg =3D { .ys =3D ys, }, };
> +	struct nfsd_version_get_rsp *rsp;
> +	struct nlmsghdr *nlh;
> +	int err;
> +
> +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_VERSION_GET, 1)=
;
> +	ys->req_policy =3D &nfsd_server_proto_nest;
> +	yrs.yarg.rsp_policy =3D &nfsd_server_proto_nest;
> +
> +	rsp =3D calloc(1, sizeof(*rsp));
> +	yrs.yarg.data =3D rsp;
> +	yrs.cb =3D nfsd_version_get_rsp_parse;
> +	yrs.rsp_cmd =3D NFSD_CMD_VERSION_GET;
> +
> +	err =3D ynl_exec(ys, nlh, &yrs);
> +	if (err < 0)
> +		goto err_free;
> +
> +	return rsp;
> +
> +err_free:
> +	nfsd_version_get_rsp_free(rsp);
> +	return NULL;
> +}
> +
>  const struct ynl_family ynl_nfsd_family =3D  {
>  	.name		=3D "nfsd",
>  };
> diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/generate=
d/nfsd-user.h
> index e162a4f20d91..d062ee8fa8b6 100644
> --- a/tools/net/ynl/generated/nfsd-user.h
> +++ b/tools/net/ynl/generated/nfsd-user.h
> @@ -19,6 +19,16 @@ extern const struct ynl_family ynl_nfsd_family;
>  const char *nfsd_op_str(int op);
> =20
>  /* Common nested types */
> +struct nfsd_nfs_version {
> +	struct {
> +		__u32 major:1;
> +		__u32 minor:1;
> +	} _present;
> +
> +	__u32 major;
> +	__u32 minor;
> +};
> +
>  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATUS_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
>  /* NFSD_CMD_RPC_STATUS_GET - dump */
>  struct nfsd_rpc_status_get_rsp_dump {
> @@ -111,4 +121,47 @@ void nfsd_threads_get_rsp_free(struct nfsd_threads_g=
et_rsp *rsp);
>   */
>  struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys);
> =20
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_VERSION_SET =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +/* NFSD_CMD_VERSION_SET - do */
> +struct nfsd_version_set_req {
> +	unsigned int n_version;
> +	struct nfsd_nfs_version *version;
> +};
> +
> +static inline struct nfsd_version_set_req *nfsd_version_set_req_alloc(vo=
id)
> +{
> +	return calloc(1, sizeof(struct nfsd_version_set_req));
> +}
> +void nfsd_version_set_req_free(struct nfsd_version_set_req *req);
> +
> +static inline void
> +__nfsd_version_set_req_set_version(struct nfsd_version_set_req *req,
> +				   struct nfsd_nfs_version *version,
> +				   unsigned int n_version)
> +{
> +	free(req->version);
> +	req->version =3D version;
> +	req->n_version =3D n_version;
> +}
> +
> +/*
> + * set nfs enabled versions
> + */
> +int nfsd_version_set(struct ynl_sock *ys, struct nfsd_version_set_req *r=
eq);
> +
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_VERSION_GET =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +/* NFSD_CMD_VERSION_GET - do */
> +
> +struct nfsd_version_get_rsp {
> +	unsigned int n_version;
> +	struct nfsd_nfs_version *version;
> +};
> +
> +void nfsd_version_get_rsp_free(struct nfsd_version_get_rsp *rsp);
> +
> +/*
> + * get nfs enabled versions
> + */
> +struct nfsd_version_get_rsp *nfsd_version_get(struct ynl_sock *ys);
> +
>  #endif /* _LINUX_NFSD_GEN_H */

--=20
Jeff Layton <jlayton@kernel.org>

