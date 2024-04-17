Return-Path: <linux-nfs+bounces-2875-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656FD8A83BD
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 15:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BED92853C6
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Apr 2024 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2DB13D615;
	Wed, 17 Apr 2024 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5g8kkSg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED2B13D290;
	Wed, 17 Apr 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359044; cv=none; b=lKrkrSSIwYPsSfh6pt3+sGBkPs8tcRNsjyM4P0V6NiytpRJljyh+KjZZciI3dfNdkiWCYIDaF1QCdZnthURsvLcP1Ouavm8YgxEzuaGV4G2Bnsvn4N0CTnHGsYpSoHdHgbOOHDLlIFADU+XFb8QydxAASwiD2TyBBHdG7KOYa1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359044; c=relaxed/simple;
	bh=sHuRTi0gMy9rtYdfWJc1aN/RiGfeu1Fg1igJqHKSN8U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FXmjU204OxKCdudPlUM/zFJ3D0yxdQD6KvDFUya9zUb6WjsCQlTnf3wXsxC/6kAHgTp8e2kgtvPcg6TqDxZ7/3PbeDdYUY3wKYi9gTBjs2a5ecigT3/mfbKgDqaFS9FfhEAY5MSJ8BCdkkVaDaEVygkcpMC2daEiGvO4GMTwPh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5g8kkSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06324C3277B;
	Wed, 17 Apr 2024 13:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713359043;
	bh=sHuRTi0gMy9rtYdfWJc1aN/RiGfeu1Fg1igJqHKSN8U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=S5g8kkSg2qiZ/Mt9BWeU0ppX0HRaqOz8rV7GxcDnvfAUMfNiIoCWsecWhPyTFGv1X
	 d7Lj3+YEAUBfWQDkBqhGC8+IZ4+G2Jjhv8scw2Ae/RhuYnNCpDB8/R3dZVmGKrMvnB
	 UOCF3zjLt0Sl6c9QFeAP3xRYHsD19rnAru6QlMQamJsIDBazrS04ErrCLK8MCjYCYR
	 lK9BHgi1+EGyZh4Q0UKkT+mZ4kEsHfgG1G/Zftpx+5lxAsZTri3zySLsv9Y6Dd84n3
	 HI/KjMLfwvutny27AYTQ5Zp7zkb2YBd1pJd5xdYMgygs2+ORdg5/sdNsflzUpiEDlD
	 ogyybLLM+ZETA==
Message-ID: <4659cdbbe84d40e98cb5926885189d08c94cb2f4.camel@kernel.org>
Subject: Re: [PATCH v8 2/6] NFSD: convert write_threads to netlink command
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com, 
	chuck.lever@oracle.com, netdev@vger.kernel.org, kuba@kernel.org
Date: Wed, 17 Apr 2024 09:04:01 -0400
In-Reply-To: <4571e67647036cbd5833637aca07b6c4cc0e5e67.camel@kernel.org>
References: <cover.1713209938.git.lorenzo@kernel.org>
	 , <4ff777ebb8652e31709bd91c3af50693edf86a26.1713209938.git.lorenzo@kernel.org>
	 <171330451967.17212.2388131327788656190@noble.neil.brown.name>
	 <4571e67647036cbd5833637aca07b6c4cc0e5e67.camel@kernel.org>
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

On Tue, 2024-04-16 at 18:39 -0400, Jeff Layton wrote:
> On Wed, 2024-04-17 at 07:55 +1000, NeilBrown wrote:
> > On Tue, 16 Apr 2024, Lorenzo Bianconi wrote:
> > > Introduce write_threads netlink command similar to the one available
> > > through the procfs.
> >=20
> > I think this should support write_pool_threads too.
> > i.e.  the number of threads should be an array.  If it is a singleton,
> > the it does write_threads.   If larger it does write_pool_threads.
> > I don't think we want to add a separate command later for pool_threads.
> >=20
> > NeilBrown
> >=20
>=20
> That is a very good point. We'll take a closer look at the current
> pool_threads interface and see how we can extend this one to cover that
> use case. Making it an array sounds reasonable at first blush.
>=20

Lorenzo and I had a look this morning:

Doing this properly is going to take some refactoring, I think. The
existing pool code has a weird restriction where you can't bring the
server up and down exclusively using the pool_threads interface. There
are no userland tools for it either, so it's out of scope since it's not
really part of the how rpc.nfsd works today.

I think the way forward here is to go ahead and make this interface use
an array of integers (like Neil suggests), but for now if someone tries
to send down a THREAD_SET operation and the pool_mode isn't global,
we'll just return an error of some sort (EINVAL, EOPNOTSUPP, ?).

One the new interfaces are in I'll take a look at adding support for
managing other pool_modes properly.

Does that sound ok?


> >=20
> > >=20
> > > Tested-by: Jeff Layton <jlayton@kernel.org>
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > > Co-developed-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  Documentation/netlink/specs/nfsd.yaml |  33 ++++++++
> > >  fs/nfsd/netlink.c                     |  19 +++++
> > >  fs/nfsd/netlink.h                     |   2 +
> > >  fs/nfsd/nfsctl.c                      | 104 ++++++++++++++++++++++++=
++
> > >  include/uapi/linux/nfsd_netlink.h     |  11 +++
> > >  5 files changed, 169 insertions(+)
> > >=20
> > > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/ne=
tlink/specs/nfsd.yaml
> > > index 05acc73e2e33..cbe6c5fd6c4d 100644
> > > --- a/Documentation/netlink/specs/nfsd.yaml
> > > +++ b/Documentation/netlink/specs/nfsd.yaml
> > > @@ -62,6 +62,18 @@ attribute-sets:
> > >          name: compound-ops
> > >          type: u32
> > >          multi-attr: true
> > > +  -
> > > +    name: server-worker
> > > +    attributes:
> > > +      -
> > > +        name: threads
> > > +        type: u32
> > > +      -
> > > +        name: gracetime
> > > +        type: u32
> > > +      -
> > > +        name: leasetime
> > > +        type: u32
> > > =20
> > >  operations:
> > >    list:
> > > @@ -87,3 +99,24 @@ operations:
> > >              - sport
> > >              - dport
> > >              - compound-ops
> > > +    -
> > > +      name: threads-set
> > > +      doc: set the number of running threads
> > > +      attribute-set: server-worker
> > > +      flags: [ admin-perm ]
> > > +      do:
> > > +        request:
> > > +          attributes:
> > > +            - threads
> > > +            - gracetime
> > > +            - leasetime
> > > +    -
> > > +      name: threads-get
> > > +      doc: get the number of running threads
> > > +      attribute-set: server-worker
> > > +      do:
> > > +        reply:
> > > +          attributes:
> > > +            - threads
> > > +            - gracetime
> > > +            - leasetime
> > > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > > index 0e1d635ec5f9..20a646af0324 100644
> > > --- a/fs/nfsd/netlink.c
> > > +++ b/fs/nfsd/netlink.c
> > > @@ -10,6 +10,13 @@
> > > =20
> > >  #include <uapi/linux/nfsd_netlink.h>
> > > =20
> > > +/* NFSD_CMD_THREADS_SET - do */
> > > +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SER=
VER_WORKER_LEASETIME + 1] =3D {
> > > +	[NFSD_A_SERVER_WORKER_THREADS] =3D { .type =3D NLA_U32, },
> > > +	[NFSD_A_SERVER_WORKER_GRACETIME] =3D { .type =3D NLA_U32, },
> > > +	[NFSD_A_SERVER_WORKER_LEASETIME] =3D { .type =3D NLA_U32, },
> > > +};
> > > +
> > >  /* Ops table for nfsd */
> > >  static const struct genl_split_ops nfsd_nl_ops[] =3D {
> > >  	{
> > > @@ -19,6 +26,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =
=3D {
> > >  		.done	=3D nfsd_nl_rpc_status_get_done,
> > >  		.flags	=3D GENL_CMD_CAP_DUMP,
> > >  	},
> > > +	{
> > > +		.cmd		=3D NFSD_CMD_THREADS_SET,
> > > +		.doit		=3D nfsd_nl_threads_set_doit,
> > > +		.policy		=3D nfsd_threads_set_nl_policy,
> > > +		.maxattr	=3D NFSD_A_SERVER_WORKER_LEASETIME,
> > > +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > +	},
> > > +	{
> > > +		.cmd	=3D NFSD_CMD_THREADS_GET,
> > > +		.doit	=3D nfsd_nl_threads_get_doit,
> > > +		.flags	=3D GENL_CMD_CAP_DO,
> > > +	},
> > >  };
> > > =20
> > >  struct genl_family nfsd_nl_family __ro_after_init =3D {
> > > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > > index d83dd6bdee92..4137fac477e4 100644
> > > --- a/fs/nfsd/netlink.h
> > > +++ b/fs/nfsd/netlink.h
> > > @@ -16,6 +16,8 @@ int nfsd_nl_rpc_status_get_done(struct netlink_call=
back *cb);
> > > =20
> > >  int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> > >  				  struct netlink_callback *cb);
> > > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *=
info);
> > > +int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *=
info);
> > > =20
> > >  extern struct genl_family nfsd_nl_family;
> > > =20
> > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > index f2e442d7fe16..38a5df03981b 100644
> > > --- a/fs/nfsd/nfsctl.c
> > > +++ b/fs/nfsd/nfsctl.c
> > > @@ -1653,6 +1653,110 @@ int nfsd_nl_rpc_status_get_done(struct netlin=
k_callback *cb)
> > >  	return 0;
> > >  }
> > > =20
> > > +/**
> > > + * nfsd_nl_threads_set_doit - set the number of running threads
> > > + * @skb: reply buffer
> > > + * @info: netlink metadata and command arguments
> > > + *
> > > + * Return 0 on success or a negative errno.
> > > + */
> > > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *=
info)
> > > +{
> > > +	struct net *net =3D genl_info_net(info);
> > > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > > +	int ret =3D -EBUSY;
> > > +	u32 nthreads;
> > > +
> > > +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_WORKER_THREADS))
> > > +		return -EINVAL;
> > > +
> > > +	nthreads =3D nla_get_u32(info->attrs[NFSD_A_SERVER_WORKER_THREADS])=
;
> > > +
> > > +	mutex_lock(&nfsd_mutex);
> > > +	if (info->attrs[NFSD_A_SERVER_WORKER_GRACETIME] ||
> > > +	    info->attrs[NFSD_A_SERVER_WORKER_LEASETIME]) {
> > > +		const struct nlattr *attr;
> > > +
> > > +		if (nn->nfsd_serv && nn->nfsd_serv->sv_nrthreads)
> > > +			goto out_unlock;
> > > +
> > > +		ret =3D -EINVAL;
> > > +		attr =3D info->attrs[NFSD_A_SERVER_WORKER_GRACETIME];
> > > +		if (attr) {
> > > +			u32 gracetime =3D nla_get_u32(attr);
> > > +
> > > +			if (gracetime < 10 || gracetime > 3600)
> > > +				goto out_unlock;
> > > +
> > > +			nn->nfsd4_grace =3D gracetime;
> > > +		}
> > > +
> > > +		attr =3D info->attrs[NFSD_A_SERVER_WORKER_LEASETIME];
> > > +		if (attr) {
> > > +			u32 leasetime =3D nla_get_u32(attr);
> > > +
> > > +			if (leasetime < 10 || leasetime > 3600)
> > > +				goto out_unlock;
> > > +
> > > +			nn->nfsd4_lease =3D leasetime;
> > > +		}
> > > +	}
> > > +
> > > +	ret =3D nfsd_svc(nthreads, net, get_current_cred());
> > > +out_unlock:
> > > +	mutex_unlock(&nfsd_mutex);
> > > +
> > > +	return ret =3D=3D nthreads ? 0 : ret;
> > > +}
> > > +
> > > +/**
> > > + * nfsd_nl_threads_get_doit - get the number of running threads
> > > + * @skb: reply buffer
> > > + * @info: netlink metadata and command arguments
> > > + *
> > > + * Return 0 on success or a negative errno.
> > > + */
> > > +int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *=
info)
> > > +{
> > > +	struct net *net =3D genl_info_net(info);
> > > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
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
> > > +	err =3D nla_put_u32(skb, NFSD_A_SERVER_WORKER_GRACETIME,
> > > +			  nn->nfsd4_grace) ||
> > > +	      nla_put_u32(skb, NFSD_A_SERVER_WORKER_LEASETIME,
> > > +			  nn->nfsd4_lease) ||
> > > +	      nla_put_u32(skb, NFSD_A_SERVER_WORKER_THREADS,
> > > +			  nn->nfsd_serv ? nn->nfsd_serv->sv_nrthreads : 0);
> > > +	mutex_unlock(&nfsd_mutex);
> > > +
> > > +	if (err) {
> > > +		err =3D -EINVAL;
> > > +		goto err_free_msg;
> > > +	}
> > > +
> > > +	genlmsg_end(skb, hdr);
> > > +
> > > +	return genlmsg_reply(skb, info);
> > > +
> > > +err_free_msg:
> > > +	nlmsg_free(skb);
> > > +
> > > +	return err;
> > > +}
> > > +
> > >  /**
> > >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespa=
ce
> > >   * @net: a freshly-created network namespace
> > > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/n=
fsd_netlink.h
> > > index 3cd044edee5d..ccc78a5ee650 100644
> > > --- a/include/uapi/linux/nfsd_netlink.h
> > > +++ b/include/uapi/linux/nfsd_netlink.h
> > > @@ -29,8 +29,19 @@ enum {
> > >  	NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
> > >  };
> > > =20
> > > +enum {
> > > +	NFSD_A_SERVER_WORKER_THREADS =3D 1,
> > > +	NFSD_A_SERVER_WORKER_GRACETIME,
> > > +	NFSD_A_SERVER_WORKER_LEASETIME,
> > > +
> > > +	__NFSD_A_SERVER_WORKER_MAX,
> > > +	NFSD_A_SERVER_WORKER_MAX =3D (__NFSD_A_SERVER_WORKER_MAX - 1)
> > > +};
> > > +
> > >  enum {
> > >  	NFSD_CMD_RPC_STATUS_GET =3D 1,
> > > +	NFSD_CMD_THREADS_SET,
> > > +	NFSD_CMD_THREADS_GET,
> > > =20
> > >  	__NFSD_CMD_MAX,
> > >  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> > > --=20
> > > 2.44.0
> > >=20
> > >=20
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

