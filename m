Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32C97A0286
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Sep 2023 13:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238065AbjINL0I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Sep 2023 07:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbjINL0B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Sep 2023 07:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6384AE3
        for <linux-nfs@vger.kernel.org>; Thu, 14 Sep 2023 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694690710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f2hDyfU1b40FQL9fZS1RPzUCtY8X09ykI8Ju0Dyg2s4=;
        b=RrzOrImjZNl58OV+uLkx4jENE3AteTYeVfF/7FanehJ+c6/PtMKkUp1aSciZ7rP1s8dGvE
        pyuJrrmGtalIuj6ZD0LmWwaS9beWFXAfuwn3xXNfygZXaSC9o4wjc0TKAQlYSKPd8++MPb
        pcdiERm7Ejnl43ic2cd+C4y3tDTaE9E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-S5GAtyXrOQ-1OL4fsoNasQ-1; Thu, 14 Sep 2023 07:25:09 -0400
X-MC-Unique: S5GAtyXrOQ-1OL4fsoNasQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-402d1892cecso4041055e9.1
        for <linux-nfs@vger.kernel.org>; Thu, 14 Sep 2023 04:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694690708; x=1695295508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2hDyfU1b40FQL9fZS1RPzUCtY8X09ykI8Ju0Dyg2s4=;
        b=FRv8oOZ1vUQfjiFuNDsOGvinaqy5yebKcFcELTgoKeHiYqR7AP0x21gtkub5DQyvD9
         yuJ2QC8o6GibcRRUFgex4Dlx8ZlIFsflaX7zMTSmQYps6uh5F4Lun57yY2x1wRkLtRDv
         h0aOOlf1I67BTj1GP088QpPvKfSSgGMDAcIMGFSzbthoxM+uf8/Lpiqdaa23PqjmkpDe
         5cWaN+wseLCmBNg0oNdcECXmSAELm6ToW5fSKpuGuf4He7g5KyPe/E4+hollNgyNAIS6
         sODJ9k+0GwfCyMIxcXpua7RcwF4T/R/y+4buTpjnCGsGabcj7QqiM84sxHeNlNCCxWqi
         VqMA==
X-Gm-Message-State: AOJu0YxWnCSczqNP0+8RcvHITlq7KeQ6MCJiqZinvK9L8Ip19TLAAfFX
        m5Pvx0dW+Dw3YqK/OM46Npo1s3VzCVQ9778zEzeUw5S+KKV6ryIK40ngFy2GZ3Ldq9DZccp3siA
        dYKth2jaRQ4MFNFGO7fAS
X-Received: by 2002:a1c:7914:0:b0:401:cf93:3103 with SMTP id l20-20020a1c7914000000b00401cf933103mr1318290wme.0.1694690707948;
        Thu, 14 Sep 2023 04:25:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeFx36SStVfKBMMDHBKgIzhzB5r3kokl/1wHGsMUlr+ymY6Q9E2do/WpDXYQ0ZJ6kuhRh10w==
X-Received: by 2002:a1c:7914:0:b0:401:cf93:3103 with SMTP id l20-20020a1c7914000000b00401cf933103mr1318272wme.0.1694690707641;
        Thu, 14 Sep 2023 04:25:07 -0700 (PDT)
Received: from localhost (net-2-34-76-254.cust.vodafonedsl.it. [2.34.76.254])
        by smtp.gmail.com with ESMTPSA id g13-20020a7bc4cd000000b003fc02e8ea68sm4592932wmk.13.2023.09.14.04.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 04:25:07 -0700 (PDT)
Date:   Thu, 14 Sep 2023 13:25:05 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Simon Horman <horms@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-nfs@vger.kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de,
        netdev@vger.kernel.org
Subject: Re: [PATCH v8 2/3] NFSD: introduce netlink rpc_status stubs
Message-ID: <ZQLtkfc3R/IvOLgi@lore-desk>
References: <cover.1694436263.git.lorenzo@kernel.org>
 <ce3bc230e1b8d0c741a240c17d99f5a2072e7ce1.1694436263.git.lorenzo@kernel.org>
 <20230912150751.GG401982@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tNrImtEzFl/+ZPIv"
Content-Disposition: inline
In-Reply-To: <20230912150751.GG401982@kernel.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


--tNrImtEzFl/+ZPIv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, Sep 11, 2023 at 02:49:45PM +0200, Lorenzo Bianconi wrote:
> > Generate empty netlink stubs and uAPI through nfsd_server.yaml specs:
> >=20
> > $./tools/net/ynl/ynl-gen-c.py --mode uapi \
> >  --spec Documentation/netlink/specs/nfsd_server.yaml \
> >  --header -o include/uapi/linux/nfsd_server.h
> > $./tools/net/ynl/ynl-gen-c.py --mode kernel \
> >  --spec Documentation/netlink/specs/nfsd_server.yaml \
> >  --header -o fs/nfsd/nfs_netlink_gen.h
> > $./tools/net/ynl/ynl-gen-c.py --mode kernel \
> >  --spec Documentation/netlink/specs/nfsd_server.yaml \
> >  --source -o fs/nfsd/nfs_netlink_gen.c
> >=20
> > Tested-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> ...
>=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 33f80d289d63..1be66088849c 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1495,6 +1495,22 @@ static int create_proc_exports_entry(void)
> > =20
> >  unsigned int nfsd_net_id;
> > =20
> > +int nfsd_server_nl_rpc_status_get_start(struct netlink_callback *cb)
> > +{
> > +	return 0;
> > +}
> > +
> > +int nfsd_server_nl_rpc_status_get_done(struct netlink_callback *cb)
> > +{
> > +	return 0;
> > +}
> > +
> > +int nfsd_server_nl_rpc_status_get_dumpit(struct sk_buff *skb,
> > +					 struct netlink_callback *cb)
> > +{
> > +	return 0;
> > +}
> > +
>=20
> Hi Lorenzo,

Hi Simon,

>=20
> W=3D1 build for gcc-13 and clang-16, and Smatch, complain that
> there is no prototype for the above functions.
>=20
> Perhaps nfs_netlink_gen.h should be included in this file?

actually I added it in patch 3/3. I will move it here. Thx.

Regards,
Lorenzo

>=20
> >  /**
> >   * nfsd_net_init - Prepare the nfsd_net portion of a new net namespace
> >   * @net: a freshly-created network namespace
>=20
> ...
>=20

--tNrImtEzFl/+ZPIv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZQLtkQAKCRA6cBh0uS2t
rD2bAP9KyJWMYFncdne90PW4IGot6TyXx3FF+H0CswJ8iOn+tAD/XuoGLCi6X2uz
oxQQZq2NdKdcICP1rk6TSwFnlDNglwo=
=5wyb
-----END PGP SIGNATURE-----

--tNrImtEzFl/+ZPIv--

