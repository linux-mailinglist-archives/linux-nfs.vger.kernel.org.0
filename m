Return-Path: <linux-nfs+bounces-191-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEB57FEC5D
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 10:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 715542821E0
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 09:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2033B291;
	Thu, 30 Nov 2023 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtFRSeWv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF5F125CC;
	Thu, 30 Nov 2023 09:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D3DC433C7;
	Thu, 30 Nov 2023 09:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701338231;
	bh=cX4RdpcedApKzx0MfOpQoLqxHZ6pmk0psKGchdeZ7eQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtFRSeWvtqsOXVwjaWa4otmtuQOf91IvoS62ckWSWYumAiSp8lzILkiSbgGE6lokt
	 zZtdsJNMyKK+cxyZTO2Ougb/k5sb2Bk6qmtSz35GWU+DcfvSQRhJN3+2iFGXq03hyl
	 rDDDHxCMF3+mP9aPUHPQnB1TseAeEYYZvb2lFXfBvqrUjzK5l5NZoJbzlkm/lkITwt
	 2EEtfqxnYBOWAvr5w/3rDIJpe2wzFKGg3+HpPJ5+10sHQnNYUfJaLLF6W4o7Chuydx
	 1WPY0j3nxpeXXCA+KAz90OkYuffWYOPivoYnII52t5XvHlgzYVFaDTYQrOAoPCbvRP
	 3Ckg94TXC7hGQ==
Date: Thu, 30 Nov 2023 10:57:07 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com, neilb@suse.de,
	netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH v5 3/3] NFSD: convert write_ports to netlink command
Message-ID: <ZWhcc8384pf11sAu@lore-desk>
References: <cover.1701277475.git.lorenzo@kernel.org>
 <67251eabfbbccb806991e6437ebcf1cf00166017.1701277475.git.lorenzo@kernel.org>
 <7b21c962c2a6c552c9807d6f382e1097da4ba748.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IoCdK9UYi/dyDdfm"
Content-Disposition: inline
In-Reply-To: <7b21c962c2a6c552c9807d6f382e1097da4ba748.camel@kernel.org>


--IoCdK9UYi/dyDdfm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, 2023-11-29 at 18:12 +0100, Lorenzo Bianconi wrote:
> > Introduce write_ports netlink command similar to the ones available
> > through the procfs.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/netlink/specs/nfsd.yaml |  28 +++++++
> >  fs/nfsd/netlink.c                     |  18 +++++
> >  fs/nfsd/netlink.h                     |   3 +
> >  fs/nfsd/nfsctl.c                      | 104 ++++++++++++++++++++++++--
> >  include/uapi/linux/nfsd_netlink.h     |  10 +++
> >  tools/net/ynl/generated/nfsd-user.c   |  81 ++++++++++++++++++++
> >  tools/net/ynl/generated/nfsd-user.h   |  54 +++++++++++++
> >  7 files changed, 291 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netl=
ink/specs/nfsd.yaml
> > index 6c5e42bb20f6..1c342ad3c5fa 100644
> > --- a/Documentation/netlink/specs/nfsd.yaml
> > +++ b/Documentation/netlink/specs/nfsd.yaml
> > @@ -80,6 +80,15 @@ attribute-sets:
> >        -
> >          name: status
> >          type: u8
> > +  -
> > +    name: server-listener
> > +    attributes:
> > +      -
> > +        name: transport-name
> > +        type: string
> > +      -
> > +        name: port
> > +        type: u32
> > =20
> >  operations:
> >    list:
> > @@ -142,3 +151,22 @@ operations:
> >            attributes:
> >              - major
> >              - minor
> > +    -
> > +      name: listener-start
> > +      doc: start server listener
> > +      attribute-set: server-listener
> > +      flags: [ admin-perm ]
> > +      do:
> > +        request:
> > +          attributes:
> > +            - transport-name
> > +            - port
> > +    -
> > +      name: listener-get
> > +      doc: dump server listeners
> > +      attribute-set: server-listener
> > +      dump:
> > +        reply:
> > +          attributes:
> > +            - transport-name
> > +            - port
> > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > index 0608a7bd193b..cd51393ede72 100644
> > --- a/fs/nfsd/netlink.c
> > +++ b/fs/nfsd/netlink.c
> > @@ -22,6 +22,12 @@ static const struct nla_policy nfsd_version_set_nl_p=
olicy[NFSD_A_SERVER_VERSION_
> >  	[NFSD_A_SERVER_VERSION_STATUS] =3D { .type =3D NLA_U8, },
> >  };
> > =20
> > +/* NFSD_CMD_LISTENER_START - do */
> > +static const struct nla_policy nfsd_listener_start_nl_policy[NFSD_A_SE=
RVER_LISTENER_PORT + 1] =3D {
> > +	[NFSD_A_SERVER_LISTENER_TRANSPORT_NAME] =3D { .type =3D NLA_NUL_STRIN=
G, },
> > +	[NFSD_A_SERVER_LISTENER_PORT] =3D { .type =3D NLA_U32, },
> > +};
> > +
> >  /* Ops table for nfsd */
> >  static const struct genl_split_ops nfsd_nl_ops[] =3D {
> >  	{
> > @@ -55,6 +61,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D=
 {
> >  		.dumpit	=3D nfsd_nl_version_get_dumpit,
> >  		.flags	=3D GENL_CMD_CAP_DUMP,
> >  	},
> > +	{
> > +		.cmd		=3D NFSD_CMD_LISTENER_START,
> > +		.doit		=3D nfsd_nl_listener_start_doit,
> > +		.policy		=3D nfsd_listener_start_nl_policy,
> > +		.maxattr	=3D NFSD_A_SERVER_LISTENER_PORT,
> > +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > +	},
> > +	{
> > +		.cmd	=3D NFSD_CMD_LISTENER_GET,
> > +		.dumpit	=3D nfsd_nl_listener_get_dumpit,
> > +		.flags	=3D GENL_CMD_CAP_DUMP,
> > +	},
> >  };
> > =20
> >  struct genl_family nfsd_nl_family __ro_after_init =3D {
> > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > index 7d203cec08e4..9a51cb83f343 100644
> > --- a/fs/nfsd/netlink.h
> > +++ b/fs/nfsd/netlink.h
> > @@ -21,6 +21,9 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, str=
uct genl_info *info);
> >  int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *in=
fo);
> >  int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
> >  			       struct netlink_callback *cb);
> > +int nfsd_nl_listener_start_doit(struct sk_buff *skb, struct genl_info =
*info);
> > +int nfsd_nl_listener_get_dumpit(struct sk_buff *skb,
> > +				struct netlink_callback *cb);
> > =20
> >  extern struct genl_family nfsd_nl_family;
> > =20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index f04430f79687..53129b5b7d3c 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -721,18 +721,16 @@ static ssize_t __write_ports_addfd(char *buf, str=
uct net *net, const struct cred
> >   * A transport listener is added by writing its transport name and
> >   * a port number.
> >   */
> > -static ssize_t __write_ports_addxprt(char *buf, struct net *net, const=
 struct cred *cred)
> > +static ssize_t ___write_ports_addxprt(struct net *net, const struct cr=
ed *cred,
> > +				      const char *transport, const int port)
> >  {
> > -	char transport[16];
> > -	struct svc_xprt *xprt;
> > -	int port, err;
> >  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > -
> > -	if (sscanf(buf, "%15s %5u", transport, &port) !=3D 2)
> > -		return -EINVAL;
> > +	struct svc_xprt *xprt;
> > +	int err;
> > =20
> >  	if (port < 1 || port > USHRT_MAX)
> >  		return -EINVAL;
> > +
> >  	trace_nfsd_ctl_ports_addxprt(net, transport, port);
> > =20
> >  	err =3D nfsd_create_serv(net);
> > @@ -765,6 +763,17 @@ static ssize_t __write_ports_addxprt(char *buf, st=
ruct net *net, const struct cr
> >  	return err;
> >  }
> > =20
> > +static ssize_t __write_ports_addxprt(char *buf, struct net *net, const=
 struct cred *cred)
> > +{
> > +	char transport[16];
> > +	int port;
> > +
> > +	if (sscanf(buf, "%15s %5u", transport, &port) !=3D 2)
> > +		return -EINVAL;
> > +
> > +	return ___write_ports_addxprt(net, cred, transport, port);
> > +}
> > +
> >  static ssize_t __write_ports(struct file *file, char *buf, size_t size,
> >  			     struct net *net)
> >  {
> > @@ -1862,6 +1871,87 @@ int nfsd_nl_version_get_dumpit(struct sk_buff *s=
kb,
> >  	return ret;
> >  }
> > =20
> > +/**
> > + * nfsd_nl_listener_start_doit - start the provided nfs server listener
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_listener_start_doit(struct sk_buff *skb, struct genl_info =
*info)
> > +{
> > +	int ret;
> > +
> > +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_LISTENER_TRANSPORT_NAME) =
||
> > +	    GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_LISTENER_PORT))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +	ret =3D ___write_ports_addxprt(genl_info_net(info), get_current_cred(=
),
> > +			nla_data(info->attrs[NFSD_A_SERVER_LISTENER_TRANSPORT_NAME]),
> > +			nla_get_u32(info->attrs[NFSD_A_SERVER_LISTENER_PORT]));
> > +	mutex_unlock(&nfsd_mutex);
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * nfsd_nl_version_get_dumpit - Handle listener_get dumpit
> > + * @skb: reply buffer
> > + * @cb: netlink metadata and command arguments
> > + *
> > + * Returns the size of the reply or a negative errno.
> > + */
> > +int nfsd_nl_listener_get_dumpit(struct sk_buff *skb,
> > +				struct netlink_callback *cb)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(sock_net(skb->sk), nfsd_net_id);
> > +	int i =3D 0, ret =3D -ENOMEM;
> > +	struct svc_xprt *xprt;
> > +	struct svc_serv *serv;
> > +
> > +	mutex_lock(&nfsd_mutex);
> > +
> > +	serv =3D nn->nfsd_serv;
> > +	if (!serv) {
> > +		mutex_unlock(&nfsd_mutex);
> > +		return 0;
> > +	}
> > +
> > +	spin_lock_bh(&serv->sv_lock);
> > +	list_for_each_entry(xprt, &serv->sv_permsocks, xpt_list) {
> > +		void *hdr;
> > +
> > +		if (i < cb->args[0]) /* already consumed */
> > +			continue;
> > +
> > +		hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> > +				  cb->nlh->nlmsg_seq, &nfsd_nl_family,
> > +				  0, NFSD_CMD_LISTENER_GET);
> > +		if (!hdr)
> > +			goto out;
> > +
> > +		if (nla_put_string(skb, NFSD_A_SERVER_LISTENER_TRANSPORT_NAME,
> > +				   xprt->xpt_class->xcl_name))
> > +			goto out;
> > +
> > +		if (nla_put_u32(skb, NFSD_A_SERVER_LISTENER_PORT,
> > +				svc_xprt_local_port(xprt)))
> > +			goto out;
> > +
> > +		genlmsg_end(skb, hdr);
> > +		i++;
> > +	}
> > +	cb->args[0] =3D i;
> > +	ret =3D skb->len;
> > +out:
> > +	spin_unlock_bh(&serv->sv_lock);
> > +
> > +	mutex_unlock(&nfsd_mutex);
> > +
> > +	return ret;
> > +}
> > +
> >  /**
> >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
> >   * @net: a freshly-created network namespace
> > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfs=
d_netlink.h
> > index 1b3340f31baa..61f4c5b50ecb 100644
> > --- a/include/uapi/linux/nfsd_netlink.h
> > +++ b/include/uapi/linux/nfsd_netlink.h
> > @@ -45,12 +45,22 @@ enum {
> >  	NFSD_A_SERVER_VERSION_MAX =3D (__NFSD_A_SERVER_VERSION_MAX - 1)
> >  };
> > =20
> > +enum {
> > +	NFSD_A_SERVER_LISTENER_TRANSPORT_NAME =3D 1,
> > +	NFSD_A_SERVER_LISTENER_PORT,
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
> > +	NFSD_CMD_LISTENER_START,
> > +	NFSD_CMD_LISTENER_GET,
> > =20
> >  	__NFSD_CMD_MAX,
> >  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> > diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/genera=
ted/nfsd-user.c
> > index 4cb71c3cd18d..167e404c9e20 100644
> > --- a/tools/net/ynl/generated/nfsd-user.c
> > +++ b/tools/net/ynl/generated/nfsd-user.c
> > @@ -19,6 +19,8 @@ static const char * const nfsd_op_strmap[] =3D {
> >  	[NFSD_CMD_THREADS_GET] =3D "threads-get",
> >  	[NFSD_CMD_VERSION_SET] =3D "version-set",
> >  	[NFSD_CMD_VERSION_GET] =3D "version-get",
> > +	[NFSD_CMD_LISTENER_START] =3D "listener-start",
> > +	[NFSD_CMD_LISTENER_GET] =3D "listener-get",
> >  };
> > =20
> >  const char *nfsd_op_str(int op)
> > @@ -71,6 +73,16 @@ struct ynl_policy_nest nfsd_server_version_nest =3D {
> >  	.table =3D nfsd_server_version_policy,
> >  };
> > =20
> > +struct ynl_policy_attr nfsd_server_listener_policy[NFSD_A_SERVER_LISTE=
NER_MAX + 1] =3D {
> > +	[NFSD_A_SERVER_LISTENER_TRANSPORT_NAME] =3D { .name =3D "transport-na=
me", .type =3D YNL_PT_NUL_STR, },
> > +	[NFSD_A_SERVER_LISTENER_PORT] =3D { .name =3D "port", .type =3D YNL_P=
T_U32, },
> > +};
> > +
> > +struct ynl_policy_nest nfsd_server_listener_nest =3D {
> > +	.max_attr =3D NFSD_A_SERVER_LISTENER_MAX,
> > +	.table =3D nfsd_server_listener_policy,
> > +};
> > +
> >  /* Common nested types */
> >  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATUS_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> >  /* NFSD_CMD_RPC_STATUS_GET - dump */
> > @@ -371,6 +383,75 @@ struct nfsd_version_get_list *nfsd_version_get_dum=
p(struct ynl_sock *ys)
> >  	return NULL;
> >  }
> > =20
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_START =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +/* NFSD_CMD_LISTENER_START - do */
> > +void nfsd_listener_start_req_free(struct nfsd_listener_start_req *req)
> > +{
> > +	free(req->transport_name);
> > +	free(req);
> > +}
> > +
> > +int nfsd_listener_start(struct ynl_sock *ys,
> > +			struct nfsd_listener_start_req *req)
> > +{
> > +	struct nlmsghdr *nlh;
> > +	int err;
> > +
> > +	nlh =3D ynl_gemsg_start_req(ys, ys->family_id, NFSD_CMD_LISTENER_STAR=
T, 1);
> > +	ys->req_policy =3D &nfsd_server_listener_nest;
> > +
> > +	if (req->_present.transport_name_len)
> > +		mnl_attr_put_strz(nlh, NFSD_A_SERVER_LISTENER_TRANSPORT_NAME, req->t=
ransport_name);
> > +	if (req->_present.port)
> > +		mnl_attr_put_u32(nlh, NFSD_A_SERVER_LISTENER_PORT, req->port);
> > +
> > +	err =3D ynl_exec(ys, nlh, NULL);
> > +	if (err < 0)
> > +		return -1;
> > +
> > +	return 0;
> > +}
> > +
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +/* NFSD_CMD_LISTENER_GET - dump */
> > +void nfsd_listener_get_list_free(struct nfsd_listener_get_list *rsp)
> > +{
> > +	struct nfsd_listener_get_list *next =3D rsp;
> > +
> > +	while ((void *)next !=3D YNL_LIST_END) {
> > +		rsp =3D next;
> > +		next =3D rsp->next;
> > +
> > +		free(rsp->obj.transport_name);
> > +		free(rsp);
> > +	}
> > +}
> > +
> > +struct nfsd_listener_get_list *nfsd_listener_get_dump(struct ynl_sock =
*ys)
> > +{
> > +	struct ynl_dump_state yds =3D {};
> > +	struct nlmsghdr *nlh;
> > +	int err;
> > +
> > +	yds.ys =3D ys;
> > +	yds.alloc_sz =3D sizeof(struct nfsd_listener_get_list);
> > +	yds.cb =3D nfsd_listener_get_rsp_parse;
> > +	yds.rsp_cmd =3D NFSD_CMD_LISTENER_GET;
> > +	yds.rsp_policy =3D &nfsd_server_listener_nest;
> > +
> > +	nlh =3D ynl_gemsg_start_dump(ys, ys->family_id, NFSD_CMD_LISTENER_GET=
, 1);
> > +
> > +	err =3D ynl_exec_dump(ys, nlh, &yds);
> > +	if (err < 0)
> > +		goto free_list;
> > +
> > +	return yds.first;
> > +
> > +free_list:
> > +	nfsd_listener_get_list_free(yds.first);
> > +	return NULL;
> > +}
> > +
> >  const struct ynl_family ynl_nfsd_family =3D  {
> >  	.name		=3D "nfsd",
> >  };
> > diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/genera=
ted/nfsd-user.h
> > index e61c5a9e46fb..da3aaaf3f6c0 100644
> > --- a/tools/net/ynl/generated/nfsd-user.h
> > +++ b/tools/net/ynl/generated/nfsd-user.h
> > @@ -166,4 +166,58 @@ void nfsd_version_get_list_free(struct nfsd_versio=
n_get_list *rsp);
> > =20
> >  struct nfsd_version_get_list *nfsd_version_get_dump(struct ynl_sock *y=
s);
> > =20
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_START =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +/* NFSD_CMD_LISTENER_START - do */
> > +struct nfsd_listener_start_req {
> > +	struct {
> > +		__u32 transport_name_len;
> > +		__u32 port:1;
> > +	} _present;
> > +
> > +	char *transport_name;
> > +	__u32 port;
> > +};
>=20
> How do you deconfigure a listener with this interface? i.e. suppose I
> want to stop nfsd from listening on a particular port? I think this too
> is a place where a declarative interface would be better:

Is it possible with current APIs? as for 2/3 so far I have just added netli=
nk
counter for current implementation but I am fine to change the logic here to
better APIs.

Regards,
Lorenzo

>=20
> Have userland send down a list of the ports that we should currently be
> listening on, and let the kernel do the work to match the request. Again
> too, an empty list could mean "close everything".
>=20
> > +
> > +static inline struct nfsd_listener_start_req *
> > +nfsd_listener_start_req_alloc(void)
> > +{
> > +	return calloc(1, sizeof(struct nfsd_listener_start_req));
> > +}
> > +void nfsd_listener_start_req_free(struct nfsd_listener_start_req *req);
> > +
> > +static inline void
> > +nfsd_listener_start_req_set_transport_name(struct nfsd_listener_start_=
req *req,
> > +					   const char *transport_name)
> > +{
> > +	free(req->transport_name);
> > +	req->_present.transport_name_len =3D strlen(transport_name);
> > +	req->transport_name =3D malloc(req->_present.transport_name_len + 1);
> > +	memcpy(req->transport_name, transport_name, req->_present.transport_n=
ame_len);
> > +	req->transport_name[req->_present.transport_name_len] =3D 0;
> > +}
> > +static inline void
> > +nfsd_listener_start_req_set_port(struct nfsd_listener_start_req *req,
> > +				 __u32 port)
> > +{
> > +	req->_present.port =3D 1;
> > +	req->port =3D port;
> > +}
> > +
> > +/*
> > + * start server listener
> > + */
> > +int nfsd_listener_start(struct ynl_sock *ys,
> > +			struct nfsd_listener_start_req *req);
> > +
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_LISTENER_GET =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > +/* NFSD_CMD_LISTENER_GET - dump */
> > +struct nfsd_listener_get_list {
> > +	struct nfsd_listener_get_list *next;
> > +	struct nfsd_listener_get_rsp obj __attribute__ ((aligned (8)));
> > +};
> > +
> > +void nfsd_listener_get_list_free(struct nfsd_listener_get_list *rsp);
> > +
> > +struct nfsd_listener_get_list *nfsd_listener_get_dump(struct ynl_sock =
*ys);
> > +
> >  #endif /* _LINUX_NFSD_GEN_H */
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

--IoCdK9UYi/dyDdfm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZWhccwAKCRA6cBh0uS2t
rJUMAP4vUeBdFvUyA3GomN9S8ASpUVfjOuqwOFPKm1l/3q0AagEAyhmU5CyX3cA2
RoVGprNrNX9PYj9sfNmdO5AL0eBJ/AE=
=DE7N
-----END PGP SIGNATURE-----

--IoCdK9UYi/dyDdfm--

