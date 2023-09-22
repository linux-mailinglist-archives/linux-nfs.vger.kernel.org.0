Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843C17AB5D1
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 18:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjIVQYv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Sep 2023 12:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjIVQYu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Sep 2023 12:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4964A139
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 09:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695399834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nYLygm7L35x3F/4md0i3XZk5AgPOd1cPrqt3FH5yPjw=;
        b=S9Wi8yW0u3Rdug3R7GQAjZMOAKRnFnFiLYZIBaT7nUDWnmMXhiWBqxqZaRKwLK49CDbJuy
        1rqGLUoiYjJj+DCCCf8gfbfMUPwwgL9rkikMnqruA63v3ixhetNaUFHPONGG9JzLv0LO0V
        fUoVSPjsqLBe6KcHiDfgyRuQThOzgTg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-sqAozBm1PM-9G5EbJHVvRQ-1; Fri, 22 Sep 2023 12:23:52 -0400
X-MC-Unique: sqAozBm1PM-9G5EbJHVvRQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so17828155e9.3
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 09:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695399831; x=1696004631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYLygm7L35x3F/4md0i3XZk5AgPOd1cPrqt3FH5yPjw=;
        b=HorUCfDJXm6/xfClES12Y1KRxK3QT2Mmf0NYwq7bF8/nje/kviTB2c6Z4teWLvIxWU
         bCye+j2yDKp8d6SUNMq6jEv9W9FJv0o3ytogNa5MxF5sx9M39Wu5gMD8MQJOQCXdbcuJ
         bosWnvDD0cZIikJJ6GIvAw+4Etl1nmzDGQUy9sRuq+uewvLKxddTPR7wScEn6yr2Ffn4
         SqTs5bGJi5aejRldnXnix0Q/kBNsK/D6ZZqlXAkYO6tTunHwveoa12FEnVMU9N161n6n
         j5OjJCHye7kh0V84njXJpxhUeBLaGhnbFm15dw4B9B4KFgT0t669Gnlm3ueYZABxnRAr
         eKGw==
X-Gm-Message-State: AOJu0Yzh1mtZ7kQZtjRacQpVk/FBq4oRckJiNMylqxbcoOP8awhpzy9D
        J9K2hhRHNzT8nflXoQQY0LK/RasHUbgpLySrAaj45SHRLQQidVAIsjdIDkdt/ALglWS4DGprThK
        rt6FeAa6xAValNZXWg7jk
X-Received: by 2002:a7b:ce0f:0:b0:401:73b2:f039 with SMTP id m15-20020a7bce0f000000b0040173b2f039mr7947271wmc.7.1695399831448;
        Fri, 22 Sep 2023 09:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZtnaRXpjEgBUGO+oLGZ+icRN2CVZ6OFPjvwm2/8NZZMG1ZShxMa57eFjFluy0o6zFSqCZZA==
X-Received: by 2002:a7b:ce0f:0:b0:401:73b2:f039 with SMTP id m15-20020a7bce0f000000b0040173b2f039mr7947256wmc.7.1695399830997;
        Fri, 22 Sep 2023 09:23:50 -0700 (PDT)
Received: from localhost (net-2-34-76-254.cust.vodafonedsl.it. [2.34.76.254])
        by smtp.gmail.com with ESMTPSA id p8-20020a7bcc88000000b003fbe4cecc3bsm117846wma.16.2023.09.22.09.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 09:23:50 -0700 (PDT)
Date:   Fri, 22 Sep 2023 18:23:48 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
Message-ID: <ZQ2/lGSbiNv5zn+Y@lore-desk>
References: <b7985d6f0708d4a2836e1b488d641cdc11ace61b.1695386483.git.lorenzo@kernel.org>
 <cc6341a7c5f09b731298236b260c9dfd94a811d8.camel@kernel.org>
 <ADA8068B-B289-4210-9E28-E69F4EBB9355@oracle.com>
 <c81b598c24df25cc1f797b8c18340d610fb58f00.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TlW41c52mslvGfeo"
Content-Disposition: inline
In-Reply-To: <c81b598c24df25cc1f797b8c18340d610fb58f00.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--TlW41c52mslvGfeo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 2023-09-22 at 16:06 +0000, Chuck Lever III wrote:
> >=20
> > > On Sep 22, 2023, at 12:04 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > On Fri, 2023-09-22 at 14:44 +0200, Lorenzo Bianconi wrote:
> > > > Introduce write_threads and write_v4_end_grace netlink commands sim=
ilar
> > > > to the ones available through the procfs.
> > > > Introduce nfsd_nl_server_status_get_dumpit netlink command in order=
 to
> > > > report global server metadata.
> > > >=20
> > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > ---
> > > > This patch can be tested with user-space tool reported below:
> > > > https://github.com/LorenzoBianconi/nfsd-netlink.git
> > > > ---
> > > > Documentation/netlink/specs/nfsd.yaml | 33 +++++++++
> > > > fs/nfsd/netlink.c                     | 30 ++++++++
> > > > fs/nfsd/netlink.h                     |  5 ++
> > > > fs/nfsd/nfsctl.c                      | 98 ++++++++++++++++++++++++=
+++
> > > > include/uapi/linux/nfsd_netlink.h     | 11 +++
> > > > 5 files changed, 177 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/=
netlink/specs/nfsd.yaml
> > > > index 403d3e3a04f3..fa1204892703 100644
> > > > --- a/Documentation/netlink/specs/nfsd.yaml
> > > > +++ b/Documentation/netlink/specs/nfsd.yaml
> > > > @@ -62,6 +62,15 @@ attribute-sets:
> > > >         name: compound-ops
> > > >         type: u32
> > > >         multi-attr: true
> > > > +  -
> > > > +    name: server-attr
> > > > +    attributes:
> > > > +      -
> > > > +        name: threads
> > > > +        type: u16
> > >=20
> > > 65k threads ought to be enough for anybody!
> >=20
> > No argument.
> >=20
> > But I thought you could echo a negative number of threads in /proc/fs/n=
fsd/threads
> > to reduce the thread count. Maybe this field should be an s32?
> >=20
>=20
> Yuck! I think I'd rather see this implemented as a declarative field.
>=20
> Let's have this specify an explicit number of threads with 0 meaning
> shutdown. If someone wants to reduce the number, they can do the math in
> userland. That also jives better with the SERVICE_STATUS_GET...

ack, I agree.

Regards,
Lorenzo

>=20
> >=20
> > > > +      -
> > > > +        name: v4-grace
> > > > +        type: u8
> > > >=20
> > > > operations:
> > > >   list:
> > > > @@ -72,3 +81,27 @@ operations:
> > > >       dump:
> > > >         pre: nfsd-nl-rpc-status-get-start
> > > >         post: nfsd-nl-rpc-status-get-done
> > > > +    -
> > > > +      name: threads-set
> > > > +      doc: set the number of running threads
> > > > +      attribute-set: server-attr
> > > > +      flags: [ admin-perm ]
> > > > +      do:
> > > > +        request:
> > > > +          attributes:
> > > > +            - threads
> > > > +    -
> > > > +      name: v4-grace-release
> > > > +      doc: release the grace period for nfsd's v4 lock manager
> > > > +      attribute-set: server-attr
> > > > +      flags: [ admin-perm ]
> > > > +      do:
> > > > +        request:
> > > > +          attributes:
> > > > +            - v4-grace
> > > > +    -
> > > > +      name: server-status-get
> > > > +      doc: dump server status info
> > > > +      attribute-set: server-attr
> > > > +      dump:
> > > > +        pre: nfsd-nl-server-status-get-start
> > > > diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
> > > > index 0e1d635ec5f9..783a34e69354 100644
> > > > --- a/fs/nfsd/netlink.c
> > > > +++ b/fs/nfsd/netlink.c
> > > > @@ -10,6 +10,16 @@
> > > >=20
> > > > #include <uapi/linux/nfsd_netlink.h>
> > > >=20
> > > > +/* NFSD_CMD_THREADS_SET - do */
> > > > +static const struct nla_policy nfsd_threads_set_nl_policy[NFSD_A_S=
ERVER_ATTR_THREADS + 1] =3D {
> > > > + [NFSD_A_SERVER_ATTR_THREADS] =3D { .type =3D NLA_U16, },
> > > > +};
> > > > +
> > > > +/* NFSD_CMD_V4_GRACE_RELEASE - do */
> > > > +static const struct nla_policy nfsd_v4_grace_release_nl_policy[NFS=
D_A_SERVER_ATTR_V4_GRACE + 1] =3D {
> > > > + [NFSD_A_SERVER_ATTR_V4_GRACE] =3D { .type =3D NLA_U8, },
> > > > +};
> > > > +
> > > > /* Ops table for nfsd */
> > > > static const struct genl_split_ops nfsd_nl_ops[] =3D {
> > > > {
> > > > @@ -19,6 +29,26 @@ static const struct genl_split_ops nfsd_nl_ops[]=
 =3D {
> > > > .done =3D nfsd_nl_rpc_status_get_done,
> > > > .flags =3D GENL_CMD_CAP_DUMP,
> > > > },
> > > > + {
> > > > + .cmd =3D NFSD_CMD_THREADS_SET,
> > > > + .doit =3D nfsd_nl_threads_set_doit,
> > > > + .policy =3D nfsd_threads_set_nl_policy,
> > > > + .maxattr =3D NFSD_A_SERVER_ATTR_THREADS,
> > > > + .flags =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > > + },
> > > > + {
> > > > + .cmd =3D NFSD_CMD_V4_GRACE_RELEASE,
> > > > + .doit =3D nfsd_nl_v4_grace_release_doit,
> > > > + .policy =3D nfsd_v4_grace_release_nl_policy,
> > > > + .maxattr =3D NFSD_A_SERVER_ATTR_V4_GRACE,
> > > > + .flags =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > > + },
> > > > + {
> > > > + .cmd =3D NFSD_CMD_SERVER_STATUS_GET,
> > > > + .start =3D nfsd_nl_server_status_get_start,
> > > > + .dumpit =3D nfsd_nl_server_status_get_dumpit,
> > > > + .flags =3D GENL_CMD_CAP_DUMP,
> > > > + },
> > > > };
> > > >=20
> > > > struct genl_family nfsd_nl_family __ro_after_init =3D {
> > > > diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
> > > > index d83dd6bdee92..2e98061fbb0a 100644
> > > > --- a/fs/nfsd/netlink.h
> > > > +++ b/fs/nfsd/netlink.h
> > > > @@ -12,10 +12,15 @@
> > > > #include <uapi/linux/nfsd_netlink.h>
> > > >=20
> > > > int nfsd_nl_rpc_status_get_start(struct netlink_callback *cb);
> > > > +int nfsd_nl_server_status_get_start(struct netlink_callback *cb);
> > > > int nfsd_nl_rpc_status_get_done(struct netlink_callback *cb);
> > > >=20
> > > > int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> > > >   struct netlink_callback *cb);
> > > > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info=
 *info);
> > > > +int nfsd_nl_v4_grace_release_doit(struct sk_buff *skb, struct genl=
_info *info);
> > > > +int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
> > > > +      struct netlink_callback *cb);
> > > >=20
> > > > extern struct genl_family nfsd_nl_family;
> > > >=20
> > > > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > > > index b71744e355a8..c631b59b7a4f 100644
> > > > --- a/fs/nfsd/nfsctl.c
> > > > +++ b/fs/nfsd/nfsctl.c
> > > > @@ -1694,6 +1694,104 @@ int nfsd_nl_rpc_status_get_done(struct netl=
ink_callback *cb)
> > > > return 0;
> > > > }
> > > >=20
> > > > +/**
> > > > + * nfsd_nl_threads_set_doit - set the number of running threads
> > > > + * @skb: reply buffer
> > > > + * @info: netlink metadata and command arguments
> > > > + *
> > > > + * Return 0 on success or a negative errno.
> > > > + */
> > > > +int nfsd_nl_threads_set_doit(struct sk_buff *skb, struct genl_info=
 *info)
> > > > +{
> > > > + u16 nthreads;
> > > > + int ret;
> > > > +
> > > > + if (!info->attrs[NFSD_A_SERVER_ATTR_THREADS])
> > > > + return -EINVAL;
> > > > +
> > > > + nthreads =3D nla_get_u16(info->attrs[NFSD_A_SERVER_ATTR_THREADS]);
> > > > +
> > > > + ret =3D nfsd_svc(nthreads, genl_info_net(info), get_current_cred(=
));
> > > > + return ret =3D=3D nthreads ? 0 : ret;
> > > > +}
> > > > +
> > > > +/**
> > > > + * nfsd_nl_v4_grace_release_doit - release the nfs4 grace period
> > > > + * @skb: reply buffer
> > > > + * @info: netlink metadata and command arguments
> > > > + *
> > > > + * Return 0 on success or a negative errno.
> > > > + */
> > > > +int nfsd_nl_v4_grace_release_doit(struct sk_buff *skb, struct genl=
_info *info)
> > > > +{
> > > > +#ifdef CONFIG_NFSD_V4
> > > > + struct nfsd_net *nn =3D net_generic(genl_info_net(info), nfsd_net=
_id);
> > > > +
> > > > + if (!info->attrs[NFSD_A_SERVER_ATTR_V4_GRACE])
> > > > + return -EINVAL;
> > > > +
> > > > + if (nla_get_u8(info->attrs[NFSD_A_SERVER_ATTR_V4_GRACE]))
> > > > + nfsd4_end_grace(nn);
> > > > +
> > >=20
> > > To be clear here. Issuing this with anything but 0 will end the grace
> > > period. A value of 0 is ignored. It might be best to make the value n=
ot
> > > matter at all. Do we have to send down a value at all?
> > >=20
> > > > + return 0;
> > > > +#else
> > > > + return -EOPNOTSUPP;
> > > > +#endif /* CONFIG_NFSD_V4 */
> > > > +}
> > > > +
> > > > +/**
> > > > + * nfsd_nl_server_status_get_start - Prepare server_status_get dum=
pit
> > > > + * @cb: netlink metadata and command arguments
> > > > + *
> > > > + * Return values:
> > > > + *   %0: The server_status_get command may proceed
> > > > + *   %-ENODEV: There is no NFSD running in this namespace
> > > > + */
> > > > +int nfsd_nl_server_status_get_start(struct netlink_callback *cb)
> > > > +{
> > > > + struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_n=
et_id);
> > > > +
> > > > + return nn->nfsd_serv ? 0 : -ENODEV;
> > > > +}
> > > > +
> > > > +/**
> > > > + * nfsd_nl_server_status_get_dumpit - dump server status info
> > > > + * @skb: reply buffer
> > > > + * @cb: netlink metadata and command arguments
> > > > + *
> > > > + * Returns the size of the reply or a negative errno.
> > > > + */
> > > > +int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
> > > > +      struct netlink_callback *cb)
> > > > +{
> > > > + struct net *net =3D sock_net(skb->sk);
> > > > +#ifdef CONFIG_NFSD_V4
> > > > + struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> > > > +#endif /* CONFIG_NFSD_V4 */
> > > > + void *hdr;
> > > > +
> > > > + if (cb->args[0]) /* already consumed */
> > > > + return 0;
> > > > +
> > > > + hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlm=
sg_seq,
> > > > +   &nfsd_nl_family, NLM_F_MULTI,
> > > > +   NFSD_CMD_SERVER_STATUS_GET);
> > > > + if (!hdr)
> > > > + return -ENOBUFS;
> > > > +
> > > > + if (nla_put_u16(skb, NFSD_A_SERVER_ATTR_THREADS, nfsd_nrthreads(n=
et)))
> > > > + return -ENOBUFS;
> > > > +#ifdef CONFIG_NFSD_V4
> > > > + if (nla_put_u8(skb, NFSD_A_SERVER_ATTR_V4_GRACE, !nn->grace_ended=
))
> > > > + return -ENOBUFS;
> > > > +#endif /* CONFIG_NFSD_V4 */
> > > > +
> > > > + genlmsg_end(skb, hdr);
> > > > + cb->args[0] =3D 1;
> > > > +
> > > > + return skb->len;
> > > > +}
> > > > +
> > > > /**
> > > >  * nfsd_net_init - Prepare the nfsd_net portion of a new net namesp=
ace
> > > >  * @net: a freshly-created network namespace
> > > > diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux=
/nfsd_netlink.h
> > > > index c8ae72466ee6..b82fbc53d336 100644
> > > > --- a/include/uapi/linux/nfsd_netlink.h
> > > > +++ b/include/uapi/linux/nfsd_netlink.h
> > > > @@ -29,8 +29,19 @@ enum {
> > > > NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
> > > > };
> > > >=20
> > > > +enum {
> > > > + NFSD_A_SERVER_ATTR_THREADS =3D 1,
> > > > + NFSD_A_SERVER_ATTR_V4_GRACE,
> > > > +
> > > > + __NFSD_A_SERVER_ATTR_MAX,
> > > > + NFSD_A_SERVER_ATTR_MAX =3D (__NFSD_A_SERVER_ATTR_MAX - 1)
> > > > +};
> > > > +
> > > > enum {
> > > > NFSD_CMD_RPC_STATUS_GET =3D 1,
> > > > + NFSD_CMD_THREADS_SET,
> > > > + NFSD_CMD_V4_GRACE_RELEASE,
> > > > + NFSD_CMD_SERVER_STATUS_GET,
> > > >=20
> > > > __NFSD_CMD_MAX,
> > > > NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> > >=20
> > > --=20
> > > Jeff Layton <jlayton@kernel.org>
> >=20
> >=20
> > --
> > Chuck Lever
> >=20
> >=20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20

--TlW41c52mslvGfeo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQ2/lAAKCRA6cBh0uS2t
rLQGAQDlOaY2nfABtpIV+hWUZv6ho3MzZ2/y8nji80AX62S8GQD+OQ+/Z3s0iLQ4
0hgat3Z/aZTOVv/SKB0Vx3zc1+1AzQQ=
=gsgQ
-----END PGP SIGNATURE-----

--TlW41c52mslvGfeo--

