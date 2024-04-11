Return-Path: <linux-nfs+bounces-2771-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3061E8A21E9
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 00:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545961C214A8
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Apr 2024 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B824641A91;
	Thu, 11 Apr 2024 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tchABnOD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8716447A48;
	Thu, 11 Apr 2024 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875716; cv=none; b=J2tfcGRA7y3YgT0gTmVrytKTalSAC4w9Ud0YVVJhewIW2r0uE0/8fHKn4H5eBMQdenXRS29yT9jiI/G4yugmCKF6WH484lDdmtIcv9nCmUMcXUEWz2HyuCioDN1Iz2aRcaQ/pqg6icSP1lBQTYHajh8eX+gcMzl6qpth94VfjE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875716; c=relaxed/simple;
	bh=gJng5u1FflOc6JXB35VuzoIq8DbaRc2Tiby5pJW0Mjg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z/qP1V5ENNecc4psCq9mOH8XkbA2HGN8ISC7BQlkpVkLun4t9BoXwJsodeopx8h5MdhgYQsGguI8Xc6XpSavVA+hArvdm3BpIulzzXaJZUq1y2aXMqfvu/FmlDv3E5t7XFXyKEA/X7cfOWBPsuc3MiabWL7kzXqIrPFuuIlvLQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tchABnOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75302C072AA;
	Thu, 11 Apr 2024 22:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712875716;
	bh=gJng5u1FflOc6JXB35VuzoIq8DbaRc2Tiby5pJW0Mjg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tchABnODC5bZIgcohlJO8F2xthtL+L/+rRmR3tM/KzLU3KRgAXCog0IN2tS2LG2Z+
	 Qr0Wm7RyA16nfM1v9r6WQ1dOir0QuUu8RwVF86Ohy6VRJf5VhrDcMrdhwFsg5mYbT+
	 IsRjjJ7VgtD6vr0NtE6OQgAgvXSFlqofaiJ3hnGGguuCGWew3eibZx1bMrDEYi1KR4
	 gLtdH4zf50dwCev2HgnW/jV3sWkb1d9YA6gkMbvCIeu46iFqlNrWRnsanCKLDq73D3
	 BufvJu5n05lVX+AbsH+vNydg4l7E2r4j8euh4a4xasZ2mGYtYDU5q+2z5xAKWuQoy8
	 xG0TfaLiIPc1Q==
Message-ID: <0b14aee6b687501e5d4eb4f0e62928fbe016af40.camel@kernel.org>
Subject: Re: [PATCH v7 2/5] NFSD: add write_version to netlink command
From: Jeff Layton <jlayton@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com, chuck.lever@oracle.com, neilb@suse.de, 
	netdev@vger.kernel.org, kuba@kernel.org
Date: Thu, 11 Apr 2024 18:48:34 -0400
In-Reply-To: <bd85d1a774cb362ab9f70ac6a2af70d9ed7a309e.1712853394.git.lorenzo@kernel.org>
References: <cover.1712853393.git.lorenzo@kernel.org>
	 <bd85d1a774cb362ab9f70ac6a2af70d9ed7a309e.1712853394.git.lorenzo@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
	kZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-11 at 18:47 +0200, Lorenzo Bianconi wrote:
> Introduce write_version netlink command through a "declarative" interface=
.
> This patch introduces a change in behavior since for version-set userspac=
e
> is expected to provide a NFS major/minor version list it wants to enable
> while all the other ones will be disabled. (procfs write_version
> command implements imperative interface where the admin writes +3/-3 to
> enable/disable a single version.
>=20
> Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  Documentation/netlink/specs/nfsd.yaml |  37 +++++++
>  fs/nfsd/netlink.c                     |  24 ++++
>  fs/nfsd/netlink.h                     |   5 +
>  fs/nfsd/netns.h                       |   1 +
>  fs/nfsd/nfsctl.c                      | 153 ++++++++++++++++++++++++++
>  fs/nfsd/nfssvc.c                      |   3 +-
>  include/uapi/linux/nfsd_netlink.h     |  18 +++
>  7 files changed, 239 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlin=
k/specs/nfsd.yaml
> index c92e1425d316..cb93e3e37119 100644
> --- a/Documentation/netlink/specs/nfsd.yaml
> +++ b/Documentation/netlink/specs/nfsd.yaml
> @@ -68,6 +68,26 @@ attribute-sets:
>        -
>          name: threads
>          type: u32
> +  -
> +    name: version
> +    attributes:
> +      -
> +        name: major
> +        type: u32
> +      -
> +        name: minor
> +        type: u32
> +      -
> +        name: enabled
> +        type: flag
> +  -
> +    name: server-proto
> +    attributes:
> +      -
> +        name: version
> +        type: nest
> +        nested-attributes: version
> +        multi-attr: true
> =20
>  operations:
>    list:
> @@ -110,3 +130,20 @@ operations:
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
> index 1a59a8e6c7e2..75f609b57ceb 100644
> --- a/fs/nfsd/netlink.c
> +++ b/fs/nfsd/netlink.c
> @@ -10,11 +10,23 @@
> =20
>  #include <uapi/linux/nfsd_netlink.h>
> =20
> +/* Common nested types */
> +const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENABLED + =
1] =3D {
> +	[NFSD_A_VERSION_MAJOR] =3D { .type =3D NLA_U32, },
> +	[NFSD_A_VERSION_MINOR] =3D { .type =3D NLA_U32, },
> +	[NFSD_A_VERSION_ENABLED] =3D { .type =3D NLA_FLAG, },
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
> +	[NFSD_A_SERVER_PROTO_VERSION] =3D NLA_POLICY_NESTED(nfsd_version_nl_pol=
icy),
> +};
> +
>  /* Ops table for nfsd */
>  static const struct genl_split_ops nfsd_nl_ops[] =3D {
>  	{
> @@ -36,6 +48,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D {
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
> index 4137fac477e4..c7c0da275481 100644
> --- a/fs/nfsd/netlink.h
> +++ b/fs/nfsd/netlink.h
> @@ -11,6 +11,9 @@
> =20
>  #include <uapi/linux/nfsd_netlink.h>
> =20
> +/* Common nested types */
> +extern const struct nla_policy nfsd_version_nl_policy[NFSD_A_VERSION_ENA=
BLED + 1];
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
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index d4be519b5734..14ec15656320 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -218,6 +218,7 @@ struct nfsd_net {
>  /* Simple check to find out if a given net was properly initialized */
>  #define nfsd_netns_ready(nn) ((nn)->sessionid_hashtbl)
> =20
> +extern bool nfsd_support_version(int vers);
>  extern void nfsd_netns_free_versions(struct nfsd_net *nn);
> =20
>  extern unsigned int nfsd_net_id;
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 71608744e67f..341efab4eaa7 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1711,6 +1711,159 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb,=
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
> +		struct nlattr *tb[NFSD_A_VERSION_MAX + 1];
> +		u32 major, minor =3D 0;
> +		bool enabled;
> +
> +		if (nla_type(attr) !=3D NFSD_A_SERVER_PROTO_VERSION)
> +			continue;
> +
> +		if (nla_parse_nested(tb, NFSD_A_VERSION_MAX, attr,
> +				     nfsd_version_nl_policy, info->extack) < 0)
> +			continue;
> +
> +		if (!tb[NFSD_A_VERSION_MAJOR])
> +			continue;
> +
> +		major =3D nla_get_u32(tb[NFSD_A_VERSION_MAJOR]);
> +		if (tb[NFSD_A_VERSION_MINOR])
> +			minor =3D nla_get_u32(tb[NFSD_A_VERSION_MINOR]);
> +
> +		enabled =3D nla_get_flag(tb[NFSD_A_VERSION_ENABLED]);
> +
> +		switch (major) {
> +		case 4:
> +			nfsd_minorversion(nn, minor, enabled ? NFSD_SET : NFSD_CLEAR);
> +			break;
> +		case 3:
> +		case 2:
> +			if (!minor)
> +				nfsd_vers(nn, major, enabled ? NFSD_SET : NFSD_CLEAR);
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
> +			/* Don't record any versions the kernel doesn't have
> +			 * compiled in
> +			 */
> +			if (!nfsd_support_version(i))
> +				continue;
> +
> +			/* NFSv{2,3} does not support minor numbers */
> +			if (i < 4 && j)
> +				continue;
> +
> +			if (i =3D=3D 4 && !nfsd_minorversion(nn, j, NFSD_TEST))
> +				continue;
> +

I think this is not quite right. We don't want to skip returning a
minorversion just because it's not enabled. We want to return the entry
with the enabled flag cleared. I'd suggest just dropping the above if
statement entirely.

> +			attr =3D nla_nest_start_noflag(skb,
> +					NFSD_A_SERVER_PROTO_VERSION);
> +			if (!attr) {
> +				err =3D -EINVAL;
> +				goto err_nfsd_unlock;
> +			}
> +
> +			if (nla_put_u32(skb, NFSD_A_VERSION_MAJOR, i) ||
> +			    nla_put_u32(skb, NFSD_A_VERSION_MINOR, j)) {
> +				err =3D -EINVAL;
> +				goto err_nfsd_unlock;
> +			}
> +
> +			/* Set the enabled flag if the version is enabled */
> +			if (nfsd_vers(nn, i, NFSD_TEST) &&
> +			    (i < 4 || nfsd_minorversion(nn, j, NFSD_TEST)) &&
> +			    nla_put_flag(skb, NFSD_A_VERSION_ENABLED)) {
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
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index c0d17b92b249..4452a9bb9bbb 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -133,8 +133,7 @@ struct svc_program		nfsd_program =3D {
>  	.pg_rpcbind_set		=3D nfsd_rpcbind_set,
>  };
> =20
> -static bool
> -nfsd_support_version(int vers)
> +bool nfsd_support_version(int vers)
>  {
>  	if (vers >=3D NFSD_MINVERS && vers < NFSD_NRVERS)
>  		return nfsd_version[vers] !=3D NULL;
> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_=
netlink.h
> index 1b6fe1f9ed0e..ccf3e15fe160 100644
> --- a/include/uapi/linux/nfsd_netlink.h
> +++ b/include/uapi/linux/nfsd_netlink.h
> @@ -36,10 +36,28 @@ enum {
>  	NFSD_A_SERVER_WORKER_MAX =3D (__NFSD_A_SERVER_WORKER_MAX - 1)
>  };
> =20
> +enum {
> +	NFSD_A_VERSION_MAJOR =3D 1,
> +	NFSD_A_VERSION_MINOR,
> +	NFSD_A_VERSION_ENABLED,
> +
> +	__NFSD_A_VERSION_MAX,
> +	NFSD_A_VERSION_MAX =3D (__NFSD_A_VERSION_MAX - 1)
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

--=20
Jeff Layton <jlayton@kernel.org>

