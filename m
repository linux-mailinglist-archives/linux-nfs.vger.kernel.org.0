Return-Path: <linux-nfs+bounces-215-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AA27FF51A
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 17:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9AF28178C
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Nov 2023 16:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF8854FAA;
	Thu, 30 Nov 2023 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4GMBNwj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE0524D9;
	Thu, 30 Nov 2023 16:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7127C433C9;
	Thu, 30 Nov 2023 16:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701361556;
	bh=8VVQLToS1vy3rKIpu86bjICXx+VSgjDOqxroXLRR97E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4GMBNwj8KDwneTPTSb3pYm20P5Xi58HSHzbZ7rQznSfmNidDU7b4LA0IXsTLUbDX
	 0uxMdBuN8p1ta13bTWxklfdhbdx7gJ8iwKAeStxwJbIrAHpGp3FPxiCrB8laOsrQlj
	 xoToMXa7v0lUlRztfh5vpfi+wDDUvMXRsAxwwiyOPNdgoiJmp5HB1GTOXU+YkJ7Wt8
	 rOCrDCnx+dSCANJBRt4imodByXP7GPeB1kOiSDI8DcR5Yru/1G74fP+BLBphKy7ZDT
	 c1T4CI38bwBTtv4sf8Q1xinU0E8oazochyd27P3BMbPwCok10qIsW+5wTZlx9ZdcTu
	 MiCCmIOAhJG3Q==
Date: Thu, 30 Nov 2023 17:25:52 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	lorenzo.bianconi@redhat.com, neilb@suse.de, netdev@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH v5 2/3] NFSD: convert write_version to netlink command
Message-ID: <ZWi3kO5nOXqzC5mS@lore-desk>
References: <cover.1701277475.git.lorenzo@kernel.org>
 <8b47d2e3f704066204149653fd1bd86a64188f61.1701277475.git.lorenzo@kernel.org>
 <88d91863e36a1e36f7770aa8a7f42853250e3d55.camel@kernel.org>
 <ZWi0OkrOsv8j6ev3@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="37F321gJSmZfvSF+"
Content-Disposition: inline
In-Reply-To: <ZWi0OkrOsv8j6ev3@tissot.1015granger.net>


--37F321gJSmZfvSF+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Nov 29, 2023 at 01:23:37PM -0500, Jeff Layton wrote:
> > On Wed, 2023-11-29 at 18:12 +0100, Lorenzo Bianconi wrote:
> > > Introduce write_version netlink command similar to the ones available
> > > through the procfs.
> > >=20
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  Documentation/netlink/specs/nfsd.yaml |  32 ++++++++
> > >  fs/nfsd/netlink.c                     |  19 +++++
> > >  fs/nfsd/netlink.h                     |   3 +
> > >  fs/nfsd/nfsctl.c                      | 105 ++++++++++++++++++++++++=
++
> > >  include/uapi/linux/nfsd_netlink.h     |  11 +++
> > >  tools/net/ynl/generated/nfsd-user.c   |  81 ++++++++++++++++++++
> > >  tools/net/ynl/generated/nfsd-user.h   |  55 ++++++++++++++
> > >  7 files changed, 306 insertions(+)
> > >=20
> > > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/ne=
tlink/specs/nfsd.yaml
> > > index c92e1425d316..6c5e42bb20f6 100644
> > > --- a/Documentation/netlink/specs/nfsd.yaml
> > > +++ b/Documentation/netlink/specs/nfsd.yaml
> > > @@ -68,6 +68,18 @@ attribute-sets:
> > >        -
> > >          name: threads
> > >          type: u32
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
> > > =20
> > >  operations:
> > >    list:
> > > @@ -110,3 +122,23 @@ operations:
> > >          reply:
> > >            attributes:
> > >              - threads
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
> > >  	[NFSD_A_SERVER_WORKER_THREADS] =3D { .type =3D NLA_U32, },
> > >  };
> > > =20
> > > +/* NFSD_CMD_VERSION_SET - do */
> > > +static const struct nla_policy nfsd_version_set_nl_policy[NFSD_A_SER=
VER_VERSION_STATUS + 1] =3D {
> > > +	[NFSD_A_SERVER_VERSION_MAJOR] =3D { .type =3D NLA_U32, },
> > > +	[NFSD_A_SERVER_VERSION_MINOR] =3D { .type =3D NLA_U32, },
> > > +	[NFSD_A_SERVER_VERSION_STATUS] =3D { .type =3D NLA_U8, },
> > > +};
> > > +
> > >  /* Ops table for nfsd */
> > >  static const struct genl_split_ops nfsd_nl_ops[] =3D {
> > >  	{
> > > @@ -36,6 +43,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =
=3D {
> > >  		.doit	=3D nfsd_nl_threads_get_doit,
> > >  		.flags	=3D GENL_CMD_CAP_DO,
> > >  	},
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
> > >  };
> > > =20
> > >  struct genl_family nfsd_nl_family __ro_after_init =3D {
> > > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > > index 4137fac477e4..7d203cec08e4 100644
> > > --- a/fs/nfsd/netlink.h
> > > +++ b/fs/nfsd/netlink.h
> > > @@ -18,6 +18,9 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *s=
kb,
> > >  				  struct netlink_callback *cb);
> > >  int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *=
info);
> > >  int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *=
info);
> > > +int nfsd_nl_version_set_doit(struct sk_buff *skb, struct genl_info *=
info);
> > > +int nfsd_nl_version_get_dumpit(struct sk_buff *skb,
> > > +			       struct netlink_callback *cb);
> > > =20
> > >  extern struct genl_family nfsd_nl_family;
> > > =20
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index 130b3d937a79..f04430f79687 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -1757,6 +1757,111 @@ int nfsd_nl_threads_get_doit(struct sk_buff *=
skb, struct genl_info *info)
> > >  	return err;
> > >  }
> > > =20
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
> > > +	struct nfsd_net *nn =3D net_generic(sock_net(skb->sk), nfsd_net_id);
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
> > >  /**
> > >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespa=
ce
> > >   * @net: a freshly-created network namespace
> > > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/n=
fsd_netlink.h
> > > index 1b6fe1f9ed0e..1b3340f31baa 100644
> > > --- a/include/uapi/linux/nfsd_netlink.h
> > > +++ b/include/uapi/linux/nfsd_netlink.h
> > > @@ -36,10 +36,21 @@ enum {
> > >  	NFSD_A_SERVER_WORKER_MAX =3D (__NFSD_A_SERVER_WORKER_MAX - 1)
> > >  };
> > > =20
> > > +enum {
> > > +	NFSD_A_SERVER_VERSION_MAJOR =3D 1,
> > > +	NFSD_A_SERVER_VERSION_MINOR,
> > > +	NFSD_A_SERVER_VERSION_STATUS,
> > > +
> > > +	__NFSD_A_SERVER_VERSION_MAX,
> > > +	NFSD_A_SERVER_VERSION_MAX =3D (__NFSD_A_SERVER_VERSION_MAX - 1)
> > > +};
> > > +
> > >  enum {
> > >  	NFSD_CMD_RPC_STATUS_GET =3D 1,
> > >  	NFSD_CMD_THREADS_SET,
> > >  	NFSD_CMD_THREADS_GET,
> > > +	NFSD_CMD_VERSION_SET,
> > > +	NFSD_CMD_VERSION_GET,
> > > =20
> > >  	__NFSD_CMD_MAX,
> > >  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> > > diff --git a/tools/net/ynl/generated/nfsd-user.c b/tools/net/ynl/gene=
rated/nfsd-user.c
> > > index 9768328a7751..4cb71c3cd18d 100644
> > > --- a/tools/net/ynl/generated/nfsd-user.c
> > > +++ b/tools/net/ynl/generated/nfsd-user.c
> > > @@ -17,6 +17,8 @@ static const char * const nfsd_op_strmap[] =3D {
> > >  	[NFSD_CMD_RPC_STATUS_GET] =3D "rpc-status-get",
> > >  	[NFSD_CMD_THREADS_SET] =3D "threads-set",
> > >  	[NFSD_CMD_THREADS_GET] =3D "threads-get",
> > > +	[NFSD_CMD_VERSION_SET] =3D "version-set",
> > > +	[NFSD_CMD_VERSION_GET] =3D "version-get",
> > >  };
> > > =20
> > >  const char *nfsd_op_str(int op)
> > > @@ -58,6 +60,17 @@ struct ynl_policy_nest nfsd_server_worker_nest =3D=
 {
> > >  	.table =3D nfsd_server_worker_policy,
> > >  };
> > > =20
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
> > >  /* Common nested types */
> > >  /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D NFSD_CMD_RPC_STATUS_GE=
T =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> > >  /* NFSD_CMD_RPC_STATUS_GET - dump */
> > > @@ -290,6 +303,74 @@ struct nfsd_threads_get_rsp *nfsd_threads_get(st=
ruct ynl_sock *ys)
> > >  	return NULL;
> > >  }
> > > =20
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
> > >  const struct ynl_family ynl_nfsd_family =3D  {
> > >  	.name		=3D "nfsd",
> > >  };
> > > diff --git a/tools/net/ynl/generated/nfsd-user.h b/tools/net/ynl/gene=
rated/nfsd-user.h
> > > index e162a4f20d91..e61c5a9e46fb 100644
> > > --- a/tools/net/ynl/generated/nfsd-user.h
> > > +++ b/tools/net/ynl/generated/nfsd-user.h
> > > @@ -111,4 +111,59 @@ void nfsd_threads_get_rsp_free(struct nfsd_threa=
ds_get_rsp *rsp);
> > >   */
> > >  struct nfsd_threads_get_rsp *nfsd_threads_get(struct ynl_sock *ys);
> > > =20
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
> > be enabled, and then just let the kernel figure out whether to enable or
> > disable each. An empty list could mean "disable everything".
> >=20
> > That's simpler to reason out as an interface from userland too. Trying
> > to keep track of the enabled and disabled versions and twiddle it is
> > really tricky in rpc.nfsd today.
>=20
> Jeff and Lorenzo, this sounds to me like a useful and narrow
> improvement to this interface, one that should be implemented as
> part of this patch series.

ack, I am fine with it, I will work on patch 2/3 and 3/3.
@Chuck: am I suppose to respin patch 1/3 too?

Regards,
Lorenzo

>=20
> Ditto for Jeff's review comment on 3/3.
>=20
>=20
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
> > >  #endif /* _LINUX_NFSD_GEN_H */
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20
>=20
> --=20
> Chuck Lever

--37F321gJSmZfvSF+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZWi3kAAKCRA6cBh0uS2t
rLHgAQCDwNl7yU1uFa0G9ikMsvUE2NoQPHbcP95m7iFF2LRK6wD9Hvv+LbrLsfjB
eKFSHzz80nXII23QEWNQCLHu0byoFAw=
=bLrz
-----END PGP SIGNATURE-----

--37F321gJSmZfvSF+--

