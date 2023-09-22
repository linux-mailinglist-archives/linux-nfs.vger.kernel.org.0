Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B287AB5C4
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 18:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjIVQVi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Sep 2023 12:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjIVQVd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Sep 2023 12:21:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF412AC
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 09:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695399643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N9dWQMyY29t0wR7wAqt+YAF4UGVxKmfZQHVC/zI3Xbo=;
        b=UQkJt5V+huWk46WvTIgLjIJoKYmFyKK4IINJ8XCeQXHKAqdfozaEmTwHR5oGHUqi2ef3By
        7HaQ3ShAVjWGdKWG0YGaV1cQqf8EPVW/HpClbFlKH6AXwLurOqDOW65TvB5YJhU4VapsWn
        Qm561FXLnuZQkpLeqhbJLHVSHfaoaGY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-az7hgfrEN9W1-xF8hAGEug-1; Fri, 22 Sep 2023 12:20:40 -0400
X-MC-Unique: az7hgfrEN9W1-xF8hAGEug-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-317d5b38194so614672f8f.0
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 09:20:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695399639; x=1696004439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9dWQMyY29t0wR7wAqt+YAF4UGVxKmfZQHVC/zI3Xbo=;
        b=pDXjrFznEJtU0pJP7TDqmpQC6hwf/EDN9enH0Ue7g08S27AjqBUYZ7NnA0nip2rf13
         SDAYBSRL7M+yibzVwaex0Ha7IAmEKfBljXGzN5ItNyLI1XvVyb8jbgJd1ftlQlf49fPm
         wI83LrTv4tYQ+a8hP1ZGx6g/Jh6AUUR65j7+mmKSFBml4Eu33JgdpAftKzOwPkghL1R6
         4shbbLLNqJsIS42yedTXV61xY8AXDD9nfjRIJARX3P5M0c8Aj9LYcR6eYLbUI7kQBKcq
         GYu+uFzGC/exFMaAMTEsl1n8NVmUlXMVkA/IH8V5nNRWpoof8YleqaJ88ylVbrtFzHqb
         nhPQ==
X-Gm-Message-State: AOJu0Ywc+k7uanm7tsYP3K82qcEuUIrdMcfRGASzWsJMlady9L/wpu97
        Ure1OMzzNJ5QPeTknMXD7Y3VMhLi7Rx5p3ppKEPvDiDkTHu+HP7sRjxBzHBBo2ZRg+iIlWE6Sge
        lo4r6wURlHyucUnmvVfNA
X-Received: by 2002:a5d:408c:0:b0:321:8181:6012 with SMTP id o12-20020a5d408c000000b0032181816012mr73823wrp.21.1695399638903;
        Fri, 22 Sep 2023 09:20:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtBRRgDYgPBt8y6kCoghzVzS/QSEpow4ZyIw6NVNK54Rc2GHD2ASQKNNoKh4/QVDuPUmQyvg==
X-Received: by 2002:a5d:408c:0:b0:321:8181:6012 with SMTP id o12-20020a5d408c000000b0032181816012mr73804wrp.21.1695399638426;
        Fri, 22 Sep 2023 09:20:38 -0700 (PDT)
Received: from localhost (net-2-34-76-254.cust.vodafonedsl.it. [2.34.76.254])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d6309000000b003143b14848dsm4750559wru.102.2023.09.22.09.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:20:37 -0700 (PDT)
Date:   Fri, 22 Sep 2023 18:20:36 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        neilb@suse.de, chuck.lever@oracle.com, netdev@vger.kernel.org
Subject: Re: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
Message-ID: <ZQ2+1NhagxR5bZF+@lore-desk>
References: <b7985d6f0708d4a2836e1b488d641cdc11ace61b.1695386483.git.lorenzo@kernel.org>
 <cc6341a7c5f09b731298236b260c9dfd94a811d8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="O+06KXfkn58hdwdo"
Content-Disposition: inline
In-Reply-To: <cc6341a7c5f09b731298236b260c9dfd94a811d8.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--O+06KXfkn58hdwdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 2023-09-22 at 14:44 +0200, Lorenzo Bianconi wrote:
> > Introduce write_threads and write_v4_end_grace netlink commands similar
> > to the ones available through the procfs.
> > Introduce nfsd_nl_server_status_get_dumpit netlink command in order to
> > report global server metadata.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > This patch can be tested with user-space tool reported below:
> > https://github.com/LorenzoBianconi/nfsd-netlink.git
> > ---
> >  Documentation/netlink/specs/nfsd.yaml | 33 +++++++++
> >  fs/nfsd/netlink.c                     | 30 ++++++++
> >  fs/nfsd/netlink.h                     |  5 ++
> >  fs/nfsd/nfsctl.c                      | 98 +++++++++++++++++++++++++++
> >  include/uapi/linux/nfsd_netlink.h     | 11 +++
> >  5 files changed, 177 insertions(+)
> >=20
> > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netl=
ink/specs/nfsd.yaml
> > index 403d3e3a04f3..fa1204892703 100644
> > --- a/Documentation/netlink/specs/nfsd.yaml
> > +++ b/Documentation/netlink/specs/nfsd.yaml
> > @@ -62,6 +62,15 @@ attribute-sets:
> >          name: compound-ops
> >          type: u32
> >          multi-attr: true
> > +  -
> > +    name: server-attr
> > +    attributes:
> > +      -
> > +        name: threads
> > +        type: u16
>=20
> 65k threads ought to be enough for anybody!

maybe u8 is fine here :)

>=20
> > +      -
> > +        name: v4-grace
> > +        type: u8
> > =20
> >  operations:
> >    list:
> > @@ -72,3 +81,27 @@ operations:
> >        dump:
> >          pre: nfsd-nl-rpc-status-get-start
> >          post: nfsd-nl-rpc-status-get-done
> > +    -
> > +      name: threads-set
> > +      doc: set the number of running threads
> > +      attribute-set: server-attr
> > +      flags: [ admin-perm ]
> > +      do:
> > +        request:
> > +          attributes:
> > +            - threads
> > +    -
> > +      name: v4-grace-release
> > +      doc: release the grace period for nfsd's v4 lock manager
> > +      attribute-set: server-attr
> > +      flags: [ admin-perm ]
> > +      do:
> > +        request:
> > +          attributes:
> > +            - v4-grace
> > +    -
> > +      name: server-status-get
> > +      doc: dump server status info
> > +      attribute-set: server-attr
> > +      dump:
> > +        pre: nfsd-nl-server-status-get-start
> > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > index 0e1d635ec5f9..783a34e69354 100644
> > --- a/fs/nfsd/netlink.c
> > +++ b/fs/nfsd/netlink.c
> > @@ -10,6 +10,16 @@
> > =20
> >  #include <uapi/linux/nfsd_netlink.h>
> > =20
> > +/* NFSD_CMD_THREADS_SET - do */
> > +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_SERVE=
R_ATTR_THREADS + 1] =3D {
> > +	[NFSD_A_SERVER_ATTR_THREADS] =3D { .type =3D NLA_U16, },
> > +};
> > +
> > +/* NFSD_CMD_V4_GRACE_RELEASE - do */
> > +static const struct nla_policy nfsd_v4_grace_release_nl_policy[NFSD_A_=
SERVER_ATTR_V4_GRACE + 1] =3D {
> > +	[NFSD_A_SERVER_ATTR_V4_GRACE] =3D { .type =3D NLA_U8, },
> > +};
> > +
> >  /* Ops table for nfsd */
> >  static const struct genl_split_ops nfsd_nl_ops[] =3D {
> >  	{
> > @@ -19,6 +29,26 @@ static const struct genl_split_ops nfsd_nl_ops[] =3D=
 {
> >  		.done	=3D nfsd_nl_rpc_status_get_done,
> >  		.flags	=3D GENL_CMD_CAP_DUMP,
> >  	},
> > +	{
> > +		.cmd		=3D NFSD_CMD_THREADS_SET,
> > +		.doit		=3D nfsd_nl_threads_set_doit,
> > +		.policy		=3D nfsd_threads_set_nl_policy,
> > +		.maxattr	=3D NFSD_A_SERVER_ATTR_THREADS,
> > +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > +	},
> > +	{
> > +		.cmd		=3D NFSD_CMD_V4_GRACE_RELEASE,
> > +		.doit		=3D nfsd_nl_v4_grace_release_doit,
> > +		.policy		=3D nfsd_v4_grace_release_nl_policy,
> > +		.maxattr	=3D NFSD_A_SERVER_ATTR_V4_GRACE,
> > +		.flags		=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > +	},
> > +	{
> > +		.cmd	=3D NFSD_CMD_SERVER_STATUS_GET,
> > +		.start	=3D nfsd_nl_server_status_get_start,
> > +		.dumpit	=3D nfsd_nl_server_status_get_dumpit,
> > +		.flags	=3D GENL_CMD_CAP_DUMP,
> > +	},
> >  };
> > =20
> >  struct genl_family nfsd_nl_family __ro_after_init =3D {
> > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > index d83dd6bdee92..2e98061fbb0a 100644
> > --- a/fs/nfsd/netlink.h
> > +++ b/fs/nfsd/netlink.h
> > @@ -12,10 +12,15 @@
> >  #include <uapi/linux/nfsd_netlink.h>
> > =20
> >  int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
> > +int nfsd_nl_server_status_get_start(struct netlink_callback *cb);
> >  int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
> > =20
> >  int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> >  				  struct netlink_callback *cb);
> > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info *in=
fo);
> > +int nfsd_nl_v4_grace_release_doit(struct sk_buff *skb, struct genl_inf=
o *info);
> > +int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
> > +				     struct netlink_callback *cb);
> > =20
> >  extern struct genl_family nfsd_nl_family;
> > =20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index b71744e355a8..c631b59b7a4f 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1694,6 +1694,104 @@ int nfsd_nl_rpc_status_get_done(struct netlink_=
callback *cb)
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
> > +	u16 nthreads;
> > +	int ret;
> > +
> > +	if (!info->attrs[NFSD_A_SERVER_ATTR_THREADS])
> > +		return -EINVAL;
> > +
> > +	nthreads =3D nla_get_u16(info->attrs[NFSD_A_SERVER_ATTR_THREADS]);
> > +
> > +	ret =3D nfsd_svc(nthreads, genl_info_net(info), get_current_cred());
> > +	return ret =3D=3D nthreads ? 0 : ret;
> > +}
> > +
> > +/**
> > + * nfsd_nl_v4_grace_release_doit - release the nfs4 grace period
> > + * @skb: reply buffer
> > + * @info: netlink metadata and command arguments
> > + *
> > + * Return 0 on success or a negative errno.
> > + */
> > +int nfsd_nl_v4_grace_release_doit(struct sk_buff *skb, struct genl_inf=
o *info)
> > +{
> > +#ifdef CONFIG_NFSD_V4
> > +	struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net_id);
> > +
> > +	if (!info->attrs[NFSD_A_SERVER_ATTR_V4_GRACE])
> > +		return -EINVAL;
> > +
> > +	if (nla_get_u8(info->attrs[NFSD_A_SERVER_ATTR_V4_GRACE]))
> > +		nfsd4_end_grace(nn);
> > +
>=20
> To be clear here. Issuing this with anything but 0 will end the grace
> period. A value of 0 is ignored. It might be best to make the value not

I tried to be aligned with write_v4_end_grace() here but supporting just 1 =
(or
any other non-zero value) and skipping 'Y/y'. If we send 0 it should skip t=
he
release action.

> matter at all. Do we have to send down a value at all?

I am not sure if ynl supports a doit operation with a request with no param=
eters.
@Chuck, Jakub: any input here?

Regards,
Lorenzo

>=20
> > +	return 0;
> > +#else
> > +	return -EOPNOTSUPP;
> > +#endif /* CONFIG_NFSD_V4 */
> > +}
> > +
> > +/**
> > + * nfsd_nl_server_status_get_start - Prepare server_status_get dumpit
> > + * @cb: netlink metadata and command arguments
> > + *
> > + * Return values:
> > + *   %0: The server_status_get command may proceed
> > + *   %-ENODEV: There is no NFSD running in this namespace
> > + */
> > +int nfsd_nl_server_status_get_start(struct netlink_callback *cb)
> > +{
> > +	struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net_i=
d);
> > +
> > +	return nn->nfsd_serv ? 0 : -ENODEV;
> > +}
> > +
> > +/**
> > + * nfsd_nl_server_status_get_dumpit - dump server status info
> > + * @skb: reply buffer
> > + * @cb: netlink metadata and command arguments
> > + *
> > + * Returns the size of the reply or a negative errno.
> > + */
> > +int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
> > +				     struct netlink_callback *cb)
> > +{
> > +	struct net *net =3D sock_net(skb->sk);
> > +#ifdef CONFIG_NFSD_V4
> > +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > +#endif /* CONFIG_NFSD_V4 */
> > +	void *hdr;
> > +
> > +	if (cb->args[0]) /* already consumed */
> > +		return 0;
> > +
> > +	hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_s=
eq,
> > +			  &nfsd_nl_family, NLM_F_MULTI,
> > +			  NFSD_CMD_SERVER_STATUS_GET);
> > +	if (!hdr)
> > +		return -ENOBUFS;
> > +
> > +	if (nla_put_u16(skb, NFSD_A_SERVER_ATTR_THREADS, nfsd_nrthreads(net)))
> > +		return -ENOBUFS;
> > +#ifdef CONFIG_NFSD_V4
> > +	if (nla_put_u8(skb, NFSD_A_SERVER_ATTR_V4_GRACE, !nn->grace_ended))
> > +		return -ENOBUFS;
> > +#endif /* CONFIG_NFSD_V4 */
> > +
> > +	genlmsg_end(skb, hdr);
> > +	cb->args[0] =3D 1;
> > +
> > +	return skb->len;
> > +}
> > +
> >  /**
> >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
> >   * @net: a freshly-created network namespace
> > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfs=
d_netlink.h
> > index c8ae72466ee6..b82fbc53d336 100644
> > --- a/include/uapi/linux/nfsd_netlink.h
> > +++ b/include/uapi/linux/nfsd_netlink.h
> > @@ -29,8 +29,19 @@ enum {
> >  	NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
> >  };
> > =20
> > +enum {
> > +	NFSD_A_SERVER_ATTR_THREADS =3D 1,
> > +	NFSD_A_SERVER_ATTR_V4_GRACE,
> > +
> > +	__NFSD_A_SERVER_ATTR_MAX,
> > +	NFSD_A_SERVER_ATTR_MAX =3D (__NFSD_A_SERVER_ATTR_MAX - 1)
> > +};
> > +
> >  enum {
> >  	NFSD_CMD_RPC_STATUS_GET =3D 1,
> > +	NFSD_CMD_THREADS_SET,
> > +	NFSD_CMD_V4_GRACE_RELEASE,
> > +	NFSD_CMD_SERVER_STATUS_GET,
> > =20
> >  	__NFSD_CMD_MAX,
> >  	NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

--O+06KXfkn58hdwdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQ2+1AAKCRA6cBh0uS2t
rJfoAP9GqpFRIn9dKxFIurZSBZJj3+XzTi6NYK8NrU60zsE7CAD7B2oT4tpFAicQ
ZuxUQiBfai8wablokwY3vPAvLMwceAg=
=HZ20
-----END PGP SIGNATURE-----

--O+06KXfkn58hdwdo--

