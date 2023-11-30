Return-Path: <linux-nfs+bounces-211-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E6B7FF482
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 17:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3DF28160E
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 16:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750D054BDF;
	Thu, 30 Nov 2023 16:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyxWQggx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E3C54670;
	Thu, 30 Nov 2023 16:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD1DC433C8;
	Thu, 30 Nov 2023 16:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701361078;
	bh=DYc1e0crY39KMNwJvIVo8vaUSfxnYYcZbkeGfYkkrfw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KyxWQggxbxc2a5/ANQ9nWtkcA9gGSVvBFf9+wW1oleP6NXmF5jrPwXx5z07aorQzd
	 kgMQVOVJro7ZSB/uZsFa4B+N+sBa9SOYure2yBHolhxCWFCZFWu3NA/A1XrgY/nTUF
	 9rm5CKr1A/LDOQ19J+rvYC09sCiQWAJSvX2s27wNsaya10G8+GW526ICVkwbLSSj7Z
	 XmG9imUw4j2hMOQY9VWb9W2u+cNZwc7Uaa2XzA14cUMhGqCNWbiJcAXUhLwGN3D6QY
	 CY7Vf5aCDFOaeBg4wgDsvcCUyZ0o1iqGMkP39jkRfyEVsMJ/TVHjzzIOuHB9ww+6xS
	 DSXglW5ioYIVQ==
Message-ID: <56eb91d5e94d4c85b6c0087f6dc6e286c5b9ef8e.camel@kernel.org>
Subject: Re: [PATCH v5 2/3] NFSD: convert write_version to netlink command
From: Jeff Layton <jlayton@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com, neilb@suse.de, 
	netdev@vger.kernel.org, kuba@kernel.org
Date: Thu, 30 Nov 2023 11:17:56 -0500
In-Reply-To: <ZWhZsRKzoSya4gTM@lore-desk>
References: <cover.1701277475.git.lorenzo@kernel.org>
	 <8b47d2e3f704066204149653fd1bd86a64188f61.1701277475.git.lorenzo@kernel.org>
	 <88d91863e36a1e36f7770aa8a7f42853250e3d55.camel@kernel.org>
	 <ZWhZsRKzoSya4gTM@lore-desk>
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

On Thu, 2023-11-30 at 10:45 +0100, Lorenzo Bianconi wrote:
> > On Wed, 2023-11-29 at 18:12 +0100, Lorenzo Bianconi wrote:
> > > Introduce write_version netlink command similar to the ones available
> > > through the procfs.
> > >=20
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > > =A0Documentation/netlink/specs/nfsd.yaml |  32 ++++++++
> > > =A0fs/nfsd/netlink.c                     |  19 +++++
> > > =A0fs/nfsd/netlink.h                     |   3 +
> > > =A0fs/nfsd/nfsctl.c                      | 105 ++++++++++++++++++++++=
++++
> > > =A0include/uapi/linux/nfsd_netlink.h     |  11 +++
> > > =A0tools/net/ynl/generated/nfsd-user.c   |  81 ++++++++++++++++++++
> > > =A0tools/net/ynl/generated/nfsd-user.h   |  55 ++++++++++++++
> > > =A07 files changed, 306 insertions(+)
> > >=20
> > > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/ne=
tlink/specs/nfsd.yaml
> > > index c92e1425d316..6c5e42bb20f6 100644
> > > --- a/Documentation/netlink/specs/nfsd.yaml
> > > +++ b/Documentation/netlink/specs/nfsd.yaml
> > > @@ -68,6 +68,18 @@ attribute-sets:
> > > =A0=A0=A0=A0=A0=A0=A0-
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0name: threads
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0type: u32
> > > +  -
> > > +    name: server-version
> > > +    attributes:
> > > +      -
> > > +        name: major
> > > +        type: u32
> > > +      -
> > > +        name: minor
> > > +        type: u32
> > > +      -
> > > +        name: status
> > > +        type: u8
> > > =A0
> > >=20
> > >=20
> > >=20
> > > =A0operations:
> > > =A0=A0=A0list:
> > > @@ -110,3 +122,23 @@ operations:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0reply:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0attributes:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0- threads
> > > +    -
> > > +      name: version-set
> > > +      doc: enable/disable server version
> > > +      attribute-set: server-version
> > > +      flags: [ admin-perm ]
> > > +      do:
> > > +        request:
> > > +          attributes:
> > > +            - major
> > > +            - minor
> > > +            - status
> > > +    -
> > > +      name: version-get
> > > +      doc: dump server versions
> > > +      attribute-set: server-version
> > > +      dump:
> > > +        reply:
> > > +          attributes:
> > > +            - major
> > > +            - minor
> > > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > > index 1a59a8e6c7e2..0608a7bd193b 100644
> > > --- a/fs/nfsd/netlink.c
> > > +++ b/fs/nfsd/netlink.c
> > > @@ -15,6 +15,13 @@ static const struct nla_policy nfsd_threads_set_nl=
_policy[NFSD_A_SERVER_WORKER_T
> > > =A0	[NFSD_A_SERVER_WORKER_THREADS] =3D { .type =3D NLA_U32, },
> > > =A0};
> > > =A0
> > >=20
> > >=20
> > >=20
> > > +/* NFSD_CMD_VERSION_SET - do */
> > > +static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SER=
VER_VERSION_STATUS + 1] =3D {
> > > +	[NFSD_A_SERVER_VERSION_MAJOR] =3D { .type =3D NLA_U32, },
> > > +	[NFSD_A_SERVER_VERSION_MINOR] =3D { .type =3D NLA_U32, },
> > > +	[NFSD_A_SERVER_VERSION_STATUS] =3D { .type =3D NLA_U8, },
> > > +};
> > > +
> > > =A0/* Ops table for nfsd */
> > > =A0static const struct genl_split_ops nfsd_nl_ops[] =3D {
> > > =A0	{
> > > @@ -36,6 +43,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =
=3D {
> > > =A0		.doit	=3D nfsd_nl_threads_get_doit,
> > > =A0		.flags	=3D GENL_CMD_CAP_DO,
> > > =A0	},
> > > +	{
> > > +		.cmd		=3D NFSD_CMD_VERSION_SET,
> > > +		.doit		=3D nfsd_nl_version_set_doit,
> > > +		.policy		=3D nfsd_version_set_nl_policy,
> > > +		.maxattr	=3D NFSD_A_SERVER_VERSION_STATUS,
> > > +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > +	},
> > > +	{
> > > +		.cmd	=3D NFSD_CMD_VERSION_GET,
> > > +		.dumpit	=3D nfsd_nl_version_get_dumpit,
> > > +		.flags	=3D GENL_CMD_CAP_DUMP,
> > > +	},
> > > =A0};
> > > =A0
> > >=20
> > >=20
> > >=20
> > > =A0struct genl_family nfsd_nl_family __ro_after_init =3D {
> > > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > > index 4137fac477e4..7d203cec08e4 100644
> > > --- a/fs/nfsd/netlink.h
> > > +++ b/fs/nfsd/netlink.h
> > > @@ -18,6 +18,9 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *s=
kb,
> > > =A0				  struct netlink_callback *cb);
> > > =A0int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info=
 *info);
> > > =A0int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info=
 *info);
> > > +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *=
info);
> > > +int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
> > > +			       struct netlink_callback *cb);
> > > =A0
> > >=20
> > >=20
> > >=20
> > > =A0extern struct genl_family nfsd_nl_family;
> > > =A0
> > >=20
> > >=20
> > >=20
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 130b3d937a79..f04430f79687 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -1757,6 +1757,111 @@ int nfsd_nl_threads_get_doit(struct sk_buff *=
skb, struct genl_info *info)
> > > =A0	return err;
> > > =A0}
> > > =A0
> > >=20
> > >=20
> > >=20
> > > +/**
> > > + * nfsd_nl_version_set_doit - enable/disable the provided nfs server=
 version
> > > + * @skb: reply buffer
> > > + * @info: netlink metadata and command arguments
> > > + *
> > > + * Return 0 on success or a negative errno.
> > > + */
> > > +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *=
info)
> > > +{
> > > +	struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_i=
d);
> > > +	enum vers_op cmd;
> > > +	u32 major, minor;
> > > +	u8 status;
> > > +	int ret;
> > > +
> > > +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_VERSION_MAJOR) ||
> > > +	    GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_VERSION_MINOR) ||
> > > +	    GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_VERSION_STATUS))
> > > +		return -EINVAL;
> > > +
> > > +	major =3D nla_get_u32(info->attrs[NFSD_A_SERVER_VERSION_MAJOR]);
> > > +	minor =3D nla_get_u32(info->attrs[NFSD_A_SERVER_VERSION_MINOR]);
> > > +
> > > +	status =3D nla_get_u32(info->attrs[NFSD_A_SERVER_VERSION_STATUS]);
> > > +	cmd =3D !!status ? NFSD_SET : NFSD_CLEAR;
> > > +
> > > +	mutex_lock(&nfsd_mutex);
> > > +	switch (major) {
> > > +	case 4:
> > > +		ret =3D nfsd_minorversion(nn, minor, cmd);
> > > +		break;
> > > +	case 2:
> > > +	case 3:
> > > +		if (!minor) {
> > > +			ret =3D nfsd_vers(nn, major, cmd);
> > > +			break;
> > > +		}
> > > +		fallthrough;
> > > +	default:
> > > +		ret =3D -EINVAL;
> > > +		break;
> > > +	}
> > > +	mutex_unlock(&nfsd_mutex);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_version_get_doit - Handle verion_get dumpit
> > > + * @skb: reply buffer
> > > + * @cb: netlink metadata and command arguments
> > > + *
> > > + * Returns the size of the reply or a negative errno.
> > > + */
> > > +int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
> > > +			       struct netlink_callback *cb)
> > > +{
> > > +	struct nfsd_net *nn =3D net_generic(sock_net(skb->sk), nfsd_net_id)=
;
> > > +	int i, ret =3D -ENOMEM;
> > > +
> > > +	mutex_lock(&nfsd_mutex);
> > > +
> > > +	for (i =3D 2; i <=3D 4; i++) {
> > > +		int j;
> > > +
> > > +		if (i < cb->args[0]) /* already consumed */
> > > +			continue;
> > > +
> > > +		if (!nfsd_vers(nn, i, NFSD_AVAIL))
> > > +			continue;
> > > +
> > > +		for (j =3D 0; j <=3D NFSD_SUPPORTED_MINOR_VERSION; j++) {
> > > +			void *hdr;
> > > +
> > > +			if (!nfsd_vers(nn, i, NFSD_TEST))
> > > +				continue;
> > > +
> > > +			/* NFSv{2,3} does not support minor numbers */
> > > +			if (i < 4 && j)
> > > +				continue;
> > > +
> > > +			if (i =3D=3D 4 && !nfsd_minorversion(nn, j, NFSD_TEST))
> > > +				continue;
> > > +
> > > +			hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> > > +					  cb->nlh->nlmsg_seq, &nfsd_nl_family,
> > > +					  0, NFSD_CMD_VERSION_GET);
> > > +			if (!hdr)
> > > +				goto out;
> > > +
> > > +			if (nla_put_u32(skb, NFSD_A_SERVER_VERSION_MAJOR, i) ||
> > > +			    nla_put_u32(skb, NFSD_A_SERVER_VERSION_MINOR, j))
> > > +				goto out;
> > > +
> > > +			genlmsg_end(skb, hdr);
> > > +		}
> > > +	}
> > > +	cb->args[0] =3D i;
> > > +	ret =3D skb->len;
> > > +out:
> > > +	mutex_unlock(&nfsd_mutex);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > =A0/**
> > > =A0=A0* nfsd_net_init - Prepare the nfsd_net portion of a new net nam=
espace
> > > =A0=A0* @net: a freshly-created network namespace
> > > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/n=
fsd_netlink.h
> > > index 1b6fe1f9ed0e..1b3340f31baa 100644
> > > --- a/include/uapi/linux/nfsd_netlink.h
> > > +++ b/include/uapi/linux/nfsd_netlink.h
> > > @@ -36,10 +36,21 @@ enum {
> > > =A0	NFSD_A_SERVER_WORKER_MAX =3D (__NFSD_A_SERVER_WORKER_MAX - 1)
> > > =A0};
> > > =A0
> > >=20
> > >=20
> > >=20
> > > +enum {
> > > +	NFSD_A_SERVER_VERSION_MAJOR =3D 1,
> > > +	NFSD_A_SERVER_VERSION_MINOR,
> > > +	NFSD_A_SERVER_VERSION_STATUS,
> > > +
> > > +	__NFSD_A_SERVER_VERSION_MAX,
> > > +	NFSD_A_SERVER_VERSION_MAX =3D (__NFSD_A_SERVER_VERSION_MAX - 1)
> > > +};
> > > +
> > > =A0enum {
> > > =A0	NFSD_CMD_RPC_STATUS_GET =3D 1,
> > > =A0	NFSD_CMD_THREADS_SET,
> > > =A0	NFSD_CMD_THREADS_GET,
> > > +	NFSD_CMD_VERSION_SET,
> > > +	NFSD_CMD_VERSION_GET,
> > > =A0
> > >=20
> > >=20
> > >=20
> > > =A0	__NFSD_CMD_MAX,
> > > =A0	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> > > diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/gene=
rated/nfsd-user.c
> > > index 9768328a7751..4cb71c3cd18d 100644
> > > --- a/tools/net/ynl/generated/nfsd-user.c
> > > +++ b/tools/net/ynl/generated/nfsd-user.c
> > > @@ -17,6 +17,8 @@ static const char * const nfsd_op_strmap[] =3D {
> > > =A0	[NFSD_CMD_RPC_STATUS_GET] =3D "rpc-status-get",
> > > =A0	[NFSD_CMD_THREADS_SET] =3D "threads-set",
> > > =A0	[NFSD_CMD_THREADS_GET] =3D "threads-get",
> > > +	[NFSD_CMD_VERSION_SET] =3D "version-set",
> > > +	[NFSD_CMD_VERSION_GET] =3D "version-get",
> > > =A0};
> > > =A0
> > >=20
> > >=20
> > >=20
> > > =A0const char *nfsd_op_str(int op)
> > > @@ -58,6 +60,17 @@ struct ynl_policy_nest nfsd_server_worker_nest =3D=
 {
> > > =A0	.table =3D nfsd_server_worker_policy,
> > > =A0};
> > > =A0
> > >=20
> > >=20
> > >=20
> > > +struct ynl_policy_attr nfsd_server_version_policy[NFSD_A_SERVER_VERS=
ION_MAX + 1] =3D {
> > > +	[NFSD_A_SERVER_VERSION_MAJOR] =3D { .name =3D "major", .type =3D YN=
L_PT_U32, },
> > > +	[NFSD_A_SERVER_VERSION_MINOR] =3D { .name =3D "minor", .type =3D YN=
L_PT_U32, },
> > > +	[NFSD_A_SERVER_VERSION_STATUS] =3D { .name =3D "status", .type =3D =
YNL_PT_U8, },
> > > +};
> > > +
> > > +struct ynl_policy_nest nfsd_server_version_nest =3D {
> > > +	.max_attr =3D NFSD_A_SERVER_VERSION_MAX,
> > > +	.table =3D nfsd_server_version_policy,
> > > +};
> > > +
> > > =A0/* Common nested types */
> > > =A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATUS_=
GET =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > =A0/* NFSD_CMD_RPC_STATUS_GET - dump */
> > > @@ -290,6 +303,74 @@ struct nfsd_threads_get_rsp *nfsd_threads_get(st=
ruct ynl_sock *ys)
> > > =A0	return NULL;
> > > =A0}
> > > =A0
> > >=20
> > >=20
> > >=20
> > > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_VERSION_SET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > +/* NFSD_CMD_VERSION_SET - do */
> > > +void nfsd_version_set_req_free(struct nfsd_version_set_req *req)
> > > +{
> > > +	free(req);
> > > +}
> > > +
> > > +int nfsd_version_set(struct ynl_sock *ys, struct nfsd_version_set_re=
q *req)
> > > +{
> > > +	struct nlmsghdr *nlh;
> > > +	int err;
> > > +
> > > +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_VERSION_SET=
, 1);
> > > +	ys->req_policy =3D &nfsd_server_version_nest;
> > > +
> > > +	if (req->_present.major)
> > > +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_VERSION_MAJOR, req->major);
> > > +	if (req->_present.minor)
> > > +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_VERSION_MINOR, req->minor);
> > > +	if (req->_present.status)
> > > +		mnl_attr_put_u8(nlh, NFSD_A_SERVER_VERSION_STATUS, req->status);
> > > +
> > > +	err =3D ynl_exec(ys, nlh, NULL);
> > > +	if (err < 0)
> > > +		return -1;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_VERSION_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > +/* NFSD_CMD_VERSION_GET - dump */
> > > +void nfsd_version_get_list_free(struct nfsd_version_get_list *rsp)
> > > +{
> > > +	struct nfsd_version_get_list *next =3D rsp;
> > > +
> > > +	while ((void *)next !=3D YNL_LIST_END) {
> > > +		rsp =3D next;
> > > +		next =3D rsp->next;
> > > +
> > > +		free(rsp);
> > > +	}
> > > +}
> > > +
> > > +struct nfsd_version_get_list *nfsd_version_get_dump(struct ynl_sock =
*ys)
> > > +{
> > > +	struct ynl_dump_state yds =3D {};
> > > +	struct nlmsghdr *nlh;
> > > +	int err;
> > > +
> > > +	yds.ys =3D ys;
> > > +	yds.alloc_sz =3D sizeof(struct nfsd_version_get_list);
> > > +	yds.cb =3D nfsd_version_get_rsp_parse;
> > > +	yds.rsp_cmd =3D NFSD_CMD_VERSION_GET;
> > > +	yds.rsp_policy =3D &nfsd_server_version_nest;
> > > +
> > > +	nlh =3D ynl_gemsg_start_dump(ys, ys->family_id, NFSD_CMD_VERSION_GE=
T, 1);
> > > +
> > > +	err =3D ynl_exec_dump(ys, nlh, &yds);
> > > +	if (err < 0)
> > > +		goto free_list;
> > > +
> > > +	return yds.first;
> > > +
> > > +free_list:
> > > +	nfsd_version_get_list_free(yds.first);
> > > +	return NULL;
> > > +}
> > > +
> > > =A0const struct ynl_family ynl_nfsd_family =3D  {
> > > =A0	.name		=3D "nfsd",
> > > =A0};
> > > diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/gene=
rated/nfsd-user.h
> > > index e162a4f20d91..e61c5a9e46fb 100644
> > > --- a/tools/net/ynl/generated/nfsd-user.h
> > > +++ b/tools/net/ynl/generated/nfsd-user.h
> > > @@ -111,4 +111,59 @@ void nfsd_threads_get_rsp_free(struct nfsd_threa=
ds_get_rsp *rsp);
> > > =A0=A0*/
> > > =A0struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys)=
;
> > > =A0
> > >=20
> > >=20
> > >=20
> > > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_VERSION_SET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > +/* NFSD_CMD_VERSION_SET - do */
> > > +struct nfsd_version_set_req {
> > > +	struct {
> > > +		__u32 major:1;
> > > +		__u32 minor:1;
> > > +		__u32 status:1;
> > > +	} _present;
> > > +
> > > +	__u32 major;
> > > +	__u32 minor;
> > > +	__u8 status;
> > > +};
> > > +
> >=20
> > This more or less mirrors how the "versions" file works today, but that
> > interface is quite klunky.=A0 We don't have a use case that requires th=
at
> > we do this piecemeal like this. I think we'd be better served with a
> > more declarative interface that reconfigures the supported versions in
> > one shot:
> >=20
> > Instead of having "major,minor,status" and potentially having to call
> > this command several times from userland, it seems like it would be
> > nicer to just have userland send down a list "major,minor" that should
> > be enabled, and then just let the kernel figure out whether to enable o=
r
> > disable each. An empty list could mean "disable everything".
> >=20
> > That's simpler to reason out as an interface from userland too. Trying
> > to keep track of the enabled and disabled versions and twiddle it is
> > really tricky in rpc.nfsd today.
>=20
> Ack. So far I have just converted the current implementation to netlink
> and I have not changed any logic. Anyway I am fine to change the current
> logic. Should we have 2 rpc.nfsd version in this case?
>=20

No. The goal is to make this a seamless change for systems
administrators who are already familiar with the userland tools.

I think what we want to aim for is to teach the existing rpc.nfsd to
speak netlink if it's available. If it's not, then it can fall back to
using the nfsdfs interfaces instead. Eventually (years from now) we can
remove the old interface support, once most everything in the field has
netlink support.


>=20
> > =A0
> >=20
> > > +static inline struct nfsd_version_set_req *nfsd_version_set_req_allo=
c(void)
> > > +{
> > > +	return calloc(1, sizeof(struct nfsd_version_set_req));
> > > +}
> > > +void nfsd_version_set_req_free(struct nfsd_version_set_req *req);
> > > +
> > > +static inline void
> > > +nfsd_version_set_req_set_major(struct nfsd_version_set_req *req, __u=
32 major)
> > > +{
> > > +	req->_present.major =3D 1;
> > > +	req->major =3D major;
> > > +}
> > > +static inline void
> > > +nfsd_version_set_req_set_minor(struct nfsd_version_set_req *req, __u=
32 minor)
> > > +{
> > > +	req->_present.minor =3D 1;
> > > +	req->minor =3D minor;
> > > +}
> > > +static inline void
> > > +nfsd_version_set_req_set_status(struct nfsd_version_set_req *req, __=
u8 status)
> > > +{
> > > +	req->_present.status =3D 1;
> > > +	req->status =3D status;
> > > +}
> > > +
> > > +/*
> > > + * enable/disable server version
> > > + */
> > > +int nfsd_version_set(struct ynl_sock *ys, struct nfsd_version_set_re=
q *req);
> > > +
> > > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_VERSION_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > +/* NFSD_CMD_VERSION_GET - dump */
> > > +struct nfsd_version_get_list {
> > > +	struct nfsd_version_get_list *next;
> > > +	struct nfsd_version_get_rsp obj __attribute__ ((aligned (8)));
> > > +};
> > > +
> > > +void nfsd_version_get_list_free(struct nfsd_version_get_list *rsp);
> > > +
> > > +struct nfsd_version_get_list *nfsd_version_get_dump(struct ynl_sock =
*ys);
> > > +
> > > =A0#endif /* _LINUX_NFSD_GEN_H */
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>

--=20
Jeff Layton <jlayton@kernel.org>

