Return-Path: <linux-nfs+bounces-1245-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDDF836C3A
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 17:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C527D1F266D2
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D34047F62;
	Mon, 22 Jan 2024 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drXQi9RJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5347F5F;
	Mon, 22 Jan 2024 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705937736; cv=none; b=btVnWhuYElRWcD918Y+ar2nNWUrmVeJwSMiaGzLcrl9g28wMYOJYVfx8NKcl+PUSbEYV9+1OwLrRYmXGukEblmS1iyS8idVCquXC+XiNQzB6J8UPFq5AaU2iLsav5CMc3UbB3QtN3YLnq0c7pVW0ftCPN2D/UZBquHbgUQwgSAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705937736; c=relaxed/simple;
	bh=cw5Mpw7n9M0hjUDaAX7nmstJjwmkUaACvFFjDSI04pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2EGQUYDS8kIlJ0zkXnHtS+ggLa/eWAlU0mdTWekfJGrRrDdFXB5Dsm4f5HCABx7Rk4TCdgNbEw9iPzfuFIVEzin5NWWG5zteoCRhrCNnFPzhawiIBIIV4rPkWYzKmLkGzUuk8jpvFPgrtpkKsYnQ/4ZYzBljtPjwWoKSYX6RwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drXQi9RJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31DDC433C7;
	Mon, 22 Jan 2024 15:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705937735;
	bh=cw5Mpw7n9M0hjUDaAX7nmstJjwmkUaACvFFjDSI04pM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drXQi9RJ0LjGHQYir+LKwlDIR3jMO59nj03htS6+w2EqCEEtmnJF1ca0pY+LhTk7r
	 SWCmsgVrv174VxdCWCu58to9bVYS/u9KrZ53lEv/lWzRZEk98lZ+4DRdOt4fK+euue
	 haVynhDWoXZRstTYJ6ZzeOD8UioCrYpBo4nlgsOKjpK7azP09oqLsiZJu4NC97pGgH
	 rBhx5jpt/OxD7VLifs8HK/NZDhhCqaeEJcOxAk+zE+/g7+n9S99FbiRbI0QD6OPrjS
	 BjaMpN80Pwgd7J/4yyt8t9IZAWF9jOGUwQ46S4BqAG/h5cFgPrYQLvpNP7+QI1CP9T
	 gHZd3Hb13ZwxQ==
Date: Mon, 22 Jan 2024 16:35:31 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com, neilb@suse.de,
	kuba@kernel.org, chuck.lever@oracle.com, horms@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/3] NFSD: add write_ports to netlink command
Message-ID: <Za6LQ8tdSwFil-eO@lore-desk>
References: <cover.1705771400.git.lorenzo@kernel.org>
 <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>
 <9e3ae337dcf168c60c4cfd51aa0b2fc7b24bcbfb.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Hh0vlcC0XRrsh2y"
Content-Disposition: inline
In-Reply-To: <9e3ae337dcf168c60c4cfd51aa0b2fc7b24bcbfb.camel@kernel.org>


--9Hh0vlcC0XRrsh2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 2024-01-20 at 18:33 +0100, Lorenzo Bianconi wrote:
> > Introduce write_ports netlink command. For listener-set, userspace is
> > expected to provide a NFS listeners list it wants to enable (all the
> > other ports will be closed).
> >=20
>=20
> Ditto here. This is a change to a declarative interface, which I think
> is a better way to handle this, but we should be aware of the change.
>=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/netlink/specs/nfsd.yaml |  37 +++++
> >  fs/nfsd/netlink.c                     |  23 +++
> >  fs/nfsd/netlink.h                     |   3 +
> >  fs/nfsd/nfsctl.c                      | 196 ++++++++++++++++++++++++++
> >  include/uapi/linux/nfsd_netlink.h     |  18 +++
> >  tools/net/ynl/generated/nfsd-user.c   | 191 +++++++++++++++++++++++++
> >  tools/net/ynl/generated/nfsd-user.h   |  55 ++++++++
> >  7 files changed, 523 insertions(+)
> >=20
> > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netl=
ink/specs/nfsd.yaml
> > index 30f18798e84e..296ff24b23ac 100644
> > --- a/Documentation/netlink/specs/nfsd.yaml
> > +++ b/Documentation/netlink/specs/nfsd.yaml
> > @@ -85,6 +85,26 @@ attribute-sets:
> >          type: nest
> >          nested-attributes: nfs-version
> >          multi-attr: true
> > +  -
> > +    name: server-instance
> > +    attributes:
> > +      -
> > +        name: transport-name
> > +        type: string
> > +      -
> > +        name: port
> > +        type: u32
> > +      -
> > +        name: inet-proto
> > +        type: u16
> > +  -
> > +    name: server-listener
> > +    attributes:
> > +      -
> > +        name: instance
> > +        type: nest
> > +        nested-attributes: server-instance
> > +        multi-attr: true
> > =20
> >  operations:
> >    list:
> > @@ -144,3 +164,20 @@ operations:
> >          reply:
> >            attributes:
> >              - version
> > +    -
> > +      name: listener-set
> > +      doc: set nfs running listeners
> > +      attribute-set: server-listener
> > +      flags: [ admin-perm ]
> > +      do:
> > +        request:
> > +          attributes:
> > +            - instance
> > +    -
> > +      name: listener-get
> > +      doc: get nfs running listeners
> > +      attribute-set: server-listener
> > +      do:
> > +        reply:
> > +          attributes:
> > +            - instance
> > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > index 5cbbd3295543..c772f9e14761 100644
> > --- a/fs/nfsd/netlink.c
> > +++ b/fs/nfsd/netlink.c
> > @@ -16,6 +16,12 @@ const struct nla_policy nfsd_nfs_version_nl_policy[N=
FSD_A_NFS_VERSION_MINOR + 1]
> >  	[NFSD_A_NFS_VERSION_MINOR] =3D { .type =3D NLA_U32, },
> >  };
> > =20
> > +const struct nla_policy nfsd_server_instance_nl_policy[NFSD_A_SERVER_I=
NSTANCE_INET_PROTO + 1] =3D {
> > +	[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] =3D { .type =3D NLA_NUL_STRIN=
G, },
> > +	[NFSD_A_SERVER_INSTANCE_PORT] =3D { .type =3D NLA_U32, },
> > +	[NFSD_A_SERVER_INSTANCE_INET_PROTO] =3D { .type =3D NLA_U16, },
> > +};
> > +
> >  /* NFSD_CMD_THREADS_SET - do */
> >  static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVE=
R_WORKER_THREADS + 1] =3D {
> >  	[NFSD_A_SERVER_WORKER_THREADS] =3D { .type =3D NLA_U32, },
> > @@ -26,6 +32,11 @@ static const struct nla_policy nfsd_version_set_nl_p=
olicy[NFSD_A_SERVER_PROTO_VE
> >  	[NFSD_A_SERVER_PROTO_VERSION] =3D NLA_POLICY_NESTED(nfsd_nfs_version_=
nl_policy),
> >  };
> > =20
> > +/* NFSD_CMD_LISTENER_SET - do */
> > +static const struct nla_policy nfsd_listener_set_nl_policy[NFSD_A_SERV=
ER_LISTENER_INSTANCE + 1] =3D {
> > +	[NFSD_A_SERVER_LISTENER_INSTANCE] =3D NLA_POLICY_NESTED(nfsd_server_i=
nstance_nl_policy),
> > +};
> > +
> >  /* Ops table for nfsd */
> >  static const struct genl_split_ops nfsd_nl_ops[] =3D {
> >  	{
> > @@ -59,6 +70,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D=
 {
> >  		.doit	=3D nfsd_nl_version_get_doit,
> >  		.flags	=3D GENL_CMD_CAP_DO,
> >  	},
> > +	{
> > +		.cmd		=3D NFSD_CMD_LISTENER_SET,
> > +		.doit		=3D nfsd_nl_listener_set_doit,
> > +		.policy		=3D nfsd_listener_set_nl_policy,
> > +		.maxattr	=3D NFSD_A_SERVER_LISTENER_INSTANCE,
> > +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > +	},
> > +	{
> > +		.cmd	=3D NFSD_CMD_LISTENER_GET,
> > +		.doit	=3D nfsd_nl_listener_get_doit,
> > +		.flags	=3D GENL_CMD_CAP_DO,
> > +	},
> >  };
> > =20
> >  struct genl_family nfsd_nl_family __ro_after_init =3D {
> > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > index c9a1be693fef..10a26ad32cd0 100644
> > --- a/fs/nfsd/netlink.h
> > +++ b/fs/nfsd/netlink.h
> > @@ -13,6 +13,7 @@
> > =20
> >  /* Common nested types */
> >  extern const struct nla_policy nfsd_nfs_version_nl_policy[NFSD_A_NFS_V=
ERSION_MINOR + 1];
> > +extern const struct nla_policy nfsd_server_instance_nl_policy[NFSD_A_S=
ERVER_INSTANCE_INET_PROTO + 1];
> > =20
> >  int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
> >  int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
> > @@ -23,6 +24,8 @@ int nfsd_nl_threads_set_doit(struct sk_buff *skb, str=
uct genl_info *info);
> >  int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *in=
fo);
> >  int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *in=
fo);
> >  int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *in=
fo);
> > +int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *i=
nfo);
> > +int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *i=
nfo);
> > =20
> >  extern struct genl_family nfsd_nl_family;
> > =20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 53af82303f93..562b209f2921 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1896,6 +1896,202 @@ int nfsd_nl_version_get_doit(struct sk_buff *sk=
b, struct genl_info *info)
> >  	return err;
> >  }
> > =20
> > +/**
> > + * nfsd_nl_listener_set_doit - set the nfs running listeners
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *i=
nfo)
> > +{
> > +	struct nlattr *tb[ARRAY_SIZE(nfsd_server_instance_nl_policy)];
> > +	struct net *net =3D genl_info_net(info);
> > +	struct svc_xprt *xprt, *tmp_xprt;
> > +	const struct nlattr *attr;
> > +	struct svc_serv *serv;
> > +	const char *xcl_name;
> > +	struct nfsd_net *nn;
> > +	int port, err, rem;
> > +	sa_family_t af;
> > +
> > +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_LISTENER_INSTANCE))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +
> > +	err =3D nfsd_create_serv(net);
> > +	if (err) {
> > +		mutex_unlock(&nfsd_mutex);
> > +		return err;
> > +	}
> > +
> > +	nn =3D net_generic(net, nfsd_net_id);
> > +	serv =3D nn->nfsd_serv;
> > +
> > +	/* 1- create brand new listeners */
> > +	nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> > +		if (nla_type(attr) !=3D NFSD_A_SERVER_LISTENER_INSTANCE)
> > +			continue;
> > +
> > +		if (nla_parse_nested(tb, ARRAY_SIZE(tb), attr,
> > +				     nfsd_server_instance_nl_policy,
> > +				     info->extack) < 0)
> > +			continue;
> > +
> > +		if (!tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] ||
> > +		    !tb[NFSD_A_SERVER_INSTANCE_PORT])
> > +			continue;
> > +
> > +		xcl_name =3D nla_data(tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME]);
> > +		port =3D nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_PORT]);
> > +		if (port < 1 || port > USHRT_MAX)
> > +			continue;
> > +
> > +		af =3D nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_INET_PROTO]);
> > +		if (af !=3D PF_INET && af !=3D PF_INET6)
> > +			continue;
> > +
> > +		xprt =3D svc_find_xprt(serv, xcl_name, net, PF_INET, port);
> > +		if (xprt) {
> > +			svc_xprt_put(xprt);
> > +			continue;
> > +		}
> > +
> > +		/* create new listerner */
> > +		if (svc_xprt_create(serv, xcl_name, net, af, port,
> > +				    SVC_SOCK_ANONYMOUS, get_current_cred()))
> > +			continue;
> > +	}
> > +
> > +	/* 2- remove stale listeners */
>=20
>=20
> The old portlist interface was weird, in that it was only additive. You
> couldn't use it to close a listening socket (AFAICT). We may be able to
> support that now with this interface, but we'll need to test that case
> carefully.
>=20
>=20
>=20
> > +	spin_lock_bh(&serv->sv_lock);
> > +	list_for_each_entry_safe(xprt, tmp_xprt, &serv->sv_permsocks,
> > +				 xpt_list) {
> > +		struct svc_xprt *rqt_xprt =3D NULL;
> > +
> > +		nlmsg_for_each_attr(attr, info->nlhdr, GENL_HDRLEN, rem) {
> > +			if (nla_type(attr) !=3D NFSD_A_SERVER_LISTENER_INSTANCE)
> > +				continue;
> > +
> > +			if (nla_parse_nested(tb, ARRAY_SIZE(tb), attr,
> > +					     nfsd_server_instance_nl_policy,
> > +					     info->extack) < 0)
> > +				continue;
> > +
> > +			if (!tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] ||
> > +			    !tb[NFSD_A_SERVER_INSTANCE_PORT])
> > +				continue;
> > +
> > +			xcl_name =3D nla_data(
> > +				tb[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME]);
> > +			port =3D nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_PORT]);
> > +			if (port < 1 || port > USHRT_MAX)
> > +				continue;
> > +
> > +			af =3D nla_get_u32(tb[NFSD_A_SERVER_INSTANCE_INET_PROTO]);
> > +			if (af !=3D PF_INET && af !=3D PF_INET6)
> > +				continue;
> > +
> > +			if (!strcmp(xprt->xpt_class->xcl_name, xcl_name) &&
> > +			    port =3D=3D svc_xprt_local_port(xprt) &&
> > +			    af =3D=3D xprt->xpt_local.ss_family &&
> > +			    xprt->xpt_net =3D=3D net) {
> > +				rqt_xprt =3D xprt;
> > +				break;
> > +			}
> > +		}
> > +
> > +		/* remove stale listener */
> > +		if (!rqt_xprt) {
> > +			spin_unlock_bh(&serv->sv_lock);
> > +			svc_xprt_close(xprt);
> >=20
>=20
> I'm not sure this is safe. Can anything else modify sv_permsocks while
> you're not holding the lock? Maybe not since you're holding the
> nfsd_mutex, but it's still probably best to restart the list walk if you
> have to drop the lock here.
>=20
> You're typically only going to have a few sockets here anyway -- usually
> just one each for TCP, UDP and maybe RDMA.

what about beeing a bit proactive and set XPT_CLOSE bit before releasing the
spinlock (as we already do in svc_xprt_close)?

Regards,
Lorenzo

>=20
>=20
> > +			spin_lock_bh(&serv->sv_lock);
> > +		}
> > +	}
> > +	spin_unlock_bh(&serv->sv_lock);
> > +
> > +	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsocks))
> > +		nfsd_destroy_serv(net);
> > +
> > +	mutex_unlock(&nfsd_mutex);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * nfsd_nl_listener_get_doit - get the nfs running listeners
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_info *i=
nfo)
> > +{
> > +	struct svc_xprt *xprt;
> > +	struct svc_serv *serv;
> > +	struct nfsd_net *nn;
> > +	void *hdr;
> > +	int err;
> > +
> > +	skb =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > +	if (!skb)
> > +		return -ENOMEM;
> > +
> > +	hdr =3D genlmsg_iput(skb, info);
> > +	if (!hdr) {
> > +		err =3D -EMSGSIZE;
> > +		goto err_free_msg;
> > +	}
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +	nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> > +	if (!nn->nfsd_serv) {
> > +		err =3D -EINVAL;
> > +		goto err_nfsd_unlock;
> > +	}
> > +
> > +	serv =3D nn->nfsd_serv;
> > +	spin_lock_bh(&serv->sv_lock);
> > +	list_for_each_entry(xprt, &serv->sv_permsocks, xpt_list) {
> > +		struct nlattr *attr;
> > +
> > +		attr =3D nla_nest_start_noflag(skb,
> > +					     NFSD_A_SERVER_LISTENER_INSTANCE);
> > +		if (!attr) {
> > +			err =3D -EINVAL;
> > +			goto err_serv_unlock;
> > +		}
> > +
> > +		if (nla_put_string(skb, NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME,
> > +				   xprt->xpt_class->xcl_name) ||
> > +		    nla_put_u32(skb, NFSD_A_SERVER_INSTANCE_PORT,
> > +				svc_xprt_local_port(xprt)) ||
> > +		    nla_put_u16(skb, NFSD_A_SERVER_INSTANCE_INET_PROTO,
> > +				xprt->xpt_local.ss_family)) {
> > +			err =3D -EINVAL;
> > +			goto err_serv_unlock;
> > +		}
> > +
> > +		nla_nest_end(skb, attr);
> > +	}
> > +	spin_unlock_bh(&serv->sv_lock);
> > +	mutex_unlock(&nfsd_mutex);
> > +
> > +	genlmsg_end(skb, hdr);
> > +
> > +	return genlmsg_reply(skb, info);
> > +
> > +err_serv_unlock:
> > +	spin_unlock_bh(&serv->sv_lock);
> > +err_nfsd_unlock:
> > +	mutex_unlock(&nfsd_mutex);
> > +err_free_msg:
> > +	nlmsg_free(skb);
> > +
> > +	return err;
> > +}
> > +
> >  /**
> >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
> >   * @net: a freshly-created network namespace
> > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfs=
d_netlink.h
> > index 2a06f9fe6fe9..659ab76b8840 100644
> > --- a/include/uapi/linux/nfsd_netlink.h
> > +++ b/include/uapi/linux/nfsd_netlink.h
> > @@ -51,12 +51,30 @@ enum {
> >  	NFSD_A_SERVER_PROTO_MAX =3D (__NFSD_A_SERVER_PROTO_MAX - 1)
> >  };
> > =20
> > +enum {
> > +	NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME =3D 1,
> > +	NFSD_A_SERVER_INSTANCE_PORT,
> > +	NFSD_A_SERVER_INSTANCE_INET_PROTO,
> > +
> > +	__NFSD_A_SERVER_INSTANCE_MAX,
> > +	NFSD_A_SERVER_INSTANCE_MAX =3D (__NFSD_A_SERVER_INSTANCE_MAX - 1)
> > +};
> > +
> > +enum {
> > +	NFSD_A_SERVER_LISTENER_INSTANCE =3D 1,
> > +
> > +	__NFSD_A_SERVER_LISTENER_MAX,
> > +	NFSD_A_SERVER_LISTENER_MAX =3D (__NFSD_A_SERVER_LISTENER_MAX - 1)
> > +};
> > +
> >  enum {
> >  	NFSD_CMD_RPC_STATUS_GET =3D 1,
> >  	NFSD_CMD_THREADS_SET,
> >  	NFSD_CMD_THREADS_GET,
> >  	NFSD_CMD_VERSION_SET,
> >  	NFSD_CMD_VERSION_GET,
> > +	NFSD_CMD_LISTENER_SET,
> > +	NFSD_CMD_LISTENER_GET,
> > =20
> >  	__NFSD_CMD_MAX,
> >  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> > diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/genera=
ted/nfsd-user.c
> > index ad498543f464..d52f392c7f59 100644
> > --- a/tools/net/ynl/generated/nfsd-user.c
> > +++ b/tools/net/ynl/generated/nfsd-user.c
> > @@ -19,6 +19,8 @@ static const char * const nfsd_op_strmap[] =3D {
> >  	[NFSD_CMD_THREADS_GET] =3D "threads-get",
> >  	[NFSD_CMD_VERSION_SET] =3D "version-set",
> >  	[NFSD_CMD_VERSION_GET] =3D "version-get",
> > +	[NFSD_CMD_LISTENER_SET] =3D "listener-set",
> > +	[NFSD_CMD_LISTENER_GET] =3D "listener-get",
> >  };
> > =20
> >  const char *nfsd_op_str(int op)
> > @@ -39,6 +41,17 @@ struct ynl_policy_nest nfsd_nfs_version_nest =3D {
> >  	.table =3D nfsd_nfs_version_policy,
> >  };
> > =20
> > +struct ynl_policy_attr nfsd_server_instance_policy[NFSD_A_SERVER_INSTA=
NCE_MAX + 1] =3D {
> > +	[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] =3D { .name =3D "transport-na=
me", .type =3D YNL_PT_NUL_STR, },
> > +	[NFSD_A_SERVER_INSTANCE_PORT] =3D { .name =3D "port", .type =3D YNL_P=
T_U32, },
> > +	[NFSD_A_SERVER_INSTANCE_INET_PROTO] =3D { .name =3D "inet-proto", .ty=
pe =3D YNL_PT_U16, },
> > +};
> > +
> > +struct ynl_policy_nest nfsd_server_instance_nest =3D {
> > +	.max_attr =3D NFSD_A_SERVER_INSTANCE_MAX,
> > +	.table =3D nfsd_server_instance_policy,
> > +};
> > +
> >  struct ynl_policy_attr nfsd_rpc_status_policy[NFSD_A_RPC_STATUS_MAX + =
1] =3D {
> >  	[NFSD_A_RPC_STATUS_XID] =3D { .name =3D "xid", .type =3D YNL_PT_U32, =
},
> >  	[NFSD_A_RPC_STATUS_FLAGS] =3D { .name =3D "flags", .type =3D YNL_PT_U=
32, },
> > @@ -79,6 +92,15 @@ struct ynl_policy_nest nfsd_server_proto_nest =3D {
> >  	.table =3D nfsd_server_proto_policy,
> >  };
> > =20
> > +struct ynl_policy_attr nfsd_server_listener_policy[NFSD_A_SERVER_LISTE=
NER_MAX + 1] =3D {
> > +	[NFSD_A_SERVER_LISTENER_INSTANCE] =3D { .name =3D "instance", .type =
=3D YNL_PT_NEST, .nest =3D &nfsd_server_instance_nest, },
> > +};
> > +
> > +struct ynl_policy_nest nfsd_server_listener_nest =3D {
> > +	.max_attr =3D NFSD_A_SERVER_LISTENER_MAX,
> > +	.table =3D nfsd_server_listener_policy,
> > +};
> > +
> >  /* Common nested types */
> >  void nfsd_nfs_version_free(struct nfsd_nfs_version *obj)
> >  {
> > @@ -124,6 +146,64 @@ int nfsd_nfs_version_parse(struct ynl_parse_arg *y=
arg,
> >  	return 0;
> >  }
> > =20
> > +void nfsd_server_instance_free(struct nfsd_server_instance *obj)
> > +{
> > +	free(obj->transport_name);
> > +}
> > +
> > +int nfsd_server_instance_put(struct nlmsghdr *nlh, unsigned int attr_t=
ype,
> > +			     struct nfsd_server_instance *obj)
> > +{
> > +	struct nlattr *nest;
> > +
> > +	nest =3D mnl_attr_nest_start(nlh, attr_type);
> > +	if (obj->_present.transport_name_len)
> > +		mnl_attr_put_strz(nlh, NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME, obj->t=
ransport_name);
> > +	if (obj->_present.port)
> > +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_INSTANCE_PORT, obj->port);
> > +	if (obj->_present.inet_proto)
> > +		mnl_attr_put_u16(nlh, NFSD_A_SERVER_INSTANCE_INET_PROTO, obj->inet_p=
roto);
> > +	mnl_attr_nest_end(nlh, nest);
> > +
> > +	return 0;
> > +}
> > +
> > +int nfsd_server_instance_parse(struct ynl_parse_arg *yarg,
> > +			       const struct nlattr *nested)
> > +{
> > +	struct nfsd_server_instance *dst =3D yarg->data;
> > +	const struct nlattr *attr;
> > +
> > +	mnl_attr_for_each_nested(attr, nested) {
> > +		unsigned int type =3D mnl_attr_get_type(attr);
> > +
> > +		if (type =3D=3D NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME) {
> > +			unsigned int len;
> > +
> > +			if (ynl_attr_validate(yarg, attr))
> > +				return MNL_CB_ERROR;
> > +
> > +			len =3D strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_len(at=
tr));
> > +			dst->_present.transport_name_len =3D len;
> > +			dst->transport_name =3D malloc(len + 1);
> > +			memcpy(dst->transport_name, mnl_attr_get_str(attr), len);
> > +			dst->transport_name[len] =3D 0;
> > +		} else if (type =3D=3D NFSD_A_SERVER_INSTANCE_PORT) {
> > +			if (ynl_attr_validate(yarg, attr))
> > +				return MNL_CB_ERROR;
> > +			dst->_present.port =3D 1;
> > +			dst->port =3D mnl_attr_get_u32(attr);
> > +		} else if (type =3D=3D NFSD_A_SERVER_INSTANCE_INET_PROTO) {
> > +			if (ynl_attr_validate(yarg, attr))
> > +				return MNL_CB_ERROR;
> > +			dst->_present.inet_proto =3D 1;
> > +			dst->inet_proto =3D mnl_attr_get_u16(attr);
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATUS_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> >  /* NFSD_CMD_RPC_STATUS_GET - dump */
> >  int nfsd_rpc_status_get_rsp_dump_parse(const struct nlmsghdr *nlh, voi=
d *data)
> > @@ -467,6 +547,117 @@ struct nfsd_version_get_rsp *nfsd_version_get(str=
uct ynl_sock *ys)
> >  	return NULL;
> >  }
> > =20
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_SET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +/* NFSD_CMD_LISTENER_SET - do */
> > +void nfsd_listener_set_req_free(struct nfsd_listener_set_req *req)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < req->n_instance; i++)
> > +		nfsd_server_instance_free(&req->instance[i]);
> > +	free(req->instance);
> > +	free(req);
> > +}
> > +
> > +int nfsd_listener_set(struct ynl_sock *ys, struct nfsd_listener_set_re=
q *req)
> > +{
> > +	struct ynl_req_state yrs =3D { .yarg =3D { .ys =3D ys, }, };
> > +	struct nlmsghdr *nlh;
> > +	int err;
> > +
> > +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_LISTENER_SET,=
 1);
> > +	ys->req_policy =3D &nfsd_server_listener_nest;
> > +
> > +	for (unsigned int i =3D 0; i < req->n_instance; i++)
> > +		nfsd_server_instance_put(nlh, NFSD_A_SERVER_LISTENER_INSTANCE, &req-=
>instance[i]);
> > +
> > +	err =3D ynl_exec(ys, nlh, &yrs);
> > +	if (err < 0)
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +/* NFSD_CMD_LISTENER_GET - do */
> > +void nfsd_listener_get_rsp_free(struct nfsd_listener_get_rsp *rsp)
> > +{
> > +	unsigned int i;
> > +
> > +	for (i =3D 0; i < rsp->n_instance; i++)
> > +		nfsd_server_instance_free(&rsp->instance[i]);
> > +	free(rsp->instance);
> > +	free(rsp);
> > +}
> > +
> > +int nfsd_listener_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
> > +{
> > +	struct nfsd_listener_get_rsp *dst;
> > +	struct ynl_parse_arg *yarg =3D data;
> > +	unsigned int n_instance =3D 0;
> > +	const struct nlattr *attr;
> > +	struct ynl_parse_arg parg;
> > +	int i;
> > +
> > +	dst =3D yarg->data;
> > +	parg.ys =3D yarg->ys;
> > +
> > +	if (dst->instance)
> > +		return ynl_error_parse(yarg, "attribute already present (server-list=
ener.instance)");
> > +
> > +	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> > +		unsigned int type =3D mnl_attr_get_type(attr);
> > +
> > +		if (type =3D=3D NFSD_A_SERVER_LISTENER_INSTANCE) {
> > +			n_instance++;
> > +		}
> > +	}
> > +
> > +	if (n_instance) {
> > +		dst->instance =3D calloc(n_instance, sizeof(*dst->instance));
> > +		dst->n_instance =3D n_instance;
> > +		i =3D 0;
> > +		parg.rsp_policy =3D &nfsd_server_instance_nest;
> > +		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> > +			if (mnl_attr_get_type(attr) =3D=3D NFSD_A_SERVER_LISTENER_INSTANCE)=
 {
> > +				parg.data =3D &dst->instance[i];
> > +				if (nfsd_server_instance_parse(&parg, attr))
> > +					return MNL_CB_ERROR;
> > +				i++;
> > +			}
> > +		}
> > +	}
> > +
> > +	return MNL_CB_OK;
> > +}
> > +
> > +struct nfsd_listener_get_rsp *nfsd_listener_get(struct ynl_sock *ys)
> > +{
> > +	struct ynl_req_state yrs =3D { .yarg =3D { .ys =3D ys, }, };
> > +	struct nfsd_listener_get_rsp *rsp;
> > +	struct nlmsghdr *nlh;
> > +	int err;
> > +
> > +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_LISTENER_GET,=
 1);
> > +	ys->req_policy =3D &nfsd_server_listener_nest;
> > +	yrs.yarg.rsp_policy =3D &nfsd_server_listener_nest;
> > +
> > +	rsp =3D calloc(1, sizeof(*rsp));
> > +	yrs.yarg.data =3D rsp;
> > +	yrs.cb =3D nfsd_listener_get_rsp_parse;
> > +	yrs.rsp_cmd =3D NFSD_CMD_LISTENER_GET;
> > +
> > +	err =3D ynl_exec(ys, nlh, &yrs);
> > +	if (err < 0)
> > +		goto err_free;
> > +
> > +	return rsp;
> > +
> > +err_free:
> > +	nfsd_listener_get_rsp_free(rsp);
> > +	return NULL;
> > +}
> > +
> >  const struct ynl_family ynl_nfsd_family =3D  {
> >  	.name		=3D "nfsd",
> >  };
> > diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/genera=
ted/nfsd-user.h
> > index d062ee8fa8b6..5765fb6f2ef5 100644
> > --- a/tools/net/ynl/generated/nfsd-user.h
> > +++ b/tools/net/ynl/generated/nfsd-user.h
> > @@ -29,6 +29,18 @@ struct nfsd_nfs_version {
> >  	__u32 minor;
> >  };
> > =20
> > +struct nfsd_server_instance {
> > +	struct {
> > +		__u32 transport_name_len;
> > +		__u32 port:1;
> > +		__u32 inet_proto:1;
> > +	} _present;
> > +
> > +	char *transport_name;
> > +	__u32 port;
> > +	__u16 inet_proto;
> > +};
> > +
> >  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATUS_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> >  /* NFSD_CMD_RPC_STATUS_GET - dump */
> >  struct nfsd_rpc_status_get_rsp_dump {
> > @@ -164,4 +176,47 @@ void nfsd_version_get_rsp_free(struct nfsd_version=
_get_rsp *rsp);
> >   */
> >  struct nfsd_version_get_rsp *nfsd_version_get(struct ynl_sock *ys);
> > =20
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_SET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +/* NFSD_CMD_LISTENER_SET - do */
> > +struct nfsd_listener_set_req {
> > +	unsigned int n_instance;
> > +	struct nfsd_server_instance *instance;
> > +};
> > +
> > +static inline struct nfsd_listener_set_req *nfsd_listener_set_req_allo=
c(void)
> > +{
> > +	return calloc(1, sizeof(struct nfsd_listener_set_req));
> > +}
> > +void nfsd_listener_set_req_free(struct nfsd_listener_set_req *req);
> > +
> > +static inline void
> > +__nfsd_listener_set_req_set_instance(struct nfsd_listener_set_req *req,
> > +				     struct nfsd_server_instance *instance,
> > +				     unsigned int n_instance)
> > +{
> > +	free(req->instance);
> > +	req->instance =3D instance;
> > +	req->n_instance =3D n_instance;
> > +}
> > +
> > +/*
> > + * set nfs running listeners
> > + */
> > +int nfsd_listener_set(struct ynl_sock *ys, struct nfsd_listener_set_re=
q *req);
> > +
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +/* NFSD_CMD_LISTENER_GET - do */
> > +
> > +struct nfsd_listener_get_rsp {
> > +	unsigned int n_instance;
> > +	struct nfsd_server_instance *instance;
> > +};
> > +
> > +void nfsd_listener_get_rsp_free(struct nfsd_listener_get_rsp *rsp);
> > +
> > +/*
> > + * get nfs running listeners
> > + */
> > +struct nfsd_listener_get_rsp *nfsd_listener_get(struct ynl_sock *ys);
> > +
> >  #endif /* _LINUX_NFSD_GEN_H */
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

--9Hh0vlcC0XRrsh2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZa6LQwAKCRA6cBh0uS2t
rHwFAQDQZUyHbqhRNg8iGUJJ/1eoIvlG6jhhLwLfiP09P2BktwEA46mnDqbKcn2p
/nl0lcc99g73b3BUYTm0rk3rtmOAEgM=
=LfyT
-----END PGP SIGNATURE-----

--9Hh0vlcC0XRrsh2y--

