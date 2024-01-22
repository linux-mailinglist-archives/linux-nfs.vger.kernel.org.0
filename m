Return-Path: <linux-nfs+bounces-1247-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FFD836C71
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 18:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C95B1C268AF
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 17:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70985495CD;
	Mon, 22 Jan 2024 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCLpAqb5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49903495CA;
	Mon, 22 Jan 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938612; cv=none; b=PmKe7vibooPlz71ac0jEIfix0RtfQac9QOlDOY9VUdrRPaxGRMqVarTkP3Xt149VPbB0iiJJPuTXUDJtlaCnDVQSWf8afm/Mfx3g/Z9cEl6bbRjks+A8dN1xXLk0+Mav1Md0YT3QWOyeLNJzFvfbt1urZIY4dYyf1I9P73Z0Sgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938612; c=relaxed/simple;
	bh=p+TlGwVMmsU570L0oRcCtptBuGnNSCPIjEoFP+qEjcg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J0nITjzh9Bw9ZL7o6EyZ2AdAOrWvhjwxIBBM1TgHNieezT16dFht6L0XKIZMbRB5P7T+nAxHZgkjd4SsD4v/rf2iBJzXDTqP+rzeSg2I6re+W1PLWX1fdexnM7QmBjEM4zOkmg0BhWtl7dzANz0dTIiuuZ+FGhcKwAN35IB4Jng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCLpAqb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22F1C43390;
	Mon, 22 Jan 2024 15:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705938611;
	bh=p+TlGwVMmsU570L0oRcCtptBuGnNSCPIjEoFP+qEjcg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=DCLpAqb5qcg1+gMqsHcdpDrrXwpMn+7zDK7EH++8sWdTnt2juCVtqoZuNazimXclV
	 lBDMgFOsHwNklF64dzMo+2x7GSSuDXV1FnsWGZbY6dtKmtNh1RV1JJvKbgwvHsL/4O
	 erqOz657Ux8wdGO9Dk51vedL8yVg8cpz46ZaN5kC4RKtSF2xVSmCvwE74s6npJLKdz
	 IRmjQLXx2/9VNBGeujsacQLPSJvVYr7o0TW0vEiw9OyObBEwVauEIoXROKzowjLoyv
	 o5FVDmvKMIQAUGLRnaNVBNFwJtOG09Hr077JjqnabjZIsraT83HgAeFdAiavYjKH9e
	 476uqTxcm+8Ig==
Message-ID: <307cd36ead20741667418fae6bf921ce44f891ea.camel@kernel.org>
Subject: Re: [PATCH v6 3/3] NFSD: add write_ports to netlink command
From: Jeff Layton <jlayton@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com, neilb@suse.de, 
 kuba@kernel.org, chuck.lever@oracle.com, horms@kernel.org,
 netdev@vger.kernel.org
Date: Mon, 22 Jan 2024 10:50:09 -0500
In-Reply-To: <Za6LQ8tdSwFil-eO@lore-desk>
References: <cover.1705771400.git.lorenzo@kernel.org>
	 <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>
	 <9e3ae337dcf168c60c4cfd51aa0b2fc7b24bcbfb.camel@kernel.org>
	 <Za6LQ8tdSwFil-eO@lore-desk>
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

On Mon, 2024-01-22 at 16:35 +0100, Lorenzo Bianconi wrote:
> > On Sat, 2024-01-20 at 18:33 +0100, Lorenzo Bianconi wrote:
> > > Introduce write_ports netlink command. For listener-set, userspace is
> > > expected to provide a NFS listeners list it wants to enable (all the
> > > other ports will be closed).
> > >=20
> >=20
> > Ditto here. This is a change to a declarative interface, which I think
> > is a better way to handle this, but we should be aware of the change.
> >=20
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > > =A0Documentation/netlink/specs/nfsd.yaml |  37 +++++
> > > =A0fs/nfsd/netlink.c                     |  23 +++
> > > =A0fs/nfsd/netlink.h                     |   3 +
> > > =A0fs/nfsd/nfsctl.c                      | 196 ++++++++++++++++++++++=
++++
> > > =A0include/uapi/linux/nfsd_netlink.h     |  18 +++
> > > =A0tools/net/ynl/generated/nfsd-user.c   | 191 ++++++++++++++++++++++=
+++
> > > =A0tools/net/ynl/generated/nfsd-user.h   |  55 ++++++++
> > > =A07 files changed, 523 insertions(+)
> > >=20
> > > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/ne=
tlink/specs/nfsd.yaml
> > > index 30f18798e84e..296ff24b23ac 100644
> > > --- a/Documentation/netlink/specs/nfsd.yaml
> > > +++ b/Documentation/netlink/specs/nfsd.yaml
> > > @@ -85,6 +85,26 @@ attribute-sets:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0type: nest
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0nested-attributes: nfs-version
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0multi-attr: true
> > > +  -
> > > +    name: server-instance
> > > +    attributes:
> > > +      -
> > > +        name: transport-name
> > > +        type: string
> > > +      -
> > > +        name: port
> > > +        type: u32
> > > +      -
> > > +        name: inet-proto
> > > +        type: u16
> > > +  -
> > > +    name: server-listener
> > > +    attributes:
> > > +      -
> > > +        name: instance
> > > +        type: nest
> > > +        nested-attributes: server-instance
> > > +        multi-attr: true
> > > =A0
> > >=20
> > >=20
> > >=20
> > > =A0operations:
> > > =A0=A0=A0list:
> > > @@ -144,3 +164,20 @@ operations:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0reply:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0attributes:
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0- version
> > > +    -
> > > +      name: listener-set
> > > +      doc: set nfs running listeners
> > > +      attribute-set: server-listener
> > > +      flags: [ admin-perm ]
> > > +      do:
> > > +        request:
> > > +          attributes:
> > > +            - instance
> > > +    -
> > > +      name: listener-get
> > > +      doc: get nfs running listeners
> > > +      attribute-set: server-listener
> > > +      do:
> > > +        reply:
> > > +          attributes:
> > > +            - instance
> > > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > > index 5cbbd3295543..c772f9e14761 100644
> > > --- a/fs/nfsd/netlink.c
> > > +++ b/fs/nfsd/netlink.c
> > > @@ -16,6 +16,12 @@ const struct nla_policy nfsd_nfs_version_nl_policy=
[NFSD_A_NFS_VERSION_MINOR + 1]
> > > =A0	[NFSD_A_NFS_VERSION_MINOR] =3D { .type =3D NLA_U32, },
> > > =A0};
> > > =A0
> > >=20
> > >=20
> > >=20
> > > +const struct nla_policy nfsd_server_instance_nl_policy[NFSD_A_SERVER=
_INSTANCE_INET_PROTO + 1] =3D {
> > > +	[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] =3D { .type =3D NLA_NUL_STR=
ING, },
> > > +	[NFSD_A_SERVER_INSTANCE_PORT] =3D { .type =3D NLA_U32, },
> > > +	[NFSD_A_SERVER_INSTANCE_INET_PROTO] =3D { .type =3D NLA_U16, },
> > > +};
> > > +
> > > =A0/* NFSD_CMD_THREADS_SET - do */
> > > =A0static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_S=
ERVER_WORKER_THREADS + 1] =3D {
> > > =A0	[NFSD_A_SERVER_WORKER_THREADS] =3D { .type =3D NLA_U32, },
> > > @@ -26,6 +32,11 @@ static const struct nla_policy nfsd_version_set_nl=
_policy[NFSD_A_SERVER_PROTO_VE
> > > =A0	[NFSD_A_SERVER_PROTO_VERSION] =3D NLA_POLICY_NESTED(nfsd_nfs_vers=
ion_nl_policy),
> > > =A0};
> > > =A0
> > >=20
> > >=20
> > >=20
> > > +/* NFSD_CMD_LISTENER_SET - do */
> > > +static const struct nla_policy nfsd_listener_set_nl_policy[NFSD_A_SE=
RVER_LISTENER_INSTANCE + 1] =3D {
> > > +	[NFSD_A_SERVER_LISTENER_INSTANCE] =3D NLA_POLICY_NESTED(nfsd_server=
_instance_nl_policy),
> > > +};
> > > +
> > > =A0/* Ops table for nfsd */
> > > =A0static const struct genl_split_ops nfsd_nl_ops[] =3D {
> > > =A0	{
> > > @@ -59,6 +70,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =
=3D {
> > > =A0		.doit	=3D nfsd_nl_version_get_doit,
> > > =A0		.flags	=3D GENL_CMD_CAP_DO,
> > > =A0	},
> > > +	{
> > > +		.cmd		=3D NFSD_CMD_LISTENER_SET,
> > > +		.doit		=3D nfsd_nl_listener_set_doit,
> > > +		.policy		=3D nfsd_listener_set_nl_policy,
> > > +		.maxattr	=3D NFSD_A_SERVER_LISTENER_INSTANCE,
> > > +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > +	},
> > > +	{
> > > +		.cmd	=3D NFSD_CMD_LISTENER_GET,
> > > +		.doit	=3D nfsd_nl_listener_get_doit,
> > > +		.flags	=3D GENL_CMD_CAP_DO,
> > > +	},
> > > =A0};
> > > =A0
> > >=20
> > >=20
> > >=20
> > > =A0struct genl_family nfsd_nl_family __ro_after_init =3D {
> > > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > > index c9a1be693fef..10a26ad32cd0 100644
> > > --- a/fs/nfsd/netlink.h
> > > +++ b/fs/nfsd/netlink.h
> > > @@ -13,6 +13,7 @@
> > > =A0
> > >=20
> > >=20
> > >=20
> > > =A0/* Common nested types */
> > > =A0extern const struct nla_policy nfsd_nfs_version_nl_policy[NFSD_A_N=
FS_VERSION_MINOR + 1];
> > > +extern const struct nla_policy nfsd_server_instance_nl_policy[NFSD_A=
_SERVER_INSTANCE_INET_PROTO + 1];
> > > =A0
> > >=20
> > >=20
> > >=20
> > > =A0int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
> > > =A0int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
> > > @@ -23,6 +24,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, s=
truct genl_info *info);
> > > =A0int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info=
 *info);
> > > =A0int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info=
 *info);
> > > =A0int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info=
 *info);
> > > +int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info =
*info);
> > > +int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info =
*info);
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
> > > index 53af82303f93..562b209f2921 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -1896,6 +1896,202 @@ int nfsd_nl_version_get_doit(struct sk_buff *=
skb, struct genl_info *info)
> > > =A0	return err;
> > > =A0}
> > > =A0
> > >=20
> > >=20
> > >=20
> > > +/**
> > > + * nfsd_nl_listener_set_doit - set the nfs running listeners
> > > + * @skb: reply buffer
> > > + * @info: netlink metadata and command arguments
> > > + *
> > > + * Return 0 on success or a negative errno.
> > > + */
> > > +int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info =
*info)
> > > +{
> > > +	struct nlattr *tb[ARRAY_SIZE(nfsd_server_instance_nl_policy)];
> > > +	struct net *net =3D genl_info_net(info);
> > > +	struct svc_xprt *xprt, *tmp_xprt;
> > > +	const struct nlattr *attr;
> > > +	struct svc_serv *serv;
> > > +	const char *xcl_name;
> > > +	struct nfsd_net *nn;
> > > +	int port, err, rem;
> > > +	sa_family_t af;
> > > +
> > > +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_LISTENER_INSTANCE))
> > > +		return -EINVAL;
> > > +
> > > +	mutex_lock(&nfsd_mutex);
> > > +
> > > +	err =3D nfsd_create_serv(net);
> > > +	if (err) {
> > > +		mutex_unlock(&nfsd_mutex);
> > > +		return err;
> > > +	}
> > > +
> > > +	nn =3D net_generic(net, nfsd_net_id);
> > > +	serv =3D nn->nfsd_serv;
> > > +
> > > +	/* 1- create brand new listeners */
> > > +	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> > > +		if (nla_type(attr) !=3D NFSD_A_SERVER_LISTENER_INSTANCE)
> > > +			continue;
> > > +
> > > +		if (nla_parse_nested(tb, ARRAY_SIZE(tb), attr,
> > > +				     nfsd_server_instance_nl_policy,
> > > +				     info->extack) < 0)
> > > +			continue;
> > > +
> > > +		if (!tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] ||
> > > +		    !tb[NFSD_A_SERVER_INSTANCE_PORT])
> > > +			continue;
> > > +
> > > +		xcl_name =3D nla_data(tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME]);
> > > +		port =3D nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_PORT]);
> > > +		if (port < 1 || port > USHRT_MAX)
> > > +			continue;
> > > +
> > > +		af =3D nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_INET_PROTO]);
> > > +		if (af !=3D PF_INET && af !=3D PF_INET6)
> > > +			continue;
> > > +
> > > +		xprt =3D svc_find_xprt(serv, xcl_name, net, PF_INET, port);
> > > +		if (xprt) {
> > > +			svc_xprt_put(xprt);
> > > +			continue;
> > > +		}
> > > +
> > > +		/* create new listerner */
> > > +		if (svc_xprt_create(serv, xcl_name, net, af, port,
> > > +				    SVC_SOCK_ANONYMOUS, get_current_cred()))
> > > +			continue;
> > > +	}
> > > +
> > > +	/* 2- remove stale listeners */
> >=20
> >=20
> > The old portlist interface was weird, in that it was only additive. You
> > couldn't use it to close a listening socket (AFAICT). We may be able to
> > support that now with this interface, but we'll need to test that case
> > carefully.
> >=20
> >=20
> >=20
> > > +	spin_lock_bh(&serv->sv_lock);
> > > +	list_for_each_entry_safe(xprt, tmp_xprt, &serv->sv_permsocks,
> > > +				 xpt_list) {
> > > +		struct svc_xprt *rqt_xprt =3D NULL;
> > > +
> > > +		nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> > > +			if (nla_type(attr) !=3D NFSD_A_SERVER_LISTENER_INSTANCE)
> > > +				continue;
> > > +
> > > +			if (nla_parse_nested(tb, ARRAY_SIZE(tb), attr,
> > > +					     nfsd_server_instance_nl_policy,
> > > +					     info->extack) < 0)
> > > +				continue;
> > > +
> > > +			if (!tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] ||
> > > +			    !tb[NFSD_A_SERVER_INSTANCE_PORT])
> > > +				continue;
> > > +
> > > +			xcl_name =3D nla_data(
> > > +				tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME]);
> > > +			port =3D nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_PORT]);
> > > +			if (port < 1 || port > USHRT_MAX)
> > > +				continue;
> > > +
> > > +			af =3D nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_INET_PROTO]);
> > > +			if (af !=3D PF_INET && af !=3D PF_INET6)
> > > +				continue;
> > > +
> > > +			if (!strcmp(xprt->xpt_class->xcl_name, xcl_name) &&
> > > +			    port =3D=3D svc_xprt_local_port(xprt) &&
> > > +			    af =3D=3D xprt->xpt_local.ss_family &&
> > > +			    xprt->xpt_net =3D=3D net) {
> > > +				rqt_xprt =3D xprt;
> > > +				break;
> > > +			}
> > > +		}
> > > +
> > > +		/* remove stale listener */
> > > +		if (!rqt_xprt) {
> > > +			spin_unlock_bh(&serv->sv_lock);
> > > +			svc_xprt_close(xprt);
> > >=20
> >=20
> > I'm not sure this is safe. Can anything else modify sv_permsocks while
> > you're not holding the lock? Maybe not since you're holding the
> > nfsd_mutex, but it's still probably best to restart the list walk if yo=
u
> > have to drop the lock here.
> >=20
> > You're typically only going to have a few sockets here anyway -- usuall=
y
> > just one each for TCP, UDP and maybe RDMA.
>=20
> what about beeing a bit proactive and set XPT_CLOSE bit before releasing =
the
> spinlock (as we already do in svc_xprt_close)?
>=20

That does sound better, actually. You might have to open-code parts of
svc_xprt_close, but it's not that big anyway.


> >=20
> >=20
> > > +			spin_lock_bh(&serv->sv_lock);
> > > +		}
> > > +	}
> > > +	spin_unlock_bh(&serv->sv_lock);
> > > +
> > > +	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks)=
)
> > > +		nfsd_destroy_serv(net);
> > > +
> > > +	mutex_unlock(&nfsd_mutex);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_listener_get_doit - get the nfs running listeners
> > > + * @skb: reply buffer
> > > + * @info: netlink metadata and command arguments
> > > + *
> > > + * Return 0 on success or a negative errno.
> > > + */
> > > +int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info =
*info)
> > > +{
> > > +	struct svc_xprt *xprt;
> > > +	struct svc_serv *serv;
> > > +	struct nfsd_net *nn;
> > > +	void *hdr;
> > > +	int err;
> > > +
> > > +	skb =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > > +	if (!skb)
> > > +		return -ENOMEM;
> > > +
> > > +	hdr =3D genlmsg_iput(skb, info);
> > > +	if (!hdr) {
> > > +		err =3D -EMSGSIZE;
> > > +		goto err_free_msg;
> > > +	}
> > > +
> > > +	mutex_lock(&nfsd_mutex);
> > > +	nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> > > +	if (!nn->nfsd_serv) {
> > > +		err =3D -EINVAL;
> > > +		goto err_nfsd_unlock;
> > > +	}
> > > +
> > > +	serv =3D nn->nfsd_serv;
> > > +	spin_lock_bh(&serv->sv_lock);
> > > +	list_for_each_entry(xprt, &serv->sv_permsocks, xpt_list) {
> > > +		struct nlattr *attr;
> > > +
> > > +		attr =3D nla_nest_start_noflag(skb,
> > > +					     NFSD_A_SERVER_LISTENER_INSTANCE);
> > > +		if (!attr) {
> > > +			err =3D -EINVAL;
> > > +			goto err_serv_unlock;
> > > +		}
> > > +
> > > +		if (nla_put_string(skb, NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME,
> > > +				   xprt->xpt_class->xcl_name) ||
> > > +		    nla_put_u32(skb, NFSD_A_SERVER_INSTANCE_PORT,
> > > +				svc_xprt_local_port(xprt)) ||
> > > +		    nla_put_u16(skb, NFSD_A_SERVER_INSTANCE_INET_PROTO,
> > > +				xprt->xpt_local.ss_family)) {
> > > +			err =3D -EINVAL;
> > > +			goto err_serv_unlock;
> > > +		}
> > > +
> > > +		nla_nest_end(skb, attr);
> > > +	}
> > > +	spin_unlock_bh(&serv->sv_lock);
> > > +	mutex_unlock(&nfsd_mutex);
> > > +
> > > +	genlmsg_end(skb, hdr);
> > > +
> > > +	return genlmsg_reply(skb, info);
> > > +
> > > +err_serv_unlock:
> > > +	spin_unlock_bh(&serv->sv_lock);
> > > +err_nfsd_unlock:
> > > +	mutex_unlock(&nfsd_mutex);
> > > +err_free_msg:
> > > +	nlmsg_free(skb);
> > > +
> > > +	return err;
> > > +}
> > > +
> > > =A0/**
> > > =A0=A0* nfsd_net_init - Prepare the nfsd_net portion of a new net nam=
espace
> > > =A0=A0* @net: a freshly-created network namespace
> > > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/n=
fsd_netlink.h
> > > index 2a06f9fe6fe9..659ab76b8840 100644
> > > --- a/include/uapi/linux/nfsd_netlink.h
> > > +++ b/include/uapi/linux/nfsd_netlink.h
> > > @@ -51,12 +51,30 @@ enum {
> > > =A0	NFSD_A_SERVER_PROTO_MAX =3D (__NFSD_A_SERVER_PROTO_MAX - 1)
> > > =A0};
> > > =A0
> > >=20
> > > +enum {
> > > +	NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME =3D 1,
> > > +	NFSD_A_SERVER_INSTANCE_PORT,
> > > +	NFSD_A_SERVER_INSTANCE_INET_PROTO,
> > > +
> > > +	__NFSD_A_SERVER_INSTANCE_MAX,
> > > +	NFSD_A_SERVER_INSTANCE_MAX =3D (__NFSD_A_SERVER_INSTANCE_MAX - 1)
> > > +};
> > > +
> > > +enum {
> > > +	NFSD_A_SERVER_LISTENER_INSTANCE =3D 1,
> > > +
> > > +	__NFSD_A_SERVER_LISTENER_MAX,
> > > +	NFSD_A_SERVER_LISTENER_MAX =3D (__NFSD_A_SERVER_LISTENER_MAX - 1)
> > > +};
> > > +
> > > =A0enum {
> > > =A0	NFSD_CMD_RPC_STATUS_GET =3D 1,
> > > =A0	NFSD_CMD_THREADS_SET,
> > > =A0	NFSD_CMD_THREADS_GET,
> > > =A0	NFSD_CMD_VERSION_SET,
> > > =A0	NFSD_CMD_VERSION_GET,
> > > +	NFSD_CMD_LISTENER_SET,
> > > +	NFSD_CMD_LISTENER_GET,
> > > =A0
> > >=20
> > > =A0	__NFSD_CMD_MAX,
> > > =A0	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> > > diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/gene=
rated/nfsd-user.c
> > > index ad498543f464..d52f392c7f59 100644
> > > --- a/tools/net/ynl/generated/nfsd-user.c
> > > +++ b/tools/net/ynl/generated/nfsd-user.c
> > > @@ -19,6 +19,8 @@ static const char * const nfsd_op_strmap[] =3D {
> > > =A0	[NFSD_CMD_THREADS_GET] =3D "threads-get",
> > > =A0	[NFSD_CMD_VERSION_SET] =3D "version-set",
> > > =A0	[NFSD_CMD_VERSION_GET] =3D "version-get",
> > > +	[NFSD_CMD_LISTENER_SET] =3D "listener-set",
> > > +	[NFSD_CMD_LISTENER_GET] =3D "listener-get",
> > > =A0};
> > > =A0
> > >=20
> > > =A0const char *nfsd_op_str(int op)
> > > @@ -39,6 +41,17 @@ struct ynl_policy_nest nfsd_nfs_version_nest =3D {
> > > =A0	.table =3D nfsd_nfs_version_policy,
> > > =A0};
> > > =A0
> > >=20
> > > +struct ynl_policy_attr nfsd_server_instance_policy[NFSD_A_SERVER_INS=
TANCE_MAX + 1] =3D {
> > > +	[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] =3D { .name =3D "transport-=
name", .type =3D YNL_PT_NUL_STR, },
> > > +	[NFSD_A_SERVER_INSTANCE_PORT] =3D { .name =3D "port", .type =3D YNL=
_PT_U32, },
> > > +	[NFSD_A_SERVER_INSTANCE_INET_PROTO] =3D { .name =3D "inet-proto", .=
type =3D YNL_PT_U16, },
> > > +};
> > > +
> > > +struct ynl_policy_nest nfsd_server_instance_nest =3D {
> > > +	.max_attr =3D NFSD_A_SERVER_INSTANCE_MAX,
> > > +	.table =3D nfsd_server_instance_policy,
> > > +};
> > > +
> > > =A0struct ynl_policy_attr nfsd_rpc_status_policy[NFSD_A_RPC_STATUS_MA=
X + 1] =3D {
> > > =A0	[NFSD_A_RPC_STATUS_XID] =3D { .name =3D "xid", .type =3D YNL_PT_U=
32, },
> > > =A0	[NFSD_A_RPC_STATUS_FLAGS] =3D { .name =3D "flags", .type =3D YNL_=
PT_U32, },
> > > @@ -79,6 +92,15 @@ struct ynl_policy_nest nfsd_server_proto_nest =3D =
{
> > > =A0	.table =3D nfsd_server_proto_policy,
> > > =A0};
> > > =A0
> > >=20
> > > +struct ynl_policy_attr nfsd_server_listener_policy[NFSD_A_SERVER_LIS=
TENER_MAX + 1] =3D {
> > > +	[NFSD_A_SERVER_LISTENER_INSTANCE] =3D { .name =3D "instance", .type=
 =3D YNL_PT_NEST, .nest =3D &nfsd_server_instance_nest, },
> > > +};
> > > +
> > > +struct ynl_policy_nest nfsd_server_listener_nest =3D {
> > > +	.max_attr =3D NFSD_A_SERVER_LISTENER_MAX,
> > > +	.table =3D nfsd_server_listener_policy,
> > > +};
> > > +
> > > =A0/* Common nested types */
> > > =A0void nfsd_nfs_version_free(struct nfsd_nfs_version *obj)
> > > =A0{
> > > @@ -124,6 +146,64 @@ int nfsd_nfs_version_parse(struct ynl_parse_arg =
*yarg,
> > > =A0	return 0;
> > > =A0}
> > > =A0
> > >=20
> > > +void nfsd_server_instance_free(struct nfsd_server_instance *obj)
> > > +{
> > > +	free(obj->transport_name);
> > > +}
> > > +
> > > +int nfsd_server_instance_put(struct nlmsghdr *nlh, unsigned int attr=
_type,
> > > +			     struct nfsd_server_instance *obj)
> > > +{
> > > +	struct nlattr *nest;
> > > +
> > > +	nest =3D mnl_attr_nest_start(nlh, attr_type);
> > > +	if (obj->_present.transport_name_len)
> > > +		mnl_attr_put_strz(nlh, NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME, obj-=
>transport_name);
> > > +	if (obj->_present.port)
> > > +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_INSTANCE_PORT, obj->port);
> > > +	if (obj->_present.inet_proto)
> > > +		mnl_attr_put_u16(nlh, NFSD_A_SERVER_INSTANCE_INET_PROTO, obj->inet=
_proto);
> > > +	mnl_attr_nest_end(nlh, nest);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int nfsd_server_instance_parse(struct ynl_parse_arg *yarg,
> > > +			       const struct nlattr *nested)
> > > +{
> > > +	struct nfsd_server_instance *dst =3D yarg->data;
> > > +	const struct nlattr *attr;
> > > +
> > > +	mnl_attr_for_each_nested(attr, nested) {
> > > +		unsigned int type =3D mnl_attr_get_type(attr);
> > > +
> > > +		if (type =3D=3D NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME) {
> > > +			unsigned int len;
> > > +
> > > +			if (ynl_attr_validate(yarg, attr))
> > > +				return MNL_CB_ERROR;
> > > +
> > > +			len =3D strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(=
attr));
> > > +			dst->_present.transport_name_len =3D len;
> > > +			dst->transport_name =3D malloc(len + 1);
> > > +			memcpy(dst->transport_name, mnl_attr_get_str(attr), len);
> > > +			dst->transport_name[len] =3D 0;
> > > +		} else if (type =3D=3D NFSD_A_SERVER_INSTANCE_PORT) {
> > > +			if (ynl_attr_validate(yarg, attr))
> > > +				return MNL_CB_ERROR;
> > > +			dst->_present.port =3D 1;
> > > +			dst->port =3D mnl_attr_get_u32(attr);
> > > +		} else if (type =3D=3D NFSD_A_SERVER_INSTANCE_INET_PROTO) {
> > > +			if (ynl_attr_validate(yarg, attr))
> > > +				return MNL_CB_ERROR;
> > > +			dst->_present.inet_proto =3D 1;
> > > +			dst->inet_proto =3D mnl_attr_get_u16(attr);
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > =A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATUS_=
GET =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > =A0/* NFSD_CMD_RPC_STATUS_GET - dump */
> > > =A0int nfsd_rpc_status_get_rsp_dump_parse(const struct nlmsghdr *nlh,=
 void *data)
> > > @@ -467,6 +547,117 @@ struct nfsd_version_get_rsp *nfsd_version_get(s=
truct ynl_sock *ys)
> > > =A0	return NULL;
> > > =A0}
> > > =A0
> > >=20
> > > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_SET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > +/* NFSD_CMD_LISTENER_SET - do */
> > > +void nfsd_listener_set_req_free(struct nfsd_listener_set_req *req)
> > > +{
> > > +	unsigned int i;
> > > +
> > > +	for (i =3D 0; i < req->n_instance; i++)
> > > +		nfsd_server_instance_free(&req->instance[i]);
> > > +	free(req->instance);
> > > +	free(req);
> > > +}
> > > +
> > > +int nfsd_listener_set(struct ynl_sock *ys, struct nfsd_listener_set_=
req *req)
> > > +{
> > > +	struct ynl_req_state yrs =3D { .yarg =3D { .ys =3D ys, }, };
> > > +	struct nlmsghdr *nlh;
> > > +	int err;
> > > +
> > > +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_LISTENER_SE=
T, 1);
> > > +	ys->req_policy =3D &nfsd_server_listener_nest;
> > > +
> > > +	for (unsigned int i =3D 0; i < req->n_instance; i++)
> > > +		nfsd_server_instance_put(nlh, NFSD_A_SERVER_LISTENER_INSTANCE, &re=
q->instance[i]);
> > > +
> > > +	err =3D ynl_exec(ys, nlh, &yrs);
> > > +	if (err < 0)
> > > +		return -1;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > +/* NFSD_CMD_LISTENER_GET - do */
> > > +void nfsd_listener_get_rsp_free(struct nfsd_listener_get_rsp *rsp)
> > > +{
> > > +	unsigned int i;
> > > +
> > > +	for (i =3D 0; i < rsp->n_instance; i++)
> > > +		nfsd_server_instance_free(&rsp->instance[i]);
> > > +	free(rsp->instance);
> > > +	free(rsp);
> > > +}
> > > +
> > > +int nfsd_listener_get_rsp_parse(const struct nlmsghdr *nlh, void *da=
ta)
> > > +{
> > > +	struct nfsd_listener_get_rsp *dst;
> > > +	struct ynl_parse_arg *yarg =3D data;
> > > +	unsigned int n_instance =3D 0;
> > > +	const struct nlattr *attr;
> > > +	struct ynl_parse_arg parg;
> > > +	int i;
> > > +
> > > +	dst =3D yarg->data;
> > > +	parg.ys =3D yarg->ys;
> > > +
> > > +	if (dst->instance)
> > > +		return ynl_error_parse(yarg, "attribute already present (server-li=
stener.instance)");
> > > +
> > > +	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> > > +		unsigned int type =3D mnl_attr_get_type(attr);
> > > +
> > > +		if (type =3D=3D NFSD_A_SERVER_LISTENER_INSTANCE) {
> > > +			n_instance++;
> > > +		}
> > > +	}
> > > +
> > > +	if (n_instance) {
> > > +		dst->instance =3D calloc(n_instance, sizeof(*dst->instance));
> > > +		dst->n_instance =3D n_instance;
> > > +		i =3D 0;
> > > +		parg.rsp_policy =3D &nfsd_server_instance_nest;
> > > +		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> > > +			if (mnl_attr_get_type(attr) =3D=3D NFSD_A_SERVER_LISTENER_INSTANC=
E) {
> > > +				parg.data =3D &dst->instance[i];
> > > +				if (nfsd_server_instance_parse(&parg, attr))
> > > +					return MNL_CB_ERROR;
> > > +				i++;
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	return MNL_CB_OK;
> > > +}
> > > +
> > > +struct nfsd_listener_get_rsp *nfsd_listener_get(struct ynl_sock *ys)
> > > +{
> > > +	struct ynl_req_state yrs =3D { .yarg =3D { .ys =3D ys, }, };
> > > +	struct nfsd_listener_get_rsp *rsp;
> > > +	struct nlmsghdr *nlh;
> > > +	int err;
> > > +
> > > +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_LISTENER_GE=
T, 1);
> > > +	ys->req_policy =3D &nfsd_server_listener_nest;
> > > +	yrs.yarg.rsp_policy =3D &nfsd_server_listener_nest;
> > > +
> > > +	rsp =3D calloc(1, sizeof(*rsp));
> > > +	yrs.yarg.data =3D rsp;
> > > +	yrs.cb =3D nfsd_listener_get_rsp_parse;
> > > +	yrs.rsp_cmd =3D NFSD_CMD_LISTENER_GET;
> > > +
> > > +	err =3D ynl_exec(ys, nlh, &yrs);
> > > +	if (err < 0)
> > > +		goto err_free;
> > > +
> > > +	return rsp;
> > > +
> > > +err_free:
> > > +	nfsd_listener_get_rsp_free(rsp);
> > > +	return NULL;
> > > +}
> > > +
> > > =A0const struct ynl_family ynl_nfsd_family =3D  {
> > > =A0	.name		=3D "nfsd",
> > > =A0};
> > > diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/gene=
rated/nfsd-user.h
> > > index d062ee8fa8b6..5765fb6f2ef5 100644
> > > --- a/tools/net/ynl/generated/nfsd-user.h
> > > +++ b/tools/net/ynl/generated/nfsd-user.h
> > > @@ -29,6 +29,18 @@ struct nfsd_nfs_version {
> > > =A0	__u32 minor;
> > > =A0};
> > > =A0
> > >=20
> > > +struct nfsd_server_instance {
> > > +	struct {
> > > +		__u32 transport_name_len;
> > > +		__u32 port:1;
> > > +		__u32 inet_proto:1;
> > > +	} _present;
> > > +
> > > +	char *transport_name;
> > > +	__u32 port;
> > > +	__u16 inet_proto;
> > > +};
> > > +
> > > =A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATUS_=
GET =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > =A0/* NFSD_CMD_RPC_STATUS_GET - dump */
> > > =A0struct nfsd_rpc_status_get_rsp_dump {
> > > @@ -164,4 +176,47 @@ void nfsd_version_get_rsp_free(struct nfsd_versi=
on_get_rsp *rsp);
> > > =A0=A0*/
> > > =A0struct nfsd_version_get_rsp *nfsd_version_get(struct ynl_sock *ys)=
;
> > > =A0
> > >=20
> > > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_SET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > +/* NFSD_CMD_LISTENER_SET - do */
> > > +struct nfsd_listener_set_req {
> > > +	unsigned int n_instance;
> > > +	struct nfsd_server_instance *instance;
> > > +};
> > > +
> > > +static inline struct nfsd_listener_set_req *nfsd_listener_set_req_al=
loc(void)
> > > +{
> > > +	return calloc(1, sizeof(struct nfsd_listener_set_req));
> > > +}
> > > +void nfsd_listener_set_req_free(struct nfsd_listener_set_req *req);
> > > +
> > > +static inline void
> > > +__nfsd_listener_set_req_set_instance(struct nfsd_listener_set_req *r=
eq,
> > > +				     struct nfsd_server_instance *instance,
> > > +				     unsigned int n_instance)
> > > +{
> > > +	free(req->instance);
> > > +	req->instance =3D instance;
> > > +	req->n_instance =3D n_instance;
> > > +}
> > > +
> > > +/*
> > > + * set nfs running listeners
> > > + */
> > > +int nfsd_listener_set(struct ynl_sock *ys, struct nfsd_listener_set_=
req *req);
> > > +
> > > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > +/* NFSD_CMD_LISTENER_GET - do */
> > > +
> > > +struct nfsd_listener_get_rsp {
> > > +	unsigned int n_instance;
> > > +	struct nfsd_server_instance *instance;
> > > +};
> > > +
> > > +void nfsd_listener_get_rsp_free(struct nfsd_listener_get_rsp *rsp);
> > > +
> > > +/*
> > > + * get nfs running listeners
> > > + */
> > > +struct nfsd_listener_get_rsp *nfsd_listener_get(struct ynl_sock *ys)=
;
> > > +
> > > =A0#endif /* _LINUX_NFSD_GEN_H */
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

