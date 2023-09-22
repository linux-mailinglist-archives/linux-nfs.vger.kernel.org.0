Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450387ABA03
	for <lists+linux-nfs@lfdr.de>; Fri, 22 Sep 2023 21:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjIVT0X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 22 Sep 2023 15:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjIVT0X (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 22 Sep 2023 15:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D23A3
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 12:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695410732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b1iw1laBUN5rzxgrcLFInMJ18Xo8+ygFbeYJ2uUzQns=;
        b=N32OfJiKi6UQnXv+pikV3WMPwh8LLyZUdUdamp1Dgo3BMwlbDMBoJe91TgvG/Fm/P+0zmf
        ahI2nUUvcMct/VOuX83wD0GYB9oufnW82zoOMo7iWAWw+gHZlF/tD8Er6hmtkZ2brHwqyR
        BPCVL2zFfHfXR7CCB0i8mpgBqpWoCP0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-xStSmjzfPWudn2viC9nbdg-1; Fri, 22 Sep 2023 15:25:31 -0400
X-MC-Unique: xStSmjzfPWudn2viC9nbdg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae52fbac1dso582218466b.1
        for <linux-nfs@vger.kernel.org>; Fri, 22 Sep 2023 12:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695410730; x=1696015530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1iw1laBUN5rzxgrcLFInMJ18Xo8+ygFbeYJ2uUzQns=;
        b=leaoqFNsSYfz/c8X9R+CW/mllC6xTEnG572wetCoaZ95m9NIYGF/stqb2qG7x6pWB6
         T+4+JsxEwtzYmOj6RZv7l3wEsOmTdDU8uYOd34RvbGbSZ3hNOFAwgeRT1vLfqdRcn1N4
         rXzr3DdsiSoaogPRzUkzClmhRJpbsqmD7zqtS76ZQp3B7L31gluPSKUPy2eWAkAn5aGC
         8ZqHNu81ptYr8fcAIb+6MMIFygNtmI5fUblOcRM1BGHG8raSE+FYA7IV3ncWOiMevofK
         V2RKCesS1CjTlk1OjyvRJ6dXuBoGV8Xqt0etDuaUwIiPf//wygrIq7hFrokxY0wtkFyK
         ZC+A==
X-Gm-Message-State: AOJu0Yx6pmPJX4EqXBws7BQI0myu7uhz3KfGYkqPJhJMEiaSOwtKWWfd
        bek6xIf2f6Auzb1jW1gAQz1AO/brHmBbCpcORTbBakU3ZXAEJaCTIPhQHhz6SNMyAPFfnQobcvM
        V1Vg3PRphB+b172tfMKB8
X-Received: by 2002:a17:907:daa:b0:9aa:1794:945b with SMTP id go42-20020a1709070daa00b009aa1794945bmr4502195ejc.22.1695410724790;
        Fri, 22 Sep 2023 12:25:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnQmZGvhaMeVqNnDrASCUCp33iXAvTOjgrp6hSRA6qrnHq5xh/KwQN8YxIXT9xlCHkkoce4g==
X-Received: by 2002:a17:907:daa:b0:9aa:1794:945b with SMTP id go42-20020a1709070daa00b009aa1794945bmr4502151ejc.22.1695410723845;
        Fri, 22 Sep 2023 12:25:23 -0700 (PDT)
Received: from localhost (net-2-34-76-254.cust.vodafonedsl.it. [2.34.76.254])
        by smtp.gmail.com with ESMTPSA id z25-20020aa7c659000000b00530ba0fd672sm2589428edr.75.2023.09.22.12.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 12:25:23 -0700 (PDT)
Date:   Fri, 22 Sep 2023 21:25:21 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] NFSD: convert write_threads and write_v4_end_grace to
 netlink commands
Message-ID: <ZQ3qIR036VrSTmAA@lore-desk>
References: <b7985d6f0708d4a2836e1b488d641cdc11ace61b.1695386483.git.lorenzo@kernel.org>
 <cc6341a7c5f09b731298236b260c9dfd94a811d8.camel@kernel.org>
 <ZQ2+1NhagxR5bZF+@lore-desk>
 <C6FD2BD6-442D-4F96-82E7-D0F99F700E03@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="czcUg8cbmTF6BK8e"
Content-Disposition: inline
In-Reply-To: <C6FD2BD6-442D-4F96-82E7-D0F99F700E03@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--czcUg8cbmTF6BK8e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>=20
>=20
> > On Sep 22, 2023, at 12:20 PM, Lorenzo Bianconi <lorenzo.bianconi@redhat=
=2Ecom> wrote:
> >=20
> >> On Fri, 2023-09-22 at 14:44 +0200, Lorenzo Bianconi wrote:
> >>> Introduce write_threads and write_v4_end_grace netlink commands simil=
ar
> >>> to the ones available through the procfs.
> >>> Introduce nfsd_nl_server_status_get_dumpit netlink command in order to
> >>> report global server metadata.
> >>>=20
> >>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >>> ---
> >>> This patch can be tested with user-space tool reported below:
> >>> https://github.com/LorenzoBianconi/nfsd-netlink.git
> >>> ---
> >>> Documentation/netlink/specs/nfsd.yaml | 33 +++++++++
> >>> fs/nfsd/netlink.c                     | 30 ++++++++
> >>> fs/nfsd/netlink.h                     |  5 ++
> >>> fs/nfsd/nfsctl.c                      | 98 +++++++++++++++++++++++++++
> >>> include/uapi/linux/nfsd_netlink.h     | 11 +++
> >>> 5 files changed, 177 insertions(+)
> >>>=20
> >>> diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/ne=
tlink/specs/nfsd.yaml
> >>> index 403d3e3a04f3..fa1204892703 100644
> >>> --- a/Documentation/netlink/specs/nfsd.yaml
> >>> +++ b/Documentation/netlink/specs/nfsd.yaml
> >>> @@ -62,6 +62,15 @@ attribute-sets:
> >>>         name: compound-ops
> >>>         type: u32
> >>>         multi-attr: true
> >>> +  -
> >>> +    name: server-attr
> >>> +    attributes:
> >>> +      -
> >>> +        name: threads
> >>> +        type: u16
> >>=20
> >> 65k threads ought to be enough for anybody!
> >=20
> > maybe u8 is fine here :)
>=20
> 32-bit is the usual for this kind of interface. I don't think we need to =
go with 16-bit.

ack, fine

>=20
>=20
> >>> +      -
> >>> +        name: v4-grace
> >>> +        type: u8
> >>>=20
> >>> operations:
> >>>   list:
> >>> @@ -72,3 +81,27 @@ operations:
> >>>       dump:
> >>>         pre: nfsd-nl-rpc-status-get-start
> >>>         post: nfsd-nl-rpc-status-get-done
> >>> +    -
> >>> +      name: threads-set
> >>> +      doc: set the number of running threads
> >>> +      attribute-set: server-attr
> >>> +      flags: [ admin-perm ]

[...]

> >=20
> > I am not sure if ynl supports a doit operation with a request with no p=
arameters.
> > @Chuck, Jakub: any input here?
>=20
> I think it does, I might have done something like that for one of the
> handshake protocol commands.

please correct me if I am wrong but in Documentation/netlink/specs/handshak=
e.yaml
we have accept and done operations and both of them have some parameters in=
 the
request field, right?

>=20
> But I think Jeff's right, end_grace might be better postponed. Pick any of
> the others that you think might be easy to implement instead.

ack, fine. Do you agree to have a global container (server-status-get) for =
all
the server metadata instead of adding dedicated get APIs?

Regards,
Lorenzo

>=20
>=20
> > Regards,
> > Lorenzo
> >=20
> >>=20
> >>> + return 0;
> >>> +#else
> >>> + return -EOPNOTSUPP;
> >>> +#endif /* CONFIG_NFSD_V4 */
> >>> +}
> >>> +
> >>> +/**
> >>> + * nfsd_nl_server_status_get_start - Prepare server_status_get dumpit
> >>> + * @cb: netlink metadata and command arguments
> >>> + *
> >>> + * Return values:
> >>> + *   %0: The server_status_get command may proceed
> >>> + *   %-ENODEV: There is no NFSD running in this namespace
> >>> + */
> >>> +int nfsd_nl_server_status_get_start(struct netlink_callback *cb)
> >>> +{
> >>> + struct nfsd_net *nn =3D net_generic(sock_net(cb->skb->sk), nfsd_net=
_id);
> >>> +
> >>> + return nn->nfsd_serv ? 0 : -ENODEV;
> >>> +}
> >>> +
> >>> +/**
> >>> + * nfsd_nl_server_status_get_dumpit - dump server status info
> >>> + * @skb: reply buffer
> >>> + * @cb: netlink metadata and command arguments
> >>> + *
> >>> + * Returns the size of the reply or a negative errno.
> >>> + */
> >>> +int nfsd_nl_server_status_get_dumpit(struct sk_buff *skb,
> >>> +     struct netlink_callback *cb)
> >>> +{
> >>> + struct net *net =3D sock_net(skb->sk);
> >>> +#ifdef CONFIG_NFSD_V4
> >>> + struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> >>> +#endif /* CONFIG_NFSD_V4 */
> >>> + void *hdr;
> >>> +
> >>> + if (cb->args[0]) /* already consumed */
> >>> + return 0;
> >>> +
> >>> + hdr =3D genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg=
_seq,
> >>> +  &nfsd_nl_family, NLM_F_MULTI,
> >>> +  NFSD_CMD_SERVER_STATUS_GET);
> >>> + if (!hdr)
> >>> + return -ENOBUFS;
> >>> +
> >>> + if (nla_put_u16(skb, NFSD_A_SERVER_ATTR_THREADS, nfsd_nrthreads(net=
)))
> >>> + return -ENOBUFS;
> >>> +#ifdef CONFIG_NFSD_V4
> >>> + if (nla_put_u8(skb, NFSD_A_SERVER_ATTR_V4_GRACE, !nn->grace_ended))
> >>> + return -ENOBUFS;
> >>> +#endif /* CONFIG_NFSD_V4 */
> >>> +
> >>> + genlmsg_end(skb, hdr);
> >>> + cb->args[0] =3D 1;
> >>> +
> >>> + return skb->len;
> >>> +}
> >>> +
> >>> /**
> >>>  * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
> >>>  * @net: a freshly-created network namespace
> >>> diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/n=
fsd_netlink.h
> >>> index c8ae72466ee6..b82fbc53d336 100644
> >>> --- a/include/uapi/linux/nfsd_netlink.h
> >>> +++ b/include/uapi/linux/nfsd_netlink.h
> >>> @@ -29,8 +29,19 @@ enum {
> >>> NFSD_A_RPC_STATUS_MAX =3D (__NFSD_A_RPC_STATUS_MAX - 1)
> >>> };
> >>>=20
> >>> +enum {
> >>> + NFSD_A_SERVER_ATTR_THREADS =3D 1,
> >>> + NFSD_A_SERVER_ATTR_V4_GRACE,
> >>> +
> >>> + __NFSD_A_SERVER_ATTR_MAX,
> >>> + NFSD_A_SERVER_ATTR_MAX =3D (__NFSD_A_SERVER_ATTR_MAX - 1)
> >>> +};
> >>> +
> >>> enum {
> >>> NFSD_CMD_RPC_STATUS_GET =3D 1,
> >>> + NFSD_CMD_THREADS_SET,
> >>> + NFSD_CMD_V4_GRACE_RELEASE,
> >>> + NFSD_CMD_SERVER_STATUS_GET,
> >>>=20
> >>> __NFSD_CMD_MAX,
> >>> NFSD_CMD_MAX =3D (__NFSD_CMD_MAX - 1)
> >>=20
> >> --=20
> >> Jeff Layton <jlayton@kernel.org>
> >>=20
>=20
> --
> Chuck Lever
>=20
>=20

--czcUg8cbmTF6BK8e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQ3qIQAKCRA6cBh0uS2t
rJ48AP0VvpNgQKtdjwn7ofeNi3L5yI66kg6kpSFYRk2bS0CzjgD+M07e7zYmkJuh
kV7bYV5G4kaRAMQdiofyYSixUiVYRA8=
=TXI6
-----END PGP SIGNATURE-----

--czcUg8cbmTF6BK8e--

