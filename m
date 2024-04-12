Return-Path: <linux-nfs+bounces-2784-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5CE8A30A5
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 16:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ECFE1C20B55
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Apr 2024 14:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C90F1272C9;
	Fri, 12 Apr 2024 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9J9pPpO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435834AECB;
	Fri, 12 Apr 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931882; cv=none; b=oT1A4I1mg3U5kxLQfJ+qpRtBGjrtseRgDR4ikN9eqrjvuibcUlD+rV9LhefpNy+Ke3oiwn7MQa5tb93d9lxlz+ADyZeNe7Hd7yWeiJ41b9u3UAXT/jHmhibF0/6VTggCZrjWZ80rDvzWLjogcSzYeUWv8ypDmyGpolbL5jxTZtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931882; c=relaxed/simple;
	bh=zMiik+Y1JsRu015cjBpLhZOK6kzw745x4aJRqR0mCEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvirZGLb0wj9fbfQa5GPtzx2mvjD/L2r1GZ177yl0xP7s+3BN6upNlL9R598Zsu1NzYLQT7BjkOVOki+6QhRuQos1oZkygr+KtY4BWv/ZRWHY6KJ7ToLJW9f6CXyfBiDGpvhG8ez7HghSFGOwAFp+08Poa/ArvFTeiniJpXtbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9J9pPpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF94C113CC;
	Fri, 12 Apr 2024 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712931881;
	bh=zMiik+Y1JsRu015cjBpLhZOK6kzw745x4aJRqR0mCEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9J9pPpOhDdee7KB04QlZAJLhz+ARc0lbPmxQnoPL3usgN0fO3V2/MClQBi/Ggi5f
	 AA6ckXdnn73tGBk34epBrAJ0plz42d82+AXI5KAVuC7XxwiGjBtaHnQSsSTOTpMYVD
	 99AHjENeJgVzMZtdEzFjFr8VEAcVptPKkzOR4kPkV+62MqyNFYy/ghG2SON1UX9Ul1
	 6Y+fcjgy4rKTyF/OoxZevNXCJ53CHlm5UEfis2T/ca/qVKzY760WjsZs9ZqfgYyAjx
	 BIFeJ+eg6hpJt7hEWsyFpfbMcFlJQ2olaaLqS6qzc3UpBcRNSKSomzXf+50YWzCaXV
	 3fqjOLuudq3Qg==
Date: Fri, 12 Apr 2024 16:24:37 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, lorenzo.bianconi@redhat.com,
	chuck.lever@oracle.com, neilb@suse.de, netdev@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH v7 1/5] NFSD: convert write_threads to netlink command
Message-ID: <ZhlEJSO6xBG6iLpX@lore-desk>
References: <cover.1712853393.git.lorenzo@kernel.org>
 <d822328a8bdf7c796f6722139accba672466703a.1712853394.git.lorenzo@kernel.org>
 <3880860740b6b1d1eb14dfd21f11904eeee33ce5.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LTW4AJAwUZJqm1aT"
Content-Disposition: inline
In-Reply-To: <3880860740b6b1d1eb14dfd21f11904eeee33ce5.camel@kernel.org>


--LTW4AJAwUZJqm1aT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 2024-04-11 at 18:47 +0200, Lorenzo Bianconi wrote:
> > Introduce write_threads netlink command similar to the one available
> > through the procfs.
> >=20
> > Tested-by: Jeff Layton <jlayton@kernel.org>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/netlink/specs/nfsd.yaml | 23 ++++++++++
> >  fs/nfsd/netlink.c                     | 17 ++++++++
> >  fs/nfsd/netlink.h                     |  2 +
> >  fs/nfsd/nfsctl.c                      | 60 +++++++++++++++++++++++++++
> >  include/uapi/linux/nfsd_netlink.h     |  9 ++++
> >  5 files changed, 111 insertions(+)
> >=20
> > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netl=
ink/specs/nfsd.yaml
> > index 05acc73e2e33..c92e1425d316 100644
> > --- a/Documentation/netlink/specs/nfsd.yaml
> > +++ b/Documentation/netlink/specs/nfsd.yaml
> > @@ -62,6 +62,12 @@ attribute-sets:
> >          name: compound-ops
> >          type: u32
> >          multi-attr: true
> > +  -
> > +    name: server-worker
> > +    attributes:
> > +      -
> > +        name: threads
> > +        type: u32
> > =20
> >  operations:
> >    list:
> > @@ -87,3 +93,20 @@ operations:
> >              - sport
> >              - dport
> >              - compound-ops
> > +    -
> > +      name: threads-set
> > +      doc: set the number of running threads
> > +      attribute-set: server-worker
> > +      flags: [ admin-perm ]
> > +      do:
> > +        request:
> > +          attributes:
> > +            - threads
>=20
> There's only one thing I think we're missing to get feature parity with
> rpc.nfsd, and that's the ability to set the lease-time and grace-time
> when starting the server.
>=20
> I think the simplest thing to do would be to just add 2 optional int
> parameters to the threads-set command. They only matter once you're
> starting the server anyway. I'll see about spinning up a patch, but let
> me know if you see problems with that approach.

ack, I am fine with it, we can squash it in the next revision or send a
follow-up patch.

Regards,
Lorenzo

>=20
> > +    -
> > +      name: threads-get
> > +      doc: get the number of running threads
> > +      attribute-set: server-worker
> > +      do:
> > +        reply:
> > +          attributes:
> > +            - threads
> > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > index 0e1d635ec5f9..1a59a8e6c7e2 100644
> > --- a/fs/nfsd/netlink.c
> > +++ b/fs/nfsd/netlink.c
> > @@ -10,6 +10,11 @@
> > =20
> >  #include <uapi/linux/nfsd_netlink.h>
> > =20
> > +/* NFSD_CMD_THREADS_SET - do */
> > +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVE=
R_WORKER_THREADS + 1] =3D {
> > +	[NFSD_A_SERVER_WORKER_THREADS] =3D { .type =3D NLA_U32, },
> > +};
> > +
> >  /* Ops table for nfsd */
> >  static const struct genl_split_ops nfsd_nl_ops[] =3D {
> >  	{
> > @@ -19,6 +24,18 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D=
 {
> >  		.done	=3D nfsd_nl_rpc_status_get_done,
> >  		.flags	=3D GENL_CMD_CAP_DUMP,
> >  	},
> > +	{
> > +		.cmd		=3D NFSD_CMD_THREADS_SET,
> > +		.doit		=3D nfsd_nl_threads_set_doit,
> > +		.policy		=3D nfsd_threads_set_nl_policy,
> > +		.maxattr	=3D NFSD_A_SERVER_WORKER_THREADS,
> > +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > +	},
> > +	{
> > +		.cmd	=3D NFSD_CMD_THREADS_GET,
> > +		.doit	=3D nfsd_nl_threads_get_doit,
> > +		.flags	=3D GENL_CMD_CAP_DO,
> > +	},
> >  };
> > =20
> >  struct genl_family nfsd_nl_family __ro_after_init =3D {
> > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > index d83dd6bdee92..4137fac477e4 100644
> > --- a/fs/nfsd/netlink.h
> > +++ b/fs/nfsd/netlink.h
> > @@ -16,6 +16,8 @@ int nfsd_nl_rpc_status_get_done(struct netlink_callba=
ck *cb);
> > =20
> >  int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> >  				  struct netlink_callback *cb);
> > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *in=
fo);
> > +int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *in=
fo);
> > =20
> >  extern struct genl_family nfsd_nl_family;
> > =20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 93c87587e646..71608744e67f 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1651,6 +1651,66 @@ int nfsd_nl_rpc_status_get_done(struct netlink_c=
allback *cb)
> >  	return 0;
> >  }
> > =20
> > +/**
> > + * nfsd_nl_threads_set_doit - set the number of running threads
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *in=
fo)
> > +{
> > +	u32 nthreads;
> > +	int ret;
> > +
> > +	if (GENL_REQ_ATTR_CHECK(info, NFSD_A_SERVER_WORKER_THREADS))
> > +		return -EINVAL;
> > +
> > +	nthreads =3D nla_get_u32(info->attrs[NFSD_A_SERVER_WORKER_THREADS]);
> > +	ret =3D nfsd_svc(nthreads,
> > +		       genl_info_net(info), get_current_cred());
> > +
> > +	return ret =3D=3D nthreads ? 0 : -EINVAL;
> > +}
> > +
> > +/**
> > + * nfsd_nl_threads_get_doit - get the number of running threads
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *in=
fo)
> > +{
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
> > +	if (nla_put_u32(skb, NFSD_A_SERVER_WORKER_THREADS,
> > +			nfsd_nrthreads(genl_info_net(info)))) {
> > +		err =3D -EINVAL;
> > +		goto err_free_msg;
> > +	}
> > +
> > +	genlmsg_end(skb, hdr);
> > +
> > +	return genlmsg_reply(skb, info);
> > +
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
> > index 3cd044edee5d..1b6fe1f9ed0e 100644
> > --- a/include/uapi/linux/nfsd_netlink.h
> > +++ b/include/uapi/linux/nfsd_netlink.h
> > @@ -29,8 +29,17 @@ enum {
> >  	NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
> >  };
> > =20
> > +enum {
> > +	NFSD_A_SERVER_WORKER_THREADS =3D 1,
> > +
> > +	__NFSD_A_SERVER_WORKER_MAX,
> > +	NFSD_A_SERVER_WORKER_MAX =3D (__NFSD_A_SERVER_WORKER_MAX - 1)
> > +};
> > +
> >  enum {
> >  	NFSD_CMD_RPC_STATUS_GET =3D 1,
> > +	NFSD_CMD_THREADS_SET,
> > +	NFSD_CMD_THREADS_GET,
> > =20
> >  	__NFSD_CMD_MAX,
> >  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

--LTW4AJAwUZJqm1aT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZhlEJQAKCRA6cBh0uS2t
rC8DAP4796My6I18ohVU0V3XdBh/DgotJI+Fw2G/qgqZaLpN5wD9HsVAWjpPQQRD
XwKMwIb27C5bytqj6vaO86eMZNB8/go=
=KTko
-----END PGP SIGNATURE-----

--LTW4AJAwUZJqm1aT--

