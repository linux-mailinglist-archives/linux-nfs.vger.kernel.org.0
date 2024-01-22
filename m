Return-Path: <linux-nfs+bounces-1249-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFC5836C8E
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 18:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B247284AF9
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Jan 2024 17:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7774D4C3D3;
	Mon, 22 Jan 2024 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zj8ZEAlq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD8F3D98B;
	Mon, 22 Jan 2024 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939203; cv=none; b=fH3zxT7Rbyn+NRtj9U1lD2s3eapvPI5Qw7WABQwLsp9Ol+r0pit3ZRhK0RUxx9+KIkpuplZVk9vK7npV0d51LSAgk2txXoC1cPfAEr1N90jxi4B6zHCoZijK6VjbiSsHb8ydkrWskRujmUzA8pvHVc3/b416zf6lZUu7a/CUHUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939203; c=relaxed/simple;
	bh=SiV+Lep+bKvyqr3uYnv+JLwp0BW34e15M4cO3L9El3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hEIpbS5VYh72xGQuMV4IKFzUzLb5ovD6hLKyyoh/kKtRnmvzMI4QbDAZDNvRH/gb5L2z3Pv5HbyiI33v6jHoEvXeV8FTT/7jYC5kFZGVhEJGR+VWS+Cnxr5xvs+uZwXRgUJXo1jxrDd3/J7ULofzH2eXQ2Jz+yk+h8eFp441Rdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zj8ZEAlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D51BC43390;
	Mon, 22 Jan 2024 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705939202;
	bh=SiV+Lep+bKvyqr3uYnv+JLwp0BW34e15M4cO3L9El3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zj8ZEAlq2TZusmbGFXyfqI2VlUl9zA+GMx4y4SEsF/5tkTQbYH3nd72R/H7OdA4J2
	 xb/Po5dcpX9jysfQjhRgP801qVYfFTeYRR5mThdp6Ho3gmluW1qD52qO84gq1OfI6g
	 6OXlCzXpxLp/MMpItnndT9dp1tfCkpaXcUya7aWidr96uTrEim7hGc8b1lPuOkrp7M
	 feb/FfTn7dPvUegta9Ra7B0888QBEBaHKYNBWVYAKpibnA8ZPSv6hphETRaCV/RPfF
	 CyGF2wZO8cSxluQoofNKWD/B56J43rQtodK/kK0yhP/f/fyXnokp3gKg8+EjBmEY+g
	 OuRHFBsUVgoOw==
Date: Mon, 22 Jan 2024 16:59:59 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com, neilb@suse.de,
	kuba@kernel.org, chuck.lever@oracle.com, horms@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v6 3/3] NFSD: add write_ports to netlink command
Message-ID: <Za6Q_2pNve5BrrhM@lore-desk>
References: <cover.1705771400.git.lorenzo@kernel.org>
 <f7c42dae2b232b3b06e54ceb3f00725893973e02.1705771400.git.lorenzo@kernel.org>
 <9e3ae337dcf168c60c4cfd51aa0b2fc7b24bcbfb.camel@kernel.org>
 <Za6LQ8tdSwFil-eO@lore-desk>
 <307cd36ead20741667418fae6bf921ce44f891ea.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jRqAJpi5/lHCWSlA"
Content-Disposition: inline
In-Reply-To: <307cd36ead20741667418fae6bf921ce44f891ea.camel@kernel.org>


--jRqAJpi5/lHCWSlA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> > >=20
> > > I'm not sure this is safe. Can anything else modify sv_permsocks while
> > > you're not holding the lock? Maybe not since you're holding the
> > > nfsd_mutex, but it's still probably best to restart the list walk if =
you
> > > have to drop the lock here.
> > >=20
> > > You're typically only going to have a few sockets here anyway -- usua=
lly
> > > just one each for TCP, UDP and maybe RDMA.
> >=20
> > what about beeing a bit proactive and set XPT_CLOSE bit before releasin=
g the
> > spinlock (as we already do in svc_xprt_close)?
> >=20
>=20
> That does sound better, actually. You might have to open-code parts of
> svc_xprt_close, but it's not that big anyway.

or even just set XPT_CLOSE before releasing the spinlock since svc_xprt_clo=
se()
will not be affected anyway and we are not in the hotpath.

Regards,
Lorenzo

>=20
>=20
> > >=20
> > >=20
> > > > +			spin_lock_bh(&serv->sv_lock);
> > > > +		}
> > > > +	}
> > > > +	spin_unlock_bh(&serv->sv_lock);
> > > > +
> > > > +	if (!serv->sv_nrthreads && list_empty(&nn->nfsd_serv->sv_permsock=
s))
> > > > +		nfsd_destroy_serv(net);
> > > > +
> > > > +	mutex_unlock(&nfsd_mutex);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * nfsd_nl_listener_get_doit - get the nfs running listeners
> > > > + * @skb: reply buffer
> > > > + * @info: netlink metadata and command arguments
> > > > + *
> > > > + * Return 0 on success or a negative errno.
> > > > + */
> > > > +int nfsd_nl_listener_get_doit(struct sk_buff *skb, struct genl_inf=
o *info)
> > > > +{
> > > > +	struct svc_xprt *xprt;
> > > > +	struct svc_serv *serv;
> > > > +	struct nfsd_net *nn;
> > > > +	void *hdr;
> > > > +	int err;
> > > > +
> > > > +	skb =3D genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
> > > > +	if (!skb)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	hdr =3D genlmsg_iput(skb, info);
> > > > +	if (!hdr) {
> > > > +		err =3D -EMSGSIZE;
> > > > +		goto err_free_msg;
> > > > +	}
> > > > +
> > > > +	mutex_lock(&nfsd_mutex);
> > > > +	nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> > > > +	if (!nn->nfsd_serv) {
> > > > +		err =3D -EINVAL;
> > > > +		goto err_nfsd_unlock;
> > > > +	}
> > > > +
> > > > +	serv =3D nn->nfsd_serv;
> > > > +	spin_lock_bh(&serv->sv_lock);
> > > > +	list_for_each_entry(xprt, &serv->sv_permsocks, xpt_list) {
> > > > +		struct nlattr *attr;
> > > > +
> > > > +		attr =3D nla_nest_start_noflag(skb,
> > > > +					     NFSD_A_SERVER_LISTENER_INSTANCE);
> > > > +		if (!attr) {
> > > > +			err =3D -EINVAL;
> > > > +			goto err_serv_unlock;
> > > > +		}
> > > > +
> > > > +		if (nla_put_string(skb, NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME,
> > > > +				   xprt->xpt_class->xcl_name) ||
> > > > +		    nla_put_u32(skb, NFSD_A_SERVER_INSTANCE_PORT,
> > > > +				svc_xprt_local_port(xprt)) ||
> > > > +		    nla_put_u16(skb, NFSD_A_SERVER_INSTANCE_INET_PROTO,
> > > > +				xprt->xpt_local.ss_family)) {
> > > > +			err =3D -EINVAL;
> > > > +			goto err_serv_unlock;
> > > > +		}
> > > > +
> > > > +		nla_nest_end(skb, attr);
> > > > +	}
> > > > +	spin_unlock_bh(&serv->sv_lock);
> > > > +	mutex_unlock(&nfsd_mutex);
> > > > +
> > > > +	genlmsg_end(skb, hdr);
> > > > +
> > > > +	return genlmsg_reply(skb, info);
> > > > +
> > > > +err_serv_unlock:
> > > > +	spin_unlock_bh(&serv->sv_lock);
> > > > +err_nfsd_unlock:
> > > > +	mutex_unlock(&nfsd_mutex);
> > > > +err_free_msg:
> > > > +	nlmsg_free(skb);
> > > > +
> > > > +	return err;
> > > > +}
> > > > +
> > > > =A0/**
> > > > =A0=A0* nfsd_net_init - Prepare the nfsd_net portion of a new net n=
amespace
> > > > =A0=A0* @net: a freshly-created network namespace
> > > > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux=
/nfsd_netlink.h
> > > > index 2a06f9fe6fe9..659ab76b8840 100644
> > > > --- a/include/uapi/linux/nfsd_netlink.h
> > > > +++ b/include/uapi/linux/nfsd_netlink.h
> > > > @@ -51,12 +51,30 @@ enum {
> > > > =A0	NFSD_A_SERVER_PROTO_MAX =3D (__NFSD_A_SERVER_PROTO_MAX - 1)
> > > > =A0};
> > > > =A0
> > > >=20
> > > > +enum {
> > > > +	NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME =3D 1,
> > > > +	NFSD_A_SERVER_INSTANCE_PORT,
> > > > +	NFSD_A_SERVER_INSTANCE_INET_PROTO,
> > > > +
> > > > +	__NFSD_A_SERVER_INSTANCE_MAX,
> > > > +	NFSD_A_SERVER_INSTANCE_MAX =3D (__NFSD_A_SERVER_INSTANCE_MAX - 1)
> > > > +};
> > > > +
> > > > +enum {
> > > > +	NFSD_A_SERVER_LISTENER_INSTANCE =3D 1,
> > > > +
> > > > +	__NFSD_A_SERVER_LISTENER_MAX,
> > > > +	NFSD_A_SERVER_LISTENER_MAX =3D (__NFSD_A_SERVER_LISTENER_MAX - 1)
> > > > +};
> > > > +
> > > > =A0enum {
> > > > =A0	NFSD_CMD_RPC_STATUS_GET =3D 1,
> > > > =A0	NFSD_CMD_THREADS_SET,
> > > > =A0	NFSD_CMD_THREADS_GET,
> > > > =A0	NFSD_CMD_VERSION_SET,
> > > > =A0	NFSD_CMD_VERSION_GET,
> > > > +	NFSD_CMD_LISTENER_SET,
> > > > +	NFSD_CMD_LISTENER_GET,
> > > > =A0
> > > >=20
> > > > =A0	__NFSD_CMD_MAX,
> > > > =A0	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> > > > diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/ge=
nerated/nfsd-user.c
> > > > index ad498543f464..d52f392c7f59 100644
> > > > --- a/tools/net/ynl/generated/nfsd-user.c
> > > > +++ b/tools/net/ynl/generated/nfsd-user.c
> > > > @@ -19,6 +19,8 @@ static const char * const nfsd_op_strmap[] =3D {
> > > > =A0	[NFSD_CMD_THREADS_GET] =3D "threads-get",
> > > > =A0	[NFSD_CMD_VERSION_SET] =3D "version-set",
> > > > =A0	[NFSD_CMD_VERSION_GET] =3D "version-get",
> > > > +	[NFSD_CMD_LISTENER_SET] =3D "listener-set",
> > > > +	[NFSD_CMD_LISTENER_GET] =3D "listener-get",
> > > > =A0};
> > > > =A0
> > > >=20
> > > > =A0const char *nfsd_op_str(int op)
> > > > @@ -39,6 +41,17 @@ struct ynl_policy_nest nfsd_nfs_version_nest =3D=
 {
> > > > =A0	.table =3D nfsd_nfs_version_policy,
> > > > =A0};
> > > > =A0
> > > >=20
> > > > +struct ynl_policy_attr nfsd_server_instance_policy[NFSD_A_SERVER_I=
NSTANCE_MAX + 1] =3D {
> > > > +	[NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME] =3D { .name =3D "transpor=
t-name", .type =3D YNL_PT_NUL_STR, },
> > > > +	[NFSD_A_SERVER_INSTANCE_PORT] =3D { .name =3D "port", .type =3D Y=
NL_PT_U32, },
> > > > +	[NFSD_A_SERVER_INSTANCE_INET_PROTO] =3D { .name =3D "inet-proto",=
 .type =3D YNL_PT_U16, },
> > > > +};
> > > > +
> > > > +struct ynl_policy_nest nfsd_server_instance_nest =3D {
> > > > +	.max_attr =3D NFSD_A_SERVER_INSTANCE_MAX,
> > > > +	.table =3D nfsd_server_instance_policy,
> > > > +};
> > > > +
> > > > =A0struct ynl_policy_attr nfsd_rpc_status_policy[NFSD_A_RPC_STATUS_=
MAX + 1] =3D {
> > > > =A0	[NFSD_A_RPC_STATUS_XID] =3D { .name =3D "xid", .type =3D YNL_PT=
_U32, },
> > > > =A0	[NFSD_A_RPC_STATUS_FLAGS] =3D { .name =3D "flags", .type =3D YN=
L_PT_U32, },
> > > > @@ -79,6 +92,15 @@ struct ynl_policy_nest nfsd_server_proto_nest =
=3D {
> > > > =A0	.table =3D nfsd_server_proto_policy,
> > > > =A0};
> > > > =A0
> > > >=20
> > > > +struct ynl_policy_attr nfsd_server_listener_policy[NFSD_A_SERVER_L=
ISTENER_MAX + 1] =3D {
> > > > +	[NFSD_A_SERVER_LISTENER_INSTANCE] =3D { .name =3D "instance", .ty=
pe =3D YNL_PT_NEST, .nest =3D &nfsd_server_instance_nest, },
> > > > +};
> > > > +
> > > > +struct ynl_policy_nest nfsd_server_listener_nest =3D {
> > > > +	.max_attr =3D NFSD_A_SERVER_LISTENER_MAX,
> > > > +	.table =3D nfsd_server_listener_policy,
> > > > +};
> > > > +
> > > > =A0/* Common nested types */
> > > > =A0void nfsd_nfs_version_free(struct nfsd_nfs_version *obj)
> > > > =A0{
> > > > @@ -124,6 +146,64 @@ int nfsd_nfs_version_parse(struct ynl_parse_ar=
g *yarg,
> > > > =A0	return 0;
> > > > =A0}
> > > > =A0
> > > >=20
> > > > +void nfsd_server_instance_free(struct nfsd_server_instance *obj)
> > > > +{
> > > > +	free(obj->transport_name);
> > > > +}
> > > > +
> > > > +int nfsd_server_instance_put(struct nlmsghdr *nlh, unsigned int at=
tr_type,
> > > > +			     struct nfsd_server_instance *obj)
> > > > +{
> > > > +	struct nlattr *nest;
> > > > +
> > > > +	nest =3D mnl_attr_nest_start(nlh, attr_type);
> > > > +	if (obj->_present.transport_name_len)
> > > > +		mnl_attr_put_strz(nlh, NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME, ob=
j->transport_name);
> > > > +	if (obj->_present.port)
> > > > +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_INSTANCE_PORT, obj->port);
> > > > +	if (obj->_present.inet_proto)
> > > > +		mnl_attr_put_u16(nlh, NFSD_A_SERVER_INSTANCE_INET_PROTO, obj->in=
et_proto);
> > > > +	mnl_attr_nest_end(nlh, nest);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +int nfsd_server_instance_parse(struct ynl_parse_arg *yarg,
> > > > +			       const struct nlattr *nested)
> > > > +{
> > > > +	struct nfsd_server_instance *dst =3D yarg->data;
> > > > +	const struct nlattr *attr;
> > > > +
> > > > +	mnl_attr_for_each_nested(attr, nested) {
> > > > +		unsigned int type =3D mnl_attr_get_type(attr);
> > > > +
> > > > +		if (type =3D=3D NFSD_A_SERVER_INSTANCE_TRANSPORT_NAME) {
> > > > +			unsigned int len;
> > > > +
> > > > +			if (ynl_attr_validate(yarg, attr))
> > > > +				return MNL_CB_ERROR;
> > > > +
> > > > +			len =3D strnlen(mnl_attr_get_str(attr), mnl_attr_get_payload_le=
n(attr));
> > > > +			dst->_present.transport_name_len =3D len;
> > > > +			dst->transport_name =3D malloc(len + 1);
> > > > +			memcpy(dst->transport_name, mnl_attr_get_str(attr), len);
> > > > +			dst->transport_name[len] =3D 0;
> > > > +		} else if (type =3D=3D NFSD_A_SERVER_INSTANCE_PORT) {
> > > > +			if (ynl_attr_validate(yarg, attr))
> > > > +				return MNL_CB_ERROR;
> > > > +			dst->_present.port =3D 1;
> > > > +			dst->port =3D mnl_attr_get_u32(attr);
> > > > +		} else if (type =3D=3D NFSD_A_SERVER_INSTANCE_INET_PROTO) {
> > > > +			if (ynl_attr_validate(yarg, attr))
> > > > +				return MNL_CB_ERROR;
> > > > +			dst->_present.inet_proto =3D 1;
> > > > +			dst->inet_proto =3D mnl_attr_get_u16(attr);
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > =A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATU=
S_GET =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > > =A0/* NFSD_CMD_RPC_STATUS_GET - dump */
> > > > =A0int nfsd_rpc_status_get_rsp_dump_parse(const struct nlmsghdr *nl=
h, void *data)
> > > > @@ -467,6 +547,117 @@ struct nfsd_version_get_rsp *nfsd_version_get=
(struct ynl_sock *ys)
> > > > =A0	return NULL;
> > > > =A0}
> > > > =A0
> > > >=20
> > > > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_SE=
T =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > > +/* NFSD_CMD_LISTENER_SET - do */
> > > > +void nfsd_listener_set_req_free(struct nfsd_listener_set_req *req)
> > > > +{
> > > > +	unsigned int i;
> > > > +
> > > > +	for (i =3D 0; i < req->n_instance; i++)
> > > > +		nfsd_server_instance_free(&req->instance[i]);
> > > > +	free(req->instance);
> > > > +	free(req);
> > > > +}
> > > > +
> > > > +int nfsd_listener_set(struct ynl_sock *ys, struct nfsd_listener_se=
t_req *req)
> > > > +{
> > > > +	struct ynl_req_state yrs =3D { .yarg =3D { .ys =3D ys, }, };
> > > > +	struct nlmsghdr *nlh;
> > > > +	int err;
> > > > +
> > > > +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_LISTENER_=
SET, 1);
> > > > +	ys->req_policy =3D &nfsd_server_listener_nest;
> > > > +
> > > > +	for (unsigned int i =3D 0; i < req->n_instance; i++)
> > > > +		nfsd_server_instance_put(nlh, NFSD_A_SERVER_LISTENER_INSTANCE, &=
req->instance[i]);
> > > > +
> > > > +	err =3D ynl_exec(ys, nlh, &yrs);
> > > > +	if (err < 0)
> > > > +		return -1;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_GE=
T =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > > +/* NFSD_CMD_LISTENER_GET - do */
> > > > +void nfsd_listener_get_rsp_free(struct nfsd_listener_get_rsp *rsp)
> > > > +{
> > > > +	unsigned int i;
> > > > +
> > > > +	for (i =3D 0; i < rsp->n_instance; i++)
> > > > +		nfsd_server_instance_free(&rsp->instance[i]);
> > > > +	free(rsp->instance);
> > > > +	free(rsp);
> > > > +}
> > > > +
> > > > +int nfsd_listener_get_rsp_parse(const struct nlmsghdr *nlh, void *=
data)
> > > > +{
> > > > +	struct nfsd_listener_get_rsp *dst;
> > > > +	struct ynl_parse_arg *yarg =3D data;
> > > > +	unsigned int n_instance =3D 0;
> > > > +	const struct nlattr *attr;
> > > > +	struct ynl_parse_arg parg;
> > > > +	int i;
> > > > +
> > > > +	dst =3D yarg->data;
> > > > +	parg.ys =3D yarg->ys;
> > > > +
> > > > +	if (dst->instance)
> > > > +		return ynl_error_parse(yarg, "attribute already present (server-=
listener.instance)");
> > > > +
> > > > +	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> > > > +		unsigned int type =3D mnl_attr_get_type(attr);
> > > > +
> > > > +		if (type =3D=3D NFSD_A_SERVER_LISTENER_INSTANCE) {
> > > > +			n_instance++;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	if (n_instance) {
> > > > +		dst->instance =3D calloc(n_instance, sizeof(*dst->instance));
> > > > +		dst->n_instance =3D n_instance;
> > > > +		i =3D 0;
> > > > +		parg.rsp_policy =3D &nfsd_server_instance_nest;
> > > > +		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
> > > > +			if (mnl_attr_get_type(attr) =3D=3D NFSD_A_SERVER_LISTENER_INSTA=
NCE) {
> > > > +				parg.data =3D &dst->instance[i];
> > > > +				if (nfsd_server_instance_parse(&parg, attr))
> > > > +					return MNL_CB_ERROR;
> > > > +				i++;
> > > > +			}
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return MNL_CB_OK;
> > > > +}
> > > > +
> > > > +struct nfsd_listener_get_rsp *nfsd_listener_get(struct ynl_sock *y=
s)
> > > > +{
> > > > +	struct ynl_req_state yrs =3D { .yarg =3D { .ys =3D ys, }, };
> > > > +	struct nfsd_listener_get_rsp *rsp;
> > > > +	struct nlmsghdr *nlh;
> > > > +	int err;
> > > > +
> > > > +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_LISTENER_=
GET, 1);
> > > > +	ys->req_policy =3D &nfsd_server_listener_nest;
> > > > +	yrs.yarg.rsp_policy =3D &nfsd_server_listener_nest;
> > > > +
> > > > +	rsp =3D calloc(1, sizeof(*rsp));
> > > > +	yrs.yarg.data =3D rsp;
> > > > +	yrs.cb =3D nfsd_listener_get_rsp_parse;
> > > > +	yrs.rsp_cmd =3D NFSD_CMD_LISTENER_GET;
> > > > +
> > > > +	err =3D ynl_exec(ys, nlh, &yrs);
> > > > +	if (err < 0)
> > > > +		goto err_free;
> > > > +
> > > > +	return rsp;
> > > > +
> > > > +err_free:
> > > > +	nfsd_listener_get_rsp_free(rsp);
> > > > +	return NULL;
> > > > +}
> > > > +
> > > > =A0const struct ynl_family ynl_nfsd_family =3D  {
> > > > =A0	.name		=3D "nfsd",
> > > > =A0};
> > > > diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/ge=
nerated/nfsd-user.h
> > > > index d062ee8fa8b6..5765fb6f2ef5 100644
> > > > --- a/tools/net/ynl/generated/nfsd-user.h
> > > > +++ b/tools/net/ynl/generated/nfsd-user.h
> > > > @@ -29,6 +29,18 @@ struct nfsd_nfs_version {
> > > > =A0	__u32 minor;
> > > > =A0};
> > > > =A0
> > > >=20
> > > > +struct nfsd_server_instance {
> > > > +	struct {
> > > > +		__u32 transport_name_len;
> > > > +		__u32 port:1;
> > > > +		__u32 inet_proto:1;
> > > > +	} _present;
> > > > +
> > > > +	char *transport_name;
> > > > +	__u32 port;
> > > > +	__u16 inet_proto;
> > > > +};
> > > > +
> > > > =A0/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATU=
S_GET =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > > =A0/* NFSD_CMD_RPC_STATUS_GET - dump */
> > > > =A0struct nfsd_rpc_status_get_rsp_dump {
> > > > @@ -164,4 +176,47 @@ void nfsd_version_get_rsp_free(struct nfsd_ver=
sion_get_rsp *rsp);
> > > > =A0=A0*/
> > > > =A0struct nfsd_version_get_rsp *nfsd_version_get(struct ynl_sock *y=
s);
> > > > =A0
> > > >=20
> > > > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_SE=
T =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > > +/* NFSD_CMD_LISTENER_SET - do */
> > > > +struct nfsd_listener_set_req {
> > > > +	unsigned int n_instance;
> > > > +	struct nfsd_server_instance *instance;
> > > > +};
> > > > +
> > > > +static inline struct nfsd_listener_set_req *nfsd_listener_set_req_=
alloc(void)
> > > > +{
> > > > +	return calloc(1, sizeof(struct nfsd_listener_set_req));
> > > > +}
> > > > +void nfsd_listener_set_req_free(struct nfsd_listener_set_req *req);
> > > > +
> > > > +static inline void
> > > > +__nfsd_listener_set_req_set_instance(struct nfsd_listener_set_req =
*req,
> > > > +				     struct nfsd_server_instance *instance,
> > > > +				     unsigned int n_instance)
> > > > +{
> > > > +	free(req->instance);
> > > > +	req->instance =3D instance;
> > > > +	req->n_instance =3D n_instance;
> > > > +}
> > > > +
> > > > +/*
> > > > + * set nfs running listeners
> > > > + */
> > > > +int nfsd_listener_set(struct ynl_sock *ys, struct nfsd_listener_se=
t_req *req);
> > > > +
> > > > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_GE=
T =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > > > +/* NFSD_CMD_LISTENER_GET - do */
> > > > +
> > > > +struct nfsd_listener_get_rsp {
> > > > +	unsigned int n_instance;
> > > > +	struct nfsd_server_instance *instance;
> > > > +};
> > > > +
> > > > +void nfsd_listener_get_rsp_free(struct nfsd_listener_get_rsp *rsp);
> > > > +
> > > > +/*
> > > > + * get nfs running listeners
> > > > + */
> > > > +struct nfsd_listener_get_rsp *nfsd_listener_get(struct ynl_sock *y=
s);
> > > > +
> > > > =A0#endif /* _LINUX_NFSD_GEN_H */
> > >=20
> > > --=20
> > > Jeff Layton <jlayton@kernel.org>
> > >=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>

--jRqAJpi5/lHCWSlA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZa6Q/gAKCRA6cBh0uS2t
rMC3AP46TBx+nUPgy9kLpIsZc6AYiVK1IvPU/SvO2D4SY37osgD/Y20msr2ai6CM
UHSffgy0WSY3cBztWb6Bzq+c8IyzGw4=
=/RVg
-----END PGP SIGNATURE-----

--jRqAJpi5/lHCWSlA--

