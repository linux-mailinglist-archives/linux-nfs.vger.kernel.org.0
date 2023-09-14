Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A927A01E9
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Sep 2023 12:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjINKry (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Sep 2023 06:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjINKrw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Sep 2023 06:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C92E1BFE
        for <linux-nfs@vger.kernel.org>; Thu, 14 Sep 2023 03:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694688422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L8a2jK5iNN4CLdQi9CXXvytxSJp7HMrgOZHAS+n/2wo=;
        b=WJbdmD5l+n59jwzpH58NGdh3ztf2X0gIYqhat6vs7KIrDYI5R78ERbKPZat5x8ph8iGxFW
        I4SecRRGhrZK+9z+MehnS7WBek/cJbV0dx8BTrGUeBkV5FljS61G7KeIsXvIrYNLr9vqdH
        JiPqgOSgz7GV0YH//Gov1ovmO+eIkRc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-dfIz0jkfMgiwWrfvUUFNsA-1; Thu, 14 Sep 2023 06:47:01 -0400
X-MC-Unique: dfIz0jkfMgiwWrfvUUFNsA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4030ae94fedso6152235e9.1
        for <linux-nfs@vger.kernel.org>; Thu, 14 Sep 2023 03:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694688420; x=1695293220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8a2jK5iNN4CLdQi9CXXvytxSJp7HMrgOZHAS+n/2wo=;
        b=AH0H/6pnhiFDO2qHoTU0FOmEvovUy42/JaQUIujpa0M6+9gg0foWvtLz29hT1HqpI7
         ta6L+tyBVtoJ662sbfuxqU+WxV0fTgfn3HqV+ygHzsxALfJTGmkHN/FLfYvX46nRzsMs
         FG9X4UEdNGLMn0lAQEVJtlq3cd5lEo8tpk77YOdeBi5IRA20qzHTeFYNrM+OLQlq1ftu
         wl1qdWURgd5QDZyqBobpyA0ZLCPxPP7L3Gk6L0PXS8OSOPRa093S0SWGSh3RQVMsnppG
         xx9mD5t3hrphcco87kYJ3o+Nyn6kOzmZQQk3SQJNhP1/NpdB6ZFEUIlMWTJMYe5Teg57
         +OaA==
X-Gm-Message-State: AOJu0YwSaOKv+gRt2gn5lDgY0CrqL+kYPTrxsmGHVsvF57JYMl7Hu33L
        isyAN52HV8ByFrqOSWh8eLZ7OmuneI+tm59fi95E6fr/rHLuVeVsINzvPH31oilSMGnO3b9ugos
        C8BA5uS1FNZk9DSug25Z4
X-Received: by 2002:a7b:c4c9:0:b0:3fe:4900:db95 with SMTP id g9-20020a7bc4c9000000b003fe4900db95mr4779080wmk.37.1694688419919;
        Thu, 14 Sep 2023 03:46:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiMDRJppR4qHWtid45/jXWTmjy1tsnwetPx7AYl4GsXM6SDgKjZRz2IKeMkYnPdZHYA0smEw==
X-Received: by 2002:a7b:c4c9:0:b0:3fe:4900:db95 with SMTP id g9-20020a7bc4c9000000b003fe4900db95mr4779066wmk.37.1694688419555;
        Thu, 14 Sep 2023 03:46:59 -0700 (PDT)
Received: from localhost (net-2-34-76-254.cust.vodafonedsl.it. [2.34.76.254])
        by smtp.gmail.com with ESMTPSA id 18-20020a05600c025200b003fe1a092925sm1615768wmj.19.2023.09.14.03.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 03:46:58 -0700 (PDT)
Date:   Thu, 14 Sep 2023 12:46:56 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        jlayton@kernel.org, neilb@suse.de, netdev@vger.kernel.org,
        kuba@kernel.org
Subject: Re: [PATCH v8 1/3] Documentation: netlink: add a YAML spec for
 nfsd_server
Message-ID: <ZQLkoHcEddFGpmeN@lore-desk>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
 <ZP9X/f43T4FwhoPH@tissot.1015granger.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GF7KpKih7c60I/3r"
Content-Disposition: inline
In-Reply-To: <ZP9X/f43T4FwhoPH@tissot.1015granger.net>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--GF7KpKih7c60I/3r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Sep 11, 2023 at 02:49:44PM +0200, Lorenzo Bianconi wrote:
> > Introduce nfsd_server.yaml specs to generate uAPI and netlink
> > code for nfsd server.
> > Add rpc-status specs to define message reported by the nfsd server
> > dumping the pending RPC requests.
> >=20
> > Tested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/netlink/specs/nfsd_server.yaml | 97 ++++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >  create mode 100644 Documentation/netlink/specs/nfsd_server.yaml
>=20
> I've had a look... the series is simple and short. Thanks!
>=20
> My only quibbles right now are cosmetic and naming-related, all
> of which can be addressed when I apply these. So I'm going to
> wait for other review comments to see if we need another version
> or whether I can apply v8 with by-hand clean-ups.
>=20
> Comments below are what I might change when applying this one.
> This is not (yet) a request for a new version.

Hi Chuck,

thx for the review. Please let me know if I need to post a v9.

>=20
>=20
> > diff --git a/Documentation/netlink/specs/nfsd_server.yaml b/Documentati=
on/netlink/specs/nfsd_server.yaml
> > new file mode 100644
> > index 000000000000..e681b493847b
> > --- /dev/null
> > +++ b/Documentation/netlink/specs/nfsd_server.yaml
> > @@ -0,0 +1,97 @@
> > +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3=
-Clause)
> > +
> > +name: nfsd_server
>=20
> IMHO "nfsd_server" is redundant. "nfsd" should work.

ack, fine

>=20
>=20
> > +
> > +doc:
> > +  nfsd server configuration over generic netlink.
> > +
> > +attribute-sets:
> > +  -
> > +    name: rpc-status-comp-op-attr
> > +    enum-name: nfsd-rpc-status-comp-attr
> > +    name-prefix: nfsd-attr-rpc-status-comp-
> > +    attributes:
> > +      -
> > +        name: unspec
> > +        type: unused
> > +        value: 0
>=20
> I don't recall whether a zero-value definition is explicitly
> necessary. Maybe "value-start: 1" would work rather than
> these three lines? Why is zero a special attribute value?

I do not think it is mandatory, I added them just to be aligned with other
netlink definitions, but we do not use them.

>=20
>=20
> > +      -
> > +        name: op
> > +        type: u32
> > +  -
> > +    name: rpc-status-attr
> > +    enum-name: nfsd-rpc-status-attr
> > +    name-prefix: nfsd-attr-rpc-status-
>=20
> Specifying all three of these name settings seems a bit
> cluttered.

ack, I would say we can get rid of enum-name, agree?

>=20
>=20
> > +    attributes:
> > +      -
> > +        name: unspec
> > +        type: unused
> > +        value: 0
> > +      -
> > +        name: xid
> > +        type: u32
> > +        byte-order: big-endian
> > +      -
> > +        name: flags
> > +        type: u32
> > +      -
> > +        name: prog
> > +        type: u32
> > +      -
> > +        name: version
> > +        type: u8
> > +      -
> > +        name: proc
> > +        type: u32
> > +      -
> > +        name: service_time
> > +        type: s64
> > +      -
> > +        name: pad
> > +        type: pad
> > +      -
> > +        name: saddr4
> > +        type: u32
> > +        byte-order: big-endian
> > +        display-hint: ipv4
> > +      -
> > +        name: daddr4
> > +        type: u32
> > +        byte-order: big-endian
> > +        display-hint: ipv4
> > +      -
> > +        name: saddr6
> > +        type: binary
> > +        display-hint: ipv6
> > +      -
> > +        name: daddr6
> > +        type: binary
> > +        display-hint: ipv6
> > +      -
> > +        name: sport
> > +        type: u16
> > +        byte-order: big-endian
> > +      -
> > +        name: dport
> > +        type: u16
> > +        byte-order: big-endian
> > +      -
> > +        name: compond-op
>=20
> s/compond-op/compound-op

ack

>=20
> > +        type: array-nest
> > +        nested-attributes: rpc-status-comp-op-attr
>=20
> So, this is supposed to be a counted array of op numbers? Is there
> an existing type that could be used for this instead?

I think the attribute-sets available types are defined here:

https://github.com/torvalds/linux/blob/master/Documentation/netlink/genetli=
nk-c.yaml#L151

Regards,
Lorenzo

>=20
>=20
> > +
> > +operations:
> > +  enum-name: nfsd-commands
> > +  name-prefix: nfsd-cmd-
> > +  list:
> > +    -
> > +      name: unspec
> > +      doc: unused
> > +      value: 0
> > +    -
> > +      name: rpc-status-get
> > +      doc: dump pending nfsd rpc
> > +      attribute-set: rpc-status-attr
> > +      dump:
> > +        pre: nfsd-server-nl-rpc-status-get-start
> > +        post: nfsd-server-nl-rpc-status-get-done
>=20
> --=20
> Chuck Lever
>=20

--GF7KpKih7c60I/3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQLkoAAKCRA6cBh0uS2t
rGp2AQCdOX1MIIR2uA/VwqT4V+x/2WvhjB4rwl61k/pyxXxPOgD/RbJmrV33kIQE
5PLWrHLhhgwFwUEL6XGPYBqRxa3KOQw=
=MalY
-----END PGP SIGNATURE-----

--GF7KpKih7c60I/3r--

